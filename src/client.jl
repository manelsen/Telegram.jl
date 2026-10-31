struct TelegramError{T} <: Exception
    msg::T
end

mutable struct TelegramClient
    token::String
    chat_id::String
    parse_mode::String
    ep::String
    query_func::Union{Function, Nothing}
    request_id::String
    enable_traceability::Bool
    allow_insecure_http::Bool
end

# Preserve the original seven-argument positional constructor.
TelegramClient(token::String, chat_id::String, parse_mode::String, ep::String,
               query_func::Union{Function, Nothing}, request_id::String,
               enable_traceability::Bool) =
    TelegramClient(token, chat_id, parse_mode, ep, query_func, request_id,
                   enable_traceability, false)

# A bot token is a credential: displaying a client must never print it.
function Base.show(io::IO, ::TelegramClient)
    print(io, "TelegramClient(token=[REDACTED])")
end

"""
    TelegramClient(token; chat_id, parse_mode, ep, use_globally = true, query_func = nothing,
                   enable_traceability = true, allow_insecure_http = false)

Creates telegram client, which can be used to run telegram commands.

# Arguments
- `token::String`: telegram token, which can be obtained in telegram from @BotFather.
- `chat_id`: if set, used as default `chat_id` argument for all chat related commands. To get specific `chat_id`, send message to the bot in telegram application and use [`getUpdates`](@ref) command.
- `parse_mode`: if set, used as default for text messaging commands.
- `use_globally::Bool`: default `true`. If set to `true` then it current client can be used as default in all telegram commands.
- `ep`: endpoint for telegram api. By default `https://api.telegram.org/bot` is used, but you may change it, if you are using proxy or for testing purposes.
- `query_func`: optional custom function for making HTTP queries. Useful for testing and mocking. Function signature: `(client, method, params) -> result`.
- `enable_traceability::Bool`: default `true`. If set to `true`, enables Decision Support traceability features (DS-001, DS-002, DS-003, DS-004, DS-005).
- `allow_insecure_http::Bool`: default `false`. Explicit opt-in for plain HTTP endpoints,
  such as a locally hosted Bot API server. Plain HTTP exposes the bot token in transit.
"""
function TelegramClient(token = get(ENV, "TELEGRAM_BOT_TOKEN", "");
                     chat_id = get(ENV, "TELEGRAM_BOT_CHAT_ID" ,""),
                     parse_mode = "",
                     ep = "https://api.telegram.org/bot",
                     use_globally = true,
                     query_func = nothing,
                     enable_traceability = true,
                     allow_insecure_http = false)
    request_id = enable_traceability ? DecisionSupport.generate_request_id() : ""
    client = TelegramClient(token, chat_id, parse_mode, ep, query_func, request_id,
                            enable_traceability, allow_insecure_http)
    if use_globally
        useglobally!(client)
    end

    return client
end

mutable struct TelegramOpts
    client::TelegramClient
    upload_kw::Vector{Symbol}
    timeout::Int
end

const DEFAULT_OPTS = TelegramOpts(TelegramClient(use_globally = false), [:photo, :audio, :thumb, :thumbnail, :cover, :live_photo, :document, :video, :animation, :voice, :video_note, :sticker, :png_sticker, :tgs_sticker, :certificate, :files], 30)

"""
    useglobally!(tg::TelegramClient)

Set `tg` as default client in all `Telegram.API` functions. 

# Example
```julia
tg = TelegramClient(ENV["TG_TOKEN"])
useglobally!(tg)

getMe() # new client is used in this command by default.
```
"""
function useglobally!(client::TelegramClient)
    DEFAULT_OPTS.client = client

    return client
end

function token(client::TelegramClient)
    isempty(client.token) || return client.token
    token = get(ENV, "TELEGRAM_BOT_TOKEN", "")
    isempty(token) && @warn "Telegram token is empty"
    return token
end

function chatid(client::TelegramClient)
    isempty(client.chat_id) || return client.chat_id
    chat_id = get(ENV, "TELEGRAM_BOT_CHAT_ID", "")
    return chat_id
end

ioify(elem::IO) = elem
ioify(elem) = IOBuffer(elem)
function ioify(elem::IOBuffer)
    seekstart(elem)
    return elem
end

function validate_multipart_field_name(name)
    if occursin(r"[\r\n]", string(name))
        throw(TelegramError("Multipart field names and filenames must not contain line breaks"))
    end
end

pushfiles!(body, keyword, file) = (validate_multipart_field_name(keyword); push!(body, keyword => file))
# Some upload field names also accept structured objects (InputProfilePhoto or
# InputSticker). HTTP.Form stringifies dictionaries unless we encode them first.
function pushfiles!(body, keyword, value::Union{AbstractDict, NamedTuple})
    validate_multipart_field_name(keyword)
    push!(body, keyword => JSON3.write(value))
