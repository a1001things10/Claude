# Segurança

Este documento existe porque **as duas maiores plataformas da categoria já falharam de
formas evitáveis e documentadas**. Cada controle abaixo é derivado de um incidente real.

---

## 1. Incidentes de referência

### Base44 — bypass de autenticação (Wiz, julho/2025)

Endpoints de registro e verificação por código **não exigiam autenticação**. Qualquer
pessoa podia se registrar em aplicações privadas sabendo o `app_id` do alvo — que estava
**público na URL e no manifest**. Contornava SSO. Atingiu apps corporativos com dados de
RH e informação pessoal. Corrigido em 24 horas.

**Lição:** numa plataforma multi-tenant onde o identificador do tenant é público por
design, ele nunca pode ser tratado como prova de autorização.

### Lovable — CVE-2025-48757 (controle de acesso ausente)

De **1.645 apps escaneados, 170 tinham bancos expostos** — 10,3%, somando 303 endpoints
vulneráveis com e-mails, chaves de API e dados de pagamento. A chave pública embutida no
cliente permitia consultar o banco direto e baixar tabelas inteiras **sem login**.

**Causa raiz:** políticas de row-level security geradas por LLM, ausentes ou permissivas.

### VibeScamming

Atacantes geram páginas de login imitando marcas conhecidas, publicam em subdomínios
confiáveis da plataforma e colhem credenciais. **A reputação do domínio da plataforma
vira a arma.**

### Tríade letal (prompt injection)

Dados privados + conteúdo não confiável + canal de exfiltração no mesmo agente. O caso
Supabase MCP de 2025: agente com acesso privilegiado ao banco processou instruções
embutidas em tickets de suporte e exfiltrou tokens para thread pública.

---

## 2. Controles obrigatórios

Cada um é um **gate automático**. Falha bloqueia a publicação — não gera aviso.

### C1 · O modelo nunca escreve política de acesso

**A regra fundadora da arquitetura.** Row-level security, autenticação, papéis e permissões
são gerados por código determinístico a partir da especificação validada. O LLM produz
apenas a declaração de intenção (`"apenas o dono vê seus pedidos"`), nunca o SQL.

### C2 · Verificador de acesso pós-migration

Para toda tabela em `public`:
- `rowsecurity = true`
- existe ao menos uma policy
- nenhuma policy é `USING (true)` para o papel anônimo

Falhou? **Publicação bloqueada.**

### C3 · Varredura de segredos no artefato

Antes de qualquer publicação, varrer o build por:
- JWT com `role: service_role`
- Padrões de chave de provedores conhecidos
- Variáveis de ambiente do servidor vazadas para o bundle do cliente

Chave de serviço **nunca** no cliente.

### C4 · Tenant-id não é credencial

Todo endpoint que recebe identificador de artefato ou organização deve verificar
autorização por sessão ou token — nunca pelo identificador em si. Auditoria explícita
de todos os endpoints que aceitam `app_id`, `project_id` ou `org_id`.

Endpoint de auto-registro consulta a política do artefato (público / privado / SSO)
**antes** de emitir qualquer código de verificação. O código não é o controle; a
elegibilidade é.

### C5 · Separação de agentes

**O agente que lê a web não pode ser o mesmo que tem credencial de banco.**

Conteúdo externo — URL buscada, documentação, arquivo enviado — passa por um sumarizador
sem ferramentas, e sua saída é tratada como **dado, nunca como instrução**.

### C6 · Isolamento de origem

Subdomínio por artefato, obrigatório. Rota por caminho compartilha origem — cookies,
localStorage, postMessage — entre tenants diferentes e é falha de segurança.

### C7 · Anti-phishing na publicação

Classificador de similaridade contra marcas conhecidas em qualquer artefato que colete
credenciais e vá para subdomínio da plataforma. Revisão manual antes de publicar quando
houver suspeita.

### C8 · Limites de gasto por tenant

Teto configurável de créditos por período. Protege o cliente contra loop acidental e a
plataforma contra abuso. Aplicado no `cost()`, antes da execução.

---

## 3. Modelo de ameaça resumido

| Ameaça | Vetor | Controle |
|---|---|---|
| Vazamento de dados de app gerado | RLS ausente | C1, C2 |
| Acesso a app privado alheio | tenant-id como credencial | C4 |
| Exfiltração de credencial | chave de serviço no bundle | C3 |
| Phishing com domínio confiável | publicação livre | C7 |
| Injeção de prompt | conteúdo externo no agente | C5 |
| Roubo de sessão entre tenants | origem compartilhada | C6 |
| Abuso de custo | loop de geração | C8 |

---

## 4. Postura

- Gates são **bloqueantes**, não avisos. Um aviso que pode ser ignorado não é controle.
- Todo gate registra no ledger com o motivo, para auditoria.
- Falha de gate **não debita crédito** do usuário — é falha da plataforma.
- Revisão de segurança obrigatória ao adicionar qualquer gerador novo, antes do primeiro
  publish em produção.
