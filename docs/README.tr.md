🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇹🇷 [**Türkçe**](README.tr.md)

> **Not:** Bu çeviri yalnızca kolaylık sağlamak amacıyla sunulmuştur. [İngilizce orijinal](../README.md) resmi sürümdür.

# scout — Web Araması ve İçerik Getirme

Claude Code'un yerleşik WebSearch aracı 125 karakterlik snippets döndürür ve yalnızca anahtar kelime eşleştirmesine dayanır. scout, belirsiz bir soruyu optimize edilmiş çok motorlu sorgulara dönüştürür, sonuç kalitesini değerlendirir ve gerektiğinde yeniden arama yapar — birincil kaynaklara daha hızlı ve güvenilir bir şekilde ulaşır.

## Özellikler

- **scout:search** — Sorgu tasarımı optimizasyonu ile çok motorlu web araması
- **scout:fetch** — Gizlilik farkındalıklı araç seçimi ile URL içeriği getirme

## Kurulum

Terminalinizde çalıştırın:

```bash
claude plugin add shidoyu/scout
```

## Hızlı Başlangıç

scout kurulumun hemen ardından çalışmaya hazırdır — arama WebSearch (yerleşik) ve Exa (ücretsiz, anahtar gerekmez) kullanır. İsteğe bağlı kurulum daha fazla özellik ekler:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Şunları içeren akıllı web araması:
- Sorgu iyileştirme için ön araştırma
- Çok dilli sorgu tasarımı
- Çoklu arama motorları (WebSearch, [Exa](https://exa.ai) anlamsal arama)
- Exa aracılığıyla kavramsal sorgular için HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496))
- Otomatik yeniden arama döngüsü ile kalite değerlendirmesi

Kullanım: `/scout:search sorunuzu buraya yazın`

### scout:fetch

Otomatik gizlilik sınıflandırması ile web sayfası içeriği getirme:
- **Genel sayfalar** → Jina Reader (API anahtarı gerekli) / WebFetch (yerleşik yedek)
- **Gizli sayfalar** → Yerel Playwright (harici API çağrısı yok)
- **Kimlik doğrulamalı sayfalar** → Chrome DevTools (tarayıcı oturumu)

Kullanım: `/scout:fetch URL`

## Kurulum (İsteğe Bağlı)

Şunları yapılandırmak için `tools/setup.sh` çalıştırın:

