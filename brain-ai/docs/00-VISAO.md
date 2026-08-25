# Visão

## O produto

Brain.AI transforma linguagem natural em artefatos digitais completos e publicados:
aplicações SaaS, sites, imagens, vídeos, gráficos, apps móveis e jogos.

## O posicionamento

O mercado brasileiro de plataformas generativas tem hoje um ocupante visível — Lasy AI —
com um problema documentado e não resolvido.

**O que a pesquisa mostrou** (detalhes em `07-PESQUISA.md`):

- Lasy é operada por uma casa de infoprodutos, não por uma empresa de engenharia
- CNPJ aberto em 30/07/2025, capital social de R$ 10 mil, sem captação
- Reclame Aqui: **62 reclamações, 0% respondidas**, classificação "Não Recomendada"
- Padrão recorrente das reclamações: **crédito consumido sem entrega**

Esse padrão não é acidente de gestão. É consequência direta de uma escolha arquitetural:
gerar código, mandar para build, e repassar ao cliente o custo do retry quando o build
quebra.

**A oportunidade não é fazer o mesmo melhor. É fazer diferente de um jeito que elimina
a causa.**

## A tese

> A confiabilidade é o produto.

Um usuário que descreve um CRM e recebe um CRM funcionando, sempre, vale mais do que um
usuário que às vezes recebe qualquer coisa. A arquitetura schema-driven da Etapa 0 existe
para tornar isso estruturalmente verdadeiro, não uma promessa de marketing:

- Sem passo de build, não há erro de build
- Validação determinística antes de gastar
- Custo previsto antes de executar
- Falha da plataforma não debita crédito, por código

## A cunha de entrada

**Pix nativo.** Não "conecte seu gateway" — o app gerado já nasce cobrando assinatura
recorrente em Pix.

Lovable e Base44 não fazem isso e não vão fazer: o mercado deles é global e a prioridade
é Stripe. Lasy afirma suportar gateway, mas o mercado reporta problemas de entrega.

Para o público brasileiro que quer transformar audiência em receita recorrente, essa é a
diferença entre um app e um negócio.

## Mercado-alvo

**Primário:** criadores, infoprodutores e pequenas agências brasileiras que precisam
entregar software de assinatura e material de marketing sem equipe técnica.

**Secundário:** pequenas e médias empresas que precisam de ferramentas internas —
CRM, painéis, controle de processo — e não têm orçamento para desenvolvimento sob medida.

## O que Brain.AI não é

- **Não é um IDE.** Quem quer escrever código tem ferramentas melhores.
- **Não é um treinador de modelos.** Alugamos pesos. Ninguém nesta categoria treina.
- **Não é infraestrutura genérica.** Não vendemos sandbox nem GPU.
- **Não é uma plataforma que promete tudo desde o dia um.** O kernel aceita tudo; os
  geradores chegam por etapa, cada um com qualidade de produção.

## O risco central e sua mitigação

**Risco:** teto de expressividade. A arquitetura declarativa cobre bem o que tem forma de
estrutura — cadastro, relação, permissão, tela, timeline, layout. Cobre mal o que é
comportamento livre, especialmente lógica de jogo.

**Mitigação em duas camadas:**
1. Componentes customizados dentro de apps (Etapa 3)
2. Exportação para código React real (Etapa 3) — a válvula de escape para quem bate no teto

**O que não fazemos:** corromper o kernel para acomodar um gerador. Se o G7 provar que
jogos não cabem no contrato, a resposta correta é limitar o escopo do G7 e documentar
o limite — não transformar o kernel num monolito.
