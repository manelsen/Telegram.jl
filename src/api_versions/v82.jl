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

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: verifyUser, verifyChat, removeUserVerification, removeChatVerification

export verifyUser, verifyChat, removeUserVerification, removeChatVerification

end # module V82
