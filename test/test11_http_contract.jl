module TestHTTPContract

using Test
using HTTP
using JSON3
using Telegram
using Telegram.API

const CONTRACT_TOKEN = "123456:SYNTHETIC_ONLY"

@testset "Bot API method-specific defaults" begin
    observed = Ref{Any}(nothing)
    mock = (client, method, params) -> begin
        observed[] = (method, copy(params))
        return true
    end
    client = TelegramClient(CONTRACT_TOKEN; chat_id = "456", parse_mode = "HTML",
                            query_func = mock, use_globally = false,
                            enable_traceability = false)

    @test getMe(client) === true
    @test observed[][1] == "getMe"
    @test isempty(observed[][2])

    @test getUpdates(client; offset = 10) === true
    @test observed[][2] == Dict(:offset => 10)

    @test setWebhook(client; url = "https://example.com/webhook") === true
    @test observed[][2] == Dict(:url => "https://example.com/webhook")

    @test getUserProfilePhotos(client; user_id = 99) === true
    @test observed[][2] == Dict(:user_id => 99)

    @test sendChatAction(client; action = "typing") === true
    @test observed[][2] == Dict(:chat_id => "456", :action => "typing")

    @test getChat(client) === true
    @test observed[][2] == Dict(:chat_id => "456")

    @test sendMessage(client; text = "hello") === true
    @test observed[][2] == Dict(:chat_id => "456", :parse_mode => "HTML", :text => "hello")

    @test sendPhoto(client; photo = "file_id", caption = "hello") === true
    @test observed[][2] == Dict(:chat_id => "456", :parse_mode => "HTML",
                                :photo => "file_id", :caption => "hello")

    @test sendMessage(client; chat_id = "999", parse_mode = "MarkdownV2", text = "hi") === true
    @test observed[][2] == Dict(:chat_id => "999", :parse_mode => "MarkdownV2", :text => "hi")

    @test Telegram.apiquery("getMe", client) === true
    @test observed[][2] == Dict{Symbol, Any}()

    @test Telegram.apiquery("sendMessage", client; text = "via apiquery") === true
    @test observed[][2] == Dict(:chat_id => "456", :parse_mode => "HTML",
                                :text => "via apiquery")

    @test Telegram.apiquery("futureMethod", client; foo = 7) === true
    @test observed[][2] == Dict(:foo => 7)

    empty_defaults = TelegramClient(CONTRACT_TOKEN; chat_id = "", parse_mode = "",
        query_func = mock, use_globally = false, enable_traceability = false)
    @test sendMessage(empty_defaults; text = "bare") === true
    @test observed[][2] == Dict(:text => "bare")
end

@testset "Bot API HTTP wire payload contains no internal metadata" begin
    payloads = JSON3.Object[]
    targets = String[]
    server = HTTP.serve!("127.0.0.1", 0; verbose = false, listenany = true) do request
        push!(targets, String(request.target))
        push!(payloads, JSON3.read(String(request.body)))
        return HTTP.Response(200, ["Content-Type" => "application/json"],
                             "{\"ok\":true,\"result\":true}")
    end
    try
        client = TelegramClient(CONTRACT_TOKEN; chat_id = "456", parse_mode = "HTML",
            ep = "http://127.0.0.1:$(HTTP.port(server))/bot",
            allow_insecure_http = true, enable_traceability = true, use_globally = false)
        original_id = client.request_id
        @test getMe(client) === true
        first_id = client.request_id
        @test first_id != original_id
        @test isempty(payloads[1])
        @test endswith(targets[1], "/getMe")

        @test sendMessage(client; text = "hello") === true
        @test client.request_id != first_id
        @test payloads[2][:chat_id] == "456"
        @test payloads[2][:parse_mode] == "HTML"
        @test payloads[2][:text] == "hello"
        @test length(keys(payloads[2])) == 3
        @test endswith(targets[2], "/sendMessage")

        @test getUpdates(client; timeout = 0) === true
        @test payloads[3][:timeout] == 0
        @test length(keys(payloads[3])) == 1

        @test Telegram.apiquery("getMe", client) === true
        @test isempty(payloads[4])

        for body in payloads
            @test !haskey(body, :_request_id)
            @test !haskey(body, :_timestamp)
            @test !haskey(body, :_schema_version)
        end
    finally
        Base.close(server)
    end
end


@testset "Concurrent requests retain distinct local trace IDs" begin
    payloads = Channel{Any}(8)
    server = HTTP.serve!("127.0.0.1", 0; verbose = false, listenany = true) do request
        put!(payloads, JSON3.read(String(request.body)))
        return HTTP.Response(200, ["Content-Type" => "application/json"],
                             "{\"ok\":true,\"result\":true}")
    end

    try
        client = TelegramClient(CONTRACT_TOKEN;
            ep = "http://127.0.0.1:$(HTTP.port(server))/bot",
            allow_insecure_http = true, enable_traceability = true, use_globally = false)

        captured_logs = Test.TestLogger(min_level = Base.CoreLogging.Debug)
        results = fill(false, 8)
        Base.CoreLogging.with_logger(captured_logs) do
            @sync for i in 1:8
                @async results[i] = getMe(client) === true
            end
        end

        @test all(results)
        bodies = [take!(payloads) for _ in 1:8]
        @test all(isempty, bodies)

        request_logs = filter(log -> log.message == "Telegram API Request",
                              captured_logs.logs)
        @test length(request_logs) == 8
        ids = [log.kwargs[:request_id] for log in request_logs]
        @test length(unique(ids)) == 8
        @test all(!isempty(id) for id in ids)
        @test all(log.kwargs[:schema_version] == Telegram.DecisionSupport.get_schema_version()
                  for log in request_logs)
        @test all(endswith(log.kwargs[:timestamp], "Z") for log in request_logs)
    finally
        Base.close(server)
    end
end

end # module TestHTTPContract
