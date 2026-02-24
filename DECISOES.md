# DECISOES.md - Registro de Decisões Técnicas (ATUALIZADO)

**Projeto:** Telegram.jl API 7.x Update
**Versão:** 1.1
**Data Criação:** 2026-02-23
**Última Atualização:** 2026-02-23 20:45 GMT-3
**Status:** Ativo

---

## Metodologia

Cada decisão técnica DEVE ser registrada com:

1. **Contexto** - Qual problema está sendo resolvido
2. **Alternativas Consideradas** - Opções avaliadas
3. **Decisão** - Opção escolhida
4. **Justificativa** - Razão para a escolha
5. **Consequências** - Impactos da decisão
6. **Riscos** - Riscos associados

---

## Decisões Tomadas

### D-001: Escopo da API Alvo (7.x vs 8.x+)

**Contexto:**
Usuário solicitou atualização para API 7.x, mas análise mostrou que já existem funcionalidades de 8.0-8.3 implementadas. Decisão necessária sobre escopo.

**Alternativas Consideradas:**
1. Implementar apenas API 7.x (7.0 a 7.11)
2. Implementar API 7.x + 8.0-8.3 (funcionalidades já iniciadas)
3. Implementar até API 9.x (mais atual possível)
4. Implementar tudo até a versão mais recente da data (9.4)

**Decisão:**
**Alternativa 2: Implementar API 7.x + 8.0-8.3**

**Justificativa:**
- Usuário explicitou API 7.x como escopo
- Funcionalidades de 8.0-8.3 já foram implementadas pelo sub-agente anterior
- Implementar até 9.x aumentaria escopo em ~300% (tempo +15-21 horas)
- **Correr changelog até API 7.x NÃO é o final do trabalho** - o objetivo é entregar PRs devidamente fatiados upstream para que o autor original não precise atualizar 3 gerações de API de uma vez só

**Consequências:**
- ✅ Foco mantido em API 7.x (principal)
- ✅ Funcionalidades de 8.0-8.3 incluídas (já implementadas)
- ✅ PRs mais completos e fatiados upstream
- ❌ Funcionalidades de 9.x não incluídas (stories avançados, checklists, etc.)
- ⏳ Cobertura parcial: API 7.x completa + API 8.0-8.3 parcial

**Riscos:**
- Risco 1: Biblioteca pode ficar rapidamente desatualizada novamente (9.x+ já existe)
- Risco 2: Usuário pode achar que implementação está incompleta

**Referência:**
- API7X_REPORT.md (análise detalhada)
- SPECS.md (escopo definido)

---

### D-002: Ordem de Implementação (Tipos vs Métodos vs Fields)

**Contexto:**
Análise identificou lacuna crítica: métodos implementados mas tipos de dados NÃO implementados. Isso causa falhas em runtime. Decisão necessária sobre prioridade.

**Alternativas Consideradas:**
1. Implementar métodos primeiro (completar funcionalidades)
2. Implementar tipos primeiro (corrigir falhas)
3. Implementar campos em tipos existentes primeiro
4. Implementar tudo em paralelo (tipos, métodos, campos)

**Decisão:**
**Alternativa 2: Implementar tipos de dados PRIMEIRO**

**Justificativa:**
- Sem tipos, métodos NÃO funcionam (falham em deserialização)
- Métodos implementados atualmente retornam tipos desconhecidos
- Testes de integração NÃO podem passar sem tipos
- **Correção: Tipos são pré-requisito para métodos funcionarem**

**Consequências:**
- ✅ Métodos existentes passarão a funcionar corretamente
- ✅ Deserialização de respostas será segura
- ✅ Testes de integração passarão
- ⏳ Milestone 1 (Tipos de Dados Críticos) tem prioridade máxima
- ⏳ Milestone 2 (Fields em Tipos) tem prioridade alta
- ⏳ Milestone 3 (Parâmetros Completos) tem prioridade média

**Riscos:**
- Risco 1: Implementar tipos pode ser trabalhoso (40+ structs)
- Risco 2: Delay em ver funcionalidade funcionando (usabilidade temporária)
- Risco 3: Interdependências entre tipos podem causar problemas

**Referência:**
- R2-001 em RISK_REGISTER.md (Deserialização Incorreta)
- TODO.md - Milestone 1 (Tipos de Dados Críticos)

---

### D-003: Estratégia de Testes (TDD vs Code-First vs Test-Last)

