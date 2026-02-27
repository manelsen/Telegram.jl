"""
    @bot_command command msg body

A high-level macro for declarative command handling.
Checks if a message exists, contains text, and starts with the specified command.

# Arguments
- `command`: The string command to match (e.g., "/start").
- `msg`: The JSON message object from Telegram.
- `body`: The code block to execute if the command matches.

# Examples
```julia
run_bot() do msg
    @bot_command "/help" msg begin
        sendMessage(text="I can echo your messages!")
    end
end
```
"""
macro bot_command(command, msg, body)
    return quote
        if haskey($(esc(msg)), :message) && haskey($(esc(msg)).message, :text)
            text = $(esc(msg)).message.text
            if startswith(text, $command)
                $(esc(body))
            end
        end
    end
end

"""
    run_bot(f::Function, [tg::TelegramClient]; timeout = 20, brute_force_alive = false, offset = -1)

The main polling loop for Telegram Bots. 
It repeatedly calls `getUpdates` and executes the function `f` for each new message.

# Arguments
- `f`: The callback function. Receives a [Update](https://core.telegram.org/bots/api#update) as a JSON3 object.
- `tg`: Optional TelegramClient. Uses the global client if not provided.
- `timeout`: Long-polling timeout in seconds.
- `brute_force_alive`: If true, periodically calls `getMe` to keep the connection alive (Experimental).
- `offset`: Starting update ID to retrieve. Useful for recovery after crashes.

# Examples
```julia
run_bot() do msg
    @info "New message!" msg
    @bot_command "/ping" msg sendMessage(text="pong")
end
```
"""
function run_bot(f, tg::TelegramClient = DEFAULT_OPTS.client; timeout = 20, brute_force_alive = false, offset = -1)
