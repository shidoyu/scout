🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇸🇦 [العربية](README.ar.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇵🇱 [Polski](README.pl.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇺🇦 [Українська](README.uk.md) · 🇹🇭 [ไทย](README.th.md) · 🇷🇺 [Русский](README.ru.md) · 🇩🇰 [**Dansk**](README.da.md)

> **Bemærk:** Denne oversættelse er kun til orientering. Den [engelske original](../README.md) er den officielle version.

# scout — Websøgning og indhentning af indhold

Claude Codes indbyggede WebSearch returnerer uddrag på 125 tegn og anvender udelukkende nøgleordsmatching. scout omdanner et vagt spørgsmål til optimerede forespørgsler på tværs af flere søgemaskiner, vurderer resultaternes kvalitet og søger igen ved behov — og når primære kilder hurtigere og mere pålideligt.

## Funktioner

- **scout:search** — Websøgning på tværs af flere søgemaskiner med optimering af forespørgselsdesign
- **scout:fetch** — Indhentning af URL-indhold med privatlivsbevidst valg af værktøj

## Installation

Kør i din terminal:

```bash
claude plugin add shidoyu/scout
```

## Kom hurtigt i gang

scout fungerer umiddelbart efter installation — søgning bruger WebSearch (indbygget) og Exa (gratis, ingen nøgle kræves). Valgfri opsætning tilføjer yderligere funktioner:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Intelligent websøgning med:
- Forsøgning til raffinering af forespørgsler
- Forespørgselsdesign på flere sprog
- Flere søgemaskiner (WebSearch, [Exa](https://exa.ai) semantisk søgning)
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) til konceptuelle forespørgsler via Exa
- Kvalitetsvurdering med automatisk loop til ny søgning

Brug: `/scout:search dit spørgsmål her`

### scout:fetch

Hent websideindhold med automatisk klassificering af følsomhed:
- **Offentlige sider** → Jina Reader (API-nøgle påkrævet) / WebFetch (indbygget reserve)
- **Fortrolige sider** → Lokal Playwright (ingen eksterne API-kald)
- **Godkendte sider** → Chrome DevTools (browsersession)

Brug: `/scout:fetch URL`

## Opsætning (valgfri)

Kør `tools/setup.sh` for at konfigurere:

1. **Exa** — Avancerede AI-native søgeværktøjer (API-nøgle til betalte funktioner; gratis niveau fungerer uden opsætning)
2. **Jina Reader** — Høj kvalitet websideindhentning som Markdown (API-nøgle påkrævet; uden den falder offentlige sider tilbage til WebFetch)
3. **Playwright** — Browserbaseret indhentning til JavaScript-renderede og fortrolige sider (~200 MB download)

Alle trin kan springes over. Kør igen når som helst for at opdatere indstillinger.
Efter opsætning skal du genstarte Claude Code (eller køre `/mcp`) for at nye MCP-servere træder i kraft.

## Privatliv

scout klassificerer URL'er i tre niveauer inden indhentning:
- **Offentlig** → Cloud-API'er (Jina Reader / WebFetch)
- **Fortrolig** → Kun lokal Playwright (tilsigtet routing: fortrolige URL'er sendes ikke til eksterne API'er)
- **Godkendt** → Chrome DevTools (bruger din browsersession)

Denne klassificering sker automatisk, men er baseret på LLM-vurdering, ikke systemmæssig håndhævelse. Se [Privatlivsfraskrivelse](#privatlivsfraskrivelse) for detaljer.

## Krav

- Claude Code
- `jq` (kun til opsætningsscript)
- `npm`/`npx` (til [MCP](https://modelcontextprotocol.io/)-server: chrome-devtools)
- Python 3.10+ (valgfri, til Playwright lokal indhentning)
- `uvx` eller `uv` (valgfri, til MCP-server: markitdown — HTML→Markdown-konvertering)
- Chrome (valgfri, til indhentning af godkendte sider via DevTools)

### Chrome DevTools-opsætning (til godkendte sider)

For at hente sider, der kræver login (OAuth, SaaS-dashboards), skal Chrome køre i fejlsøgningstilstand:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Privatlivsfraskrivelse

scout klassificerer URL'er efter følsomhed og videresender fortrolige URL'er til lokale værktøjer.
Denne klassificering er baseret på LLM-vurdering (domænemønstre og kontekst) og er **ikke en systemmæssigt håndhævet garanti**.
For meget følsomme data bør du verificere klassificeringen, inden du fortsætter.

**Browserprofil.** Den Playwright-baserede indhentning (`fetch-page.py`) anvender en vedvarende browserprofil (`tools/.chrome-profile/`), som kan akkumulere cookies, sessionsdata og browserhistorik. Dette bibliotek er udelukket fra Git via `.gitignore`, men kan kopieres af backupværktøjer eller skysyncstjenester. Slet biblioteket med jævne mellemrum, hvis du henter fortrolige sider.

## Sprog

Opsætningsinstruktioner leveres på dit sprog af AI-assistenten.
Oversatte instruktioner er kun til orientering — **den engelske original er autoritativ**.

## Sikkerhedsnote

Efter at have kørt `setup.sh` gemmes API-nøgler i `.mcp.json`.
**Commit ikke `.mcp.json` til Git.** Brug `.mcp.json.dist` som skabelon til distribution.

## Fraskrivelse

Dette plugin leveres "som det er" under MIT-licensen, uden nogen form for garanti.

**Eksterne API'er.** Dette plugin er afhængigt af tredjeparts-API'er (Exa, Jina AI og andre). Forfatteren giver ingen garantier for disse tjenesters tilgængelighed, nøjagtighed, prissætning eller kontinuitet og er ikke ansvarlig for omkostninger opstået ved API-brug.

**API-nøglehåndtering.** Du er alene ansvarlig for at anskaffe, sikre og administrere dine egne API-nøgler samt for at overholde hver udbyders servicevilkår.

**Indholdsklassificering.** Når webindhold hentes, kan pluginnet anvende LLM-baseret klassificering til at vurdere privatlivsfølsomhed og bestemme passende hentningsmetoder. Sådanne klassificeringer er bedste forsøg og kan indeholde fejl. Stol ikke på automatisk klassificering som den eneste beskyttelse for følsomme eller fortrolige oplysninger.

**Webhentning og browserautomatisering.** Dette plugin inkluderer værktøjer til headless browserautomatisering via Playwright og Chrome DevTools. Du er ansvarlig for at sikre, at din brug overholder målwebsteders servicevilkår, robots.txt-politikker og gældende lovgivning. Forfatteren er ikke ansvarlig for blokering af websteder, kontosuspension, IP-restriktioner, uventet scriptudførelse, ressourceforbrug eller kompatibilitetsproblemer som følge af browserautomatisering.

**MCP-servere.** Dette plugin forbinder til tredjeparts MCP (Model Context Protocol)-servere. Forfatteren kontrollerer, reviderer eller garanterer ikke disse servers adfærd eller sikkerhed.

## Tredjepartsattributter

Dette plugin integrerer med følgende eksterne værktøjer og tjenester. Ingen tredjeparts kildekode redistribueres — integration sker via MCP-serverforbindelser, installation af pakker ved kørselstid og wrappercripts forfattet af pluginudvikleren.

| Værktøj | Udbyder | Licens |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietær (API-vilkår) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alle produktnavne, logoer og varemærker tilhører de respektive ejere. Dette plugin er ikke tilknyttet eller godkendt af nogen af de ovenstående tredjepartstjenester.

## Support

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Fejlrapporter, funktionsanmodninger og spørgsmål

## Forfatter

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licens

[MIT License](../LICENSE) — fri til at bruge, ændre og distribuere. Copyright (c) 2026 shidoyu.

