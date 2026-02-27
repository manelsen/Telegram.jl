module CLI

using ..Telegram
using ..Telegram.API
using ConfigEnv
using JSON3

export onboard, doctor

"""
    onboard()

Scaffolds a typical bot project in the current directory.
"""
function onboard()
    println("☁️  Starting Telegram.jl Onboarding...")
    if !isfile(".env")
        write(".env", "TELEGRAM_BOT_TOKEN=YOUR_TOKEN_HERE\nTELEGRAM_BOT_CHAT_ID=YOUR_CHAT_ID_HERE\n")
    end
    if !isfile("main.jl")
        write("main.jl", "using Telegram, Telegram.API\nusing ConfigEnv\ndotenv()\nrun_bot() do msg\n    @bot_command \"/start\" msg sendMessage(text=\"Hello!\")\nend\n")
    end
    println("✅ Onboarding Complete!")
end

"""
    doctor()

Diagnoses common bot configuration issues.
"""
function doctor()
    println("🚑  Telegram.jl Doctor - Running Checkup...")
    # Basic implementation for CLI tool commit
    if isfile(".env")
        println("  [PASS] .env file found.")
    else
        println("  [FAIL] .env file missing.")
    end
end

end # module