end
function pushfiles!(body, keyword, file::Pair)
    validate_multipart_field_name(keyword)
    validate_multipart_field_name(file.first)
    push!(body, keyword => HTTP.Multipart(file.first, ioify(file.second)))
end

process_params(x::AbstractString) = x
process_params(x) = JSON3.write(x)   

"""Validate the destination before sending a credential-bearing request."""
function validate_endpoint(client::TelegramClient)
    uri = try
        HTTP.URI(client.ep)
    catch
        nothing
    end
    uri === nothing && throw(TelegramError("Invalid Telegram API endpoint URL"))

    scheme = lowercase(uri.scheme)
    if occursin(r"[\r\n]", client.ep) || isempty(uri.host) || !isempty(uri.userinfo) ||
       !isempty(uri.query) || !isempty(uri.fragment) ||
       !(scheme == "https" || (scheme == "http" && client.allow_insecure_http))
        throw(TelegramError("Telegram API endpoint must be an HTTPS URL without credentials, query, or fragment (set allow_insecure_http=true only for a trusted HTTP server)"))
    end

    return nothing
end

function query(client::TelegramClient, method; params = Dict())
    # Use custom query function if provided (useful for testing/mocking)
    if client.query_func !== nothing
        return client.query_func(client, method, params)
    end

    validate_endpoint(client)
    bot_token = token(client)
    if isempty(bot_token) || !occursin(r"^[A-Za-z0-9:_-]+$", bot_token)
        throw(TelegramError("Bot token is empty or contains invalid URL characters"))
    end
    method_name = string(method)
    if !occursin(r"^[A-Za-z][A-Za-z0-9_]*$", method_name)
        throw(TelegramError("Invalid Telegram API method name"))
    end

    # Traceability is local to the client and its logs. These metadata keys are
    # not Bot API parameters and must not be sent to Telegram.
    if client.enable_traceability
        request_id = DecisionSupport.generate_request_id()
        client.request_id = request_id  # Last started request; not a per-task context.
        timestamp = DecisionSupport.datetime_to_iso8601(DecisionSupport.generate_timestamp_utc())
        @debug "Telegram API Request" method=method request_id=request_id timestamp=timestamp schema_version=DecisionSupport.get_schema_version()
    end

    req_uri = client.ep * bot_token * "/" * method_name
    intersection = intersect(keys(params), DEFAULT_OPTS.upload_kw)
    headers, request_body = if isempty(intersection)
        (["Content-Type" => "application/json", "Connection" => "Keep-Alive"],
         JSON3.write(params))
    else
        body = Pair[]
        for (k, v) in params
            k in intersection && continue
            validate_multipart_field_name(k)
            push!(body, k => process_params(v))
        end
        for k in intersection
            pushfiles!(body, k, params[k])
        end
        (["Connection" => "Keep-Alive"], HTTP.Form(body))
    end

    res, transport_error = try
        (HTTP.post(req_uri, headers, request_body;
                   read_idle_timeout = DEFAULT_OPTS.timeout + 1,
                   redirect = false, status_exception = false), nothing)
    catch err
        err isa InterruptException && rethrow()
        # HTTP transport exceptions can contain the full request URL and bot token.
        # Leave the catch block before throwing, to avoid logging the original cause.
        (nothing, string(typeof(err)))
    end
    transport_error === nothing || throw(TelegramError("Telegram API transport failed ($transport_error); request URL withheld"))

    if 300 <= res.status < 400
        throw(TelegramError("Telegram API returned HTTP $(res.status); redirects are disabled to protect the bot token"))
    end

    response = try
        JSON3.read(res.body)
    catch
        nothing
    end
    response === nothing && throw(TelegramError("Telegram API returned an invalid JSON response (HTTP $(res.status))"))

    if !(response isa JSON3.Object)
        throw(TelegramError("Telegram API returned an invalid JSON response shape (HTTP $(res.status))"))
    end

    ok = get(response, :ok, nothing)
    if !(ok isa Bool)
        throw(TelegramError("Telegram API returned JSON without a boolean 'ok' field (HTTP $(res.status))"))
    end

    if !(200 <= res.status < 300) && ok
        throw(TelegramError("Telegram API returned unexpected HTTP $(res.status)"))
    end

    if ok
        return response.result
    else
        throw(TelegramError(response))
    end
end

"""
    apiquery(method, client; kwargs...)

Sends `method` request to the telegram. It is recommended to use only if some of Telegram API function is not wrapped already.

# Arguments
- `method::String`: method name from the Telegram API, for example "getMe"
- `client::TelegramClient`: telegram client, can be omitted, in this case default client is used.
"""
function apiquery(method, client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    params = API.method_params(client, string(method), kwargs)
    query(client, method; params = params)
end
