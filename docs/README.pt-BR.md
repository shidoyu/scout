🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 **Português** · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Aviso:** Esta tradução é fornecida por conveniência. A [versão original em inglês](../README.md) é a versão oficial.

<p align="center">
  <img src="assets/hero.png" alt="scout — Pense primeiro. Pesquise depois." width="600">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Plugin de pesquisa web para <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Transforma perguntas vagas em consultas multi-motor otimizadas que alcançam as fontes primárias.
</p>

<p align="center">
  <strong>Pense primeiro. Pesquise depois.</strong>
</p>

---

A WebSearch integrada do Claude Code retorna trechos de 125 caracteres e depende exclusivamente de correspondência de palavras-chave. Isso é suficiente para buscas simples — mas para uma pesquisa real, você precisa de design de consultas, avaliação de fontes e roteamento consciente de privacidade.

scout pensa antes de pesquisar.

## Início rápido

Sem chaves de API. Sem alterações de ambiente. Instale e experimente imediatamente:

**1. Adicionar o marketplace** (apenas uma vez):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Instalar**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Recarregar plugins** (digite isso dentro do Claude Code):

```
/mcp
```

Depois pergunte ao Claude:

```text
/scout:search Quero algo como Git blame mas para decisões de design
```

scout vai transformar esse conceito vago no termo correto (ADR — Architecture Decision Records), pesquisar em múltiplos motores com consultas otimizadas, avaliar a qualidade das fontes e retornar uma resposta com um Research Trail mostrando exatamente como chegou ao resultado.

## O que o scout faz

### Encontrar conceitos que você ainda não sabe nomear

> "Eu sei que o conceito existe — algo sobre registrar por que tomamos cada decisão de design — mas não sei o nome"

scout traduz ideias vagas em terminologia precisa e alcança as fontes primárias.

### Atravessar o ruído do SEO

> "Para o que eu deveria realmente migrar saindo do Terraform — não as listas patrocinadas, histórias reais de migração"

A pré-pesquisa adquire o vocabulário adequado, depois consultas direcionadas contornam as fazendas de conteúdo.

### Chegar diretamente na documentação oficial

> "Como configuro middleware no Next.js App Router?"

