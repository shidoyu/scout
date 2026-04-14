🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 **Nederlands** · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Let op:** Deze vertaling is beschikbaar gesteld voor het gemak. De [originele Engelse versie](../README.md) is de officiële versie.

<p align="center">
  <img src="assets/hero.png" alt="scout — Eerst denken. Dan zoeken." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Webonderzoek-plugin voor <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Zet vage vragen om in geoptimaliseerde multi-engine zoekopdrachten die primaire bronnen bereiken.
</p>

<p align="center">
  <strong>Eerst denken. Dan zoeken.</strong>
</p>

---

De ingebouwde WebSearch van Claude Code levert fragmenten van 125 tekens en vertrouwt uitsluitend op trefwoordovereenkomst. Dat volstaat voor eenvoudige opzoekingen — maar voor echt onderzoek heb je queryontwerp, bronevaluatie en privacybewuste routering nodig.

scout denkt na voordat het zoekt.

## Snelstart

Geen API-sleutels nodig. Geen omgevingswijzigingen. Installeer en probeer het direct:

**1. Marketplace toevoegen** (eenmalig):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Installeren**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Plugins herladen** (typ dit in Claude Code):

```
/mcp
```

Vraag dan aan Claude:

```text
/scout:search Ik zoek iets als Git blame maar dan voor ontwerpbeslissingen
```

scout zet dit vage concept om in de juiste term (ADR — Architecture Decision Records), doorzoekt meerdere zoekmachines met geoptimaliseerde queries, beoordeelt de bronkwaliteit en levert een antwoord met een Research Trail die precies laat zien hoe het tot het resultaat is gekomen.

## Wat scout doet

### Concepten vinden die je nog niet kunt benoemen

> "Ik weet dat het concept bestaat — iets over bijhouden waarom we elke ontwerpkeuze hebben gemaakt — maar ik ken de naam niet"

scout vertaalt vage ideeën naar precieze terminologie en bereikt de primaire bronnen.

### Door SEO-ruis heen snijden

> "Waarnaar moet ik echt migreren vanaf Terraform — niet de gesponsorde lijsten, echte migratieverhalen"

Vooronderzoek verwerft het juiste vocabulaire, waarna gerichte queries de contentfarms omzeilen.

### Officiële documentatie direct bereiken

> "Hoe stel ik middleware in bij Next.js App Router?"

