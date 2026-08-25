# Registro de decisões arquiteturais

Formato: contexto, decisão, consequência. Uma decisão revogada não é apagada — é marcada
como substituída, com link para a que a substituiu.

---

## ADR-001 · Especificação declarativa em vez de geração de código

**Data:** Agosto/2026 · **Status:** Aceita

**Contexto**
Duas escolas na categoria. A **Escola A** (Lovable, Bolt, v0, Lasy) faz o LLM escrever
código de infraestrutura — SQL, políticas de acesso, funções. A **Escola B** (Base44) faz
o LLM preencher um schema declarativo, e a plataforma gera a infraestrutura
deterministicamente.

A Escola A produz o modo de falha dominante do mercado: build quebra, crédito é consumido,
cliente paga pelo erro. É o padrão documentado nas 62 reclamações não respondidas da Lasy.

**Decisão**
Escola B como fundação. O LLM produz especificação; a plataforma compila.

**Consequências**
- Sem passo de build, sem erro de build
- Custo por geração limitado e previsível (US$ 0,04–0,12 no G1)
- A classe do CVE-2025-48757 deixa de existir
- Elimina sandbox e proxy de preview das Etapas 0 a 2
- **Custo:** teto de expressividade. Mitigado por ADR-004.

---

## ADR-002 · Contrato uniforme de gerador

**Data:** Agosto/2026 · **Status:** Aceita

**Contexto**
O escopo do produto inclui artefatos de naturezas muito diferentes — app, imagem, vídeo,
jogo. A tentação é construir cada um como produto separado, o que leva a seis pipelines
mal integrados e a impossibilidade de melhorar qualquer coisa transversal.

**Decisão**
Todo gerador implementa `parse / validate / cost / compile / preview / patch`. O kernel
não conhece a natureza do artefato.

**Consequências**
- Melhorias no kernel — cache, ledger, versionamento, publicação — beneficiam todos os
  geradores de uma vez
- Adicionar gerador não requer mudança no kernel
- **Teste de saúde da arquitetura:** se um gerador novo exigir mudança no kernel, o contrato
  está errado e deve ser corrigido, não contornado. Verificado explicitamente na Etapa 1.

---

## ADR-003 · Custo estimado antes de executar

**Data:** Agosto/2026 · **Status:** Aceita

**Contexto**
O problema central de confiança na categoria é crédito consumido sem entrega.

**Decisão**
`cost()` é determinística, roda antes de `compile()`, e o resultado é mostrado ao usuário.
O ledger pré-autoriza. Falha atribuível à plataforma estorna automaticamente.

**Consequências**
- Estorno é código no kernel, não política de suporte
- Exige que cada gerador saiba estimar seu custo antes de rodar — restrição real de projeto
- Habilita limites de gasto por tenant (C8)

---

## ADR-004 · Válvula de escape adiada para a Etapa 3

**Data:** Agosto/2026 · **Status:** Aceita

**Contexto**
A ADR-001 impõe teto de expressividade. A saída natural é exportar para código React real.
Mas exportação transforma o produto na Escola A e traz sandbox, build e todos os custos.

**Decisão**
Exportação entra na Etapa 3, depois de o negócio já se pagar.

**Consequências**
- Etapas 0 a 2 operam sem frota de máquinas, com equipe pequena
- Clientes que batem no teto antes da Etapa 3 são perdidos — **custo aceito conscientemente**
- Base44 provou que esse teto é comercialmente tolerável: US$ 100M de ARR com menos de
  dez pessoas

---

## ADR-005 · Crédito como unidade de preço

**Data:** Agosto/2026 · **Status:** Aceita

**Contexto**
Cobrar por token acopla o preço ao fornecedor e expõe a variância de custo ao cliente.

**Decisão**
Crédito. Sempre. O ledger registra o custo real em dólar separadamente.

**Consequências**
- Troca de modelo sem mexer no preço
- Margem verdadeira por gerador é mensurável
- Vídeo cobrado por crédito com preço marginal explícito; app e gráfico suportam flat

---

## ADR-006 · Git real para todo artefato

**Data:** Agosto/2026 · **Status:** Aceita

**Contexto**
Versionar por snapshot de blob é mais simples no início e vira reescrita completa depois.

**Decisão**
Todo artefato versionado em git, inclusive os que não são código. Vídeo versiona a
especificação de timeline; assets em storage endereçado por hash.

**Consequências**
- Histórico, diff, rollback e exportação vêm de graça
- Vínculo com repositório externo por **identificador numérico estável**, nunca por nome —
  a Lovable quebra o sync permanentemente quando o repositório é renomeado, por ter guardado
  o nome

---

## ADR-007 · Pix nativo como cunha de entrada

**Data:** Agosto/2026 · **Status:** Aceita

**Contexto**
Concorrentes globais priorizam Stripe. O público-alvo brasileiro precisa de Pix recorrente,
e transformar audiência em receita recorrente é o trabalho que ele está tentando fazer.

**Decisão**
Pix nativo nos apps gerados, não como integração opcional. Asaas ou Pagar.me.

**Consequências**
- Diferencial que os concorrentes globais não têm incentivo para replicar
- Acopla a Etapa 1 a regulação e a um provedor brasileiro
- Internacionalização (Stripe) fica para depois da Etapa 3

---

## Decisões em aberto

| Questão | Depende de | Etapa |
|---|---|---|
| Daytona ou E2B | Medição de cold start e custo real | 3 |
| Supabase por app ou cluster compartilhado | Custo de provisionamento em escala | 1 |
| Remotion ou FFmpeg puro na montagem | Complexidade das timelines reais | 2 |
| G7 cabe no contrato de gerador? | Prova na Etapa 4 | 4 |
