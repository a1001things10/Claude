# Pesquisa de mercado e engenharia reversa

Levantamento de agosto de 2026. **Ressalva de método:** o ambiente de pesquisa teve egress
bloqueado para lasy.ai e para praticamente todas as páginas oficiais de preço. Os dados vêm
de registro público, trackers e fontes secundárias. **Revalidar antes de decisão de contrato.**

---

## 1. Lasy AI

### Registro público
- **LASY NEGÓCIOS DIGITAIS LTDA** — CNPJ 61.980.588/0001-81
- Aberta em **30/07/2025**, Florianópolis/SC
- Capital social **R$ 10 mil**. Sem rodada de investimento registrada
- Sócio-administrador: Fabiano de Souza Carvalho Junior, também administrador da
  **Guru Soluções Digitais** (Gurukiller)
- Produto criado pela equipe do Gurukiller, vendido junto ao infoproduto "Manual do Milhão"
- Rosto público do produto é Embaixador Oficial da Lovable no Brasil

### Produto
- Prompt em texto ou áudio, upload de screenshots, URLs e documentos como referência
- Gera apps SaaS, sites, dashboards, CRMs, jogos, painéis
- Stack declarada: **Supabase + GitHub + Vercel** — idêntica ao padrão Lovable
- **Qual LLM usa: não é público em nenhuma fonte**

### Preços
| Plano | R$/mês | Créditos | Destrava |
|---|---|---|---|
| Starter | 97 | 500 | Domínio custom, 1 dispositivo |
| Pro | 197 | 1.500 | + Supabase, + GitHub, 2 dispositivos |
| Scale | 997 | 9.000 | + 5 colaboradores |

Banco de dados real e acesso ao código só a partir do Pro. Sem trial gratuito.

### Reputação — o dado mais importante
**Reclame Aqui: 62 reclamações, 0% respondidas, classificação "Não Recomendada".**

Padrão recorrente: falha na geração exigindo reiniciar projeto, tela em branco, **crédito
consumido sem entrega** (registro de usuário Pro com 622 créditos queimados sem resultado),
suporte orientando comprar mais créditos, dificuldade de cancelamento.

**Leitura:** não é apenas má gestão. É o sintoma econômico de repassar ao cliente o custo do
retry numa arquitetura que gera código e depende de build. É a causa que o ADR-001 elimina.

---

## 2. Anatomia técnica da categoria

### Loop de geração
Padrão convergente: intenção → coleta de contexto → change set → build → feedback.

Achados relevantes:
- Equipe Lovable **testou orquestração multi-agente complexa e abandonou**
- Relata que **janelas de contexto maiores pioraram a qualidade** — contexto é curadoria
- Arquitetura vencedora: modelo barato roteando, modelo forte gerando, verificação
  determinística fechando

### Aplicação de edições — o gargalo real
Três estratégias, em ordem de maturidade:
1. Reescrita de arquivo inteiro — robusta, caríssima em tokens de saída
2. Blocos search-replace — baratos, **5 a 15% de falha de match**
3. **Apply model dedicado** — modelo pequeno recebe original + edição preguiçosa e emite
   o final. É o que a Vercel fez com a Fireworks (~40× mais rápido, roda inline no stream)

O item 3 é o maior diferencial de qualidade percebida por dólar.

### v0 não é "um LLM com prompt"
É uma **família de modelos compostos**: RAG especializado de framework + raciocínio de
modelo de fronteira + **modelo customizado de correção de erros aplicado em streaming**.

### Sandbox
| Abordagem | Quem | Cold start | Custo | Limitação |
|---|---|---|---|---|
| WASM no browser | Bolt, StackBlitz | instantâneo | ≈ US$ 0 | Só JS/Node, sem binários nativos |
| Container | Replit, Daytona | ~90 ms | US$ 0,05/vCPU-h | Kernel compartilhado |
| microVM Firecracker | E2B | ~150 ms | US$ 0,05/vCPU-h | Kernel + memória por sandbox |

E2B usa **pool de VMs pré-aquecidas com snapshot de memória** — restaura em vez de bootar.
Replit usa container por usuário com Postgres próprio e Nix para pacotes reprodutíveis.

### Backend gerenciado — a bifurcação
- **Lovable Cloud é Supabase por baixo**, instância de propriedade da Lovable, invisível no
  dashboard do usuário. Na prática, um orquestrador da management API do Supabase
