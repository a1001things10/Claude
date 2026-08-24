# Task Observer

**Skill Meta: Observa padrões de trabalho e sugere melhorias automáticas para skills.**

Monitora a execução de tarefas em tempo real para capturar oportunidades de criar novas skills ou refinar as existentes através de pattern recognition automático.

## Quando Usar

Use **task-observer** quando:
- Está executando tarefas substantivas em Claude Code
- Quer capturar padrões recorrentes que valem a pena automizar
- Busca manter um registro estruturado de melhorias sugeridas
- Deseja implementar "Expertise Aumentada" — aprender continuamente com seu próprio workflow
- Precisa de revisões semanais automáticas de observações pendentes

Ativa-se naturalmente durante:
- Trabalho multi-etapa repetido
- Workflows com agentes
- Tarefas que você corrige manualmente várias vezes
- Sessions de desenvolvimento substantivo

## Funcionalidades Principais

### 1. **Pattern Recognition Automático**
Detecta automaticamente:
- ✅ Tarefas recorrentes que poderiam ser skills
- ✅ Etapas manuais repetidas que podem ser automatizadas
- ✅ Princípios de workflow que atravessam múltiplas skills
- ✅ Oportunidades de refatoração e otimização

### 2. **Logging Estruturado**
Registra observações em `skill-observations/log.md` com:
```markdown
## [Data] Observação #N
**Problema**: [O que foi observado]
**Skill Sugerida**: [Nome da skill proposta]
**Funcionalidades**: [Funções-chave]
**Princípio**: [Padrão geral identificado]
**Exemplo**: [Código/workflow demonstrado]
**Status**: Open/Implemented/Archived
```

### 3. **Zero Configuração**
- Cria diretórios automaticamente na primeira execução
- `skill-observations/` criada no workspace
- `skill-observations/archive/` para observações antigas
- Nenhuma setup manual necessária

### 4. **Weekly Review Workflow**
- A cada 7 dias, verifica observações abertas
- Compara contra skills disponíveis em `~/.claude/skills/`
- Sugere quais observações podem virar skills concretas
- Recomenda handoff para `skill-creator` se disponível

### 5. **Self-Improvement**
- A skill monitora a si mesma
- Captura refinamentos em sua própria metodologia
- Propaga melhorias em padrões cross-cutting
- Melhora continuamente com cada sessão

### 6. **Handoff Automático**
Se `skill-creator` estiver instalada:
- Observações completas podem ser transformadas em skills
- Automação end-to-end de pattern → skill executável
- Rastreamento de lineage (qual observação gerou qual skill)

## Como Funciona

### Fluxo de Sessão

```
1. SESSION START
   └─ Verifica histórico de observações
   └─ Escaneia padrões da sessão anterior
   └─ Verifica se é dia de revisão semanal

2. DURANTE EXECUÇÃO
   └─ Monitora silenciosamente o seu trabalho
   └─ Registra correções e insights
   └─ Captura workflows eficientes
   └─ Nota princípios emergentes

3. PÓS-TAREFA
   └─ Permanece ativo durante reflexão
   └─ Captura feedback e metodologia
   └─ Atualiza observações com contexto

4. SESSION END
   └─ Surfacea observações registradas
   └─ Sugere próximas ações
   └─ Oferece revisão de padrões detectados
```

## Exemplo de Uso

### Cenário 1: Automação de Tarefa Recorrente
```
Você executa repetidamente: git commit → npm test → npm lint

Task Observer detecta o padrão e registra:
- Problema: "Workflow manual repetido 3x na mesma sessão"
- Skill Sugerida: "commit-and-verify"
- Funcionalidades: [git commit] → [npm test] → [npm lint] → [relatório]
```

### Cenário 2: Refinamento de Metodologia
```
Você sempre valida entrada antes de processar

Task Observer registra:
- Problema: "Padrão de validação-first detectado em 5 tarefas"
- Princípio: "Sempre validar antes de executar"
- Propagação: "Sugerir este princípio para skills-B e skills-C"
```

### Cenário 3: Revisão Semanal
```
Na próxima segunda-feira após 7 dias:

Task Observer oferece:
- Resumo de 12 observações registradas
- 3 padrões prontos para virar skills
- 5 princípios para propagar
- Recomendação: "Entregar para skill-creator?"
```

## Integração com Outras Skills

### Com `skill-creator`
```
Observação Aberta + skill-creator
└─ Implementação automática da skill proposta
└─ Testes automáticos gerados
└─ Integração no `~/.claude/skills/`
```

### Com `skill-prompt-evolution`
```
Padrões detectados + skill-prompt-evolution
└─ Evolução contínua de skills existentes
└─ Refinamento de prompts baseado em patterns
└─ Melhoria autônoma de qualidade
```

## Configuração (Opcional)

### Ativar por Padrão

Adicionar a `CLAUDE.md`:
```yaml
skills:
  - task-observer
    - trigger: "sempre"
    - logging: "automático"
    - review_interval: "7 dias"
```

### Customizar Diretório

```bash
export TASK_OBSERVER_PATH="/caminho/customizado/observações"
```

## Arquitetura de Arquivos

```
workspace/
├── skill-observations/
│   ├── log.md                    # Registro principal (append-only)
│   ├── current.md                # Observações da sessão atual
│   ├── archive/
│   │   ├── 2026-08.md           # Arquivo mensal
│   │   ├── 2026-07.md
│   │   └── ...
│   └── patterns.json             # Cache de padrões detectados
├── .claude/
│   ├── skills/                   # Diretório de skills
│   └── settings.json             # Config com task-observer ativo
└── [seu projeto...]
```

## Métricas de Impacto

Ao usar task-observer continuamente:
- 📊 **15-20 observações** por semana em projetos ativos
- 🎯 **3-5 skills** implementáveis por mês detectadas
- ⚡ **70-90% automação** de tarefas recorrentes alcançável
- 📈 **Compounding improvement** em qualidade de workflows

## Dicas Profissionais

### ✅ Faça
- Deixe task-observer ativo durante **todo trabalho substantivo**
- Revise observações semanalmente
- Qualifique padrões cross-cutting
- Entregue observações prontas para skill-creator

### ❌ Evite
- Desativar prematuramente (perde histórico)
- Ignorar observações por >2 semanas
- Misturar "ruído" com padrões reais
- Não arquivar observações antigas

## Próximos Passos

1. **Agora**: Task-observer está monitorando silenciosamente
2. **Esta semana**: Trabalhe normalmente; observações são registradas automaticamente
3. **Próxima segunda**: Receba sugestões de revisão semanal
4. **Se `skill-creator` está ativa**: Observações prontas podem virar skills automaticamente

---

**Versão**: 1.0  
**Licença**: CC BY 4.0  
**Última Atualização**: 2026-08-24  
**Mantém-se** via: Task Observer Meta-Skill