scout verifica primeiro o [Context7](https://github.com/upstash/context7) em busca de documentação oficial indexada — se a resposta estiver lá, nenhuma pesquisa web é necessária.

### Ler qualquer página web

> "Busque e resuma https://docs.anthropic.com/en/docs/claude-code"

Busca consciente de privacidade: páginas públicas passam por APIs na nuvem, páginas confidenciais ficam na sua máquina.

## Níveis de configuração

scout funciona imediatamente após a instalação. Cada nível adiciona capacidades — todos opcionais, todos reversíveis.

### Nível 1: Pesquisa integrada (padrão)

Usa a WebSearch do Claude Code. Nenhuma configuração necessária. É o que você obtém de imediato.

### Nível 2: Documentação oficial + busca mais limpa

[Context7](https://github.com/upstash/context7) para acesso direto à documentação de bibliotecas/frameworks, e [Jina Reader](https://jina.ai) para uma leitura de páginas mais limpa. Context7 não precisa de chave de API; chave opcional para os limites de taxa do Jina.

### Nível 3: Pesquisa semântica

[Exa](https://exa.ai) para pesquisa baseada em significado — encontra páginas relevantes mesmo quando você não conhece as palavras-chave certas. A pesquisa semântica básica funciona com o nível gratuito; uma chave de API desbloqueia recursos avançados.

### Nível 4: Navegador local

[Playwright](https://playwright.dev) para páginas renderizadas com JavaScript e URLs confidenciais que nunca devem sair da sua máquina. Requer o download do Chromium (~200 MB).

**Execute `/scout:setup` para configurar cada nível de forma interativa.** Cada etapa mostra exatamente o que será adicionado à sua configuração antes de qualquer alteração. Execute novamente a qualquer momento para adicionar ou atualizar ferramentas.

## Skills

| Skill | Finalidade |
|---|---|
| `/scout:search` | Pesquisa web multi-motor com design de consultas, avaliação de fontes e re-pesquisa automática |
| `/scout:fetch` | Busca de conteúdo de URLs com classificação automática de privacidade |
| `/scout:setup` | Configuração interativa guiada para motores de pesquisa e ferramentas de busca |

### Research Trail

Cada pesquisa termina com um registro estruturado mostrando como o scout chegou à sua resposta:

```
🔍 Research Trail
───────────────────────────────
Query:           sua pergunta original
Designed queries: as consultas otimizadas que o scout realmente executou
Sources:         URLs com nível de confiabilidade (🟢 primária / 🟡 secundária / ⚪ terciária)
Re-searches:     pesquisas adicionais e seus motivos
Confidence:      High / Medium / Low com justificativa
```

## Privacidade

scout classifica as URLs em três níveis antes de buscá-las:

| Classificação | Roteamento | Exemplos |
|---|---|---|
| **Público** | APIs na nuvem (Jina Reader / WebFetch) | Blogs, documentação, repos públicos do GitHub |
| **Confidencial** | Apenas Playwright local | localhost, wikis internos, painéis de administração |
| **Autenticado** | Chrome DevTools (sua sessão do navegador) | Notion, Slack, páginas pós-OAuth |

Essa classificação é baseada no julgamento do LLM, não em aplicação técnica. Trate-a como roteamento de melhor esforço. Para dados altamente sensíveis, verifique a classificação antes de prosseguir.

**URLs confidenciais nunca são enviadas para APIs externas, mesmo em caso de falha** — o sistema não recorre a ferramentas na nuvem para páginas confidenciais.

<details>
<summary>Configuração do Chrome DevTools (para páginas autenticadas)</summary>

Para buscar páginas que exigem login (OAuth, painéis SaaS), inicie o Chrome em modo de depuração:

macOS:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

Linux:

```bash
google-chrome --remote-debugging-port=9222
```
</details>

<details>
<summary>Nota sobre o perfil do navegador</summary>

O fetcher baseado em Playwright usa um perfil de navegador persistente (`tools/.chrome-profile/`) que pode acumular cookies e dados de sessão. Esse diretório é excluído do Git via `.gitignore`, mas pode ser copiado por ferramentas de backup. Exclua-o periodicamente se você buscar páginas confidenciais.
</details>

## Desinstalação

Dois comandos para remover tudo. Sem resíduos.

Remover o plugin (limpa cache, configuração e dados de estado):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Remover o Context7 se adicionado via scout:setup (escopo de usuário — removido de todos os projetos):

```bash
claude mcp remove context7
```

## Requisitos

- **Claude Code** (obrigatório)
- `jq` (apenas para diagnósticos de configuração)
- Python 3.10+ (apenas para busca local com Playwright)
- `npm`/`npx` (apenas para o servidor MCP do Chrome DevTools)

## Segurança

As chaves de API são armazenadas em `.mcp.json` dentro do diretório do plugin.
**Não faça commit de `.mcp.json` no Git.** O template `.mcp.json.dist` é seguro para distribuição.

## Isenção de responsabilidade

Este plugin é fornecido "como está" sob a Licença MIT, sem garantia de qualquer tipo.

**APIs externas.** Este plugin depende de APIs de terceiros (Exa, Jina AI e outros). O autor não garante a disponibilidade, precisão, preços ou continuidade desses serviços e não é responsável por custos decorrentes do uso das APIs.

**Gerenciamento de chaves de API.** Você é o único responsável por obter, proteger e gerenciar suas próprias chaves de API, e por cumprir os termos de serviço de cada provedor.

**Classificação de conteúdo.** A classificação de privacidade de URLs é baseada no julgamento do LLM e pode conter erros. Não dependa dela como única salvaguarda para informações sensíveis.

**Busca web e automação de navegador.** Este plugin inclui ferramentas de automação de navegador headless via Playwright e Chrome DevTools. Você é responsável por garantir que seu uso esteja em conformidade com os termos de serviço dos sites alvo, suas políticas de robots.txt e as leis aplicáveis.

**Servidores MCP.** Este plugin se conecta a servidores MCP de terceiros. O autor não controla, audita nem garante o comportamento ou a segurança desses servidores.

## Atribuições de terceiros

Nenhum código-fonte de terceiros é redistribuído — a integração é feita via conexões MCP, instalação de pacotes em tempo de execução e scripts wrapper.

| Ferramenta | Provedor | Licença |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/nichochar/chrome-devtools-mcp) | nichochar | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Todos os nomes de produtos, logos e marcas comerciais são propriedade de seus respectivos titulares.

## Idioma

As instruções de configuração são fornecidas no seu idioma pelo assistente de IA. Os READMEs traduzidos são por conveniência — **a versão original em inglês é a oficial**.

## Suporte

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Relatórios de bugs, solicitações de recursos e perguntas

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licença

[MIT License](../LICENSE) — livre para usar, modificar e distribuir. Copyright (c) 2026 shidoyu.
