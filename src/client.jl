using .DecisionSupport

"""
    @api_method name docstring

Macro for maintainers to generate Telegram API methods with zero boilerplate.
Automatically handles global defaults (chat_id, parse_mode) and client management.
"""
macro api_method(name, doc)
    method_name = string(name)
    return quote
        @doc $doc
        function $(esc(name))(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
            params = Dict{Symbol, Any}(kwargs)
            params[:chat_id] = get(params, :chat_id, chatid(client))
            params[:parse_mode] = get(params, :parse_mode, client.parse_mode)
            query(client, $method_name, params = params)
        end
        export $(esc(name))
    end
end

"""
    TelegramError(error_code, description)

An exception thrown when the Telegram API returns an error.
It includes a human-friendly explanation and advice based on the error code.
"""
struct TelegramError <: Exception
    code::Int
    msg::String
    advice::String

    function TelegramError(code::Int, msg::String)
        advice = get_friendly_advice(code, msg)
        new(code, msg, advice)
    end
end

function get_friendly_advice(code::Int, msg::String)
    if code == 401
        return "Your BOT_TOKEN seems invalid. Check with @BotFather if you copied it correctly."
    elseif code == 403
        return "The bot was blocked by the user or kicked from the group. Make sure the user has started a conversation with the bot."
    elseif code == 400 && occursin("chat not found", msg)
        return "The chat_id is incorrect or the bot hasn't seen this chat yet. Ask the user to send a message to the bot first."
    elseif code == 429
        return "You are being rate-limited. Slow down! Check Telegram's broadcasting limits."
    elseif code == 404
        return "The method you called does not exist. Check if it's available in your Bot API version."
    else
        return "An unexpected error occurred. Please check the official Telegram Bot API documentation."
    end
end

function Base.show(io::IO, e::TelegramError)
    print(io, "Telegram API Error [$(e.code)]: $(e.msg)\n")
    print(io, "💡 Advice: $(e.advice)")
end

"""
    TelegramClient(token; chat_id="", parse_mode="HTML", enable_traceability=true)

The central configuration object for all Telegram interactions.
"""
mutable struct TelegramClient
    token::String
    chat_id::String
    parse_mode::String
    ep::String
    query_func::Union{Function, Nothing}
    request_id::String
    enable_traceability::Bool

    function TelegramClient(token::String; 
                           chat_id::Union{String, Int} = "", 
                           parse_mode::String = "HTML",
                           enable_traceability::Bool = true,
                           query_func::Union{Function, Nothing} = nothing)
        new(token, string(chat_id), parse_mode, "https://api.telegram.org/bot$token/", query_func, "", enable_traceability)
    end
end

# Internal defaults
mutable struct DefaultOptions
    client::TelegramClient
end

const DEFAULT_OPTS = DefaultOptions(TelegramClient(""))

"""
    useglobally!(client::TelegramClient)

Sets the provided client as the global default for all Telegram API calls.
"""
function useglobally!(client::TelegramClient)
    DEFAULT_OPTS.client = client
end

"""
    chatid(client::TelegramClient)

Returns the default `chat_id` configured in the client.
"""
chatid(client::TelegramClient) = client.chat_id

"""
    query(client, method; params=Dict())

Performs a raw request to the Telegram Bot API. 
Handles JSON serialization, traceability metadata, and error reporting.
"""
function query(client::TelegramClient, method::String; params::Dict{Symbol, Any} = Dict{Symbol, Any}())
    if client.query_func !== nothing
        return client.query_func(client, method, params)
    end

    if client.enable_traceability
        # Generate new request ID for this specific call
        client.request_id = DecisionSupport.generate_request_id()
        
        # Add traceability metadata
        params = copy(params)
        params[:_request_id] = client.request_id
        params[:_timestamp] = DecisionSupport.datetime_to_iso8601(DecisionSupport.generate_timestamp_utc())
        params[:_schema_version] = DecisionSupport.get_schema_version()
        
        DecisionSupport.validate_https_enforced(client.ep) || error("HTTPS is mandatory for Telegram API")
    end

    body = isempty(params) ? "" : JSON3.write(params)
    headers = ["Content-Type" => "application/json"]
    
    response = HTTP.post(client.ep * method, headers, body; status_exception = false)
    
    if response.status != 200
        res_json = JSON3.read(response.body)
        throw(TelegramError(get(res_json, :error_code, response.status), get(res_json, :description, "Unknown Error")))
    end
    
    res_json = JSON3.read(response.body)
    if !res_json.ok
        throw(TelegramError(get(res_json, :error_code, 400), get(res_json, :description, "Unknown Error")))
    end
    
    return res_json.result
end
