"""
    Telegram.API.V82

Métodos da API 8.2 - Third-party Verification
Released: January 2025

API 8.2 adds:
- verifyUser: Verify a user on behalf of an organization
- verifyChat: Verify a chat on behalf of an organization
- removeUserVerification: Remove user verification
- removeChatVerification: Remove chat verification
- upgrade_star_count field in Gift
- pay_for_upgrade parameter in sendGift
"""
module V82
using ...Telegram
using ...Telegram.API

"""
    verifyUser([client]; user_id, organization_id; kwargs...)

Use this method to verify a user on behalf of an organization. 
Returns True on success.

# Arguments
- `user_id`: User identifier to verify
- `organization_id`: Organization identifier
"""
function verifyUser(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "verifyUser", Dict{Symbol, Any}(kwargs))
end

"""
    verifyChat([client]; chat_id, organization_id; kwargs...)

Use this method to verify a chat on behalf of an organization. 
Returns True on success.

# Arguments
- `chat_id`: Chat identifier to verify
- `organization_id`: Organization identifier
"""
function verifyChat(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "verifyChat", Dict{Symbol, Any}(kwargs))
end

"""
    removeUserVerification([client]; user_id; kwargs...)

Use this method to remove verification of a user. 
Returns True on success.

# Arguments
- `user_id`: User identifier to remove verification
"""
function removeUserVerification(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "removeUserVerification", Dict{Symbol, Any}(kwargs))
end

"""
    removeChatVerification([client]; chat_id; kwargs...)

Use this method to remove verification of a chat. 
Returns True on success.

# Arguments
- `chat_id`: Chat identifier to remove verification
"""
function removeChatVerification(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "removeChatVerification", Dict{Symbol, Any}(kwargs))
end

export verifyUser, verifyChat, removeUserVerification, removeChatVerification
end
