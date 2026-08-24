# Design Automator

**Skill para criar designs profissionais em segundos: UIs, landing pages, presentations, assets visuais**

Integra Figma + Canva + Claude Vision para automação visual 100%.

## Quando Usar

Use **Design Automator** quando:
- Quer criar mockups de UI rapidamente
- Precisa de landing pages prontas
- Gerar assets visuais em larga escala
- Quer design systems automatizados
- Criar presentations visuais

## Stack

- **UI Design**: Figma + figma-code-connect
- **Visual Design**: Canva MCP (30+ operações)
- **Web Design**: Claude Design (in-browser editor)
- **Design System**: shadcn/ui components
- **Code Generation**: Figma → React (automático)

## Features

✅ Component library generation  
✅ Design system automation  
✅ Code-to-design sync  
✅ Design-to-code (Figma → React)  
✅ Batch image generation  
✅ Brand consistency  
✅ Responsive layouts  
✅ Accessibility (WCAG 2.1)  
✅ Dark mode automation  
✅ Multi-language support  

## Quick Start

### Opção 1: UI Mockup (5 min)
```bash
# 1. Criar mockup no Figma
/figma create-design "Dashboard mockup"

# 2. Adicionar componentes
# 3. Export para código
/figma get-code-connect  # → React + Tailwind

# 4. Copy-paste e pronto!
```

### Opção 2: Landing Page (10 min)
```bash
# 1. Usar template
/canva generate --template "SaaS Landing"

# 2. Customizar com marca
# 3. Export para HTML/PDF
```

### Opção 3: Design System (30 min)
```bash
# 1. Criar componentes
/figma create-design-system "MyApp"

# 2. Setup code-connect
/figma add-code-connect-map

# 3. Sincronizar automaticamente
```

## Workflows Principais

### Workflow 1: Design → Code
```
Figma Design
    ↓
Export → Code
    ↓
shadcn/ui components
    ↓
Next.js project
    ↓
Deploy automático
```

### Workflow 2: Code → Design
```
React Component
    ↓
Figma Sync
    ↓
Design system update
    ↓
Screenshots automáticas
    ↓
CI/CD docs atualizado
```

### Workflow 3: Batch Assets
```
Conceito
    ↓
100 variações (via Canva)
    ↓
Otimizar tamanhos
    ↓
CDN upload automático
    ↓
Pronto para uso
```

## Componentes Pré-Built

**UI Components:**
- Navigation bars (10 variações)
- Hero sections (15 variações)
- CTAs (20 variações)
- Forms (30 variações)
- Cards (25 variações)
- Modals (15 variações)

**Layouts:**
- SaaS landing pages (50+)
- E-commerce (40+)
- Blog (30+)
- Portfolio (25+)
- Dashboard (35+)

**Design Systems:**
- Tailwind components (200+)
- shadcn/ui complete
- Radix UI integration
- Headless UI components

## Integração com Codebase

```typescript
// lib/components.ts
import { Button, Card, Input } from '@/components/ui'

// Importados diretamente do Figma!
// Toda mudança no Figma = mudança no código
```

## Design Tokens

Suportado:
- Colors (light/dark mode)
- Typography scales
- Spacing system
- Shadows + elevations
- Breakpoints
- Custom animations

## Accessibility

Automático:
- ✅ Contrast ratios (WCAG AAA)
- ✅ Semantic HTML
- ✅ ARIA labels
- ✅ Keyboard navigation
- ✅ Screen reader optimized
- ✅ Focus indicators

## Performance

Expectativas:
- **Component copy**: < 5 segundos
- **Landing page**: < 10 minutos
- **Design system**: < 1 hora
- **Batch images**: ~2s por asset

## Pricing

- **Figma**: Free tier + $0/mês (professional)
- **Canva**: Free tier (1000+ designs)
- **Claude Design**: Free (in-browser)

## Checklist Design

- [ ] Color palette definida
- [ ] Typography configurada
- [ ] Component library pronta
- [ ] Dark mode testado
- [ ] Responsive tested (mobile/tablet/desktop)
- [ ] Accessibility auditado
- [ ] Brand kit criado
- [ ] Design tokens documented

## Pro Tips

1. **Reuse components**: Criar uma vez, usar 100x
2. **Design tokens**: Centralizar tudo em um arquivo
3. **Dark mode**: Adicionar no Figma, exporta automático
4. **Responsive**: Testar em 3 breakpoints
5. **Performance**: Optimize images (WebP, AVIF)

## Exemplos

### Landing Page SaaS (Tempo: 15 min)
```bash
# 1. Canva template
/canva generate --template "SaaS Landing" --colors "brand"

# 2. Figma mockup
/figma create-design "Dashboard"

# 3. Export para React
# 4. Deploy no Vercel
# PRONTO!
```

### Design System (Tempo: 2h)
```bash
# 1. Criar 50+ componentes no Figma
# 2. Code connect mapping automático
# 3. Sincronizar no Git
# 4. CI/CD automático
# 5. Deploy docs
# PRODUCTION READY!
```

## Próximos Passos

1. `/design-automator init` → Setup
2. `/figma create-design` → Mockup
3. `/canva generate` → Assets
4. `/deploy-design` → Production

---

**Versão**: 1.0  
**Stack**: Figma + Canva + Claude Design  
**Licença**: MIT  
**Nota**: Profissionais em 5-30 minutos
