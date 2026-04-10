🇯🇵 [日本語](docs/README.ja.md) · 🇰🇷 [한국어](docs/README.ko.md) · 🇨🇳 [简体中文](docs/README.zh-CN.md) · 🇹🇼 [繁體中文](docs/README.zh-TW.md) · 🇮🇳 [हिन्दी](docs/README.hi.md) · 🇩🇪 [Deutsch](docs/README.de.md) · 🇫🇷 [Français](docs/README.fr.md) · 🇪🇸 [Español](docs/README.es.md) · 🇧🇷 [Português](docs/README.pt-BR.md) · 🇮🇹 [Italiano](docs/README.it.md) · 🇳🇱 [Nederlands](docs/README.nl.md) · 🇵🇱 [Polski](docs/README.pl.md) · 🇨🇿 [Čeština](docs/README.cs.md) · 🇺🇦 [Українська](docs/README.uk.md) · 🇷🇺 [Русский](docs/README.ru.md) · 🇸🇪 [Svenska](docs/README.sv.md) · 🇩🇰 [Dansk](docs/README.da.md) · 🇪🇪 [Eesti](docs/README.et.md) · 🇹🇷 [Türkçe](docs/README.tr.md) · 🇸🇦 [العربية](docs/README.ar.md) · 🇮🇱 [עברית](docs/README.he.md) · 🇻🇳 [Tiếng Việt](docs/README.vi.md) · 🇮🇩 [Bahasa Indonesia](docs/README.id.md) · 🇹🇭 [ไทย](docs/README.th.md)

# scout

**Wrong search, wrong decision.**

> Think first. Search second. — Web research plugin for Claude Code.

Query design, multi-engine search, privacy-aware fetching.

---

Claude Code's built-in WebSearch returns 125-character snippets and relies on keyword matching alone. scout turns a vague question into optimized multi-engine queries, evaluates result quality, and re-searches when needed — reaching primary sources faster and more reliably.

## Features

- **scout:search** — Multi-engine web search with query design optimization
- **scout:fetch** — URL content fetching with privacy-aware tool selection

## Install

**Step 1** — Register the marketplace

```bash
claude plugin marketplace add shidoyu/scout
```

**Step 2** — Install the plugin

```bash
claude plugin install scout@shidoyu-scout
```

**Step 3** — Set up search engines and fetching tools

Run these one at a time in Claude Code:

```text
/reload-plugins
```

```text
/scout:setup
```

