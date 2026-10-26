module TestSecurity

using Test
using HTTP
using JSON3
using Telegram
using Telegram.DecisionSupport: validate_https_enforced
using Base.CoreLogging: Info

# The anonymizer does not rewrite fixture files when imported for tests.
include(joinpath(@__DIR__, "..", "extras", "anonymize_fixtures.jl"))

const SYNTHETIC_TOKEN = "123456:TEST_TOKEN_ONLY"

function local_client(endpoint; kwargs...)
    TelegramClient(SYNTHETIC_TOKEN; ep = endpoint, use_globally = false,
                   enable_traceability = false, kwargs...)
end

@testset "SEC-001: credential and endpoint safety" begin
    client = local_client("https://api.telegram.org/bot")
    @test !occursin(SYNTHETIC_TOKEN, sprint(show, client))
    @test !occursin(SYNTHETIC_TOKEN, sprint(show, MIME("text/plain"), client))
    positional = TelegramClient(SYNTHETIC_TOKEN, "123", "", "https://api.telegram.org/bot",
                                nothing, "", false)
    @test !positional.allow_insecure_http

    @test validate_https_enforced("https://api.telegram.org/bot")
    @test !validate_https_enforced("https://")
    @test !validate_https_enforced("http://api.telegram.org/bot")

    for endpoint in ("http://api.telegram.org/bot",
                     "not-a-url", "https://user:pass@example.com/bot",
                     "https://api.telegram.org/bot?redirect=1",
                     "https://api.telegram.org/bot#fragment")
        @test_throws Telegram.TelegramError Telegram.query(local_client(endpoint), "getMe")
    end

    @test_throws Telegram.TelegramError Telegram.query(local_client("https://api.telegram.org/bot"), "../getMe")
    @test_throws Telegram.TelegramError Telegram.query(local_client("https://api.telegram.org/bot"), "getMe?token=bad")
    @test_throws Telegram.TelegramError Telegram.query(
        TelegramClient("token/with/slashes"; use_globally = false, enable_traceability = false), "getMe")
    @test_throws Telegram.TelegramError Telegram.query(
        TelegramClient(""; use_globally = false, enable_traceability = false), "getMe")

    @test_throws Telegram.TelegramError Telegram.pushfiles!(Pair[], :document,
        "bad\r\nInjected-Header: value" => IOBuffer("synthetic"))
    @test_throws Telegram.TelegramError Telegram.pushfiles!(Pair[], Symbol("bad\nname"),
        IOBuffer("synthetic"))
end

