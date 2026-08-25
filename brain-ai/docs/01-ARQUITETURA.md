# Arquitetura

## O problema que a arquitetura resolve

Plataformas generativas morrem de uma causa previsível: cada novo tipo de artefato é
construído como um produto separado, com seu próprio pipeline, sua própria contabilidade,
seu próprio versionamento. Em dois anos existem seis produtos mal integrados dividindo um
logo, e mudar qualquer coisa transversal — preço, cache, permissão — significa mudar em
seis lugares.

Brain.AI evita isso com uma aposta: **todo artefato gerável tem a mesma forma de pipeline.**

```
prompt  →  SPEC  →  validação  →  compilação  →  ARTEFATO  →  publicação
           (IR)     (determinística)  (por tipo)              (uniforme)
```

O que varia entre gerar um CRM e gerar um vídeo é apenas o **compilador**. Tudo à esquerda
e à direita dele é kernel compartilhado.

---

## 1. O kernel

Oito serviços. Eles não sabem o que é um vídeo ou um CRM — só sabem manipular
especificações e artefatos.

### 1.1 Intent Router

Recebe a mensagem do usuário e decide **qual gerador atende**. Roda em modelo pequeno e
barato, porque é classificação, não criação.

Saída: `{ generator: "app" | "image" | "video" | ..., confidence, clarifications[] }`

Quando a confiança é baixa, não adivinha: devolve perguntas. Adivinhar errado aqui custa
uma geração cara inteira.

### 1.2 Spec Layer (IR)

O coração conceitual. Cada gerador declara um **schema JSON de especificação** — uma
representação intermediária declarativa do artefato.

| Gerador | A especificação descreve |
|---|---|
| App | Entidades, campos, relações, papéis, regras de permissão, telas |
| Imagem | Grafo de prompt, referências, restrições de marca, proporção |
| Vídeo | Timeline: cenas, duração, transições, trilhas de áudio, legendas |
| Site | Árvore de seções, conteúdo, tokens de design |
| Gráfico | Fonte de dados, tipo de marca, escalas, anotações |
| Mobile | Igual App + navegação nativa e capacidades de dispositivo |
| Jogo | Grafo de cena, entidades, sistemas, regras, assets |

**A regra que sustenta tudo:** o LLM produz *especificação*, nunca o artefato final. A
especificação é pequena (5 a 20 mil tokens), validável por código e barata de corrigir.
Um schema inválido é rejeitado por um validador determinístico e devolvido ao modelo com
o erro exato — sem gastar uma geração cara.

### 1.3 Generator Registry

Registro de módulos plugáveis. **Todo gerador implementa o mesmo contrato:**

```ts
interface Generator<S extends Spec, A extends Artifact> {
  readonly id: string;
  readonly specSchema: JSONSchema;

  /** Linguagem natural → especificação. Usa LLM. */
  parse(prompt: string, ctx: Context): Promise<S>;

  /** Determinístico, sem LLM. Nunca lança; devolve diagnósticos. */
  validate(spec: S): Diagnostic[];

  /** Estimativa de custo ANTES de executar. Determinística. */
  cost(spec: S): CostEstimate;

  /** Especificação → artefato. Onde mora a diferença entre os geradores. */
  compile(spec: S, ctx: Context): Promise<A>;

  /** URL de visualização do artefato. */
  preview(artifact: A): Promise<PreviewHandle>;

  /** Modificação incremental sem recompilar tudo. */
  patch(spec: S, instruction: string, ctx: Context): Promise<S>;
}
```

**Este contrato é a decisão arquitetural mais importante do projeto.** Se um gerador novo
exigir mudança no kernel para ser adicionado, o contrato está errado e deve ser corrigido —
não contornado.

Note que `cost()` é determinística e roda antes de `compile()`. É o que permite mostrar ao
usuário quanto vai custar antes de gastar, e é o que impede o problema de créditos queimados
sem entrega.

### 1.4 Execution Fabric

Abstração sobre onde as coisas rodam. Os geradores não sabem se estão num container, numa
GPU ou numa chamada de API.

```ts
interface ExecutionFabric {
  runSandbox(image: string, cmds: Command[]): Promise<SandboxResult>;
  runModel(req: ModelRequest): Promise<ModelResult>;   // LLM e difusão
  runRender(job: RenderJob): Promise<Asset>;           // FFmpeg, Remotion
}
```

Trocar E2B por Daytona, ou fal.ai por chamada direta ao Vertex, é trocar uma implementação
aqui. Nenhum gerador é afetado.

### 1.5 Artifact Store

Versionamento uniforme. **Todo artefato é versionado em git real**, não em snapshot de blob
— inclusive os que não são código.

- Um app: repositório com o código gerado
- Um vídeo: a especificação de timeline versionada, com os assets em storage endereçado por hash
- Uma imagem: o grafo de prompt versionado, com o binário em storage

Isso dá de graça: histórico, diff, rollback, e exportação. Quem começa com tarball por
versão reescreve tudo em git seis meses depois.

### 1.6 Ledger

Contabilidade de custo real. **Toda chamada a modelo registra tokens e dólares antes de
virar crédito debitado.** Não é telemetria — é a fonte da verdade do negócio.

```
generation_id | generator | model | tokens_in | tokens_out | usd_real | credits_charged | outcome
```

A coluna `outcome` é o que impede o problema da Lasy: geração que falhou por culpa da
plataforma **não debita crédito**. Isso é política de produto codificada no kernel, não
na boa vontade do suporte.

### 1.7 Identity & Tenancy

Autenticação, organizações, papéis, chaves de API.