- **Base44 tem backend próprio**: entidades como **JSON Schema**, plataforma cuida de
  storage, validação e migrations. Ao gerar UI, projeta o schema simultaneamente

Esta é a distinção arquitetural mais importante da pesquisa, e a origem do ADR-001.

### Preview
Padrão server-side: sandbox roda dev server → proxy de borda mapeia
`{projectId}.preview.dominio` → wildcard TLS → **upgrade de WebSocket obrigatório** ou o
hot reload morre. Subdomínio por projeto é isolamento de origem, não estética.

### Versionamento
Lovable tem sync bidirecional com GitHub, mas **renomear o repositório quebra o sync
permanentemente** — denuncia que o vínculo é guardado por nome em vez de identificador
numérico. Erro a não repetir (ADR-006).

### Economia de token
- Iteração típica: 30–90k tokens de entrada, 2–10k de saída
- Cache de prompt derruba entrada para ~10%
- **Ordenar do estável ao volátil**; qualquer coisa dinâmica no topo destrói o cache
- Roteamento por tier corta 50–70%
- Todos cobram por **crédito**, não por token

---

## 3. Segurança — incidentes

Detalhamento e controles derivados em `05-SEGURANCA.md`.

- **Base44 / Wiz (jul/2025):** endpoints de registro sem autenticação; `app_id` público
  permitia entrar em apps privados, contornando SSO. Corrigido em 24h
- **Lovable / CVE-2025-48757:** 170 de 1.645 apps com banco exposto (10,3%), 303 endpoints
  vulneráveis. Causa: RLS gerada por LLM, ausente ou permissiva
- **VibeScamming:** páginas de phishing publicadas em subdomínios confiáveis da plataforma
- **Tríade letal:** dados privados + conteúdo não confiável + canal de exfiltração no
  mesmo agente

---

## 4. Números públicos

| Empresa | ARR | Valuation | Captação | Time |
|---|---|---|---|---|
| **Base44** | US$ 100M (9 meses pós-deal) | Vendida por US$ 80M + 90M earn-out | **US$ 0** | **< 10**, fundador solo |
| **Bolt / StackBlitz** | US$ 40M | ~US$ 700M | US$ 135M | ~30 |
| **Lovable** | ~US$ 600M | US$ 13,3B | US$ 552M | 146–300 |

### A calibração
O dado mais acionável do levantamento: **Base44 — fundador solo, menos de dez pessoas, zero
captação, US$ 100M de ARR, saída por US$ 80M.**

A barreira de entrada técnica nesta categoria é baixa. A barreira é de **distribuição e de
escolha arquitetural**. E a arquitetura que o fundador solo escolheu foi a mais barata de
operar: backend declarativo próprio, sem sandbox por usuário, sem git, sem container.

Bolt, no outro extremo, chegou a US$ 40M com 30 pessoas porque **o compute do sandbox é
pago pelo browser do usuário**.

**As duas operações de eficiência extrema evitaram operar frota de máquinas.** Quem opera
frota de verdade tem centenas de engenheiros.

Essa observação é a razão de ser das Etapas 0 a 2 do roadmap.

---

## 5. Camada de mídia

Preços e matemática completa em `03-ECONOMIA.md`. Achados estruturais:

- **Piso de vídeo caiu para US$ 0,03–0,08/s**; teto com áudio nativo em US$ 0,12–0,40/s
- **Spread agregador vs direto é grande**: Kling a US$ 0,084/s direto contra US$ 0,224/s
  via fal — 2,6×
- **API do Sora encerra em 24/09/2026** — não criar dependência
- **Self-host de vídeo não compensa em 2026**: Wan 2.2 a ~US$ 0,044/s com qualidade
  inferior ao Veo Lite a US$ 0,03/s
- **Self-host de imagem compensa acima de ~100k/mês**; camada auxiliar compensa sempre
- **Onde está a margem do vídeo:** a camada de montagem. Uma geração vira dezenas de
  entregas por reformatação e variação combinatória, a custo marginal quase zero
- Plataformas de criativo (Arcads, HeyGen, Creatify) fecham o loop com dados de performance
  de ads — **o cliente não compra vídeo, compra taxa de acerto**
