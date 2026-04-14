🇯🇵 [日本語](docs/README.ja.md) · 🇰🇷 [한국어](docs/README.ko.md) · 🇨🇳 [简体中文](docs/README.zh-CN.md) · 🇹🇼 [繁體中文](docs/README.zh-TW.md) · 🇮🇳 [हिन्दी](docs/README.hi.md) · 🇩🇪 [Deutsch](docs/README.de.md) · 🇫🇷 [Français](docs/README.fr.md) · 🇪🇸 [Español](docs/README.es.md) · 🇧🇷 [Português](docs/README.pt-BR.md) · 🇮🇹 [Italiano](docs/README.it.md) · 🇳🇱 [Nederlands](docs/README.nl.md) · 🇵🇱 [Polski](docs/README.pl.md) · 🇨🇿 [Čeština](docs/README.cs.md) · 🇺🇦 [Українська](docs/README.uk.md) · 🇷🇺 [Русский](docs/README.ru.md) · 🇸🇪 [Svenska](docs/README.sv.md) · 🇩🇰 [Dansk](docs/README.da.md) · 🇪🇪 [Eesti](docs/README.et.md) · 🇹🇷 [Türkçe](docs/README.tr.md) · 🇸🇦 [العربية](docs/README.ar.md) · 🇮🇱 [עברית](docs/README.he.md) · 🇻🇳 [Tiếng Việt](docs/README.vi.md) · 🇮🇩 [Bahasa Indonesia](docs/README.id.md) · 🇹🇭 [ไทย](docs/README.th.md)

<p align="center">
  <img src="docs/assets/hero.png" alt="scout — Think first. Search second." width="820">
</p>

<p align="center">
  <img src="docs/assets/demo.gif" alt="scout demo — Before/After comparison" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Web research plugin for <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Turns vague questions into optimized multi-engine queries that reach primary sources.
</p>

<p align="center">
  <strong>Think first. Search second.</strong>
</p>

---

Claude Code's built-in WebSearch returns 125-character snippets and relies on keyword matching alone. That's enough for simple lookups — but for real research, you need query design, source evaluation, and privacy-aware routing.

scout does the thinking before the searching.

## Quick Start

No API keys required. No environment changes. Install and try immediately:

**1. Add the marketplace** (one-time):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Install**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Reload plugins** (type this inside Claude Code):

```
/mcp
```

Then ask Claude:

```text
/scout:search I want something like Git blame but for design decisions
```

scout will redesign this vague concept into the right term (ADR — Architecture Decision Records), search multiple engines with refined queries, evaluate source quality, and return an answer with a Research Trail showing exactly how it got there.

## What scout does

### Find concepts you can't name yet

> "I know the concept exists — something about tracking why we made each design choice — but I don't know what it's called"

scout translates fuzzy ideas into precise terminology and reaches the primary sources.

### Cut through SEO noise

> "What should I actually migrate to from Terraform — not the sponsored lists, real migration stories"

Pre-research acquires the right vocabulary, then targeted queries bypass content farms.

### Reach official docs directly

> "How do I set up middleware in Next.js App Router?"

