# Domínio

> **Nota:** não foi possível verificar disponibilidade — o ambiente de pesquisa tem egress
> bloqueado para registradores e serviços de WHOIS. **Toda disponibilidade abaixo é
> hipótese e precisa ser checada por você.**

---

## O que o domínio precisa suportar

Antes de escolher, saiba o que a arquitetura exige dele:

1. **Wildcard TLS** em `*.dominio` — subdomínio por artefato é requisito de segurança (C6),
   não estética
2. **Domínio custom de clientes** apontando por CNAME
3. **Validação por DNS-01** — a validação por HTTP quebra atrás de proxy da Cloudflare
4. Preferencialmente **DNS na Cloudflare**, que já é a escolha de CDN e R2

Um domínio que não permite wildcard ou tem DNS ruim custa retrabalho na Etapa 0.

---

## Realidade sobre `.ai`

`brain.ai` quase certamente está registrado — é uma palavra comum de duas sílabas no TLD
mais disputado do momento. Se estiver à venda, espere **cinco a seis dígitos em dólar**.

Domínios `.ai` também são caros na renovação: tipicamente **US$ 70 a 150 por dois anos**,
contra US$ 10 a 15 de um `.com`. E são registrados em Anguilla, com regras próprias.

**Recomendação honesta:** não trave o projeto esperando `brain.ai`. O nome do produto pode
ser Brain.AI sem que o domínio seja exatamente isso — é o que a maioria das empresas faz.

---

## Candidatos

### Faixa 1 — prefixo ou sufixo em `.ai`

| Domínio | Nota |
|---|---|
| `usebrain.ai` | Padrão consagrado (useX). Provável disponibilidade |
| `trybrain.ai` | Mesma lógica |
| `brainhq.ai` | |
| `getbrain.ai` | |
| `brainlabs.ai` | Pode conflitar com agência existente de mesmo nome |

### Faixa 2 — `.com` composto

| Domínio | Nota |
|---|---|
| `brainai.com` | Provavelmente registrado |
| `usebrainai.com` | |
| `brainplatform.com` | |
| `brain.build` | TLD alinhado ao produto — construir coisas |
| `brain.dev` | HTTPS obrigatório por padrão, bom sinal técnico |

### Faixa 3 — Brasil

| Domínio | Nota |
|---|---|
| `brain.com.br` | Provavelmente registrado |
| `brainai.com.br` | Barato (~R$ 40/ano no registro.br) |
| `usebrain.com.br` | |

**Considere seriamente a faixa 3.** O mercado-alvo é brasileiro, o diferencial é Pix, e
`.com.br` transmite confiança local — que é exatamente o atributo em que o concorrente
está fraco.

---

## Estratégia recomendada

1. **Registre agora o `.com.br` e um `.ai` de prefixo** — custo somado abaixo de US$ 150/ano
2. **Aponte ambos para a Cloudflare** e configure DNS lá desde o dia um
3. **Escolha um como canônico** e redirecione o outro com 301
4. **Reserve um subdomínio dedicado para artefatos** — `*.app.seudominio` em vez de
   `*.seudominio`. Isola o namespace dos clientes do site institucional e simplifica o
   wildcard
5. **Registre também o handle nas redes** antes de anunciar

---

## Checklist de registro

- [ ] Verificar disponibilidade em pelo menos dois registradores
- [ ] Verificar marca registrada no INPI para "Brain" na classe de software
- [ ] Registrar `.com.br` no registro.br
- [ ] Registrar `.ai` (Namecheap, Porkbun ou Cloudflare Registrar quando suportado)
- [ ] Ativar **auto-renovação** — perder o domínio depois de clientes publicarem é catastrófico
- [ ] Ativar bloqueio de transferência
- [ ] Migrar DNS para Cloudflare
- [ ] Criar zona `*.app.seudominio`
- [ ] Emitir certificado wildcard por DNS-01
- [ ] Testar CNAME de domínio custom de terceiro antes da Etapa 0 terminar

---

## Aviso sobre marca

**Brain** é uma palavra comum e existem empresas com esse nome em software. Antes de
investir em identidade visual e material, faça uma busca no INPI e considere consulta a
um advogado de propriedade intelectual. Descobrir conflito depois de ter clientes é caro.
