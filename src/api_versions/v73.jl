"""
    Telegram.API.V73

Métodos da API 7.3 - Live Location
Released: April 2024
"""
module V73

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: editMessageLiveLocation, stopMessageLiveLocation

export editMessageLiveLocation, stopMessageLiveLocation

end # module V73
