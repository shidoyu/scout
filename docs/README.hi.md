🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇸🇦 [العربية](README.ar.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇵🇱 [Polski](README.pl.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇺🇦 [Українська](README.uk.md) · 🇹🇭 [ไทย](README.th.md) · 🇷🇺 [Русский](README.ru.md) · 🇮🇳 [**हिन्दी**](README.hi.md)

> **नोट:** यह अनुवाद केवल सुविधा के लिए है। [अंग्रेज़ी मूल](../README.md) आधिकारिक संस्करण है।

# scout

**Wrong search, wrong decision.**

> पहले सोचो, फिर खोजो। — Claude Code के लिए वेब रिसर्च प्लगइन।

क्वेरी डिज़ाइन, मल्टी-इंजन सर्च, प्राइवेसी-अवेयर फ़ेचिंग।

Claude Code का बिल्ट-इन WebSearch सिर्फ 125-अक्षरों के स्निपेट लौटाता है और केवल कीवर्ड मैचिंग पर निर्भर रहता है। scout एक अस्पष्ट सवाल को कई सर्च इंजनों के लिए ऑप्टिमाइज़्ड क्वेरी में बदलता है, परिणामों की गुणवत्ता का मूल्यांकन करता है, और ज़रूरत पड़ने पर दोबारा खोजता है, ताकि प्राथमिक स्रोतों तक तेज़ी और ज़्यादा भरोसे के साथ पहुँचा जा सके।

## विशेषताएँ

- **scout:search** — Query design optimization के साथ multi-engine web search
- **scout:fetch** — Privacy-aware tool selection के साथ URL content fetching

## इंस्टॉलेशन

अपने टर्मिनल में चलाएँ:

```bash
# चरण 1: मार्केटप्लेस रजिस्टर करें
claude plugin marketplace add shidoyu/scout
```

```bash
# चरण 2: प्लगइन इंस्टॉल करें
claude plugin install scout@shidoyu-scout
```

**चरण 3** — सर्च इंजन और फ़ेचिंग टूल सेट करें

इन्हें Claude Code में एक-एक करके चलाएँ:

```text
/reload-plugins
```

```text
/scout:setup
```

scout:setup आपको Context7 (library docs), Jina Reader (वेब पेज फ़ेचिंग), Exa (सिमैंटिक सर्च), और Playwright (JavaScript-रेंडर्ड पेज) को इंटरैक्टिव तरीक़े से कॉन्फ़िगर करने में मदद करता है। हर स्टेप वैकल्पिक है और स्किप किया जा सकता है।

> **नोट:** अगर आप यह स्टेप स्किप करते हैं, तो scout अगले सेशन शुरू होने पर आपसे पूछेगा। बेसिक सर्च बिना सेटअप के तुरंत काम करता है।

## Quick Start

इंस्टॉल करने के बाद तुरंत उपयोग करें (सेटअप ज़रूरी नहीं — बेसिक सर्च तुरंत काम करता है):

### अभी आज़माएं

इंस्टॉल करने के बाद, Claude से पूछें:

**उन concepts को खोजें जिनका नाम आप अभी तक नहीं जानते:**
> "वो technique जिसमें database अपने आप बार-बार पूछे जाने वाले queries का result याद रख लेता है"

**भारतीय concepts के international equivalents खोजें:**
> "UPI payment integration के लिए कौन सा API best है? Razorpay vs Paytm vs PhonePe difference क्या है?"

**सरल सवालों से expert जवाब पाएं:**
> "Hindi text का font browser में सही दिख रहा है लेकिन PDF generate करने पर टूट जाता है"

**कोई specific page पढ़ें:**
> "ये page पढ़ो https://docs.github.com/en/actions/quickstart"

## Skills

### scout:search

Intelligent web search जिसमें शामिल हैं:
- Query refinement के लिए pre-research
- Multi-language query design
- Multiple search engines (WebSearch, [Context7](https://github.com/upstash/context7) official docs, [Exa](https://exa.ai) semantic search)
- Conceptual queries के लिए Exa के via HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496))
- Automatic re-search loop के साथ quality assessment

Usage: `/scout:search your question here`

### scout:fetch

Automatic privacy classification के साथ web page content fetch करें:
- **Public pages** → Jina Reader / WebFetch (built-in fallback)
- **Confidential pages** → Local Playwright (no external API calls)
- **Authenticated pages** → Chrome DevTools (browser session)

Usage: `/scout:fetch URL`

### scout:setup

सर्च इंजन और फ़ेचिंग टूल के लिए इंटरैक्टिव गाइडेड सेटअप:
- **Context7** — लाइब्रेरी और फ्रेमवर्क की मौजूदा आधिकारिक docs तक सीधा रास्ता, ताकि तकनीकी सवाल जल्दी source docs तक पहुँचें ([Context7 MCP](https://github.com/upstash/context7), API key नहीं चाहिए)
- **Jina Reader** — वेब पेज को ज़्यादा साफ़ Markdown में लाता है, नेविगेशन और दोहराए जाने वाले हिस्से हटाता है, जिससे अक्सर मॉडल तक कम टेक्स्ट जाता है और टोकन बचते हैं ([मुफ़्त API key](https://jina.ai/?newKey))
- **Exa** — अर्थ-आधारित खोज, जब सवाल अस्पष्ट, वैचारिक या niche हो और सही terms साफ़ न हों ([API key](https://exa.ai))
- **Playwright** — JavaScript-rendered या गोपनीय पेजों के लिए लोकल ब्राउज़र फ़ेचिंग, जो आपकी मशीन पर ही रहनी चाहिए (~200MB डाउनलोड)

सभी स्टेप वैकल्पिक हैं। सेटिंग्स अपडेट करने के लिए कभी भी दोबारा चलाएँ।

उपयोग: `/scout:setup`

## Privacy

scout fetch करने से पहले URLs को तीन levels में classify करता है:
- **Public** → Cloud APIs (Jina Reader / WebFetch)
- **Confidential** → Local Playwright only (intended routing: confidential URLs को external APIs पर नहीं भेजा जाता)
- **Authenticated** → Chrome DevTools (आपका browser session use होता है)

यह classification automatic है लेकिन LLM judgment पर based है, system enforcement पर नहीं। Details के लिए [Privacy Disclaimer](#privacy-disclaimer) देखें।

## ज़रूरतें

- Claude Code
- `jq` (सिर्फ setup के लिए)
- `npm`/`npx` ([MCP](https://modelcontextprotocol.io/) server के लिए: chrome-devtools)
- Python 3.10+ (optional, Playwright local fetching के लिए)
- `uvx` या `uv` (optional, MCP server के लिए: markitdown — HTML→Markdown conversion)
- Chrome (optional, DevTools के via authenticated page fetching के लिए)

### Chrome DevTools Setup (authenticated pages के लिए)

ऐसे pages fetch करने के लिए जिनमें login चाहिए (OAuth, SaaS dashboards), Chrome को debug mode में run करना होगा:

macOS पर:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

Linux पर:

```bash
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

सेटअप के बाद, API keys `.mcp.json` में store होती हैं।
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

