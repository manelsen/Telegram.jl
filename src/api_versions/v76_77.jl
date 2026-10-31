"""
    Telegram.API.V76_77

Métodos da API 7.6-7.7 - Paid Media
Released: July 2024
"""
module V76_77

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: sendPaidMedia, createChatSubscriptionInviteLink, editChatSubscriptionInviteLink

export sendPaidMedia, createChatSubscriptionInviteLink, editChatSubscriptionInviteLink

end # module V76_77
