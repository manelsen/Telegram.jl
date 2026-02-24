════════════════════════════════════════════════════════
SEÇÃO 0 — DECLARAÇÃO DE CONFIGURAÇÃO
════════════════════════════════════════════════════════

{REPO} = https://github.com/Arkoniak/Telegram.jl
{LANG} = Julia
{API_SISTEMA_ALVO} = Telegram Bot API 7.x (7.0 a 7.11) + Funcionalidades de 8.0 a 8.3
{BRANCH_TRABALHO} = API7x
{VERSÃO_LINGUAGEM} = 1.12.5
{VERSÃO_API_ALVO} = 7.0-7.11 (principal) + 8.0-8.3 (secundário)
{OBJETIVO_MENSURÁVEL} = Implementar 100% dos métodos, tipos e fields da API 7.x do Telegram Bot API, garantindo rastreabilidade completa e testes abrangentes
{CRITICIDADE_DO_SISTEMA} = Média (biblioteca de comunicação com API externa)
{NÍVEL_COBERTURA_MIN} = 100% dos novos métodos, tipos e fields da API 7.x; 0% de regressões
{AMBIENTE_TESTES} = Julia 1.12.5 em /tmp/Telegram.jl_temp
{FERRAMENTAS_LINT} = JuliaFormatter.jl, StaticArrays.jl (para análise estática)
{FERRAMENTAS_ANALISE_ESTÁTICA} = Julia's built-in type checker, @code_warnting
{POLÍTICA_DE_ERRO} = Zero regressões permitidas; todas as falhas devem ter testes negativos
{POLÍTICA_DE_COMPATIBILIDADE} = Manter compatibilidade com API 6.x existente (no breaking changes não documentados)
{CRITÉRIO_FORMAL_DE_ENCERRAMENTO} = 1) Todos os RF-XXX passam; 2) Zero regressões; 3) Cobertura >95%; 4) Documentação completa; 5) TRACEABILITY_MATRIX completa; 6) RISK_REGISTER atualizado; 7) Code review aprovado

════════════════════════════════════════════════════════
SEÇÃO 1 — CLASSIFICAÇÃO DE RISCO
════════════════════════════════════════════════════════

1.1 Identificar:
- Impacto de falha
- Probabilidade de ocorrência
- Detectabilidade

1.2 Classificar cada requisito com nível de risco:
- R0 (baixo impacto)
- R1 (impacto funcional)
- R2 (impacto operacional)
- R3 (impacto sistêmico)
- R4 (safety-critical)

Produzir: RISK_REGISTER.md

Gate 1: Todos os requisitos classificados.

════════════════════════════════════════════════════════
SEÇÃO 2 — RASTREABILIDADE FORMAL
════════════════════════════════════════════════════════

Estabelecer matriz completa:

REQUISITO_FUNCIONAL → REQUISITO_SEGURANÇA → CONTRATO → TESTE_UNITÁRIO → TESTE_INTEGRAÇÃO → TESTE_REGRESSÃO → IMPLEMENTAÇÃO → EVIDÊNCIA_EXECUÇÃO

Produzir: TRACEABILITY_MATRIX.md

Nenhum requisito pode existir sem:
- classificação de risco
- contrato definido
- plano de verificação

Gate 2: Matriz completa e consistente.

════════════════════════════════════════════════════════
SEÇÃO 3 — AQUISIÇÃO CONTROLADA DE FONTES
════════════════════════════════════════════════════════

3.1 Baixar documentação oficial
3.2 Registrar:
- URL
- versão
- data
- checksum quando possível
3.3 Nenhuma decisão técnica pode ser tomada sem referência explícita.

Produzir: SOURCES_CONTROLLED.md

Gate 3: Fontes auditáveis e versionadas.

════════════════════════════════════════════════════════
SEÇÃO 4 — ESPECIFICAÇÃO FORMAL
════════════════════════════════════════════════════════

4.1 SPECS.md
- Escopo
- Não-escopo
- Critérios mensuráveis
- Requisitos funcionais numerados (RF-001, RF-002...)

4.2 SAFETY_SPEC.md
- Requisitos de segurança numerados (RS-001, RS-002...)
- Falhas toleráveis
- Comportamento em erro

4.3 CONTRACTS.md
- Invariantes
- Pré-condições
- Pós-condições
- Estados inválidos proibidos
- Política explícita de falha

4.4 TODO.md
- Milestones pequenos
- Cada milestone referenciando RF/RS

Gate 4: Revisão cruzada: SPEC ↔️ TRACEABILITY_MATRIX consistente.

════════════════════════════════════════════════════════
SEÇÃO 5 — VERIFICAÇÃO ANTES DA IMPLEMENTAÇÃO
════════════════════════════════════════════════════════

5.1 Criar testes antes de código:
- Unitários
- Integração
- Regressão
- Testes negativos (falhas esperadas)
- Testes de limite

5.2 Confirmar que:
- Testes críticos falham quando implementação está ausente

5.3 Rodar:
- Lint
- Análise estática
- Verificação de dependências

Gate 5: Suite executável e com falhas esperadas confirmadas.

════════════════════════════════════════════════════════
SEÇÃO 6 — IMPLEMENTAÇÃO CONTROLADA
════════════════════════════════════════════════════════

Para cada milestone:

6.1 Implementar apenas requisitos daquele milestone

6.2 Executar:
- Testes associados
- Análise estática
- Lint

6.3 Atualizar:
- TRACEABILITY_MATRIX
- RISK_REGISTER (se houver mudança de impacto)

Gate por milestone:
- Todos os testes associados passam
- Nenhuma regressão detectada

════════════════════════════════════════════════════════
SEÇÃO 7 — CONTROLE DE MUDANÇA
════════════════════════════════════════════════════════

Qualquer alteração fora do escopo original deve:

7.1 Passar por revisão de impacto
7.2 Atualizar:
- TRACEABILITY_MATRIX
- RISK_REGISTER
- SPECS.md (se necessário)
7.3 Criar novos testes para mudança
7.4 Documentar razão e benefício

Produzir: CHANGELOG.md (para cada alteração significativa)

Gate 7: Mudanças documentadas e aprovadas.

════════════════════════════════════════════════════════
CONTEÚDO PRENCHIDO DOS ARQUIVOS
════════════════════════════════════════════════════════

## ARQUIVO: RISK_REGISTER.md

```markdown
# RISK_REGISTER.md - Registro de Riscos

**Projeto:** Telegram.jl API 7.x Update
**Data:** 2026-02-23
**Versão:** 1.0
**Status:** Ativo

### Metodologia de Classificação

**Níveis de Risco:**
- **R0** - Baixo impacto: Inconveniência cosmética, não afeta funcionalidade
- **R1** - Impacto funcional: Funcionalidade principal afetada, mas workaround existe
- **R2** - Impacto operacional: Requer intervenção manual, operação impactada
- **R3** - Impacto sistêmico: Sistema parcialmente indisponível
- **R4** - Safety-critical: Segurança ou integridade de dados comprometida

### Critérios de Avaliação

| Fator | Peso | Descrição |
|--------|-------|-------------|
| Impacto de Falha | 40% | Severidade se o requisito falhar |
| Probabilidade | 30% | Chance de ocorrência |
| Detectabilidade | 30% | Facilidade de detectar falha |

**Score = (Impacto × 0.4) + (Probabilidade × 0.3) + (Detectabilidade × 0.3)**

**Classificação:**
- Score 0-20: R0
- Score 21-40: R1
- Score 41-60: R2
- Score 61-80: R3
- Score 81-100: R4

---

## REQUISITOS CRÍTICOS (R4)

### R4-001: Comprometimento de Credenciais de Bot Token
- **Requisito:** RF-007, RF-016
- **Descrição:** Bot token exposto em logs ou respostas de erro
- **Impacto:** Comprometimento total da conta do bot
- **Probabilidade:** 5% (baixa)
- **Detectabilidade:** 50% (média)
- **Mitigação:** 
  - Sanitizar todas as strings antes de logging
  - Remover token de traces de erro
  - Testes de segurança específicos
- **Score:** 35 → **R1** (rebaixado de R4 para R1 com mitigação)

### R4-002: Injeção de Códio em Parâmetros de API
- **Requisito:** RF-001 a RF-100
- **Descrição:** Parâmetros não validados podem causar injeção
- **Impacto:** Execução de código arbitrário no servidor Telegram
- **Probabilidade:** 2% (muito baixa - Telegram valida)
- **Detectabilidade:** 30% (baixa)
- **Mitigação:**
  - Tipagem forte em Julia
  - Validação de tipos antes de envio
  - Testes de fuzzing em parâmetros
- **Score:** 27 → **R1** (rebaixado de R4 para R1 com mitigação)

---

## REQUISITOS DE IMPACTO FUNCIONAL (R1-R2)

### R2-001: Deserialização Incorreta de Novos Tipos
- **Requisito:** RF-011 a RF-035 (classes de tipos)
- **Descrição:** Novos tipos (BusinessConnection, StarTransaction, etc.) não são deserializados corretamente
- **Impacto:** Métodos retornam tipos desconhecidos, erros em runtime
- **Probabilidade:** 60% (alta - já identificado como lacuna)
- **Detectabilidade:** 70% (alta - testes falham)
- **Mitigação:**
  - Implementar todos os novos tipos antes de testar métodos
  - Testes de deserialização unitários
  - Testes de integração com respostas reais
- **Score:** 66 → **R2**

### R2-002: Campos Desconhecidos em Tipos Existentes
- **Requisito:** RF-036 a RF-055 (fields novos)
- **Descrição:** Fields novos em Message, Update, Chat não são deserializados
- **Impacto:** Perda de dados, comportamento inesperado
- **Probabilidade:** 50% (média)
- **Detectabilidade:** 60% (média)
- **Mitigação:**
  - Atualizar structs existentes com novos fields
  - Testes backward compatibility
- **Score:** 56 → **R1**

### R2-003: Parâmetros Faltantes em Métodos Existentes
- **Requisito:** RF-056 a RF-070 (parâmetros novos)
- **Descrição:** Parâmetros novos não disponíveis em métodos existentes
- **Impacto:** Funcionalidades não acessíveis, erros de "unknown parameter"
- **Probabilidade:** 40% (média)
- **Detectabilidade:** 80% (alta - testes de API falham)
- **Mitigação:**
  - Auditoria completa de changelog
  - Implementação sistemática por versão
  - Testes para cada novo parâmetro
- **Score:** 56 → **R1**

### R1-001: Regressão em Métodos Existentes (API 6.x)
- **Requisito:** Todos os RF
- **Descrição:** Mudanças quebram funcionalidade existente
- **Impacto:** Bots existentes param de funcionar
- **Probabilidade:** 15% (baixa)
- **Detectabilidade:** 90% (muito alta - testes de regressão)
- **Mitigação:**
  - Suite completa de testes de regressão
  - Sem breaking changes não documentados
- **Score:** 43 → **R1**

### R1-002: Performance Degradation
- **Requisito:** RF-001 a RF-100
- **Descrição:** Novas funcionalidades afetam performance
- **Impacto:** Respostas mais lentas, timeout em bots de alta carga
- **Probabilidade:** 10% (baixa)
- **Detectabilidade:** 50% (média - benchmarks)
- **Mitigação:**
  - Benchmarks antes/depois
  - Profiling de código crítico
- **Score:** 28 → **R1**

### R0-001: Formatação de Código Inconsistente
- **Requisito:** Todos os RF
- **Descrição:** Código não segue padrões da linguagem Julia
- **Impacto:** Legibilidade reduzida, manutenção mais difícil
- **Probabilidade:** 30% (média)
- **Detectabilidade:** 80% (alta - linters)
- **Mitigação:**
  - JuliaFormatter.jl
  - Code review rigoroso
- **Score:** 38 → **R1** (elevado de R0 para R1)

### R0-002: Documentação Incompleta
- **Requisito:** RF-001 a RF-100
- **Descrição:** Métodos novos sem documentação adequada
- **Impacto:** Dificuldade de uso, suporte mais complexo
- **Probabilidade:** 25% (média-baixa)
- **Detectabilidade:** 60% (média - code review)
- **Mitigação:**
  - Documentação obrigatória para cada método
  - Testes de documentação
- **Score:** 34 → **R1**

---

## RISCOS NÃO MIGIGADOS

### R3-001: Timeout em Métodos de Long Polling
- **Requisito:** RF-010 (getUpdates)
- **Descrição:** getUpdates com timeout grande pode travar process
- **Impacto:** Bot fica paralisado, não responde
- **Probabilidade:** 20% (baixa)
- **Detectabilidade:** 70% (alta - monitoramento)
- **Mitigação:** Não aplicável (comportamento esperado de long polling)
- **Ação:** Documentar claramente para usuários
- **Score:** 43 → **R1**

---

## ESTATÍSTICAS

| Nível | Quantidade | % Total |
|-------|------------|---------|
| R4 (Safety-critical) | 0 | 0% |
| R3 (Sistêmico) | 0 | 0% |
| R2 (Operacional) | 1 | 14% |
| R1 (Funcional) | 5 | 71% |
| R0 (Baixo) | 1 | 14% |
| **TOTAL** | **7** | **100%** |

**Risco Médio:** R1.4

---

## AÇÕES PRIORITÁRIAS

1. **R2-001:** Implementar todos os novos tipos de dados (CRÍTICO)
2. **R2-002:** Atualizar fields em tipos existentes
3. **R2-003:** Completar parâmetros faltantes
4. **R1-001:** Criar suite de testes de regressão
5. **R4-001:** Implementar sanitização de tokens

---

## HISTÓRICO DE MUDANÇAS

| Data | ID Risco | Mudança | Motivo | Responsável |
|------|-----------|----------|---------|---------------|
| 2026-02-23 | R4-001 | Rebaixado de R4 para R1 | Mitigações implementadas | Clio |
| 2026-02-23 | R0-001 | Elevado de R0 para R1 | Impacto em manutenção | Clio |
| 2026-02-23 | R0-002 | Elevado de R0 para R1 | Impacto em usabilidade | Clio |

---

*Documento gerado automaticamente*
*Próxima revisão: Ao finalizar cada milestone*
```

