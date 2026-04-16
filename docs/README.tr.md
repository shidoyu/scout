🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 **Türkçe** · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Not:** Bu çeviri yalnızca kolaylık amacıyla sunulmuştur. [İngilizce orijinal](../README.md) resmi sürümdür.

<p align="center">
  <img src="assets/hero.png" alt="scout — Önce düşün. Sonra ara." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  <a href="https://claude.com/claude-code">Claude Code</a> için web araştırma eklentisi.<br>
  Belirsiz soruları, birincil kaynaklara ulaşan optimize edilmiş çoklu motor sorgularına dönüştürür.
</p>

<p align="center">
  <strong>Önce düşün. Sonra ara.</strong>
</p>

---

Claude Code'un yerleşik WebSearch özelliği 125 karakterlik kısa alıntılar döndürür ve yalnızca anahtar kelime eşleştirmesine dayanır. Basit aramalar için yeterlidir — ancak gerçek bir araştırma için sorgu tasarımı, kaynak değerlendirmesi ve gizlilik odaklı yönlendirme gerekir.

scout aramadan önce düşünür.

## Hızlı Başlangıç

API anahtarı gerekmez. Ortam değişikliği gerekmez. Kurun ve hemen deneyin:

**1. Mağazayı ekleyin** (tek seferlik):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Kurulum**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Eklentileri yeniden yükleyin** (Claude Code içinde yazın):

```
/mcp
```

Ardından Claude'a sorun:

```text
/scout:search Git blame gibi ama tasarım kararları için bir şey istiyorum
```

scout bu belirsiz kavramı doğru terime (ADR — Architecture Decision Records) dönüştürecek, birden fazla motorda iyileştirilmiş sorgular çalıştıracak, kaynak kalitesini değerlendirecek ve sonuca nasıl ulaştığını gösteren bir Research Trail ile yanıt verecektir.

## scout ne yapar

### Henüz adını bilmediğiniz kavramları bulun

> "Böyle bir kavram olduğunu biliyorum — her tasarım kararının nedenini kaydetmekle ilgili bir şey — ama adını bilmiyorum"

scout belirsiz fikirleri kesin terminolojiye çevirir ve birincil kaynaklara ulaşır.

### SEO gürültüsünü aşın

> "Terraform'dan gerçekten neye geçmeliyim — sponsorlu listeler değil, gerçek göç hikayeleri"

Ön araştırma doğru kelime dağarcığını edinir, ardından hedefli sorgular içerik çiftliklerini atlar.

### Resmi belgelere doğrudan ulaşın

> "Next.js App Router'da middleware nasıl kurulur?"

