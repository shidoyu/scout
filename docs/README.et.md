🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 **Eesti** · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Märkus:** See tõlge on esitatud üksnes mugavuse huvides. Ametlik versioon on [ingliskeelne originaal](../README.md).

<p align="center">
  <img src="assets/hero.png" alt="scout — Kõigepealt mõtle. Siis otsi." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Veebiuuringute pistikprogramm <a href="https://claude.com/claude-code">Claude Code</a>'ile.<br>
  Muudab ebamäärased küsimused optimeeritud mitme otsingumootori päringuteks, mis jõuavad esmaste allikateni.
</p>

<p align="center">
  <strong>Kõigepealt mõtle. Siis otsi.</strong>
</p>

---

Claude Code'i sisseehitatud WebSearch tagastab 125 tähemärgi pikkuseid katkendeid ja tugineb ainult märksõnade vastavusele. Lihtsate otsingute jaoks piisab sellest, kuid tõelised uuringud nõuavad päringute kujundamist, allikate hindamist ja privaatsust arvestavat marsruutimist.

scout mõtleb enne otsimist.

## Kiirstart

API-võtmeid pole vaja. Keskkonna muudatusi pole vaja. Paigalda ja proovi kohe:

**1. Lisa turukoht** (ühekordne):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Paigalda**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Laadi pistikprogrammid uuesti** (sisesta see Claude Code'is):

```
/mcp
```

Seejärel küsi Claude'ilt:

```text
/scout:search Otsin midagi Git blame'i sarnast, aga disainiotsuste jälgimiseks
```

scout muudab selle ebamäärase mõiste õigeks terminiks (ADR — Architecture Decision Records), otsib mitmes mootoris täiustatud päringutega, hindab allikate kvaliteeti ja tagastab vastuse koos Research Trail'iga, mis näitab täpselt, kuidas ta vastuseni jõudis.

## Mida scout teeb

### Leiab mõisted, mida sa veel nimetada ei oska

> "Ma tean, et selline mõiste on olemas — midagi selle kohta, kuidas jälgida, miks me iga disainiotsuse tegime — aga ma ei tea, kuidas seda nimetatakse"

scout tõlgib udused ideed täpseks terminoloogiaks ja jõuab esmaste allikateni.

### Murrab läbi SEO-müra

> "Millele peaksin tegelikult Terraformilt üle minema — mitte sponsoreeritud nimekirjad, vaid reaalsed üleminekukogemused"

Eeluurimine annab õige sõnavara, seejärel mööduvad sihitud päringud sisufarmidest.

### Jõuab otse ametliku dokumentatsioonini

> "Kuidas seadistada middleware'i Next.js App Router'is?"

scout kontrollib esmalt [Context7](https://github.com/upstash/context7) indekseeritud ametliku dokumentatsiooni olemasolu — kui vastus on seal, pole veebiotsingut vaja.

### Loeb mis tahes veebilehte

> "Too ja tee kokkuvõte https://docs.anthropic.com/en/docs/claude-code"

Privaatsust arvestav toomine: avalikud lehed lähevad pilve-API-de kaudu, konfidentsiaalsed lehed jäävad sinu masinasse.

## Seadistustasemed

scout töötab kohe pärast paigaldamist. Iga tase lisab võimalusi — kõik on valikulised ja tagasipööratavad.

### Tase 1: Sisseehitatud otsing (vaikimisi)

Kasutab Claude Code'i WebSearch'i. Seadistamist pole vaja. See on see, mida sa saad kohe karbist välja.

### Tase 2: Ametlik dokumentatsioon + puhtam toomine

Lisa [Context7](https://github.com/upstash/context7) teekide ja raamistike dokumentatsiooni otsepääsuks. Jina Reader eemaldab lehe müra, nii et kontekstis on vähem teksti ja säästad tokeneid. Töötab ilma võtmeta (20 req/min); tasuta API-võti avab 500 req/min.

### Tase 3: Semantiline otsing

Lisa [Exa](https://exa.ai) tähenduspõhiseks otsinguks — leiab asjakohased lehed isegi siis, kui sa ei tea õigeid märksõnu. Põhiline semantiline otsing töötab tasuta plaaniga; API-võti avab täiustatud funktsioone.

### Tase 4: Kohalik brauser

Lisa [Playwright](https://playwright.dev) JavaScriptiga renderdatud lehtede ja konfidentsiaalsete URL-ide jaoks, mis ei tohiks kunagi sinu masinast lahkuda. Laadib alla Chromiumi (~200MB).

**Käivita `/scout:setup`, et interaktiivselt läbida iga tase.** Iga samm näitab täpselt, mis konfiguratsioonile lisatakse, enne kui muudatusi tehakse. Käivita uuesti igal ajal, et lisada või värskendada tööriistu.

## Oskused

| Oskus | Otstarve |
|---|---|
| `/scout:search` | Mitme otsingumootori veebiotsing päringu kujundamise, allikate hindamise ja automaatse kordusotsinguga |
| `/scout:fetch` | URL-sisu toomine automaatse privaatsusklassifikatsiooniga |
| `/scout:setup` | Interaktiivne juhendatud seadistus otsingumootorite ja toomistööriistade jaoks |

### Research Trail

Iga otsing lõpeb struktureeritud ülevaatega, mis näitab, kuidas scout vastuseni jõudis:

```
🔍 Research Trail
───────────────────────────────
Query:           sinu algne küsimus
Designed queries: optimeeritud päringud, mida scout tegelikult käivitas
Sources:         URL-id usaldusväärsuse tasemega (🟢 esmased / 🟡 teisesed / ⚪ kolmandased)
Re-searches:     lisaotsingud ja nende põhjused
Confidence:      High / Medium / Low põhjendusega
```

## Privaatsus

scout klassifitseerib URL-id kolme tasemesse enne toomist:

| Klassifikatsioon | Marsruutimine | Näited |
|---|---|---|
| **Avalik** | Pilve-API-d (Jina Reader / WebFetch) | Blogid, dokumentatsioon, avalikud GitHub'i repod |
| **Konfidentsiaalne** | Ainult kohalik Playwright | localhost, sisemised vikid, haldusvaated |
| **Autenditud** | Playwright CDP | Notion, Slack, OAuth-järgsed lehed |

See klassifikatsioon põhineb LLM-i hinnangul, mitte süsteemsel jõustamisel. Käsitle seda parima võimaliku marsruutimisena. Väga tundlike andmete puhul kontrolli klassifikatsiooni enne jätkamist.

**Konfidentsiaalseid URL-e ei saadeta kunagi välistele API-dele, isegi ebaõnnestumise korral** — süsteem ei kasuta konfidentsiaalsete lehtede jaoks pilvetööriistu varuvalikuna.

<details>
<summary>Chrome'i silumisrežiimi seadistamine (autenditud lehtede jaoks)</summary>

Sisselogimist nõudvate lehtede toomiseks (OAuth, SaaS-paneelid) käivita Chrome silumisrežiimis. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Märkus brauseri profiili kohta</summary>

Playwrightil põhinev toomismoodul kasutab püsivat brauseriprofiili (`tools/.chrome-profile/`), kuhu võivad koguneda küpsised ja sessiooniandmed. See kataloog on Gitist välja jäetud `.gitignore` kaudu, kuid varundamisvahendid võivad seda kopeerida. Kui tood konfidentsiaalseid lehti, kustuta see regulaarselt.
</details>

## Desinstallimine

Kaks käsku eemaldavad kõik. Jääke ei jää.

Eemalda pistikprogramm (puhastab vahemälu, konfiguratsiooni ja olekuandmed):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Eemalda Context7, kui lisasid selle scout:setup kaudu (kasutajaulatus — eemaldatakse kõigist projektidest):

```bash
claude mcp remove context7
```

## Nõuded

- **Claude Code** (kohustuslik)
- `jq` (ainult seadistuse diagnostika jaoks)
- Python 3.10+ (ainult kohalikuks toomiseks Playwrighti kaudu)

## Turvalisus

API-võtmed salvestatakse pistikprogrammi kataloogi `.mcp.json` faili.
**Ära komiti `.mcp.json` faili Giti.** Mall `.mcp.json.dist` on turvaline levitamiseks.

## Vastutuse välistamine

See pistikprogramm on esitatud "nagu on" MIT-litsentsi alusel, ilma igasuguse garantiita.

**Välised API-d.** See pistikprogramm tugineb kolmandate osapoolte API-dele (Exa, Jina AI jt). Autor ei anna garantiisid nende teenuste kättesaadavuse, täpsuse, hinnakujunduse ega järjepidevuse kohta ega vastuta API kasutamisega kaasnevate kulude eest.

**API-võtmete haldamine.** Enda API-võtmete hankimine, turvamine ja haldamine ning iga teenusepakkuja kasutustingimuste järgimine on ainuüksi sinu vastutus.

**Sisu klassifitseerimine.** URL-ide privaatsusklassifikatsioon põhineb LLM-i hinnangul ja võib sisaldada vigu. Ära tugine sellele kui ainsale kaitsemeetmele tundliku teabe puhul.

**Veebilehtede toomine ja brauseri automatiseerimine.** See pistikprogramm sisaldab tööriistu peata brauseri automatiseerimiseks Playwrighti kaudu. Sina vastutad selle eest, et sinu kasutus vastab sihtveebilehtede kasutustingimustele, robots.txt poliitikatele ja kehtivatele seadustele.

**MCP-serverid.** See pistikprogramm ühendub kolmandate osapoolte MCP-serveritega. Autor ei kontrolli, auditeeri ega garanteeri nende serverite käitumist ega turvalisust.

## Kolmandate osapoolte viited

Kolmandate osapoolte lähtekoodi ei levitata edasi — integratsioon toimub MCP-ühenduste, käitusaegsete pakettide paigaldamise ja ümbrisskriptide kaudu.

| Tööriist | Pakkuja | Litsents |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Kõik tootenimed, logod ja kaubamärgid kuuluvad nende vastavatele omanikele.

## Keel

Seadistusjuhised esitatakse sinu keeles AI-assistendi poolt. Tõlgitud README-failid on mugavuse huvides — **ingliskeelne originaal on ametlik versioon**.

## Tugi

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Veateated, funktsioonisoovid ja küsimused

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Litsents

[MIT License](../LICENSE) — vaba kasutada, muuta ja levitada. Copyright (c) 2026 shidoyu.