scout checks [Context7](https://github.com/upstash/context7) for indexed official docs first — zero web search needed if the answer is there.

### Read any web page

> "Fetch and summarize https://docs.anthropic.com/en/docs/claude-code"

Privacy-aware fetching: public pages go through cloud APIs, confidential pages stay on your machine.

## Setup Levels

scout works immediately after install. Each level adds capability — all optional, all reversible.

### Level 1: Built-in Search (default)

Uses Claude Code's WebSearch. No configuration needed. This is what you get out of the box.

### Level 2: Official Docs + Cleaner Fetching

Add [Context7](https://github.com/upstash/context7) for direct library/framework doc access. Jina Reader's boilerplate stripping is built in — no setup needed. It automatically strips page noise so less text fills your context.

### Level 3: Semantic Search

Add [Exa](https://exa.ai) for meaning-based search — finds relevant pages even when you don't know the right keywords. Basic semantic search works with a free tier; API key unlocks advanced features.

### Level 4: Local Browser

Add [Playwright](https://playwright.dev) for JavaScript-rendered pages and confidential URLs that should never leave your machine. Downloads Chromium (~200MB).

**Run `/scout:setup` to walk through each level interactively.** Every step shows exactly what will be added to your configuration before any changes are made. Re-run anytime to add or update tools.

## Skills

| Skill | Purpose |
|---|---|
| `/scout:search` | Multi-engine web search with query design, source evaluation, and automatic re-search |
| `/scout:fetch` | URL content fetching with automatic privacy classification |
| `/scout:setup` | Interactive guided setup for search engines and fetching tools |

### Research Trail

Every search ends with a structured trail showing how scout reached its answer:

```
🔍 Research Trail
───────────────────────────────
Query:           your original question
Designed queries: the optimized queries scout actually ran
Sources:         URLs with reliability tier (🟢 primary / 🟡 secondary / ⚪ tertiary)
Re-searches:     any additional searches and why
Confidence:      High / Medium / Low with rationale
```

## Privacy

scout classifies URLs into three tiers before fetching:

| Classification | Routing | Examples |
|---|---|---|
| **Public** | Cloud APIs (r.jina.ai / WebFetch) | Blogs, docs, GitHub public repos |
| **Confidential** | Local Playwright only | localhost, internal wikis, admin panels |
| **Authenticated** | Playwright CDP (your browser session) | Notion, Slack, post-OAuth pages |

This classification is based on LLM judgment, not system enforcement. Treat it as best-effort routing. For highly sensitive data, verify the classification before proceeding.

**Confidential URLs are never sent to external APIs, even on failure** — the system does not fall back to cloud tools for confidential pages.

<details>
<summary>Chrome debug mode setup (for authenticated pages)</summary>

To fetch pages that require login (OAuth, SaaS dashboards), launch Chrome with remote debugging enabled. Chrome 146+ requires a separate `--user-data-dir`:

macOS:

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --remote-debugging-port=9222 \
  --user-data-dir=$HOME/.chrome-debug
```

Linux:

```bash
google-chrome --remote-debugging-port=9222 --user-data-dir=$HOME/.chrome-debug
```

On first launch with a new `--user-data-dir`, you'll need to log in to your accounts again. After that, sessions persist across restarts.
</details>

<details>
<summary>Browser profile note</summary>

The Playwright-based fetcher uses a persistent browser profile (`tools/.chrome-profile/`) that may accumulate cookies and session data. This directory is excluded from Git via `.gitignore` but may be copied by backup tools. Delete it periodically if you fetch confidential pages.
</details>

## Uninstall

Two commands to remove everything. No leftovers.

Remove the plugin (cleans up cache, config, and state data):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Remove Context7 if you added it via scout:setup (user-scoped — removes from all projects):

```bash
claude mcp remove context7
```

## Requirements

- **Claude Code** (required)
- `jq` (for setup diagnostics only)
- Python 3.10+ (only for Playwright local fetching)

## Security

API keys are stored in `.mcp.json` inside the plugin directory.
**Do not commit `.mcp.json` to Git.** The template `.mcp.json.dist` is safe to distribute.

## Disclaimer

This plugin is provided "as is" under the MIT License, without warranty of any kind.

**External APIs.** This plugin relies on third-party APIs (Exa, Jina AI, and others). The author makes no guarantees about the availability, accuracy, pricing, or continuity of these services and is not responsible for costs incurred through API usage.

**API Key Management.** You are solely responsible for obtaining, securing, and managing your own API keys, and for complying with each provider's terms of service.

**Content Classification.** URL privacy classification is based on LLM judgment and may contain errors. Do not rely on it as the sole safeguard for sensitive information.

**Web Fetching & Browser Automation.** This plugin includes tools for browser automation via Playwright. You are responsible for ensuring your use complies with target websites' terms of service, robots.txt policies, and applicable laws.

**MCP Servers.** This plugin connects to third-party MCP servers. The author does not control, audit, or guarantee the behavior or security of these servers.

## Third-Party Attributions

No third-party source code is redistributed — integration is via MCP connections, runtime package installation, and wrapper scripts.

| Tool | Provider | License |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

All product names, logos, and trademarks are the property of their respective owners.

## Language

Setup instructions are provided in your language by the AI assistant. Translated READMEs are for convenience — **the English original is authoritative**.

## Support

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Bug reports, feature requests, and questions

## Author

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## License

[MIT License](LICENSE) — free to use, modify, and distribute. Copyright (c) 2026 shidoyu.
