# TODO - Telegram.jl API 7.x Implementation

## Status Key
- [ ] Not Started
- [~] In Progress
- [x] Completed
- [!] Blocked

---

## FASE 1: Preparação e Análise ✅

- [x] 1.1 Criar branch "API7x"
- [x] 1.2 Analisar convenções de código existentes
- [x] 1.3 Documentar arquitetura atual
- [x] 1.4 Criar SPEC.md
- [x] 1.5 Criar TODO.md

---

## FASE 2: Novos Métodos API 7.x ✅

### 2.1 Business Account Methods
- [x] `getBusinessConnection` - Get business connection info

### 2.2 Telegram Stars Methods
- [x] `refundStarPayment` - Refund a star payment
- [x] `getStarTransactions` - Get star transaction history

### 2.3 Paid Media Methods
- [x] `sendPaidMedia` - Send paid media content

### 2.4 Subscription Methods
- [x] `createChatSubscriptionInviteLink` - Create subscription-based invite link
- [x] `editChatSubscriptionInviteLink` - Edit subscription invite link

### 2.5 User Methods
- [x] `setUserEmojiStatus` - Set user's emoji status

---

## FASE 3: Atualização de Estruturas (Milestone 2) ✅

### 3.1 Atualizar struct Update (RF-036 a RF-038)
- [x] Criar/abrir arquivo src/types/update.jl
- [x] Adicionar field business_connection (CT-036, RF-036) - Union{BusinessConnection, Nothing}
- [x] Adicionar field business_message (CT-037, RF-037) - Union{Message, Nothing}
- [x] Adicionar field edited_business_message (CT-038, RF-038) - Union{Message, Nothing}
- [x] Tornar campos opcionais (default nothing)
- [x] Escrever testes TU-036 a TU-038 em test/types/test_update.jl
- [x] Executar testes e verificar passagem

### 3.2 Atualizar struct Message (RF-039 a RF-041)
- [x] Localizar struct Message existente
- [x] Adicionar field business_connection_id (CT-039, RF-039) - Union{String, Nothing}
- [x] Adicionar field paid_media (CT-040, RF-040) - Union{PaidMedia, Nothing}
- [x] Adicionar field gift (CT-041, RF-041) - Union{Gift, Nothing}
- [x] Tornar campos opcionais (default nothing)
- [x] Manter compatibilidade com todos os campos existentes
- [x] Escrever testes TU-039 a TU-041 em test/types/test_message.jl
- [x] Executar testes e verificar passagem

### 3.3 Atualizar struct Chat (RF-042 a RF-043)
- [x] Localizar struct Chat existente
- [x] Adicionar field business_intro (CT-042, RF-042) - Union{BusinessIntro, Nothing}
- [x] Adicionar field business_location (CT-043, RF-043) - Union{BusinessLocation, Nothing}
- [x] Tornar campos opcionais (default nothing)
- [x] Escrever testes TU-042 a TU-043 em test/types/test_chat.jl
- [x] Executar testes e verificar passagem

---

## FASE 4: Testes ✅

### 4.1 Testes Unitários
- [x] Teste para getBusinessConnection
- [x] Teste para refundStarPayment
- [x] Teste para getStarTransactions
- [x] Teste para sendPaidMedia
- [x] Teste para createChatSubscriptionInviteLink
- [x] Teste para editChatSubscriptionInviteLink
- [x] Teste para setUserEmojiStatus
- [x] Teste para Update type (TU-036 a TU-038)
- [x] Teste para Message type (TU-039 a TU-041)
- [x] Teste para Chat type (TU-042 a TU-043)

---

## FASE 3: Atualização de Métodos Existentes

### 3.1 Novo parâmetro: business_connection_id
Adicionar aos seguintes métodos:
- [ ] sendMessage
- [ ] sendPhoto
- [ ] sendVideo
- [ ] sendAnimation
- [ ] sendAudio
- [ ] sendDocument
- [ ] sendSticker
- [ ] sendVideoNote
- [ ] sendVoice
- [ ] sendLocation
- [ ] sendVenue
- [ ] sendContact
- [ ] sendPoll
- [ ] sendDice
- [ ] sendGame
- [ ] sendMediaGroup
- [ ] sendChatAction
- [ ] editMessageText
- [ ] editMessageMedia
- [ ] editMessageCaption
- [ ] editMessageLiveLocation
- [ ] stopMessageLiveLocation
- [ ] editMessageReplyMarkup
- [ ] stopPoll
- [ ] pinChatMessage
- [ ] unpinChatMessage

### 3.2 Novos parâmetros específicos
- [ ] sendInvoice: provider_token opcional para XTR
- [ ] createInvoiceLink: subscription_period, business_connection_id
- [ ] sendPoll: question_parse_mode, question_entities, options como InputPollOption
- [ ] editMessageLiveLocation: live_period
- [ ] sendAnimation: show_caption_above_media, message_effect_id
- [ ] sendPhoto: show_caption_above_media, message_effect_id
- [ ] sendVideo: show_caption_above_media, message_effect_id, cover, start_timestamp
- [ ] copyMessage: show_caption_above_media, message_effect_id, video_start_timestamp
- [ ] editMessageCaption: show_caption_above_media
- [ ] forwardMessage: message_effect_id, video_start_timestamp
- [ ] sendMediaGroup: message_effect_id
- [ ] sendSticker: message_effect_id

---

## FASE 4: Testes

### 4.1 Testes Unitários
- [ ] Teste para getBusinessConnection
- [ ] Teste para refundStarPayment
- [ ] Teste para getStarTransactions
- [ ] Teste para sendPaidMedia
- [ ] Teste para createChatSubscriptionInviteLink
- [ ] Teste para editChatSubscriptionInviteLink
- [ ] Teste para setUserEmojiStatus

### 4.2 Testes de Integração
- [ ] Mock test para business connection
- [ ] Mock test para star transactions
- [ ] Mock test para paid media

### 4.3 Testes de Regressão
- [ ] Verificar métodos existentes ainda funcionam
- [ ] Verificar compatibilidade retroativa

---

## FASE 5: Documentação

- [ ] Atualizar README.md com novos recursos
- [ ] Criar LEARNINGS.md
- [ ] Atualizar CHANGELOG

---

## Notas de Progresso

### 2025-02-23
- Criado SPEC.md com especificação completa das mudanças API 7.x
- Criado TODO.md com checklist detalhado
- Implementados novos métodos (Fase 2)
- ✅ **Milestone 2 Completo: Atualização de structs existentes**
  - 8 novos campos adicionados (Update, Message, Chat)
  - 14 tipos de suporte criados
  - 53 testes passando (TU-036 a TU-043)
  - 100% backward compatibility mantida
  - Relatório M2_REPORT.md criado
- Próximo passo: Fase 3 - Atualizar métodos existentes

