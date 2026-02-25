module TestHelpers

using Telegram
using Telegram.DecisionSupport
using Test
using JSON3

export MockClient, success_response, error_response
export get_me_response, get_updates_response, send_message_response, set_chat_title_response
export validate_uuid_format, validate_timestamp_utc_format, validate_iso8601_format
export extract_request_id_from_params, extract_timestamp_from_params

"""
    MockClient(token::String = "test_token"; responses::Dict = Dict{String, Dict}(), kwargs...)

Create a mock Telegram client for testing.

# Arguments
- `token::String`: Bot token (can be any string for testing)
- `responses::Dict`: Dictionary mapping method names to responses
- `kwargs`: Additional keyword arguments to pass to TelegramClient (e.g., chat_id, parse_mode, enable_traceability)

# Returns
- `TelegramClient`: A client with a custom query function that returns mock responses
"""
function MockClient(token::String = "test_token"; responses::Dict = Dict{String, Dict}(), kwargs...)
    query_func = (client, method, params) -> begin
        # Get response or return default success response
        if haskey(responses, method)
            resp = responses[method]

            # Check if response is an error
            if get(resp, "ok", false)
                return resp["result"]
            else
                throw(Telegram.TelegramError(resp))
            end
        else
            # Default successful response for getMe
            default_result = Dict(
                "id" => 123456789,
                "is_bot" => true,
                "first_name" => "Test Bot",
                "username" => "test_bot"
            )
            return default_result
        end
    end

    # Enable traceability by default in mocks
    if !haskey(kwargs, :enable_traceability)
        kwargs = (;kwargs..., enable_traceability = false)
    end

    return TelegramClient(token; query_func = query_func, kwargs...)
end

"""
    success_response(data::Dict)

Create a successful Telegram API response.
"""
function success_response(data::Dict)
    return Dict(
        "ok" => true,
        "result" => data
    )
end

"""
    error_response(error_code::Int, description::String)

Create an error Telegram API response.
"""
function error_response(error_code::Int, description::String)
    return Dict(
        "ok" => false,
        "error_code" => error_code,
        "description" => description
    )
end

"""
    get_me_response()

Mock response for getMe method.
"""
function get_me_response()
    return success_response(Dict(
        "id" => 123456789,
        "is_bot" => true,
        "first_name" => "Test Bot",
        "username" => "test_bot"
    ))
end

"""
    get_updates_response(updates::Vector = [])

Mock response for getUpdates method.
"""
function get_updates_response(updates::Vector = [])
    return Dict(
        "ok" => true,
        "result" => updates
    )
end

"""
    send_message_response(message_id::Int, chat_id::Int, text::String)

Mock response for sendMessage method.
"""
function send_message_response(message_id::Int, chat_id::Int, text::String)
    return success_response(Dict(
        "message_id" => message_id,
        "from" => Dict(
            "id" => 123456789,
            "is_bot" => true,
            "first_name" => "Test Bot",
            "username" => "test_bot"
        ),
        "chat" => Dict(
            "id" => chat_id,
            "type" => "private"
        ),
        "date" => Int(floor(time())),
        "text" => text
    ))
end

"""
    set_chat_title_response(success::Bool = true)

Mock response for setChatTitle method.
"""
function set_chat_title_response(success::Bool = true)
    return success ? success_response(Dict("result" => true)) :
                     error_response(400, "Bad Request: chat not found")
end

# ============================================================================
# Decision Support Test Helpers
# ============================================================================

"""
    validate_uuid_format(uuid_str::String) -> Bool

Validate that a string is a valid UUID v4 format.

# Arguments
- `uuid_str::String`: String to validate

# Returns
- `Bool`: True if valid UUID v4 format, false otherwise
"""
function validate_uuid_format(uuid_str::String)
    pattern = r"^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$"
    return occursin(pattern, lowercase(uuid_str))
end

"""
    validate_timestamp_utc_format(timestamp::String) -> Bool

Validate that a timestamp string is in UTC ISO 8601 format.

# Arguments
- `timestamp::String`: Timestamp string to validate

# Returns
- `Bool`: True if valid UTC ISO 8601 format, false otherwise
"""
function validate_timestamp_utc_format(timestamp::String)
    # Check for Z suffix (UTC indicator)
    if !endswith(timestamp, "Z")
        return false
    end

    # Try to parse as DateTime
    try
        dt = DateTime(timestamp[1:end-1], "yyyy-mm-ddTHH:MM:SS.sss")
        return true
    catch
        return false
    end
end

"""
    validate_iso8601_format(timestamp::String) -> Bool

Validate that a timestamp string is in ISO 8601 format.

# Arguments
- `timestamp::String`: Timestamp string to validate

# Returns
- `Bool`: True if valid ISO 8601 format, false otherwise
"""
function validate_iso8601_format(timestamp::String)
    try
        if endswith(timestamp, "Z")
            dt = DateTime(timestamp[1:end-1], "yyyy-mm-ddTHH:MM:SS.sss")
        else
            dt = DateTime(timestamp, "yyyy-mm-ddTHH:MM:SS.sss")
        end
        return true
    catch
        return false
    end
end

"""
    extract_request_id_from_params(params::Dict) -> String

Extract request ID from parameters dictionary.

# Arguments
- `params::Dict`: Parameters dictionary

# Returns
- `String`: Request ID or empty string if not found
"""
function extract_request_id_from_params(params::Dict)
    return get(params, "_request_id", "")
end

"""
    extract_timestamp_from_params(params::Dict) -> String

Extract timestamp from parameters dictionary.

# Arguments
- `params::Dict`: Parameters dictionary

# Returns
- `String`: Timestamp or empty string if not found
"""
function extract_timestamp_from_params(params::Dict)
    return get(params, "_timestamp", "")
end

export MockClient
export success_response, error_response
export get_me_response, get_updates_response, send_message_response, set_chat_title_response

end # module
