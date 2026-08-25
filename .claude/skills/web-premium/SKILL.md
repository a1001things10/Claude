# Web Premium

**Skill para criar websites premium com design e performance máximos**

Gera sites profissionais usando Framer, CMS, Design System e deploy automático.

## Quando Usar

Use **Web Premium** quando:
- Quer criar websites de agência
- Precisa de CMS headless
- Quer design system completo
- Criar portfólio profissional
- Landing pages conversion-optimized
- Websites escaláveis

## Stack

- **Framer**: Motion + Design + Code
- **Storyblok**: CMS Headless
- **Sanity**: CMS flexível
- **Shadcn/ui**: Design system
- **Next.js 14**: Framework rápido
- **Vercel**: Deploy + Analytics

## Quick Start

```bash
# 1. Criar site premium
/web-premium create --template "agency"

# 2. Setup CMS
npx create-sanity-studio@latest

# 3. Deploy
npm run deploy

# Site profissional live em 10 minutos!
```

## Casos de Uso

### Website de Agência (20 min)
```
Portfolio + Case studies
↓
Framer + Sanity CMS
↓
Conversão otimizada
```

### Landing Page SaaS (15 min)
```
Template profissional
↓
Customização branding
↓
A/B testing built-in
```

### Portfólio Designer (10 min)
```
Galeria dinâmica
↓
CMS integrado
↓
Animations suaves
```

### Blog Profissional (5 min)
```
MDX + CMS
↓
SEO otimizado
↓
Performance 100/100
```

## Pricing

- **Framer**: Free + Pro ($15/mês)
- **Storyblok**: Free + pricing
- **Sanity**: Free tier + upgrade
- **Shadcn/ui**: Grátis
- **Vercel**: Gratuito + Pro

## Features

✅ CMS integrado  
✅ Design system  
✅ Animations fluidas  
✅ Dark mode automático  
✅ SEO completo  
✅ Analytics built-in  
✅ A/B testing  
✅ Performance 100/100  

## Integration

```typescript
import { createWebsite } from '@web-premium/sdk'

const site = await createWebsite({
  template: 'agency',
  cms: 'sanity',
  design: 'premium',
  analytics: true,
  seo: {
    title: '...',
    description: '...',
    ogImage: '...'
  }
})
```

## Templates Disponíveis

| Template | Uso | Features |
|----------|-----|----------|
| Agency | Serviços | Portfólio + Blog |
| SaaS | Produtos | Pricing + Docs |
| Portfolio | Criadores | Galeria + Contato |
| Ecommerce | Vendas | Carrinho + Checkout |
| Blog | Conteúdo | CMS + SEO |

## Pro Tips

1. **CMS Strategy**: Escolha entre conteúdo editorial vs data
2. **Design System**: Componentes reutilizáveis desde o início
3. **Performance**: Otimize imagens com Next.js Image
4. **SEO**: Meta tags dinâmicas por página
5. **Analytics**: Integre Vercel Analytics + Hotjar

---

**Versão**: 1.0 | **Stack**: Framer + Sanity + Next.js + Vercel | **Licença**: MIT
