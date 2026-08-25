# Image Pro

**Skill para gerar imagens profissionais em escala com IA**

Cria desde thumbnails até illustrations completas usando Flux, Stable Diffusion e Canva.

## Quando Usar

Use **Image Pro** quando:
- Quer gerar imagens em massa
- Precisa de stock images customizadas
- Quer criar illustrations únicas
- Gerar social media assets
- Criar backgrounds/textures
- Design covers/thumbnails

## Stack

- **Canva MCP**: 1000+ templates (integrada)
- **Flux (Replicate)**: Melhor qualidade ($0.04/img)
- **Stable Diffusion**: Controle avançado
- **Unsplash/Pexels**: Stock images grátis
- **Cloudinary**: Hosting + transformações

## Quick Start

```bash
# 1. Gerar imagem com Canva
/canva generate --template "Social Media"

# 2. Customizar com prompt
"Create a professional tech company hero image"

# 3. Download/uso automático
# Pronto em 30 segundos!
```

## Casos de Uso

### Thumbnails (5 min)
```
Prompt: "YouTube thumbnail: 1280x720, bright colors, tech theme"
↓
Flux gerá em 30s
↓
Download + use
```

### Stock Images Customizadas (3 min)
```
Prompt: "Professional team photo, 4 people, office, diverse"
↓
Canva or Flux
↓
Comercial use OK
```

### Illustrations (10 min)
```
Prompt: "Isometric illustration of SaaS dashboard, bright colors"
↓
Refinamento com AI
↓
Export SVG/PNG
```

### Social Media Pack (15 min)
```
Prompt: "Generate 10 Instagram post backgrounds, minimal, professional"
↓
Batch process
↓
Metricool schedule
```

## Pricing

- **Canva**: Free + Pro ($12.99/mês)
- **Flux via Replicate**: $0.04-0.10 por imagem
- **Stable Diffusion**: Self-hosted (free) + APIs
- **Unsplash**: Completamente grátis

## Features

✅ Prompt engineering avançado  
✅ Batch generation (100+ imagens)  
✅ Style transfer  
✅ Upscaling (2x-4x)  
✅ Background removal  
✅ Color correction  
✅ Commercial license  
✅ Export múltiplos formatos  

## Integration

```typescript
// Usar em SaaS
import { generateImage } from '@image-pro/sdk'

const image = await generateImage({
  prompt: "...",
  model: "flux",
  size: "1024x1024",
  style: "professional"
})

// Retorna URL pronta para download/uso
```

## Pro Tips

1. **Prompt Power**: Use adjectives específicos
2. **Batch First**: Gerar 5 + refinar melhor
3. **Style Consistency**: Use "in the style of..." para uniformidade
4. **License Check**: Sempre verificar commercial rights
5. **Upscale Always**: 2x upscale aumenta qualidade

## Modelos Disponíveis

| Modelo | Qualidade | Velocidade | Custo |
|--------|-----------|-----------|-------|
| Flux | ⭐⭐⭐⭐⭐ | Média | $0.04 |
| SDXL | ⭐⭐⭐⭐ | Rápido | Grátis |
| Stable Diffusion | ⭐⭐⭐ | Muito rápido | Grátis |

---

**Versão**: 1.0 | **Stack**: Canva + Flux + Stable Diffusion | **Licença**: MIT
