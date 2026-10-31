"""
    Telegram.API.V91

Métodos da API 9.1 - Checklists
Released: July 2025

API 9.1 adds:
- sendChecklist: Send a checklist
- editMessageChecklist: Edit a checklist
- getMyStarBalance: Get bot's star balance
"""
module V91

# Versioned compatibility namespace: reuse the generated Telegram.API methods.
# Do not define independent wrappers; they would diverge from API's query contract.
using ..API: sendChecklist, editMessageChecklist, getMyStarBalance

export sendChecklist, editMessageChecklist, getMyStarBalance

end # module V91
