🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 **Eesti** · 🇸🇪 [Svenska](README.sv.md)

> **Märkus:** See tõlge on esitatud mugavuse huvides. [Ingliskeelne originaal](../README.md) on ametlik versioon.

# scout

**Wrong search, wrong decision.**

> Kõigepealt mõtle, siis otsi. — Veebiuuringu plugin Claude Code jaoks.

Päringuteostus, mitmemootorine otsing, privaatsust arvestav toomine.

## Funktsioonid

- **scout:search** — Mitmemootoriline veebiotsing päringu optimeerimisega
- **scout:fetch** — URL-i sisu toomine privaatsusest lähtuva tööriistavalikuga

## Paigaldamine

Käivita terminalis:

```bash
# 1. samm: Registreeri marketplace
claude plugin marketplace add shidoyu/scout

# 2. samm: Paigalda plugin
claude plugin install scout@shidoyu-scout
```

**3. samm** — Seadista otsingumootorid ja toomistööriistad

```
/reload-plugins
/scout:setup
```

`scout:setup` juhendab sind interaktiivselt [[Context7](https://github.com/upstash/context7) (teekide dokumentatsioon), Jina Reader](https://jina.ai) (veebilehtede toomine), [Exa](https://exa.ai) (semantiline otsing) ja [Playwright](https://playwright.dev) (JavaScriptiga renderdatud lehed) seadistamisel. Kõik sammud on valikulised ja vahelejätavad.

> **Märkus:** Kui jätad selle sammu vahele, palub scout seadistust järgmisel seansi alguses. Põhiotsing töötab kohe ilma seadistuseta.

## Kiirstart

Pärast paigaldamist küsi Claude'ilt (seadistus pole vajalik — põhiotsing töötab kohe):

**Leia kontseptsioonid, mida sa veel nimetada ei oska:**
> "see programmeerimisvõte kus funktsioon jätab enda meelde eelmised tulemused et mitte uuesti arvutada"

**Avasta Eesti kontseptsioonide rahvusvahelised vasted:**
> "kas mujal maailmas on midagi sarnast e-residentsuse API-ga?"

**Saa ekspertvastuseid lihtsatest küsimustest:**
> "minu Python skript töötab terminalis aga cron job ei leia mooduleid — ModuleNotFoundError"

**Loe konkreetset lehte:**
> "loe https://nextjs.org/docs/app/building-your-application/routing"

## Skills

### scout:search

Intelligentne veebiotsing, mis sisaldab:
- Eeluuringut päringu täpsustamiseks
- Mitmekeelset päringu kujundust
- Mitut otsimootorit (WebSearch, [Context7](https://github.com/upstash/context7) ametlik dokumentatsioon, [Exa](https://exa.ai) semantiline otsing)
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) kontseptuaalsete päringute jaoks Exa kaudu
- Kvaliteedihindamist automaatse uuesti otsimise tsükliga

Kasutus: `/scout:search sinu küsimus siia`

### scout:fetch

Veebilehe sisu toomine automaatse privaatsusklassifikatsiooniga:
- **Avalikud lehed** → Jina Reader / WebFetch (sisseehitatud varuvõimalus)
- **Konfidentsiaalsed lehed** → Kohalik Playwright (väliseid API-kõnesid ei tehta)
- **Autentimist nõudvad lehed** → Chrome DevTools (brauseri seanss)

Kasutus: `/scout:fetch URL`

### scout:setup

Interaktiivne juhendatud seadistus otsingumootorite ja toomistööriistade jaoks:
- **Context7** — Library & framework documentation search via [Context7 MCP](https://github.com/upstash/context7) (no API key needed)
- **Jina Reader** — Kvaliteetne veebilehtede toomine Markdownina ([tasuta API-võti](https://jina.ai/?newKey))
- **Exa** — Täiustatud AI-põhine semantiline otsing ([API-võti](https://exa.ai))
- **Playwright** — Brauseripõhine toomine JavaScriptiga renderdatud ja konfidentsiaalsete lehtede jaoks (~200 MB allalaadimine)

Kõik sammud on valikulised. Käivita uuesti igal ajal seadete uuendamiseks.

Kasutus: `/scout:setup`

## Privaatsus

scout liigitab URL-id kolme tasemesse enne toomist:
- **Avalik** → Pilveteenuse API-d (Jina Reader / WebFetch)
- **Konfidentsiaalne** → Ainult kohalik Playwright (kavandatud marsruutimine: konfidentsiaalseid URL-e ei saadeta välistele API-dele)
- **Autentimist nõudev** → Chrome DevTools (kasutab sinu brauseri seanssi)

See klassifikatsioon on automaatne, kuid põhineb LLM-i otsusel, mitte süsteemi poolt jõustatud. Vaata üksikasju jaotisest [Privaatsusest loobumine](#privaatsusest-loobumine).

## Nõuded

- Claude Code
- `jq` (ainult seadistuse jaoks)
- `npm`/`npx` ([MCP](https://modelcontextprotocol.io/) serveri jaoks: chrome-devtools)
- Python 3.10+ (valikuline, Playwright'i kohaliku toomise jaoks)
- `uvx` või `uv` (valikuline, MCP serveri jaoks: markitdown — HTML→Markdown teisendus)
- Chrome (valikuline, autentimist nõudvate lehtede toomiseks DevTools'i kaudu)

### Chrome DevTools'i seadistamine (autentimist nõudvate lehtede jaoks)

Sisselogimist nõudvate lehtede toomiseks (OAuth, SaaS-töölauad) peab Chrome töötama silumisrežiimis:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Privaatsusest loobumine

scout liigitab URL-id tundlikkuse järgi ja suunab konfidentsiaalsed URL-id ainult kohalikele tööriistadele.
See klassifikatsioon põhineb LLM-i otsusel (domeenimustrid ja kontekst) ning **ei ole süsteemi poolt jõustatud garantii**.
Eriti tundlike andmete puhul kontrolli klassifikatsioon enne jätkamist üle.

**Brauseriprofiil.** Playwright'il põhinev toomisprogramm (`fetch-page.py`) kasutab püsivat brauseriprofiili (`tools/.chrome-profile/`), millesse võivad koguneda küpsised, seansiandmed ja sirvimisajalugu. See kataloog on Gitis `.gitignore` kaudu välistatud, kuid varukoopiatööriistad või pilvesünkroonimisteenus võivad selle kopeerida. Kustuta kataloog perioodiliselt, kui tood konfidentsiaalseid lehti.

## Keel

Seadistamisjuhised esitatakse sinu keeles AI-assistendi poolt.
Tõlgitud juhised on ainult mugavuse huvides — **ingliskeelne originaal on autoriteetne**.

## Turvamarginaal

Pärast seadistamist salvestatakse API-võtmed `.mcp.json`-faili.
**Ära tee `.mcp.json` kohta Giti commit'i.** Kasuta jaotuseks malli `.mcp.json.dist`.

## Lahtiütlemine

See plugin esitatakse "nii nagu on" MIT-litsentsi alusel, ilma igasuguse garantiita.

**Välised API-d.** See plugin tugineb kolmandate osapoolte API-dele (Exa, Jina AI ja teised). Autor ei anna mingeid garantiisid nende teenuste kättesaadavuse, täpsuse, hinnakujunduse või järjepidevuse kohta ega vastuta API kasutamisest tulenevate kulude eest.

**API-võtmete haldamine.** Oled ainuisikuliselt vastutav oma API-võtmete hankimise, turvamise ja haldamise ning iga teenusepakkuja kasutustingimustele vastamise eest.

**Sisu klassifikatsioon.** Veebisisu toomisel võib plugin kasutada LLM-põhist klassifikatsiooni privaatsustundlikkuse hindamiseks ja sobivate toomismeetodite määramiseks. Sellised klassifikatsioonid on parima pingutuse tulemus ja võivad sisaldada vigu. Ära loedu ainult automatiseeritud klassifikatsioonile tundliku või konfidentsiaalse teabe kaitsmisel.

**Veebisisu toomine ja brauseri automatiseerimine.** See plugin sisaldab tööriistu brauseri automaatseks käsitsemiseks Playwright'i ja Chrome DevTools'i kaudu. Oled vastutav selle eest, et sinu kasutus vastab sihtsaitide kasutustingimustele, robots.txt-poliitikatele ja kehtivatele seadustele. Autor ei vastuta saitide blokeerimise, konto peatamise, IP-piirangute, ootamatu skripti käivitamise, ressursikasutuse ega brauseri automatiseerimisest tulenevate ühilduvusprobleemide eest.

**MCP-serverid.** See plugin ühendub kolmandate osapoolte MCP (Model Context Protocol) serveritega. Autor ei kontrolli, auditeeri ega garanteeri nende serverite käitumist ega turvalisust.

## Kolmandate osapoolte omistamine

See plugin integreerub järgmiste väliste tööriistade ja teenustega. Kolmandate osapoolte lähtekoodi ei levitata ümber — integratsioon toimub MCP-serveri ühenduste, käitusaegse pakettide paigaldamise ja pistikprogrammi arendaja kirjutatud ümbrikskriptide kaudu.

| Tööriist | Pakkuja | Litsents |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Omandiõiguslik (API tingimused) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Kõik tootenimed, logod ja kaubamärgid kuuluvad nende vastavatele omanikele. See plugin ei ole seotud ega heaks kiidetud ühegi eespool loetletud kolmanda osapoole teenuse poolt.

## Tugi

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Veateated, funktsionaalsuse soovid ja küsimused

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Litsents

[MIT License](../LICENSE) — vaba kasutada, muuta ja levitada. Copyright (c) 2026 shidoyu.

