"""
    Telegram.API.V90

Métodos da API 9.0 - Business Accounts
Released: April 2025

API 9.0 adds many Business Account methods:
"""
module V90

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: readBusinessMessage, deleteBusinessMessages, setBusinessAccountName, setBusinessAccountUsername, setBusinessAccountBio, setBusinessAccountProfilePhoto, removeBusinessAccountProfilePhoto, setBusinessAccountGiftSettings, getBusinessAccountStarBalance, transferBusinessAccountStars, getBusinessAccountGifts, convertGiftToStars, upgradeGift, transferGift, postStory, editStory, deleteStory

export readBusinessMessage, deleteBusinessMessages, setBusinessAccountName, setBusinessAccountUsername, setBusinessAccountBio, setBusinessAccountProfilePhoto, removeBusinessAccountProfilePhoto, setBusinessAccountGiftSettings, getBusinessAccountStarBalance, transferBusinessAccountStars, getBusinessAccountGifts, convertGiftToStars, upgradeGift, transferGift, postStory, editStory, deleteStory

end # module V90
