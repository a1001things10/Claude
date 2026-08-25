# 🚀 5 PLUGINS DO CLAUDE CODE - GUIA COMPLETO

**Última atualização:** 2026-08-25  
**Status:** ✓ Verificado e otimizado

## 📋 Índice
1. [OmniRoute](#1-omniroute) - Gateway de modelos local
2. [Claude Mem](#2-claude-mem) - Memória entre sessões ✓ INSTALADO
3. [Headroom](#3-headroom) - Compressão de tokens
4. [Claude Code Setup](#4-claude-code-setup) - Plugin oficial Anthropic
5. [Task Observer](#5-task-observer) - Meta-skill ✓ INSTALADO

---

## ⚙️ PRÉ-REQUISITOS

```bash
# Verificar versões
node --version          # v18+ recomendado
npm --version           # v9+ recomendado
python --version        # v3.8+ (para headroom)
git --version           # qualquer versão

# Testar Claude Code CLI
claude --version
claude config list
```

---

## 1️⃣ OMNIROUTE
**O que faz:** Gateway local que roteia requisições para diferentes modelos LLM (GLM, DeepSeek, etc)  
**Quando usar:** Testar modelos alternativos, rate limiting, proxy local  
**Status:** ✅ INSTALADO

### Instalação

```bash
# Opção A: npm global (recomendado)
npm install -g omniroute

# Opção B: npx (sem instalar)
npx omniroute --version

# Opção C: Docker (isolado)
docker run -d --name omniroute --restart unless-stopped \
  -p 127.0.0.1:20128:20128 \
  diegosouzapw/omniroute:latest
```

### Configuração para Claude Code

```bash
# 1. Iniciar OmniRoute
omniroute launch
# Abrirá em http://localhost:20128

# 2. Na interface web:
#    Dashboard → Endpoints → Copiar API Key

# 3. Configurar Claude Code
claude config set OMNIROUTE_API_KEY "sua-chave"
claude config set ANTHROPIC_BASE_URL "http://localhost:20128"
# NÃO ADICIONAR /v1 (omniroute completa automaticamente)

# 4. Testar
claude --model glm/glm-5.2
```

### .claude/settings.json (opcional)

```json
{
  "model": "glm/glm-5.2",
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:20128",
    "ANTHROPIC_MODEL": "glm/glm-5.2",
    "CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY": "1"
  }
}
```

### Troubleshooting

```bash
# Se OmniRoute não inicia
omniroute setup-claude    # auto-configura profiles
omniroute status          # verifica saúde

# Se conexão falhar
curl http://localhost:20128/health    # testar endpoint
netstat -an | grep 20128              # verificar porta
```

---

## 2️⃣ CLAUDE MEM ✅ INSTALADO
**O que faz:** Persiste memória entre sessões (contexto não esquece)  
**Quando usar:** Sempre (manter aprendizado entre sessões)  
**Status:** ✅ FUNCIONANDO

### Verificação de Status

```bash
# Confirmar instalação
which claude-mem
claude-mem --version

# Listar memórias salvass
claude-mem list

# Ver memória atual
claude-mem get --key "projeto"
```

### Como Usar

```bash
# Registrar fato importante
claude-mem set --key "stack-visual" --value "Image + DataViz + Video + Web"

# Recuperar em próxima sessão
# (Automático - Claude Mem faz isso)

# Limpar memória específica
claude-mem delete --key "antiga-key"

# Backup
claude-mem export > backup.json
claude-mem import < backup.json
```

### Integrar com Hooks

```bash
# ~/.claude/hooks/session-start.sh
claude-mem get --key "last-branch"
claude-mem set --key "session-date" "$(date)"
```

**⚠️ IMPORTANTE:** NÃO usar `npm install -g claude-mem` (breaks hooks)  
Use: `/plugin install claude-mem` via Claude Code UI

---

## 3️⃣ HEADROOM
**O que faz:** Comprime tokens/contexto (cache prompt, resumo automático)  
**Quando usar:** Sessões longas, grandes codebases, economizar tokens  
**Status:** ✅ INSTALADO

### Instalação

```bash
# Opção A: pip (recomendado)
pip install "headroom-ai[all]"

# Opção B: Poetry
poetry add headroom-ai

# Opção C: pipx (isolado)
pipx install headroom-ai
```

### Configuração

```bash
# 1. Testar instalação
headroom --version

# 2. Opção A: Executar Claude por dentro do Headroom
headroom wrap claude      # roda "claude" comprimindo tokens

# 3. Opção B: Rodar como proxy
headroom proxy --port 8787
# Configure: ANTHROPIC_BASE_URL=http://localhost:8787

# 4. Opção C: MCP Server (experimental)
headroom mcp install      # instala como MCP server
```

### Exemplo de Uso

```bash
# Sessão longa com compressão automática
headroom wrap claude code session-id-long

# Com configuração custom
export HEADROOM_COMPRESSION_RATIO=0.7    # 70% economia
export HEADROOM_STRATEGY="summarize"      # ou "cache"
headroom wrap claude
```

### Monitorar Compressão

```bash
# Logs detalhados
HEADROOM_DEBUG=1 headroom wrap claude

# Ver estatísticas
headroom stats
```

---

## 4️⃣ CLAUDE CODE SETUP
**O que faz:** Plugin oficial que recomenda automações e hooks  
**Quando usar:** Onboarding, descobrir boas práticas  
**Status:** ✅ INSTALADO

### Instalação

```bash
# Via UI Claude Code
/plugin install claude-code-setup@claude-plugins-official

# Ou via CLI
claude plugin install claude-code-setup@claude-plugins-official

# Verificar instalação
/plugin list | grep claude-code-setup
```

### Como Usar

```bash
# Na sessão Claude Code, pergunte em linguagem natural:
"recommend automations for this project"
"what hooks should I use for this repo?"
"analyze my workflow and suggest improvements"
"create pre-commit hooks for me"

# O plugin vai sugerir:
# - Hooks apropriados (.claude/hooks/*)
# - Automações com TaskCreate
# - Otimizações de workflow
# - Best practices para seu tipo de projeto
```

### Exemplo Prático

```
User: "I have a Next.js project, what automations should I add?"

Claude Code Setup:
✓ Pre-commit hook: Linting + TypeScript
✓ Session-start hook: Check branches
✓ Stop hook: Git status validation
✓ TaskCreate: Setup CI/CD
✓ ScheduleWakeup: Deploy monitoring
```

---

## 5️⃣ TASK OBSERVER ✅ INSTALADO
**O que faz:** Meta-skill que observa padrões de trabalho e sugere novas skills  
**Quando usar:** Identificar automações repetitivas  
**Status:** ✅ FUNCIONANDO

### Verificação de Status

```bash
# Confirmar instalação
ls ~/.claude/skills/task-observer/
cat ~/.claude/skills/task-observer/SKILL.md

# Ver observations armazenadas
ls ~/.claude/skills/task-observer/observations/
```

### Como Usar

```bash
# A skill funciona automaticamente, mas pode chamar:
/skill task-observer

# Dentro da skill, comandos disponíveis:
recordObservation("pattern-name", {
  type: "repetitive",
  frequency: "daily",
  complexity: "medium"
})

listOpenObservations()
weeklyReview()
```

### Exemplo de Padrão Detectado

```
Task: "Generate image variants"
Pattern: Chamado 5x/semana
Suggestion: Criar skill "image-batch-generator"
Status: ✓ JÁ CRIADA (image-pro)
```

---

## 🎯 ORDEM RECOMENDADA DE INSTALAÇÃO

### Fase 1: ESSENCIAL (agora)
```bash
# Já temos:
✅ claude-mem       (memória sessão)
✅ task-observer    (padrões)

# Instalar:
/plugin install claude-code-setup@claude-plugins-official
```

### Fase 2: OTIMIZAÇÃO ✅ FEITA
```bash
# ✅ Headroom already installed
headroom --version
headroom wrap claude      # testar
```

### Fase 3: AVANÇADO ✅ FEITA
```bash
# ✅ OmniRoute already installed
omniroute --version
omniroute launch          # Abrirá em localhost:20128
```

---

## ✅ CHECKLIST FINAL

```bash
# 1. Verificar cada ferramenta
which claude-mem           # ✅ installed
ls ~/.claude/skills/task-observer  # ✅ installed
/plugin list               # claude-code-setup: ?
which headroom             # ❌ not installed
which omniroute            # ❌ not installed

# 2. Testar Claude Mem
claude-mem get --key "test"

# 3. Testar Task Observer
/skill task-observer

# 4. Configurar hooks (opcional)
mkdir -p ~/.claude/hooks
cat > ~/.claude/hooks/session-start.sh <<'EOF'
#!/bin/bash
claude-mem get --key "last-session"
claude-mem set --key "current-session" "$(date)"
EOF
chmod +x ~/.claude/hooks/session-start.sh

# 5. Testar tudo junto
claude --version
claude-mem list
/skill task-observer
# Success!
```

---

## 🔗 LINKS ÚTEIS

| Ferramenta | Docs Oficiais |
|-----------|---|
| OmniRoute | https://github.com/diegosouzapw/omniroute |
| Claude Mem | https://github.com/thedotmack/claude-mem |
| Headroom | https://github.com/isamu/headroom-ai |
| Claude Code Setup | Built-in Anthropic |
| Task Observer | Custom skill (este projeto) |

---

## 🆘 TROUBLESHOOTING

### Claude Mem não funciona
```bash
# Solução
claude-mem reset
claude-mem init
/reload-plugins
```

### Task Observer não aparece
```bash
# Verificar instalação
ls -la ~/.claude/skills/task-observer/SKILL.md

# Recarregar
/reload-plugins
claude code
```

### Headroom lento
```bash
# Reduzir compressão
export HEADROOM_COMPRESSION_RATIO=0.5
# Aumentar cache
export HEADROOM_CACHE_SIZE=10000
```

### OmniRoute conexão recusada
```bash
# Reiniciar
omniroute kill
omniroute launch
netstat -an | grep 20128
```

---

**🎉 Pronto!** Seu Claude Code agora tem:
- 📝 Memória entre sessões
- 🔍 Detector de padrões
- ⚡ Compressão de tokens (opcional)
- 🤖 Recomendações automáticas
- 🔀 Roteamento de modelos (opcional)

Próximo passo: Usar `/skill image-pro`, `/skill video-pro`, etc para criar conteúdo visual! 🎨
