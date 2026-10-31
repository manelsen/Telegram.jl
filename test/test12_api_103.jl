module TestAPI103

using Telegram
using Test
using JSON3
using HTTP

const SPEC_PATH = joinpath(@__DIR__, "..", "extras", "bot_api_10_3.min.json")
const SCHEMA = JSON3.read(read(SPEC_PATH, String))

# Ensure that the checked-in API source and both references can be regenerated
# entirely offline from the pinned specification.
include(joinpath(@__DIR__, "..", "extras", "generate_api_from_spec.jl"))


@testset "Bot API 10.3 reproducible parity" begin
    @test SCHEMA.version == "Bot API 10.3"
    @test SCHEMA.release_date == "August 24, 2026"
    @test length(SCHEMA.methods) == 185
    @test length(SCHEMA.types) == 400

    # Git on Windows may check out text with CRLF; compare semantic LF content.
    normalize_lf(text) = replace(text, "\r\n" => "\n")
    @test normalize_lf(read(joinpath(@__DIR__, "..", "src", "telegram_api.jl"), String)) ==
          APIReferenceGenerator.render_api(SCHEMA)
    @test normalize_lf(read(joinpath(@__DIR__, "..", "docs", "src", "reference.md"), String)) ==
          APIReferenceGenerator.render_reference(SCHEMA)
    @test normalize_lf(read(joinpath(@__DIR__, "..", "docs", "src", "types.md"), String)) ==
          APIReferenceGenerator.render_types(SCHEMA)


    generated = Dict(String(name) => String(doc) for (name, doc) in Telegram.API.TELEGRAM_API)
    @test length(generated) == 185
    @test Set(keys(generated)) == Set(String.(keys(SCHEMA.methods)))

    chat_methods = Set{String}()
    parse_methods = Set{String}()
    total_fields = 0
    for (method, definition) in pairs(SCHEMA.methods)
        name = String(method)
        @test isdefined(Telegram.API, Symbol(name))
        haskey(generated, name) || continue
        doc = generated[name]
        @test occursin(definition.href, doc)
        for field in get(definition, :fields, ())
            field_name = String(field.name)
            @test occursin(string("- ", Char(96), field_name, Char(96), ":"), doc)
            total_fields += 1
            if field_name == "chat_id"
                push!(chat_methods, name)
            elseif field_name == "parse_mode"
                push!(parse_methods, name)
            end
        end
    end
    @test total_fields == 932
    @test Telegram.API.DEFAULT_CHAT_ID_METHODS == chat_methods
    @test Telegram.API.DEFAULT_PARSE_MODE_METHODS == parse_methods

    @testset "new 10.3 methods dispatch through the shared client" begin
        expected = (
            :sendRichMessage, :sendRichMessageDraft,
            :editEphemeralMessageText, :editEphemeralMessageMedia,
            :editEphemeralMessageCaption, :editEphemeralMessageReplyMarkup,
            :deleteEphemeralMessage, :getManagedBotToken,
            :replaceManagedBotToken, :getManagedBotAccessSettings,
            :setManagedBotAccessSettings, :deleteAllMessageReactions,
            :deleteMessageReaction, :answerChatJoinRequestQuery,
            :sendChatJoinRequestWebApp, :answerGuestQuery,
            :savePreparedKeyboardButton, :sendLivePhoto,
            :setChatMemberTag, :getUserPersonalChatMessages,
        )
        @test length(expected) == 20
        observed = Ref{Any}(nothing)
        transport = (client, method, params) -> begin
            observed[] = (String(method), copy(params))
            return true
        end
        client = Telegram.TelegramClient("synthetic";
            chat_id = "123", parse_mode = "HTML", query_func = transport,
            use_globally = false, enable_traceability = false)
        for method in expected
            @test isdefined(Telegram.API, method)
            isdefined(Telegram.API, method) || continue
            result = getproperty(Telegram.API, method)(client; sample = 1)
            @test result === true
            @test observed[][1] == String(method)
            @test observed[][2][:sample] == 1
            @test haskey(observed[][2], :chat_id) == (String(method) in chat_methods)
            @test haskey(observed[][2], :parse_mode) == (String(method) in parse_methods)
        end
    end

    @testset "new 10.3 parameters on existing methods" begin
        @test occursin(string("- ", Char(96), "ephemeral_message_parameters", Char(96), ":"), generated["sendMessage"])
        @test occursin(string("- ", Char(96), "can_manage_tags", Char(96), ":"), generated["promoteChatMember"])
        @test occursin(string("- ", Char(96), "rich_message", Char(96), ":"), generated["editMessageText"])
        @test occursin(string("- ", Char(96), "can_stop", Char(96), ":"), generated["sendMessageDraft"])
    end

    @testset "all Bot API object types documented as dynamic JSON schemas" begin
        model_doc_path = joinpath(@__DIR__, "..", "docs", "src", "types.md")
        @test isfile(model_doc_path)
        if isfile(model_doc_path)
            content = read(model_doc_path, String)
            for model in keys(SCHEMA.types)
                @test occursin(string("## ", Char(96), String(model), Char(96)), content)
            end
            @test occursin(string("## ", Char(96), "EphemeralMessageParameters", Char(96)), content)
            @test occursin(string("## ", Char(96), "RichMessageButton", Char(96)), content)
        end
    end
