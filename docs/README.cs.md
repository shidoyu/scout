🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇸🇦 [العربية](README.ar.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇵🇱 [Polski](README.pl.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇺🇦 [Українська](README.uk.md) · 🇹🇭 [ไทย](README.th.md) · 🇷🇺 [Русский](README.ru.md) · 🇨🇿 [**Čeština**](README.cs.md)

> **Poznámka:** Tento překlad je poskytnut pouze pro pohodlí. [Anglický originál](../README.md) je oficiální verze.

# scout

**Wrong search, wrong decision.**

> Nejdřív přemýšlej, pak hledej. — Plugin pro webový výzkum pro Claude Code.

Návrh dotazů, vícemotorové vyhledávání, načítání s ohledem na soukromí.

Vestavěný WebSearch v Claude Code vrací jen 125znakové úryvky a spoléhá pouze na shodu klíčových slov. scout převádí vágní otázku na optimalizované dotazy pro více vyhledávačů, vyhodnocuje kvalitu výsledků a podle potřeby hledá znovu, takže se k primárním zdrojům dostane rychleji a spolehlivěji.

## Funkce

- **scout:search** — Webové vyhledávání s více vyhledávači a optimalizací návrhu dotazů
- **scout:fetch** — Načítání obsahu URL s výběrem nástrojů ohleduplným k soukromí

## Instalace

Spusťte v terminálu:

```bash
# Krok 1: Zaregistrujte marketplace
claude plugin marketplace add shidoyu/scout
```

```bash
# Krok 2: Nainstalujte plugin
claude plugin install scout@shidoyu-scout
```

**Krok 3** — Nastavte vyhledávače a nástroje pro načítání

Tyto příkazy spusťte v Claude Code po jednom:

```text
/reload-plugins
```

```text
/scout:setup
```

scout:setup vás interaktivně provede konfigurací Context7 (dokumentace knihoven), Jina Reader (načítání webových stránek), Exa (sémantické vyhledávání) a Playwright (stránky vykreslované JavaScriptem). Všechny kroky jsou volitelné a lze je přeskočit.

> **Poznámka:** Pokud tento krok přeskočíte, scout vás vyzve k nastavení při dalším spuštění relace. Základní vyhledávání funguje okamžitě bez nastavení.

## Rychlý start

Po instalaci se zeptejte Claude (nastavení není potřeba — základní vyhledávání funguje okamžitě):

### Vyzkoušejte hned

**Najít koncepty, které ještě neumíte pojmenovat:**
> „návrhový vzor kdy se víc malých objektů tváří jako jeden velký a klient nepozná rozdíl"

**Objevit mezinárodní ekvivalenty českých konceptů:**
> „jak vysvětlit zahraničnímu týmu český koncept datových schránek a najít obdobu v jiných zemích"

**Získat odborné odpovědi z jednoduchých otázek:**
> „Git říká že nemůžu pushovat protože remote obsahuje práci kterou nemám lokálně ale já nic neměnil"

**Přečíst konkrétní stránku:**
> „přečti https://docs.python.org/3/library/asyncio-task.html"

## Skills

### scout:search

Inteligentní webové vyhledávání s funkcemi:
- Předvýzkum pro upřesnění dotazů
- Návrh dotazů ve více jazycích
- Více vyhledávačů (WebSearch, [Context7](https://github.com/upstash/context7) oficiální dokumentace, sémantické vyhledávání [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) pro konceptuální dotazy přes Exa
- Hodnocení kvality s automatickou smyčkou opakovaného vyhledávání

Použití: `/scout:search vaše otázka zde`

### scout:fetch

Načítání obsahu webových stránek s automatickou klasifikací soukromí:
- **Veřejné stránky** → Jina Reader / WebFetch (vestavěná záloha)
- **Důvěrné stránky** → Lokální Playwright (bez volání externích API)
- **Stránky vyžadující přihlášení** → Chrome DevTools (relace prohlížeče)

Použití: `/scout:fetch URL`

### scout:setup

Interaktivní průvodce nastavením vyhledávačů a nástrojů pro načítání:
- **Context7** — Přímá cesta k aktuálním oficiálním dokumentacím knihoven a frameworků, takže se k primárním docs dostanete rychleji přes [Context7 MCP](https://github.com/upstash/context7) (není potřeba API klíč)
- **Jina Reader** — Čistší načítání webových stránek jako Markdown, které odstraňuje navigaci a opakující se šablonový obsah, takže se do modelu často posílá méně textu a šetří se tokeny ([API klíč](https://jina.ai/?newKey))
- **Exa** — Vyhledávání podle významu pro vágní, konceptuální a niche dotazy, když neznáte přesné termíny ([API klíč](https://exa.ai))
- **Playwright** — Lokální prohlížečové načítání pro stránky renderované JavaScriptem nebo důvěrné stránky, které mají zůstat na vašem zařízení (~200MB download)

Všechny kroky jsou volitelné. Spusťte znovu kdykoliv pro aktualizaci nastavení.

Použití: `/scout:setup`

## Soukromí

scout klasifikuje URL adresy do tří úrovní před načítáním:
- **Veřejné** → Cloudová API (Jina Reader / WebFetch)
- **Důvěrné** → Pouze lokální Playwright (zamýšlené směrování: důvěrné URL adresy nejsou odesílány externím API)
- **Vyžadující přihlášení** → Chrome DevTools (využívá relaci vašeho prohlížeče)

Tato klasifikace je automatická, ale vychází z úsudku LLM, nikoli ze systémového vynucení. Podrobnosti viz [Prohlášení o ochraně soukromí](#prohlášení-o-ochraně-soukromí).

## Požadavky

- Claude Code
- `jq` (pouze pro nastavení)
- `npm`/`npx` (pro [MCP](https://modelcontextprotocol.io/) server: chrome-devtools)
- Python 3.10+ (volitelné, pro lokální načítání pomocí Playwright)
- `uvx` nebo `uv` (volitelné, pro MCP server: markitdown — konverze HTML→Markdown)
- Chrome (volitelné, pro načítání stránek vyžadujících přihlášení přes DevTools)

### Nastavení Chrome DevTools (pro stránky vyžadující přihlášení)

Pro načítání stránek vyžadujících přihlášení (OAuth, SaaS dashboardy) musí Chrome běžet v režimu ladění:

Na macOS:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

Na Linuxu:

```bash
google-chrome --remote-debugging-port=9222
```

## Prohlášení o ochraně soukromí

scout klasifikuje URL adresy podle citlivosti a směruje důvěrné URL adresy na lokální nástroje.
Tato klasifikace vychází z úsudku LLM (vzory domén a kontext) a **není systémově vynucenou zárukou**.
U vysoce citlivých dat před pokračováním ověřte klasifikaci.

**Profil prohlížeče.** Načítač na bázi Playwright (`fetch-page.py`) používá trvalý profil prohlížeče (`tools/.chrome-profile/`), který může hromadit cookies, data relací a historii prohlížení. Tento adresář je vyloučen z Gitu prostřednictvím `.gitignore`, ale může být zkopírován zálohovacími nástroji nebo službami cloudové synchronizace. Pravidelně adresář mažte, pokud načítáte důvěrné stránky.

## Jazyk

Pokyny k nastavení poskytne asistent AI ve vašem jazyce.
Přeložené pokyny jsou pouze pro pohodlí — **anglický originál je autoritativní verzí**.

## Bezpečnostní poznámka

Po nastavení jsou API klíče uloženy v `.mcp.json`.
**Necommitujte `.mcp.json` do Gitu.** Jako šablonu pro distribuci používejte `.mcp.json.dist`.

## Právní upozornění

Tento plugin je poskytován „tak jak je" pod licencí MIT, bez jakékoli záruky.

**Externí API.** Tento plugin spoléhá na API třetích stran (Exa, Jina AI a další). Autor neposkytuje žádné záruky ohledně dostupnosti, přesnosti, cen ani kontinuity těchto služeb a nenese odpovědnost za náklady vzniklé používáním API.

**Správa API klíčů.** Nesete výhradní odpovědnost za získání, zabezpečení a správu vlastních API klíčů a za dodržování podmínek služby každého poskytovatele.

**Klasifikace obsahu.** Při načítání webového obsahu může plugin používat klasifikaci založenou na LLM k posouzení citlivosti na soukromí a určení vhodných metod načítání. Taková klasifikace je prováděna s maximálním úsilím a může obsahovat chyby. Nespoléhejte se na automatickou klasifikaci jako jediné ochranné opatření pro citlivé nebo důvěrné informace.

**Načítání webu a automatizace prohlížeče.** Tento plugin obsahuje nástroje pro automatizaci bezhlavého prohlížeče prostřednictvím Playwright a Chrome DevTools. Nesete odpovědnost za zajištění toho, aby vaše použití bylo v souladu s podmínkami služby cílových webů, zásadami robots.txt a platnými zákony. Autor nenese odpovědnost za blokování stránek, pozastavení účtu, omezení IP, neočekávané spuštění skriptů, spotřebu prostředků nebo problémy s kompatibilitou vyplývající z automatizace prohlížeče.

**MCP servery.** Tento plugin se připojuje k MCP (Model Context Protocol) serverům třetích stran. Autor nekontroluje, neaudituje ani nezaručuje chování ani bezpečnost těchto serverů.

## Přiřazení třetích stran

Tento plugin se integruje s následujícími externími nástroji a službami. Žádný zdrojový kód třetích stran není redistribuován — integrace probíhá prostřednictvím připojení k MCP serverům, instalace balíčků za běhu a obalových skriptů vytvořených vývojářem pluginu.

| Nástroj | Poskytovatel | Licence |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietární (podmínky API) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Všechny názvy produktů, loga a ochranné známky jsou majetkem příslušných vlastníků. Tento plugin není přidružen k žádné z výše uvedených služeb třetích stran ani jimi není doporučován.

## Podpora

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Hlášení chyb, požadavky na funkce a dotazy

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licence

[MIT License](../LICENSE) — volné použití, úpravy a distribuce. Copyright (c) 2026 shidoyu.
