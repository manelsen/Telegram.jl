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

using Base.CoreLogging:
    global_logger,
    LogLevel, BelowMinLevel, Debug, Info, Warn, Error, AboveMaxLevel

import Base.CoreLogging:
    AbstractLogger,
    handle_message, shouldlog, min_enabled_level, catch_exceptions

include("decision_support.jl")

export TelegramClient, useglobally!, TelegramLogger, run_bot

include("client.jl")
include("api.jl")
using .API

include("api_versions/v70.jl")
include("api_versions/v72.jl")
include("api_versions/v73.jl")
include("api_versions/v74_75.jl")
include("api_versions/v76_77.jl")
include("api_versions/v78.jl")
include("api_versions/v79.jl")
include("api_versions/v710.jl")
include("api_versions/v711.jl")
include("api_versions/v80.jl")
include("api_versions/v81.jl")
include("api_versions/v82.jl")
include("api_versions/v83.jl")
include("api_versions/v90.jl")
include("api_versions/v91.jl")
include("api_versions/v92.jl")
include("api_versions/v93.jl")
include("api_versions/v94.jl")
using .V70
using .V72
using .V73
using .V74_75
using .V76_77
using .V80
using .V82
using .V90
using .V91
using .V93
using .V94

include("logging.jl")
include("bot.jl")

end # module
