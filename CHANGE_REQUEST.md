# CHANGE_REQUEST.md - Controle de Mudanças

**Projeto:** Telegram.jl API 7.x Update
**Versão:** 1.0
**Data Criação:** 2026-02-23
**Status:** Ativo

---

## Política de Controle de Mudanças

Qualquer alteração no escopo original DEVE passar por este processo:

1. **Identificação** da mudança
2. **Avaliação de impacto** em requisitos existentes
3. **Atualização** de documentos de rastreabilidade
4. **Aprovação** formal antes de implementação
5. **Registro** neste documento

---

## Formulário de Solicitação de Mudança

```markdown
### CR-XXX: [Título da Mudança]

**Solicitante:** [Nome]
**Data:** [YYYY-MM-DD]
**Tipo:** [Escopo/Critério/Requisito/Arquitetura/Outro]
**Prioridade:** [Baixa/Média/Alta/Crítica]

### Descrição
[Descrição detalhada da mudança solicitada]

### Justificativa
[Razão pela qual a mudança é necessária]

### Impacto Esperado
- [ ] Novos requisitos funcionais
- [ ] Mudança em requisitos existentes
- [ ] Alteração de risco
- [ ] Aumento de tempo estimado
- [ ] Outro: [descrição]

### Riscos Identificados
- Risco 1: [descrição]
- Risco 2: [descrição]

### Aprovação Necessária
- [ ] Clio (Coordenadora)
- [ ] Manel (Sponsor)
- [ ] Code Reviewer
- [ ] Outro: [nome]

### Decisão
- [ ] APROVADO
- [ ] REJEITADO
- [ ] DEFERIDO
- [ ] REQUER MAIS INFORMAÇÕES

### Justificativa da Decisão
[Razão para aprovação/rejeição]

### Plano de Implementação
- [ ] Atualizar SPECS.md
- [ ] Atualizar TODO.md
- [ ] Atualizar TRACEABILITY_MATRIX.md
- [ ] Atualizar RISK_REGISTER.md
- [ ] Criar novos requisitos RF
- [ ] Criar novos requisitos RS
- [ ] Criar novos contratos CT
- [ ] Criar novos testes TU/TI/TR
```

---

## Histórico de Solicitações

### CR-001: NÃO HÁ - Estado Inicial

**Solicitante:** N/A
**Data:** 2026-02-23
**Tipo:** Estado Inicial
**Prioridade:** N/A

### Descrição
Projeto criado. Nenhuma mudança solicitada ainda.

### Justificativa
Inicialização do controle de mudanças.

### Impacto Esperado
Nenhum

### Riscos Identificados
Nenhum

### Aprovação Necessária
Nenhuma necessária (estado inical)

### Decisão
Aguardando primeira solicitação

---

## Template em Branco (Copiar para Novas Solicitações)

```markdown
### CR-XXX: [TÍTULO]

**Solicitante:** [Nome]
**Data:** [YYYY-MM-DD]
**Tipo:** [Escopo/Critério/Requisito/Arquitetura/Outro]
**Prioridade:** [Baixa/Média/Alta/Crítica]

### Descrição



### Justificativa



### Impacto Esperado
- [ ] Novos requisitos funcionais
- [ ] Mudança em requisitos existentes
- [ ] Alteração de risco
- [ ] Aumento de tempo estimado
- [ ] Outro: 

### Riscos Identificados
- Risco 1: 
- Risco 2: 

### Aprovação Necessária
- [ ] Clio (Coordenadora)
- [ ] Manel (Sponsor)
- [ ] Code Reviewer
- [ ] Outro: 

### Decisão
- [ ] APROVADO
- [ ] REJEITADO
- [ ] DEFERIDO
- [ ] REQUER MAIS INFORMAÇÕES

### Justificativa da Decisão



### Plano de Implementação
- [ ] Atualizar SPECS.md
- [ ] Atualizar TODO.md
- [ ] Atualizar TRACEABILITY_MATRIX.md
- [ ] Atualizar RISK_REGISTER.md
- [ ] Criar novos requisitos RF
- [ ] Criar novos requisitos RS
- [ ] Criar novos contratos CT
- [ ] Criar novos testes TU/TI/TR
```

---

## Estatísticas

| Tipo | Aprovados | Rejeitados | Pendentes | Total |
|------|-----------|--------------|-----------|-------|
| Escopo | 0 | 0 | 0 | 0 |
| Critério | 0 | 0 | 0 | 0 |
| Requisito | 0 | 0 | 0 | 0 |
| Arquitetura | 0 | 0 | 0 | 0 |
| Outro | 0 | 0 | 0 | 0 |
| **TOTAL** | **0** | **0** | **0** | **0** |

| Prioridade | Baixa | Média | Alta | Crítica | Total |
|-----------|-------|-------|------|---------|-------|
| Quantidade | 0 | 0 | 0 | 0 | 0 |

---

## Regras de Uso

1. **Proibido** fazer mudanças sem CR aprovado
2. **Obrigatório** preencher todos os campos do formulário
3. **Obrigatório** avaliar impacto em RISK_REGISTER.md antes de aprovar
4. **Obrigatório** atualizar todos os documentos de rastreabilidade
5. **Recomendado** discutir mudanças em review de código

---

## Notas Importantes

- **CRITÉRIO FORMAL DE ENCERRAMENTO:** Todos os CR pendentes devem ser resolvidos antes de FINAL_VALIDATION
- **TRACEABILITY:** Cada CR DEVE atualizar TRACEABILITY_MATRIX.md com RFs adicionados/removidos
- **TESTES:** Mudanças aprovadas DEVEREM incluir novos testes antes de implementação
- **BACKLOG:** CRs rejeitados são movidos para BACKLOG.md (não implementado ainda)

---

*Documento de controle de mudanças - Iniciado em 2026-02-23*
*Próxima atualização: Quando nova solicitação for recebida*
