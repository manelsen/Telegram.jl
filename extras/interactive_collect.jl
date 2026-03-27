#!/usr/bin/env julia
"""
Script Interativo de Coleta de Fixtures do Telegram

Este script guia você passo a passo na coleta de respostas reais da API do Telegram.
Cada etapa explica o que vai acontecer e como interagir com o bot para gerar o dado.

Uso:
    julia --project=extras extras/interactive_collect.jl

Pré-requisitos:
    1. Tenha um bot do Telegram configurado no @BotFather
    2. Defina TELEGRAM_BOT_TOKEN no .env
    3. Inicie uma conversa com seu bot no Telegram
    4. O chat_id será detectado automaticamente nas primeiras chamadas

Fluxo:
    1. Coleta de METADADOS (sem interação)
    2. Coleta de MENSAGENS (você envia mensagens)
    3. Coleta de MÍDIA (você envia fotos, documentos, etc.)
    4. Coleta de INTERATIVIDADE (você cria polls, reações, etc.)
    5. Coleta de UPDATES (você envia diferentes tipos de conteúdo)
"""

using Telegram, Telegram.API
using JSON3
using Dates
using ConfigEnv

# Carrega variáveis de ambiente
dotenv()

const FIXTURES_DIR = joinpath(@__DIR__, "..", "test", "fixtures")
const DEMO_CHAT_ID = "12345678"  # Placeholder para quando não temos chat_id real

# ============================================================================
# Utilitários de UI
# ============================================================================

function print_header(title::String)
    println("\n" * "="^60)
    println("  $title")
    println("="^60)
end

