🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 **Čeština** · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Upozornění:** Tento překlad je poskytován pouze pro usnadnění. Oficiální verzí je [anglický originál](../README.md).

<p align="center">
  <img src="assets/hero.png" alt="scout — Nejdřív přemýšlej. Pak hledej." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Plugin pro webový výzkum pro <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Přemění vágní otázky na optimalizované vícemotorové dotazy, které se dostanou k primárním zdrojům.
</p>

<p align="center">
  <strong>Nejdřív přemýšlej. Pak hledej.</strong>
</p>

---

Vestavěné WebSearch v Claude Code vrací úryvky o délce 125 znaků a spoléhá pouze na shodu klíčových slov. Pro jednoduché vyhledávání to stačí, ale skutečný výzkum vyžaduje návrh dotazů, hodnocení zdrojů a směrování respektující soukromí.

scout přemýšlí, než začne hledat.

## Rychlý start

Není potřeba API klíčů. Žádné změny prostředí. Nainstalujte a hned vyzkoušejte:

**1. Přidejte marketplace** (jednorázově):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Nainstalujte**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Znovu načtěte pluginy** (zadejte v Claude Code):

```
/mcp
```

Poté se zeptejte Claude:

```text
/scout:search Hledám něco jako Git blame, ale pro sledování návrhových rozhodnutí
```

scout přemění tento vágní koncept na správný termín (ADR — Architecture Decision Records), prohledá více vyhledávačů optimalizovanými dotazy, vyhodnotí kvalitu zdrojů a vrátí odpověď s Research Trail, který přesně ukazuje, jak k ní dospěl.

## Co scout umí

### Najde koncepty, které ještě neumíte pojmenovat

> „Vím, že takový koncept existuje — něco o zaznamenávání, proč jsme udělali každé návrhové rozhodnutí — ale neznám jeho název"

scout převádí mlhavé nápady na přesnou terminologii a dostane se k primárním zdrojům.

### Prorazí šumem SEO

> „Na co bych měl skutečně migrovat z Terraform — ne sponzorované seznamy, ale skutečné příběhy o migraci"

Předvýzkum získá správnou slovní zásobu a poté cílené dotazy obejdou obsahové farmy.

### Dostane se přímo k oficiální dokumentaci

> „Jak nastavit middleware v Next.js App Router?"

