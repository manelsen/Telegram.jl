"""
    Telegram.API.V76_77

Métodos da API 7.6-7.7 - Paid Media
Released: July 2024
"""
module V76_77
using ...Telegram
using ...Telegram.API

"""
    sendPaidMedia([client]; business_connection_id, star_count, media; kwargs...)

Use this method to send paid media to a channel, private chat, or group chat. 
Returns a Message object on success.

# Required arguments
- `business_connection_id`: Unique identifier of the business connection
- `star_count`: The number of Telegram Stars that must be paid
- `media`: A JSON-serialized array of InputPaidMedia
"""
function sendPaidMedia(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "sendPaidMedia", Dict{Symbol, Any}(kwargs))
end

"""
    createChatSubscriptionInviteLink([client]; chat_id, subscription_period, subscription_price; kwargs...)

Use this method to create a subscription invite link for a channel chat. 
Returns a ChatInviteLink object on success.

# Arguments
- `chat_id`: Unique identifier for the target chat
- `subscription_period`: Number of seconds the subscription will be valid for
- `subscription_price`: Amount of Telegram Stars
"""
function createChatSubscriptionInviteLink(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "createChatSubscriptionInviteLink", Dict{Symbol, Any}(kwargs))
end

"""
    editChatSubscriptionInviteLink([client]; invite_link; kwargs...)

Use this method to edit a subscription invite link. Returns the updated ChatInviteLink on success.

# Arguments
- `invite_link`: The invite link to edit
"""
function editChatSubscriptionInviteLink(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "editChatSubscriptionInviteLink", Dict{Symbol, Any}(kwargs))
end

export sendPaidMedia, createChatSubscriptionInviteLink, editChatSubscriptionInviteLink
end
