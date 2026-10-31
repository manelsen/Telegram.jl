module TestFaultInjection

using Test
using HTTP
using JSON3
using Telegram
using Telegram.API

const FAULT_TEST_TOKEN = "123456:SYNTHETIC_TEST_ONLY"

"""Return the caught exception, or nothing if the operation unexpectedly succeeds."""
function caught_exception(f::Function)
    try
        f()
        return nothing
    catch err
        return err
    end
end

"""Construct an isolated Telegram client pointed exclusively at a local test server."""
function fault_client(base_url::String, scenario::String; kwargs...)
    return TelegramClient(FAULT_TEST_TOKEN;
                          ep = "$base_url/$scenario/bot",
                          use_globally = false,
                          enable_traceability = false,
                          allow_insecure_http = true,
                          kwargs...)
end

"""Build a synthetic Telegram JSON response with an explicit HTTP status."""
json_reply(status::Integer, body::AbstractString) =
    HTTP.Response(status, ["Content-Type" => "application/json"], body)

@testset "Fault injection: real HTTP transport, synthetic responses" begin
    malformed_request = Ref{Any}(nothing)
    invalid_mode_request = Ref{Any}(nothing)
    uploaded_parts = Ref{Any}(nothing)

    server = HTTP.serve!("127.0.0.1", 0; verbose = false, listenany = true) do request
        path = String(request.target)

        if occursin("/http500/", path)
            return json_reply(500,
                "{\"ok\":false,\"error_code\":500,\"description\":\"Internal Server Error\"}")
        elseif occursin("/http401/", path)
            return json_reply(401,
                "{\"ok\":false,\"error_code\":401,\"description\":\"Unauthorized\"}")
        elseif occursin("/http429/", path)
            return HTTP.Response(429,
                ["Content-Type" => "application/json", "Retry-After" => "17"],
                "{\"ok\":false,\"error_code\":429,\"description\":\"Too Many Requests\"," *
                "\"parameters\":{\"retry_after\":17}}")
        elseif occursin("/http400/", path)
            malformed_request[] = JSON3.read(String(request.body))
            return json_reply(400,
                "{\"ok\":false,\"error_code\":400,\"description\":\"Bad Request\"}")
        elseif occursin("/invalid-mode/", path)
            invalid_mode_request[] = JSON3.read(String(request.body))
            return json_reply(400,
                "{\"ok\":false,\"error_code\":400,\"description\":\"Bad Request: parse mode\"}")
        elseif occursin("/malformed-json/", path)
            return json_reply(200, "{not valid JSON")
        elseif occursin("/empty-json/", path)
            return json_reply(200, "")
        elseif occursin("/array-json/", path)
            return json_reply(200, "[]")
        elseif occursin("/nonboolean-ok/", path)
            return json_reply(200, "{\"ok\":\"true\",\"result\":{}}")
        elseif occursin("/missing-ok/", path)
            return json_reply(200, "{\"result\":{}}")
        elseif occursin("/partial-result/", path)
            return json_reply(200, "{\"ok\":true,\"result\":{\"is_bot\":\"invalid\"}}")
        elseif occursin("/slow-response/", path)
            sleep(3.0)
            return json_reply(200, "{\"ok\":true,\"result\":true}")
        elseif occursin("/multipart/", path)
            parts = HTTP.parse_multipart_form(request)
            uploaded_parts[] = [(part.name, part.filename, read(part.data, String)) for part in parts]
            return json_reply(200, "{\"ok\":true,\"result\":true}")
        end

        return json_reply(404,
            "{\"ok\":false,\"error_code\":404,\"description\":\"Unknown test scenario\"}")
    end

    base_url = "http://127.0.0.1:$(HTTP.port(server))"

    try
        @testset "FALHA-001: API unavailable" begin
            err = caught_exception(() -> getMe(fault_client(base_url, "http500")))
            @test err isa Telegram.TelegramError
            @test err.msg.error_code == 500
            @test err.msg.ok === false
        end

        @testset "FALHA-002: Authentication failure" begin
            err = caught_exception(() -> getMe(fault_client(base_url, "http401")))
            @test err isa Telegram.TelegramError
            @test err.msg.error_code == 401

            # A genuinely empty token must fail before any HTTP request.
            withenv("TELEGRAM_BOT_TOKEN" => nothing) do
                empty_client = TelegramClient(""; ep = "$base_url/http401/bot",
                                              use_globally = false,
                                              enable_traceability = false,
                                              allow_insecure_http = true)
                err = caught_exception(() -> getMe(empty_client))
                @test err isa Telegram.TelegramError
                @test occursin("token", lowercase(err.msg))
            end
        end

        @testset "FALHA-003: Rate limiting" begin
            err = caught_exception(() ->
                sendMessage(fault_client(base_url, "http429"; chat_id = "123");
                            text = "synthetic"))
            @test err isa Telegram.TelegramError
            @test err.msg.error_code == 429
            # The current SDK preserves Telegram's structured error response;
            # it does not expose a dedicated err.retry_after property.
            @test err.msg.parameters.retry_after == 17
        end

        @testset "FALHA-004: Invalid request parameters" begin
            err = caught_exception(() ->
                sendMessage(fault_client(base_url, "http400"; chat_id = "invalid");
                            text = ""))
            @test err isa Telegram.TelegramError
            @test err.msg.error_code == 400
            @test malformed_request[].text == ""
            @test malformed_request[].chat_id == "invalid"

            err = caught_exception(() ->
                sendMessage(fault_client(base_url, "http400"; chat_id = "123")))
            @test err isa Telegram.TelegramError
            @test err.msg.error_code == 400
            # Required Telegram fields are checked by Telegram, not by this SDK.
            @test !haskey(malformed_request[], :text)
        end

        @testset "FALHA-005 / INV-003: Read-idle timeout" begin
            original_timeout = Telegram.DEFAULT_OPTS.timeout
            @test original_timeout > 0
            try
                # Telegram.query passes read_idle_timeout = DEFAULT_OPTS.timeout + 1
                # to HTTP.post. The loopback server deliberately replies later.
                Telegram.DEFAULT_OPTS.timeout = 0
                err = caught_exception(() ->
                    getMe(fault_client(base_url, "slow-response")))
                @test err isa Telegram.TelegramError
                @test occursin("transport failed", lowercase(err.msg))
                @test !occursin(FAULT_TEST_TOKEN, sprint(showerror, err))
            finally
                Telegram.DEFAULT_OPTS.timeout = original_timeout
            end
            @test Telegram.DEFAULT_OPTS.timeout == original_timeout
        end

        @testset "FALHA-006: Malformed and empty JSON" begin
            for scenario in ("malformed-json", "empty-json")
                err = caught_exception(() -> getMe(fault_client(base_url, scenario)))
                @test err isa Telegram.TelegramError
                @test occursin("invalid JSON response", err.msg)
            end
        end

        @testset "FALHA-007: Response shape validation" begin
            for scenario in ("array-json", "nonboolean-ok", "missing-ok")
                err = caught_exception(() -> getMe(fault_client(base_url, scenario)))
                @test err isa Telegram.TelegramError
            end

            # The SDK validates the transport envelope, but deliberately does not
            # perform schema validation on individual Telegram result objects.
            result = getMe(fault_client(base_url, "partial-result"))
            @test result.is_bot == "invalid"
            @test !haskey(result, :id)
        end

        @testset "FALHA-008: Client configuration" begin
            bad_endpoint = TelegramClient(FAULT_TEST_TOKEN;
                                          ep = "not-a-url",
                                          use_globally = false,
                                          enable_traceability = false)
            err = caught_exception(() -> getMe(bad_endpoint))
            @test err isa Telegram.TelegramError
            @test occursin("endpoint", lowercase(err.msg))

            err = caught_exception(() ->
                sendMessage(fault_client(base_url, "invalid-mode"; chat_id = "123",
                                         parse_mode = "not-a-mode");
                            text = "synthetic"))
            @test err isa Telegram.TelegramError
            @test err.msg.error_code == 400
            # The API rejects unsupported parse modes; the SDK forwards kwargs.
            @test invalid_mode_request[].parse_mode == "not-a-mode"
        end

        @testset "INV-005: File uploads use multipart encoding" begin
            client = fault_client(base_url, "multipart"; chat_id = "123")
            result = sendPhoto(client; photo = ("image.jpg" => IOBuffer("synthetic image")))
            @test result === true
            @test uploaded_parts[] !== nothing
            @test any(part -> part[1] == "photo" &&
                               part[2] == "image.jpg" &&
                               part[3] == "synthetic image", uploaded_parts[])
        end
    finally
        close(server)
    end

    @testset "FALHA-001: Closed server produces sanitized transport error" begin
        err = caught_exception(() -> getMe(fault_client(base_url, "http500")))
        @test err isa Telegram.TelegramError
        @test occursin("transport failed", lowercase(err.msg))
        @test !occursin(FAULT_TEST_TOKEN, sprint(showerror, err))
    end
end

end # module TestFaultInjection
