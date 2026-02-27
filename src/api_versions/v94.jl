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
using ...Telegram: @api_method

@api_method setMyProfilePhoto """
    setMyProfilePhoto([client]; photo)
Sets the bot's profile photo. Returns True on success.
"""

@api_method removeMyProfilePhoto """
    removeMyProfilePhoto([client])
Removes the bot's profile photo.
"""

@api_method getUserProfileAudios """
    getUserProfileAudios([client]; user_id; kwargs...)
Retrieves a list of profile audios of a user.
"""

end # module
