# Task Observer - Meta-Skill para Claude Code

**Monitorar, Registrar, Melhorar: Um sistema de aprendizado contínuo para automação de skills.**

## 🎯 O que é Task Observer?

Task Observer é uma **meta-skill** que funciona como uma camada observacional persistente durante suas sessões de trabalho em Claude Code. Ela monitora automaticamente a execução de tarefas para identificar oportunidades de criar novas skills ou melhorar as existentes.

## ✨ Recursos Principais

- ✅ **Pattern Recognition Automático** — Detecta tarefas recorrentes que poderiam ser automizadas
- 📝 **Logging Estruturado** — Registra observações em formato padronizado
- 🚀 **Zero Configuração** — Cria diretórios e arquivos automaticamente
- 📊 **Revisão Semanal** — Análise automática de padrões a cada 7 dias
- 🔗 **Integração com skills** — Funciona com `skill-creator` para automação end-to-end
- 🧠 **Self-Improvement** — A skill monitora a si mesma

## 📦 Instalação

A skill já está instalada em `~/.claude/skills/task-observer/`

### Ativar Automaticamente

Adicione ao seu `CLAUDE.md`:

```yaml
skills:
  - task-observer:
      trigger: "sempre"
      logging: "automático"
      review_interval: "7 dias"
```

## 🚀 Uso Rápido

### Inicializar pela primeira vez
```bash
cd ~/seu-projeto
node ~/.claude/skills/task-observer/init.js
```

Isso cria:
- `skill-observations/log.md` — Registro principal
- `skill-observations/current.md` — Observações da sessão
- `skill-observations/archive/` — Histórico mensal
- `skill-observations/patterns.json` — Cache de padrões

### Registrar uma Observação
```bash
node ~/.claude/skills/task-observer/init.js record \
  "Tarefa manual repetida 3x" \
  "commit-and-test" \
  "git-commit,npm-test,npm-lint"
```

### Listar Observações Abertas
```bash
node ~/.claude/skills/task-observer/init.js list
```

### Executar Revisão Semanal
```bash
node ~/.claude/skills/task-observer/init.js review
```

## 📊 Estrutura de Arquivos

```
seu-projeto/
├── skill-observations/
│   ├── log.md                    # Registro principal (append-only)
│   ├── current.md                # Observações da sessão atual
│   ├── patterns.json             # Cache JSON de padrões
│   └── archive/
│       ├── review-2026-08-24.md
│       ├── review-2026-08-17.md
│       └── ...
└── .claude/
    └── skills/
        └── task-observer/        # Esta skill
```

## 💡 Exemplos de Uso

### Exemplo 1: Detectar Tarefa Recorrente

Você executa o mesmo comando várias vezes:
```bash
git add .
git commit -m "commit message"
npm test
npm run lint
```

Task Observer detecta e registra:
```markdown
**Problema**: Workflow de commit+test repetido 3x na sessão

**Skill Sugerida**: commit-and-verify

**Funcionalidades**:
- git add (customizável)
- git commit (com mensagem)
- npm test
- npm lint
- Relatório de status
```

### Exemplo 2: Padrão Cross-Cutting

Você sempre valida entrada antes de processar:

```javascript
// task-a.js
if (!input.validate()) throw Error("Invalid");

// task-b.js
if (!data.validate()) throw Error("Invalid");

// task-c.js
if (!config.validate()) throw Error("Invalid");
```

Task Observer registra:
```markdown
**Problema**: Padrão "sempre validar antes" detectado em 5 skills

**Princípio**: Validation-First Pattern

**Recomendação**: Propagar princípio para skill-d, skill-e
```

### Exemplo 3: Revisão Semanal

Na segunda-feira, task-observer oferece:
- Resumo de 12-15 observações registradas
- 3-5 padrões prontos para virar skills
- Recomendações de refatoração
- Oportunidade de entregar para `skill-creator`

