🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 **Svenska** · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Observera:** Denna översättning tillhandahålls för bekvämlighets skull. Den officiella versionen är [det engelska originalet](../README.md).

<p align="center">
  <img src="assets/hero.png" alt="scout — Tänk först. Sök sedan." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Webbforskningsplugin för <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Omvandlar vaga frågor till optimerade flermotorsfrågor som når primära källor.
</p>

<p align="center">
  <strong>Tänk först. Sök sedan.</strong>
</p>

---

Claude Codes inbyggda WebSearch returnerar utdrag på 125 tecken och förlitar sig enbart på nyckelordsmatchning. Det räcker för enkla uppslag, men riktig forskning kräver frågedesign, källvärdering och integritetsmedveten routing.

scout tänker före sökningen.

## Snabbstart

Inga API-nycklar behövs. Inga miljöförändringar. Installera och prova direkt:

**1. Lägg till marknadsplatsen** (engångsinställning):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Installera**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Ladda om plugins** (skriv detta i Claude Code):

```
/mcp
```

Fråga sedan Claude:

```text
/scout:search Jag söker något som Git blame men för designbeslut
```

scout omvandlar detta vaga koncept till rätt term (ADR — Architecture Decision Records), söker i flera motorer med förfinade frågor, utvärderar källkvalitet och returnerar ett svar med en Research Trail som visar exakt hur den kom fram till svaret.

## Vad scout gör

### Hittar koncept du ännu inte kan namnge

> "Jag vet att konceptet finns — något om att spara varför vi fattade varje designbeslut — men jag vet inte vad det heter"

scout översätter suddiga idéer till exakt terminologi och når de primära källorna.

### Tar sig genom SEO-bruset

> "Vad bör jag egentligen migrera till från Terraform — inte de sponsrade listorna, verkliga migreringshistorier"

Förforskning ger rätt vokabulär, sedan kringgår riktade frågor innehållsfarmerna.

### Når officiell dokumentation direkt

> "Hur konfigurerar jag middleware i Next.js App Router?"