`scout:setup` walks you through configuring [Context7](https://github.com/upstash/context7) (library docs), [Jina Reader](https://jina.ai) (web page fetching), [Exa](https://exa.ai) (semantic search), and [Playwright](https://playwright.dev) (JavaScript-rendered pages) interactively. Every step is optional and skippable.

> **Note:** If you skip this step, scout will prompt you on the next session start. Basic search works immediately without setup.

## Quick Start

After installing, ask Claude (no setup required — basic search works immediately):

**Find concepts you can't name yet:**
> "I want something like Git blame but for design decisions — I know the concept exists but not what it's called"

**Cut through SEO noise:**
> "What should I actually migrate to from Terraform — not the sponsored lists, real migration stories"

**Get expert answers from plain language:**
> "ENOSPC error but I have plenty of disk space — what's the real fix?"

**Read a specific page:**
> "Fetch and summarize https://docs.anthropic.com/en/docs/claude-code"

## Skills

### scout:search

Intelligent web search with:
- Pre-research for query refinement
- Multi-language query design
- Multiple search engines (WebSearch, [Context7](https://github.com/upstash/context7) official docs, [Exa](https://exa.ai) semantic search)
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) for conceptual queries via Exa
- Quality assessment with automatic re-search loop

Usage: `/scout:search your question here`

### scout:fetch

Fetch web page content with automatic privacy classification:
- **Public pages** → Jina Reader / WebFetch (built-in fallback)
- **Confidential pages** → Local Playwright (no external API calls)
- **Authenticated pages** → Chrome DevTools (browser session)

Usage: `/scout:fetch URL`

### scout:setup

Interactive guided setup for search engines and fetching tools:
- **Context7** — Direct path to current official library and framework docs, so technical questions reach source docs faster ([Context7 MCP](https://github.com/upstash/context7), no API key needed)
- **Jina Reader** — Cleaner web page fetching as Markdown that strips navigation and boilerplate, often reducing the text sent to the model and saving tokens ([free API key](https://jina.ai/?newKey))
- **Exa** — Meaning-based search for vague, conceptual, and niche queries where exact terms are unclear ([API key](https://exa.ai))
- **Playwright** — Local browser fetching for JavaScript-rendered or confidential pages that should stay on your machine (~200MB download)

All steps are optional. Re-run anytime to update settings.

Usage: `/scout:setup`

## Privacy

scout classifies URLs into three levels before fetching:
- **Public** → Cloud APIs (Jina Reader / WebFetch)
- **Confidential** → Local Playwright only (intended routing: confidential URLs are not sent to external APIs)
- **Authenticated** → Chrome DevTools (uses your browser session)

This classification is automatic but based on LLM judgment, not system enforcement. See [Privacy Disclaimer](#privacy-disclaimer) for details.

## Requirements

- Claude Code
- `jq` (for setup only)
- `npm`/`npx` (for [MCP](https://modelcontextprotocol.io/) server: chrome-devtools)
- Python 3.10+ (optional, for Playwright local fetching)
- `uvx` or `uv` (optional, for MCP server: markitdown — HTML→Markdown conversion)
- Chrome (optional, for authenticated page fetching via DevTools)

### Chrome DevTools Setup (for authenticated pages)

To fetch pages that require login (OAuth, SaaS dashboards), Chrome must be running in debug mode:

macOS:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

Linux:

```bash
google-chrome --remote-debugging-port=9222
```

## Privacy Disclaimer

scout classifies URLs by sensitivity and routes confidential URLs to local-only tools.
This classification is based on LLM judgment (domain patterns and context) and is **not a system-enforced guarantee**.
For highly sensitive data, verify the classification before proceeding.

**Browser Profile.** The Playwright-based fetcher (`fetch-page.py`) uses a persistent browser profile (`tools/.chrome-profile/`) that may accumulate cookies, session data, and browsing history. This directory is excluded from Git via `.gitignore` but may be copied by backup tools or cloud sync services. Delete the directory periodically if you fetch confidential pages.

## Language

Setup instructions are provided in your language by the AI assistant.
Translated instructions are for convenience only — **the English original is authoritative**.

## Security Note

After setup, API keys are stored in `.mcp.json`.
**Do not commit `.mcp.json` to Git.** Use `.mcp.json.dist` as the template for distribution.

## Disclaimer

This plugin is provided "as is" under the MIT License, without warranty of any kind.

**External APIs.** This plugin relies on third-party APIs (Exa, Jina AI, and others). The author makes no guarantees about the availability, accuracy, pricing, or continuity of these services and is not responsible for costs incurred through API usage.

**API Key Management.** You are solely responsible for obtaining, securing, and managing your own API keys, and for complying with each provider's terms of service.

**Content Classification.** When fetching web content, the plugin may use LLM-based classification to assess privacy sensitivity and determine appropriate retrieval methods. Such classifications are best-effort and may contain errors. Do not rely on automated classification as the sole safeguard for sensitive or confidential information.

**Web Fetching & Browser Automation.** This plugin includes tools for headless browser automation via Playwright and Chrome DevTools. You are responsible for ensuring your use complies with target websites' terms of service, robots.txt policies, and applicable laws. The author is not liable for site blocking, account suspension, IP restrictions, unexpected script execution, resource consumption, or compatibility issues resulting from browser automation.

**MCP Servers.** This plugin connects to third-party MCP (Model Context Protocol) servers. The author does not control, audit, or guarantee the behavior or security of these servers.

## Third-Party Attributions

This plugin integrates with the following external tools and services. No third-party source code is redistributed — integration is via MCP server connections, runtime package installation, and wrapper scripts authored by the plugin developer.

| Tool | Provider | License |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

All product names, logos, and trademarks are the property of their respective owners. This plugin is not affiliated with or endorsed by any of the third-party services listed above.

## Support

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Bug reports, feature requests, and questions

## Author

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## License

[MIT License](LICENSE) — free to use, modify, and distribute. Copyright (c) 2026 shidoyu.
