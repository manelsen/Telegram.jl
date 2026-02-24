module Telegram
using HTTP
using JSON3

using Base.CoreLogging:
    global_logger,
    LogLevel, BelowMinLevel, Debug, Info, Warn, Error, AboveMaxLevel

import Base.CoreLogging:
    AbstractLogger,
    handle_message, shouldlog, min_enabled_level, catch_exceptions

export TelegramClient, useglobally!, TelegramLogger, run_bot

include("client.jl")
include("api.jl")
using .API

# Load type definitions
include("types/telegram_types.jl")
include("types/supporting_types.jl")

include("logging.jl")
include("bot.jl")

end # module
