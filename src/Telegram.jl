"""
    module Telegram

The ultimate Julia SDK for the Telegram Bot API.

`Telegram.jl` provides a high-level, idiomatic, and high-performance interface to interact with
Telegram. It features dynamic API generation, built-in bot polling, and advanced traceability
standards (Decision Support).

# Main Exports
- `TelegramClient`: The core object managing authentication and global defaults.
- `run_bot`: A robust, non-blocking polling loop for bot logic.
- `TelegramLogger`: A standard Julia logger that sends logs directly to Telegram.
- `@bot_command`: A macro for elegant, declarative command handling.

# Examples
```julia
using Telegram, Telegram.API

# Quick Start: Echo Bot
run_bot() do msg
    @bot_command "/start" msg sendMessage(text="Hello from Julia!")
    
    if haskey(msg, :message)
        sendMessage(text=msg.message.text, chat_id=msg.message.chat.id)
    end
end
```
"""
module Telegram
using HTTP
using JSON3
