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
end

"""
    TelegramClient(token; chat_id, parse_mode, ep, use_globally = true, query_func = nothing, enable_traceability = true)

Creates telegram client, which can be used to run telegram commands.

# Arguments
- `token::String`: telegram token, which can be obtained in telegram from @BotFather.
- `chat_id`: if set, used as default `chat_id` argument for all chat related commands. To get specific `chat_id`, send message to the bot in telegram application and use [`getUpdates`](@ref) command.
- `parse_mode`: if set, used as default for text messaging commands.
- `use_globally::Bool`: default `true`. If set to `true` then it current client can be used as default in all telegram commands.
- `ep`: endpoint for telegram api. By default `https://api.telegram.org/bot` is used, but you may change it, if you are using proxy or for testing purposes.
- `query_func`: optional custom function for making HTTP queries. Useful for testing and mocking. Function signature: `(client, method, params) -> result`.
- `enable_traceability::Bool`: default `true`. If set to `true`, enables Decision Support traceability features (DS-001, DS-002, DS-003, DS-004, DS-005).
"""
function TelegramClient(token = get(ENV, "TELEGRAM_BOT_TOKEN", "");
                     chat_id = get(ENV, "TELEGRAM_BOT_CHAT_ID" ,""),
                     parse_mode = "",
                     ep = "https://api.telegram.org/bot",
                     use_globally = true,
                     query_func = nothing,
                     enable_traceability = true)
    request_id = enable_traceability ? DecisionSupport.generate_request_id() : ""
    client = TelegramClient(token, chat_id, parse_mode, ep, query_func, request_id, enable_traceability)
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

const DEFAULT_OPTS = TelegramOpts(TelegramClient(use_globally = false), [:photo, :audio, :thumb, :document, :video, :animation, :voice, :video_note, :sticker, :png_sticker, :tgs_sticker, :certificate, :files], 30)

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

pushfiles!(body, keyword, file) = push!(body, keyword => file)
function pushfiles!(body, keyword, file::Pair)
    push!(body, keyword => HTTP.Multipart(file.first, ioify(file.second)))
end

process_params(x::AbstractString) = x
process_params(x) = JSON3.write(x)   

function query(client::TelegramClient, method; params = Dict())
    # Use custom query function if provided (useful for testing/mocking)
    if client.query_func !== nothing
        return client.query_func(client, method, params)
    end

    # DS-001: Traceability - Add request ID, timestamp, and schema version
    if client.enable_traceability
        # Generate new request ID for each query
        client.request_id = DecisionSupport.generate_request_id()

        # Add traceability metadata
        params = copy(params)
        params["_request_id"] = client.request_id
        params["_timestamp"] = DecisionSupport.datetime_to_iso8601(DecisionSupport.generate_timestamp_utc())
        params["_schema_version"] = DecisionSupport.get_schema_version()

        # Log request ID (DS-001)
        @debug "Telegram API Request" method=method request_id=client.request_id
    end

    # DS-003: Integrity - Validate HTTPS is enforced
    if !DecisionSupport.validate_https_enforced(client.ep)
        @warn "HTTPS not enforced for endpoint" endpoint=client.ep
    end

    req_uri = client.ep * token(client) * "/" * method
    intersection = intersect(keys(params), DEFAULT_OPTS.upload_kw)
    if isempty(intersection)
        headers = ["Content-Type" => "application/json", "Connection" => "Keep-Alive"]
        json_params = JSON3.write(params)
        res = HTTP.post(req_uri, headers, json_params; readtimeout = DEFAULT_OPTS.timeout + 1)
    else
        body = Pair[]
        for (k, v) in params
            k in intersection && continue
            push!(body, k => process_params(v))
        end
        for k in intersection
            pushfiles!(body, k, params[k])
        end
        res = HTTP.post(req_uri, ["Connection" => "Keep-Alive"], HTTP.Form(body); readtimeout = DEFAULT_OPTS.timeout + 1)
    end

    response = JSON3.read(res.body)

    if response.ok
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
    params = Dict{Symbol, Any}(kwargs)
    params[:chat_id] = get(params, :chat_id, chatid(client))
    params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
    query(client, method, params = params)
end
