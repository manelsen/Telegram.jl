"""
    Telegram.API.V74_75

Métodos da API 7.4-7.5 - Telegram Stars & Transactions
Released: June 2024
"""
module V74_75
using ...Telegram
using ...Telegram.API

"""
    refundStarPayment([client]; user_id, telegram_payment_charge_id)

Use this method to refund a successful payment in Telegram Stars. Returns True on success.

# Arguments
- `user_id`: Identifier of the user whose payment was refunded
- `telegram_payment_charge_id`: Telegram payment identifier
"""
function refundStarPayment(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "refundStarPayment", Dict{Symbol, Any}(kwargs))
end

"""
    getStarTransactions([client]; kwargs...)

Use this method to get the list of all Telegram Star transactions for the bot. 
Returns a StarTransactions object on success.

# Optional arguments
- `offset`: Offset of the first entry to return
- `limit`: Maximum number of entries to return (1-100)
"""
function getStarTransactions(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getStarTransactions", Dict{Symbol, Any}(kwargs))
end

export refundStarPayment, getStarTransactions
end