**Contexto:**
Template exige "Criar testes antes de código" (TDD). Decisão necessária sobre estratégia de testes.

**Alternativas Consideradas:**
1. TDD puro: Escrever teste falho, implementar mínimo para passar, refatorar
2. Code-First: Implementar funcionalidade, depois escrever testes
3. Test-First: Escrever testes, depois implementar
4. Hybrid: Testes críticos em TDD, restante em Code-First

**Decisão:**
**Alternativa 1: TDD Obrigatório para Métodos Críticos, Code-First permitido para tipos simples**

**Justificativa:**
- **TDD tem custo de performance aceitável diante de erros catastróficos que evita**
- Erros catastróficos (ex: deserialização incorreta, segurança) são MUITO piores que custo de TDD
- Tipos de dados podem usar Code-First (validação é simples: deserializa ou não)
- Métodos com lógica complexa DEVEM usar TDD (ex: sendPaidMedia)
- **Checklist de M&Ms (Minutos e Mensagens) pode ser usado para verificar se contratado tem se atentado a detalhes aparentemente pequenos mas de segurança crítica**

**Consequências:**
- ✅ Métodos críticos têm testes sólidos (getStarTransactions, etc.)
- ✅ Tipos de dados podem ser implementados mais rápido
- ✅ Código mais confiável onde mais importante
- ✅ **Erros catastróficos evitados por TDD** (custo aceitável)
- ⏳ Desenvolvedor precisa decidir: TDD vs Code-First para cada tarefa
- ⏳ Code reviews devem verificar se testes foram escritos

**Riscos:**
- Risco 1: Desenvolvedor pode escolher sempre Code-First (preguiça)
- Risco 2: Tipos de dados podem não ter testes suficientes
- Risco 3: Critério "Híbrido" pode ser subjetivo

**Referência:**
- SEÇÃO 5 do template (Verificação Antes da Implementação)
- CONTRACTS.md (contratos definem o que deve ser testado)
- M&Ms Checklist (para detalhes críticos de segurança)

---

### D-004: Biblioteca de JSON vs Manual (JSON3.jl vs Custom)

**Contexto:**
Telegram.jl atual usa JSON3.jl para deserialização. Decisão necessária: continuar com JSON3.jl ou criar parser manual.

**Alternativas Consideradas:**
1. Continuar com JSON3.jl (existente)
2. Criar parser manual customizado
3. Usar JSON.jl (alternativa)
4. Usar JSONParser.jl (mais rápido)

**Decisão:**
**Alternativa 1: Continuar com JSON3.jl**

**Justificativa:**
- JSON3.jl já está instalado e configurado (ver dependências)
- Compatibilidade com código existente (sem breaking changes)
- Performance de JSON3.jl é aceitável para este caso de uso
- Parser manual adicionaria complexidade e riscos
- JSONParser.jl não traz benefício significativo (diferença de performance <10%)

**Consequências:**
- ✅ Sem mudanças em dependências
- ✅ Compatibilidade com código existente mantida
- ✅ Desenvolvimento mais rápido (sem reescrita de deserialização)
- ⏳ Deserialização de novos tipos deve usar padrões JSON3.jl existentes
- ⏳ Performance pode não ser ótima (mas é aceitável)

**Riscos:**
- Risco 1: JSON3.jl pode ter bugs com tipos complexos
- Risco 2: Performance de deserialização pode ser lenta para grandes payloads
- Risco 3: Atualizações futuras podem exigir mudança de biblioteca

**Referência:**
- Project.toml (dependências atuais)
- R2-005 em RISK_REGISTER.md (Deserialização Segura)

---

### D-005: Organização de Arquivos (Flat vs Hierárquico)

**Contexto:**
Atualmente todos os tipos de dados estão juntos em `telegram_api.jl` com definições de métodos. Decisão necessária sobre estrutura de arquivos.

**Alternativas Consideradas:**
1. Flat structure: Manter tudo junto (telegram_api.jl + telegram_api.jl atual)
2. Hierárquica: Separar em `src/types/`, `src/methods/`, `src/api/`
3. Mixed: Métodos em `src/api.jl`, tipos em `src/types/`, tipos existentes em `src/telegram.jl`
4. Por funcionalidade: `src/business/`, `src/stars/`, `src/paid_media/`, etc.

