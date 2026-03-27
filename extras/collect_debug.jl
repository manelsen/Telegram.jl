#!/usr/bin/env julia
"""
Script para coletar callbacks e interacoes
"""

using Telegram, Telegram.API
using JSON3

token = get(ENV, "TELEGRAM_BOT_TOKEN", "")
if isempty(token)
    error("Defina TELEGRAM_BOT_TOKEN")
end

FIXTURES_DIR = joinpath(@__DIR__, "..", "test", "fixtures")
mkpath(FIXTURES_DIR)

function salvar(nome, dados)
    path = joinpath(FIXTURES_DIR, "$nome.json")
    open(path, "w") do io
        JSON3.pretty(io, dados)
    end
    println("  SALVO: $nome.json")
end

println("Conectando...")
tg = TelegramClient(token; use_globally=false, enable_traceability=false)
println("OK: @$(getMe(tg).username)")

# Detectar chat_id
println("\n[1] Detectando chat_id...")
println("ENVIE MSG PARA O BOT!")
chat_id = nothing

for i in 1:60
    try
        for u in getUpdates(tg, timeout=1, offset=-1)
            if haskey(u, :message)
                global chat_id = u.message.chat.id
                println("  CHAT: $chat_id")
                salvar("getChat", u.message.chat)
                break
            end
        end
    catch e
        # timeout
    end
    sleep(0.5)
    chat_id !== nothing && break
end

chat_id === nothing && error("Chat nao detectado!")

# Enviar inline keyboard
println("\n[2] Enviando inline keyboard...")
try
    msg = sendMessage(tg;
        text="CLIQUE NOS BOTOES!",
        reply_markup=Dict(
            "inline_keyboard" => [
                [Dict("text" => "A", "callback_data" => "choice_a")],
                [Dict("text" => "B", "callback_data" => "choice_b")]
            ]
        ),
        chat_id=chat_id
    )
    salvar("sendMessage_InlineKeyboard", msg)
    println("  BOTOES ENVIADOS! CLIQUE AGORA!")
catch e
    println("  ERRO: $e")
end

# Aguardar interacoes
println("\n[3] Aguardando interacoes (60s)...")

getUpdates(tg, offset=-1, limit=1)  # limpar

all_updates = []
callbacks = []
last_offset = -1
start = time()

for i in 1:120
    elapsed = round(Int, time() - start)
    remaining = 60 - elapsed
    print("\r  Tempo: $elapsed s | Remaining: $remaining s | Updates: $(length(all_updates))    ")
    
    try
        updates = getUpdates(tg, timeout=1, offset=last_offset)
        
        for u in updates
            global last_offset = u.update_id + 1
            push!(all_updates, u)
            
            # Debug: mostrar tipo
            tipo = "?"
            if haskey(u, :callback_query)
                tipo = "CALLBACK"
                push!(callbacks, u.callback_query)
            elseif haskey(u, :edited_message)
                tipo = "EDITED"
            elseif haskey(u, :message_reaction)
                tipo = "REACTION"
            elseif haskey(u, :message)
                msg = u.message
                if haskey(msg, :callback_data)  # shouldn't exist
                    tipo = "MSG_CALLBACK"
                elseif haskey(msg, :location)
                    tipo = "LOCATION"
                elseif haskey(msg, :contact)
                    tipo = "CONTACT"
                elseif haskey(msg, :poll)
                    tipo = "POLL"
                else
                    tipo = "MSG"
                end
            end
            println("\n  >> $tipo (offset=$last_offset)")
        end
        
    catch e
        # timeout normal
    end
    
    sleep(0.5)
    
    if time() - start >= 60
        break
    end
end

println("\n")

# Salvar tudo
salvar("getUpdates_All", all_updates)
if !isempty(callbacks)
    salvar("callbacks", callbacks)
    println("  $(length(callbacks)) callbacks!")
else
    println("  NENHUM CALLBACK CAPTURADO!")
end

# Mostrar o que temos
println("\n=== RESULTADO ===")
for f in sort(readdir(FIXTURES_DIR))
    sz = filesize(joinpath(FIXTURES_DIR, f))
    println("  $f ($(sz) bytes)")
end
