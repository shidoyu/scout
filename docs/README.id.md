🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇮🇩 [**Bahasa Indonesia**](README.id.md)

> **Catatan:** Terjemahan ini disediakan untuk kemudahan saja. [Versi asli dalam bahasa Inggris](../README.md) adalah versi resmi.

# scout

**Wrong search, wrong decision.**

> Pikir dulu, baru cari. — Plugin riset web untuk Claude Code.

Desain kueri, pencarian multi-mesin, pengambilan konten yang menjaga privasi.

## Fitur

- **scout:search** — Pencarian web multi-mesin dengan optimasi desain kueri
- **scout:fetch** — Pengambilan konten URL dengan pemilihan alat yang memperhatikan privasi

## Instalasi

Jalankan di terminal:

```bash
# Langkah 1: Daftarkan marketplace
claude plugin marketplace add shidoyu/scout

# Langkah 2: Instal plugin
claude plugin install scout@shidoyu-scout
```

**Langkah 3** — Siapkan mesin pencari dan alat pengambilan

```
/reload-plugins
/scout:setup
```

`scout:setup` memandu Anda secara interaktif untuk mengonfigurasi [[Context7](https://github.com/upstash/context7) (dokumentasi pustaka), Jina Reader](https://jina.ai) (pengambilan halaman web), [Exa](https://exa.ai) (pencarian semantik), dan [Playwright](https://playwright.dev) (halaman yang dirender JavaScript). Setiap langkah bersifat opsional dan dapat dilewati.

> **Catatan:** Jika Anda melewati langkah ini, scout akan meminta pengaturan pada awal sesi berikutnya. Pencarian dasar langsung berfungsi tanpa pengaturan.

## Mulai Cepat

Setelah menginstal, tanya Claude (tidak perlu pengaturan — pencarian dasar langsung berfungsi):

**Temukan konsep yang belum bisa kamu sebut namanya:**
> "teknik di mana program bisa jalan terus tanpa harus nunggu proses sebelumnya selesai"

**Temukan padanan internasional konsep Indonesia:**
> "QRIS itu kalau di luar negeri padanannya apa untuk integrasi pembayaran?"

**Dapatkan jawaban ahli dari pertanyaan sederhana:**
> "aplikasi Android saya force close terus di HP murah tapi di HP mahal lancar"

**Baca halaman tertentu:**
> "baca https://vuejs.org/guide/essentials/reactivity-fundamentals.html"

## Skill

### scout:search

Pencarian web cerdas dengan:
- Pra-riset untuk penyempurnaan kueri
- Desain kueri multi-bahasa
- Berbagai mesin pencari (WebSearch, [Context7](https://github.com/upstash/context7) dokumentasi resmi, pencarian semantik [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) untuk kueri konseptual melalui Exa
- Penilaian kualitas dengan loop pencarian ulang otomatis

Penggunaan: `/scout:search pertanyaan Anda di sini`

### scout:fetch

Ambil konten halaman web dengan klasifikasi privasi otomatis:
- **Halaman publik** → Jina Reader / WebFetch (fallback bawaan)
- **Halaman rahasia** → Playwright lokal (tanpa panggilan API eksternal)
- **Halaman terautentikasi** → Chrome DevTools (sesi browser)

Penggunaan: `/scout:fetch URL`

### scout:setup

Pengaturan interaktif terpandu untuk mesin pencari dan alat pengambilan:
- **Context7** — Library & framework documentation search via [Context7 MCP](https://github.com/upstash/context7) (no API key needed)
- **Jina Reader** — Pengambilan halaman web berkualitas tinggi dalam format Markdown ([kunci API gratis](https://jina.ai/?newKey))
- **Exa** — Pencarian semantik AI-native canggih ([kunci API](https://exa.ai))
- **Playwright** — Pengambilan berbasis browser untuk halaman yang dirender JavaScript dan halaman rahasia (unduhan ~200MB)

Semua langkah bersifat opsional. Jalankan ulang kapan saja untuk memperbarui pengaturan.

Penggunaan: `/scout:setup`

## Privasi

scout mengklasifikasikan URL ke dalam tiga tingkat sebelum mengambil konten:
- **Publik** → API cloud (Jina Reader / WebFetch)
- **Rahasia** → Hanya Playwright lokal (perutean yang dimaksud: URL rahasia tidak dikirim ke API eksternal)
- **Terautentikasi** → Chrome DevTools (menggunakan sesi browser Anda)

Klasifikasi ini bersifat otomatis tetapi didasarkan pada penilaian LLM, bukan penegakan sistem. Lihat [Penafian Privasi](#penafian-privasi) untuk detail lebih lanjut.

## Persyaratan

- Claude Code
- `jq` (hanya untuk pengaturan)
- `npm`/`npx` (untuk server [MCP](https://modelcontextprotocol.io/): chrome-devtools)
- Python 3.10+ (opsional, untuk pengambilan lokal Playwright)
- `uvx` atau `uv` (opsional, untuk server MCP: markitdown — konversi HTML→Markdown)
- Chrome (opsional, untuk pengambilan halaman terautentikasi melalui DevTools)

### Pengaturan Chrome DevTools (untuk halaman terautentikasi)

Untuk mengambil halaman yang memerlukan login (OAuth, dasbor SaaS), Chrome harus berjalan dalam mode debug:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Penafian Privasi

scout mengklasifikasikan URL berdasarkan sensitivitas dan merutekan URL rahasia ke alat lokal saja.
Klasifikasi ini didasarkan pada penilaian LLM (pola domain dan konteks) dan **bukan merupakan jaminan yang ditegakkan oleh sistem**.
Untuk data yang sangat sensitif, verifikasi klasifikasi sebelum melanjutkan.

**Profil Browser.** Pengambil berbasis Playwright (`fetch-page.py`) menggunakan profil browser persisten (`tools/.chrome-profile/`) yang dapat mengakumulasi cookie, data sesi, dan riwayat penelusuran. Direktori ini dikecualikan dari Git melalui `.gitignore` tetapi mungkin disalin oleh alat pencadangan atau layanan sinkronisasi cloud. Hapus direktori ini secara berkala jika Anda mengambil halaman rahasia.

## Bahasa

Instruksi pengaturan disediakan dalam bahasa Anda oleh asisten AI.
Instruksi yang diterjemahkan hanya untuk kemudahan — **versi asli dalam bahasa Inggris adalah yang otoritatif**.

## Catatan Keamanan

Setelah pengaturan, kunci API disimpan di `.mcp.json`.
**Jangan commit `.mcp.json` ke Git.** Gunakan `.mcp.json.dist` sebagai templat untuk distribusi.

## Penafian

Plugin ini disediakan "sebagaimana adanya" di bawah Lisensi MIT, tanpa jaminan apa pun.

**API Eksternal.** Plugin ini bergantung pada API pihak ketiga (Exa, Jina AI, dan lainnya). Penulis tidak memberikan jaminan tentang ketersediaan, akurasi, harga, atau kelangsungan layanan ini dan tidak bertanggung jawab atas biaya yang timbul melalui penggunaan API.

**Pengelolaan Kunci API.** Anda sepenuhnya bertanggung jawab untuk mendapatkan, mengamankan, dan mengelola kunci API Anda sendiri, serta untuk mematuhi ketentuan layanan setiap penyedia.

**Klasifikasi Konten.** Saat mengambil konten web, plugin dapat menggunakan klasifikasi berbasis LLM untuk menilai sensitivitas privasi dan menentukan metode pengambilan yang tepat. Klasifikasi tersebut bersifat upaya terbaik dan mungkin mengandung kesalahan. Jangan mengandalkan klasifikasi otomatis sebagai satu-satunya perlindungan untuk informasi sensitif atau rahasia.

**Pengambilan Web & Otomasi Browser.** Plugin ini menyertakan alat untuk otomasi browser tanpa kepala melalui Playwright dan Chrome DevTools. Anda bertanggung jawab untuk memastikan penggunaan Anda mematuhi ketentuan layanan situs web target, kebijakan robots.txt, dan hukum yang berlaku. Penulis tidak bertanggung jawab atas pemblokiran situs, penangguhan akun, pembatasan IP, eksekusi skrip yang tidak terduga, konsumsi sumber daya, atau masalah kompatibilitas yang diakibatkan oleh otomasi browser.

**Server MCP.** Plugin ini terhubung ke server MCP (Model Context Protocol) pihak ketiga. Penulis tidak mengontrol, mengaudit, atau menjamin perilaku atau keamanan server tersebut.

## Atribusi Pihak Ketiga

Plugin ini terintegrasi dengan alat dan layanan eksternal berikut. Tidak ada kode sumber pihak ketiga yang didistribusikan ulang — integrasi dilakukan melalui koneksi server MCP, instalasi paket runtime, dan skrip pembungkus yang dibuat oleh pengembang plugin.

| Alat | Penyedia | Lisensi |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (ketentuan API) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Semua nama produk, logo, dan merek dagang adalah milik pemiliknya masing-masing. Plugin ini tidak berafiliasi dengan atau didukung oleh layanan pihak ketiga mana pun yang tercantum di atas.

## Dukungan

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Laporan bug, permintaan fitur, dan pertanyaan

## Penulis

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Lisensi

[MIT License](../LICENSE) — bebas digunakan, dimodifikasi, dan didistribusikan. Copyright (c) 2026 shidoyu.

