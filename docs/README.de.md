🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 **Deutsch** · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Hinweis:** Diese Übersetzung dient der besseren Zugänglichkeit. Das [englische Original](../README.md) ist die maßgebliche Version.

<p align="center">
  <img src="assets/hero.png" alt="scout — Erst denken. Dann suchen." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Web-Recherche-Plugin für <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Verwandelt vage Fragen in optimierte Multi-Engine-Abfragen, die Primärquellen erreichen.
</p>

<p align="center">
  <strong>Erst denken. Dann suchen.</strong>
</p>

---

Die integrierte WebSearch von Claude Code liefert Snippets mit 125 Zeichen und basiert ausschließlich auf Keyword-Matching. Für einfache Nachschlagearbeiten reicht das — aber für echte Recherche braucht man Abfragedesign, Quellenbewertung und datenschutzbewusstes Routing.

scout denkt, bevor es sucht.

## Schnellstart

Keine API-Schlüssel nötig. Keine Umgebungsänderungen. Installieren und sofort ausprobieren:

**1. Marketplace hinzufügen** (einmalig):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Installieren**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Plugins neu laden** (in Claude Code eingeben):

```
/mcp
```

Dann fragen Sie Claude:

```text
/scout:search Ich suche etwas wie Git blame, aber für Designentscheidungen
```

scout wandelt dieses vage Konzept in den richtigen Fachbegriff um (ADR — Architecture Decision Records), durchsucht mehrere Suchmaschinen mit optimierten Abfragen, bewertet die Quellenqualität und liefert eine Antwort mit einem Research Trail, der genau zeigt, wie das Ergebnis zustande kam.

## Was scout leistet

### Konzepte finden, die man noch nicht benennen kann

> „Ich weiß, dass es dieses Konzept gibt — etwas darüber, warum wir jede Designentscheidung getroffen haben — aber ich kenne den Namen nicht"

scout übersetzt unscharfe Ideen in präzise Fachbegriffe und erreicht die Primärquellen.

### SEO-Rauschen durchbrechen

> „Wohin sollte ich wirklich von Terraform migrieren — nicht die gesponserten Listen, sondern echte Migrationsberichte"

Durch Vorrecherche wird das richtige Vokabular ermittelt, dann umgehen gezielte Abfragen die Content-Farmen.

### Offizielle Dokumentation direkt erreichen

> „Wie richte ich Middleware in Next.js App Router ein?"

