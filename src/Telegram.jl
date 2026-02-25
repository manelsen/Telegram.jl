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
using .V70
using .V72
using .V73
using .V74_75
using .V76_77

include("logging.jl")
include("bot.jl")

end # module
