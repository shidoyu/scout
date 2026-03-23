🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇸🇦 [العربية](README.ar.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇵🇱 [Polski](README.pl.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇺🇦 [Українська](README.uk.md) · 🇹🇭 [ไทย](README.th.md) · 🇷🇺 [Русский](README.ru.md) · 🇳🇱 [**Nederlands**](README.nl.md)

> **Opmerking:** Deze vertaling is uitsluitend bedoeld voor het gemak. Het [Engelse origineel](../README.md) is de officiële versie.

# scout — Webzoeken & Inhoud Ophalen

De ingebouwde WebSearch van Claude Code retourneert fragmenten van 125 tekens en vertrouwt uitsluitend op trefwoordovereenkomst. scout vertaalt een vage vraag naar geoptimaliseerde zoekopdrachten voor meerdere zoekmachines, beoordeelt de kwaliteit van de resultaten en zoekt opnieuw wanneer dat nodig is — waarmee primaire bronnen sneller en betrouwbaarder worden bereikt.

## Functies

- **scout:search** — Webzoeken met meerdere zoekmachines en geoptimaliseerd zoekontwerp
- **scout:fetch** — URL-inhoud ophalen met privacybewuste toolselectie

## Installatie

Voer uit in je terminal:

```bash
claude plugin add shidoyu/scout
```

## Snel aan de slag

scout werkt direct na installatie — zoeken maakt gebruik van WebSearch (ingebouwd) en Exa (gratis, geen sleutel vereist). Optionele instelling voegt meer mogelijkheden toe:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Intelligente webzoekopdracht met:
- Vooronderzoek voor het verfijnen van zoekopdrachten
- Meertalig zoekontwerp
- Meerdere zoekmachines (WebSearch, [Exa](https://exa.ai) semantisch zoeken)
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) voor conceptuele zoekopdrachten via Exa
- Kwaliteitsbeoordeling met automatische herzoeklus

Gebruik: `/scout:search jouw vraag hier`

### scout:fetch

Webpagina-inhoud ophalen met automatische privacyclassificatie:
- **Openbare pagina's** → Jina Reader (API-sleutel vereist) / WebFetch (ingebouwde fallback)
- **Vertrouwelijke pagina's** → Lokale Playwright (geen externe API-aanroepen)
- **Geverifieerde pagina's** → Chrome DevTools (browsersessie)

Gebruik: `/scout:fetch URL`

## Instelling (Optioneel)

Voer `tools/setup.sh` uit om het volgende in te stellen:

1. **Exa** — Geavanceerde AI-native zoektools (API-sleutel voor betaalde functies; gratis tier werkt zonder instelling)
2. **Jina Reader** — Webpagina's van hoge kwaliteit ophalen als Markdown (API-sleutel vereist; zonder sleutel vallen openbare pagina's terug op WebFetch)
3. **Playwright** — Op browser gebaseerd ophalen voor door JavaScript gerenderde en vertrouwelijke pagina's (~200 MB download)

Alle stappen zijn overgeslagen. Voer het script opnieuw uit om instellingen bij te werken.
Na de instelling moet Claude Code opnieuw worden opgestart (of voer `/mcp` uit) zodat nieuwe MCP-servers van kracht worden.

## Privacy

scout classificeert URL's in drie niveaus voordat inhoud wordt opgehaald:
- **Openbaar** → Cloud-API's (Jina Reader / WebFetch)
- **Vertrouwelijk** → Alleen lokale Playwright (bedoelde routering: vertrouwelijke URL's worden niet naar externe API's verzonden)
- **Geverifieerd** → Chrome DevTools (maakt gebruik van uw browsersessie)

Deze classificatie is automatisch maar gebaseerd op LLM-oordeel, niet op systeemhandhaving. Zie [Privacyvoorbehoud](#privacyvoorbehoud) voor details.

## Vereisten

- Claude Code
- `jq` (alleen voor het installatiesscript)
- `npm`/`npx` (voor [MCP](https://modelcontextprotocol.io/) server: chrome-devtools)
- Python 3.10+ (optioneel, voor lokaal ophalen via Playwright)
- `uvx` of `uv` (optioneel, voor MCP-server: markitdown — HTML→Markdown-conversie)
- Chrome (optioneel, voor het ophalen van geverifieerde pagina's via DevTools)

### Chrome DevTools-instelling (voor geverifieerde pagina's)

Om pagina's op te halen waarvoor inloggen vereist is (OAuth, SaaS-dashboards), moet Chrome worden uitgevoerd in foutopsporingsmodus:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Privacyvoorbehoud

scout classificeert URL's op gevoeligheid en routeert vertrouwelijke URL's naar uitsluitend lokale tools.
Deze classificatie is gebaseerd op LLM-oordeel (domeinpatronen en context) en is **geen door het systeem gehandhaafde garantie**.
Verifieer de classificatie voor zeer gevoelige gegevens voordat u verdergaat.

**Browserprofiel.** De op Playwright gebaseerde ophaalmodule (`fetch-page.py`) maakt gebruik van een persistent browserprofiel (`tools/.chrome-profile/`) dat cookies, sessiegegevens en browsegeschiedenis kan accumuleren. Deze map is uitgesloten van Git via `.gitignore`, maar kan worden gekopieerd door back-uptools of cloudopslagdiensten. Verwijder de map regelmatig als u vertrouwelijke pagina's ophaalt.

## Taal

Installatie-instructies worden in uw taal verstrekt door de AI-assistent.
Vertaalde instructies zijn uitsluitend bedoeld voor het gemak — **het Engelse origineel is gezaghebbend**.

## Beveiligingsopmerking

Na het uitvoeren van `setup.sh` worden API-sleutels opgeslagen in `.mcp.json`.
**Commit `.mcp.json` niet naar Git.** Gebruik `.mcp.json.dist` als sjabloon voor distributie.

## Disclaimer

Deze plugin wordt geleverd "zoals hij is" onder de MIT-licentie, zonder enige garantie.

**Externe API's.** Deze plugin is afhankelijk van API's van derden (Exa, Jina AI en anderen). De auteur geeft geen garanties over de beschikbaarheid, nauwkeurigheid, prijsstelling of continuïteit van deze diensten en is niet verantwoordelijk voor kosten die voortvloeien uit API-gebruik.

**API-sleutelbeheer.** U bent als enige verantwoordelijk voor het verkrijgen, beveiligen en beheren van uw eigen API-sleutels en voor de naleving van de servicevoorwaarden van elke aanbieder.

**Inhoudsclassificatie.** Bij het ophalen van webinhoud kan de plugin LLM-gebaseerde classificatie gebruiken om de privacygevoeligheid te beoordelen en geschikte ophaalmethoden te bepalen. Dergelijke classificaties zijn gebaseerd op beste inspanning en kunnen fouten bevatten. Vertrouw niet uitsluitend op automatische classificatie als bescherming voor gevoelige of vertrouwelijke informatie.

**Webophalen & browserautomatisering.** Deze plugin bevat tools voor headless browserautomatisering via Playwright en Chrome DevTools. U bent verantwoordelijk voor het waarborgen dat uw gebruik voldoet aan de servicevoorwaarden, robots.txt-beleid en toepasselijke wetgeving van doelwebsites. De auteur is niet aansprakelijk voor siteblokkering, accountopschorting, IP-beperkingen, onverwachte scriptuitvoering, resourceverbruik of compatibiliteitsproblemen als gevolg van browserautomatisering.

**MCP-servers.** Deze plugin maakt verbinding met MCP (Model Context Protocol)-servers van derden. De auteur heeft geen controle over, auditeert niet en garandeert niet het gedrag of de beveiliging van deze servers.

## Attributies van derden

Deze plugin integreert met de volgende externe tools en diensten. Er wordt geen broncode van derden gedistribueerd — integratie verloopt via MCP-serververbindingen, runtime-pakketinstallatie en wrappersscripts van de pluginontwikkelaar.

| Tool | Aanbieder | Licentie |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API-voorwaarden) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alle productnamen, logo's en handelsmerken zijn eigendom van hun respectieve eigenaren. Deze plugin is niet gelieerd aan of goedgekeurd door een van de bovengenoemde diensten van derden.

## Ondersteuning

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Bugrapporten, functieverzoeken en vragen

## Auteur

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licentie

[MIT-licentie](../LICENSE) — vrij te gebruiken, aan te passen en te distribueren. Copyright (c) 2026 shidoyu.

