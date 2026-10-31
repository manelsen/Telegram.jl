module API
using ..Telegram

include("telegram_api.jl")

# Each generated method contains parameter declarations in its embedded Bot API
# documentation. Derive the optional defaults from that same source of truth,
# rather than maintaining a second list of methods by hand.
const DEFAULT_CHAT_ID_METHODS = Set(
    string(f) for (f, doc) in TELEGRAM_API if occursin(r"(?m)^- \x60chat_id\x60:", doc)
)
const DEFAULT_PARSE_MODE_METHODS = Set(
    string(f) for (f, doc) in TELEGRAM_API if occursin(r"(?m)^- \x60parse_mode\x60:", doc)
)

"""
    method_params(client::TelegramClient, method::AbstractString, kwargs)

Prepare the parameters for an API method, adding configured chat_id and
parse_mode defaults only where the method declares those parameters.

Unknown methods pass through exactly the caller's supplied keyword arguments.
An explicitly supplied value (including an empty string) takes precedence.
"""
function method_params(client::Telegram.TelegramClient, method::AbstractString, kwargs)
    params = Dict{Symbol, Any}(kwargs)

    if method in DEFAULT_CHAT_ID_METHODS && !haskey(params, :chat_id)
        default_chat_id = Telegram.chatid(client)
        isempty(default_chat_id) || (params[:chat_id] = default_chat_id)
    end

    if method in DEFAULT_PARSE_MODE_METHODS && !haskey(params, :parse_mode)
        isempty(client.parse_mode) || (params[:parse_mode] = client.parse_mode)
    end

    return params
end

for (f, fdoc) in TELEGRAM_API
    fs = string(f)
    @eval begin
        function $f(client::Telegram.TelegramClient = Telegram.DEFAULT_OPTS.client; kwargs...)
            params = method_params(client, $fs, kwargs)
            Telegram.query(client, $fs; params = params)
        end

        @doc $fdoc $f
        export $f
    end
end

end # module
