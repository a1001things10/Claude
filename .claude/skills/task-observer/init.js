#!/usr/bin/env node

/**
 * Task Observer - Initialization Script
 * Cria estrutura de logging automática na primeira execução
 */

const fs = require('fs');
const path = require('path');

const WORKSPACE = process.cwd();
const OBSERVER_DIR = path.join(WORKSPACE, 'skill-observations');
const ARCHIVE_DIR = path.join(OBSERVER_DIR, 'archive');
const LOG_FILE = path.join(OBSERVER_DIR, 'log.md');
const CURRENT_FILE = path.join(OBSERVER_DIR, 'current.md');
const PATTERNS_FILE = path.join(OBSERVER_DIR, 'patterns.json');

/**
 * Cria estrutura de diretórios necessários
 */
function initializeDirectories() {
  try {
    // Criar skill-observations/
    if (!fs.existsSync(OBSERVER_DIR)) {
      fs.mkdirSync(OBSERVER_DIR, { recursive: true });
      console.log('✅ Criado: skill-observations/');
    }

    // Criar skill-observations/archive/
    if (!fs.existsSync(ARCHIVE_DIR)) {
      fs.mkdirSync(ARCHIVE_DIR, { recursive: true });
      console.log('✅ Criado: skill-observations/archive/');
    }

    return true;
  } catch (error) {
    console.error('❌ Erro ao criar diretórios:', error.message);
    return false;
  }
}

/**
 * Cria arquivo de log principal se não existir
 */
function initializeLogFile() {
  if (!fs.existsSync(LOG_FILE)) {
    const header = `# Task Observer - Log de Observações

Data de Criação: ${new Date().toISOString()}

## Observações Registradas

`;
    fs.writeFileSync(LOG_FILE, header, 'utf8');
    console.log('✅ Criado: skill-observations/log.md');
  }
}

/**
 * Cria arquivo de padrões (cache JSON)
 */
function initializePatternsFile() {
  if (!fs.existsSync(PATTERNS_FILE)) {
    const patterns = {
      detected: [],
      lastReview: new Date().toISOString(),
      version: '1.0',
    };
    fs.writeFileSync(PATTERNS_FILE, JSON.stringify(patterns, null, 2), 'utf8');
    console.log('✅ Criado: skill-observations/patterns.json');
  }
}

/**
 * Cria arquivo de observações da sessão atual
 */
function initializeCurrentSession() {
  const today = new Date().toISOString().split('T')[0];
  if (!fs.existsSync(CURRENT_FILE)) {
    const content = `# Observações - Sessão ${today}

Data: ${new Date().toISOString()}
Status: Em Andamento

## Padrões Detectados Hoje

`;
    fs.writeFileSync(CURRENT_FILE, content, 'utf8');
    console.log('✅ Criado: skill-observations/current.md');
  }
}

/**
 * Função para registrar uma observação
 */
function recordObservation(observation) {
  const {
    problema,
    skillSugerida,
    funcionalidades = [],
    principio = '',
    exemplo = '',
    status = 'Open',
  } = observation;

  const timestamp = new Date().toISOString();
  const observationEntry = `
## [${timestamp}] Observação - ${skillSugerida}

**Problema**: ${problema}

**Skill Sugerida**: ${skillSugerida}

**Funcionalidades**:
${funcionalidades.map((f) => `- ${f}`).join('\n') || '- (a definir)'}

**Princípio**: ${principio || '(a ser refinado)'}

**Exemplo**:
\`\`\`
${exemplo || '(código/workflow aqui)'}
\`\`\`

**Status**: ${status}

---
`;

  // Append ao log principal
  fs.appendFileSync(LOG_FILE, observationEntry, 'utf8');

  // Também append ao current.md
  fs.appendFileSync(CURRENT_FILE, `### ${skillSugerida}\n- Problema: ${problema}\n- Status: ${status}\n`, 'utf8');

  console.log(`📝 Observação registrada: ${skillSugerida}`);
  return { timestamp, skillSugerida, status };
}

/**
 * Lista observações abertas
 */
function listOpenObservations() {
  if (!fs.existsSync(LOG_FILE)) return [];

  const content = fs.readFileSync(LOG_FILE, 'utf8');
  const openPattern = /Status.*Open/g;
  const matches = content.match(openPattern) || [];

  return {
    total: matches.length,
    observations: matches,
  };
}

/**
 * Revisão semanal
 */
function weeklyReview() {
  const open = listOpenObservations();
  const timestamp = new Date().toISOString();

  const reviewFile = path.join(ARCHIVE_DIR, `review-${timestamp.split('T')[0]}.md`);
  const content = `# Weekly Review - ${timestamp}

## Resumo

- **Observações Abertas**: ${open.total}
- **Data da Revisão**: ${timestamp}

## Observações Prontas para Implementação

${open.observations.map((_, i) => `${i + 1}. Revisar observação #${i + 1}`).join('\n')}

## Recomendações

- [ ] Converter observações em skills (se skill-creator disponível)
- [ ] Arquivar observações implementadas
- [ ] Identificar padrões cross-cutting
- [ ] Propagar princípios entre skills existentes

---
`;

  fs.writeFileSync(reviewFile, content, 'utf8');
  console.log(`📊 Weekly review criado: ${reviewFile}`);

  return {
    reviewDate: timestamp,
    openCount: open.total,
    reviewFile,
  };
}

/**
 * Main - Inicializar Task Observer
 */
function main() {
  console.log('🔍 Inicializando Task Observer...\n');

  const initialized = initializeDirectories() && true;

  if (initialized) {
    initializeLogFile();
    initializePatternsFile();
    initializeCurrentSession();

    console.log('\n✅ Task Observer inicializado com sucesso!');
    console.log(`📁 Diretório: ${OBSERVER_DIR}`);
    console.log('\n💡 Dica: Execute `task-observer record` para registrar observações');

    return true;
  }

  console.error('\n❌ Falha ao inicializar Task Observer');
  return false;
}

/**
 * Exports para uso como módulo
 */
if (require.main === module) {
  const args = process.argv.slice(2);
  const command = args[0];

  switch (command) {
    case 'record':
      // Exemplo: node init.js record "Problema" "skill-name" "func1,func2"
      recordObservation({
        problema: args[1] || 'Exemplo de problema',
        skillSugerida: args[2] || 'exemplo-skill',
        funcionalidades: (args[3] || 'func1,func2').split(','),
        status: 'Open',
      });
      break;

    case 'review':
      weeklyReview();
      break;

    case 'list':
      console.log(listOpenObservations());
      break;

    default:
      main();
  }
}

module.exports = {
  recordObservation,
  listOpenObservations,
  weeklyReview,
  initializeDirectories,
};
