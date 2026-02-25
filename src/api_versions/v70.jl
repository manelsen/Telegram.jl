"""
    Telegram.API.V70

Métodos da API 7.0 - Reactions, Replies 2.0, Link Preview Customization
Released: December 2023
"""
module V70
using ...Telegram
using ...Telegram.API

"""
    setMessageReaction([client]; chat_id, message_id, reaction; kwargs...)

Use this method to change the chosen reactions on a message by a bot. 
The bot must be an administrator in the chat and must have the appropriate administrator rights. 
Returns True on success.

# Arguments
- `chat_id`: Unique identifier for the target chat or username of the target channel
- `message_id`: Identifier of the target message
- `reaction`: New reaction as an array of ReactionType

# Example
```julia
tg = TelegramClient(token)
setMessageReaction(tg; chat_id=123, message_id=456, reaction=[Dict("type" => "emoji", "emoji" => "👍")])
```
"""
function setMessageReaction(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setMessageReaction", Dict{Symbol, Any}(kwargs))
end

export setMessageReaction
end