**Decisão:**
**Alternativa 2: Estrutura Hierárquica (src/types/, src/methods/, src/api/)**

**Justificativa:**
- `telegram_api.jl` já tem 1600+ linhas (difícil de navegar)
- Separação de responsabilidades facilita manutenção
- 40+ novos tipos justificam arquivo dedicado `src/types/`
- Funcionalidades por API (Business, Stars, Gifts, Paid Media) justificam separação
- Torna claro o que é novo vs. existente

**Consequências:**
- ✅ Código mais organizado e navegável
- ✅ Mais fácil entender arquitetura da biblioteca
- ✅ Separação clara entre tipos existentes e novos
- ⏳ Migração de código existente (refatoração)
- ⏳ Atualizações de `include()` em `src/Telegram.jl`

**Riscos:**
- Risco 1: Refatoração pode introduzir regressões
- Risco 2: Navegação entre arquivos pode ser confusa inicialmente
- Risco 3: `include()` circular (precisa ser evitado)
- Risco 4: Mais arquivos podem aumentar tempo de build

**Referência:**
- Estrutura atual (src/api.jl, src/client.jl, src/bot.jl)
- M1.6 em TODO.md (Implementar structs auxiliares)

---

### D-006: Backward Compatibility (Strict vs Loose vs Versioning)

**Contexto:**
Template exige "100% compatível com API 6.x". Decisão necessária sobre como lidar com tipos mudados (ex: Chat → ChatFullInfo).

**Alternativas Consideradas:**
1. Strict backward compatibility: Manter tipos 6.x inalterados, criar novos tipos 7.x
2. Loose compatibility: Mudar tipos existentes, mas aceitar campos desconhecidos
3. Versioning: Criar tipos versionados (ChatV6, ChatV7)
4. Union types: Usar Union{ChatV6, ChatV7} para flexibilidade

**Decisão:**
**Alternativa 1: Strict Backward Compatibility (tipos existentes inalterados)**

**Justificativa:**
- Breaking changes não documentados causam regressões em bots existentes
- Chat → ChatFullInfo é breaking change (API oficial fala nisso)
- Criar ChatFullInfo como novo tipo mantém Chat inalterado
- Campos novos devem ser opcionais (default nothing) em tipos existentes
- Usuários que dependem de API 6.x não quebram

**Consequências:**
- ✅ Bots existentes continuam funcionando sem mudanças
- ✅ Novos tipos podem usar novos recursos
- ✅ Upward compatibility (6.x → 7.x transparente)
- ⏳ Tipos existentes podem ficar "poluídos" com muitos campos opcionais
- ⏳ Usuários precisam saber quando usar Chat vs ChatFullInfo
- ⏳ Documentação deve explicar diferenças claramente

**Riscos:**
- Risco 1: Duplicação de funcionalidade (Chat vs ChatFullInfo)
- Risco 2: Confusão sobre quando usar qual tipo
- Risco 3: Campos opcionais em excesso dificultam entendimento de código

**Referência:**
- NÃO-F-002 em SPECS.md (Sistema DEVE manter compatibilidade com API 6.x)
- API7X_REPORT.md (seção "Fields em Tipos Existentes")

---

### D-007: Validação de Parâmetros (Strict vs Lenient vs Lazy)

**Contexto:**
Template exige validação de tipos (SAFETY_SPEC.md). Decisão necessária sobre estratégia de validação.

**Alternativas Consideradas:**
1. Strict: Validar todos os parâmetros no cliente (rejeitar se inválido)
2. Lenient: Validar apenas parâmetros críticos, passar outros para API
3. Lazy: Não validar, deixar API retornar erro (confiar em Telegram)
4. Hybrid: Validar parâmetros de segurança, deixar API validar o restante

**Decisão:**
**Alternativa 2: Lenient (validar apenas críticos, API valida o restante)**

**Justificativa:**
- API Telegram valida todos os parâmetros (não há necessidade de duplicar)
- Validação no cliente adiciona overhead (performance)
- Evita problema: "funcionalidade nova implementada na API mas cliente ainda rejeita"
- Validação de segurança (token, user_id) deve ser no cliente (não enviar para API)
- Parâmetros de tipo (String, Integer, Bool) podem ser validados por Julia (type system)

