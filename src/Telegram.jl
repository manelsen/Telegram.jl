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

using .V70, .V72, .V73, .V74_75, .V76_77, .V78, .V79, .V710, .V711
using .V80, .V81, .V82, .V83
using .V90, .V91, .V92, .V93, .V94

# Global Exports for all API versions
for mod in [V70, V72, V73, V74_75, V76_77, V78, V79, V710, V711, V80, V81, V82, V83, V90, V91, V92, V93, V94]
    for sym in names(mod)
        if sym != Symbol(mod)
            @eval export $sym
        end
    end
end

include("logging.jl")
include("bot.jl")

end # module
