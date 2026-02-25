"""
    Telegram.API.V80

Métodos da API 8.0 - Star Subscriptions, Full-screen Mode, Emoji Status
Released: November 2024

API 8.0 adds:
- editUserStarSubscription: Edit user's star subscription
- setUserEmojiStatus: Set user's emoji status  
- savePreparedInlineMessage: Save prepared inline message
- subscription_period parameter to createInvoiceLink
- business_connection_id parameter to createInvoiceLink
"""
module V80
using ...Telegram
using ...Telegram.API

"""
    editUserStarSubscription([client]; user_id, telegram_payment_charge_id; kwargs...)

Use this method to edit the subscription of a user to a paid broadcast. 
Returns True on success.

# Arguments
- `user_id`: Identifier of the user whose subscription to edit
- `telegram_payment_charge_id`: Telegram payment charge identifier
"""
function editUserStarSubscription(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "editUserStarSubscription", Dict{Symbol, Any}(kwargs))
end

"""
    setUserEmojiStatus([client]; user_id, emoji_status_custom_emoji_id; kwargs...)

Use this method to change the default emoji status for the user. 
Returns True on success.

# Arguments
- `user_id`: Identifier of the user
- `emoji_status_custom_emoji_id`: Custom emoji identifier
"""
function setUserEmojiStatus(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setUserEmojiStatus", Dict{Symbol, Any}(kwargs))
end

"""
    savePreparedInlineMessage([client]; user_id, chat_id, message_id, data; kwargs...)

Use this method to save a prepared inline message for a user. 
Returns a PreparedInlineMessage object on success.

# Arguments
- `user_id`: Identifier of the user
- `chat_id`: Identifier of the chat
- `message_id`: Identifier of the message
- `data`: Data to save
"""
function savePreparedInlineMessage(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "savePreparedInlineMessage", Dict{Symbol, Any}(kwargs))
end

export editUserStarSubscription, setUserEmojiStatus, savePreparedInlineMessage
end
