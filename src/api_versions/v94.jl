"""
    Telegram.API.V94

Métodos da API 9.4 - Profile Photos and User Audios
Released: February 2026

API 9.4 adds:
- setMyProfilePhoto: Set bot's profile photo
- removeMyProfilePhoto: Remove bot's profile photo
- getUserProfileAudios: Get user's profile audios
- allows_users_to_create_topics field in User
- Custom emoji support in messages
"""
module V94
using ...Telegram
using ...Telegram.API

"""
    setMyProfilePhoto([client]; photo)

Use this method to set the bot's profile photo. 
Returns True on success.

# Arguments
- `photo`: InputProfilePhoto
"""
function setMyProfilePhoto(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setMyProfilePhoto", Dict{Symbol, Any}(kwargs))
end

"""
    removeMyProfilePhoto([client])

Use this method to remove the bot's profile photo. 
Returns True on success.
"""
function removeMyProfilePhoto(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "removeMyProfilePhoto", Dict{Symbol, Any}(kwargs))
end

"""
    getUserProfileAudios([client]; user_id; kwargs...)

Use this method to get a list of profile audios of a user. 
Returns UserProfileAudios on success.

# Arguments
- `user_id`: User identifier
"""
function getUserProfileAudios(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getUserProfileAudios", Dict{Symbol, Any}(kwargs))
end

export setMyProfilePhoto, removeMyProfilePhoto, getUserProfileAudios
end
