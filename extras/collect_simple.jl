#!/usr/bin/env julia
"""
Script para Coletar Fixtures do Telegram

Uso:
    export TELEGRAM_BOT_TOKEN="seu_token_aqui"
    julia --project=. extras/collect_simple.jl
"""

using Telegram, Telegram.API
using JSON3
using Dates

token = get(ENV, "TELEGRAM_BOT_TOKEN", "")
if isempty(token)
    error("Defina TELEGRAM_BOT_TOKEN no ambiente")
end

FIXTURES_DIR = joinpath(@__DIR__, "..", "test", "fixtures")
mkpath(FIXTURES_DIR)

println("🔗 Conectando ao bot...")
tg = TelegramClient(token; use_globally=false, enable_traceability=false)
me = getMe(tg)
println("✅ Conectado: @$(me.username) (ID: $(me.id))")

function salvar(nome, dados)
    path = joinpath(FIXTURES_DIR, "$nome.json")
    open(path, "w") do io
        JSON3.pretty(io, dados)
    end
    println("  ✅ $nome.json")
end

# ETAPA 1: METADADOS
println("\n📋 ETAPA 1: METADADOS")
println("─"^60)
try salvar("getMe", getMe(tg)) catch e println("  ⚠️ getMe") end
try salvar("getMyName", getMyName(tg)) catch e println("  ⚠️ getMyName") end
try salvar("getMyCommands", getMyCommands(tg)) catch e println("  ⚠️ getMyCommands") end
try salvar("getMyDescription", getMyDescription(tg)) catch e println("  ⚠️ getMyDescription") end
try salvar("getMyShortDescription", getMyShortDescription(tg)) catch e println("  ⚠️ getMyShortDescription") end
try salvar("getWebhookInfo", getWebhookInfo(tg)) catch e println("  ⚠️ getWebhookInfo") end

# ETAPA 2: DETECTAR CHAT_ID
println("\n📋 ETAPA 2: DETECTAR CHAT_ID")
println("─"^60)
println("\n💡 ENVIE UMA MENSAGEM PARA O BOT!\n")

chat_id_detectado = nothing
last_offset = -1

for i in 1:60
    try
        updates = getUpdates(tg, timeout=1, offset=last_offset)
        for u in updates
            if haskey(u, :message)
                global chat_id_detectado = u.message.chat.id
                global last_offset = u.update_id + 1
                println("  ✅ Chat ID: $chat_id_detectado ($(u.message.chat.type))")
                salvar("getChat", u.message.chat)
            end
        end
    catch e
        # timeout normal
    end
    sleep(0.5)
end

if chat_id_detectado === nothing
    error("Não detectou chat_id. Envie mensagem para o bot!")
end

# ETAPA 3: ENVIAR MENSAGENS
println("\n📋 ETAPA 3: MENSAGENS DE TESTE")
println("─"^60)
try
    msg = sendMessage(tg; text="Teste de fixture.", chat_id=chat_id_detectado)
    salvar("sendMessage", msg)
catch e
    println("  ⚠️  sendMessage: $e")
end

try
    msg = sendMessage(tg; text="<b>Bold</b> <i>Italic</i>", parse_mode="HTML", chat_id=chat_id_detectado)
    salvar("sendMessage_HTML", msg)
catch e
    println("  ⚠️  sendMessage_HTML")
end

# ETAPA 4: MÍDIA
println("\n📋 ETAPA 4: MÍDIA")
println("─"^60)
println("\n💡 Envie foto, documento, áudio!\n")

getUpdates(tg, offset=-1, limit=1)
captured = []
last_offset = -1

for i in 1:120
    try
        for u in getUpdates(tg, timeout=1, offset=last_offset)
            msg = get(u, :message, nothing)
            if msg !== nothing
                for tipo in [:photo, :document, :audio, :voice, :video, :animation, :sticker]
                    if haskey(msg, tipo)
                        push!(captured, msg)
                        global last_offset = u.update_id + 1
                        println("  📎 $tipo")
                        break
                    end
                end
            end
        end
    catch e
    end
    sleep(0.5)
end

if !isempty(captured)
    salvar("getUpdates_Media", captured)
else
    println("  ⚠️  Nenhuma mídia")
end

# ETAPA 5: INTERATIVO
println("\n📋 ETAPA 5: INTERATIVO")
println("─"^60)
println("\n💡 Localização, contato, poll, reação!\n")

getUpdates(tg, offset=-1, limit=1)
captured = []
last_offset = -1

for i in 1:120
    try
        for u in getUpdates(tg, timeout=1, offset=last_offset)
            # Check direct update types
            for tipo in [:location, :contact, :venue, :poll, :message_reaction, :edited_message, :callback_query]
                if haskey(u, tipo)
                    push!(captured, u)
                    global last_offset = u.update_id + 1
                    println("  🎯 $tipo")
                    break
                end
            end
            
            # Check message.* types
            msg = get(u, :message, nothing)
            if msg !== nothing
                for tipo in [:location, :contact, :venue, :poll]
                    if haskey(msg, tipo)
                        push!(captured, u)
                        global last_offset = u.update_id + 1
                        println("  🎯 message.$tipo")
                        break
                    end
                end
            end
        end
    catch e
    end
    sleep(0.5)
end

if !isempty(captured)
    salvar("getUpdates_Interactive", captured)
else
    println("  ⚠️  Nenhum interativo")
end

# RESULTADO
println("\n" * "="^60)
println("✅ COLETA CONCLUÍDA!")
println("="^60)
println("\n📁 Arquivos em: $FIXTURES_DIR")
for f in sort(readdir(FIXTURES_DIR))
    sz = filesize(joinpath(FIXTURES_DIR, f)) ÷ 1024
    println("   • $f ($sz KB)")
end
