"""
    run_bot(f::Function, [tg::TelegramClient]; timeout = 10, brute_force_alive = false, offset = -1)

Run telegram bot, which executes function `f` repeatedly.

# Arguments

- `f`: function to run with the bot. As an input it receive [Message](https://core.telegram.org/bots/api#message) in the form of JSON3 object.
- `tg`: Telegram client, if not set then global telegram client is used.
- `timeout`: timeout limit of messages, defines when longpoll messages should be interrupted
- `brute_force_alive`: despite all measures, messages sometimes "hangs". You may use this argument to wake up telegram server regularly. When this option is set to `true` it works, but it is not recommended, since it makes additional calls. Consider this feature experimental and use at your own risk.
- `offset`: telegram message offset, useful if you have processed messages, but bot was interrupted and messages state was lost.
"""
function run_bot(f, tg::TelegramClient = DEFAULT_OPTS.client; timeout = 20, brute_force_alive = false, offset = -1)
    running = Ref(true)
    if brute_force_alive
        @async while running[]
            try
                getMe(tg)
            catch err
                err isa InterruptException && break
                @error err
            end
            # Also wait after failures, so an unavailable server is not hammered.
            running[] && sleep(max(1, timeout ÷ 2))
        end
    end

    retry_delay = 1.0
    try
        while running[]
            try
                ignore_errors = true
                res = offset == -1 ? getUpdates(tg, timeout = timeout) : (ignore_errors = false;getUpdates(tg, timeout = timeout, offset = offset) )
                for msg in res
                    try
                        f(msg)
                        offset = offset <= get(msg, :update_id, -1) ? get(msg, :update_id, -1) + 1 : offset
                    catch err
                        err isa InterruptException && rethrow()
                        @error err
                        if ignore_errors
                            offset = offset <= get(msg, :update_id, -1) ? get(msg, :update_id, -1) + 1 : offset
                        else
                            rethrow()
                        end
                    end
                end
                retry_delay = 1.0
            catch err
                if err isa InterruptException
                    break
                end
                @error err
                sleep(retry_delay)
                retry_delay = min(30.0, retry_delay * 2)
            end
        end
    finally
        running[] = false
    end
end
