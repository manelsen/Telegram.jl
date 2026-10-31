"""
    Telegram.API.V70

Métodos da API 7.0 - Reactions, Replies 2.0, Link Preview Customization
Released: December 2023
"""
module V70

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: setMessageReaction

export setMessageReaction

end # module V70
