# Brain.AI

> Plataforma generativa de propósito geral. Um kernel, muitos geradores.

**Status:** Especificação. Nenhuma linha de produção escrita.
**Criado:** Agosto de 2026
**Documento raiz:** [`docs/01-ARQUITETURA.md`](docs/01-ARQUITETURA.md)

---

## O que é

Brain.AI transforma linguagem natural em artefatos digitais completos — aplicações SaaS,
imagens, vídeos, sites, gráficos, apps móveis e jogos — e os publica prontos para uso.

O que distingue Brain.AI de um clone de Lovable ou Lasy não é a lista de coisas que gera.
É a **arquitetura que permite adicionar um novo tipo de artefato sem tocar no núcleo.**

## A tese em uma frase

> Toda geração, seja de um CRM ou de um vídeo de 30 segundos, é o mesmo pipeline:
> **prompt → especificação declarativa → validação determinística → compilação → publicação.**
> O que muda entre um CRM e um vídeo é apenas o compilador.

Essa uniformidade é o produto. É o que permite que o sistema raiz receba melhorias que
beneficiam todos os geradores de uma vez — cache de prompt, contabilidade de custo,
versionamento, permissões, publicação — sem reescrever nada.

## Índice da documentação

| Documento | Conteúdo |
|---|---|
| [`00-VISAO.md`](docs/00-VISAO.md) | Posicionamento, mercado, o que Brain.AI não é |
| [`01-ARQUITETURA.md`](docs/01-ARQUITETURA.md) | Kernel, contrato de gerador, IR, fluxo de execução |
| [`02-ROADMAP.md`](docs/02-ROADMAP.md) | Etapas de entrega, critérios de saída de cada uma |
| [`03-ECONOMIA.md`](docs/03-ECONOMIA.md) | Custo unitário, modelo de créditos, precificação |
| [`04-STACK.md`](docs/04-STACK.md) | Decisões técnicas e fornecedores |
| [`05-SEGURANCA.md`](docs/05-SEGURANCA.md) | Modelo de ameaça e controles obrigatórios |
| [`06-DECISOES.md`](docs/06-DECISOES.md) | Registro de decisões arquiteturais (ADR) |
| [`07-PESQUISA.md`](docs/07-PESQUISA.md) | Engenharia reversa de Lasy, Lovable, Base44 |
| [`08-DOMINIO.md`](docs/08-DOMINIO.md) | Candidatos de domínio e checklist de registro |

## Princípios inegociáveis

1. **O modelo nunca escreve infraestrutura de segurança.** Políticas de acesso,
   autenticação e permissões são geradas por código determinístico, sempre.
2. **Nenhum artefato é publicado sem passar por gates automáticos.** Validação de
   especificação, verificação de acesso e varredura de segredos.
3. **Custo é medido por geração, não estimado.** Toda chamada a modelo registra tokens
   e dólares reais no ledger antes de virar crédito debitado.
4. **Um gerador novo não pode exigir mudança no kernel.** Se exigir, o contrato está errado.
5. **Vídeo se cobra por crédito. Nunca flat.**

## Próximo passo

Registrar o domínio (ver [`08-DOMINIO.md`](docs/08-DOMINIO.md)) e executar a Etapa 0
do roadmap: o kernel e o primeiro gerador.
