#!/bin/bash

# 5 PLUGINS DO CLAUDE CODE - AUTOMATED INSTALLER
# Instala os 5 plugins na ordem correta com verificações

set -e

echo "🚀 Claude Code 5 Plugins Installer"
echo "=================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Track installation status
INSTALLED=0
FAILED=0

# Function to print section
print_section() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
}

# Function to check if tool is installed
check_installed() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✓ $1 já está instalado${NC}"
        return 0
    else
        echo -e "${YELLOW}✗ $1 não encontrado${NC}"
        return 1
    fi
}

# Function to verify Claude
verify_claude() {
    if command -v claude &> /dev/null; then
        echo -e "${GREEN}✓ Claude Code CLI encontrado${NC}"
        claude --version
        return 0
    else
        echo -e "${RED}✗ Claude Code não instalado${NC}"
        echo "   Instale com: npm install -g @anthropic-ai/claude-code"
        return 1
    fi
}

# STEP 0: Verify Claude Code
print_section "STEP 0: Verificando Claude Code"
if ! verify_claude; then
    echo -e "${RED}Abortando instalação - Claude Code obrigatório${NC}"
    exit 1
fi

# STEP 1: Check/Install OmniRoute
print_section "STEP 1: OmniRoute (Model Gateway)"
if check_installed "omniroute"; then
    echo "Status: READY"
else
    echo "Instalando OmniRoute..."
    read -p "Instalar OmniRoute? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        npm install -g omniroute
        if check_installed "omniroute"; then
            echo -e "${GREEN}✓ OmniRoute instalado${NC}"
            ((INSTALLED++))
        else
            echo -e "${RED}✗ Falha ao instalar OmniRoute${NC}"
            ((FAILED++))
        fi
    fi
fi

# STEP 2: Check/Install Claude Mem
print_section "STEP 2: Claude Mem (Session Memory)"
if check_installed "claude-mem"; then
    echo "Status: READY"
else
    echo "Instalando Claude Mem..."
    read -p "Instalar Claude Mem? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        npm install -g claude-mem
        if check_installed "claude-mem"; then
            echo -e "${GREEN}✓ Claude Mem instalado${NC}"
            ((INSTALLED++))
        else
            echo -e "${RED}✗ Falha ao instalar Claude Mem${NC}"
            ((FAILED++))
        fi
    fi
fi

# STEP 3: Check/Install Headroom
print_section "STEP 3: Headroom (Token Compression)"
if check_installed "headroom"; then
    echo "Status: READY"
else
    echo "Instalando Headroom..."
    read -p "Instalar Headroom? (python pip requerido) (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v pip &> /dev/null; then
            pip install "headroom-ai[all]"
            if check_installed "headroom"; then
                echo -e "${GREEN}✓ Headroom instalado${NC}"
                ((INSTALLED++))
            else
                echo -e "${RED}✗ Falha ao instalar Headroom${NC}"
                ((FAILED++))
            fi
        else
            echo -e "${RED}✗ Python pip não encontrado${NC}"
            echo "   Instale Python 3.8+ com pip"
            ((FAILED++))
        fi
    fi
fi

# STEP 4: Install Claude Code Setup Plugin
print_section "STEP 4: Claude Code Setup (Official Plugin)"
echo "Este plugin se instala via UI do Claude Code"
echo ""
echo "Para instalar manualmente:"
echo "  1. Abra o Claude Code"
echo "  2. Digite: /plugin install claude-code-setup@claude-plugins-official"
echo "  3. Digite: /reload-plugins"
echo ""
read -p "Já instalou? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ((INSTALLED++))
fi

# STEP 5: Verify Task Observer
print_section "STEP 5: Task Observer (Meta Skill)"
if [ -f ~/.claude/skills/task-observer/SKILL.md ]; then
    echo -e "${GREEN}✓ Task Observer já está instalado${NC}"
    ((INSTALLED++))
else
    echo -e "${YELLOW}✗ Task Observer não encontrado${NC}"
    echo "   Se desejar instalar, clone e copie:"
    echo "   git clone https://github.com/rebelytics/one-skill-to-rule-them-all"
fi

# STEP 6: Configuration
print_section "STEP 6: Configuração Final"

# Create hooks directory if needed
if [ ! -d ~/.claude/hooks ]; then
    mkdir -p ~/.claude/hooks
    echo -e "${GREEN}✓ Diretório de hooks criado${NC}"
fi

# Optional: Create session-start hook
read -p "Criar hook de session-start? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cat > ~/.claude/hooks/session-start.sh <<'EOF'
#!/bin/bash
# Auto-loaded by Claude Code on session start
if command -v claude-mem &> /dev/null; then
    LAST_SESSION=$(claude-mem get --key "last-session-date" 2>/dev/null || echo "unknown")
    CURRENT_DATE=$(date '+%Y-%m-%d %H:%M')
    claude-mem set --key "last-session-date" "$CURRENT_DATE"
fi
EOF
    chmod +x ~/.claude/hooks/session-start.sh
    echo -e "${GREEN}✓ Hook criado: ~/.claude/hooks/session-start.sh${NC}"
fi

# STEP 7: Verification
print_section "STEP 7: Verificação Final"
echo ""
echo "Testando ferramentas instaladas:"
echo ""

if command -v omniroute &> /dev/null; then
    echo -e "${GREEN}✓${NC} omniroute $(omniroute --version 2>/dev/null || echo '')"
else
    echo -e "${YELLOW}○${NC} omniroute (não instalado)"
fi

if command -v claude-mem &> /dev/null; then
    echo -e "${GREEN}✓${NC} claude-mem $(claude-mem --version 2>/dev/null || echo '')"
else
    echo -e "${YELLOW}○${NC} claude-mem (não instalado)"
fi

if command -v headroom &> /dev/null; then
    echo -e "${GREEN}✓${NC} headroom $(headroom --version 2>/dev/null || echo '')"
else
    echo -e "${YELLOW}○${NC} headroom (não instalado)"
fi

if [ -f ~/.claude/skills/task-observer/SKILL.md ]; then
    echo -e "${GREEN}✓${NC} task-observer (skill)"
else
    echo -e "${YELLOW}○${NC} task-observer (não instalado)"
fi

echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}Instalação concluída!${NC}"
echo ""
echo "Plugins instalados: $INSTALLED"
echo "Falhas: $FAILED"
echo ""
echo "📚 Para mais detalhes, consulte:"
echo "   cat ~/.claude/5-PLUGINS-SETUP-GUIDE.md"
echo ""
echo "🚀 Próximo passo: Use os plugins!"
echo "   /plugin list                  # ver plugins"
echo "   /skill image-pro              # testar skill visual"
echo "   /skill video-pro              # criar vídeos"
echo ""
