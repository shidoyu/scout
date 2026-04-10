🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 **Português** · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **Nota:** Esta tradução é apenas para conveniência. O [original em inglês](../README.md) é a versão oficial.

# scout

**Wrong search, wrong decision.**

> Primeiro pensar, depois pesquisar. — Plugin de pesquisa web para Claude Code.

Design de consultas, busca multi-motor, obtenção com privacidade.

O WebSearch embutido do Claude Code retorna apenas trechos de 125 caracteres e depende somente de correspondência por palavras-chave. O scout transforma uma pergunta vaga em consultas otimizadas para múltiplos mecanismos, avalia a qualidade dos resultados e pesquisa novamente quando necessário, chegando a fontes primárias com mais rapidez e confiabilidade.

## Funcionalidades

- **scout:search** — Busca na web com múltiplos motores e otimização do design de consultas
- **scout:fetch** — Obtenção de conteúdo de URLs com seleção de ferramentas sensível à privacidade

## Instalação

Execute no seu terminal:

```bash
# Passo 1: Registrar o marketplace
claude plugin marketplace add shidoyu/scout
```

```bash
# Passo 2: Instalar o plugin
claude plugin install scout@shidoyu-scout
```

**Passo 3** — Configurar motores de busca e ferramentas de obtenção

Execute estes comandos um de cada vez no Claude Code:

```text
/reload-plugins
```

```text
/scout:setup
```

scout:setup orienta você interativamente na configuração do Context7 (documentação de bibliotecas), Jina Reader (obtenção de páginas web), Exa (busca semântica) e Playwright (páginas renderizadas com JavaScript). Todas as etapas são opcionais e podem ser puladas.

> **Nota:** Se você pular esta etapa, o scout solicitará a configuração no próximo início de sessão. A busca básica funciona imediatamente sem configuração.

## Início Rápido

Após instalar, pergunte ao Claude (sem necessidade de configuração — a busca básica funciona imediatamente):

### Experimente agora

**Encontrar conceitos que você ainda não sabe nomear:**
> "Aquele conceito em programação onde você transforma uma função que recebe vários argumentos em uma cadeia de funções que recebem um argumento de cada vez"

**Descobrir equivalentes internacionais de conceitos brasileiros:**
> "Existe um equivalente em inglês pro 'jeitinho brasileiro' na programação — aquele improviso criativo pra contornar uma limitação técnica que não deveria existir?"

**Obter respostas de especialista a partir de perguntas simples:**
> "Minha aplicação Node.js funciona normal no meu Mac mas no servidor Linux dá erro de 'file not found' em arquivos que existem — os nomes estão certos"

**Ler uma página específica:**
> "Leia https://nodejs.org/en/docs/guides/event-loop-timers-and-nexttick e me explique a diferença entre setImmediate e process.nextTick"

## Skills

### scout:search