1. **Exa** — Gelişmiş AI destekli arama araçları (ücretli özellikler için API anahtarı; ücretsiz katman kurulum gerektirmeden çalışır)
2. **Jina Reader** — Markdown olarak yüksek kaliteli web sayfası getirme (API anahtarı gerekli; olmadan, genel sayfalar WebFetch'e düşer)
3. **Playwright** — JavaScript ile render edilmiş ve gizli sayfalar için tarayıcı tabanlı getirme (~200MB indirme)

Tüm adımlar atlanabilir. Ayarları güncellemek için istediğiniz zaman yeniden çalıştırın.
Kurulumdan sonra, yeni MCP sunucularının etkinleşmesi için Claude Code'u yeniden başlatın (veya `/mcp` çalıştırın).

## Gizlilik

scout, getirmeden önce URL'leri üç seviyeye göre sınıflandırır:
- **Genel** → Bulut API'leri (Jina Reader / WebFetch)
- **Gizli** → Yalnızca yerel Playwright (amaçlanan yönlendirme: gizli URL'ler harici API'lere gönderilmez)
- **Kimlik doğrulamalı** → Chrome DevTools (tarayıcı oturumunuzu kullanır)

Bu sınıflandırma otomatiktir ancak sistem zorlaması değil, LLM değerlendirmesine dayanır. Ayrıntılar için [Gizlilik Feragatnamesi](#gizlilik-feragatnamesi) bölümüne bakın.

## Gereksinimler

- Claude Code
- `jq` (yalnızca kurulum betiği için)
- `npm`/`npx` ([MCP](https://modelcontextprotocol.io/) sunucusu için: chrome-devtools)
- Python 3.10+ (isteğe bağlı, Playwright yerel getirme için)
- `uvx` veya `uv` (isteğe bağlı, MCP sunucusu için: markitdown — HTML→Markdown dönüşümü)
- Chrome (isteğe bağlı, DevTools aracılığıyla kimlik doğrulamalı sayfa getirme için)

### Chrome DevTools Kurulumu (kimlik doğrulamalı sayfalar için)

Giriş gerektiren sayfaları (OAuth, SaaS panelleri) getirmek için Chrome'un hata ayıklama modunda çalışıyor olması gerekir:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Gizlilik Feragatnamesi

scout, URL'leri hassasiyetlerine göre sınıflandırır ve gizli URL'leri yalnızca yerel araçlara yönlendirir.
Bu sınıflandırma, LLM değerlendirmesine (alan adı kalıpları ve bağlam) dayanır ve **sistem tarafından zorunlu kılınan bir güvence değildir**.
Son derece hassas veriler için, devam etmeden önce sınıflandırmayı doğrulayın.

**Tarayıcı Profili.** Playwright tabanlı getirici (`fetch-page.py`), çerezler, oturum verileri ve tarama geçmişi biriktirebilecek kalıcı bir tarayıcı profili (`tools/.chrome-profile/`) kullanır. Bu dizin `.gitignore` aracılığıyla Git'ten hariç tutulmuştur, ancak yedekleme araçları veya bulut senkronizasyon hizmetleri tarafından kopyalanabilir. Gizli sayfalar getiriyorsanız dizini periyodik olarak silin.

## Dil

Kurulum talimatları, AI asistanı tarafından kendi dilinizde sağlanır.
Çevrilmiş talimatlar yalnızca kolaylık amaçlıdır — **İngilizce orijinal yetkilidir**.

## Güvenlik Notu

`setup.sh` çalıştırıldıktan sonra API anahtarları `.mcp.json` içinde saklanır.
**`.mcp.json` dosyasını Git'e commit etmeyin.** Dağıtım için şablon olarak `.mcp.json.dist` kullanın.

## Sorumluluk Reddi

Bu eklenti, herhangi bir garanti olmaksızın MIT Lisansı kapsamında "olduğu gibi" sağlanmaktadır.

**Harici API'ler.** Bu eklenti üçüncü taraf API'lere (Exa, Jina AI ve diğerleri) dayanmaktadır. Yazar, bu hizmetlerin kullanılabilirliği, doğruluğu, fiyatlandırması veya sürekliliği konusunda herhangi bir garanti vermez ve API kullanımından kaynaklanan maliyetlerden sorumlu değildir.

**API Anahtarı Yönetimi.** Kendi API anahtarlarınızı edinmekten, güvence altına almaktan ve yönetmekten, ayrıca her sağlayıcının hizmet koşullarına uymaktan yalnızca siz sorumlusunuzdur.

**İçerik Sınıflandırması.** Web içeriği getirilirken, eklenti gizlilik hassasiyetini değerlendirmek ve uygun alma yöntemlerini belirlemek için LLM tabanlı sınıflandırma kullanabilir. Bu tür sınıflandırmalar en iyi çaba sonucudur ve hatalar içerebilir. Hassas veya gizli bilgiler için otomatik sınıflandırmayı tek koruma olarak kullanmayın.

**Web Getirme ve Tarayıcı Otomasyonu.** Bu eklenti, Playwright ve Chrome DevTools aracılığıyla başsız tarayıcı otomasyonu için araçlar içermektedir. Kullanımınızın hedef web sitelerinin hizmet koşullarına, robots.txt politikalarına ve geçerli yasalara uygun olmasını sağlamaktan siz sorumlusunuzdur. Yazar, tarayıcı otomasyonundan kaynaklanan site engelleme, hesap askıya alma, IP kısıtlamaları, beklenmedik komut dosyası yürütme, kaynak tüketimi veya uyumluluk sorunlarından sorumlu değildir.

**MCP Sunucuları.** Bu eklenti üçüncü taraf MCP (Model Context Protocol) sunucularına bağlanır. Yazar, bu sunucuların davranışını veya güvenliğini kontrol etmez, denetlemez veya garanti vermez.

## Üçüncü Taraf Atıflar

Bu eklenti aşağıdaki harici araç ve hizmetlerle entegre olur. Hiçbir üçüncü taraf kaynak kodu yeniden dağıtılmaz — entegrasyon MCP sunucu bağlantıları, çalışma zamanı paket kurulumu ve eklenti geliştiricisi tarafından yazılmış sarmalayıcı betikler aracılığıyla gerçekleştirilir.

| Araç | Sağlayıcı | Lisans |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tüm ürün adları, logolar ve ticari markalar ilgili sahiplerine aittir. Bu eklenti, yukarıda listelenen üçüncü taraf hizmetlerden herhangi biriyle bağlantılı değildir veya bunlar tarafından onaylanmamıştır.

## Destek

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Hata raporları, özellik istekleri ve sorular

## Yazar

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Lisans

[MIT License](../LICENSE) — ücretsiz kullanım, değiştirme ve dağıtım. Copyright (c) 2026 shidoyu.

