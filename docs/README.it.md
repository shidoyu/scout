🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 **Italiano** · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Nota:** Questa traduzione è fornita per comodità. La versione ufficiale è l'[originale in inglese](../README.md).

<p align="center">
  <img src="assets/hero.png" alt="scout — Prima pensa. Poi cerca." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Plugin di ricerca web per <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Trasforma domande vaghe in query multi-motore ottimizzate che raggiungono le fonti primarie.
</p>

<p align="center">
  <strong>Prima pensa. Poi cerca.</strong>
</p>

---

La WebSearch integrata di Claude Code restituisce snippet di 125 caratteri e si basa solo sulla corrispondenza di parole chiave. Per ricerche semplici è sufficiente, ma per una ricerca seria servono progettazione delle query, valutazione delle fonti e routing rispettoso della privacy.

scout pensa prima di cercare.

## Avvio Rapido

Nessuna API key richiesta. Nessuna modifica all'ambiente. Installa e prova subito:

**1. Aggiungi il marketplace** (una sola volta):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Installa**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Ricarica i plugin** (digita all'interno di Claude Code):

```
/mcp
```

Poi chiedi a Claude:

```text
/scout:search Voglio qualcosa come Git blame ma per le decisioni di design
```

scout riformulerà questa idea vaga nel termine corretto (ADR — Architecture Decision Records), eseguirà query ottimizzate su più motori, valuterà la qualità delle fonti e restituirà una risposta con un Research Trail che mostra esattamente come ci è arrivato.

## Cosa fa scout

### Trovare concetti che non sai ancora nominare

> "So che il concetto esiste — qualcosa sul tenere traccia del perché di ogni scelta di design — ma non so come si chiama"

scout traduce idee vaghe in terminologia precisa e raggiunge le fonti primarie.

### Superare il rumore SEO

> "Da cosa dovrei davvero migrare Terraform — non le liste sponsorizzate, storie di migrazione reali"

La pre-ricerca acquisisce il vocabolario giusto, poi query mirate aggirano le content farm.

### Raggiungere direttamente la documentazione ufficiale

> "Come configuro il middleware in Next.js App Router?"

scout controlla prima [Context7](https://github.com/upstash/context7) per la documentazione ufficiale indicizzata — zero ricerche web se la risposta è già lì.

### Leggere qualsiasi pagina web

> "Recupera e riassumi https://docs.anthropic.com/en/docs/claude-code"

Recupero rispettoso della privacy: le pagine pubbliche passano tramite API cloud, le pagine confidenziali restano sulla tua macchina.

## Livelli di Configurazione

scout funziona subito dopo l'installazione. Ogni livello aggiunge funzionalità — tutti opzionali, tutti reversibili.

### Livello 1: Ricerca Integrata (predefinito)

Usa la WebSearch di Claude Code. Nessuna configurazione necessaria. È quello che ottieni appena installato.

### Livello 2: Documentazione Ufficiale + Recupero Più Pulito

Aggiungi [Context7](https://github.com/upstash/context7) per accedere direttamente alla documentazione di librerie e framework, e [Jina Reader](https://jina.ai) per eliminare gli elementi superflui delle pagine e ridurre il rumore nel tuo contesto. Nessuno dei due richiede una API key — Jina funziona gratuitamente a 20 req/min senza quota.

### Livello 3: Ricerca Semantica

Aggiungi [Exa](https://exa.ai) per la ricerca basata sul significato — trova pagine pertinenti anche quando non conosci le parole chiave giuste. La ricerca semantica di base funziona con il piano gratuito; la API key sblocca funzionalità avanzate.

### Livello 4: Browser Locale

Aggiungi [Playwright](https://playwright.dev) per le pagine renderizzate con JavaScript e gli URL confidenziali che non devono mai lasciare la tua macchina. Richiede il download di Chromium (~200MB).

**Esegui `/scout:setup` per configurare ogni livello in modo interattivo.** Ogni passaggio mostra esattamente cosa verrà aggiunto alla tua configurazione prima di qualsiasi modifica. Riesegui in qualsiasi momento per aggiungere o aggiornare strumenti.

## Skill

| Skill | Scopo |
|---|---|
| `/scout:search` | Ricerca web multi-motore con progettazione query, valutazione fonti e ri-ricerca automatica |
| `/scout:fetch` | Recupero contenuti URL con classificazione automatica della privacy |
| `/scout:setup` | Configurazione guidata interattiva per motori di ricerca e strumenti di recupero |

### Research Trail

Ogni ricerca termina con un percorso strutturato che mostra come scout è arrivato alla risposta:

```
🔍 Research Trail
───────────────────────────────
Query:           la tua domanda originale
Designed queries: le query ottimizzate effettivamente eseguite da scout
Sources:         URL con livello di affidabilità (🟢 primaria / 🟡 secondaria / ⚪ terziaria)
Re-searches:     eventuali ricerche aggiuntive e perché
Confidence:      High / Medium / Low con motivazione
```

## Privacy

scout classifica gli URL in tre livelli prima del recupero:

| Classificazione | Routing | Esempi |
|---|---|---|
| **Pubblico** | API cloud (Jina Reader / WebFetch) | Blog, documentazione, repo GitHub pubblici |
| **Confidenziale** | Solo Playwright locale | localhost, wiki interne, pannelli di amministrazione |
| **Autenticato** | Playwright CDP | Notion, Slack, pagine post-OAuth |

Questa classificazione si basa sul giudizio del LLM, non su un'imposizione di sistema. Trattala come routing best-effort. Per dati altamente sensibili, verifica la classificazione prima di procedere.

**Gli URL confidenziali non vengono mai inviati ad API esterne, nemmeno in caso di errore** — il sistema non ricorre a strumenti cloud per le pagine confidenziali.

<details>
<summary>Configurazione modalità debug di Chrome (per pagine autenticate)</summary>

Per recuperare pagine che richiedono login (OAuth, dashboard SaaS), avvia Chrome in modalità debug. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Nota sul profilo del browser</summary>

Il fetcher basato su Playwright utilizza un profilo browser persistente (`tools/.chrome-profile/`) che potrebbe accumulare cookie e dati di sessione. Questa directory è esclusa da Git tramite `.gitignore` ma potrebbe essere copiata da strumenti di backup. Eliminala periodicamente se recuperi pagine confidenziali.
</details>

## Disinstallazione

Due comandi per rimuovere tutto. Nessun residuo.

Rimuovi il plugin (pulisce cache, configurazione e dati di stato):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Rimuovi Context7 se lo hai aggiunto tramite scout:setup (ambito utente — lo rimuove da tutti i progetti):

```bash
claude mcp remove context7
```

## Requisiti

- **Claude Code** (obbligatorio)
- `jq` (solo per la diagnostica del setup)
- Python 3.10+ (solo per il recupero locale con Playwright)

## Sicurezza

Le API key sono memorizzate in `.mcp.json` nella directory del plugin.
**Non fare commit di `.mcp.json` su Git.** Il template `.mcp.json.dist` è sicuro da distribuire.

## Disclaimer

Questo plugin è fornito "così com'è" sotto la Licenza MIT, senza alcuna garanzia.

**API esterne.** Questo plugin si basa su API di terze parti (Exa, Jina AI e altre). L'autore non fornisce garanzie sulla disponibilità, accuratezza, prezzi o continuità di questi servizi e non è responsabile dei costi sostenuti tramite l'uso delle API.

**Gestione delle API key.** L'ottenimento, la protezione e la gestione delle proprie API key, nonché il rispetto dei termini di servizio di ciascun provider, sono responsabilità dell'utente.

**Classificazione dei contenuti.** La classificazione della privacy degli URL si basa sul giudizio del LLM e potrebbe contenere errori. Non fare affidamento su di essa come unica protezione per informazioni sensibili.

**Web fetching e automazione del browser.** Questo plugin include strumenti per l'automazione headless del browser tramite Playwright. È responsabilità dell'utente verificare la conformità con i termini di servizio dei siti target, le policy robots.txt e le leggi applicabili.

**Server MCP.** Questo plugin si connette a server MCP di terze parti. L'autore non controlla, verifica o garantisce il comportamento o la sicurezza di questi server.

## Attribuzioni di Terze Parti

Nessun codice sorgente di terze parti viene ridistribuito — l'integrazione avviene tramite connessioni MCP, installazione di pacchetti a runtime e script wrapper.

| Strumento | Provider | Licenza |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tutti i nomi dei prodotti, i loghi e i marchi sono di proprietà dei rispettivi titolari.

## Lingua

Le istruzioni di configurazione vengono fornite nella tua lingua dall'assistente AI. Le traduzioni sono a scopo informativo — **l'originale in inglese è quello ufficiale**.

## Supporto

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Segnalazione bug, richieste di funzionalità e domande

## Autore

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licenza

[MIT License](../LICENSE) — libero di usare, modificare e distribuire. Copyright (c) 2026 shidoyu.
