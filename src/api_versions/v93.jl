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

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: sendMessageDraft, getUserGifts, getChatGifts

export sendMessageDraft, getUserGifts, getChatGifts

end # module V93