Busca na web inteligente com:
- Pré-pesquisa para refinamento de consultas
- Design de consultas em múltiplos idiomas
- Múltiplos motores de busca (WebSearch, [Context7](https://github.com/upstash/context7) documentação oficial, busca semântica [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) para consultas conceituais via Exa
- Avaliação de qualidade com loop automático de nova busca

Uso: `/scout:search sua pergunta aqui`

### scout:fetch

Obtém conteúdo de páginas web com classificação automática de privacidade:
- **Páginas públicas** → Jina Reader / WebFetch (fallback integrado)
- **Páginas confidenciais** → Playwright local (sem chamadas a APIs externas)
- **Páginas autenticadas** → Chrome DevTools (sessão do navegador)

Uso: `/scout:fetch URL`

### scout:setup

Configuração interativa guiada para motores de busca e ferramentas de obtenção:
- **Context7** — Caminho direto para a documentação oficial e atual de bibliotecas e frameworks, fazendo perguntas técnicas chegarem mais rápido aos docs de origem via [Context7 MCP](https://github.com/upstash/context7) (sem API key)
- **Jina Reader** — Captura de páginas web em Markdown mais limpa, removendo navegação e boilerplate, o que muitas vezes reduz o texto enviado ao modelo e economiza tokens ([API key gratuita](https://jina.ai/?newKey))
- **Exa** — Busca por significado para consultas vagas, conceituais e de nicho quando os termos exatos ainda não estão claros ([API key](https://exa.ai))
- **Playwright** — Captura local em navegador para páginas renderizadas com JavaScript ou páginas confidenciais que devem permanecer na sua máquina (~200MB de download)

Todas as etapas são opcionais. Execute novamente a qualquer momento para atualizar as configurações.

Uso: `/scout:setup`

## Privacidade

O scout classifica as URLs em três níveis antes de obter o conteúdo:
- **Pública** → APIs em nuvem (Jina Reader / WebFetch)
- **Confidencial** → Somente Playwright local (roteamento intencional: URLs confidenciais não são enviadas a APIs externas)
- **Autenticada** → Chrome DevTools (usa sua sessão do navegador)

Esta classificação é automática, mas baseada no julgamento do LLM, não em imposição do sistema. Consulte o [Aviso de Privacidade](#aviso-de-privacidade) para mais detalhes.

## Requisitos

- Claude Code
- `jq` (somente para configuração)
- `npm`/`npx` (para o servidor [MCP](https://modelcontextprotocol.io/): chrome-devtools)
- Python 3.10+ (opcional, para obtenção local via Playwright)
- `uvx` ou `uv` (opcional, para o servidor MCP: markitdown — conversão HTML→Markdown)
- Chrome (opcional, para obtenção de páginas autenticadas via DevTools)

### Configuração do Chrome DevTools (para páginas autenticadas)

Para obter páginas que exigem login (OAuth, dashboards SaaS), o Chrome deve estar em execução no modo de depuração:

No macOS:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

No Linux:

```bash
google-chrome --remote-debugging-port=9222
```

## Aviso de Privacidade

O scout classifica as URLs por sensibilidade e roteia URLs confidenciais para ferramentas exclusivamente locais.
Esta classificação é baseada no julgamento do LLM (padrões de domínio e contexto) e **não é uma garantia imposta pelo sistema**.
Para dados altamente sensíveis, verifique a classificação antes de prosseguir.

**Perfil do Navegador.** O fetcher baseado em Playwright (`fetch-page.py`) utiliza um perfil de navegador persistente (`tools/.chrome-profile/`) que pode acumular cookies, dados de sessão e histórico de navegação. Este diretório é excluído do Git via `.gitignore`, mas pode ser copiado por ferramentas de backup ou serviços de sincronização em nuvem. Exclua o diretório periodicamente se você obtiver páginas confidenciais.

## Idioma

As instruções de configuração são fornecidas no seu idioma pelo assistente de IA.
As instruções traduzidas são apenas para conveniência — **o original em inglês é autoritativo**.

## Nota de Segurança

Após a configuração, as chaves de API são armazenadas em `.mcp.json`.
**Não faça commit de `.mcp.json` no Git.** Use `.mcp.json.dist` como template para distribuição.

## Isenção de Responsabilidade

Este plugin é fornecido "no estado em que se encontra" sob a Licença MIT, sem garantia de qualquer tipo.

**APIs Externas.** Este plugin depende de APIs de terceiros (Exa, Jina AI e outras). O autor não oferece garantias sobre a disponibilidade, precisão, preços ou continuidade desses serviços e não se responsabiliza por custos incorridos através do uso de APIs.

**Gerenciamento de Chaves de API.** Você é o único responsável por obter, proteger e gerenciar suas próprias chaves de API, bem como por cumprir os termos de serviço de cada provedor.

**Classificação de Conteúdo.** Ao obter conteúdo da web, o plugin pode usar classificação baseada em LLM para avaliar a sensibilidade de privacidade e determinar os métodos de recuperação apropriados. Tais classificações são feitas com base em melhor esforço e podem conter erros. Não confie na classificação automatizada como única salvaguarda para informações sensíveis ou confidenciais.

**Obtenção de Conteúdo Web e Automação de Navegador.** Este plugin inclui ferramentas para automação de navegador headless via Playwright e Chrome DevTools. Você é responsável por garantir que seu uso esteja em conformidade com os termos de serviço dos sites de destino, políticas de robots.txt e leis aplicáveis. O autor não se responsabiliza por bloqueios de sites, suspensão de contas, restrições de IP, execução inesperada de scripts, consumo de recursos ou problemas de compatibilidade resultantes da automação do navegador.

**Servidores MCP.** Este plugin se conecta a servidores MCP (Model Context Protocol) de terceiros. O autor não controla, audita nem garante o comportamento ou a segurança desses servidores.

## Atribuições de Terceiros

Este plugin integra-se às seguintes ferramentas e serviços externos. Nenhum código-fonte de terceiros é redistribuído — a integração ocorre via conexões de servidores MCP, instalação de pacotes em tempo de execução e scripts wrapper criados pelo desenvolvedor do plugin.

| Ferramenta | Provedor | Licença |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietária (termos de API) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Todos os nomes de produtos, logotipos e marcas registradas são propriedade de seus respectivos donos. Este plugin não tem afiliação nem é endossado por nenhum dos serviços de terceiros listados acima.

## Suporte

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Relatórios de bugs, solicitações de funcionalidades e perguntas

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licença

[MIT License](../LICENSE) — livre para usar, modificar e distribuir. Copyright (c) 2026 shidoyu.