**Consequências:**
- ✅ Performance melhor (sem validação duplicada)
- ✅ Funcionalidades futuras funcionam sem atualizar cliente
- ✅ Erros da API são mais informativos (sabem exatamente o que está errado)
- ⏳ Dependem de mensagens de erro claras da API Telegram
- ⏳ Erros de tipo podem ser "encontrados" em runtime (em vez de validation time)

**Riscos:**
- Risco 1: Erros de API podem ser menos amigáveis (JSON raw)
- Risco 2: Bugs na validação da API Telegram afetam usuários
- Risco 3: Parâmetros mal-tipados causam erros HTTP 400 (em vez de ArgumentError)

**Referência:**
- RS-002 em SAFETY_SPEC.md (Validação de Tipos Antes de Envio)
- RS-003 em SAFETY_SPEC.md (Proteção Contra Injeção)

---

### D-008: Documentação de Código (Docstrings vs External vs Mixed)

**Contexto:**
Telegram.jl atual usa docstrings embutidas em código. Decisão necessária sobre estratégia de documentação de API 7.x.

**Alternativas Consideradas:**
1. Docstrings: Usar apenas docstrings Julia ("""...""")
2. External: Documentar em arquivos Markdown separados
3. Mixed: Docstrings básicas + docs detalhadas em Markdown
4. Auto-doc: Gerar documentação automaticamente de tipos/contratos

**Decisão:**
**Alternativa 1: Docstrings Julia (padrão existente)**

**Justificativa:**
- Mantém consistência com código existente
- Julia docstrings são nativamente acessíveis via `?nome_funcao`
- Documentação externa se desincroniza facilmente (esquecer de atualizar)
- Uma fonte única de verdade (código) é mais confiável
- Templates do Telegram.jl já usam docstrings (convenção estabelecida)

**Consequências:**
- ✅ Consistência com padrão existente
- ✅ Documentação acessível via Julia REPL
- ✅ Uma fonte única de verdade (código)
- ⏳ Docstrings podem ficar longas (métodos complexos)
- ⏳ Sem documentação separada para não-usuários de Julia

**Riscos:**
- Risco 1: Documentação externa (README) precisa ser mantida em paralelo
- Risco 2: Docstrings longas dificultam leitura de código
- Risco 3: Sem "Quick Start" separado para novatos

**Referência:**
- Exemplos em src/telegram_api.jl (docstrings existentes)
- M5.1 em TODO.md (Escrever docstrings para novos métodos)

---

### D-009: CI/CD GitHub Actions (NOVO)

**Contexto:**
Milestone 6 menciona "CI/CD passando". Decisão necessária sobre estratégia de CI/CD para testes automáticos.

**Alternativas Consideradas:**
1. GitHub Actions (já usado pelo repo, gratuito para open source)
2. GitLab CI (alternativa)
3. Manual: Executar testes localmente antes de commit
4. Nenhuma CI (entregar sem automação)

**Decisão:**
**Alternativa 1: GitHub Actions (workflow completo)**

**Justificativa:**
- GitHub Actions é padrão do GitHub, gratuito para open source
- Já configurado no repo (reutilizar infraestrutura)
- Automação obriga qualidade (testes passam antes de merge)
- Relatórios de coverage ajudam a manter >95%
- Notificações automáticas em caso de falha
- **Checklist de M&Ms pode ser automatizado no CI**

**Consequências:**
- ✅ Testes executados automaticamente em cada push e PR
- ✅ Cobertura de código reportada automaticamente
- ✅ Code review mais eficiente (já vem com status dos testes)
- ✅ Previne regressões (CI bloqueia merges com testes falhando)
- ✅ Notificações automáticas para equipe
- ⏳ Configuração inicial do workflow (YAML para GitHub Actions)
- ⏳ Tempo de build aumentado (mas aceitável)
- ⏳ Dependem de configuração correta do workflow

**Riscos:**
- Risco 1: Workflow mal configurado pode causar falsos positivos
- Risco 2: Aumento de tempo de build pode frustar desenvolvedores
- Risco 3: Dependências de CI podem falhar (cache, etc.)

**Referência:**
- .github/workflows/ (estrutura de workflows existentes)
- Project.toml (dependências de teste)
- M6 em TODO.md (Release e Merge)

---

### D-010: Checklist de M&Ms (NOVO)

**Contexto:**
Usado no passado como aferição se o contratado tem se atentado a detalhes aparentemente pequenos mas de segurança crítica. TDD não é opcional mas tem custo aceitável vs. erros catastróficos.