@testset "SEC-002: synthetic loopback transport" begin
    visited_redirect_target = Ref(false)
    observed_request = Ref{Any}(nothing)
    observed_multipart = Ref{Any}(nothing)
    server = HTTP.serve!("127.0.0.1", 0; verbose = false, listenany = true) do request
        target = String(request.target)
        if endswith(target, "/redirect")
            return HTTP.Response(302, ["Location" => "/unexpected"], "")
        elseif endswith(target, "/unexpected")
            visited_redirect_target[] = true
            return HTTP.Response(200, "{}")
        elseif endswith(target, "/fail")
            return HTTP.Response(401, ["Content-Type" => "application/json"],
                                 "{\"ok\":false,\"error_code\":401,\"description\":\"Unauthorized\"}")
        elseif endswith(target, "/malformed")
            return HTTP.Response(200, "not-json")
        elseif endswith(target, "/wrongshape")
            return HTTP.Response(200, "{\"ok\":\"yes\"}")
        elseif endswith(target, "/upload")
            parts = HTTP.parse_multipart_form(request)
            observed_multipart[] = [(part.name, part.filename, read(part.data, String)) for part in parts]
            return HTTP.Response(200, ["Content-Type" => "application/json"],
                                 "{\"ok\":true,\"result\":true}")
        else
            observed_request[] = JSON3.read(String(request.body))
            return HTTP.Response(200, ["Content-Type" => "application/json"],
                                 "{\"ok\":true,\"result\":{\"id\":1}}")
        end
    end

    endpoint = "http://127.0.0.1:$(HTTP.port(server))/bot"
    try
        client = local_client(endpoint; allow_insecure_http = true)
        @test_throws Telegram.TelegramError Telegram.query(client, "redirect")
        @test !visited_redirect_target[]
        @test_throws Telegram.TelegramError Telegram.query(client, "fail")
        @test_throws Telegram.TelegramError Telegram.query(client, "malformed")
        @test_throws Telegram.TelegramError Telegram.query(client, "wrongshape")

        traced = TelegramClient(SYNTHETIC_TOKEN; ep = endpoint, use_globally = false,
                                allow_insecure_http = true)
        @test Telegram.query(traced, "getMe"; params = Dict{Symbol, Any}(:chat_id => 1)).id == 1
        @test haskey(observed_request[], :_request_id)
        @test haskey(observed_request[], :_timestamp)
        @test haskey(observed_request[], :_schema_version)

        @test Telegram.query(client, "upload";
            params = Dict{Symbol, Any}(:chat_id => 1,
                :document => ("report.bin" => IOBuffer("synthetic payload")))) === true
        @test any(part -> part[1] == "document" && part[2] == "report.bin" &&
                   part[3] == "synthetic payload", observed_multipart[])
    finally
        close(server)
    end

    # The server is gone. A transport exception must not disclose the URL/token.
    error = try
        Telegram.query(local_client(endpoint; allow_insecure_http = true), "getMe")
        nothing
    catch err
        err
    end
    @test error isa Telegram.TelegramError
    @test !occursin(SYNTHETIC_TOKEN, sprint(showerror, error))
end

@testset "SEC-003: logging redaction" begin
    sent = Ref{Any}(nothing)
    sender = (client, method, params) -> (sent[] = params; true)
    client = TelegramClient(SYNTHETIC_TOKEN; chat_id = "123", query_func = sender,
                            use_globally = false)
    logger = TelegramLogger(client; async = false)
    Telegram.handle_message(logger, Info, "safe message", Main, :test, :test,
                            "test.jl", 1; api_key = "SYNTHETIC_SECRET", session = "normal")
    @test sent[] !== nothing
    @test !occursin("SYNTHETIC_SECRET", sent[][:text])
    @test occursin("[REDACTED]", sent[][:text])
    @test occursin("session = normal", sent[][:text])
end

@testset "SEC-004: fixture privacy" begin
    captured = JSON3.read("""
        {"id":123,"message":{"text":"private content","email":"private@example.com",
         "chat_instance":"raw-id","user_id":456},"callback_data":"choice_a"}
        """)
    anonymous = anonymize_recursive!(captured)
    @test anonymous[:id] == 12345678
    @test anonymous[:message][:text] == "Anonymized message content"
    @test anonymous[:message][:email] == "anonymous@example.com"
    @test anonymous[:message][:chat_instance] == "ANONYMIZED_IDENTIFIER"
    @test anonymous[:message][:user_id] == 12345678

    # Also handle dictionary inputs with String keys, not just JSON3 Symbol keys.
    @test anonymize_recursive!(Dict("text" => "private"))[:text] == "Anonymized message content"
end

@testset "SEC-005: polling backs off on failures" begin
    calls = Ref(0)
    failing_query = (client, method, params) -> begin
        calls[] += 1
        calls[] == 3 && throw(InterruptException())
        error("synthetic offline failure")
    end
    client = TelegramClient(SYNTHETIC_TOKEN; query_func = failing_query,
                            use_globally = false)
    started = time()
    run_bot(_ -> nothing, client; timeout = 0)
    @test calls[] == 3
    @test time() - started >= 2.8  # waits 1s + 2s after failures

    updates = (client, method, params) -> [Dict(:update_id => 1)]
    client_with_update = TelegramClient(SYNTHETIC_TOKEN; query_func = updates,
                                        use_globally = false)
    @test_nowarn run_bot(_ -> throw(InterruptException()), client_with_update; timeout = 0)
end

end # module
