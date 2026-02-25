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
using ...Telegram
using ...Telegram.API

"""
    sendChecklist([client]; business_connection_id, chat_id, checklist; kwargs...)

Use this method to send a checklist on behalf of a business account. 
Returns Message on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `chat_id`: Chat identifier
- `checklist`: InputChecklist
"""
function sendChecklist(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "sendChecklist", Dict{Symbol, Any}(kwargs))
end

"""
    editMessageChecklist([client]; business_connection_id, chat_id, message_id, checklist; kwargs...)

Use this method to edit a checklist. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `chat_id`: Chat identifier
- `message_id`: Message identifier
- `checklist`: InputChecklist
"""
function editMessageChecklist(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "editMessageChecklist", Dict{Symbol, Any}(kwargs))
end

"""
    getMyStarBalance([client])

Use this method to get the current star balance of the bot. 
Returns StarAmount on success.
"""
function getMyStarBalance(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getMyStarBalance", Dict{Symbol, Any}(kwargs))
end

export sendChecklist, editMessageChecklist, getMyStarBalance
end