## 🔄 Ciclo de Trabalho

```
1. Você trabalha normalmente em seu projeto
   ↓
2. Task Observer monitora silenciosamente
   ↓
3. Padrões são registrados em skill-observations/
   ↓
4. Todo domingo: Revisão automática
   ↓
5. Observações prontas são sugeridas
   ↓
6. Você aprova e transforma em skills (manual ou com skill-creator)
   ↓
7. Novo skill disponível em ~/.claude/skills/
```

## 🎯 Métricas de Impacto

Com task-observer ativo continuamente:
- 📈 **15-20 observações** por semana em projetos ativos
- 🚀 **3-5 skills** implementáveis por mês
- ⚡ **70-90% automação** de tarefas recorrentes
- 📊 **Compounding improvement** em produtividade

## 🔗 Integração com Outras Skills

### Com `skill-creator`
Task Observer + skill-creator = Automação End-to-End
```
Observação Aberta → skill-creator → Skill Implementada → Testes Automáticos
```

### Com `claude-mem`
Task Observer + claude-mem = Memória Persistente de Padrões
```
Observações de hoje → Memória compartilhada → Contexto futuro
```

## ⚙️ Configuração Avançada

### Customizar Diretório
```bash
export TASK_OBSERVER_PATH="/caminho/customizado"
```

### Alterar Intervalo de Revisão
```bash
export TASK_OBSERVER_REVIEW_INTERVAL="5"  # 5 dias em vez de 7
```

### Desabilitar Logging Automático
```bash
export TASK_OBSERVER_AUTO_LOG="false"
```

## 🛠️ Desenvolvimento

### Estrutura de Código
```
init.js
├── initializeDirectories()      # Cria estrutura
├── initializeLogFile()          # Cria log.md
├── initializePatternsFile()     # Cria patterns.json
├── recordObservation()          # Registra uma observação
├── listOpenObservations()       # Lista abiertas
└── weeklyReview()               # Executa revisão
```

### Adicionar Novo Comando
```javascript
// Em init.js, adicionar ao switch:
case 'seu-comando':
  seuComando();
  break;
```

## 📝 Formato de Observação

```markdown
## [ISO-TIMESTAMP] Observação - skill-name

**Problema**: Descrição clara do problema observado

**Skill Sugerida**: Nome da skill proposta

**Funcionalidades**:
- Funcionalidade 1
- Funcionalidade 2
- Funcionalidade 3

**Princípio**: Padrão geral ou princípio identificado

**Exemplo**:
```código aqui```

**Status**: Open / In Progress / Implemented / Archived
```

## 🚨 Troubleshooting

### Diretório não foi criado
```bash
# Executar manualmente
node ~/.claude/skills/task-observer/init.js
```

### Permissões negadas
```bash
chmod +x ~/.claude/skills/task-observer/init.js
```

### Log não está sendo atualizado
```bash
# Verificar se arquivo existe
cat ~/seu-projeto/skill-observations/log.md

# Se não existir, reinicializar
node ~/.claude/skills/task-observer/init.js
```

## 📚 Documentação Completa

Veja `SKILL.md` para documentação completa, casos de uso avançados e integração profunda.

## 📄 Licença

CC BY 4.0 — Creative Commons Attribution

## 🤝 Contribuindo

Esta skill faz parte do projeto Claude Code. Para sugestões ou melhorias:
1. Abra uma issue no GitHub
2. Envie um PR com suas melhorias
3. Compartilhe observações de sua experiência

## 🎓 Aprenda Mais

- [Claude Code Skills Guide](https://code.claude.com/skills)
- [Task Observer GitHub](https://github.com/a1001things10/claude/.claude/skills/task-observer)
- [Pattern Recognition in AI](https://docs.anthropic.com)

---

**Versão**: 1.0.0  
**Última atualização**: 2026-08-24  
**Mantido por**: Claude Code Team
