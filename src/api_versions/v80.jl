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

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: editUserStarSubscription, setUserEmojiStatus, savePreparedInlineMessage

export editUserStarSubscription, setUserEmojiStatus, savePreparedInlineMessage

end # module V80
