🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 **Dansk** · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Bemærk:** Denne oversættelse er kun til orientering. Den officielle version er [den engelske original](../README.md).

<p align="center">
  <img src="assets/hero.png" alt="scout — Tænk først. Søg bagefter." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Webforskningsplugin til <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Omdanner vage spørgsmål til optimerede flermotorsforespørgsler, der når frem til primære kilder.
</p>

<p align="center">
  <strong>Tænk først. Søg bagefter.</strong>
</p>

---

Claude Codes indbyggede WebSearch returnerer uddrag på 125 tegn og baserer sig udelukkende på nøgleordsmatch. Det er nok til simple opslag, men reel forskning kræver forespørgselsdesign, kildevurdering og privatlivsbevidst routing.

scout tænker, før den søger.

## Hurtig start

Ingen API-nøgler påkrævet. Ingen miljøændringer. Installér og prøv med det samme:

**1. Tilføj markedspladsen** (engangs):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Installér**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Genindlæs plugins** (skriv dette i Claude Code):

```
/mcp
```

Spørg derefter Claude:

```text
/scout:search Jeg leder efter noget som Git blame, men til at spore designbeslutninger
```

scout omdanner dette vage koncept til den rette term (ADR — Architecture Decision Records), søger i flere motorer med forfinede forespørgsler, evaluerer kildekvalitet og returnerer et svar med en Research Trail, der viser præcist, hvordan den nåede frem til svaret.

## Hvad scout gør

### Finder koncepter, du endnu ikke kan navngive

> "Jeg ved, at konceptet findes — noget om at registrere, hvorfor vi traf hver designbeslutning — men jeg kender ikke navnet"

scout oversætter uklare idéer til præcis terminologi og når de primære kilder.

### Bryder igennem SEO-støjen

> "Hvad bør jeg egentlig migrere til fra Terraform — ikke de sponsorerede lister, men rigtige migreringshistorier"

Forudgående research giver det rette ordforråd, hvorefter målrettede forespørgsler omgår indholdsfarmene.

### Når direkte til officiel dokumentation

> "Hvordan opsætter jeg middleware i Next.js App Router?"