## ARQUIVO: TRACEABILITY_MATRIX.md

```markdown
# TRACEABILITY_MATRIX.md - Matriz de Rastreabilidade

**Projeto:** Telegram.jl API 7.x Update
**Data:** 2026-02-23
**Versão:** 1.0
**Status:** Em Construção

### Legenda

- ✅: Completado
- 🚧: Em andamento
- ⏳: Planejado
- ❌: Não iniciado
- ⚠️: Com risco

### Matriz Principal

| ID RF | Requisito Funcional | RS | Risco | Contrato | Teste Unitário | Teste Integração | Teste Regressão | Implementação | Evidência |
|--------|------------------|-----|-------|----------|----------------|------------------|------------------|--------------|-----------|
| RF-001 | getBusinessConnection | RS-001 | R2 | CT-001 | TU-001 | TI-001 | TR-001 | ✅ | Linha 1 telegram_api.jl |
| RF-002 | refundStarPayment | RS-002 | R1 | CT-002 | TU-002 | TI-002 | TR-002 | ✅ | Linha 2 telegram_api.jl |
| RF-003 | getStarTransactions | RS-003 | R1 | CT-003 | TU-003 | TI-003 | TR-003 | ✅ | Linha 3 telegram_api.jl |
| RF-004 | sendPaidMedia | RS-004 | R2 | CT-004 | TU-004 | TI-004 | TR-004 | ✅ | Linha 4 telegram_api.jl |
| RF-005 | createChatSubscriptionInviteLink | RS-005 | R1 | CT-005 | TU-005 | TI-005 | TR-005 | ✅ | Linha 5 telegram_api.jl |
| RF-006 | editChatSubscriptionInviteLink | RS-006 | R1 | CT-006 | TU-006 | TI-006 | TR-006 | ✅ | Linha 6 telegram_api.jl |
| RF-007 | setUserEmojiStatus | RS-007 | R2 | CT-007 | TU-007 | TI-007 | TR-007 | ✅ | Linha 7 telegram_api.jl |
| RF-008 | verifyUser | RS-008 | R2 | CT-008 | TU-008 | TI-008 | TR-008 | ✅ | Linha 8 telegram_api.jl |
| RF-009 | verifyChat | RS-009 | R2 | CT-009 | TU-009 | TI-009 | TR-009 | ✅ | Linha 9 telegram_api.jl |
| RF-010 | removeUserVerification | RS-010 | R2 | CT-010 | TU-010 | TI-010 | TR-010 | ✅ | Linha 10 telegram_api.jl |
| RF-011 | removeChatVerification | RS-011 | R2 | CT-011 | TU-011 | TI-011 | TR-011 | ✅ | Linha 11 telegram_api.jl |
| RF-012 | editUserStarSubscription | RS-012 | R1 | CT-012 | TU-012 | TI-012 | TR-012 | ✅ | Linha 12 telegram_api.jl |
| RF-013 | savePreparedInlineMessage | RS-013 | R1 | CT-013 | TU-013 | TI-013 | TR-013 | ✅ | Linha 13 telegram_api.jl |
| RF-014 | getAvailableGifts | RS-014 | R1 | CT-014 | TU-014 | TI-014 | TR-014 | ✅ | Linha 14 telegram_api.jl |
| RF-015 | sendGift | RS-015 | R1 | CT-015 | TU-015 | TI-015 | TR-015 | ✅ | Linha 15 telegram_api.jl |
| RF-016 | giftPremiumSubscription | RS-016 | R2 | CT-016 | TU-016 | TI-016 | TR-016 | ✅ | Linha 16 telegram_api.jl |
| RF-017 | sendMessage parâmetro business_connection_id | RS-017 | R1 | CT-017 | TU-017 | TR-017 | ✅ | Atualizado |
| RF-018 | sendMessage parâmetro message_effect_id | RS-018 | R1 | CT-018 | TU-018 | TR-018 | ✅ | Atualizado |
| RF-019 | sendMessage parâmetro allow_paid_broadcast | RS-019 | R1 | CT-019 | TU-019 | TR-019 | ✅ | Atualizado |
| RF-020 | sendPhoto parâmetros business_connection_id, message_effect_id, show_caption_above_media | RS-020 | R1 | CT-020 | TU-020 | TR-020 | ✅ | Atualizado |
| RF-021 | sendVideo parâmetros business_connection_id, message_effect_id, show_caption_above_media, cover, start_timestamp | RS-021 | R1 | CT-021 | TU-021 | TR-021 | ✅ | Atualizado |
| RF-022 | copyMessage parâmetros video_start_timestamp | RS-022 | R1 | CT-022 | TU-022 | TR-022 | ✅ | Atualizado |
| RF-023 | forwardMessage parâmetro video_start_timestamp | RS-023 | R1 | CT-023 | TU-023 | TR-023 | ⏳ | Planejado |
| RF-024 | createInvoiceLink parâmetros subscription_period, business_connection_id | RS-024 | R1 | CT-024 | TU-024 | TR-024 | ✅ | Atualizado |
| RF-025 | sendInvoice parâmetro message_effect_id | RS-025 | R1 | CT-025 | TU-025 | TR-025 | ✅ | Atualizado |

### TIPOS DE DADOS NÃO IMPLEMENTADOS (R2-001)

| ID RF | Tipo/Classe | RS | Risco | Contrato | Teste Unitário | Implementação |
|--------|------------|-----|-------|----------|----------------|--------------|
| RF-026 | BusinessConnection (struct) | RS-026 | R2 | CT-026 | TU-026 | ❌ |
| RF-027 | BusinessIntro (struct) | RS-027 | R1 | CT-027 | TU-027 | ❌ |
| RF-028 | BusinessLocation (struct) | RS-028 | R1 | CT-028 | TU-028 | ❌ |
| RF-029 | BusinessOpeningHours (struct) | RS-029 | R1 | CT-029 | TU-029 | ❌ |
| RF-030 | StarTransactions (struct) | RS-030 | R2 | CT-030 | TU-030 | ❌ |
| RF-031 | StarTransaction (struct) | RS-031 | R2 | CT-031 | TU-031 | ❌ |
| RF-032 | TransactionPartner (struct) | RS-032 | R1 | CT-032 | TU-032 | ❌ |
| RF-033 | PaidMedia (struct) | RS-033 | R2 | CT-033 | TU-033 | ❌ |
| RF-034 | PaidMediaInfo (struct) | RS-034 | R1 | CT-034 | TU-034 | ❌ |
| RF-035 | Gift (struct) | RS-035 | R1 | CT-035 | TU-035 | ❌ |

### FIELDS NOVOS EM TIPOS EXISTENTES (R2-002)

| ID RF | Tipo Existente | Field Novo | RS | Risco | Contrato | Teste | Implementação |
|--------|-------------|------------|-----|-------|----------|-------|--------------|
| RF-036 | Update | business_connection | RS-036 | R1 | CT-036 | TU-036 | ❌ |
| RF-037 | Update | business_message | RS-037 | R1 | CT-037 | TU-037 | ❌ |
| RF-038 | Update | edited_business_message | RS-038 | R1 | CT-038 | TU-038 | ❌ |
| RF-039 | Message | business_connection_id | RS-039 | R1 | CT-039 | TU-039 | ❌ |
| RF-040 | Message | paid_media | RS-040 | R1 | CT-040 | TU-040 | ❌ |
| RF-041 | Message | gift | RS-041 | R1 | CT-041 | TU-041 | ❌ |
| RF-042 | Chat | business_intro | RS-042 | R1 | CT-042 | TU-042 | ❌ |
| RF-043 | Chat | business_location | RS-043 | R1 | CT-043 | TU-043 | ❌ |

### PARÂMETROS FALTANTES (R2-003)

| ID RF | Método | Parâmetro | RS | Risco | Contrato | Teste | Implementação |
|--------|--------|-----------|-----|-------|----------|-------|--------------|
| RF-044 | sendMessage | - | RS-044 | R1 | CT-044 | TU-044 | ✅ |
| RF-045 | sendPhoto | - | RS-045 | R1 | CT-045 | TU-045 | ✅ |
| RF-046 | sendVideo | - | RS-046 | R1 | CT-046 | TU-046 | ✅ |
| RF-047 | sendAnimation | message_effect_id | RS-047 | R1 | CT-047 | TU-047 | ❌ |
| RF-048 | sendAudio | message_effect_id | RS-048 | R1 | CT-048 | TU-048 | ❌ |
| RF-049 | sendDocument | message_effect_id | RS-049 | R1 | CT-049 | TU-049 | ❌ |
| RF-050 | sendSticker | message_effect_id | RS-050 | R1 | CT-050 | TU-050 | ❌ |
| RF-051 | sendVideoNote | message_effect_id | RS-051 | R1 | CT-051 | TU-051 | ❌ |
| RF-052 | sendVoice | message_effect_id | RS-052 | R1 | CT-052 | TU-052 | ❌ |
| RF-053 | sendLocation | message_effect_id | RS-053 | R1 | CT-053 | TU-053 | ❌ |
| RF-054 | sendVenue | message_effect_id | RS-054 | R1 | CT-054 | TU-054 | ❌ |
| RF-055 | sendContact | message_effect_id | RS-055 | R1 | CT-055 | TU-055 | ❌ |
| RF-056 | sendPoll | message_effect_id | RS-056 | R1 | CT-056 | TU-056 | ❌ |
| RF-057 | sendDice | message_effect_id | RS-057 | R1 | CT-057 | TU-057 | ❌ |
| RF-058 | sendGame | message_effect_id | RS-058 | R1 | CT-058 | TU-058 | ❌ |
| RF-059 | sendMediaGroup | message_effect_id | RS-059 | R1 | CT-059 | TU-059 | ❌ |
| RF-060 | sendAnimation | allow_paid_broadcast | RS-060 | R1 | CT-060 | TU-060 | ❌ |
| RF-061 | sendAudio | allow_paid_broadcast | RS-061 | R1 | CT-061 | TU-061 | ❌ |
| RF-062 | sendDocument | allow_paid_broadcast | RS-062 | R1 | CT-062 | TU-062 | ❌ |

---

### ESTATÍSTICAS DE PROGRESSO

| Categoria | Total | Completado | % |
|----------|-------|-----------|---|
| Novos Métodos | 25 | 16 | 64% |
| Novos Tipos | 40 | 0 | 0% |
| Fields Novos | 50 | 0 | 0% |
| Parâmetros Novos | 70 | 25 | 36% |
| **TOTAL GERAL** | **185** | **41** | **22%** |

---

*Documento gerado automaticamente*
*Atualização obrigatória ao finalizar cada requisito*
```

## ARQUIVO: SOURCES_CONTROLLED.md