scout kontrollerar först [Context7](https://github.com/upstash/context7) för indexerad officiell dokumentation — om svaret finns där behövs ingen webbsökning.

### Läser valfri webbsida

> "Hämta och sammanfatta https://docs.anthropic.com/en/docs/claude-code"

Integritetsmedveten hämtning: offentliga sidor går via moln-API:er, konfidentiella sidor stannar på din maskin.

## Installationsnivåer

scout fungerar direkt efter installation. Varje nivå lägger till kapacitet — alla är valfria och reversibla.

### Nivå 1: Inbyggd sökning (standard)

Använder Claude Codes WebSearch. Ingen konfiguration behövs. Detta är vad du får direkt ur lådan.

### Nivå 2: Officiell dokumentation + renare hämtning

Lägg till [Context7](https://github.com/upstash/context7) för direkt åtkomst till dokumentation för bibliotek och ramverk. Jina Readers rensning av överflödig text är inbyggd — ingen konfiguration krävs. Sidbruset rensas bort automatiskt så att mindre text tar upp plats i din kontext.

### Nivå 3: Semantisk sökning

Lägg till [Exa](https://exa.ai) för betydelsebaserad sökning — hittar relevanta sidor även när du inte kan de rätta nyckelorden. Grundläggande semantisk sökning fungerar med gratisplanen; API-nyckel låser upp avancerade funktioner.

### Nivå 4: Lokal webbläsare

Lägg till [Playwright](https://playwright.dev) för JavaScript-renderade sidor och konfidentiella URL:er som aldrig bör lämna din maskin. Laddar ner Chromium (~200MB).

**Kör `/scout:setup` för att interaktivt gå igenom varje nivå.** Varje steg visar exakt vad som kommer att läggas till i konfigurationen innan några ändringar görs. Kör när som helst igen för att lägga till eller uppdatera verktyg.

## Färdigheter

| Färdighet | Syfte |
|---|---|
| `/scout:search` | Flermotors webbsökning med frågedesign, källvärdering och automatisk omsökning |
| `/scout:fetch` | URL-innehållshämtning med automatisk integritetsklassificering |
| `/scout:setup` | Interaktiv guidad installation för sökmotorer och hämtningsverktyg |

### Research Trail

Varje sökning avslutas med en strukturerad redogörelse som visar hur scout nådde sitt svar:

```
🔍 Research Trail
───────────────────────────────
Query:           din ursprungliga fråga
Designed queries: de optimerade frågorna som scout faktiskt körde
Sources:         URL:er med pålitlighetsnivå (🟢 primära / 🟡 sekundära / ⚪ tertiära)
Re-searches:     eventuella ytterligare sökningar och varför
Confidence:      High / Medium / Low med motivering
```

## Integritet

scout klassificerar URL:er i tre nivåer före hämtning:

| Klassificering | Routing | Exempel |
|---|---|---|
| **Offentlig** | Moln-API:er (Jina Reader / WebFetch) | Bloggar, dokumentation, offentliga GitHub-repon |
| **Konfidentiell** | Enbart lokal Playwright | localhost, interna wikier, adminpaneler |
| **Autentiserad** | Playwright CDP | Notion, Slack, sidor efter OAuth-inloggning |

Denna klassificering baseras på LLM-bedömning, inte systemtillämpning. Behandla den som routing efter bästa förmåga. För mycket känsliga data, verifiera klassificeringen innan du fortsätter.

**Konfidentiella URL:er skickas aldrig till externa API:er, inte ens vid misslyckande** — systemet faller inte tillbaka på molnverktyg för konfidentiella sidor.

<details>
<summary>Chrome-felsökningsläge (för autentiserade sidor)</summary>

För att hämta sidor som kräver inloggning (OAuth, SaaS-instrumentpaneler), starta Chrome i felsökningsläge. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Om webbläsarprofilen</summary>

Playwright-baserade hämtaren använder en bestående webbläsarprofil (`tools/.chrome-profile/`) där cookies och sessionsdata kan ackumuleras. Denna katalog är exkluderad från Git via `.gitignore` men kan kopieras av säkerhetskopieringsverktyg. Radera den regelbundet om du hämtar konfidentiella sidor.
</details>

## Avinstallation

Två kommandon tar bort allt. Inga rester.

Ta bort pluginet (rensar cache, konfiguration och tillståndsdata):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Ta bort Context7 om du lade till det via scout:setup (användaromfång — tas bort från alla projekt):

```bash
claude mcp remove context7
```

## Krav

- **Claude Code** (obligatoriskt)
- `jq` (enbart för installationsdiagnostik)
- Python 3.10+ (enbart för lokal hämtning via Playwright)

## Säkerhet

API-nycklar lagras i `.mcp.json` i pluginkatalogen.
**Committa inte `.mcp.json` till Git.** Mallen `.mcp.json.dist` är säker att distribuera.

## Ansvarsfriskrivning

Detta plugin tillhandahålls "i befintligt skick" under MIT-licensen, utan några garantier.

**Externa API:er.** Detta plugin förlitar sig på tredjeparts-API:er (Exa, Jina AI med flera). Författaren lämnar inga garantier om tillgänglighet, noggrannhet, prissättning eller kontinuitet för dessa tjänster och är inte ansvarig för kostnader som uppstår genom API-användning.

**API-nyckelhantering.** Du är ensam ansvarig för att skaffa, säkra och hantera dina egna API-nycklar samt för att följa varje leverantörs användarvillkor.

**Innehållsklassificering.** URL-integritetsklassificering baseras på LLM-bedömning och kan innehålla fel. Förlita dig inte på den som enda skyddsåtgärd för känslig information.

**Webbhämtning och webbläsarautomation.** Detta plugin inkluderar verktyg för headless webbläsarautomation via Playwright. Du är ansvarig för att säkerställa att din användning följer målsidornas användarvillkor, robots.txt-policyer och tillämplig lagstiftning.

**MCP-servrar.** Detta plugin ansluter till tredjeparts-MCP-servrar. Författaren kontrollerar, granskar eller garanterar inte dessa servrars beteende eller säkerhet.

## Tredjepartshänvisningar

Ingen tredjepartskällkod omdistribueras — integration sker via MCP-anslutningar, körningspaketinstallation och omslagsskript.

| Verktyg | Leverantör | Licens |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alla produktnamn, logotyper och varumärken tillhör sina respektive ägare.

## Språk

Installationsinstruktioner tillhandahålls på ditt språk av AI-assistenten. Översatta README-filer är för bekvämlighets skull — **det engelska originalet är den officiella versionen**.

## Support

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Felrapporter, funktionsförfrågningar och frågor

## Författare

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licens

[MIT License](../LICENSE) — fri att använda, modifiera och distribuera. Copyright (c) 2026 shidoyu.
