"""
    Telegram.API.V72

Métodos da API 7.2 - Business Messages
Released: March 2024
"""
module V72
using ...Telegram
using ...Telegram.API

"""
    getBusinessConnection([client]; business_connection_id)

Use this method to get information about the connection of the bot with a business account. 
Returns a BusinessConnection object on success.

# Arguments
- `business_connection_id`: Unique identifier of the business connection
"""
function getBusinessConnection(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getBusinessConnection", Dict{Symbol, Any}(kwargs))
end

export getBusinessConnection
end
