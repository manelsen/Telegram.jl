"""
    Telegram.API.V74_75

Métodos da API 7.4-7.5 - Telegram Stars & Transactions
Released: June 2024
"""
module V74_75

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: refundStarPayment, getStarTransactions

export refundStarPayment, getStarTransactions

end # module V74_75