end


@testset "Schema-defined top-level InputFile fields use multipart uploads" begin
    file_fields = Set{Symbol}()
    for method in values(SCHEMA.methods)
        for field in get(method, :fields, ())
            if any(occursin("InputFile", String(t)) for t in field.types)
                push!(file_fields, Symbol(field.name))
            end
        end
    end
    @test :live_photo in file_fields
    @test :thumbnail in file_fields
    @test :cover in file_fields
    @test all(name in Telegram.DEFAULT_OPTS.upload_kw for name in file_fields)

    if all(name in Telegram.DEFAULT_OPTS.upload_kw for name in file_fields)
        received = Ref{Any}(nothing)
        server = HTTP.serve!("127.0.0.1", 0; listenany = true, verbose = false) do req
            parts = HTTP.parse_multipart_form(req)
            received[] = [(part.name, part.filename, read(part.data, String)) for part in parts]
            return HTTP.Response(200, ["Content-Type" => "application/json"],
                                 "{\"ok\":true,\"result\":true}")
        end
        try
            client = Telegram.TelegramClient("123456:SYNTHETIC";
                ep = "http://127.0.0.1:$(HTTP.port(server))/bot",
                allow_insecure_http = true, use_globally = false,
                enable_traceability = false)
            @test Telegram.API.sendLivePhoto(client; chat_id = 456,
                live_photo = "clip.mov" => IOBuffer("synthetic-live-photo")) === true
            @test any(p -> p[1] == "live_photo" && p[2] == "clip.mov" &&
                           p[3] == "synthetic-live-photo", received[])

            @test Telegram.API.sendVideo(client; chat_id = 456,
                video = "file_id", cover = "cover.jpg" => IOBuffer("synthetic-cover"),
                thumbnail = "thumb.jpg" => IOBuffer("synthetic-thumb")) === true
            @test any(p -> p[1] == "cover" && p[2] == "cover.jpg" &&
                           p[3] == "synthetic-cover", received[])
            @test any(p -> p[1] == "thumbnail" && p[2] == "thumb.jpg" &&
                           p[3] == "synthetic-thumb", received[])
        finally
            Base.close(server)
        end
    end
end

@testset "Structured objects sharing upload field names remain JSON" begin
    received = Ref{Any}(nothing)
    server = HTTP.serve!("127.0.0.1", 0; listenany = true, verbose = false) do req
        received[] = Dict(part.name => read(part.data, String)
                          for part in HTTP.parse_multipart_form(req))
        HTTP.Response(200, ["Content-Type" => "application/json"],
                      "{\"ok\":true,\"result\":true}")
    end
    try
        client = Telegram.TelegramClient("SYNTHETIC";
            ep = "http://127.0.0.1:$(HTTP.port(server))/bot",
            allow_insecure_http = true, use_globally = false,
            enable_traceability = false)
        photo = Dict("type" => "static", "photo" => "attach://document")
        sticker = Dict("sticker" => "attach://document", "format" => "static",
                       "emoji_list" => ["✅"])
        for (method, field, value, kwargs) in (
            (:setMyProfilePhoto, :photo, photo, (;)),
            (:setBusinessAccountProfilePhoto, :photo, photo,
             (; business_connection_id = "synthetic")),
            (:addStickerToSet, :sticker, sticker,
             (; user_id = 123, name = "synthetic")),
            (:replaceStickerInSet, :sticker, sticker,
             (; user_id = 123, name = "synthetic", old_sticker = "synthetic")),
        )
            for payload in (value, JSON3.read(JSON3.write(value)),
                            (; (Symbol(k) => v for (k, v) in value)...))
                @test getproperty(Telegram.API, method)(client;
                    kwargs..., field => payload,
                    document = "test.bin" => IOBuffer("synthetic-bytes")) === true
                @test JSON3.read(received[][String(field)]) == JSON3.read(JSON3.write(value))
                @test received[]["document"] == "synthetic-bytes"
            end
        end
    finally
        close(server)
    end
end

end # module TestAPI103
