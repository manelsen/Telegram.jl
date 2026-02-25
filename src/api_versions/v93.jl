"""
    Telegram.API.V93

Métodos da API 9.3 - Topics in private chats
Released: December 2025

API 9.3 adds:
- sendMessageDraft: Send a message draft
- getUserGifts: Get user's gifts
- getChatGifts: Get chat's gifts
- has_topics_enabled field in User
- message_thread_id support in private chats
"""
module V93
using ...Telegram
using ...Telegram.API

"""
    sendMessageDraft([client]; chat_id, message_thread_id, draft_id, text; kwargs...)

Use this method to send a message draft. 
Returns True on success.

# Arguments
- `chat_id`: Chat identifier
- `draft_id`: Draft identifier
- `text`: Draft text
"""
function sendMessageDraft(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "sendMessageDraft", Dict{Symbol, Any}(kwargs))
end

"""
    getUserGifts([client]; user_id; kwargs...)

Use this method to get the list of gifts owned by a user. 
Returns OwnedGifts on success.

# Arguments
- `user_id`: User identifier
"""
function getUserGifts(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getUserGifts", Dict{Symbol, Any}(kwargs))
end

"""
    getChatGifts([client]; chat_id; kwargs...)

Use this method to get the list of gifts owned by a chat. 
Returns OwnedGifts on success.

# Arguments
- `chat_id`: Chat identifier
"""
function getChatGifts(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getChatGifts", Dict{Symbol, Any}(kwargs))
end

export sendMessageDraft, getUserGifts, getChatGifts
end
