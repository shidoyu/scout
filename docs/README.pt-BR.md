🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 **Português** · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **Nota:** Esta tradução é apenas para conveniência. O [original em inglês](../README.md) é a versão oficial.

# scout — Busca na Web e Obtenção de Conteúdo

O WebSearch integrado ao Claude Code retorna trechos de 125 caracteres e depende apenas de correspondência por palavras-chave. O scout transforma uma pergunta vaga em consultas otimizadas para múltiplos motores de busca, avalia a qualidade dos resultados e realiza novas buscas quando necessário — alcançando fontes primárias com mais rapidez e confiabilidade.

## Funcionalidades

- **scout:search** — Busca na web com múltiplos motores e otimização do design de consultas
- **scout:fetch** — Obtenção de conteúdo de URLs com seleção de ferramentas sensível à privacidade

## Instalação

Execute no seu terminal:

```bash
claude plugin add shidoyu/scout
```

## Início Rápido

O scout funciona imediatamente após a instalação — a busca utiliza WebSearch (integrado) e Exa (gratuito, sem necessidade de chave). A configuração opcional adiciona mais capacidades:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Busca na web inteligente com:
- Pré-pesquisa para refinamento de consultas
- Design de consultas em múltiplos idiomas
- Múltiplos motores de busca (WebSearch, busca semântica [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) para consultas conceituais via Exa
- Avaliação de qualidade com loop automático de nova busca

Uso: `/scout:search sua pergunta aqui`

### scout:fetch

Obtém conteúdo de páginas web com classificação automática de privacidade:
- **Páginas públicas** → Jina Reader (chave de API necessária) / WebFetch (fallback integrado)
- **Páginas confidenciais** → Playwright local (sem chamadas a APIs externas)
- **Páginas autenticadas** → Chrome DevTools (sessão do navegador)

Uso: `/scout:fetch URL`

## Configuração (Opcional)

Execute `tools/setup.sh` para configurar:

1. **Exa** — Ferramentas de busca avançadas com IA nativa (chave de API para recursos pagos; o nível gratuito funciona sem configuração)
2. **Jina Reader** — Obtenção de páginas web em alta qualidade como Markdown (chave de API necessária; sem ela, páginas públicas usam WebFetch como fallback)
3. **Playwright** — Obtenção baseada em navegador para páginas renderizadas com JavaScript e páginas confidenciais (~200MB de download)

Todas as etapas podem ser puladas. Execute novamente a qualquer momento para atualizar as configurações.
Após a configuração, reinicie o Claude Code (ou execute `/mcp`) para que os novos servidores MCP entrem em vigor.

## Privacidade

O scout classifica as URLs em três níveis antes de obter o conteúdo:
- **Pública** → APIs em nuvem (Jina Reader / WebFetch)
- **Confidencial** → Somente Playwright local (roteamento intencional: URLs confidenciais não são enviadas a APIs externas)
- **Autenticada** → Chrome DevTools (usa sua sessão do navegador)

Esta classificação é automática, mas baseada no julgamento do LLM, não em imposição do sistema. Consulte o [Aviso de Privacidade](#aviso-de-privacidade) para mais detalhes.

## Requisitos

- Claude Code
- `jq` (somente para o script de configuração)
- `npm`/`npx` (para o servidor [MCP](https://modelcontextprotocol.io/): chrome-devtools)
- Python 3.10+ (opcional, para obtenção local via Playwright)
- `uvx` ou `uv` (opcional, para o servidor MCP: markitdown — conversão HTML→Markdown)
- Chrome (opcional, para obtenção de páginas autenticadas via DevTools)

### Configuração do Chrome DevTools (para páginas autenticadas)

Para obter páginas que exigem login (OAuth, dashboards SaaS), o Chrome deve estar em execução no modo de depuração:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
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

Após executar `setup.sh`, as chaves de API são armazenadas em `.mcp.json`.
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

