🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 **Deutsch** · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **Hinweis:** Diese Übersetzung dient nur der Bequemlichkeit. Das [englische Original](../README.md) ist die offizielle Version.

# scout — Websuche & Inhaltabruf

Die in Claude Code integrierte WebSearch liefert lediglich 125-Zeichen-Ausschnitte und basiert ausschließlich auf Keyword-Matching. scout wandelt eine vage Frage in optimierte Multi-Engine-Abfragen um, bewertet die Qualität der Ergebnisse und führt bei Bedarf erneute Suchen durch — so gelangt es schneller und zuverlässiger zu primären Quellen.

## Funktionen

- **scout:search** — Multi-Engine-Websuche mit optimiertem Query-Design
- **scout:fetch** — URL-Inhaltsabruf mit datenschutzbewusster Tool-Auswahl

## Installation

```bash
claude plugin add shidoyu/scout
```

## Schnellstart

scout funktioniert sofort nach der Installation — die Suche verwendet WebSearch (integriert) und Exa (kostenlos, kein API-Schlüssel erforderlich). Optionales Setup erschließt weitere Funktionen:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Intelligente Websuche mit:
- Vorrecherche zur Query-Verfeinerung
- Mehrsprachigem Query-Design
- Mehreren Suchmaschinen (WebSearch, semantische Suche via [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) für konzeptuelle Abfragen über Exa
- Qualitätsbewertung mit automatischer Nachsuch-Schleife

Verwendung: `/scout:search Ihre Frage hier`

### scout:fetch

Webseiteninhalt abrufen mit automatischer Datenschutzklassifizierung:
- **Öffentliche Seiten** → Jina Reader (API-Schlüssel erforderlich) / WebFetch (integrierter Fallback)
- **Vertrauliche Seiten** → Lokales Playwright (keine externen API-Aufrufe)
- **Authentifizierte Seiten** → Chrome DevTools (Browser-Sitzung)

Verwendung: `/scout:fetch URL`

## Setup (Optional)

`tools/setup.sh` ausführen, um Folgendes zu konfigurieren:

1. **Exa** — Erweiterte KI-native Suchwerkzeuge (API-Schlüssel für kostenpflichtige Funktionen; der kostenlose Tarif funktioniert ohne Setup)
2. **Jina Reader** — Hochwertiger Webseiteninhalt als Markdown (API-Schlüssel erforderlich; ohne ihn greifen öffentliche Seiten auf WebFetch zurück)
3. **Playwright** — Browserbasierter Abruf für JavaScript-gerenderte und vertrauliche Seiten (~200 MB Download)

Alle Schritte können übersprungen werden. Das Skript kann jederzeit erneut ausgeführt werden, um Einstellungen zu aktualisieren.
Nach dem Setup Claude Code neu starten (oder `/mcp` ausführen), damit neue MCP-Server wirksam werden.

## Datenschutz

scout klassifiziert URLs vor dem Abruf in drei Stufen:
- **Öffentlich** → Cloud-APIs (Jina Reader / WebFetch)
- **Vertraulich** → Ausschließlich lokales Playwright (vertrauliche URLs werden nicht an externe APIs gesendet)
- **Authentifiziert** → Chrome DevTools (verwendet Ihre Browser-Sitzung)

Diese Klassifizierung erfolgt automatisch, basiert jedoch auf der Einschätzung des LLMs, nicht auf systemseitiger Durchsetzung. Einzelheiten finden Sie im [Datenschutzhinweis](#datenschutzhinweis).

## Voraussetzungen

- Claude Code
- `jq` (nur für das Setup-Skript)
- `npm`/`npx` (für den [MCP](https://modelcontextprotocol.io/)-Server: chrome-devtools)
- Python 3.10+ (optional, für lokalen Playwright-Abruf)
- `uvx` oder `uv` (optional, für den MCP-Server: markitdown — HTML→Markdown-Konvertierung)
- Chrome (optional, für den Abruf authentifizierter Seiten via DevTools)

### Chrome DevTools-Setup (für authentifizierte Seiten)

Um Seiten abzurufen, die eine Anmeldung erfordern (OAuth, SaaS-Dashboards), muss Chrome im Debug-Modus gestartet sein:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Datenschutzhinweis

scout klassifiziert URLs nach ihrer Sensitivität und leitet vertrauliche URLs ausschließlich an lokale Tools weiter.
Diese Klassifizierung basiert auf der Einschätzung des LLMs (Domain-Muster und Kontext) und ist **keine systemseitig erzwungene Garantie**.
Bei hochsensiblen Daten sollte die Klassifizierung vor dem Fortfahren überprüft werden.

**Browser-Profil.** Der Playwright-basierte Abrufer (`fetch-page.py`) verwendet ein persistentes Browser-Profil (`tools/.chrome-profile/`), in dem sich Cookies, Sitzungsdaten und der Browserverlauf ansammeln können. Dieses Verzeichnis ist über `.gitignore` aus Git ausgeschlossen, kann jedoch von Backup-Tools oder Cloud-Synchronisierungsdiensten kopiert werden. Das Verzeichnis sollte regelmäßig gelöscht werden, wenn vertrauliche Seiten abgerufen werden.

## Sprache

Setup-Anweisungen werden vom KI-Assistenten in Ihrer Sprache bereitgestellt.
Übersetzte Anweisungen dienen nur der Bequemlichkeit — **das englische Original ist maßgebend**.

## Sicherheitshinweis

Nach dem Ausführen von `setup.sh` werden API-Schlüssel in `.mcp.json` gespeichert.
**`.mcp.json` nicht in Git committen.** Verwenden Sie `.mcp.json.dist` als Vorlage für die Weitergabe.

## Haftungsausschluss

Dieses Plugin wird „so wie es ist" unter der MIT-Lizenz bereitgestellt, ohne jegliche Gewährleistung.

**Externe APIs.** Dieses Plugin stützt sich auf Drittanbieter-APIs (Exa, Jina AI und andere). Der Autor übernimmt keine Garantie für die Verfügbarkeit, Genauigkeit, Preisgestaltung oder Kontinuität dieser Dienste und haftet nicht für Kosten, die durch die API-Nutzung entstehen.

**API-Schlüssel-Verwaltung.** Sie sind allein verantwortlich für die Beschaffung, Sicherung und Verwaltung Ihrer eigenen API-Schlüssel sowie für die Einhaltung der Nutzungsbedingungen jedes Anbieters.

**Inhaltsklassifizierung.** Beim Abruf von Webinhalten kann das Plugin LLM-basierte Klassifizierung einsetzen, um die Datenschutz-Sensitivität zu bewerten und geeignete Abrufmethoden zu bestimmen. Solche Klassifizierungen erfolgen nach bestem Bemühen und können Fehler enthalten. Verlassen Sie sich bei sensiblen oder vertraulichen Informationen nicht allein auf die automatische Klassifizierung.

**Web-Abruf & Browser-Automatisierung.** Dieses Plugin enthält Tools zur kopflosen Browser-Automatisierung via Playwright und Chrome DevTools. Sie sind dafür verantwortlich, dass Ihre Nutzung den Nutzungsbedingungen der Zielwebseiten, den robots.txt-Richtlinien und den geltenden Gesetzen entspricht. Der Autor haftet nicht für Website-Sperrungen, Kontosperrungen, IP-Einschränkungen, unerwartete Skriptausführung, Ressourcenverbrauch oder Kompatibilitätsprobleme, die durch Browser-Automatisierung entstehen.

**MCP-Server.** Dieses Plugin stellt Verbindungen zu MCP-Servern (Model Context Protocol) von Drittanbietern her. Der Autor kontrolliert, prüft oder garantiert weder das Verhalten noch die Sicherheit dieser Server.

## Drittanbieter-Attributionen

Dieses Plugin ist mit den folgenden externen Tools und Diensten integriert. Es wird kein Quellcode von Drittanbietern neu verteilt — die Integration erfolgt über MCP-Server-Verbindungen, Laufzeit-Paketinstallation und vom Plugin-Entwickler erstellte Wrapper-Skripte.

| Tool | Anbieter | Lizenz |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietär (API-Bedingungen) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alle Produktnamen, Logos und Markenzeichen sind Eigentum ihrer jeweiligen Inhaber. Dieses Plugin ist weder mit einem der oben genannten Drittanbieter-Dienste verbunden noch von diesen unterstützt.

## Support

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Fehlermeldungen, Feature-Anfragen und Fragen

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Lizenz

[MIT License](../LICENSE) — kostenlos nutzbar, veränderbar und weitergabe. Copyright (c) 2026 shidoyu.

