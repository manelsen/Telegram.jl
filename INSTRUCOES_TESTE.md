# Instruções para Testar e Validar

## 🚀 Quick Start

### Pré-requisitos
- Julia 1.3 ou superior instalado
- Python 3 (opcional, para scripts de teste)

### Instalação

```bash
# Navegar para o repositório
cd /tmp/Telegram.jl

# Instalar dependências
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

### Executar Todos os Testes

```bash
julia --project=. -e 'using Pkg; Pkg.test()'
```

### Executar Apenas Testes de API 7.x

```bash
julia --project=. -e 'using Telegram, Telegram.API; include("test/test_api7x.jl")'
```

---

## 📋 Testes Disponíveis

### 1. Testes Unitários (`test/test_api7x.jl`)

**Cobertura:**
- ✅ Assinaturas de todos os 16 novos métodos
- ✅ Parâmetros obrigatórios dos novos métodos
- ✅ Parâmetros opcionais dos novos métodos
- ✅ Assinaturas dos 7 métodos atualizados
- ✅ Presença de novos parâmetros
- ✅ Contagem total de métodos na API

**Executar:**
```bash
julia --project=. -e 'using Telegram, Telegram.API; include("test/test_api7x.jl")'
```

### 2. Testes de Regressão

**Executar:**
```bash
julia --project=. -e 'using Pkg; Pkg.test()'
```

Isso executa todos os testes existentes no diretório `test/`.

### 3. Testes de Integração (Falta)

**Será criado:** `test/test_api7x_integration.jl`

**O que incluirá:**
- Mock da API do Telegram
- Testes de fluxos completos
- Testes de erros
- Testes de edge cases

---

## 🧪 Como Testar Manualmente

### Teste 1: Novos Métodos

```julia
using Telegram, Telegram.API

# Criar client
tg = Telegram.TelegramClient("YOUR_TOKEN"; chat_id = "YOUR_CHAT_ID")

# Testar getBusinessConnection
try
    result = getBusinessConnection(tg, business_connection_id = "conn_123")
    println("✅ getBusinessConnection: OK")
catch err
    println("⚠️  getBusinessConnection: $err")
end

# Testar refundStarPayment
try
    result = refundStarPayment(tg, user_id = 123456, telegram_payment_charge_id = "charge_123")
    println("✅ refundStarPayment: OK")
catch err
    println("⚠️  refundStarPayment: $err")
end

# Testar getStarTransactions
try
    result = getStarTransactions(tg, limit = 10)
    println("✅ getStarTransactions: OK")
catch err
    println("⚠️  getStarTransactions: $err")
end

# Testar sendPaidMedia
try
    result = sendPaidMedia(tg, chat_id = "123", star_count = 100,
        media = [Telegram.InputPaidMediaPhoto(photo = "photo_id")])
    println("✅ sendPaidMedia: OK")
catch err
    println("⚠️  sendPaidMedia: $err")
end

# Testar métodos com novos parâmetros
try
    result = sendMessage(tg, chat_id = "123", text = "Hello", message_effect_id = "effect_123")
    println("✅ sendMessage com message_effect_id: OK")
catch err
    println("⚠️  sendMessage com message_effect_id: $err")
end
```

### Teste 2: Métodos Atualizados

```julia
using Telegram, Telegram.API

# Criar client
tg = Telegram.TelegramClient("YOUR_TOKEN"; chat_id = "YOUR_CHAT_ID")

# Testar sendPhoto com novos parâmetros
try
    result = sendPhoto(tg, chat_id = "123", photo = "photo_id",
        caption = "Test", show_caption_above_media = true)
    println("✅ sendPhoto com show_caption_above_media: OK")
catch err
    println("⚠️  sendPhoto com show_caption_above_media: $err")
end

# Testar sendVideo com novos parâmetros
try
    result = sendVideo(tg, chat_id = "123", video = "video_id",
        duration = 10, cover = "cover_id")
    println("✅ sendVideo com cover e start_timestamp: OK")
catch err
    println("⚠️  sendVideo com cover e start_timestamp: $err")
end

# Testar createInvoiceLink com novo parâmetro
try
    result = createInvoiceLink(tg, title = "Test", description = "Test",
        payload = "test", currency = "XTR", prices = [Telegram.LabeledPrice(label = "Test", amount = 100)],
        subscription_period = 2592000)
    println("✅ createInvoiceLink com subscription_period: OK")
catch err
    println("⚠️  createInvoiceLink com subscription_period: $err")
end
```

### Teste 3: Métodos Existentes (Compatibilidade)

```julia
using Telegram, Telegram.API

