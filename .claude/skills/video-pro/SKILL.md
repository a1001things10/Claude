# Video Pro

**Skill para criar vídeos profissionais em escala com IA**

Gera vídeos, animações, intros e conteúdo com FFmpeg, Remotion e ElevenLabs.

## Quando Usar

Use **Video Pro** quando:
- Quer criar vídeos promo
- Precisa de animações programáticas
- Quer narração com IA
- Criar conteúdo social media
- Vídeo marketing em massa
- Tutoriais automatizados

## Stack

- **Remotion**: Vídeo como React code
- **FFmpeg**: Edição de vídeo poderosa
- **ElevenLabs**: Narração IA natural
- **HyperFrames**: Geração programática
- **Lottie**: Animações vetoriais
- **Ffmpeg.wasm**: Client-side processing

## Quick Start

```bash
# 1. Criar vídeo com Remotion
npm run create-video --template "promo"

# 2. Adicionar narração
/video add-voiceover --text "Seu script"

# 3. Renderizar
npm run render

# Vídeo pronto em 2 minutos!
```

## Casos de Uso

### Vídeo Promo (10 min)
```
Script + Imagens
↓
Remotion + ElevenLabs
↓
Video MP4 profissional
```

### Tutorial Automático (15 min)
```
Código + Documentação
↓
HyperFrames render
↓
Vídeo passo-a-passo
```

### Social Media Assets (5 min)
```
Criativo base
↓
FFmpeg + Remotion
↓
TikTok + Instagram ready
```

### Conteúdo em Massa (20 min)
```
Template + dados CSV
↓
Batch processing
↓
100 vídeos prontos
```

## Pricing

- **Remotion**: Free + Pro ($200/mês)
- **FFmpeg**: Grátis (open source)
- **ElevenLabs**: Free tier + pago
- **HyperFrames**: Integrado
- **Lottie**: Grátis

## Features

✅ Renderização 4K  
✅ Animações React  
✅ Narração IA (50+ vozes)  
✅ Efeitos automáticos  
✅ Múltiplos formatos  
✅ Transições suaves  
✅ Sync de áudio  
✅ Batch processing  

## Integration

```typescript
import { createVideo } from '@video-pro/sdk'

const video = await createVideo({
  template: 'promo',
  duration: 30,
  voiceover: { text: '...', voice: 'en-US' },
  effects: ['fade', 'zoom'],
  output: 'mp4',
  quality: '4k'
})
```

## Formatos Suportados

| Formato | Uso | Codec |
|---------|-----|-------|
| MP4 | Web/Social | H.264 |
| WebM | Web moderno | VP9 |
| MOV | Apple | ProRes |
| GIF | Rápido | GIF |
| WebP | Animado | WebP |

## Pro Tips

1. **Narração**: Escolha vozes que combinam com brand
2. **Música**: Use royalty-free (Unsplash Music)
3. **Ritmo**: Sync com beat de áudio
4. **Cores**: Mantenha consistência brand
5. **Subtítulos**: Sempre adicione para acessibilidade

---

**Versão**: 1.0 | **Stack**: Remotion + FFmpeg + ElevenLabs | **Licença**: MIT
