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

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: setMyProfilePhoto, removeMyProfilePhoto, getUserProfileAudios

export setMyProfilePhoto, removeMyProfilePhoto, getUserProfileAudios

end # module V94
