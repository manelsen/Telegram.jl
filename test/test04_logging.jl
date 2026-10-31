module TestLogging

using Telegram
using Test
using Base.CoreLogging: Info, Warn

"""Create a logger whose transport captures requests without network access."""
function recording_logger(; token = "synthetic_token", kwargs...)
    calls = NamedTuple[]
    sender = (client, method, params) -> begin
        push!(calls, (method = method, params = copy(params)))
        return true
    end
    client = TelegramClient(token; chat_id = "123", query_func = sender,
                            use_globally = false, enable_traceability = false)
    logger = TelegramLogger(client; async = false, kwargs...)
    return logger, client, calls
end

@testset "SURF-003: TelegramLogger" begin
    @testset "constructor preserves client and options" begin
        logger, client, calls = recording_logger(min_level = Warn)
        @test logger.tg === client
        @test logger.async === false
        @test logger.silent_errors === false
        @test Telegram.min_enabled_level(logger) == Warn
        @test isempty(calls)
    end

    @testset "client without a token is constructible, not validated up front" begin
        logger, client, calls = recording_logger(token = "")
        @test logger.tg === client
        @test isempty(client.token)
        @test isempty(calls)
    end

    @testset "synchronous messages are sent through the configured client" begin
        logger, client, calls = recording_logger()
        Telegram.handle_message(logger, Info, "ready", @__MODULE__, :tests, :logger,
                                "test04_logging.jl", 1; session = "normal")
        @test length(calls) == 1
        @test calls[1].method == "sendMessage"
        @test calls[1].params[:chat_id] == "123"
        @test occursin("ready", calls[1].params[:text])
        @test occursin("session = normal", calls[1].params[:text])
        @test Telegram.shouldlog(logger, Info, @__MODULE__, :tests, :logger)
    end
end

@testset "INV-001: Credentials in structured log fields are redacted" begin
    logger, client, calls = recording_logger(token = "SYNTHETIC_SECRET_TOKEN")
    Telegram.handle_message(logger, Info, "safe event", @__MODULE__, :tests, :logger,
                            "test04_logging.jl", 1;
                            api_key = "SYNTHETIC_API_KEY",
                            authorization = "SYNTHETIC_AUTH",
                            password = "SYNTHETIC_PASSWORD",
                            cookie = "SYNTHETIC_COOKIE",
                            session = "public")
    @test length(calls) == 1
    sent = calls[1].params[:text]
    @test occursin("safe event", sent)
    @test occursin("session = public", sent)
    @test !occursin("SYNTHETIC_SECRET_TOKEN", sent)
    for secret in ("SYNTHETIC_API_KEY", "SYNTHETIC_AUTH",
                   "SYNTHETIC_PASSWORD", "SYNTHETIC_COOKIE")
        @test !occursin(secret, sent)
    end
    @test length(collect(eachmatch(r"\[REDACTED\]", sent))) == 4
    @test !occursin("SYNTHETIC_SECRET_TOKEN", sprint(show, client))
end

@testset "INV-015: Error propagation versus silent errors" begin
    failing_sender = (client, method, params) -> error("synthetic transport failure")
    client = TelegramClient("synthetic_token"; chat_id = "123",
                            query_func = failing_sender,
                            use_globally = false, enable_traceability = false)

    loud = TelegramLogger(client; async = false, silent_errors = false)
    @test_throws ErrorException Telegram.handle_message(
        loud, Info, "test", @__MODULE__, :tests, :logger, "test04_logging.jl", 1)

    quiet = TelegramLogger(client; async = false, silent_errors = true)
    @test_nowarn Telegram.handle_message(
        quiet, Info, "test", @__MODULE__, :tests, :logger, "test04_logging.jl", 1)
end

end # module TestLogging
