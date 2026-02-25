"""
    Telegram.API.V79

Métodos da API 7.9 - Super Channels, Paid Media, Subscriptions
Released: July 2024

API 7.9 adds:
- business_connection_id parameter to sendPaidMedia
- createChatSubscriptionInviteLink (already implemented in v76_77)
- editChatSubscriptionInviteLink (already implemented in v76_77)
- ReactionTypePaid for paid reactions

Note: createChatSubscriptionInviteLink and editChatSubscriptionInviteLink 
were implemented in API 7.6-7.7 commit but officially released in 7.9
"""
module V79
# Subscription methods already in v76_77
# business_connection_id param to sendPaidMedia handled via kwargs
end
