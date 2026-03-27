🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 **Svenska**

> **Obs:** Denna översättning tillhandahålls för bekvämlighet. [Det engelska originalet](../README.md) är den officiella versionen.

# scout — Webbsökning & Innehållshämtning

Claude Codes inbyggda WebSearch returnerar 125 tecken långa utdrag och förlitar sig enbart på nyckelordsmatchning. scout omvandlar en vag fråga till optimerade flermotor-sökfrågor, utvärderar resultatens kvalitet och söker om vid behov — och når primärkällor snabbare och mer tillförlitligt.

## Funktioner

- **scout:search** — Flermotor-webbsökning med optimerad frågedesign
- **scout:fetch** — Hämtning av URL-innehåll med sekretessmedvetet verktygsval

## Installation

Kör i din terminal:

```bash
# Steg 1: Registrera marketplace
claude plugin marketplace add shidoyu/scout

# Steg 2: Installera plugin
claude plugin install scout@shidoyu-scout
```

## Snabbstart

scout fungerar direkt efter installation — sökning använder WebSearch (inbyggd) och Exa (gratis, ingen nyckel krävs). Valfri konfiguration lägger till fler funktioner:

```bash
bash tools/setup.sh
```

### Prova nu

Efter installationen, fråga Claude:

**Hitta koncept du inte kan namnge ännu:**
> "det där mönstret där man skickar tillbaka ett objekt som bygger sig själv steg för steg"

**Upptäck internationella motsvarigheter till svenska koncept:**
> "finns det något som personnummer-validering i andra länders API:er?"

**Få expertkunskap från enkla frågor:**
> "min Docker-container funkar lokalt men kraschar på servern med 'killed'"

**Läs en specifik sida:**
> "läs https://docs.pydantic.dev/latest/concepts/validators/"

## Skills

### scout:search

