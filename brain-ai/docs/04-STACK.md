# Stack e fornecedores

## Decisões de plataforma

| Camada | Escolha | Alternativa avaliada | Razão |
|---|---|---|---|
| Linguagem | TypeScript, estrito | — | Um tipo de especificação compartilhado entre kernel, geradores e runtime |
| App da plataforma | Next.js (App Router) | Remix | Ecossistema e deploy trivial |
| Runtime dos artefatos | React + Vite | — | Renderiza especificação em tempo de execução, sem build |
| Banco da plataforma | Postgres (Neon) | Supabase | Serverless, escala a zero, ramificação por ambiente |
| Backend dos apps gerados | Supabase via management API | Postgres próprio multi-tenant | Isolamento por projeto; provisionamento programático |
| Storage de assets | Cloudflare R2 | S3 | Sem custo de egress |
| CDN e TLS | Cloudflare | — | Wildcard, DNS-01 para domínio custom |
| Fila e jobs | Postgres + pg-boss | Redis, SQS | Uma dependência a menos até haver escala que justifique |
| Observabilidade | OpenTelemetry | — | Ledger é fonte da verdade de custo; OTel para latência e erro |

## Modelos

| Uso | Modelo | Razão |
|---|---|---|
| Roteamento de intenção | Modelo pequeno | Classificação, não criação |
| Geração de especificação | Modelo de fronteira | O único passo que exige raciocínio forte |
| Correção de validação | Modelo pequeno | Recebe erro exato; tarefa mecânica |
| Aplicação de edições | Modelo pequeno dedicado | O "apply model"; maior ganho de qualidade por dólar |
| Nomes, resumos, commits | Modelo pequeno | Trivial |

**Roteamento por tier corta 50 a 70% do custo com perda quase nula.**

Nenhum gerador chama modelo diretamente — tudo passa por `ExecutionFabric.runModel()`,
que centraliza cache, retry, contabilidade e troca de fornecedor.

## Mídia

| Uso | Fornecedor | Nota |
|---|---|---|
| Camada default | **fal.ai** | Um contrato, um SDK, fallback entre modelos |
| Vídeo alto volume | **Kling direto (Kuaishou)** | US$ 0,084/s contra 0,224/s via agregador |
| Vídeo qualidade | **Veo via Vertex** | Áudio nativo |
| Imagem volume | Ideogram 4.0 Turbo | Melhor tipografia por US$ 0,03 |
| Imagem herói | Nano Banana Pro | Referência de texto em imagem |
| Imagem com marca | Recraft V4 Pro | Brand kits, vetor |
| Voz | ElevenLabs ou Cartesia | Flash a US$ 0,05/1k chars |
| Transcrição | Deepgram Nova-3 | US$ 0,0043/min |
| Montagem | FFmpeg, depois Remotion | Onde mora a margem do vídeo |

**Alerta:** a API do Sora encerra em **24/09/2026**. Não criar dependência arquitetural.

**Self-host:** não compensa para vídeo em 2026 (Wan 2.2 sai a ~US$ 0,044/s com qualidade
inferior ao Veo Lite a US$ 0,03/s). Compensa para FLUX acima de ~100k imagens/mês, e
compensa desde cedo na camada auxiliar — Whisper, remoção de fundo, upscaling.

## Pagamento

| Uso | Fornecedor |
|---|---|
| Assinatura da plataforma (BR) | **Asaas** ou **Pagar.me** — Pix e boleto |
| Assinatura embutida nos apps gerados | Mesmo provedor, via API |
| Internacional (futuro) | Stripe |

Pix nativo é a cunha de entrada. Ver `00-VISAO.md`.

## Sandbox (apenas Etapa 3)

| Opção | Cold start | Custo | Piso mensal |
|---|---|---|---|
| **Daytona** | ~90 ms | US$ 0,05/vCPU-h | nenhum |
| **E2B** | ~150 ms | US$ 0,05/vCPU-h | US$ 150 (Pro) |
| Modal | — | ~US$ 0,14/h | único com GPU no sandbox |

Avaliar Daytona primeiro pelo custo de entrada. Frota própria de Firecracker só acima de
~US$ 1M/ano de gasto com terceiros.

## Acessos necessários para desenvolvimento

Lista concreta do que precisa existir antes de a Etapa 0 começar:

**Contas e chaves**
- [ ] Anthropic API — chave com limite de gasto
- [ ] Supabase — conta com acesso à management API
- [ ] Neon — banco da plataforma
- [ ] Cloudflare — DNS, R2, wildcard TLS
- [ ] Asaas ou Pagar.me — ambiente sandbox
- [ ] fal.ai — a partir da Etapa 1
- [ ] Vercel — hospedagem da plataforma

**Rede**
Ambiente de desenvolvimento precisa de egress para: `api.anthropic.com`, `*.supabase.co`,
`*.neon.tech`, `api.cloudflare.com`, `*.r2.cloudflarestorage.com`, `fal.run`,
`api.asaas.com`, `registry.npmjs.org`.

**Repositório**
Repositório próprio com permissão de escrita. Branch protegida em `main`.

**Domínio**
Ver `08-DOMINIO.md`. Necessário antes do Publish Layer da Etapa 0, porque wildcard TLS e
subdomínio por artefato dependem dele.
