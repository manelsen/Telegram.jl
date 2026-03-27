#!/usr/bin/env julia
"""
Script para coletar fixtures de INTERAÇÃO com botões
"""

using Telegram, Telegram.API
using JSON3

token = get(ENV, "TELEGRAM_BOT_TOKEN", "")
if isempty(token)
    error("Defina TELEGRAM_BOT_TOKEN")
end

FIXTURES_DIR = joinpath(@__DIR__, "..", "test", "fixtures")
mkpath(FIXTURES_DIR)

println("Conectando...")
tg = TelegramClient(token; use_globally=false, enable_traceability=false)
me = getMe(tg)
println("OK @$(me.username)")

function salvar(nome, dados)
    path = joinpath(FIXTURES_DIR, "$nome.json")
    open(path, "w") do io
        JSON3.pretty(io, dados)
    end
    println("  salvo: $nome.json")
end

# Detectar chat_id
println("\nDetectando chat_id...")
println("ENVIE UMA MENSAGEM PARA O BOT!")

chat_id = nothing
for i in 1:60
    try
        for u in getUpdates(tg, timeout=1, offset=-1)
            if haskey(u, :message)
                global chat_id = u.message.chat.id
                println("  OK: $chat_id")
                salvar("getChat", u.message.chat)
                break
            end
        end
    catch e
    end
    sleep(0.5)
    chat_id !== nothing && break
end

chat_id === nothing && error("Chat nao detectado!")

# ============================================================================
# 1. INLINE KEYBOARD
# ============================================================================
println("\n=== INLINE KEYBOARD ===")
println("Enviando...")

try
    msg = sendMessage(tg;
        text="Clique em um botao:",
        reply_markup=Dict(
            "inline_keyboard" => [
                [Dict("text" => "Opcao A", "callback_data" => "choice_a")],
                [Dict("text" => "Opcao B", "callback_data" => "choice_b")],
                [Dict("text" => "Google", "url" => "https://google.com")]
            ]
        ),
        chat_id=chat_id
    )
    salvar("sendMessage_InlineKeyboard", msg)
    println("  OK! Clique em A ou B no Telegram")
catch e
    println("  ERRO: $e")
end

# ============================================================================
# 2. REPLY KEYBOARD
# ============================================================================
println("\n=== REPLY KEYBOARD ===")
println("Enviando...")

try
    msg = sendMessage(tg;
        text="Use o teclado:",
        reply_markup=Dict(
            "keyboard" => [
                [Dict("text" => "Gostei")],
                [Dict("text" => "Nao gostei")]
            ],
            "resize_keyboard" => true,
            "one_time_keyboard" => true
        ),
        chat_id=chat_id
    )
    salvar("sendMessage_ReplyKeyboard", msg)
    println("  OK!")
catch e
    println("  ERRO: $e")
end

# ============================================================================
# 3. AGUARDAR INTERACOES
# ============================================================================
println("\n=== AGUARDANDO INTERACOES (90s) ===")
println("Acoes: clique botoes, edite msgs, reaja")

getUpdates(tg, offset=-1, limit=1)
captured = []
last_offset = -1

for i in 1:180
    try
        for u in getUpdates(tg, timeout=1, offset=last_offset)
            global last_offset = u.update_id + 1
            
            if haskey(u, :callback_query)
                cb = u.callback_query
                println("  callback: $(cb.data)")
                push!(captured, u)
                salvar("callbackQuery_$(cb.data)", cb)
                
                # Responder callback
                try
                    answerCallbackQuery(tg; callback_query_id=cb.id, text="Escolheu: $(cb.data)")
                catch e
                end
                
            elseif haskey(u, :edited_message)
                println("  edited_message")
                push!(captured, u)
                
            elseif haskey(u, :message_reaction)
                println("  reaction")
                push!(captured, u)
                
            elseif haskey(u, :poll_answer)
                println("  poll_answer")
                push!(captured, u)
            end
        end
    catch e
    end
    sleep(0.5)
end

if !isempty(captured)
    salvar("getUpdates_Interactive2", captured)
end

# ============================================================================
# RESULTADO
# ============================================================================
println("\n=== PRONTO ===")
for f in sort(readdir(FIXTURES_DIR))
    sz = filesize(joinpath(FIXTURES_DIR, f)) ÷ 1024
    println("  $f ($sz KB)")
end