function print_step(step::Int, total::Int, description::String)
    println("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    println("  📋 ETAPA $step/$total: $description")
    println("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end

function print_instruction(text::String)
    println("\n  💡 INSTRUÇÃO:")
    println("     $text")
end

function print_success(text::String)
    println("  ✅ $text")
end

function print_warning(text::String)
    println("  ⚠️  $text")
end

function print_error(text::String)
    println("  ❌ $text")
end

function esperar_confirmacao(msg::String = "Pressione ENTER para continuar...")
    println("\n  └─ $msg")
    readline(stdin)
end

function pular_etapa?()::Bool
    print("\n  └─ Pular esta etapa? (s/n) [n]: ")
    resposta = strip(readline(stdin))
    return resposta in ["s", "S", "sim", "Sim", "SIM"]
end

# ============================================================================
# Utilitários de Coleta
# ============================================================================

function salvar_fixture(nome::String, dados)
    path = joinpath(FIXTURES_DIR, "$nome.json")
    
    # Anonimiza os dados antes de salvar
    dados_anonimos = anonimizar(dados)
    
    open(path, "w") do io
        JSON3.pretty(io, dados_anonimos)
    end
    
    return path
end

function anonimizar(obj)
    """Substitui dados sensíveis por placeholders anônimos."""
    return _anonimizar_recursivo(obj)
end

function _anonimizar_recursivo(obj)
    if obj isa AbstractDict
        new_dict = Dict{Symbol, Any}()
        for (k, v) in obj
            k_sym = Symbol(k)
            if k in ["id", "chat_id", "user_id", "message_id"]
                new_dict[k_sym] = 12345678
            elseif k in ["first_name", "firstName"]
                new_dict[k_sym] = "AnonymizedUser"
            elseif k in ["last_name", "lastName"]
                new_dict[k_sym] = "Name"
            elseif k in ["username"]
                new_dict[k_sym] = "anonymized_bot"
            elseif k in ["title"]
                new_dict[k_sym] = "Anonymized Chat Title"
            elseif k in ["text", "caption"]
                new_dict[k_sym] = "Anonymized message content"
            elseif k in ["phone_number", "phoneNumber"]
                new_dict[k_sym] = "+5511999999999"
            elseif k in ["latitude"]
                new_dict[k_sym] = 0.0
            elseif k in ["longitude"]
                new_dict[k_sym] = 0.0
            elseif k in ["file_id", "fileId"]
                new_dict[k_sym] = "FILE_ID_ANONYMIZED_REDACTED"
            elseif k in ["file_unique_id", "fileUniqueId"]
                new_dict[k_sym] = "FILE_UNIQUE_ID_REDACTED"
            elseif k in ["address", "vcard"]
                new_dict[k_sym] = "Anonymized Data"
            elseif k in ["url", "link"]
                new_dict[k_sym] = "https://example.com/anonymized"
            else
                new_dict[k_sym] = _anonimizar_recursivo(v)
            end
        end
        return new_dict
    elseif obj isa AbstractArray
        return [_anonimizar_recursivo(item) for item in obj]
    else
        return obj
    end
end

# ============================================================================
# ETAPAS DE COLETA
# ============================================================================

function etapa_metadados(tg::TelegramClient)
    """Coleta informações básicas do bot sem interação do usuário."""
    print_step(1, 5, "METADADOS DO BOT")
    print_instruction("Esta etapa coleta informações sobre seu bot.")
    println("  Não é necessária nenhuma interação com o Telegram.")
    
    if pular_etapa?()
        print_warning("Etapa pulada.")
        return
    end
    
    esperar_confirmacao("Pressione ENTER para coletar metadados...")
    
    # getMe - Informações do bot
    print("\n  Coletando getMe... ")
    try
        me = getMe()
        salvar_fixture("getMe", me)
        print_success("getMe ✓")
    catch e
        print_error("Falhou: $e")
    end
    
    # getMyName - Nome configurado do bot
    print("\n  Coletando getMyName... ")
    try
        nome = getMyName()
        salvar_fixture("getMyName", nome)
        print_success("getMyName ✓")
    catch e
        print_error("Falhou: $e")
    end
    
    # getMyDescription - Descrição do bot
    print("\n  Coletando getMyDescription... ")
    try
        desc = getMyDescription()
        salvar_fixture("getMyDescription", desc)
        print_success("getMyDescription ✓")
    catch e
        print_error("Falhou: $e")
    end
    
    # getMyShortDescription - Descrição curta
    print("\n  Coletando getMyShortDescription... ")
    try
        short_desc = getMyShortDescription()
        salvar_fixture("getMyShortDescription", short_desc)
        print_success("getMyShortDescription ✓")
    catch e
        print_error("Falhou: $e")
    end
    
    # getMyCommands - Comandos configurados
    print("\n  Coletando getMyCommands... ")
    try
        comandos = getMyCommands()
        salvar_fixture("getMyCommands", comandos)
        print_success("getMyCommands ✓")
    catch e
        print_error("Falhou: $e")
    end
    
    # getWebhookInfo - Status do webhook
    print("\n  Coletando getWebhookInfo... ")
    try
        webhook = getWebhookInfo()
        salvar_fixture("getWebhookInfo", webhook)
        print_success("getWebhookInfo ✓")
    catch e
        print_error("Falhou: $e")
    end
    
    print_success("\nMetadados coletados com sucesso!")
end

function etapa_mensagens_simples(tg::TelegramClient)
    """Coleta exemplos de mensagens de texto."""
    print_step(2, 5, "MENSAGENS DE TEXTO")
    print_instruction("""
    Você vai enviar mensagens de texto para o bot.
    O script coletará cada tipo de mensagem que você enviar.
    """)
    
    if pular_etapa?()
        print_warning("Etapa pulada.")
        return
    end
    
    esperar_confirmacao("Pressione ENTER quando estiver pronto para enviar mensagens...")
    
    # Limpa updates pendentes
    try
        getUpdates(offset=-1, limit=1)
    catch
    end
    
    println("\n  📱 Aguardando mensagens (60 segundos)...")
    println("  └─ Envie diferentes tipos de mensagens:")
    println("       • Texto simples")
    println("       • Mensagem com link (https://)")
    println("       • Mensagem mencionando @outrobot")
    println("")
    
    captured = []
    start_time = now()
    last_offset = -1
    
    while (now() - start_time) < Second(60)
        try
            updates = getUpdates(timeout=5, offset=last_offset)
            for u in updates
                if haskey(u, :message) && haskey(u.message, :text)
                    push!(captured, u)
                    last_offset = u.update_id + 1
                    print_success("📝 Mensagem capturada: '$(u.message.text)'")
                end
            end
        catch e
            # Timeout é esperado
        end
        sleep(0.5)
    end
    
    if !isempty(captured)
        salvar_fixture("getUpdates_Messages", captured)
        print_success("\n$(length(captured)) mensagens capturadas!")
    else
        print_warning("Nenhuma mensagem capturada.")
    end
end

function etapa_midia(tg::TelegramClient)
    """Coleta exemplos de mídia (foto, documento, etc.)."""
    print_step(3, 5, "MÍDIA (FOTOS, DOCUMENTOS, ÁUDIO)")
    print_instruction("""
    Você vai enviar diferentes tipos de mídia para o bot.
    O script coletará as respostas da API para cada tipo.
    """)
    
    if pular_etapa?()
        print_warning("Etapa pulada.")
        return
    end
    
    esperar_confirmacao("Pressione ENTER quando estiver pronto para enviar mídia...")
    
    # Limpa updates pendentes
    try
        getUpdates(offset=-1, limit=1)
    catch
    end
    
    println("\n  📱 Aguardando mídia (90 segundos)...")
    println("  └─ Envie para o bot:")
    println("       1. Uma foto")
    println("       2. Um documento")
    println("       3. Um arquivo de áudio")
    println("       4. Uma nota de voz")
    println("       5. Um vídeo")
    println("       6. Um arquivo GIF/animação")
    println("")
    
    captured = []
    start_time = now()
    last_offset = -1
    
    media_types = [:photo, :document, :audio, :voice, :video, :animation]
    
    while (now() - start_time) < Second(90)
        try
            updates = getUpdates(timeout=5, offset=last_offset)
            for u in updates
                if haskey(u, :message)
                    msg = u.message
                    for media_type in media_types
                        if haskey(msg, media_type)
                            push!(captured, (type=media_type, message=msg))
                            last_offset = u.update_id + 1
                            print_success("📎 $(media_type) capturado!")
                            break
                        end
                    end
                end
            end
        catch e
            # Timeout é esperado
        end
        sleep(0.5)
    end
    
    if !isempty(captured)
        # Salva cada tipo separadamente
        for (type, msg) in captured
            fixture_name = "sendMedia_$(type)"
            salvar_fixture(fixture_name, msg)
        end
        print_success("\n$(length(captured)) tipos de mídia capturados!")
    else
        print_warning("Nenhuma mídia capturada.")
    end
end

function etapa_interativo(tg::TelegramClient)
    """Coleta elementos interativos (polls, localizações, etc.)."""
    print_step(4, 5, "ELEMENTOS INTERATIVOS")
    print_instruction("""
    Você vai criar elementos interativos para o bot.
    """)
    
    if pular_etapa?()
        print_warning("Etapa pulada.")
        return
    end
    
    esperar_confirmacao("Pressione ENTER quando estiver pronto...")
    
    # Limpa updates pendentes
    try
        getUpdates(offset=-1, limit=1)
    catch
    end
    
    println("\n  📱 Aguardando elementos interativos (90 segundos)...")
    println("  └─ Crie/envie para o bot:")
    println("       1. Uma localização")
    println("       2. Um contato")
    println("       3. Vote ou crie uma enquete")
    println("       4. Reaja (com emoji) a uma mensagem do bot")
    println("       5. Edite uma mensagem que você enviou")
    println("       6. Envie um sticker")
    println("")
    
    captured = []
    start_time = now()
    last_offset = -1
    
    interactive_types = [:location, :contact, :poll, :venue, :sticker, :message_reaction, :edited_message]
    
    while (now() - start_time) < Second(90)
        try
            updates = getUpdates(timeout=5, offset=last_offset)
            for u in updates
                for int_type in interactive_types
                    if haskey(u, int_type)
                        push!(captured, (type=int_type, update=u))
                        last_offset = u.update_id + 1
                        print_success("🎯 $(int_type) capturado!")
                        break
                    end
                end
            end
        catch e
            # Timeout é esperado
        end
        sleep(0.5)
    end
    
    if !isempty(captured)
        salvar_fixture("getUpdates_Interactive", captured)
        print_success("\n$(length(captured)) elementos interativos capturados!")
    else
        print_warning("Nenhum elemento interativo capturado.")
    end
end

function etapa_updates_completos(tg::TelegramClient)
    """Coleta uma coleção abrangente de todos os tipos de updates."""
    print_step(5, 5, "COLEÇÃO COMPLETA DE UPDATES")
    print_instruction("""
    Modo livre! Aguardaremos 2 minutos para você enviar/acionar
    qualquer tipo de update que quiser capturar.
    
    Ideias do que você pode fazer:
    - Encaminhar mensagens de outros chats
    - Criar um topic em grupo (se tiver permissão)
    - Fazer uma chamada de voz/vídeo (será detectado como update)
    - Usar comandos do bot (se configurados)
    - Enviar mensagens de teste em sequência
    """)
    
    if pular_etapa?()
        print_warning("Etapa pulada.")
        return
    end
    
    esperar_confirmacao("Pressione ENTER para iniciar captura livre...")
    
    # Limpa updates pendentes
    try
        getUpdates(offset=-1, limit=1)
    catch
    end
    
    println("\n  ⏱️  Captura livre iniciada (2 minutos)...")
    println("  └─ Faça o que quiser no Telegram! (")
    
    captured = []
    start_time = now()
    last_offset = -1
    
    while (now() - start_time) < Second(120)
        try
            updates = getUpdates(timeout=5, offset=last_offset)
            for u in updates
                push!(captured, u)
                last_offset = u.update_id + 1
                
                # Identifica o tipo
                update_type = "unknown"
                for k in keys(u)
                    if k != :update_id
                        update_type = string(k)
                        break
                    end
                end
                print("  → $update_type ")
            end
        catch e
            # Timeout é esperado
        end
        sleep(0.5)
        
        # Progresso
        elapsed = (now() - start_time).value ÷ 1000
        remaining = 120 - elapsed
        print("\r  ⏱️  $(remaining)s restantes...                                     ")
    end
    
    println("\n")
    
    if !isempty(captured)
        salvar_fixture("getUpdates_Collection", captured)
        print_success("$(length(captured)) updates capturados na coleção completa!")
    else
        print_warning("Nenhum update capturado.")
    end
end

# ============================================================================
# SCRIPT PRINCIPAL
# ============================================================================

function main()
    println("""
    ╔══════════════════════════════════════════════════════════════════════╗
    ║           📸 COLETA INTERATIVA DE FIXTURES DO TELEGRAM              ║
    ╚══════════════════════════════════════════════════════════════════════╝
    
    Este script vai guiá-lo através de 5 etapas de coleta de fixtures.
    
    Para cada etapa, você terá a opção de:
    - Pular (se não quiser coletar aquele tipo)
    - Ver instruções detalhadas do que fazer no Telegram
    
    Dados coletados serão salvos em: test/fixtures/
    Todos os dados pessoais serão anonimizados automaticamente.
    """)
    
    # Verifica credenciais
    token = get(ENV, "TELEGRAM_BOT_TOKEN", "")
    if isempty(token)
        print_error("ERRO: TELEGRAM_BOT_TOKEN não encontrado!")
        println("""
        
        Configure seu .env com:
            TELEGRAM_BOT_TOKEN=seu_token_aqui
        
        Você pode obter um token em @BotFather no Telegram.
        """)
        return 1
    end
    
    println("  ✓ Token encontrado: $(token[1:min(end,10)])...")
    
    # Detecta chat_id automaticamente
    println("\n  🔍 Detectando chat_id automaticamente...")
    try
PQ:        tg = TelegramClient(token; use_globally=false, enable_traceability=false)
        # Faz uma chamada dummy para detectar chat
        me = getMe(tg)
        print_success("Bot conectado: @$(me.username)")
    catch e
        print_error("Erro ao conectar: $e")
        println("""
        
        Verifique se:
        1. O token está correto
        2. Você iniciou uma conversa com o bot no Telegram
        """)
        return 1
    end
    
    # Garante que o diretório de fixtures existe
    mkpath(FIXTURES_DIR)
    
    # Executa as etapas
    esperar_confirmacao("\nPressione ENTER para começar a coleta...")
    
    etapa_metadados(tg)
    etapa_mensagens_simples(tg)
    etapa_midia(tg)
    etapa_interativo(tg)
    etapa_updates_completos(tg)
    
    # Resumo final
    print_header("COLETA CONCLUÍDA!")
    
    println("\n  📁 Fixtures salvas em: $FIXTURES_DIR")
    println("\n  Arquivos coletados:")
    
    arquivos = sort(readdir(FIXTURES_DIR))
    for arq in arquivos
        size = filesize(joinpath(FIXTURES_DIR, arq))
        println("     • $arq ($(div(size, 1024))KB)")
    end
    
    println("""
    
    ┌─────────────────────────────────────────────────────────────────────┐
    │  PRÓXIMOS PASSOS                                                     │
    ├─────────────────────────────────────────────────────────────────────┤
    │  1. Revise os fixtures em test/fixtures/                            │
    │  2. Execute os testes: julia --project=. -e 'using Pkg; Pkg.test()' │
    │  3. Commit as mudanças: git add test/fixtures/ && git commit       │
    └─────────────────────────────────────────────────────────────────────┘
    """)
    
    return 0
end

# Executa
exit(main())