scout tjekker først [Context7](https://github.com/upstash/context7) for indekseret officiel dokumentation — hvis svaret er der, er websøgning ikke nødvendig.

### Læser enhver webside

> "Hent og opsummér https://docs.anthropic.com/en/docs/claude-code"

Privatlivsbevidst hentning: offentlige sider går via cloud-API'er, fortrolige sider forbliver på din maskine.

## Opsætningsniveauer

scout virker med det samme efter installation. Hvert niveau tilføjer funktionalitet — alle er valgfrie og kan rulles tilbage.

### Niveau 1: Indbygget søgning (standard)

Bruger Claude Codes WebSearch. Ingen konfiguration nødvendig. Dette er, hvad du får lige ud af boksen.

### Niveau 2: Officiel dokumentation + renere hentning

Tilføj [Context7](https://github.com/upstash/context7) for direkte adgang til biblioteks-/rammeværksdokumentation, og [Jina Reader](https://jina.ai) for renere sidelæsning. Context7 kræver ingen API-nøgle; valgfri nøgle til Jina øger hastighedsgrænserne.

### Niveau 3: Semantisk søgning

Tilføj [Exa](https://exa.ai) til betydningsbaseret søgning — finder relevante sider, selv når du ikke kender de rigtige nøgleord. Grundlæggende semantisk søgning virker med den gratis plan; API-nøgle låser avancerede funktioner op.

### Niveau 4: Lokal browser

Tilføj [Playwright](https://playwright.dev) til JavaScript-renderede sider og fortrolige URL'er, der aldrig bør forlade din maskine. Henter Chromium (~200MB).

**Kør `/scout:setup` for at gå interaktivt igennem hvert niveau.** Hvert trin viser præcist, hvad der vil blive tilføjet til konfigurationen, før nogen ændringer foretages. Kan køres igen når som helst for at tilføje eller opdatere værktøjer.

## Færdigheder

| Færdighed | Formål |
|---|---|
| `/scout:search` | Flermotors websøgning med forespørgselsdesign, kildevurdering og automatisk gensøgning |
| `/scout:fetch` | URL-indholdshentning med automatisk privatlivsklassificering |
| `/scout:setup` | Interaktiv guidet opsætning af søgemotorer og hentningsværktøjer |

### Research Trail

Hver søgning afsluttes med en struktureret oversigt, der viser, hvordan scout nåede frem til sit svar:

```
🔍 Research Trail
───────────────────────────────
Query:           dit oprindelige spørgsmål
Designed queries: de optimerede forespørgsler, som scout faktisk kørte
Sources:         URL'er med pålidelighedsniveau (🟢 primære / 🟡 sekundære / ⚪ tertiære)
Re-searches:     eventuelle yderligere søgninger og hvorfor
Confidence:      High / Medium / Low med begrundelse
```

## Privatliv

scout klassificerer URL'er i tre niveauer før hentning:

| Klassificering | Routing | Eksempler |
|---|---|---|
| **Offentlig** | Cloud-API'er (Jina Reader / WebFetch) | Blogs, dokumentation, offentlige GitHub-repos |
| **Fortrolig** | Kun lokal Playwright | localhost, interne wikier, adminpaneler |
| **Autentificeret** | Playwright CDP | Notion, Slack, sider efter OAuth-login |

Denne klassificering er baseret på LLM-vurdering, ikke systemmæssig håndhævelse. Behandl den som best-effort routing. For meget følsomme data, verificér klassificeringen, før du fortsætter.

**Fortrolige URL'er sendes aldrig til eksterne API'er, selv ved fejl** — systemet falder ikke tilbage til cloudværktøjer for fortrolige sider.

<details>
<summary>Chrome-fejlsøgningstilstand (til autentificerede sider)</summary>

For at hente sider, der kræver login (OAuth, SaaS-dashboards), start Chrome i fejlsøgningstilstand. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Bemærkning om browserprofil</summary>

Den Playwright-baserede henter bruger en vedvarende browserprofil (`tools/.chrome-profile/`), hvor cookies og sessionsdata kan akkumuleres. Denne mappe er ekskluderet fra Git via `.gitignore`, men kan kopieres af backupværktøjer. Slet den jævnligt, hvis du henter fortrolige sider.
</details>

## Afinstallation

To kommandoer fjerner alt. Ingen rester.

Fjern pluginet (rydder cache, konfiguration og tilstandsdata):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Fjern Context7, hvis du tilføjede det via scout:setup (brugerscope — fjernes fra alle projekter):

```bash
claude mcp remove context7
```

## Krav

- **Claude Code** (påkrævet)
- `jq` (kun til opsætningsdiagnostik)
- Python 3.10+ (kun til lokal hentning via Playwright)

## Sikkerhed

API-nøgler opbevares i `.mcp.json` i plugin-mappen.
**Commit ikke `.mcp.json` til Git.** Skabelonen `.mcp.json.dist` er sikker at distribuere.

## Ansvarsfraskrivelse

Dette plugin leveres "som det er" under MIT-licensen, uden nogen form for garanti.

**Eksterne API'er.** Dette plugin er afhængigt af tredjeparts-API'er (Exa, Jina AI med flere). Forfatteren giver ingen garantier for tilgængelighed, nøjagtighed, prissætning eller kontinuitet af disse tjenester og er ikke ansvarlig for omkostninger, der opstår ved API-brug.

**API-nøglehåndtering.** Du er alene ansvarlig for at anskaffe, sikre og håndtere dine egne API-nøgler samt for at overholde hver udbyders servicevilkår.

**Indholdsklassificering.** URL-privatlivsklassificering er baseret på LLM-vurdering og kan indeholde fejl. Stol ikke på den som eneste beskyttelse af følsomme oplysninger.

**Webhentning og browserautomation.** Dette plugin inkluderer værktøjer til headless browserautomation via Playwright. Du er ansvarlig for at sikre, at din brug overholder målwebsidernes servicevilkår, robots.txt-politikker og gældende lovgivning.

**MCP-servere.** Dette plugin forbinder til tredjeparts-MCP-servere. Forfatteren kontrollerer, auditerer eller garanterer ikke disse serveres adfærd eller sikkerhed.

## Tredjepartshenvisninger

Ingen tredjepartskildekode redistribueres — integration sker via MCP-forbindelser, runtime-pakkeinstallation og wrapper-scripts.

| Værktøj | Udbyder | Licens |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alle produktnavne, logoer og varemærker tilhører deres respektive ejere.

## Sprog

Opsætningsinstruktioner leveres på dit sprog af AI-assistenten. Oversatte README-filer er til orientering — **den engelske original er den officielle version**.

## Support

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Fejlrapporter, funktionsanmodninger og spørgsmål

## Forfatter

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licens

[MIT License](../LICENSE) — fri at bruge, ændre og distribuere. Copyright (c) 2026 shidoyu.