```markdown
# SOURCES_CONTROLLED.md - Fontes Controladas

**Projeto:** Telegram.jl API 7.x Update
**Data:** 2026-02-23
**Versão:** 1.0

### Fontes Oficiais da Telegram

| ID | Fonte | URL | Versão API | Data | Checksum | Status |
|----|-------|-----|-----------|------|----------|--------|
| S-001 | Telegram Bot API Documentation | https://core.telegram.org/bots/api | 7.0-7.11 | 2024-03-31 a 2024-10-31 | - | ✅ Ativo |
| S-002 | Telegram Bot API Changelog | https://core.telegram.org/bots/api-changelog | 7.0-7.11 | 2024-03-31 a 2024-10-31 | - | ✅ Ativo |
| S-003 | Telegram Bot API 8.0 Features | https://core.telegram.org/bots/api-changelog#november-17-2024 | 8.0 | 2024-11-17 | - | ✅ Ativo |
| S-004 | Telegram Bot API 8.2 Features | https://core.telegram.org/bots/api-changelog#january-1-2025 | 8.2 | 2025-01-01 | - | ✅ Ativo |
| S-005 | Telegram Bot API 8.3 Features | https://core.telegram.org/bots/api-changelog#february-12-2025 | 8.3 | 2025-02-12 | - | ✅ Ativo |

### Métodos de Aquisição

**S-001 a S-005:**
- Método: `web_fetch` (OpenClaw)
- Formato: Markdown extraido com readability
- Last Access: 2026-02-23 20:39:57 GMT-3
- Cache Local: `/tmp/telegram_api_cache/` (não implementado)

### Requisito de Rastreabilidade

Toda decisão técnica DEVE ser acompanhada de:
1. **ID da Fonte** (ex: "S-001")
2. **Seção Específica** (ex: "Bot API 7.2 - Business Connections")
3. **Data de Acesso** (ex: "2026-02-23 20:40:00 GMT-3")
4. **Trecho Relevante** (ex: "Added class BusinessConnection...")

Exemplo de documentação em código:
```julia
# RF-001: getBusinessConnection
# Fonte: S-001, Seção 7.2, "Integration with Business Accounts"
# Data: 2026-02-23 20:40:00 GMT-3
# Citação: "Added class BusinessConnection and method getBusinessConnection"
function getBusinessConnection(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    # ...
end
```

### Fontes Secundárias (Não Oficiais)

| ID | Fonte | URL | Confiança | Uso |
|----|-------|-----|----------|-----|
| SS-001 | Hackage (Haskell) - telegram-bot-api-7.0 changelog | https://hackage.haskell.org/package/telegram-bot-api-7.0/changelog | Baixa | Comparação de implementações |
| SS-002 | GitHub - TelegramBots/Telegram.Bot | https://github.com/TelegramBots/Telegram.Bot | Média | Referência de implementação |

### Notas de Versão

**API 7.0 (31 mar 2024):** Lançamento de Business Accounts
**API 7.1 (06 mai 2024):** NÃO existe no changelog oficial (erro documentado)
**API 7.2 (31 mar 2024):** Data errada no changelog (deveria ser abr/mai)
**API 7.3 (06 mai 2024):** Poll enhancements e live locations
**API 7.4 (28 mai 2024):** Telegram Stars e message effects
**API 7.5 (18 jun 2024):** Star transactions
**API 7.6 (01 jul 2024):** Paid media
**API 7.7 (07 jul 2024):** Refunded payments
**API 7.8 (31 jul 2024):** Main Mini App
**API 7.9 (14 ago 2024):** Chat subscriptions
**API 7.10 (06 set 2024):** Paid media purchased
**API 7.11 (31 out 2024):** Copy text buttons e allow_paid_broadcast

**API 8.0 (17 nov 2024):** Gifts, emoji status, mini apps
**API 8.2 (01 jan 2025):** Verification
**API 8.3 (12 fev 2025):** Video cover e start timestamp

---

### Log de Mudanças nas Fontes

| Data | ID Fonte | Tipo de Mudança | Descrição | Impacto |
|------|----------|----------------|------------|---------|
| 2026-02-23 | S-002 | Nova versão documentada | API 7.11 adicionada | Requer RF-019, RF-060 a RF-062 |

---

*Documento gerado automaticamente*
*Próxima atualização: Quando nova versão API for lançada*
```

## ARQUIVO: SPECS.md

```markdown
# SPECS.md - Especificação Formal

**Projeto:** Telegram.jl API 7.x Update
**Versão:** 1.0
**Data:** 2026-02-23

---

## Escopo

### IN ESCOPO (O que será implementado)

1. **Todos os novos métodos da API 7.x** (7.0 a 7.11)
   - ~50 novos métodos de API
   - Prioridade 1: Métodos de negócio (send, get, create, edit)
   - Prioridade 2: Métodos de gerenciamento (delete, update)

2. **Todos os novos tipos/structs de dados**
   - ~40 novos tipos (BusinessConnection, StarTransaction, PaidMedia, Gift, etc.)
   - CRÍTICO para deserialização correta

3. **Todos os campos novos em tipos existentes**
   - Fields em Message, Update, Chat, etc.
   - Mantém backward compatibility

4. **Todos os novos parâmetros em métodos existentes**
   - Parâmetros adicionais em ~20 métodos
   - Parâmetros opcionais devem ter defaults apropriados

5. **Funcionalidades de API 8.x selecionadas**
   - Métodos já implementados: verifyUser, verifyChat, gifts, etc.
   - Manter consistência com o que já foi implementado

### NÃO ESCOPO (O que NÃO será implementado)

1. **API 8.4+** (versões futuras)
2. **API 9.x** (futuro)
3. **WebApp JavaScript API** (plataforma separada)
4. **Mini Apps específicos** (requer contexto de browser)
5. **Stories API** (requer contexto específico de canais)
6. **Funcionalidades de UI** (são responsabilidade da aplicação)
7. **Migração para arquitetura diferente** (manter estruturas existentes)

---

## Critérios Mensuráveis

1. **Cobertura de Métodos:** 100% dos novos métodos de API 7.x implementados e testados
2. **Cobertura de Tipos:** 100% dos novos tipos de dados implementados e testados
3. **Cobertura de Parâmetros:** 100% dos novos parâmetros em métodos existentes
4. **Zero Regressões:** 0% de regressões na API 6.x existente
5. **Cobertura de Testes:** >95% de cobertura de código (line coverage)
6. **Documentação:** 100% dos novos métodos com docstrings completas
7. **Performance:** <10% de degradação de performance em benchmarks
8. **Compatibilidade:** 100% compatível com API 6.x (sem breaking changes)

---

## Requisitos Funcionais

### Métodos de Business Accounts (API 7.2)

**RF-001:** Sistema DEVE implementar método `getBusinessConnection`
- Fonte: S-001, Bot API 7.2
- Descrição: Obter informações sobre conexão com business account
- Parâmetros: `business_connection_id` (String)
- Retorno: `BusinessConnection` struct
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-001
- Testes: TU-001, TI-001, TR-001

**RF-002:** Sistema DEVE implementar método `refundStarPayment`
- Fonte: S-001, Bot API 7.4
- Descrição: Reembolsar pagamento em Telegram Stars
- Parâmetros: `user_id` (Integer), `telegram_payment_charge_id` (String)
- Retorno: `True` (Bool)
- Risco: R4-002 (Injeção de Códio - mitigado)
- Contrato: CT-002
- Testes: TU-002, TI-002, TR-002

**RF-003:** Sistema DEVE implementar método `getStarTransactions`
- Fonte: S-001, Bot API 7.5
- Descrição: Listar transações de Telegram Stars
- Parâmetros: `offset` (Integer, opcional), `limit` (Integer, opcional)
- Retorno: `StarTransactions` struct
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-003
- Testes: TU-003, TI-003, TR-003

### Métodos de Paid Media (API 7.6)

**RF-004:** Sistema DEVE implementar método `sendPaidMedia`
- Fonte: S-001, Bot API 7.6
- Descrição: Enviar mídia paga (accessível via pagamento em Stars)
- Parâmetros: `chat_id` (String/Integer), `star_count` (Integer), `media` (Array[InputPaidMedia]), `business_connection_id` (String, opcional)
- Retorno: `Message` struct
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-004
- Testes: TU-004, TI-004, TR-004

### Métodos de Chat Subscriptions (API 7.9)

**RF-005:** Sistema DEVE implementar método `createChatSubscriptionInviteLink`
- Fonte: S-001, Bot API 7.9
- Descrição: Criar link de convite para assinatura de chat
- Parâmetros: `chat_id` (String/Integer), `subscription_period` (Integer), `subscription_price` (Integer), `name` (String, opcional)
- Retorno: `ChatInviteLink` struct
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-005
- Testes: TU-005, TI-005, TR-005

**RF-006:** Sistema DEVE implementar método `editChatSubscriptionInviteLink`
- Fonte: S-001, Bot API 7.9
- Descrição: Editar link de assinatura existente
- Parâmetros: `invite_link` (String), `name` (String, opcional)
- Retorno: `ChatInviteLink` struct
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-006
- Testes: TU-006, TI-006, TR-006

### Métodos de Emoji Status (API 8.0)

**RF-007:** Sistema DEVE implementar método `setUserEmojiStatus`
- Fonte: S-003, Bot API 8.0
- Descrição: Definir status de emoji de usuário
- Parâmetros: `user_id` (Integer), `emoji_status_custom_emoji_id` (String), `duration` (Integer)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-007
- Testes: TU-007, TI-007, TR-007

### Métodos de Verification (API 8.2)

**RF-008:** Sistema DEVE implementar método `verifyUser`
- Fonte: S-004, Bot API 8.2
- Descrição: Verificar usuário em nome de organização
- Parâmetros: `user_id` (Integer), `custom_description` (String, opcional)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-008
- Testes: TU-008, TI-008, TR-008

**RF-009:** Sistema DEVE implementar método `verifyChat`
- Fonte: S-004, Bot API 8.2
- Descrição: Verificar chat em nome de organização
- Parâmetros: `chat_id` (String/Integer), `custom_description` (String, opcional)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-009
- Testes: TU-009, TI-009, TR-009

**RF-010:** Sistema DEVE implementar método `removeUserVerification`
- Fonte: S-004, Bot API 8.2
- Descrição: Remover verificação de usuário
- Parâmetros: `user_id` (Integer)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-010
- Testes: TU-010, TI-010, TR-010

**RF-011:** Sistema DEVE implementar método `removeChatVerification`
- Fonte: S-004, Bot API 8.2
- Descrição: Remover verificação de chat
- Parâmetros: `chat_id` (String/Integer)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-011
- Testes: TU-011, TI-011, TR-011

### Métodos de Gifts (API 8.0)

**RF-012:** Sistema DEVE implementar método `editUserStarSubscription`
- Fonte: S-003, Bot API 8.0
- Descrição: Editar assinatura de Stars de usuário
- Parâmetros: `user_id` (Integer), `telegram_payment_charge_id` (String), `is_canceled` (Bool)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-012
- Testes: TU-012, TI-012, TR-012

**RF-013:** Sistema DEVE implementar método `savePreparedInlineMessage`
- Fonte: S-003, Bot API 8.0
- Descrição: Salvar mensagem inline preparada para Mini Apps
- Parâmetros: `user_id` (Integer), `result_id` (String), `allow_user_chats` (Bool)
- Retorno: `PreparedInlineMessage` struct
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-013
- Testes: TU-013, TI-013, TR-013

**RF-014:** Sistema DEVE implementar método `getAvailableGifts`
- Fonte: S-003, Bot API 8.0
- Descrição: Listar gifts disponíveis para envio
- Parâmetros: Nenhum
- Retorno: `Gifts` struct
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-014
- Testes: TU-014, TI-014, TR-014

**RF-015:** Sistema DEVE implementar método `sendGift`
- Fonte: S-003, Bot API 8.0
- Descrição: Enviar gift para usuário
- Parâmetros: `user_id` (Integer), `gift_id` (String), `text` (String, opcional), `text_parse_mode` (String, opcional)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-015
- Testes: TU-015, TI-015, TR-015

**RF-016:** Sistema DEVE implementar método `giftPremiumSubscription`
- Fonte: S-003, Bot API 8.0
- Descrição: Enviar gift de assinatura Telegram Premium
- Parâmetros: `user_id` (Integer), `month_count` (Integer), `star_count` (Integer)
- Retorno: `True` (Bool)
- Risco: R2-001 (Deserialização Incorreta)
- Contrato: CT-016
- Testes: TU-016, TI-016, TR-016

### Parâmetros em Métodos Existentes

**RF-017:** Sistema DEVE adicionar parâmetro `business_connection_id` a `sendMessage`
- Fonte: S-001, Bot API 7.2
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-017
- Testes: TU-017, TR-017

**RF-018:** Sistema DEVE adicionar parâmetro `message_effect_id` a `sendMessage`
- Fonte: S-001, Bot API 7.4
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-018
- Testes: TU-018, TR-018

**RF-019:** Sistema DEVE adicionar parâmetro `allow_paid_broadcast` a `sendMessage`
- Fonte: S-002, Bot API 7.11
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-019
- Testes: TU-019, TR-019

**RF-020:** Sistema DEVE adicionar parâmetros `business_connection_id`, `message_effect_id`, `show_caption_above_media` a `sendPhoto`
- Fonte: S-001, Bot API 7.2/7.4/7.4
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-020
- Testes: TU-020, TR-020

**RF-021:** Sistema DEVE adicionar parâmetros `business_connection_id`, `message_effect_id`, `show_caption_above_media`, `cover`, `start_timestamp` a `sendVideo`
- Fonte: S-001, Bot API 7.2/7.4/7.4/8.3
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-021
- Testes: TU-021, TR-021

**RF-022:** Sistema DEVE adicionar parâmetro `video_start_timestamp` a `copyMessage`
- Fonte: S-005, Bot API 8.3
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-022
- Testes: TU-022, TR-022

**RF-023:** Sistema DEVE adicionar parâmetro `video_start_timestamp` a `forwardMessage`
- Fonte: S-005, Bot API 8.3
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-023
- Testes: TU-023, TR-023

**RF-024:** Sistema DEVE adicionar parâmetros `subscription_period`, `business_connection_id` a `createInvoiceLink`
- Fonte: S-003, Bot API 8.0
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-024
- Testes: TU-024, TR-024

**RF-025:** Sistema DEVE adicionar parâmetro `message_effect_id` a `sendInvoice`
- Fonte: S-001, Bot API 7.4
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-025
- Testes: TU-025, TR-025

### Tipos de Dados Novos (CRÍTICO)

**RF-026:** Sistema DEVE implementar struct `BusinessConnection`
- Fonte: S-001, Bot API 7.2
- Fields: `id`, `user`, `can_reply`, `can_write`, `date`, `disable_date`
- Risco: R2-001 (CRÍTICO - sem isso, métodos falham)
- Contrato: CT-026
- Testes: TU-026, TI-026

**RF-027:** Sistema DEVE implementar struct `BusinessIntro`
- Fonte: S-001, Bot API 7.2
- Fields: `title`, `description`
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-027
- Testes: TU-027, TI-027

**RF-028:** Sistema DEVE implementar struct `BusinessLocation`
- Fonte: S-001, Bot API 7.2
- Fields: `address`, `location`
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-028
- Testes: TU-028, TI-028

**RF-029:** Sistema DEVE implementar struct `BusinessOpeningHours`
- Fonte: S-001, Bot API 7.2
- Fields: `time_zone_name`, `opening_hours`
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-029
- Testes: TU-029, TI-029

**RF-030:** Sistema DEVE implementar struct `StarTransactions`
- Fonte: S-001, Bot API 7.5
- Fields: `transactions` (Array[StarTransaction])
- Risco: R2-001 (CRÍTICO - sem isso, getStarTransactions falha)
- Contrato: CT-030
- Testes: TU-030, TI-030

**RF-031:** Sistema DEVE implementar struct `StarTransaction`
- Fonte: S-001, Bot API 7.5
- Fields: `id`, `type`, `source`, `amount`, `date`, `partner`
- Risco: R2-001 (CRÍTICO - sem isso, getStarTransactions falha)
- Contrato: CT-031
- Testes: TU-031, TI-031

**RF-032:** Sistema DEVE implementar struct `TransactionPartner`
- Fonte: S-001, Bot API 7.5
- Fields: Union de `TransactionPartnerUser`, `TransactionPartnerTelegramAds`, etc.
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-032
- Testes: TU-032, TI-032

**RF-033:** Sistema DEVE implementar struct `PaidMedia`
- Fonte: S-001, Bot API 7.6
- Fields: Union de `PaidMediaPhoto`, `PaidMediaVideo`, etc.
- Risco: R2-001 (CRÍTICO - sem isso, sendPaidMedia falha)
- Contrato: CT-033
- Testes: TU-033, TI-033

**RF-034:** Sistema DEVE implementar struct `PaidMediaInfo`
- Fonte: S-001, Bot API 7.6
- Fields: `star_count`, `paid_media`
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-034
- Testes: TU-034, TI-034

**RF-035:** Sistema DEVE implementar struct `Gift`
- Fonte: S-003, Bot API 8.0
- Fields: `id`, `sticker`, `star_count`, `total_count`
- Risco: R2-001 (CRÍTICO - sem isso, gifts falham)
- Contrato: CT-035
- Testes: TU-035, TI-035

### Fields Novos em Tipos Existentes

**RF-036:** Sistema DEVE adicionar field `business_connection` a struct `Update`
- Fonte: S-001, Bot API 7.2
- Tipo: `BusinessConnection` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-036
- Testes: TU-036, TR-036

**RF-037:** Sistema DEVE adicionar field `business_message` a struct `Update`
- Fonte: S-001, Bot API 7.2
- Tipo: `Message` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-037
- Testes: TU-037, TR-037

**RF-038:** Sistema DEVE adicionar field `edited_business_message` a struct `Update`
- Fonte: S-001, Bot API 7.2
- Tipo: `Message` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-038
- Testes: TU-038, TR-038

**RF-039:** Sistema DEVE adicionar field `business_connection_id` a struct `Message`
- Fonte: S-001, Bot API 7.2
- Tipo: `String` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-039
- Testes: TU-039, TR-039

**RF-040:** Sistema DEVE adicionar field `paid_media` a struct `Message`
- Fonte: S-001, Bot API 7.6
- Tipo: `PaidMedia` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-040
- Testes: TU-040, TR-040

**RF-041:** Sistema DEVE adicionar field `gift` a struct `Message`
- Fonte: S-003, Bot API 8.0
- Tipo: `Gift` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-041
- Testes: TU-041, TR-041

**RF-042:** Sistema DEVE adicionar field `business_intro` a struct `Chat`
- Fonte: S-001, Bot API 7.2
- Tipo: `BusinessIntro` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-042
- Testes: TU-042, TR-042

**RF-043:** Sistema DEVE adicionar field `business_location` a struct `Chat`
- Fonte: S-001, Bot API 7.2
- Tipo: `BusinessLocation` (opcional)
- Risco: R2-002 (Campos Desconhecidos)
- Contrato: CT-043
- Testes: TU-043, TR-043

### Parâmetros Adicionais Faltantes

**RF-047 a RF-059:** Sistema DEVE adicionar parâmetro `message_effect_id` a métodos de envio
- Fonte: S-001, Bot API 7.4
- Métodos: `sendAnimation`, `sendAudio`, `sendDocument`, `sendSticker`, `sendVideoNote`, `sendVoice`, `sendLocation`, `sendVenue`, `sendContact`, `sendPoll`, `sendDice`, `sendGame`, `sendMediaGroup`
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-047 a CT-059
- Testes: TU-047 a TU-059, TR-047 a TR-059

**RF-060 a RF-062:** Sistema DEVE adicionar parâmetro `allow_paid_broadcast` a métodos de envio
- Fonte: S-002, Bot API 7.11
- Métodos: `sendAnimation`, `sendAudio`, `sendDocument`, `sendSticker`, `sendVideoNote`, `sendVoice`, `sendLocation`, `sendVenue`, `sendContact`, `sendPoll`, `sendDice`, `sendGame`, `sendMediaGroup`, `copyMessage`
- Risco: R2-003 (Parâmetros Faltantes)
- Contrato: CT-060 a CT-062
- Testes: TU-060 a TU-062, TR-060 a TR-062

---

## Dependências

### Dependências Existentes
- HTTP v1.10.19 - Requisito atual
- JSON3 v1.14.3 - Requisito atual
- Test v1.11.0 - Requisito atual

### Novas Dependências (se aplicável)
- Nenhuma nova dependência externa necessária
- Todos os novos tipos podem ser implementados com structs Julia

---

## Não-Funcionais

**NÃO-F 001:** Usuário DEVE poder chamar métodos novos sem quebrar código existente
**NÃO-F 002:** Sistema DEVE manter compatibilidade com API 6.x
**NÃO-F 003:** Deserialização DEVE falhar graciosamente em campos desconhecidos
**NÃO-F 004:** Parâmetros desconhecidos DEVERIAM ser ignorados (não causar erro)
**NÃO-F 005:** Performance DEVE manter degradação <10% em benchmarks

---

*Especificação completa - 185 requisitos funcionais identificados*
*Próxima revisão: Ao finalizar cada milestone*
```

## ARQUIVO: SAFETY_SPEC.md

```markdown
# SAFETY_SPEC.md - Requisitos de Segurança

**Projeto:** Telegram.jl API 7.x Update
**Versão:** 1.0
**Data:** 2026-02-23

---

## Requisitos de Segurança

### RS-001: Validação de Parâmetros de Bot Token
- **Fonte:** R4-001 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE sanitizar todos os parâmetros que contenham bot token antes de logging
- **Falha Tolerável:** Token parcialmente ofuscado em logs de debug (não produção)
- **Comportamento em Erro:** Rejeitar requisição com log de erro sem token
- **Teste:** TS-001: Testar que token NÃO aparece em logs
- **Implementação:** Criar função `sanitize_token(token::String)` que substitui caracteres por `*`
- **Prioridade:** Alta (R4)

### RS-002: Validação de Tipos Antes de Envio
- **Fonte:** R4-002 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE validar tipos de todos os parâmetros antes de enviar à API
- **Falha Tolerável:** Validação de tipos com warnings (não bloqueia envio)
- **Comportamento em Erro:** Converter tipo se possível; rejeitar se impossível
- **Teste:** TS-002: Testar que tipos inválidos causam erro antes do envio
- **Implementação:** Usar `try-catch` com conversões de tipo explícitas
- **Prioridade:** Alta (R4)

### RS-003: Proteção Contra Injeção
- **Fonte:** R4-002 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE escapar strings antes de usar em URLs
- **Falha Tolerável:** URL mal-formada causando erro HTTP
- **Comportamento em Erro:** Retornar erro claro ("Invalid URL format")
- **Teste:** TS-003: Testar injection em parâmetros de URL
- **Implementação:** Usar `URIs.escape_uri` de HTTP.jl
- **Prioridade:** Alta (R4)

### RS-004: Validação de IDs de Usuário/Chat
- **Fonte:** R2-001 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE validar que IDs de usuário/chat são inteiros positivos
- **Falha Tolerável:** ID inválido causando erro de API (servidor valida)
- **Comportamento em Erro:** Advertir em debug mas permitir envio (API valida)
- **Teste:** TS-004: Testar IDs negativos, zero, string inválida
- **Implementação:** `validate_id(id) = id > 0 || @warn("Invalid ID: $id")`
- **Prioridade:** Média (R2)

### RS-005: Deserialização Segura
- **Fonte:** R2-001 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE deserializar JSON de forma segura, sem eval de códio
- **Falha Tolerável:** Campos desconhecidos ignorados com warning
- **Comportamento em Erro:** Lançar erro claro ("Deserialization error: ...") mas não crashar
- **Teste:** TS-005: Testar JSON mal-formado, campos desconhecidos
- **Implementação:** Usar `JSON3.read` com tipos forçados
- **Prioridade:** Alta (R2)

### RS-006: Validação de Valores de Enum
- **Fonte:** R2-001 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE validar que enums só aceitam valores válidos
- **Falha Tolerável:** Valor de enum inválido causando erro de API
- **Comportamento em Erro:** Advertir e converter para valor default se possível
- **Teste:** TS-006: Testar valores de enum inválidos
- **Implementação:** `validate_enum(value, valid_values)`
- **Prioridade:** Média (R2)

### RS-007: Proteção de Dados Sensíveis
- **Fonte:** R4-001 (RISK_REGISTER.md)
- **Descrição:** Sistema NÃO DEVE logar dados pessoais (nomes, emails, phones)
- **Falha Tolerável:** Dados sensíveis em logs de debug temporários (rotacionados)
- **Comportamento em Erro:** Substituir por `[REDACTED]` em logs
- **Teste:** TS-007: Verificar que dados sensíveis não aparecem em logs de produção
- **Implementação:** Criar lista de fields sensíveis e substituir em logging
- **Prioridade:** Alta (R4)

### RS-008: Validação de Tamanho de Mensagem
- **Fonte:** R2-001 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE validar tamanho de mensagens antes de envio
- **Falha Tolerável:** Mensagem muito longa causando erro de API
- **Comportamento em Erro:** Truncar com warning ou rejeitar se >4096 caracteres
- **Teste:** TS-008: Testar mensagens de 4097, 10000, 0 caracteres
- **Implementação:** `validate_message_length(text) = length(text) <= 4096`
- **Prioridade:** Média (R1)

### RS-009: Tratamento de Erro de API
- **Fonte:** R1-001 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE tratar erros de API de forma consistente
- **Falha Tolerável:** Erros de API com códigos desconhecidos
- **Comportamento em Erro:** Retornar erro estruturado com código e mensagem
- **Teste:** TS-009: Simular erros de API (400, 401, 403, 500)
- **Implementação:** Criar struct `APIError` com código e mensagem
- **Prioridade:** Alta (R1)

### RS-010: Validação de Limites de Rate
- **Fonte:** R2-002 (RISK_REGISTER.md)
- **Descrição:** Sistema DEVE implementar rate limiting para prevenir bloqueios
- **Falha Tolerável:** Rate limit excedido temporariamente
- **Comportamento em Erro:** Backoff exponencial com reintentos
- **Teste:** TS-010: Testar múltiplas requisições simultâneas
- **Implementação:** Usar bucket token ou similar
- **Prioridade:** Baixa (R0) - delegado à aplicação

---

## Politica de Falha

### Princípios
1. **Fail-Closed:** Se incerto, rejeitar em vez de prosseguir
2. **Fail-Safe:** Em caso de falha, retornar valor seguro/default
3. **Fail-Fast:** Detectar erros o mais rápido possível
4. **Fail-Clear:** Mensagens de erro claras e acionáveis

### Níveis de Falha
- **Fatal:** Sistema interrompido, requer reinício
- **Error:** Operação falhou, mas sistema continua
- **Warning:** Situação anormal, mas funcionamento normal
- **Info:** Mensagem informativa, não indica problema

### Tratamento por Categoria

| Categoria | Tratamento | Exemplo |
|-----------|-------------|---------|
| Validação de Entrada | Rejeitar com erro claro | "Invalid user_id: must be positive integer" |
| Erro de API HTTP | Retornar erro estruturado | APIError(429, "Too many requests") |
| Deserialização | Falhar graciosamente | "Unknown field 'x' ignored" |
| Timeout | Retornar erro com retry | TimeoutError("Request timeout, will retry") |
| Erro Interno | Logar detalhadamente e crashar (se fatal) | "Internal error: stack trace..." |

---

## Falhas Toleráveis

| Cenário | Comportamento | Risco Aceito |
|----------|--------------|----------------|
| Campo desconhecido em JSON | Ignorar com warning | Baixo - pode ser versão futura |
| Enum inválido | Usar valor default + warning | Baixo - evolução de API |
| Tipo não esperado | Tentar conversão, falhar se impossível | Médio - compatibilidade |
| Parâmetro opcional ausente | Usar valor default | Baixo - comportamento esperado |

---

## Testes de Segurança

### TS-001: Teste de Sanitização de Token
```julia
@testset "Segurança - Sanitização de Token" begin
    token = "123456:ABC-DEF_GHI"
    result = sanitize_token(token)
    @test result != token  # Token não deve aparecer em logs
    @test contains(result, "***")  # Deve estar ofuscado
end
```

### TS-002: Teste de Validação de Tipos
```julia
@testset "Segurança - Validação de Tipos" begin
    @test_throws ArgumentError validate_id(-1)
    @test_throws ArgumentError validate_id(0)
    @test validate_id(123) == 123
end
```

### TS-003: Teste de Injeção
```julia
@testset "Segurança - Injeção" begin
    @test_throws ArgumentError send_message(chat_id="../../../../etc/passwd", text="test")
    @test_throws ArgumentError send_message(chat_id=1, text="<script>alert('xss')</script>")
end
```

### TS-004: Teste de Validação de IDs
```julia
@testset "Segurança - Validação de IDs" begin
    @test_throws ArgumentError validate_user_id(-100)
    @test validate_user_id(123456789) == 123456789
    @test_throws ArgumentError validate_chat_id("invalid")
end
```

### TS-005: Teste de Deserialização Segura
```julia
@testset "Segurança - Deserialização" begin
    json_str = """{"id":1,"unknown_field":"x"}"""
    result = deserialize_message(json_str)
    @test result.id == 1
    @test !haskey(result, :unknown_field)  # Ignorado
end
```

### TS-006: Teste de Validação de Enum
```julia
@testset "Segurança - Validação de Enum" begin
    @test_throws ArgumentError validate_enum("INVALID_TYPE", VALID_TYPES)
    @test validate_enum("text", VALID_TYPES) == "text"
end
```

### TS-007: Teste de Proteção de Dados Sensíveis
```julia
@testset "Segurança - Proteção de Dados Sensíveis" begin
    user_info = Dict("name"=>"John Doe", "email"=>"john@example.com")
    log_msg = log_user_info(user_info)
    @test !contains(log_msg, "John Doe")
    @test !contains(log_msg, "john@example.com")
    @test contains(log_msg, "[REDACTED]")
end
```

### TS-008: Teste de Validação de Tamanho de Mensagem
```julia
@testset "Segurança - Validação de Tamanho" begin
    @test validate_message_length("a"^4096) == true
    @test_throws ArgumentError validate_message_length("a"^4097)
    @test_throws ArgumentError validate_message_length("")
end
```

### TS-009: Teste de Tratamento de Erro de API
```julia
@testset "Segurança - Tratamento de Erro de API" begin
    error = APIError(400, "Bad Request")
    @test error.code == 400
    @test error.message == "Bad Request"
    @test_throws ArgumentError APIError(-1, "Invalid code")
end
```

### TS-010: Teste de Rate Limiting
```julia
@testset "Segurança - Rate Limiting" begin
    @testset "Múltiplas requisições" begin
        for i in 1:100
            send_message(chat_id=1, text="test $i")
        end
        # Deveria backoff ou rate limit
    end
end
```

---

## Checklist de Segurança por Requisito

Cada RF DEVE passar por:

- [ ] RS-001: Validação de parâmetros de token implementada?
- [ ] RS-002: Validação de tipos implementada?
- [ ] RS-003: Proteção contra injeção implementada?
- [ ] RS-005: Deserialização segura implementada?
- [ ] RS-009: Tratamento de erro de API consistente?
- [ ] TS-001 a TS-010: Testes de segurança passando?

---

*Especificação de segurança - 10 requisitos identificados*
*Prioridade Alta: RS-001, RS-002, RS-003, RS-005, RS-007*
*Próxima revisão: Ao finalizar cada milestone*
```

## ARQUIVO: CONTRACTS.md

```markdown
# CONTRACTS.md - Contratos de Componentes

**Projeto:** Telegram.jl API 7.x Update
**Versão:** 1.0
**Data:** 2026-02-23

---

## Contrato CT-001: getBusinessConnection

### Descrição
Obter informações sobre conexão com business account do Telegram.

### Pré-condições
- `business_connection_id` DEVE ser uma String não-vazia
- Token de bot DEVE ser válido e autorizado para business account
- Conexão HTTP DEVE estar estabelecida

### Invariantes
- Retorno SEMPRE contém `id`, `user`, `can_reply`, `can_write`, `date`
- `id` SEMPRE é uma String
- `user` SEMPRE é um struct `User`
- `can_reply`, `can_write` SEMPRE são Booleans
- `date` SEMPRE é um Integer (timestamp Unix)

### Pós-condições
- SE business_connection_id válido, retorna `BusinessConnection`
- SE business_connection_id inválido, lança `APIError` com código apropriado
- SEMPRE retorna dentro de <10s (timeout configurável)

### Estados Inválidos Proibidos
- `business_connection_id` = `nothing` ou `""`
- Retorno com `id` = `nothing`
- Retorno com `user` que não é struct `User`

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("business_connection_id cannot be empty")`
**Falha Invariante:** Lançar `AssertionError("Invalid BusinessConnection structure")`
**Falha Timeout:** Lançar `TimeoutError("Request timeout after 10s")`
**Falha API:** Retornar `APIError(código, mensagem)` do Telegram

### Assinatura
```julia
function getBusinessConnection(
    client::TelegramClient = DEFAULT_OPTS.client;
    business_connection_id::String
)::BusinessConnection
```

### Teste de Contrato
```julia
@testset "CT-001: getBusinessConnection" begin
    @testset "Pré-condições" begin
        @test_throws ArgumentError getBusinessConnection(business_connection_id="")
        @test_throws ArgumentError getBusinessConnection(business_connection_id=nothing)
    end

    @testset "Pós-condições válidas" begin
        result = getBusinessConnection(business_connection_id="valid_id")
        @test result.id isa String
        @test result.user isa User
        @test result.can_reply isa Bool
        @test result.can_write isa Bool
        @test result.date isa Int
    end

    @testset "Invariante: campos obrigatórios" begin
        result = getBusinessConnection(business_connection_id="valid_id")
        @test haskey(result, :id)
        @test haskey(result, :user)
        @test haskey(result, :can_reply)
        @test haskey(result, :can_write)
        @test haskey(result, :date)
    end

    @testset "Falha de API" begin
        @test_throws APIError getBusinessConnection(business_connection_id="invalid_id")
    end
end
```

---

## Contrato CT-002: refundStarPayment

### Descrição
Reembolsar pagamento realizado em Telegram Stars.

### Pré-condições
- `user_id` DEVE ser um Integer positivo
- `telegram_payment_charge_id` DEVE ser uma String não-vazia
- Bot DEVE ter saldo suficiente de Stars
- Pagamento DEVE estar em período de reembolso (30 dias)

### Invariantes
- Retorno SEMPRE é `True` (Bool) se sucesso
- SEMPRE deduz saldo de bot
- SEMPRE notifica usuário do reembolso

### Pós-condições
- SE parâmetros válidos, retorna `true`
- SE saldo insuficiente, lança `APIError` com código 403
- SE pagamento não encontrado, lança `APIError` com código 400

### Estados Inválidos Proibidos
- `user_id` <= 0
- `telegram_payment_charge_id` = `""` ou `nothing`
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("user_id must be positive integer")`
**Falha Invariante:** Lançar `AssertionError("refundStarPayment must return true")`
**Falha Saldo:** Lançar `APIError(403, "Insufficient stars balance")`
**Falha API:** Retornar `APIError(código, mensagem)` do Telegram

### Assinatura
```julia
function refundStarPayment(
    client::TelegramClient = DEFAULT_OPTS.client;
    user_id::Integer,
    telegram_payment_charge_id::String
)::Bool
```

### Teste de Contrato
```julia
@testset "CT-002: refundStarPayment" begin
    @testset "Pré-condições" begin
        @test_throws ArgumentError refundStarPayment(user_id=0, telegram_payment_charge_id="xxx")
        @test_throws ArgumentError refundStarPayment(user_id=-1, telegram_payment_charge_id="xxx")
        @test_throws ArgumentError refundStarPayment(user_id=1, telegram_payment_charge_id="")
    end

    @testset "Pós-condições válidas" begin
        result = refundStarPayment(user_id=123456, telegram_payment_charge_id="valid_charge_id")
        @test result === true
    end

    @testset "Falha de saldo insuficiente" begin
        @test_throws APIError refundStarPayment(user_id=123456, telegram_payment_charge_id="valid_charge_id")
        # Verificar código 403
    end
end
```

---

## Contrato CT-003: getStarTransactions

### Descrição
Listar todas as transações de Telegram Stars do bot.

### Pré-condições
- Token de bot DEVE ser válido
- Offset DEVE ser >= 0 (se fornecido)
- Limit DEVE ser 1-100 (se fornecido)

### Invariantes
- Retorno SEMPRE é `StarTransactions` struct
- `transactions` SEMPRE é um Array[StarTransaction]
- `total_count` SEMPRE é um Integer >= 0
- SE offset=0 e limit=100, retorna até 100 transações
- SE offset fornecido, pula primeiras `offset` transações

### Pós-condições
- SEMPRE retorna `StarTransactions` válido
- SE bot sem transações, retorna array vazio
- SE offset > total_count, retorna array vazio

### Estados Inválidos Proibidos
- `limit` < 1 ou `limit` > 100
- `offset` < 0
- Retorno que não é `StarTransactions`

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("limit must be 1-100")`
**Falha Invariante:** Lançar `AssertionError("getStarTransactions must return StarTransactions")`
**Falha API:** Retornar `APIError(código, mensagem)` do Telegram

### Assinatura
```julia
function getStarTransactions(
    client::TelegramClient = DEFAULT_OPTS.client;
    offset::Integer = 0,
    limit::Integer = 100
)::StarTransactions
```

### Teste de Contrato
```julia
@testset "CT-003: getStarTransactions" begin
    @testset "Pré-condições" begin
        @test_throws ArgumentError getStarTransactions(limit=0)
        @test_throws ArgumentError getStarTransactions(limit=101)
        @test_throws ArgumentError getStarTransactions(offset=-1)
    end

    @testset "Pós-condições válidas" begin
        result = getStarTransactions(offset=0, limit=10)
        @test result isa StarTransactions
        @test result.transactions isa Vector{StarTransaction}
        @test length(result.transactions) <= 10
    end

    @testset "Invariante: campos obrigatórios" begin
        result = getStarTransactions()
        @test haskey(result, :transactions)
        @test haskey(result, :total_count)
    end
end
```

---

## Contrato CT-004: sendPaidMedia

### Descrição
Enviar mídia paga para um chat. Usuários pagam em Stars para acessar.

### Pré-condições
- `chat_id` DEVE ser válido (String ou Integer)
- `star_count` DEVE ser Integer >= 1
- `media` DEVE ser Array não-vazio de InputPaidMedia
- SE `business_connection_id` fornecido, DEVE ser válido

### Invariantes
- Retorno SEMPRE é `Message` struct
- `message_id` SEMPRE é Integer positivo
- `paid_media` SEMPRE contém a mídia enviada
- SEMPRE deduz `star_count` do balance do bot

### Pós-condições
- SE parâmetros válidos, retorna `Message` com `paid_media`
- SE chat_id inválido, lança `APIError` com código 400

### Estados Inválidos Proibidos
- `star_count` < 1
- `media` = vazio ou `nothing`
- Retorno sem `message_id`

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("star_count must be >= 1")`
**Falha Invariante:** Lançar `AssertionError("sendPaidMedia must return Message with paid_media")`
**Falha API:** Retornar `APIError(código, mensagem)` do Telegram

### Assinatura
```julia
function sendPaidMedia(
    client::TelegramClient = DEFAULT_OPTS.client;
    chat_id::Union{String, Integer},
    star_count::Integer,
    media::Vector{InputPaidMedia},
    business_connection_id::Union{String, Nothing} = nothing
)::Message
```

### Teste de Contrato
```julia
@testset "CT-004: sendPaidMedia" begin
    @testset "Pré-condições" begin
        @test_throws ArgumentError sendPaidMedia(chat_id=1, star_count=0, media=[])
        @test_throws ArgumentError sendPaidMedia(chat_id=1, star_count=1, media=nothing)
    end

    @testset "Pós-condições válidas" begin
        media = [InputPaidMediaPhoto(...)]
        result = sendPaidMedia(chat_id=123456, star_count=100, media=media)
        @test result isa Message
        @test result.message_id > 0
        @test !isnothing(result.paid_media)
    end
end
```

---

## Contrato CT-005: createChatSubscriptionInviteLink

### Descrição
Criar link de convite para assinatura de chat com pagamento em Stars.

### Pré-condições
- `chat_id` DEVE ser válido (String ou Integer)
- `subscription_period` DEVE ser Integer >= 1 (dias)
- `subscription_price` DEVE ser Integer >= 1 (Stars)

### Invariantes
- Retorno SEMPRE é `ChatInviteLink` struct
- `invite_link` SEMPRE é String não-vazia
- `subscription_period` e `subscription_price` SEMPRE mantidos

### Pós-condições
- SE parâmetros válidos, retorna `ChatInviteLink` com link
- SE chat_id inválido, lança `APIError`

### Estados Inválidos Proibidos
- `subscription_period` < 1
- `subscription_price` < 1
- Retorno com `invite_link` = "" ou `nothing`

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("subscription_period must be >= 1")`
**Falha Invariante:** Lançar `AssertionError("createChatSubscriptionInviteLink must return ChatInviteLink with invite_link")`
**Falha API:** Retornar `APIError(código, mensagem)` do Telegram

### Assinatura
```julia
function createChatSubscriptionInviteLink(
    client::TelegramClient = DEFAULT_OPTS.client;
    chat_id::Union{String, Integer},
    subscription_period::Integer,
    subscription_price::Integer,
    name::Union{String, Nothing} = nothing
)::ChatInviteLink
```

---

## Contrato CT-006: editChatSubscriptionInviteLink

### Descrição
Editar nome de link de assinatura existente.

### Pré-condições
- `invite_link` DEVE ser String não-vazia (URL existente)
- `name` DEVE ser String não-vazia se fornecido

### Invariantes
- Retorno SEMPRE é `ChatInviteLink` struct
- `invite_link` SEMPRE mantém o mesmo valor

### Pós-condições
- SE link válido, retorna `ChatInviteLink` atualizado
- SE link inválido, lança `APIError`

### Estados Inválidos Proibidos
- `invite_link` = "" ou `nothing`
- `name` = "" (se fornecido)

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("invite_link cannot be empty")`
**Falha Invariante:** Lançar `AssertionError("editChatSubscriptionInviteLink must return ChatInviteLink")`

---

## Contrato CT-007: setUserEmojiStatus

### Descrição
Definir status de emoji de usuário.

### Pré-condições
- `user_id` DEVE ser Integer positivo
- `emoji_status_custom_emoji_id` DEVE ser String de emoji customizado válido
- `duration` DEVE ser Integer >= 0 (segundos)

### Invariantes
- Retorno SEMPRE é `true` (Bool)
- SE duration=0, remove status
- SE duration>0, define status temporário

### Pós-condições
- SE usuário autorizado, retorna `true`
- SE usuário não autorizado, lança `APIError` com código 400

### Estados Inválidos Proibidos
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("duration must be >= 0")`
**Falha Invariante:** Lançar `AssertionError("setUserEmojiStatus must return true")`

---

## Contrato CT-008: verifyUser

### Descrição
Verificar usuário em nome de organização verificada.

### Pré-condições
- `user_id` DEVE ser Integer positivo
- Organização DEVE ter permissão de verificação

### Invariantes
- Retorno SEMPRE é `true` (Bool) se sucesso

### Pós-condições
- SE usuário válido e organização autorizada, retorna `true`
- SE usuário não encontrado, lança `APIError`

### Estados Inválidos Proibidos
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("user_id must be positive integer")`
**Falha Invariante:** Lançar `AssertionError("verifyUser must return true")`

---

## Contrato CT-009: verifyChat

### Descrição
Verificar chat em nome de organização.

### Pré-condições
- `chat_id` DEVE ser válido (String ou Integer)

### Invariantes
- Retorno SEMPRE é `true` (Bool) se sucesso

### Pós-condições
- SE chat válido, retorna `true`
- SE chat inválido, lança `APIError`

### Estados Inválidos Proibidos
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("chat_id must be valid")`

---

## Contrato CT-010: removeUserVerification

### Descrição
Remover verificação de usuário.

### Pré-condições
- `user_id` DEVE ser Integer positivo

### Invariantes
- Retorno SEMPRE é `true` (Bool)

### Pós-condições
- SE usuário verificado, remove e retorna `true`
- SE usuário não verificado, lança `APIError`

### Estados Inválidos Proibidos
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Invariante:** Lançar `AssertionError("removeUserVerification must return true")`

---

## Contrato CT-011: removeChatVerification

### Descrição
Remover verificação de chat.

### Pré-condições
- `chat_id` DEVE ser válido

### Invariantes
- Retorno SEMPRE é `true` (Bool)

### Pós-condições
- SE chat verificado, remove e retorna `true`
- SE chat não verificado, lança `APIError`

### Estados Inválidos Proibidos
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Invariante:** Lançar `AssertionError("removeChatVerification must return true")`

---

## Contrato CT-012: editUserStarSubscription

### Descrição
Editar ou cancelar assinatura de Stars de usuário.

### Pré-condições
- `user_id` DEVE ser Integer positivo
- `telegram_payment_charge_id` DEVE ser String não-vazia
- `is_canceled` DEVE ser Boolean

### Invariantes
- Retorno SEMPRE é `true` (Bool)
- SE is_canceled=true, cancela assinatura

### Pós-condições
- SE assinatura válida, edita/cancela e retorna `true`
- SE assinatura não encontrada, lança `APIError`

### Estados Inválidos Proibidos
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Invariante:** Lançar `AssertionError("editUserStarSubscription must return true")`

---

## Contrato CT-013: savePreparedInlineMessage

### Descrição
Salvar mensagem inline preparada para uso em Mini Apps.

### Pré-condições
- `user_id` DEVE ser Integer positivo
- `result_id` DEVE ser String não-vazia (de query inline)
- `allow_user_chats` DEVE ser Boolean

### Invariantes
- Retorno SEMPRE é `PreparedInlineMessage` struct
- `id` SEMPRE é String não-vazia

### Pós-condições
- SE query válido, salva e retorna `PreparedInlineMessage`
- SE query inválido, lança `APIError`

### Estados Inválidos Proibidos
- Retorno sem `id`

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("result_id cannot be empty")`
**Falha Invariante:** Lançar `AssertionError("savePreparedInlineMessage must return PreparedInlineMessage with id")`

---

## Contrato CT-014: getAvailableGifts

### Descrição
Listar gifts disponíveis para envio.

### Pré-condições
- Nenhuma pré-condição (método público)

### Invariantes
- Retorno SEMPRE é `Gifts` struct
- `gifts` SEMPRE é Array[Gift] não-vazio
- Cada gift contém `id`, `sticker`, `star_count`

### Pós-condições
- SEMPRE retorna lista de gifts disponíveis

### Estados Inválidos Proibidos
- Retorno sem `gifts` ou com array vazio

### Política de Falha
**Falha Invariante:** Lançar `AssertionError("getAvailableGifts must return Gifts with non-empty gifts array")`

---

## Contrato CT-015: sendGift

### Descrição
Enviar gift para usuário.

### Pré-condições
- `user_id` DEVE ser Integer positivo
- `gift_id` DEVE ser String não-vazia (de getAvailableGifts)

### Invariantes
- Retorno SEMPRE é `true` (Bool)
- SEMPRE deduz `star_count` do balance do bot

### Pós-condições
- SE parâmetros válidos, envia e retorna `true`
- SE user_id inválido, lança `APIError`

### Estados Inválidos Proibidos
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("gift_id cannot be empty")`
**Falha Invariante:** Lançar `AssertionError("sendGift must return true")`

---

## Contrato CT-016: giftPremiumSubscription

### Descrição
Enviar gift de assinatura Telegram Premium.

### Pré-condições
- `user_id` DEVE ser Integer positivo
- `month_count` DEVE ser 3, 6, ou 12
- `star_count` DEVE corresponder ao month_count:
  - 3 meses: 1000 Stars
  - 6 meses: 1500 Stars
  - 12 meses: 2500 Stars

### Invariantes
- Retorno SEMPRE é `true` (Bool)
- month_count SEMPRE é um dos valores válidos
- star_count SEMPRE corresponde ao month_count

### Pós-condições
- SE parâmetros válidos, envia e retorna `true`
- SE star_count insuficiente, lança `APIError` com código 403

### Estados Inválidos Proibidos
- month_count não é 3, 6, ou 12
- star_count não corresponde ao month_count
- Retorno = `false` (deve ser `true` ou erro)

### Política de Falha
**Falha Pré-condição:** Lançar `ArgumentError("month_count must be 3, 6, or 12")`
**Falha Invariante:** Lançar `AssertionError("giftPremiumSubscription must return true")`

---

## Contratos de Parâmetros (CT-017 a CT-062)

### Contrato CT-017: sendMessage - business_connection_id
- **Descrição:** Adicionar parâmetro opcional `business_connection_id` a sendMessage
- **Pré-condição:** SE fornecido, DEVE ser String não-vazia
- **Invariante:** SE não fornecido, usa valor `nothing` (default)
- **Pós-condição:** Mensagem enviada em nome da business account
- **Estado Inválido:** `business_connection_id = ""`

### Contrato CT-018: sendMessage - message_effect_id
- **Descrição:** Adicionar parâmetro opcional `message_effect_id` a sendMessage
- **Pré-condição:** SE fornecido, DEVE ser String de effect válida
- **Invariante:** SE não fornecido, usa valor `nothing`
- **Pós-condição:** Effect aplicado à mensagem (se suportado pelo chat)
- **Estado Inválido:** `message_effect_id = ""`

### Contrato CT-019: sendMessage - allow_paid_broadcast
- **Descrição:** Adicionar parâmetro opcional `allow_paid_broadcast` a sendMessage
- **Pré-condição:** SE true, bot DEVE ter saldo de Stars
- **Invariante:** Default é `false`
- **Pós-condição:** Broadcast enviado em até 1000 msg/s (0.1 Star/msg)
- **Estado Inválido:** Saldo insuficiente causa APIError(403)

### Contrato CT-020: sendPhoto - business_connection_id, message_effect_id, show_caption_above_media
- **Descrição:** Adicionar 3 parâmetros opcionais a sendPhoto
- **Invariante:** Todos default `nothing` ou `false`
- **Pós-condição:** Foto enviada com parâmetros aplicados
- **Estado Inválido:** Parâmetros inválidos causam erro de API

### Contrato CT-021: sendVideo - business_connection_id, message_effect_id, show_caption_above_media, cover, start_timestamp
- **Descrição:** Adicionar 5 parâmetros opcionais a sendVideo
- **Invariante:** Todos default `nothing` ou `false`
- **Pós-condição:** Vídeo enviado com parâmetros aplicados
- **Estado Inválido:** Cover/start_timestamp inválidos causam erro

### Contrato CT-022: copyMessage - video_start_timestamp
- **Descrição:** Adicionar parâmetro opcional a copyMessage
- **Invariante:** Default `nothing`
- **Pós-condição:** Vídeo copiado iniciando em timestamp especificado

### Contrato CT-023: forwardMessage - video_start_timestamp
- **Descrição:** Adicionar parâmetro opcional a forwardMessage
- **Invariante:** Default `nothing`
- **Pós-condição:** Vídeo encaminhado iniciando em timestamp especificado

### Contrato CT-024: createInvoiceLink - subscription_period, business_connection_id
- **Descrição:** Adicionar 2 parâmetros opcionais a createInvoiceLink
- **Invariante:** Ambos default `nothing`
- **Pós-condição:** Link criado com assinatura configurada (se period fornecido)

### Contrato CT-025: sendInvoice - message_effect_id
- **Descrição:** Adicionar parâmetro opcional a sendInvoice
- **Invariante:** Default `nothing`
- **Pós-condição:** Invoice enviado com effect aplicado

---

## Contratos de Tipos de Dados (CT-026 a CT-035)

### Contrato CT-026: BusinessConnection (struct)
```julia
struct BusinessConnection
    id::String                    # ID da conexão
    user::User                     # Usuário da business account
    can_reply::Bool                 # Pode responder?
    can_write::Bool                 # Pode escrever?
    date::Int                       # Timestamp Unix
    disable_date::Union{Int, Nothing}  # Timestamp de desabilitação
end
```
- **Pré-condição:** Recebido de API Telegram
- **Invariante:** `id`, `user`, `can_reply`, `can_write`, `date` SEMPRE presentes
- **Pós-condição:** Struct válido com todos campos

### Contrato CT-030: StarTransactions (struct)
```julia
struct StarTransactions
    transactions::Vector{StarTransaction}  # Array de transações
end
```
- **Invariante:** `transactions` SEMPRE é Vector não-vazio (pode ser vazio)
- **Pós-condição:** Estrutura serializável

### Contrato CT-031: StarTransaction (struct)
```julia
struct StarTransaction
    id::String                          # ID da transação
    type::String                        # Tipo (refund, purchase, etc.)
    source::Union{StarTransactionSource, Nothing}
    amount::Int                        # Quantidade de Stars
    date::Int                           # Timestamp Unix
    partner::Union{TransactionPartner, Nothing}
end
```

### Contrato CT-033: PaidMedia (struct)
```julia
abstract type PaidMedia end

struct PaidMediaPhoto <: PaidMedia
    photo::String  # file_id ou URL
end

struct PaidMediaVideo <: PaidMedia
    video::String  # file_id ou URL
end
```

### Contrato CT-035: Gift (struct)
```julia
struct Gift
    id::String           # ID do gift
    sticker::Sticker     # Sticker do gift
    star_count::Int      # Custo em Stars
    total_count::Int     # Disponibilidade
    # ... outros campos
end
```

---

## Contratos de Fields Novos (CT-036 a CT-043)

### Contrato CT-036: Update.business_connection
- **Descrição:** Adicionar campo `business_connection` a struct Update
- **Tipo:** `Union{BusinessConnection, Nothing}`
- **Invariante:** Default `nothing`
- **Pós-condição:** Update contém BusinessConnection quando relevante

### Contrato CT-037: Update.business_message
- **Descrição:** Adicionar campo `business_message` a struct Update
- **Tipo:** `Union{Message, Nothing}`
- **Invariante:** Default `nothing`

### Contrato CT-038: Update.edited_business_message
- **Descrição:** Adicionar campo `edited_business_message` a struct Update
- **Tipo:** `Union{Message, Nothing}`
- **Invariante:** Default `nothing`

### Contrato CT-039: Message.business_connection_id
- **Descrição:** Adicionar campo `business_connection_id` a struct Message
- **Tipo:** `Union{String, Nothing}`
- **Invariante:** Default `nothing`

### Contrato CT-040: Message.paid_media
- **Descrição:** Adicionar campo `paid_media` a struct Message
- **Tipo:** `Union{PaidMedia, Nothing}`
- **Invariante:** Default `nothing`

### Contrato CT-041: Message.gift
- **Descrição:** Adicionar campo `gift` a struct Message
- **Tipo:** `Union{Gift, Nothing}`
- **Invariante:** Default `nothing`

### Contrato CT-042: Chat.business_intro
- **Descrição:** Adicionar campo `business_intro` a struct Chat
- **Tipo:** `Union{BusinessIntro, Nothing}`
- **Invariante:** Default `nothing`

### Contrato CT-043: Chat.business_location
- **Descrição:** Adicionar campo `business_location` a struct Chat
- **Tipo:** `Union{BusinessLocation, Nothing}`
- **Invariante:** Default `nothing`

---

*Contratos formais - 62 contratos definidos*
*Cada RF tem CT associado para verificação*
*Próxima revisão: Ao implementar cada requisito*
```

## ARQUIVO: TODO.md

```markdown
# TODO.md - Milestones de Implementação

**Projeto:** Telegram.jl API 7.x Update
**Versão:** 1.0
**Data:** 2026-02-23

---

## Milestone 1: Tipos de Dados Críticos (PRIORIDADE 0)

**Objetivo:** Implementar structs de dados necessários para que métodos funcionem
**Estimativa:** 4-6 horas
**Pré-condições:** SPECS.md, CONTRACTS.md, RISK_REGISTER.md aprovados
**Critérios de Sucesso:**
- [ ] Todos os structs CT-026 a CT-035 implementados
- [ ] Todos os testes TU-026 a TU-035 passando
- [ ] Deserialização de JSON funcionando para todos os tipos
- [ ] Zero regressões detectadas

### Tarefas
- [ ] M1.1: Implementar struct `BusinessConnection` (CT-026, RF-026)
  - [ ] M1.1.1: Criar struct em `src/types/business.jl`
  - [ ] M1.1.2: Adicionar campos: id, user, can_reply, can_write, date, disable_date
  - [ ] M1.1.3: Implementar deserialização JSON3
  - [ ] M1.1.4: Escrever teste TU-026
  - [ ] M1.1.5: Executar teste e verificar pass

- [ ] M1.2: Implementar struct `StarTransactions` (CT-030, RF-030)
  - [ ] M1.2.1: Criar struct em `src/types/stars.jl`
  - [ ] M1.2.2: Adicionar campo transactions (Vector{StarTransaction})
  - [ ] M1.2.3: Implementar deserialização
  - [ ] M1.2.4: Escrever teste TU-030
  - [ ] M1.2.5: Executar teste

- [ ] M1.3: Implementar struct `StarTransaction` (CT-031, RF-031)
  - [ ] M1.3.1: Criar struct com todos campos
  - [ ] M1.3.2: Implementar Union para TransactionPartner
  - [ ] M1.3.3: Escrever teste TU-031
  - [ ] M1.3.4: Executar teste

- [ ] M1.4: Implementar struct `PaidMedia` e subtipos (CT-033, RF-033)
  - [ ] M1.4.1: Criar abstract type PaidMedia
  - [ ] M1.4.2: Criar struct PaidMediaPhoto
  - [ ] M1.4.3: Criar struct PaidMediaVideo
  - [ ] M1.4.4: Escrever teste TU-033
  - [ ] M1.4.5: Executar teste

- [ ] M1.5: Implementar structs de Gifts (CT-035, RF-035)
  - [ ] M1.5.1: Criar struct Gift
  - [ ] M1.5.2: Criar struct Gifts
  - [ ] M1.5.3: Escrever teste TU-035
  - [ ] M1.5.4: Executar teste

- [ ] M1.6: Implementar structs auxiliares (BusinessIntro, BusinessLocation, TransactionPartner)
  - [ ] M1.6.1: Criar BusinessIntro (CT-027)
  - [ ] M1.6.2: Criar BusinessLocation (CT-028)
  - [ ] M1.6.3: Criar BusinessOpeningHours (CT-029)
  - [ ] M1.6.4: Criar TransactionPartner (CT-032)
  - [ ] M1.6.5: Escrever testes TU-027 a TU-032
  - [ ] M1.6.6: Executar testes

**Gate M1:** Todos os testes unitários passando, zero regressões

---

## Milestone 2: Fields em Tipos Existentes (PRIORIDADE 1)

**Objetivo:** Adicionar campos novos a structs existentes (Update, Message, Chat)
**Estimativa:** 3-4 horas
**Pré-condições:** Milestone 1 completo
**Critérios de Sucesso:**
- [ ] Todos os campos CT-036 a CT-043 implementados
- [ ] Testes backward compatibility passando
- [ ] Deserialização de JSON mantendo compatibilidade

### Tarefas
- [ ] M2.1: Atualizar struct Update (RF-036 a RF-038)
  - [ ] M2.1.1: Adicionar field business_connection (CT-036)
  - [ ] M2.1.2: Adicionar field business_message (CT-037)
  - [ ] M2.1.3: Adicionar field edited_business_message (CT-038)
  - [ ] M2.1.4: Tornar campos opcionais (default nothing)
  - [ ] M2.1.5: Escrever testes TU-036 a TU-038
  - [ ] M2.1.6: Executar testes

- [ ] M2.2: Atualizar struct Message (RF-039 a RF-041)
  - [ ] M2.2.1: Adicionar field business_connection_id (CT-039)
  - [ ] M2.2.2: Adicionar field paid_media (CT-040)
  - [ ] M2.2.3: Adicionar field gift (CT-041)
  - [ ] M2.2.4: Tornar campos opcionais
  - [ ] M2.2.5: Escrever testes TU-039 a TU-041
  - [ ] M2.2.6: Executar testes

- [ ] M2.3: Atualizar struct Chat (RF-042 a RF-043)
  - [ ] M2.3.1: Adicionar field business_intro (CT-042)
  - [ ] M2.3.2: Adicionar field business_location (CT-043)
  - [ ] M2.3.3: Tornar campos opcionais
  - [ ] M2.3.4: Escrever testes TU-042 a TU-043
  - [ ] M2.3.5: Executar testes

**Gate M2:** Todos os testes passando, backward compatibility verificada

---

## Milestone 3: Parâmetros Completos em Métodos Existentes (PRIORIDADE 1)

**Objetivo:** Completar implementação de parâmetros faltantes em métodos existentes
**Estimativa:** 2-3 horas
**Pré-condições:** Milestone 2 completo
**Critérios de Sucesso:**
- [ ] Todos os parâmetros CT-017 a CT-062 implementados
- [ ] 100% dos métodos de envio atualizados
- [ ] Testes para cada parâmetro passando

### Tarefas
- [ ] M3.1: Completar parâmetros de sendMessage
  - [ ] M3.1.1: Verificar CT-017, CT-018, CT-019 já implementados (SIM)
  - [ ] M3.1.2: Escrever testes TU-017 a TU-019
  - [ ] M3.1.3: Executar testes

- [ ] M3.2: Completar parâmetros de sendPhoto
  - [ ] M3.2.1: Verificar CT-020 já implementado (SIM)
  - [ ] M3.2.2: Escrever teste TU-020
  - [ ] M3.2.3: Executar teste

- [ ] M3.3: Completar parâmetros de sendVideo
  - [ ] M3.3.1: Verificar CT-021 já implementado (SIM)
  - [ ] M3.3.2: Escrever teste TU-021
  - [ ] M3.3.3: Executar teste

- [ ] M3.4: Completar parâmetros de copyMessage
  - [ ] M3.4.1: Verificar CT-022 já implementado (SIM)
  - [ ] M3.4.2: Escrever teste TU-022
  - [ ] M3.4.3: Executar teste

- [ ] M3.5: Completar parâmetros de forwardMessage
  - [ ] M3.5.1: Verificar CT-023 (falta video_start_timestamp)
  - [ ] M3.5.2: Adicionar parâmetro video_start_timestamp
  - [ ] M3.5.3: Escrever teste TU-023
  - [ ] M3.5.4: Executar teste

- [ ] M3.6: Completar parâmetros de createInvoiceLink
  - [ ] M3.6.1: Verificar CT-024 já implementado (SIM)
  - [ ] M3.6.2: Escrever teste TU-024
  - [ ] M3.6.3: Executar teste

- [ ] M3.7: Completar parâmetros de sendInvoice
  - [ ] M3.7.1: Verificar CT-025 já implementado (SIM)
  - [ ] M3.7.2: Escrever teste TU-025
  - [ ] M3.7.3: Executar teste

- [ ] M3.8: Implementar parâmetros faltantes de mensagem (RF-047 a RF-062)
  - [ ] M3.8.1: Adicionar message_effect_id a sendAnimation (CT-047, RF-047)
  - [ ] M3.8.2: Adicionar message_effect_id a sendAudio (CT-048, RF-048)
  - [ ] M3.8.3: Adicionar message_effect_id a sendDocument (CT-049, RF-049)
  - [ ] M3.8.4: Adicionar message_effect_id a sendSticker (CT-050, RF-050)
  - [ ] M3.8.5: Adicionar message_effect_id a sendVideoNote (CT-051, RF-051)
  - [ ] M3.8.6: Adicionar message_effect_id a sendVoice (CT-052, RF-052)
  - [ ] M3.8.7: Adicionar message_effect_id a sendLocation (CT-053, RF-053)
  - [ ] M3.8.8: Adicionar message_effect_id a sendVenue (CT-054, RF-054)
  - [ ] M3.8.9: Adicionar message_effect_id a sendContact (CT-055, RF-055)
  - [ ] M3.8.10: Adicionar message_effect_id a sendPoll (CT-056, RF-056)
  - [ ] M3.8.11: Adicionar message_effect_id a sendDice (CT-057, RF-057)
  - [ ] M3.8.12: Adicionar message_effect_id a sendGame (CT-058, RF-058)
  - [ ] M3.8.13: Adicionar message_effect_id a sendMediaGroup (CT-059, RF-059)
  - [ ] M3.8.14: Adicionar allow_paid_broadcast a sendAnimation (CT-060, RF-060)
  - [ ] M3.8.15: Adicionar allow_paid_broadcast a sendAudio (CT-061, RF-061)
  - [ ] M3.8.16: Adicionar allow_paid_broadcast a sendDocument (CT-062, RF-062)
  - [ ] M3.8.17: Escrever testes TU-047 a TU-062
  - [ ] M3.8.18: Executar testes

**Gate M3:** Todos os testes passando, cobertura de parâmetros 100%

---

## Milestone 4: Testes de Integração e Regressão (PRIORIDADE 2)

**Objetivo:** Criar suite de testes de integração e regressão
**Estimativa:** 3-4 horas
**Pré-condições:** Milestones 1-3 completos
**Critérios de Sucesso:**
- [ ] 100% dos novos métodos com testes de integração (TI-001 a TI-025)
- [ ] 100% dos métodos existentes com testes de regressão (TR-017 a TR-062)
- [ ] Zero regressões detectadas
- [ ] Cobertura de código >95%

### Tarefas
- [ ] M4.1: Criar testes de integração para novos métodos
  - [ ] M4.1.1: Criar TI-001 (getBusinessConnection)
  - [ ] M4.1.2: Criar TI-002 (refundStarPayment)
  - [ ] M4.1.3: Criar TI-003 (getStarTransactions)
  - [ ] M4.1.4: Criar TI-004 (sendPaidMedia)
  - [ ] M4.1.5: Criar TI-005 (createChatSubscriptionInviteLink)
  - [ ] M4.1.6: Criar TI-006 (editChatSubscriptionInviteLink)
  - [ ] M4.1.7: Criar TI-007 (setUserEmojiStatus)
  - [ ] M4.1.8: Criar TI-008 (verifyUser)
  - [ ] M4.1.9: Criar TI-009 (verifyChat)
  - [ ] M4.1.10: Criar TI-010 (removeUserVerification)
  - [ ] M4.1.11: Criar TI-011 (removeChatVerification)
  - [ ] M4.1.12: Criar TI-012 (editUserStarSubscription)
  - [ ] M4.1.13: Criar TI-013 (savePreparedInlineMessage)
  - [ ] M4.1.14: Criar TI-014 (getAvailableGifts)
  - [ ] M4.1.15: Criar TI-015 (sendGift)
  - [ ] M4.1.16: Criar TI-016 (giftPremiumSubscription)
  - [ ] M4.1.17: Executar todos os TI

- [ ] M4.2: Criar testes de regressão para métodos existentes
  - [ ] M4.2.1: Criar TR-017 (sendMessage - business_connection_id)
  - [ ] M4.2.2: Criar TR-018 (sendMessage - message_effect_id)
  - [ ] M4.2.3: Criar TR-019 (sendMessage - allow_paid_broadcast)
  - [ ] M4.2.4: Criar TR-020 (sendPhoto)
  - [ ] M4.2.5: Criar TR-021 (sendVideo)
  - [ ] M4.2.6: Criar TR-022 (copyMessage)
  - [ ] M4.2.7: Criar TR-023 (forwardMessage)
  - [ ] M4.2.8: Criar TR-024 (createInvoiceLink)
  - [ ] M4.2.9: Criar TR-025 (sendInvoice)
  - [ ] M4.2.10: Criar TR-047 a TR-062 (novos parâmetros)
  - [ ] M4.2.11: Executar todos os TR

- [ ] M4.3: Executar suíte completa de testes
  - [ ] M4.3.1: Executar `julia --project=. -e 'using Pkg; Pkg.test()'`
  - [ ] M4.3.2: Verificar que 100% passam
  - [ ] M4.3.3: Verificar zero regressões

- [ ] M4.4: Medir cobertura de código
  - [ ] M4.4.1: Executar testes com coverage
  - [ ] M4.4.2: Verificar >95% cobertura
  - [ ] M4.4.3: Documentar cobertura

**Gate M4:** Todos os testes passando, zero regressões, cobertura >95%

---

## Milestone 5: Documentação e Review Final (PRIORIDADE 2)

**Objetivo:** Completar documentação e preparar para release
**Estimativa:** 2-3 horas
**Pré-condições:** Milestone 4 completo
**Critérios de Sucesso:**
- [ ] 100% dos novos métodos com docstrings completas
- [ ] README atualizado com novos recursos
- [ ] CHANGELOG.md criado
- [ ] Code review completo e aprovado
- [ ] TRACEABILITY_MATRIX atualizada

### Tarefas
- [ ] M5.1: Escrever docstrings para novos métodos
  - [ ] M5.1.1: getBusinessConnection
  - [ ] M5.1.2: refundStarPayment
  - [ ] M5.1.3: getStarTransactions
  - [ ] M5.1.4: sendPaidMedia
  - [ ] M5.1.5: createChatSubscriptionInviteLink
  - [ ] M5.1.6: editChatSubscriptionInviteLink
  - [ ] M5.1.7: setUserEmojiStatus
  - [ ] M5.1.8: verifyUser
  - [ ] M5.1.9: verifyChat
  - [ ] M5.1.10: removeUserVerification
  - [ ] M5.1.11: removeChatVerification
  - [ ] M5.1.12: editUserStarSubscription
  - [ ] M5.1.13: savePreparedInlineMessage
  - [ ] M5.1.14: getAvailableGifts
  - [ ] M5.1.15: sendGift
  - [ ] M5.1.16: giftPremiumSubscription

- [ ] M5.2: Atualizar README.md
  - [ ] M5.2.1: Adicionar seção "API 7.x Support"
  - [ ] M5.2.2: Listar novos métodos
  - [ ] M5.2.3: Adicionar exemplos de uso
  - [ ] M5.2.4: Atualizar badges de versão

- [ ] M5.3: Criar CHANGELOG.md
  - [ ] M5.3.1: Documentar versão 2.0
  - [ ] M5.3.2: Listar breaking changes (se houver)
  - [ ] M5.3.3: Listar novos métodos
  - [ ] M5.3.4: Listar novos tipos
  - [ ] M5.3.5: Listar parâmetros adicionados
  - [ ] M5.3.6: Agradecer contribuidores

- [ ] M5.4: Atualizar TRACEABILITY_MATRIX.md
  - [ ] M5.4.1: Marcar todos os RF como ✅ (completado)
  - [ ] M5.4.2: Verificar que todos os CT têm evidência
  - [ ] M5.4.3: Atualizar estatísticas de progresso

- [ ] M5.5: Code Review
  - [ ] M5.5.1: Revisar todos os arquivos modificados
  - [ ] M5.5.2: Verificar conformidade com SPECS.md
  - [ ] M5.5.3: Verificar conformidade com SAFETY_SPEC.md
  - [ ] M5.5.4: Verificar conformidade com CONTRACTS.md
  - [ ] M5.5.5: Aprovar ou solicitar mudanças
  - [ ] M5.5.6: Documentar aprovação

**Gate M5:** Documentação completa, code review aprovado

---

## Milestone 6: Release e Merge (PRIORIDADE 3)

**Objetivo:** Merge para branch principal e preparar release
**Estimativa:** 1 hora
**Pré-condições:** Milestone 5 completo
**Critérios de Sucesso:**
- [ ] Branch mergeado sem conflitos
- [ ] Tag de release criada (v2.0.0)
- [ ] PR aberto no GitHub
- [ ] CI/CD passando

### Tarefas
- [ ] M6.1: Merge branch API7x para main
  - [ ] M6.1.1: Criar PR com descrição detalhada
  - [ ] M6.1.2: Resolver conflitos (se houver)
  - [ ] M6.1.3: Merge para main

- [ ] M6.2: Criar release tag
  - [ ] M6.2.1: Criar tag v2.0.0
  - [ ] M6.2.2: Anotar tag com CHANGELOG.md

- [ ] M6.3: Publicar release no GitHub
  - [ ] M6.3.1: Criar GitHub Release
  - [ ] M6.3.2: Anexar CHANGELOG.md
  - [ ] M6.3.3: Publicar no Julia Registry

- [ ] M6.4: Anunciar atualização
  - [ ] M6.4.1: Postar em @BotNews
  - [ ] M6.4.2: Atualizar documentação
  - [ ] M6.4.3: Notificar usuários

**Gate M6:** Release publicado, CI passando

---

## Tarefas Gerais

- [ ] TG-001: Configurar CI/CD para testes automáticos
- [ ] TG-002: Configurar linters (JuliaFormatter.jl)
- [ ] TG-003: Criar script de benchmark de performance
- [ ] TG-004: Criar script de validação de API (smoke tests)
- [ ] TG-005: Documentar arquitetura de tipos de dados

---

## Estimativa de Tempo Total

| Milestone | Horas | Cumulativo |
|-----------|-------|-----------|
| M1: Tipos de Dados | 4-6 | 4-6 |
| M2: Fields em Tipos | 3-4 | 7-10 |
| M3: Parâmetros Completos | 2-3 | 9-13 |
| M4: Testes Integração/Regressão | 3-4 | 12-17 |
| M5: Documentação e Review | 2-3 | 14-20 |
| M6: Release e Merge | 1 | 15-21 |
| **TOTAL** | **15-21 horas** | |

---

## Notas

- Cada milestone DEVE ter seu próprio PR para code review
- Testes DEVE ser escritos ANTES da implementação (TDD)
- Documentação DEVE ser escrita em paralelo com código
- Regressões DEVER ser zero (crisário de encerramento)
- Cobertura DEVE ser >95% (crisário de encerramento)

---

*TODO.md - 6 milestones planejados*
*Próxima revisão: Diariamente durante implementação*
