🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇸🇦 [العربية](README.ar.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇵🇱 [Polski](README.pl.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇺🇦 [Українська](README.uk.md) · 🇹🇭 [ไทย](README.th.md) · 🇷🇺 [Русский](README.ru.md) · 🇮🇳 [**हिन्दी**](README.hi.md)

> **नोट:** यह अनुवाद केवल सुविधा के लिए है। [अंग्रेज़ी मूल](../README.md) आधिकारिक संस्करण है।

# scout — Web Search & Content Fetching

Claude Code का built-in WebSearch सिर्फ 125-character snippets return करता है और केवल keyword matching पर depend करता है। scout एक vague question को optimized multi-engine queries में बदलता है, result quality evaluate करता है, और ज़रूरत पड़ने पर re-search करता है — primary sources तक तेज़ी से और reliably पहुँचने के लिए।

## विशेषताएँ

- **scout:search** — Query design optimization के साथ multi-engine web search
- **scout:fetch** — Privacy-aware tool selection के साथ URL content fetching

## इंस्टॉलेशन

अपने टर्मिनल में चलाएँ:

```bash
claude plugin add shidoyu/scout
```

## Quick Start

scout install के तुरंत बाद काम करता है — search WebSearch (built-in) और Exa (free, no key needed) use करता है। Optional setup से और capabilities मिलती हैं:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Intelligent web search जिसमें शामिल हैं:
- Query refinement के लिए pre-research
- Multi-language query design
- Multiple search engines (WebSearch, [Exa](https://exa.ai) semantic search)
- Conceptual queries के लिए Exa के via HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496))
- Automatic re-search loop के साथ quality assessment

Usage: `/scout:search your question here`

### scout:fetch

Automatic privacy classification के साथ web page content fetch करें:
- **Public pages** → Jina Reader (API key required) / WebFetch (built-in fallback)
- **Confidential pages** → Local Playwright (no external API calls)
- **Authenticated pages** → Chrome DevTools (browser session)

Usage: `/scout:fetch URL`

## Setup (Optional)

Configure करने के लिए `tools/setup.sh` run करें:

1. **Exa** — Advanced AI-native search tools (paid features के लिए API key; free tier बिना setup के काम करती है)
2. **Jina Reader** — High-quality web page fetching as Markdown (API key required; इसके बिना public pages WebFetch पर fall back करती हैं)
3. **Playwright** — JavaScript-rendered और confidential pages के लिए browser-based fetching (~200MB download)

सभी steps skippable हैं। Settings update करने के लिए कभी भी re-run करें।
Setup के बाद, नए MCP servers को effect में लाने के लिए Claude Code restart करें (या `/mcp` run करें)।

## Privacy

scout fetch करने से पहले URLs को तीन levels में classify करता है:
- **Public** → Cloud APIs (Jina Reader / WebFetch)
- **Confidential** → Local Playwright only (intended routing: confidential URLs को external APIs पर नहीं भेजा जाता)
- **Authenticated** → Chrome DevTools (आपका browser session use होता है)

यह classification automatic है लेकिन LLM judgment पर based है, system enforcement पर नहीं। Details के लिए [Privacy Disclaimer](#privacy-disclaimer) देखें।

## ज़रूरतें

- Claude Code
- `jq` (सिर्फ setup script के लिए)
- `npm`/`npx` ([MCP](https://modelcontextprotocol.io/) server के लिए: chrome-devtools)
- Python 3.10+ (optional, Playwright local fetching के लिए)
- `uvx` या `uv` (optional, MCP server के लिए: markitdown — HTML→Markdown conversion)
- Chrome (optional, DevTools के via authenticated page fetching के लिए)

### Chrome DevTools Setup (authenticated pages के लिए)

ऐसे pages fetch करने के लिए जिनमें login चाहिए (OAuth, SaaS dashboards), Chrome को debug mode में run करना होगा:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Privacy Disclaimer

scout URLs को sensitivity के हिसाब से classify करता है और confidential URLs को local-only tools पर route करता है।
यह classification LLM judgment (domain patterns और context) पर based है और **system-enforced guarantee नहीं है**।
अत्यधिक sensitive data के लिए, proceed करने से पहले classification verify करें।

**Browser Profile.** Playwright-based fetcher (`fetch-page.py`) एक persistent browser profile (`tools/.chrome-profile/`) use करता है जिसमें cookies, session data, और browsing history accumulate हो सकती है। यह directory `.gitignore` के via Git से exclude है लेकिन backup tools या cloud sync services द्वारा copy हो सकती है। Confidential pages fetch करते हैं तो directory को periodically delete करें।

## भाषा

Setup instructions AI assistant द्वारा आपकी भाषा में दिए जाते हैं।
अनुवादित instructions केवल सुविधा के लिए हैं — **अंग्रेज़ी original authoritative है**।

## Security Note

`setup.sh` run करने के बाद, API keys `.mcp.json` में store होती हैं।
**`.mcp.json` को Git पर commit न करें।** Distribution के लिए template के रूप में `.mcp.json.dist` use करें।

## Disclaimer

यह plugin MIT License के अंतर्गत "as is" provide किया जाता है, बिना किसी warranty के।

**External APIs.** यह plugin third-party APIs (Exa, Jina AI, और अन्य) पर rely करता है। Author इन services की availability, accuracy, pricing, या continuity के बारे में कोई guarantee नहीं देता और API usage के through होने वाले costs के लिए responsible नहीं है।

**API Key Management.** अपनी API keys प्राप्त करना, secure करना, और manage करना पूरी तरह आपकी ज़िम्मेदारी है, साथ ही प्रत्येक provider की terms of service का पालन करना भी।

**Content Classification.** Web content fetch करते समय, plugin privacy sensitivity assess करने और appropriate retrieval methods determine करने के लिए LLM-based classification use कर सकता है। ऐसी classifications best-effort हैं और इनमें errors हो सकती हैं। Sensitive या confidential information के लिए automated classification को sole safeguard के रूप में न लें।

**Web Fetching & Browser Automation.** इस plugin में Playwright और Chrome DevTools के via headless browser automation के tools शामिल हैं। यह सुनिश्चित करना आपकी ज़िम्मेदारी है कि आपका use target websites की terms of service, robots.txt policies, और applicable laws का पालन करता है। Browser automation से होने वाले site blocking, account suspension, IP restrictions, unexpected script execution, resource consumption, या compatibility issues के लिए author liable नहीं है।

**MCP Servers.** यह plugin third-party MCP (Model Context Protocol) servers से connect होता है। Author इन servers के behavior या security को control, audit, या guarantee नहीं करता।

## Third-Party Attributions

यह plugin निम्नलिखित external tools और services के साथ integrate होता है। कोई भी third-party source code redistribute नहीं किया जाता — integration MCP server connections, runtime package installation, और plugin developer द्वारा authored wrapper scripts के via होती है।

| Tool | Provider | License |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

सभी product names, logos, और trademarks उनके respective owners की property हैं। यह plugin ऊपर listed किसी भी third-party service से affiliated या endorsed नहीं है।

## सहायता

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Bug reports, feature requests, और प्रश्न

## लेखक

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## लाइसेंस

[MIT License](../LICENSE) — उपयोग, संशोधन, और वितरण के लिए स्वतंत्र। Copyright (c) 2026 shidoyu.