scout nejprve zkontroluje [Context7](https://github.com/upstash/context7), zda tam není indexovaná oficiální dokumentace — pokud je tam odpověď, webové vyhledávání není potřeba.

### Přečte libovolnou webovou stránku

> „Načti a shrň https://docs.anthropic.com/en/docs/claude-code"

Načítání respektující soukromí: veřejné stránky procházejí přes cloudová API, důvěrné stránky zůstávají na vašem počítači.

## Úrovně nastavení

scout funguje ihned po instalaci. Každá úroveň přidává schopnosti — všechny jsou volitelné a vratné.

### Úroveň 1: Vestavěné vyhledávání (výchozí)

Používá WebSearch v Claude Code. Není potřeba konfigurace. To je to, co dostanete hned po instalaci.

### Úroveň 2: Oficiální dokumentace + čistší načítání

Přidejte [Context7](https://github.com/upstash/context7) pro přímý přístup k dokumentaci knihoven a frameworků. Jina Reader odstraňuje rušivé prvky stránky, takže do kontextu se vejde méně textu a šetří se tokeny. Funguje bez klíče (20 req/min); s bezplatným API klíčem získáte 500 req/min.

### Úroveň 3: Sémantické vyhledávání

Přidejte [Exa](https://exa.ai) pro vyhledávání založené na významu — najde relevantní stránky i tehdy, když neznáte správná klíčová slova. Základní sémantické vyhledávání funguje v bezplatném plánu; API klíč odemkne pokročilé funkce.

### Úroveň 4: Lokální prohlížeč

Přidejte [Playwright](https://playwright.dev) pro stránky renderované JavaScriptem a důvěrné URL adresy, které by nikdy neměly opustit váš počítač. Stáhne Chromium (~200MB).

**Spusťte `/scout:setup` pro interaktivní průchod každou úrovní.** Každý krok přesně ukáže, co bude přidáno do konfigurace, než se provedou jakékoli změny. Můžete spustit kdykoli znovu pro přidání nebo aktualizaci nástrojů.

## Dovednosti

| Dovednost | Účel |
|---|---|
| `/scout:search` | Vícemotorové webové vyhledávání s návrhem dotazů, hodnocením zdrojů a automatickým opětovným vyhledáváním |
| `/scout:fetch` | Načítání obsahu URL s automatickou klasifikací soukromí |
| `/scout:setup` | Interaktivní průvodce nastavením vyhledávačů a nástrojů pro načítání |

### Research Trail

Každé vyhledávání končí strukturovaným záznamem, který ukazuje, jak scout dospěl k odpovědi:

```
🔍 Research Trail
───────────────────────────────
Query:           vaše původní otázka
Designed queries: optimalizované dotazy, které scout skutečně spustil
Sources:         URL s úrovní spolehlivosti (🟢 primární / 🟡 sekundární / ⚪ terciární)
Re-searches:     dodatečná vyhledávání a jejich důvody
Confidence:      High / Medium / Low s odůvodněním
```

## Soukromí

scout klasifikuje URL adresy do tří úrovní před načtením:

| Klasifikace | Směrování | Příklady |
|---|---|---|
| **Veřejné** | Cloudová API (Jina Reader / WebFetch) | Blogy, dokumentace, veřejné repozitáře GitHub |
| **Důvěrné** | Pouze lokální Playwright | localhost, interní wiki, administrační panely |
| **S ověřením** | Playwright CDP | Notion, Slack, stránky po OAuth ověření |

Tato klasifikace je založena na úsudku LLM, nikoli na systémovém vynucení. Považujte ji za směrování na principu nejlepšího úsilí. U vysoce citlivých dat ověřte klasifikaci před pokračováním.

**Důvěrné URL adresy se nikdy neodesílají na externí API, ani v případě selhání** — systém nepřechází na cloudové nástroje pro důvěrné stránky.

<details>
<summary>Nastavení režimu ladění Chrome (pro stránky s ověřením)</summary>

Pro načítání stránek vyžadujících přihlášení (OAuth, SaaS dashboardy) spusťte Chrome v režimu ladění. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Poznámka k profilu prohlížeče</summary>

Modul načítání založený na Playwright používá trvalý profil prohlížeče (`tools/.chrome-profile/`), ve kterém se mohou hromadit cookies a data relací. Tento adresář je vyloučen z Gitu přes `.gitignore`, ale může být zkopírován zálohovacími nástroji. Pokud načítáte důvěrné stránky, pravidelně jej mažte.
</details>

## Odinstalace

Dva příkazy odstraní vše. Bez zbytků.

Odstraňte plugin (vyčistí mezipaměť, konfiguraci a stavová data):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Odstraňte Context7, pokud jste jej přidali přes scout:setup (rozsah uživatele — odstraní ze všech projektů):

```bash
claude mcp remove context7
```

## Požadavky

- **Claude Code** (povinné)
- `jq` (pouze pro diagnostiku nastavení)
- Python 3.10+ (pouze pro lokální načítání přes Playwright)

## Bezpečnost

API klíče jsou uloženy v souboru `.mcp.json` v adresáři pluginu.
**Necommitujte `.mcp.json` do Gitu.** Šablona `.mcp.json.dist` je bezpečná k distribuci.

## Prohlášení

Tento plugin je poskytován „tak, jak je" pod licencí MIT, bez jakékoli záruky.

**Externí API.** Tento plugin využívá API třetích stran (Exa, Jina AI a další). Autor negarantuje dostupnost, přesnost, ceny ani kontinuitu těchto služeb a nenese odpovědnost za náklady vzniklé používáním API.

**Správa API klíčů.** Získání, zabezpečení a správa vlastních API klíčů a dodržování podmínek služeb jednotlivých poskytovatelů je výhradně vaší odpovědností.

**Klasifikace obsahu.** Klasifikace soukromí URL adres je založena na úsudku LLM a může obsahovat chyby. Nespoléhejte na ni jako na jediné zabezpečení citlivých informací.

**Načítání webu a automatizace prohlížeče.** Tento plugin obsahuje nástroje pro automatizaci bezhlavého prohlížeče pomocí Playwright. Za dodržování podmínek služeb cílových webů, politik robots.txt a platných zákonů odpovídáte vy.

**MCP servery.** Tento plugin se připojuje k MCP serverům třetích stran. Autor nekontroluje, neaudituje ani negarantuje chování a bezpečnost těchto serverů.

## Uvedení třetích stran

Zdrojový kód třetích stran není redistribuován — integrace probíhá přes MCP připojení, instalaci balíčků za běhu a obalovací skripty.

| Nástroj | Poskytovatel | Licence |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Všechny názvy produktů, loga a ochranné známky jsou majetkem příslušných vlastníků.

## Jazyk

Pokyny k nastavení jsou poskytovány ve vašem jazyce prostřednictvím AI asistenta. Přeložené soubory README slouží pro usnadnění — **anglický originál je oficiální verzí**.

## Podpora

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Hlášení chyb, žádosti o funkce a dotazy

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licence

[MIT License](../LICENSE) — volně k použití, úpravě a distribuci. Copyright (c) 2026 shidoyu.
