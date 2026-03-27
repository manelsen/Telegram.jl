using Telegram, Telegram.API
using JSON3
using ConfigEnv
using Dates

# Carrega credenciais do .env
dotenv()

const FIXTURES_DIR = joinpath(@__DIR__, "..", "test", "fixtures")
mkpath(FIXTURES_DIR)

function save_fixture(method, result)
    path = joinpath(FIXTURES_DIR, "$method.json")
    open(path, "w") do io
        JSON3.write(io, result)
    end
    println("✓ Fixture salva: $method")
end

token = get(ENV, "TELEGRAM_BOT_TOKEN", "")
chat_id = get(ENV, "TELEGRAM_BOT_CHAT_ID", "")

if isempty(token) || isempty(chat_id)
    error("Configurações incompletas no .env (TOKEN ou CHAT_ID).")
end

tg = TelegramClient(token; chat_id=chat_id)

println("--- INICIANDO CAPTURA DE ALTA COBERTURA ---")

# --- 1. METADADOS E INFO ---
println("\n[1/5] Metadados...")
save_fixture("getMe", getMe())
save_fixture("getChat", getChat(chat_id=chat_id))
save_fixture("getWebhookInfo", getWebhookInfo())
save_fixture("getMyCommands", getMyCommands())
save_fixture("getMyName", getMyName())
save_fixture("getMyDescription", getMyDescription())
save_fixture("getMyShortDescription", getMyShortDescription())

# --- 2. MENSAGENS E FORMATAÇÃO ---
println("\n[2/5] Mensagens e Formatação...")
save_fixture("sendMessage_Markdown", sendMessage(text="*Bold* _Italic_ `Code` [Link](https://julia.org)", parse_mode="MarkdownV2"))
save_fixture("sendMessage_HTML", sendMessage(text="<b>Bold</b> <i>Italic</i> <pre>Code</pre>", parse_mode="HTML"))

# --- 3. MÍDIAS (UPLOADS) ---
println("\n[3/5] Mídias (Uploads)...")

# Criando dummy assets para teste de upload
dummy_text = IOBuffer("Conteudo de teste para fixture")
save_fixture("sendDocument", sendDocument(document="test.txt" => dummy_text, caption="Document Fixture"))

# Dice/Dados (Eventos aleatórios da API)
for emoji in ["🎲", "🎯", "🏀", "⚽", "🎳", "🎰"]
    save_fixture("sendDice_$emoji", sendDice(emoji=emoji))
end

# --- 4. INTERATIVIDADE E GESTÃO ---
println("\n[4/5] Interatividade e Gestão...")
save_fixture("sendPoll", sendPoll(question="Qual sua versão de Julia favorita?", options=["1.0", "1.6 (LTS)", "1.10 (LTS)", "Nightly"], is_anonymous=false))
save_fixture("sendLocation", sendLocation(latitude=-23.5505, longitude=-46.6333)) # SP
save_fixture("sendContact", sendContact(phone_number="+551199999999", first_name="Julia", last_name="Bot"))

# --- 5. MODO DE CAPTURA DE EVENTOS RAROS (INTERATIVO) ---
println("\n[5/5] MODO INTERATIVO: Capturando Updates Reais")
println("LIMPANDO UPDATES ANTIGOS...")
getUpdates(offset=-1, limit=1) # Confirma todos os anteriores

println("Aguardando 60 segundos. Por favor, faça o seguinte no Telegram AGORA:")
println("1. Envie uma mensagem de texto.")
println("2. REAJA (Emoji) a uma mensagem do bot.")
println("3. EDITE uma das suas mensagens.")
println("4. RESPONDA à enquete que o bot enviou.")
println("5. ENVIE sua localização ou um áudio.")

start_time = now()
captured_updates = []
current_offset = -1
while (now() - start_time) < Second(60)
    # Pedimos explicitamente por todos os tipos de updates interessantes
    allowed = ["message", "edited_message", "message_reaction", "message_reaction_count", "poll", "poll_answer", "callback_query", "chat_member"]
    updates = current_offset == -1 ? getUpdates(timeout=5, allowed_updates=allowed) : getUpdates(timeout=5, offset=current_offset, allowed_updates=allowed)
    for u in updates
        global current_offset = u.update_id + 1
        push!(captured_updates, u)
        
        # Identifica o tipo de update para o log
        type = "unknown"
        for k in keys(u)
            if k != :update_id
                type = string(k)
                break
            end
        end
        println("  -> [$(now())] Capturado: $type (ID: $(u.update_id))")
    end
    sleep(0.2)
end

if !isempty(captured_updates)
    save_fixture("getUpdates_Collection", captured_updates)
    println("✓ Coleção de $(length(captured_updates)) updates reais salva.")
end

println("\n--- PROCESSO CONCLUÍDO ---")
println("As fixtures foram geradas. Agora você pode atualizar o TestHelpers.jl para usá-las.")