**Regra absoluta, herdada do incidente Base44:** identificador de tenant nunca é credencial.
`app_id` aparece em URL e é público por design; nenhum endpoint pode tratá-lo como prova
de autorização.

### 1.8 Publish Layer

Publicação uniforme para todos os tipos: domínio, TLS, CDN, controle de acesso do artefato
publicado.

- Subdomínio por artefato — **obrigatório, não cosmético.** É o que dá isolamento de origem
  entre tenants. Rota por caminho compartilha origem e é falha de segurança.
- Wildcard TLS nos subdomínios próprios; certificado individual para domínio custom.
- Emissão por validação HTTP falha atrás de proxy da Cloudflare — detectar e cair para
  validação por DNS.

---

## 2. Os geradores

Cada um é um módulo independente. A ordem de entrega está em `02-ROADMAP.md`.

### G1 · App / SaaS  — *schema-driven, sem build*

O gerador fundador, e o que prova o contrato.

A especificação descreve entidades, campos, relações, papéis e permissões. O compilador
gera **deterministicamente**: tabelas Postgres, políticas de row-level security, endpoints
CRUD, e a configuração de telas.

**O app do cliente não é código gerado — é o runtime Brain.AI lendo a especificação dele.**
Não há passo de build, logo não há erro de build. Publicar é instantâneo.

Consequências diretas:
- O LLM nunca escreve política de acesso → a classe do CVE-2025-48757 não existe aqui
- Custo por geração limitado e previsível → viabiliza plano flat com lucro
- Sem sandbox por usuário → sem frota de VMs, sem piso de infraestrutura

**Válvula de escape:** exportação para código React real, para quem bate no teto.
Entregue na Etapa 3, não antes — ela transforma o produto na Escola A e traz todos os
custos junto.

### G2 · Imagem

Especificação = grafo de prompt com referências e restrições de marca.
Compilador = roteamento entre modelos por finalidade: Ideogram para volume com tipografia,
Nano Banana para peça-herói, Recraft quando a identidade é rígida.

Overgeneration de 3× é padrão de produção, não desperdício. Deve estar no `cost()`.

### G3 · Vídeo

Especificação = timeline. Cenas, durações, transições, trilhas de áudio, legendas.
Compilador = geração de cenas por modelo + TTS + montagem determinística.

**A montagem é onde mora a margem.** Uma geração vira dezenas de entregas: mesma timeline
rerenderizada em 9:16, 1:1 e 16:9; matriz de gancho × narração × chamada. Isso é FFmpeg
ou Remotion, não modelo — custo próximo de zero por variação adicional.

Fator de retry de 1,5× é obrigatório no `cost()`.

### G4 · Gráficos e dataviz

Especificação = fonte de dados, tipo de marca, escalas, anotações.
Compilador = determinístico, sem modelo de difusão. É o gerador mais barato e mais preciso
do conjunto.

### G5 · Sites e landing pages

Especificação = árvore de seções e tokens de design. Mesmo motor de runtime do G1,
com renderização estática para CDN.

### G6 · Mobile

Especificação = G1 mais navegação nativa e capacidades de dispositivo.
Compilador = React Native via Expo; distribuição por EAS Build.

Depende do G1 estar maduro. Não iniciar antes.

### G7 · Jogos

O de maior teto e menor previsibilidade. Especificação = grafo de cena, entidades, sistemas
e regras. Compilador = runtime de jogo (Phaser para 2D, Three.js para 3D) parametrizado
pela especificação, com assets vindos do G2.

Último da fila por uma razão: é o único onde a especificação declarativa não cobre bem o
espaço do problema, porque lógica de jogo é comportamento, não estrutura.

---

## 3. Fluxo completo de uma geração

```
1.  Usuário descreve o que quer
2.  Intent Router  → escolhe gerador          [modelo pequeno]
3.  Generator.parse() → especificação          [modelo forte]
4.  Generator.validate() → diagnósticos        [determinístico, sem custo]
        ↳ inválido? devolve ao passo 3 com erro exato. Barato.
5.  Generator.cost() → estimativa              [determinístico]
6.  Ledger reserva créditos                    [pré-autorização]
7.  Generator.compile() → artefato             [caro: modelos, sandbox, render]
8.  Gates de segurança                         [obrigatórios, ver 05-SEGURANCA.md]
9.  Artifact Store versiona (commit)
10. Ledger consolida: sucesso debita, falha da plataforma estorna
11. Publish Layer expõe
```

Os passos 4 e 5 são o que separa esta arquitetura de um clone de Lasy. Validar e precificar
**antes** de gastar é o que impede o cliente de pagar pelo erro do sistema.

---

## 4. Contexto e custo de token

Regras que valem para todos os geradores:

- **Ordene o prompt do estável ao volátil**: sistema → template → catálogo de especificação
  → contexto → histórico → mensagem. Qualquer coisa dinâmica no topo destrói o cache.
- **Cache de prompt não é otimização, é a diferença entre margem positiva e negativa.**
- **Roteamento por tier**: modelo pequeno para classificar, nomear, aplicar edições e
  corrigir validação. Modelo forte apenas para produzir especificação.
- **Grep vence embeddings** para busca em código. Símbolo exato é problema lexical.
- Janela de contexto maior piora qualidade. Contexto é curadoria.

---

## 5. O que explicitamente não fazemos

- **Não treinamos modelo.** Alugamos pesos. Ninguém nesta categoria treina.
- **Não operamos frota de GPU** para vídeo — self-host perde para API em 2026.
- **Não construímos sandbox próprio** antes de ~US$ 1M/ano de gasto com terceiros.
- **Não geramos política de acesso por LLM.** Nunca.
- **Não oferecemos plano flat com vídeo generoso.** É buraco que cresce com o sucesso.
