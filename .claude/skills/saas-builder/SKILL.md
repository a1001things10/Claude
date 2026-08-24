# SaaS Builder

**Skill para construir SaaS em 24 horas com Next.js + Supabase + Vercel**

Automatiza toda a pipeline de criação: setup inicial, scaffolding, banco de dados, autenticação, deploy.

## Quando Usar

Use **SaaS Builder** quando:
- Quer criar um novo SaaS do zero rapidamente
- Precisa de boilerplate production-ready
- Quer autenticação automática configurada
- Precisa de database relacional com segurança
- Quer deploy automático no Vercel

## Stack

- **Frontend**: Next.js 14 + React + Tailwind CSS v4 + shadcn/ui
- **Backend**: Supabase PostgreSQL + Edge Functions
- **Deploy**: Vercel (frontend) + Supabase (backend)
- **Auth**: Supabase Auth (Magic Links, OAuth, 2FA)
- **Database**: PostgreSQL com Row-Level Security
- **Type Safety**: TypeScript + Supabase types

## Features Pré-Configuradas

✅ Autenticação completa (signup/login/logout)  
✅ Database schema exemplo  
✅ API routes com edge functions  
✅ Middleware de autenticação  
✅ Componentes UI prontos (shadcn/ui)  
✅ Environment variables automatizadas  
✅ Deploy one-click  
✅ Type-safe database queries  
✅ Rate limiting + DDoS protection  
✅ Email verification  

## Quick Start

```bash
# 1. Criar projeto
npx create-next-app@latest meu-saas --typescript --tailwind

# 2. Instalar Supabase
npm install @supabase/supabase-js @supabase/auth-helpers-nextjs

# 3. Configurar .env.local
NEXT_PUBLIC_SUPABASE_URL=sua-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=sua-chave

# 4. Setup database
npx supabase db pull

# 5. Deploy
git push origin main  # Auto-deploy no Vercel
```

## Estrutura de Projeto

```
meu-saas/
├── app/
│   ├── (auth)/
│   │   ├── login/
│   │   ├── signup/
│   │   └── forgot-password/
│   ├── (dashboard)/
│   │   ├── page.tsx
│   │   ├── settings/
│   │   └── [resource]/
│   └── api/
│       └── auth/
├── components/
│   ├── ui/          # shadcn/ui components
│   └── dashboard/   # Custom components
├── lib/
│   ├── supabase.ts
│   ├── auth.ts
│   └── types.ts
├── database/
│   └── schema.sql
└── public/
```

## Componentes Essenciais

### 1. Auth Handler
```typescript
// lib/auth.ts
import { createClient } from '@supabase/supabase-js'

export const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
)
```

### 2. Protected Page
```typescript
// app/(dashboard)/layout.tsx
import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase'

export default async function DashboardLayout({ children }) {
  const supabase = createClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  if (!user) redirect('/login')
  
  return <>{children}</>
}
```

### 3. Database Query
```typescript
// lib/db.ts
export async function getUser(userId: string) {
  const { data, error } = await supabase
    .from('users')
    .select()
    .eq('id', userId)
    .single()
  
  return data
}
```

## Pricing Strategy

Usar **Supabase + Vercel freemium**:
- Free tier suporta ~100k requests/mês
- Scale to $25-50/mês conforme crescimento
- Enterprise-ready quando precisar

## Monetização

Adicionar Stripe:
```bash
npm install @stripe/stripe-js stripe
```

## Checklist de Launch

- [ ] Autenticação funcionando
- [ ] Database com dados fake
- [ ] UI responsiva (mobile-first)
- [ ] Testes (Playwright)
- [ ] Environment variables seguros
- [ ] Error logging (Sentry)
- [ ] Analytics (Vercel Analytics)
- [ ] Backup automático (Supabase)
- [ ] SSL/TLS automático
- [ ] CI/CD automático (GitHub Actions)

## Tempo de Setup

- Projeto novo: **5 minutos**
- Database schema: **10 minutos**
- Autenticação: **5 minutos**
- UI componentes: **30 minutos**
- Deploy: **2 minutos**

**Total: ~1 hora para um SaaS production-ready**

## Próximos Passos

1. `/saas-builder init` → Setup automático
2. `/hyperframes` → Criar landing page com vídeo
3. `/stripe-setup` → Adicionar pagamentos
4. `/monitor-analytics` → Track usuários

---

**Versão**: 1.0  
**Stack**: Next.js 14 + Supabase + Vercel  
**Licença**: MIT
