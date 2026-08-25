# DataViz Pro

**Skill para criar visualizações de dados impressionantes com IA**

Gera gráficos, dashboards e relatórios interativos usando D3.js, Plotly, Recharts e Vega-Lite.

## Quando Usar

Use **DataViz Pro** quando:
- Quer criar dashboards interativos
- Precisa visualizar grandes volumes de dados
- Quer gráficos responsivos e animados
- Criar relatórios executivos
- Dashboards em tempo real
- Análise de dados visual

## Stack

- **Recharts**: React components, simples e rápido
- **Plotly**: Gráficos interativos avançados
- **D3.js**: Customização total, máximo poder
- **Vega-Lite**: Declarativo, perfeito para exploração
- **Chart.js**: Gráficos simples, leve
- **Observable Plot**: Análise exploratória

## Quick Start

```bash
# 1. Dados em JSON/CSV
npm run parse-data data.csv

# 2. Gerar visualização
/dataviz generate --chart "bar" --data "sales.json"

# 3. Render interativo
# Dashboard live em 2 minutos!
```

## Casos de Uso

### Dashboard Executivo (10 min)
```
Dados: sales, revenue, churn
↓
DataViz + Recharts
↓
Export PNG + PDF
```

### Análise Exploratória (15 min)
```
Dataset grande
↓
Plotly + Vega-Lite
↓
Descobrir padrões
```

### Relatório Interativo (20 min)
```
Múltiplos gráficos
↓
D3.js customizado
↓
HTML/PDF exportado
```

### Real-time Monitoring (5 min)
```
WebSocket data
↓
Recharts atualização live
↓
Alerts automáticos
```

## Pricing

- **Recharts**: Free (open source)
- **Plotly**: Free + Pro
- **D3.js**: Free (open source)
- **Vega-Lite**: Free (open source)
- **Observable**: Gratuito + Pro ($15/mês)

## Features

✅ Gráficos responsivos  
✅ Tema dark/light  
✅ Animações suaves  
✅ Tooltips customizados  
✅ Exportar PNG/SVG/PDF  
✅ Time-series support  
✅ Geo maps  
✅ 3D Charts  

## Integration

```typescript
import { createChart } from '@dataviz-pro/sdk'

const chart = await createChart({
  type: "bar",
  data: salesData,
  title: "Monthly Sales",
  theme: "dark",
  interactive: true,
  export: ["png", "pdf"]
})
```

## Modelos de Gráficos

| Gráfico | Melhor Para | Biblioteca |
|---------|------------|-----------|
| Bar | Comparações | Recharts |
| Line | Trends | Plotly |
| Scatter | Correlações | D3.js |
| Pie | Proporções | Chart.js |
| Heatmap | Padrões | D3.js |
| Geo | Mapa | Plotly |

## Pro Tips

1. **Cores**: Use paletas acessíveis (ColorBrewer)
2. **Labels**: Sempre inclua contexto
3. **Mobile First**: Responsive é crítico
4. **Performance**: Lazy load para 1000+ pontos
5. **A/B Test**: Compare visualizações

---

**Versão**: 1.0 | **Stack**: Recharts + Plotly + D3.js + Vega-Lite | **Licença**: MIT
