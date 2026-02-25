"""
    Telegram.API.V711

Métodos da API 7.11 - Copy Text Button, Allow Paid Broadcast
Released: September 2024

API 7.11 adds:
- CopyTextButton and copy_text inline keyboard button
- allow_paid_broadcast parameter to sendMessage, sendPhoto, sendVideo, etc.
- TransactionPartnerTelegramApi for paid broadcasts

These are implemented as parameters to existing methods via kwargs.
"""
module V711
# allow_paid_broadcast handled via kwargs in existing send methods
end
