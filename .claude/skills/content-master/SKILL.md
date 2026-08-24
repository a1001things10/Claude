# Content Master

**Skill para criar conteúdo multimodal em escala: vídeos, ebooks, apresentações, social media**

Automatiza pipeline completa de produção de conteúdo com HyperFrames, Canva, Gamma e integração social.

## Quando Usar

Use **Content Master** quando:
- Quer criar vídeos programaticamente
- Precisa gerar ebooks/PDFs
- Quer automatizar social media
- Criar presentations profissionais
- Produzir conteúdo em larga escala

## Stack

- **Vídeo**: HyperFrames + hyperframes-media
- **Design**: Canva + Figma
- **Apresentações**: Gamma
- **Social**: Metricool
- **Transcrições**: Whisper (via hyperframes-media)
- **Voiceover**: Kokoro TTS (via hyperframes-media)

## Casos de Uso

### 1. Video Production
```bash
# Gerar vídeo com narração
/hyperframes compose
# ↓ HyperFrames cria composição HTML
# ↓ hyperframes-media adiciona TTS
# ↓ hyperframes render gera MP4
```

### 2. Ebook Generation
```bash
# Criar ebook de 50 páginas automaticamente
npx content-master ebook "Topic" --pages 50 --images
# ↓ Gera conteúdo
# ↓ Canva cria capas
# ↓ Export para PDF
```

### 3. Social Media Automation
```bash
# Schedule 30 posts para o mês
npx content-master social --count 30 --schedule
# ↓ Gera criativos com Canva
# ↓ Redacta captions com Claude
# ↓ Schedule no Metricool
```

### 4. Presentation Deck
```bash
# Criar deck de 20 slides
/gamma generate-from-content "Topics"
# ↓ Gamma cria slides profissionais
# ↓ Export para PDF/PPTX
```

## Features Pré-Built

✅ Template library (100+ designs)  
✅ TTS com 50+ vozes (Kokoro)  
✅ Transcription automática (Whisper)  
✅ Background removal (u2net)  
✅ Social scheduling  
✅ Analytics tracking  
✅ Brand kit management  
✅ Batch processing  
✅ Watermark automático  
✅ Multi-language support  

## Quick Start

```bash
# 1. Criar vídeo simples
/hyperframes init --template social-promo
/hyperframes preview
/hyperframes render  # → MP4

# 2. Adicionar voiceover
npx hyperframes media tts "Script aqui" --voice en-US-Neural2-A
npx hyperframes media transcribe video.mp4

# 3. Criar design de capa
/canva generate --template "Social Media"

# 4. Publicar automático
npx metricool schedule --posts 5 --frequency weekly
```

## Workflow Completo: Vídeo + Landing Page

```
1. Escrever script
   ↓
2. /hyperframes compose (cria vídeo HTML)
   ↓
3. hyperframes-media tts (adiciona narração)
   ↓
4. hyperframes render (gera MP4)
   ↓
5. /canva generate (cria thumbnail + cover)
   ↓
6. /hyperframes website-to-hyperframes (faz página interativa)
   ↓
7. Vercel deploy
   ↓
8. Share + Analytics
```

## Templates Disponíveis

**Vídeo:**
- Social promo (15-30s)
- Product demo (2-3 min)
- Tutorial (5-15 min)
- Explainer (60s)
- Teaser/Trailer (30s)

**Design:**
- Social media covers
- E-book covers
- YouTube thumbnails
- LinkedIn posts
- Instagram stories

**Apresentação:**
- Pitch deck
- Product overview
- Company culture
- Educational content
- Case study

## Pricing (Tudo Gratuito!)

- **HyperFrames**: Open source
- **Canva**: Free tier (1000+ templates)
- **Gamma**: Free (up to 10 creations/mês)
- **Metricool**: Free tier (1 account)
- **Kokoro TTS**: Free (via hyperframes-media)
- **Whisper**: Free (open source)

## Performance Metrics

Espere processar:
- **Vídeo 1 min**: ~30s rendering
- **Ebook 50 pgs**: ~2 min generation
- **30 posts sociais**: ~5 min batch

Com GPU (opcional): 10x mais rápido

## Integração com SaaS

```typescript
// Gerar vídeo dentro da sua SaaS
import { createVideo } from '@content-master/sdk'

const video = await createVideo({
  title: 'Meu vídeo',
  voiceover: true,
  background: 'gradient',
  duration: 30
})

// Retorna URL do MP4 pronto para download
```

## Checklist de Produção

- [ ] Scripts prontos
- [ ] Brand guidelines (Canva brand kit)
- [ ] Voiceover settings
- [ ] Social media templates
- [ ] Scheduling calendar
- [ ] Analytics dashboard
- [ ] Backup automático
- [ ] Version control (Git)

## Próximos Passos

1. `/content-master init` → Setup automático
2. `/hyperframes` → Criar primeiro vídeo
3. `/canva` → Designs automáticos
4. `/metricool` → Social scheduling

## Pro Tips

1. **Batch creation**: Criar 50 posts de uma vez é mais eficiente
2. **Templates**: Use templates para consistência visual
3. **Brand kit**: Configure Canva brand kit uma vez, reutilize forever
4. **Scheduling**: Schedule conteúdo com dias de antecedência
5. **Analytics**: Rastreie quais conteúdos performam melhor

---

**Versão**: 1.0  
**Stack**: HyperFrames + Canva + Gamma + Metricool  
**Licença**: MIT  
**Atualizado**: 2026-08-24
