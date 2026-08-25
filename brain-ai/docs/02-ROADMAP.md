# Roadmap

Cinco etapas. Cada uma tem **critério de saída objetivo** — não se avança sem cumprir.

A ordem não é arbitrária: cada etapa entrega valor sozinha e reduz risco da seguinte.

---

## Etapa 0 · O kernel e a prova do contrato

**Objetivo:** provar que o contrato de gerador funciona, construindo o kernel e um único
gerador de ponta a ponta.

**Escopo**
- Spec Layer com validador determinístico
- Generator Registry e o contrato `Generator`
- Ledger com contabilidade real de tokens e dólares
- Artifact Store em git
- Identity & Tenancy
- **G1 · App** completo: parse, validate, cost, compile, preview, patch
- Runtime React que renderiza especificação em tempo de execução
- Publish Layer com subdomínio e TLS

**Fora de escopo:** qualquer outro gerador. Pagamento. Multi-idioma.

**Critério de saída**
1. Um usuário descreve um CRM em português e recebe um app funcional publicado em URL própria
2. O app tem autenticação, CRUD, e permissões por papel — **nenhuma linha gerada por LLM**
3. `cost()` prevê o custo com erro menor que 15% do real medido no ledger
4. Geração que falha por culpa da plataforma não debita crédito, automaticamente
5. Gate de segurança bloqueia publicação de app com tabela sem política de acesso

**Duração realista:** 8 a 12 semanas com um desenvolvedor experiente em tempo integral.

**Por que esta etapa primeiro:** é a mais difícil e a que mais informa. Se o contrato não
aguentar o G1, ele não aguenta nada, e é melhor descobrir agora.

---

## Etapa 1 · Monetização e os geradores baratos

**Objetivo:** transformar o sistema em negócio e provar que o contrato aceita geradores
novos sem tocar no kernel.

**Escopo**
- **Pagamento com Pix nativo** (Asaas ou Pagar.me), assinatura recorrente
- Planos, ledger de créditos ligado ao faturamento
- **G5 · Sites e landing pages** — reusa o runtime do G1
- **G2 · Imagem** — roteamento entre Ideogram, Nano Banana e Recraft
- **G4 · Gráficos** — determinístico, sem difusão

**Critério de saída**
1. Cliente assina no Pix e gera sem intervenção manual
2. G2, G4 e G5 foram adicionados **sem uma linha de mudança no kernel** — se exigiram
   mudança, o contrato precisa ser corrigido antes de seguir
3. Margem bruta medida por gerador no ledger, positiva nos três

**Por que aqui:** G2, G4 e G5 são baratos, rápidos e de custo previsível. Servem como
teste do contrato com risco financeiro baixo, antes do vídeo.

---

## Etapa 2 · Vídeo

**Objetivo:** o gerador de maior custo unitário e maior percepção de valor.

**Escopo**
- **G3 · Vídeo**: timeline como especificação
- Roteamento entre modelos: Veo, Kling direto, Hailuo
- TTS e transcrição para legendas
- **Camada de montagem** — a peça que gera margem: uma geração vira N entregas por
  reformatação e variação combinatória
- Crédito com preço marginal explícito, **nunca flat**

**Critério de saída**
1. Um anúncio de 30 segundos gerado ponta a ponta com custo real dentro de 20% da estimativa
2. Uma geração produz no mínimo 6 entregas (3 proporções × 2 variações) com custo
   marginal próximo de zero
3. Fator de retry medido em produção e refletido em `cost()`

**Alerta de fornecedor:** a API do Sora encerra em 24/09/2026. Não criar dependência.

---

## Etapa 3 · Extensão e válvula de escape

**Objetivo:** romper o teto de expressividade sem quebrar o que funciona.

**Escopo**
- **Exportação para código React real** — a válvula de escape do G1
- Sandbox de execução (E2B ou Daytona) — **só agora** entra a frota
- **G6 · Mobile** via Expo
- Componentes customizados dentro de apps do G1

**Critério de saída**
1. Um app do G1 exporta para repositório funcional que builda e roda fora da plataforma
2. Custo de sandbox por usuário ativo medido e dentro do orçamento definido em `03-ECONOMIA.md`

**Por que só agora:** o sandbox é o que traz o piso de infraestrutura e a complexidade
operacional. Adiar isso ao máximo é o que permitiu ao Base44 operar com menos de dez pessoas.

---

## Etapa 4 · Jogos e o teto

**Escopo**
- **G7 · Jogos**: runtime Phaser e Three.js parametrizado
- Assets vindos do G2
- Editor visual de cena

**Critério de saída**
1. Um jogo 2D simples jogável, gerado e publicado
2. O contrato de gerador **continua intacto** — se o G7 exigir mudança no kernel, documentar
   como falha de projeto do contrato e corrigir

**Risco declarado:** lógica de jogo é comportamento, não estrutura. É o único gerador onde
a especificação declarativa pode não cobrir bem o espaço do problema. Se o G7 provar isso,
a resposta correta é limitar o escopo do gerador, não corromper o kernel.

---

## Resumo

| Etapa | Entrega | Duração | Traz frota de VM? |
|---|---|---|---|
| 0 | Kernel + App | 8–12 sem | Não |
| 1 | Pix + Site + Imagem + Gráfico | 6–8 sem | Não |
| 2 | Vídeo | 6–8 sem | Não |
| 3 | Export + Mobile + Sandbox | 10–14 sem | **Sim** |
| 4 | Jogos | 8–12 sem | Sim |

**Total até negócio funcionando (Etapas 0–2): 20 a 28 semanas.**

As três primeiras etapas rodam sem sandbox e sem frota — piso de infraestrutura baixo,
margem alta, equipe pequena. Essa é a janela em que o negócio precisa provar que se paga.