# Criar client
tg = Telegram.TelegramClient("YOUR_TOKEN"; chat_id = "YOUR_CHAT_ID")

# Testar métodos antigos
try
    result = sendMessage(tg, chat_id = "123", text = "Hello")
    println("✅ sendMessage antigo: OK")
catch err
    println("⚠️  sendMessage antigo: $err")
end

try
    result = getMe(tg)
    println("✅ getMe antigo: OK")
catch err
    println("⚠️  getMe antigo: $err")
end
```

---

## 📊 Verificar Implementação

### Verificar que todos os métodos existem

```julia
using Telegram, Telegram.API

# Verificar contagem de métodos
println("Total de métodos: ", length(Telegram.API.TELEGRAM_API))

# Verificar métodos específicos
methods = [
    :getBusinessConnection,
    :refundStarPayment,
    :getStarTransactions,
    :sendPaidMedia,
    :createChatSubscriptionInviteLink,
    :editChatSubscriptionInviteLink,
    :setUserEmojiStatus,
    :verifyUser,
    :verifyChat,
    :removeUserVerification,
    :removeChatVerification,
    :editUserStarSubscription,
    :savePreparedInlineMessage,
    :getAvailableGifts,
    :sendGift,
    :giftPremiumSubscription
]

println("\nVerificando métodos novos:")
for method in methods
    if hasmethod(Telegram.API.method, (Telegram.TelegramClient,), (method,))
        println("✅ $method")
    else
        println("❌ $method - NÃO ENCONTRADO")
    end
end

# Verificar métodos atualizados
updated_methods = [:sendMessage, :sendPhoto, :sendVideo, :copyMessage,
                   :forwardMessage, :createInvoiceLink, :sendInvoice]

println("\nVerificando métodos atualizados:")
for method in updated_methods
    if hasmethod(Telegram.API.method, (Telegram.TelegramClient,), (method,))
        println("✅ $method")
    else
        println("❌ $method - NÃO ENCONTRADO")
    end
end
```

### Verificar parâmetros opcionais

```julia
using Telegram, Telegram.API

# Verificar sendMessage
sig = method_signature(Telegram.API.sendMessage, (Telegram.TelegramClient,))
println("sendMessage signature: $sig")

# Verificar sendPaidMedia
sig = method_signature(Telegram.API.sendPaidMedia, (Telegram.TelegramClient,))
println("sendPaidMedia signature: $sig")
```

---

## 🐛 Debugging

### Ativar Logging

```julia
using Telegram, Telegram.Logging

# Criar logger
tg_logger = TelegramLogger(tg; async = false, min_level = Telegram.Info)

# Ativar no julia
using Logging
global_logger(TelegramLogger(tg; async = false, min_level = Telegram.Debug))

# Executar método
sendMessage(tg, chat_id = "123", text = "Debug")

# Verificar logs
```

### Verificar Requisições HTTP

```julia
using HTTP
using Base.Mock

# Criar mock
mock_server = MockServer()

# Simular requisição
response = HTTP.post("https://api.telegram.org/botTEST/getMe", [])
println("Status: ", response.status)
println("Body: ", String(response.body))
```

---

## 📈 Métricas de Teste

### Medir Cobertura

```julia
# Não há instrumentação de cobertura no pacote
# Recomendação: usar Coverage.jl com julia --track-filter=
```

### Medir Tempo de Execução

```bash
# Time unitário
julia --project=. -e 'using Telegram, Telegram.API; include("test/test_api7x.jl")' time

# Time com profiling
julia --project=. -e 'using Profile, PProf; using Telegram, Telegram.API; include("test/test_api7x.jl"); Profile.clear(); Profile.@profile include("test/test_api7x.jl"); PProf.@profinfo'
```

---

## ✅ Checklist de Validação

- [ ] Todos os 16 novos métodos existem
- [ ] Todos os 7 métodos atualizados têm novos parâmetros
- [ ] Métodos antigos continuam funcionando (compatibilidade)
- [ ] Todos os parâmetros opcionais funcionam corretamente
- [ ] Erros são tratados corretamente
- [ ] Documentação está atualizada
- [ ] Testes passam sem erros
- [ ] Não há warnings de deprecation
- [ ] Performance é aceitável
- [ ] Código segue convenções de código existentes

---

## 📚 Referências

- **Documentação API:** https://core.telegram.org/bots/api
- **Changelog:** https://core.telegram.org/bots/api-changelog
- **GitHub:** https://github.com/Arkoniak/Telegram.jl
- **Issues:** https://github.com/Arkoniak/Telegram.jl/issues

---

*Última atualização: 2025-02-23*
*Versão: 1.2.0 (API 7.x)*
