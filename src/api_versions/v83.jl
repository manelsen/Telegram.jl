"""
    Telegram.API.V83

Métodos da API 8.3 - Video Cover and Start Timestamp
Released: February 2025

API 8.3 adds:
- chat_id parameter to sendGift (send gifts to channel chats)
- cover and start_timestamp parameters to sendVideo
- video_start_timestamp parameter to forwardMessage and copyMessage
- can_send_gift field in ChatFullInfo
- TransactionPartnerChat class for chat transactions

Note: These are primarily parameter additions to existing methods.
"""
module V83
# New parameters in this version:
# - chat_id to sendGift
# - cover, start_timestamp to sendVideo  
# - video_start_timestamp to forwardMessage/copyMessage
# These are handled via kwargs in existing implementations
end
