🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇸🇦 [العربية](README.ar.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇵🇱 [Polski](README.pl.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇺🇦 [Українська](README.uk.md) · 🇹🇭 [ไทย](README.th.md) · 🇷🇺 [Русский](README.ru.md) · 🇮🇹 [**Italiano**](README.it.md)

> **Nota:** Questa traduzione è fornita solo per comodità. L'[originale in inglese](../README.md) è la versione ufficiale.


# scout

**Wrong search, wrong decision.**

> Prima pensare, poi cercare. — Plugin di ricerca web per Claude Code.

Progettazione query, ricerca multi-motore, recupero rispettoso della privacy.

La WebSearch integrata di Claude Code restituisce solo snippet di 125 caratteri e si basa esclusivamente sulla corrispondenza di parole chiave. scout trasforma una domanda vaga in query ottimizzate per più motori, valuta la qualità dei risultati e ripete la ricerca quando serve, raggiungendo le fonti primarie più rapidamente e con maggiore affidabilità.

## Funzionalità

- **scout:search** — Ricerca web multi-motore con ottimizzazione del design delle query
- **scout:fetch** — Recupero di contenuti da URL con selezione degli strumenti attenta alla privacy

## Installazione

Esegui nel terminale:

```bash
# Passaggio 1: Registrare il marketplace
claude plugin marketplace add shidoyu/scout
```

```bash
# Passaggio 2: Installare il plugin
claude plugin install scout@shidoyu-scout
```

**Passaggio 3** — Configurare i motori di ricerca e gli strumenti di recupero

Esegui questi comandi uno alla volta in Claude Code:

```text
/reload-plugins
```

```text
/scout:setup
```

scout:setup ti guida interattivamente nella configurazione di Context7 (documentazione librerie), Jina Reader (recupero di pagine web), Exa (ricerca semantica) e Playwright (pagine renderizzate con JavaScript). Tutti i passaggi sono opzionali e possono essere saltati.

> **Nota:** Se salti questo passaggio, scout ti chiederà la configurazione al prossimo avvio di sessione. La ricerca di base funziona immediatamente senza configurazione.

## Avvio rapido

Dopo l'installazione, chiedi a Claude (nessuna configurazione necessaria — la ricerca di base funziona immediatamente):

### Provalo subito

**Trova concetti che non sai ancora nominare:**
> "quel meccanismo dove il programma reagisce automaticamente quando un dato cambia senza dover controllare continuamente"

**Scopri gli equivalenti internazionali di concetti italiani:**
> "come funziona la fatturazione elettronica italiana (SDI) rispetto ai sistemi di fatturazione di altri paesi?"

**Ottieni risposte da esperto da domande semplici:**
> "il mio sito è lentissimo sulla prima visita ma poi va bene"

**Leggi una pagina specifica:**
> "leggi https://tailwindcss.com/docs/configuration"

## Skills

### scout:search

Ricerca web intelligente con:
- Pre-ricerca per il raffinamento delle query
- Design di query multilingua
- Più motori di ricerca (WebSearch, [Context7](https://github.com/upstash/context7) documentazione ufficiale, ricerca semantica [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) per query concettuali tramite Exa
- Valutazione della qualità con loop di ri-ricerca automatico

Utilizzo: `/scout:search la tua domanda qui`

### scout:fetch

Recupera il contenuto di pagine web con classificazione automatica della privacy:
- **Pagine pubbliche** → Jina Reader / WebFetch (fallback integrato)
- **Pagine riservate** → Playwright locale (nessuna chiamata a API esterne)
- **Pagine autenticate** → Chrome DevTools (sessione del browser)

Utilizzo: `/scout:fetch URL`

### scout:setup

Configurazione interattiva guidata per motori di ricerca e strumenti di recupero:
- **Context7** — Percorso diretto alla documentazione ufficiale aggiornata di librerie e framework, così le domande tecniche arrivano prima alle fonti tramite [Context7 MCP](https://github.com/upstash/context7) (nessuna API key necessaria)
- **Jina Reader** — Recupero più pulito delle pagine web in Markdown, che rimuove navigazione e contenuto ripetitivo, così spesso arriva meno testo al modello e si risparmiano token ([API key gratuita](https://jina.ai/?newKey))
- **Exa** — Ricerca basata sul significato per query vaghe, concettuali e di nicchia quando i termini esatti non sono chiari ([API key](https://exa.ai))
- **Playwright** — Recupero locale via browser per pagine renderizzate in JavaScript o pagine riservate che devono restare sulla tua macchina (~200MB di download)

Tutti i passaggi sono opzionali. Riesegui in qualsiasi momento per aggiornare le impostazioni.

Utilizzo: `/scout:setup`

## Privacy

scout classifica gli URL in tre livelli prima del recupero:
- **Pubblico** → API cloud (Jina Reader / WebFetch)
- **Riservato** → Solo Playwright locale (instradamento previsto: gli URL riservati non vengono inviati ad API esterne)
- **Autenticato** → Chrome DevTools (utilizza la sessione del tuo browser)

Questa classificazione è automatica ma basata sul giudizio del LLM, non su meccanismi di sistema. Consulta la sezione [Avvertenza sulla privacy](#avvertenza-sulla-privacy) per i dettagli.

## Requisiti

- Claude Code
- `jq` (solo per la configurazione)
- `npm`/`npx` (per il server [MCP](https://modelcontextprotocol.io/): chrome-devtools)
- Python 3.10+ (opzionale, per il recupero locale tramite Playwright)
- `uvx` o `uv` (opzionale, per il server MCP: markitdown — conversione HTML→Markdown)
- Chrome (opzionale, per il recupero di pagine autenticate tramite DevTools)

### Configurazione di Chrome DevTools (per pagine autenticate)

Per recuperare pagine che richiedono il login (OAuth, dashboard SaaS), Chrome deve essere avviato in modalità debug:

Su macOS:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

Su Linux:

```bash
google-chrome --remote-debugging-port=9222
```

## Avvertenza sulla privacy

scout classifica gli URL in base alla sensibilità e instrada gli URL riservati verso strumenti esclusivamente locali.
Questa classificazione si basa sul giudizio del LLM (pattern di dominio e contesto) e **non è una garanzia applicata dal sistema**.
Per dati altamente sensibili, verifica la classificazione prima di procedere.

**Profilo del browser.** Il fetcher basato su Playwright (`fetch-page.py`) utilizza un profilo del browser persistente (`tools/.chrome-profile/`) che può accumulare cookie, dati di sessione e cronologia di navigazione. Questa directory è esclusa da Git tramite `.gitignore`, ma potrebbe essere copiata da strumenti di backup o servizi di sincronizzazione cloud. Elimina periodicamente la directory se recuperi pagine riservate.

## Lingua

Le istruzioni di configurazione vengono fornite nella tua lingua dall'assistente AI.
Le istruzioni tradotte sono fornite solo per comodità — **l'originale in inglese è autorevole**.

## Nota sulla sicurezza

Dopo la configurazione, le API key vengono memorizzate in `.mcp.json`.
**Non eseguire il commit di `.mcp.json` su Git.** Usa `.mcp.json.dist` come template per la distribuzione.

## Dichiarazione di non responsabilità

Questo plugin è fornito "così com'è" sotto la licenza MIT, senza garanzie di alcun tipo.

**API esterne.** Questo plugin si affida ad API di terze parti (Exa, Jina AI e altre). L'autore non fornisce garanzie sulla disponibilità, accuratezza, prezzi o continuità di questi servizi e non è responsabile dei costi sostenuti tramite l'utilizzo delle API.

**Gestione delle API key.** Sei l'unico responsabile dell'ottenimento, della protezione e della gestione delle tue API key, nonché del rispetto dei termini di servizio di ciascun provider.

**Classificazione dei contenuti.** Durante il recupero di contenuti web, il plugin potrebbe utilizzare la classificazione basata su LLM per valutare la sensibilità della privacy e determinare i metodi di recupero appropriati. Tali classificazioni sono best-effort e possono contenere errori. Non fare affidamento sulla classificazione automatica come unica misura di protezione per informazioni sensibili o riservate.

**Recupero web e automazione del browser.** Questo plugin include strumenti per l'automazione headless del browser tramite Playwright e Chrome DevTools. Sei responsabile di garantire che il tuo utilizzo sia conforme ai termini di servizio dei siti web di destinazione, alle politiche robots.txt e alle leggi applicabili. L'autore non è responsabile per blocchi del sito, sospensioni dell'account, restrizioni IP, esecuzione imprevista di script, consumo di risorse o problemi di compatibilità derivanti dall'automazione del browser.

**Server MCP.** Questo plugin si connette a server MCP (Model Context Protocol) di terze parti. L'autore non controlla, non verifica né garantisce il comportamento o la sicurezza di questi server.

## Attribuzioni di terze parti

Questo plugin si integra con i seguenti strumenti e servizi esterni. Nessun codice sorgente di terze parti viene ridistribuito — l'integrazione avviene tramite connessioni a server MCP, installazione di pacchetti a runtime e script wrapper scritti dallo sviluppatore del plugin.

| Strumento | Provider | Licenza |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietaria (termini API) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tutti i nomi di prodotti, loghi e marchi registrati sono di proprietà dei rispettivi titolari. Questo plugin non è affiliato né approvato da nessuno dei servizi di terze parti elencati sopra.

## Supporto

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Segnalazioni di bug, richieste di funzionalità e domande

## Autore

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licenza

[MIT License](../LICENSE) — libero di usare, modificare e distribuire. Copyright (c) 2026 shidoyu.

