"""
    Telegram.API.V73

Métodos da API 7.3 - Live Location
Released: April 2024
"""
module V73
using ...Telegram
using ...Telegram.API

"""
    editMessageLiveLocation([client]; chat_id, message_id, latitude, longitude; kwargs...)

Use this method to edit live location messages. Location can be edited until its live_period expires 
or explicitly stopped using stopMessageLiveLocation.

# Arguments
- `chat_id`: Unique identifier for the target chat
- `message_id`: Identifier of the message to edit
- `latitude`: Latitude of the new location
- `longitude`: Longitude of the new location
"""
function editMessageLiveLocation(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "editMessageLiveLocation", Dict{Symbol, Any}(kwargs))
end

"""
    stopMessageLiveLocation([client]; chat_id, message_id)
    stopMessageLiveLocation([client]; inline_message_id)

Use this method to stop updating a live location message before live_period expires.

# Arguments (one of the following required)
- `chat_id` + `message_id`: For regular messages
- `inline_message_id`: For inline messages
"""
function stopMessageLiveLocation(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "stopMessageLiveLocation", Dict{Symbol, Any}(kwargs))
end

export editMessageLiveLocation, stopMessageLiveLocation
end