**Alternativas Consideradas:**
1. Não usar checklist de M&Ms
2. Usar checklist informal
3. Usar checklist formal de M&Ms (Minutos em Reunião, Mensagens)

**Decisão:**
**Alternativa 3: Usar checklist formal de M&Ms para detalhes críticos de segurança**

**Justificativa:**
- Detalhes aparentemente pequenos podem ser de segurança crítica
- Exemplo: sanitização de token, validação de tipos, proteção contra injeção
- M&Ms (Minutos e Mensagens) forçam foco e documentação
- TDD previne erros catastróficos com custo aceitável de performance
- Checklist formal torna explícito o que precisa ser verificado

**Consequências:**
- ✅ Detalhes de segurança não são esquecidos
- ✅ Documentação explícita do que foi revisado
- ✅ Rastreabilidade de quem revisou cada detalhe
- ✅ Auditoria possível (revisar histórico de M&Ms)
- ⏳ Tempo adicional em reuniões/reviews (mas compensado por qualidade)
- ⏳ Carga administrativa (manter checklist atualizado)

**Riscos:**
- Risco 1: Checklist pode ficar desatualizado se não for mantido
- Risco 2: Checklists longos podem causar fadiga e revisões superficiais
- Risco 3: Foco em checklist pode distrair do problema maior

**Referência:**
- SAFETY_SPEC.md (requisitos de segurança críticos)
- RISK_REGISTER.md (riscos R4 safety-critical)
- CONTRATO com Manel (acordo de qualidade e segurança)

---

## Decisões Pendentes

Nenhuma decisão pendente.

---

## Estatísticas

| Categoria | Decisões Tomadas | Decisões Pendentes | Total |
|-----------|---------------------|-----------------------|-------|
| Arquitetura | 3 | 0 | 3 |
| Estratégia de Testes | 1 | 0 | 1 |
| Dependências | 2 | 0 | 2 |
| Backward Compatibility | 1 | 0 | 1 |
| Validação | 1 | 0 | 1 |
| Documentação | 1 | 0 | 1 |
| CI/CD | 1 | 0 | 1 |
| Segurança (M&Ms) | 1 | 0 | 1 |
| **TOTAL** | **11** | **0** | **11** |

| Prioridade | Baixa | Média | Alta | Crítica | Total |
|-----------|-------|-------|------|---------|-------|
| Quantidade | 2 | 5 | 3 | 1 | 11 |

---

## Referências Cruzadas

| Decisão | Risco Relacionado | Contrato Relacionado | Milestone Relacionado |
|-----------|-------------------|---------------------|----------------------|
| D-001 | N/A | N/A | Escopo |
| D-002 | R2-001 | CT-026 a CT-035 | M1 |
| D-003 | R1-001 | CT-001 a CT-062 | M1, M2, M3 |
| D-004 | R2-005 | Todos | M1, M2, M3 |
| D-005 | R1-002 | Todos | M1, M2 |
| D-006 | R1-002 | CT-036 a CT-043 | M2 |
| D-007 | RS-002, RS-003 | Todos | M1, M2, M3 |
| D-008 | R0-002 | Todos | M5 |
| D-009 | N/A | N/A | M6 |
| D-010 | R4-001, R4-002 | Todos RS | M1, M2, M3, M4, M5 |

---

## Notas Importantes

- **CRITÉRIO FORMAL DE ENCERRAMENTO:** Todas as decisões arquiteturais (D-001 a D-010) DEVEM ser tomadas antes de Milestone 1
- **TRACEABILITY:** Cada decisão DEVE referenciar RISK_REGISTER.md e CONTRACTS.md
- **ATUALIZAÇÃO:** Novas decisões DEVEM ser registradas imediatamente
- **REVISÃO:** Decisões podem ser reavaliadas se novas informações surgirem
- **TDD OBRIGATÓRIO:** D-003 esclarece que TDD é obrigatório para métodos críticos (custo aceitável vs. erros catastróficos)
- **CHECKLIST M&Ms:** D-010 formaliza uso de checklist para detalhes críticos de segurança
- **CI/CD:** D-009 configura GitHub Actions para automação de testes e qualidade

---

*Registro de decisões técnicas - Iniciado em 2026-02-23*
*11 decisões registradas, 0 pendentes*
*Última atualização: 2026-02-23 20:45 GMT-3*
*Próxima atualização: Quando nova decisão for tomada*