scout prüft zuerst [Context7](https://github.com/upstash/context7) auf indexierte offizielle Dokumentation — wenn die Antwort dort liegt, ist keine Websuche nötig.

### Beliebige Webseiten lesen

> „Rufe https://docs.anthropic.com/en/docs/claude-code ab und fasse es zusammen"

Datenschutzbewusstes Abrufen: Öffentliche Seiten gehen über Cloud-APIs, vertrauliche Seiten bleiben auf Ihrem Rechner.

## Setup-Stufen

scout funktioniert sofort nach der Installation. Jede Stufe erweitert die Möglichkeiten — alle optional, alle rückgängig machbar.

### Stufe 1: Integrierte Suche (Standard)

Nutzt Claude Codes WebSearch. Keine Konfiguration nötig. Das ist der Ausgangszustand.

### Stufe 2: Offizielle Dokumentation + saubereres Abrufen

Füge [Context7](https://github.com/upstash/context7) für direkten Zugriff auf Bibliotheks- und Framework-Dokumentation hinzu. Die Bereinigung überflüssiger Inhalte durch Jina Reader ist bereits integriert — keine Einrichtung nötig. Seitenrauschen wird automatisch entfernt, sodass weniger Text den Kontext belegt.

### Stufe 3: Semantische Suche

[Exa](https://exa.ai) für bedeutungsbasierte Suche — findet relevante Seiten, auch wenn Sie die richtigen Schlüsselwörter nicht kennen. Grundlegende semantische Suche funktioniert mit dem kostenlosen Kontingent; ein API-Schlüssel schaltet erweiterte Funktionen frei.

### Stufe 4: Lokaler Browser

[Playwright](https://playwright.dev) für JavaScript-gerenderte Seiten und vertrauliche URLs, die Ihren Rechner nie verlassen sollten. Erfordert den Download von Chromium (~200 MB).

**Führen Sie `/scout:setup` aus, um jede Stufe interaktiv einzurichten.** Vor jeder Änderung wird genau angezeigt, was zu Ihrer Konfiguration hinzugefügt wird. Jederzeit erneut ausführbar, um Tools hinzuzufügen oder zu aktualisieren.

## Skills

| Skill | Zweck |
|---|---|
| `/scout:search` | Multi-Engine-Websuche mit Abfragedesign, Quellenbewertung und automatischer Nachsuche |
| `/scout:fetch` | URL-Inhaltsabruf mit automatischer Datenschutzklassifizierung |
| `/scout:setup` | Interaktive Einrichtung für Suchmaschinen und Abruf-Tools |

### Research Trail

Jede Suche endet mit einem strukturierten Protokoll, das zeigt, wie scout zu seiner Antwort gelangt ist:

```
🔍 Research Trail
───────────────────────────────
Query:           Ihre ursprüngliche Frage
Designed queries: die optimierten Abfragen, die scout tatsächlich ausgeführt hat
Sources:         URLs mit Zuverlässigkeitsstufe (🟢 Primärquelle / 🟡 Sekundärquelle / ⚪ Tertiärquelle)
Re-searches:     etwaige Nachsuchen und deren Begründung
Confidence:      High / Medium / Low mit Begründung
```

## Datenschutz

scout klassifiziert URLs vor dem Abruf in drei Stufen:

| Klassifizierung | Routing | Beispiele |
|---|---|---|
| **Öffentlich** | Cloud-APIs (Jina Reader / WebFetch) | Blogs, Dokumentation, öffentliche GitHub-Repos |
| **Vertraulich** | Nur lokaler Playwright | localhost, interne Wikis, Admin-Panels |
| **Authentifiziert** | Playwright CDP | Notion, Slack, Post-OAuth-Seiten |

Diese Klassifizierung basiert auf der Einschätzung des LLM, nicht auf technischer Durchsetzung. Betrachten Sie es als Best-Effort-Routing. Bei hochsensiblen Daten sollten Sie die Klassifizierung vor der Verarbeitung überprüfen.

**Vertrauliche URLs werden niemals an externe APIs gesendet, auch nicht bei Fehlschlägen** — das System greift bei vertraulichen Seiten nicht auf Cloud-Tools zurück.

<details>
<summary>Chrome-Debugmodus einrichten (für authentifizierte Seiten)</summary>

Um Seiten abzurufen, die eine Anmeldung erfordern (OAuth, SaaS-Dashboards), starten Sie Chrome im Debug-Modus. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Hinweis zum Browserprofil</summary>

Der Playwright-basierte Fetcher verwendet ein persistentes Browserprofil (`tools/.chrome-profile/`), in dem sich Cookies und Sitzungsdaten ansammeln können. Dieses Verzeichnis ist über `.gitignore` von Git ausgeschlossen, kann aber von Backup-Tools kopiert werden. Löschen Sie es regelmäßig, wenn Sie vertrauliche Seiten abrufen.
</details>

## Deinstallation

Zwei Befehle entfernen alles. Keine Rückstände.

Plugin entfernen (bereinigt Cache, Konfiguration und Zustandsdaten):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Context7 entfernen, falls über scout:setup hinzugefügt (benutzerbezogen — wird aus allen Projekten entfernt):

```bash
claude mcp remove context7
```

## Voraussetzungen

- **Claude Code** (erforderlich)
- `jq` (nur für Setup-Diagnose)
- Python 3.10+ (nur für lokales Abrufen mit Playwright)

## Sicherheit

API-Schlüssel werden in `.mcp.json` im Plugin-Verzeichnis gespeichert.
**Committen Sie `.mcp.json` nicht in Git.** Die Vorlage `.mcp.json.dist` kann sicher verteilt werden.

## Haftungsausschluss

Dieses Plugin wird unter der MIT-Lizenz „wie besehen" bereitgestellt, ohne jegliche Gewährleistung.

**Externe APIs.** Dieses Plugin nutzt APIs von Drittanbietern (Exa, Jina AI und andere). Der Autor übernimmt keine Garantie für die Verfügbarkeit, Genauigkeit, Preisgestaltung oder Kontinuität dieser Dienste und ist nicht verantwortlich für Kosten, die durch die API-Nutzung entstehen.

**API-Schlüssel-Verwaltung.** Sie sind allein verantwortlich für die Beschaffung, Sicherung und Verwaltung Ihrer eigenen API-Schlüssel sowie für die Einhaltung der Nutzungsbedingungen der jeweiligen Anbieter.

**Inhaltsklassifizierung.** Die Datenschutzklassifizierung von URLs basiert auf der Einschätzung des LLM und kann Fehler enthalten. Verlassen Sie sich nicht darauf als einzige Schutzmaßnahme für sensible Informationen.

**Web-Abruf & Browser-Automatisierung.** Dieses Plugin enthält Tools für die Headless-Browser-Automatisierung über Playwright. Sie sind dafür verantwortlich sicherzustellen, dass Ihre Nutzung den Nutzungsbedingungen der Zielwebsites, deren robots.txt-Richtlinien und geltenden Gesetzen entspricht.

**MCP Server.** Dieses Plugin verbindet sich mit MCP-Servern von Drittanbietern. Der Autor kontrolliert, prüft und garantiert weder das Verhalten noch die Sicherheit dieser Server.

## Zuordnung von Drittanbietern

Es wird kein Quellcode von Drittanbietern weiterverteilt — die Integration erfolgt über MCP-Verbindungen, Laufzeit-Paketinstallationen und Wrapper-Skripte.

| Tool | Anbieter | Lizenz |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Alle Produktnamen, Logos und Marken sind Eigentum ihrer jeweiligen Inhaber.

## Sprache

Die Einrichtungsanweisungen werden vom KI-Assistenten in Ihrer Sprache bereitgestellt. Übersetzte READMEs dienen der besseren Zugänglichkeit — **das englische Original ist maßgeblich**.

## Support

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Fehlermeldungen, Funktionswünsche und Fragen

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Lizenz

[MIT License](../LICENSE) — frei nutzbar, modifizierbar und verteilbar. Copyright (c) 2026 shidoyu.