Intelligent webbsökning med:
- Förundersökning för förfining av sökfrågor
- Flerspråkig frågedesign
- Flera sökmotorer (WebSearch, [Exa](https://exa.ai) semantisk sökning)
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) för konceptuella sökfrågor via Exa
- Kvalitetsbedömning med automatisk omsökningsloop

Användning: `/scout:search din fråga här`

### scout:fetch

Hämta webbsidors innehåll med automatisk sekretessklassificering:
- **Offentliga sidor** → Jina Reader (API-nyckel krävs) / WebFetch (inbyggd reservlösning)
- **Konfidentiella sidor** → Lokal Playwright (inga externa API-anrop)
- **Autentiserade sidor** → Chrome DevTools (webbläsarsession)

Användning: `/scout:fetch URL`

## Konfiguration (valfri)

Kör `tools/setup.sh` för att konfigurera:

1. **Exa** — Avancerade AI-native sökverktyg (API-nyckel för betalfunktioner; gratisnivån fungerar utan konfiguration)
2. **Jina Reader** — Högkvalitativ hämtning av webbsidor som Markdown (API-nyckel krävs; utan den faller offentliga sidor tillbaka på WebFetch)
3. **Playwright** — Webbläsarbaserad hämtning för JavaScript-renderade och konfidentiella sidor (~200 MB nedladdning)

Alla steg kan hoppas över. Kör om när som helst för att uppdatera inställningar.
Efter konfiguration, starta om Claude Code (eller kör `/mcp`) för att nya MCP-servrar ska börja gälla.

## Sekretess

scout klassificerar URL:er i tre nivåer innan hämtning:
- **Offentlig** → Moln-API:er (Jina Reader / WebFetch)
- **Konfidentiell** → Enbart lokal Playwright (avsedd routing: konfidentiella URL:er skickas inte till externa API:er)
- **Autentiserad** → Chrome DevTools (använder din webbläsarsession)

Denna klassificering är automatisk men baserad på LLM-bedömning, inte systemmässig tillämpning. Se [Sekretesspåpekande](#sekretesspåpekande) för detaljer.

## Krav

- Claude Code
- `jq` (enbart för konfigurationsskript)
- `npm`/`npx` (för [MCP](https://modelcontextprotocol.io/)-server: chrome-devtools)
- Python 3.10+ (valfritt, för lokal Playwright-hämtning)
- `uvx` eller `uv` (valfritt, för MCP-server: markitdown — HTML→Markdown-konvertering)
- Chrome (valfritt, för autentiserad sidhämtning via DevTools)

### Chrome DevTools-konfiguration (för autentiserade sidor)

För att hämta sidor som kräver inloggning (OAuth, SaaS-instrumentpaneler) måste Chrome köras i felsökningsläge:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Sekretesspåpekande

scout klassificerar URL:er efter känslighet och dirigerar konfidentiella URL:er till lokala verktyg.
Denna klassificering baseras på LLM-bedömning (domänmönster och kontext) och är **inte en systemmässigt tillämpat garanti**.
För mycket känslig data, verifiera klassificeringen innan du fortsätter.

**Webbläsarprofil.** Den Playwright-baserade hämtaren (`fetch-page.py`) använder en beständig webbläsarprofil (`tools/.chrome-profile/`) som kan ackumulera cookies, sessionsdata och webbhistorik. Denna katalog är exkluderad från Git via `.gitignore` men kan kopieras av säkerhetskopieringsverktyg eller molnsynkroniseringstjänster. Radera katalogen regelbundet om du hämtar konfidentiella sidor.

## Språk

Konfigurationsinstruktioner tillhandahålls på ditt språk av AI-assistenten.
Översatta instruktioner är endast för bekvämlighet — **det engelska originalet är auktoritativt**.

## Säkerhetsnotering

Efter att ha kört `setup.sh` lagras API-nycklar i `.mcp.json`.
**Commita inte `.mcp.json` till Git.** Använd `.mcp.json.dist` som mall för distribution.

## Ansvarsfriskrivning

Detta plugin tillhandahålls "i befintligt skick" under MIT-licensen, utan någon form av garanti.

**Externa API:er.** Detta plugin förlitar sig på tredjeparts-API:er (Exa, Jina AI med flera). Upphovsmannen ger inga garantier om dessa tjänsters tillgänglighet, noggrannhet, prissättning eller kontinuitet och ansvarar inte för kostnader som uppstår vid API-användning.

**API-nyckelhantering.** Du är ensamt ansvarig för att skaffa, säkra och hantera dina egna API-nycklar samt för att följa varje leverantörs användarvillkor.

**Innehållsklassificering.** Vid hämtning av webbinnehåll kan pluginet använda LLM-baserad klassificering för att bedöma sekretesskänslighet och fastställa lämpliga hämtningsmetoder. Sådana klassificeringar är av bästa-ansträngnings-typ och kan innehålla fel. Förlita dig inte på automatisk klassificering som det enda skyddet för känslig eller konfidentiell information.

**Webbhämtning och webbläsarautomatisering.** Detta plugin inkluderar verktyg för headless webbläsarautomatisering via Playwright och Chrome DevTools. Du är ansvarig för att din användning följer målwebbplatsers användarvillkor, robots.txt-policyer och tillämplig lagstiftning. Upphovsmannen ansvarar inte för blockering av webbplats, kontosuspension, IP-begränsningar, oväntad skriptkörning, resursförbrukning eller kompatibilitetsproblem till följd av webbläsarautomatisering.

**MCP-servrar.** Detta plugin ansluter till tredjeparts MCP-servrar (Model Context Protocol). Upphovsmannen kontrollerar, granskar eller garanterar inte dessa servrars beteende eller säkerhet.

## Tredjepartsattributioner

Detta plugin integreras med följande externa verktyg och tjänster. Ingen tredjeparts källkod distribueras vidare — integrering sker via MCP-serveranslutningar, körtidspaketinstallation och omslutningsskript skrivna av pluginutvecklaren.

| Verktyg | Leverantör | Licens |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietär (API-villkor) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alla produktnamn, logotyper och varumärken tillhör respektive ägare. Detta plugin är inte anslutet till eller godkänt av någon av de tredjeparts tjänster som anges ovan.

## Support

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Felrapporter, funktionsförfrågningar och frågor

## Upphovsman

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licens

[MIT License](../LICENSE) — fri att använda, modifiera och distribuera. Copyright (c) 2026 shidoyu.