scout controleert eerst [Context7](https://github.com/upstash/context7) op geïndexeerde officiële documentatie — als het antwoord daar staat, is geen webzoekopdracht nodig.

### Elke webpagina lezen

> "Haal https://docs.anthropic.com/en/docs/claude-code op en vat het samen"

Privacybewust ophalen: openbare pagina's gaan via cloud-API's, vertrouwelijke pagina's blijven op je machine.

## Configuratieniveaus

scout werkt direct na installatie. Elk niveau voegt mogelijkheden toe — allemaal optioneel, allemaal omkeerbaar.

### Niveau 1: Ingebouwde zoekopdracht (standaard)

Gebruikt de WebSearch van Claude Code. Geen configuratie nodig. Dit is wat je standaard krijgt.

### Niveau 2: Officiële documentatie + schoner ophalen

Voeg [Context7](https://github.com/upstash/context7) toe voor directe toegang tot documentatie van libraries en frameworks. Jina Reader verwijdert paginaruis, zodat minder tekst je context vult en je tokens bespaart. Werkt zonder sleutel (20 req/min); een gratis API-sleutel ontgrendelt 500 req/min.

### Niveau 3: Semantisch zoeken

[Exa](https://exa.ai) voor betekenisgebaseerd zoeken — vindt relevante pagina's zelfs als je de juiste trefwoorden niet kent. Standaard semantisch zoeken werkt met de gratis laag; een API-sleutel ontgrendelt geavanceerde functies.

### Niveau 4: Lokale browser

[Playwright](https://playwright.dev) voor met JavaScript gerenderde pagina's en vertrouwelijke URL's die je machine nooit mogen verlaten. Vereist het downloaden van Chromium (~200 MB).

**Voer `/scout:setup` uit om elk niveau interactief in te stellen.** Elke stap toont precies wat er aan je configuratie wordt toegevoegd voordat er wijzigingen worden aangebracht. Voer het op elk moment opnieuw uit om tools toe te voegen of bij te werken.

## Skills

| Skill | Doel |
|---|---|
| `/scout:search` | Multi-engine webzoekopdracht met queryontwerp, bronevaluatie en automatisch opnieuw zoeken |
| `/scout:fetch` | URL-inhoud ophalen met automatische privacyclassificatie |
| `/scout:setup` | Interactieve begeleide configuratie voor zoekmachines en ophaaltools |

### Research Trail

Elke zoekopdracht eindigt met een gestructureerd verslag dat laat zien hoe scout tot zijn antwoord is gekomen:

```
🔍 Research Trail
───────────────────────────────
Query:           je oorspronkelijke vraag
Designed queries: de geoptimaliseerde queries die scout daadwerkelijk heeft uitgevoerd
Sources:         URL's met betrouwbaarheidsniveau (🟢 primair / 🟡 secundair / ⚪ tertiair)
Re-searches:     eventuele aanvullende zoekopdrachten en hun redenen
Confidence:      High / Medium / Low met onderbouwing
```

## Privacy

scout classificeert URL's in drie niveaus voordat ze worden opgehaald:

| Classificatie | Routering | Voorbeelden |
|---|---|---|
| **Openbaar** | Cloud-API's (Jina Reader / WebFetch) | Blogs, documentatie, openbare GitHub-repo's |
| **Vertrouwelijk** | Alleen lokale Playwright | localhost, interne wiki's, beheerpanelen |
| **Geauthenticeerd** | Playwright CDP | Notion, Slack, post-OAuth-pagina's |

Deze classificatie is gebaseerd op het oordeel van het LLM, niet op technische handhaving. Beschouw het als best-effort routering. Controleer bij zeer gevoelige gegevens de classificatie voordat je verdergaat.

**Vertrouwelijke URL's worden nooit naar externe API's gestuurd, zelfs niet bij falen** — het systeem valt niet terug op cloudtools voor vertrouwelijke pagina's.

<details>
<summary>Chrome-debugmodus instellen (voor geauthenticeerde pagina's)</summary>

Om pagina's op te halen die inloggen vereisen (OAuth, SaaS-dashboards), start Chrome in debugmodus. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Opmerking over het browserprofiel</summary>

De op Playwright gebaseerde fetcher gebruikt een persistent browserprofiel (`tools/.chrome-profile/`) waar cookies en sessiegegevens zich kunnen ophopen. Deze map is uitgesloten van Git via `.gitignore`, maar kan door back-uptools worden gekopieerd. Verwijder deze periodiek als je vertrouwelijke pagina's ophaalt.
</details>

## Verwijderen

Twee commando's om alles te verwijderen. Geen restanten.

Plugin verwijderen (ruimt cache, configuratie en statusgegevens op):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Context7 verwijderen als het via scout:setup is toegevoegd (gebruikersbereik — verwijderd uit alle projecten):

```bash
claude mcp remove context7
```

## Vereisten

- **Claude Code** (vereist)
- `jq` (alleen voor configuratiediagnostiek)
- Python 3.10+ (alleen voor lokaal ophalen met Playwright)

## Beveiliging

API-sleutels worden opgeslagen in `.mcp.json` in de pluginmap.
**Commit `.mcp.json` niet naar Git.** Het sjabloon `.mcp.json.dist` is veilig om te distribueren.

## Disclaimer

Deze plugin wordt "zoals hij is" aangeboden onder de MIT-licentie, zonder enige garantie.

**Externe API's.** Deze plugin maakt gebruik van API's van derden (Exa, Jina AI en anderen). De auteur geeft geen garanties over de beschikbaarheid, nauwkeurigheid, prijsstelling of continuïteit van deze diensten en is niet verantwoordelijk voor kosten die voortvloeien uit API-gebruik.

**Beheer van API-sleutels.** Je bent als enige verantwoordelijk voor het verkrijgen, beveiligen en beheren van je eigen API-sleutels, en voor het naleven van de servicevoorwaarden van elke provider.

**Inhoudsclassificatie.** De privacyclassificatie van URL's is gebaseerd op het oordeel van het LLM en kan fouten bevatten. Vertrouw er niet op als enige beveiliging voor gevoelige informatie.

**Web ophalen & browserautomatisering.** Deze plugin bevat tools voor headless browserautomatisering via Playwright. Je bent verantwoordelijk om ervoor te zorgen dat je gebruik voldoet aan de servicevoorwaarden van de doelwebsites, hun robots.txt-beleid en de toepasselijke wetgeving.

**MCP-servers.** Deze plugin maakt verbinding met MCP-servers van derden. De auteur controleert, auditeert of garandeert het gedrag of de beveiliging van deze servers niet.

## Toeschrijvingen van derden

Er wordt geen broncode van derden herverspreid — integratie vindt plaats via MCP-verbindingen, runtime-pakketinstallaties en wrapper-scripts.

| Tool | Aanbieder | Licentie |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alle productnamen, logo's en handelsmerken zijn eigendom van hun respectieve houders.

## Taal

Configuratie-instructies worden door de AI-assistent in je taal aangeboden. Vertaalde README's zijn voor het gemak — **de originele Engelse versie is de officiële versie**.

## Ondersteuning

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Bugrapporten, functieverzoeken en vragen

## Auteur

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licentie

[MIT License](../LICENSE) — vrij te gebruiken, aan te passen en te verspreiden. Copyright (c) 2026 shidoyu.