scout önce [Context7](https://github.com/upstash/context7) üzerinden indekslenmiş resmi belgeleri kontrol eder — cevap oradaysa web aramasına gerek kalmaz.

### Herhangi bir web sayfasını okuyun

> "https://docs.anthropic.com/en/docs/claude-code adresini getir ve özetle"

Gizlilik odaklı getirme: genel sayfalar bulut API'leri üzerinden, gizli sayfalar yerel makinenizde işlenir.

## Kurulum Seviyeleri

scout kurulumdan hemen sonra çalışır. Her seviye yetenek ekler — hepsi isteğe bağlı, hepsi geri alınabilir.

### Seviye 1: Yerleşik Arama (varsayılan)

Claude Code'un WebSearch'ünü kullanır. Yapılandırma gerekmez. Kutudan çıktığı haliyle budur.

### Seviye 2: Resmi Belgeler + Daha Temiz Getirme

Kütüphane ve framework belgelerine doğrudan erişim için [Context7](https://github.com/upstash/context7) ekleyin. Jina Reader sayfa gürültüsünü temizler, böylece bağlamınızı daha az metin doldurur ve token tasarrufu sağlarsınız. Anahtar olmadan çalışır (20 req/min); ücretsiz bir API anahtarı 500 req/min kilidini açar.

### Seviye 3: Anlamsal Arama

Anlam tabanlı arama için [Exa](https://exa.ai) — doğru anahtar kelimeleri bilmeseniz bile ilgili sayfaları bulur. Ücretsiz katmanda temel anlamsal arama çalışır; API anahtarı gelişmiş özellikleri açar.

### Seviye 4: Yerel Tarayıcı

JavaScript ile oluşturulan sayfalar ve makinenizden asla çıkmaması gereken gizli URL'ler için [Playwright](https://playwright.dev). Chromium indirmesi gerektirir (~200MB).

**Her seviyeyi etkileşimli olarak ayarlamak için `/scout:setup` komutunu çalıştırın.** Her adım, değişiklik yapılmadan önce yapılandırmanıza nelerin ekleneceğini gösterir. Araç eklemek veya güncellemek için istediğiniz zaman yeniden çalıştırın.

## Yetenekler

| Yetenek | Amaç |
|---|---|
| `/scout:search` | Sorgu tasarımı, kaynak değerlendirmesi ve otomatik yeniden arama ile çoklu motor web araması |
| `/scout:fetch` | Otomatik gizlilik sınıflandırması ile URL içerik getirme |
| `/scout:setup` | Arama motorları ve getirme araçları için etkileşimli rehberli kurulum |

### Research Trail

Her aramanın sonunda, scout'un yanıta nasıl ulaştığını gösteren yapılandırılmış bir iz görüntülenir:

```
🔍 Research Trail
───────────────────────────────
Query:           orijinal sorunuz
Designed queries: scout'un gerçekte çalıştırdığı optimize sorgular
Sources:         güvenilirlik seviyeli URL'ler (🟢 birincil / 🟡 ikincil / ⚪ üçüncül)
Re-searches:     ek aramalar ve nedenleri
Confidence:      High / Medium / Low gerekçesiyle
```

## Gizlilik

scout, getirmeden önce URL'leri üç seviyede sınıflandırır:

| Sınıflandırma | Yönlendirme | Örnekler |
|---|---|---|
| **Genel** | Bulut API'leri (Jina Reader / WebFetch) | Bloglar, belgeler, GitHub genel depoları |
| **Gizli** | Yalnızca yerel Playwright | localhost, dahili wikiler, yönetim panelleri |
| **Kimlik doğrulamalı** | Playwright CDP | Notion, Slack, OAuth sonrası sayfalar |

Bu sınıflandırma LLM yargısına dayanır, sistem tarafından zorunlu kılınmaz. En iyi çaba yönlendirmesi olarak değerlendirin. Yüksek hassasiyetli veriler için işlem öncesi sınıflandırmayı doğrulayın.

**Gizli URL'ler, başarısızlık durumunda bile asla harici API'lere gönderilmez** — sistem gizli sayfalar için bulut araçlarına geri dönmez.

<details>
<summary>Chrome hata ayıklama modu kurulumu (kimlik doğrulamalı sayfalar için)</summary>

Giriş gerektiren sayfaları (OAuth, SaaS panelleri) getirmek için Chrome'u hata ayıklama modunda başlatın. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Tarayıcı profili notu</summary>

Playwright tabanlı getirici, çerez ve oturum verisi birikebilen kalıcı bir tarayıcı profili (`tools/.chrome-profile/`) kullanır. Bu dizin `.gitignore` ile Git'ten hariç tutulmuştur ancak yedekleme araçları tarafından kopyalanabilir. Gizli sayfalar getirdiyseniz düzenli olarak silin.
</details>

## Kaldırma

Her şeyi kaldırmak için iki komut. Artık kalıntı yok.

Eklentiyi kaldırın (önbellek, yapılandırma ve durum verilerini temizler):

```bash
claude plugin uninstall scout@shidoyu-scout
```

scout:setup ile eklediyseniz Context7'yi kaldırın (kullanıcı kapsamlı — tüm projelerden kaldırır):

```bash
claude mcp remove context7
```

## Gereksinimler

- **Claude Code** (gerekli)
- `jq` (yalnızca kurulum teşhisi için)
- Python 3.10+ (yalnızca Playwright yerel getirme için)

## Güvenlik

API anahtarları eklenti dizinindeki `.mcp.json` dosyasında saklanır.
**`.mcp.json` dosyasını Git'e eklemeyin.** Dağıtım için `.mcp.json.dist` şablonunu kullanın.

## Sorumluluk Reddi

Bu eklenti MIT Lisansı kapsamında "olduğu gibi" sağlanmakta olup hiçbir garanti verilmemektedir.

**Harici API'ler.** Bu eklenti üçüncü taraf API'lerine (Exa, Jina AI ve diğerleri) bağımlıdır. Yazar, bu hizmetlerin kullanılabilirliği, doğruluğu, fiyatlandırması veya sürekliliği hakkında hiçbir garanti vermez ve API kullanımından kaynaklanan maliyetlerden sorumlu değildir.

**API Anahtarı Yönetimi.** API anahtarlarınızın edinilmesi, güvenliğinin sağlanması ve yönetilmesi ile her sağlayıcının hizmet şartlarına uyum tamamen sizin sorumluluğunuzdadır.

**İçerik Sınıflandırması.** URL gizlilik sınıflandırması LLM yargısına dayanır ve hatalar içerebilir. Hassas bilgiler için tek güvence olarak buna güvenmeyin.

**Web Getirme ve Tarayıcı Otomasyonu.** Bu eklenti, Playwright aracılığıyla başsız tarayıcı otomasyon araçları içerir. Hedef web sitelerinin hizmet şartlarına, robots.txt politikalarına ve yürürlükteki yasalara uygunluğun sağlanması sizin sorumluluğunuzdadır.

**MCP Sunucuları.** Bu eklenti üçüncü taraf MCP sunucularına bağlanır. Yazar, bu sunucuların davranışını veya güvenliğini kontrol etmez, denetlemez veya garanti etmez.

## Üçüncü Taraf Atıfları

Üçüncü taraf kaynak kodu yeniden dağıtılmamaktadır — entegrasyon MCP bağlantıları, çalışma zamanı paket kurulumu ve sarmalayıcı betikler aracılığıyla sağlanır.

| Araç | Sağlayıcı | Lisans |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tüm ürün adları, logolar ve ticari markalar ilgili sahiplerinin mülkiyetindedir.

## Dil

Kurulum talimatları AI asistanı tarafından kendi dilinizde sunulur. Çeviriler kolaylık amaçlıdır — **İngilizce orijinal yetkili sürümdür**.

## Destek

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Hata raporları, özellik istekleri ve sorular

## Yazar

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Workflow Designer

## Lisans

[MIT License](../LICENSE) — özgürce kullanılabilir, değiştirilebilir ve dağıtılabilir. Copyright (c) 2026 shidoyu.
