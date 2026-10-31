"""
    Telegram.API.V72

Métodos da API 7.2 - Business Messages
Released: March 2024
"""
module V72

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: getBusinessConnection

export getBusinessConnection

end # module V72
