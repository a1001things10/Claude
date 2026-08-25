# Economia

> Todos os preços de fornecedor são de agosto de 2026, compilados de fontes secundárias.
> **Revalidar na página oficial antes de virar decisão de contrato ou de precificação.**

---

## 1. O princípio

O custo de uma plataforma generativa é **marginal e variável**. Isso a torna diferente de
um SaaS tradicional, onde o custo por usuário adicional tende a zero. Aqui, cada geração
tem um custo real em dólar, e ignorar isso é o erro que quebra o negócio.

**Regra fundadora:** nenhum plano é lançado sem que o ledger tenha medido o custo real do
gerador em produção. Preço derivado de estimativa é chute.

---

## 2. Custo por unidade gerada

### App (G1)

| Item | Tokens | Custo |
|---|---|---|
| Roteamento de intenção | ~2k in / 200 out | ~US$ 0,002 |
| Geração de especificação | ~15k in / 8k out | ~US$ 0,10 |
| Correção de validação (quando ocorre) | ~5k in / 3k out | ~US$ 0,03 |
| Compilação | determinística | US$ 0 |
| **Total típico** | | **~US$ 0,12** |

Com cache de prompt no prefixo estável, o custo de entrada cai para cerca de 10%.
**Custo efetivo por geração de app: US$ 0,04 a 0,12.**

Este número é o que viabiliza plano flat no G1 — e é a vantagem estrutural da arquitetura
schema-driven sobre a geração de código.

### Imagem (G2)

| Modelo | US$/peça | Uso |
|---|---|---|
| Ideogram 4.0 Turbo | 0,030 | Volume, tipografia |
| Seedream 5.0 Lite | 0,035 | Variações |
| Nano Banana 2 | 0,045–0,151 | Padrão |
| GPT-Image 2 | 0,06–0,211 | Instrução complexa |
| Nano Banana Pro | 0,134–0,24 | Peça-herói |
| Recraft V4 Pro | 0,25 | Marca rígida |

**Overgeneration de 3× é obrigatória no `cost()`.** Um lote de 20 peças entregues
consome 60 gerações: **US$ 1,80 a 15,00** conforme o modelo.

### Vídeo (G3)

Custo por segundo gerado:

| Modelo | US$/s | Áudio | Nota |
|---|---|---|---|
| Veo 3.1 Lite | 0,03 | opcional | Piso de mercado, 720p |
| Runway Gen-4 Turbo | 0,05 | não | Rápido |
| Hailuo 2.3 | 0,07 | parcial | Melhor custo do tier produção |
| Kling 3.0 direto | 0,084 | sim | **2,6× mais barato que via agregador** |
| Veo 3.1 Fast | 0,12 | sim | Melhor equilíbrio |
| Kling 3.0 Pro | 0,168 | sim | 4K, lip-sync multilíngue |
| Veo 3.1 Standard | 0,40 | sim | Teto de qualidade |

**Anúncio completo de 30 segundos:**

| Item | Custo |
|---|---|
| Roteiro (LLM) | 0,01 |
| 4 cenas × 8s @ Veo 3.1 Fast | 3,84 |
| Retries (fator 1,5×) | 1,92 |
| Voz (ElevenLabs Flash, 450 chars) | 0,02 |
| Trilha | 0,02 |
| Legendas (Deepgram) | 0,002 |
| Montagem | 0,10 |
| **Total** | **US$ 5,91** |

Versão econômica com Veo Lite e FFmpeg próprio: **US$ 1,60–2,30**.
Versão premium com Kling 3 Omni: **US$ 12–20**.

**O multiplicador de margem:** a mesma timeline rerenderizada em 3 proporções × 2 variações
= 6 entregas ao custo marginal da montagem (~US$ 0,10 cada). O custo por entrega cai de
US$ 5,91 para **US$ 1,08**.

### Gráfico (G4)

Determinístico após a especificação. **~US$ 0,03 por gráfico**, só o custo do LLM.
O gerador mais lucrativo do conjunto.

---

## 3. O erro que quebra o negócio

| Preço ao cliente | COGS | Margem bruta |
|---|---|---|
| US$ 0,50 / imagem | 0,09 | **82%** |
| US$ 20 / vídeo 30s | 5,91 | **70%** |
| US$ 99/mês flat · 20 vídeos + 200 imagens | **145** | **−46%** |

**Assinatura flat com vídeo generoso não é aquisição agressiva. É um buraco que aumenta
com o sucesso** — quanto mais o cliente usa, mais se perde.

### A regra

- **Vídeo:** crédito com preço marginal explícito. Sempre.
- **Imagem:** crédito, com franquia mensal generosa.
- **App, site, gráfico:** flat é seguro. Custo por geração é de centavos.

---

## 4. Modelo de créditos

**Crédito, nunca token.** Isso desacopla o preço do fornecedor por baixo, permite trocar
de modelo sem mexer no pricing, e esconde a variância de custo do usuário.

### Princípios do ledger

1. **Pré-autorização.** `cost()` roda antes de `compile()`. O usuário vê o custo e o
   sistema reserva os créditos.
2. **Estorno automático em falha de plataforma.** Erro de validação, timeout de fornecedor,
   bug — não debita. Isso é código no kernel, não política de suporte.
3. **Falha por instrução ambígua do usuário debita**, mas com transparência: o ledger
   registra o motivo e o usuário vê.
4. **Custo real sempre registrado**, mesmo quando o crédito cobrado difere. É a única
   forma de saber a margem verdadeira por gerador.

O ponto 2 é a diferença competitiva direta contra a Lasy, cujo padrão de reclamação
documentado é exatamente crédito consumido sem entrega.

---

## 5. Custo fixo de operação

### Etapas 0 a 2 (sem frota)

| Item | US$/mês |
|---|---|
| LLM (uso) | 200–600 |
| Postgres da plataforma (Neon) | 0–25 |
| Supabase (backend dos apps) | por projeto |
| Hospedagem e CDN | 20–50 |
| Storage de assets (R2) | 5–30 |
| Domínio e TLS | ~2 |
| **Total** | **~US$ 250–700** |

### Etapa 3 em diante (com sandbox)

| Item | US$/mês |
|---|---|
| Tudo acima | 250–700 |
| Sandbox (E2B Pro, piso) | **150** |
| Sandbox (uso: US$ 0,05/vCPU-h) | variável |
| **Total** | **~US$ 400–1.200+** |

Daytona não tem mínimo mensal e tem cold start menor (~90 ms contra ~150 ms do E2B).
Avaliar ambos na Etapa 3.

---

## 6. Calibração de mercado

| Empresa | ARR | Captação | Time | Arquitetura |
|---|---|---|---|---|
| **Base44** | US$ 100M | **US$ 0** | **< 10** | Backend declarativo, sem sandbox |
| Bolt | US$ 40M | US$ 135M | ~30 | Sandbox no browser do usuário |
| Lovable | ~US$ 600M | US$ 552M | 146–300 | Gera repo real, opera infra |

**A leitura:** as duas operações de eficiência extrema evitaram operar frota de máquinas.
Base44 vendeu por US$ 80M mais earn-out com menos de dez pessoas e zero captação.

A arquitetura do Brain.AI reproduz deliberadamente essa escolha nas Etapas 0 a 2, e só
admite frota na Etapa 3, quando o negócio já deve se pagar.
