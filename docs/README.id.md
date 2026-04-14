🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 **Bahasa Indonesia** · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Catatan:** Terjemahan ini disediakan untuk kemudahan saja. [Versi asli dalam bahasa Inggris](../README.md) adalah versi resmi.

<p align="center">
  <img src="assets/hero.png" alt="scout — Berpikir dulu. Baru cari." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Plugin riset web untuk <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Mengubah pertanyaan samar menjadi kueri multi-mesin yang dioptimalkan untuk mencapai sumber primer.
</p>

<p align="center">
  <strong>Berpikir dulu. Baru cari.</strong>
</p>

---

WebSearch bawaan Claude Code mengembalikan cuplikan 125 karakter dan hanya mengandalkan pencocokan kata kunci. Itu cukup untuk pencarian sederhana — tapi untuk riset sesungguhnya, Anda perlu desain kueri, evaluasi sumber, dan routing yang memperhatikan privasi.

scout berpikir sebelum mencari.

## Mulai Cepat

Tidak perlu API key. Tidak perlu mengubah environment. Instal dan langsung coba:

**1. Tambahkan marketplace** (satu kali):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Instal**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Muat ulang plugin** (ketik di dalam Claude Code):

```
/mcp
```

Lalu tanyakan ke Claude:

```text
/scout:search Saya ingin sesuatu seperti Git blame tapi untuk keputusan desain
```

scout akan mengubah konsep samar ini menjadi istilah yang tepat (ADR — Architecture Decision Records), menjalankan kueri yang dioptimalkan di beberapa mesin, mengevaluasi kualitas sumber, dan memberikan jawaban dengan Research Trail yang menunjukkan persis bagaimana ia sampai ke sana.

## Apa yang scout lakukan

### Temukan konsep yang belum Anda ketahui namanya

> "Saya tahu konsep ini ada — sesuatu tentang mencatat alasan di balik setiap keputusan desain — tapi saya tidak tahu namanya"

scout menerjemahkan ide yang kabur menjadi terminologi yang tepat dan mencapai sumber primer.

### Terobos noise SEO

> "Sebenarnya harus migrasi ke mana dari Terraform — bukan daftar bersponsor, cerita migrasi yang nyata"

Pra-riset memperoleh kosakata yang tepat, lalu kueri terarah melewati content farm.

### Langsung ke dokumentasi resmi

> "Bagaimana cara mengatur middleware di Next.js App Router?"

scout memeriksa [Context7](https://github.com/upstash/context7) terlebih dahulu untuk dokumentasi resmi yang sudah diindeks — tidak perlu pencarian web jika jawabannya ada di sana.

### Baca halaman web apa saja

> "Ambil dan ringkas https://docs.anthropic.com/en/docs/claude-code"

Pengambilan yang memperhatikan privasi: halaman publik melalui API cloud, halaman rahasia tetap di mesin Anda.

## Level Setup

scout langsung bekerja setelah instalasi. Setiap level menambah kemampuan — semuanya opsional, semuanya bisa dibatalkan.

### Level 1: Pencarian Bawaan (default)

Menggunakan WebSearch milik Claude Code. Tidak perlu konfigurasi. Inilah yang Anda dapatkan langsung.

### Level 2: Dokumentasi Resmi + Pengambilan Lebih Bersih

Tambahkan [Context7](https://github.com/upstash/context7) untuk akses langsung ke dokumentasi library dan framework. Pembersihan konten berlebih oleh Jina Reader sudah bawaan — tidak perlu pengaturan apa pun. Noise halaman otomatis dihapus sehingga lebih sedikit teks yang mengisi konteks Anda.

### Level 3: Pencarian Semantik

Tambahkan [Exa](https://exa.ai) untuk pencarian berbasis makna — menemukan halaman yang relevan meskipun Anda tidak tahu kata kunci yang tepat. Pencarian semantik dasar bekerja dengan tier gratis; API key membuka fitur lanjutan.

### Level 4: Browser Lokal

Tambahkan [Playwright](https://playwright.dev) untuk halaman yang di-render JavaScript dan URL rahasia yang tidak boleh keluar dari mesin Anda. Memerlukan unduhan Chromium (~200MB).

**Jalankan `/scout:setup` untuk mengatur setiap level secara interaktif.** Setiap langkah menunjukkan persis apa yang akan ditambahkan ke konfigurasi Anda sebelum perubahan apa pun dilakukan. Jalankan kapan saja untuk menambah atau memperbarui alat.

## Skill

| Skill | Tujuan |
|---|---|
| `/scout:search` | Pencarian web multi-mesin dengan desain kueri, evaluasi sumber, dan pencarian ulang otomatis |
| `/scout:fetch` | Pengambilan konten URL dengan klasifikasi privasi otomatis |
| `/scout:setup` | Setup terpandu interaktif untuk mesin pencari dan alat pengambilan |

### Research Trail

Setiap pencarian diakhiri dengan jejak terstruktur yang menunjukkan bagaimana scout mencapai jawabannya:

```
🔍 Research Trail
───────────────────────────────
Query:           pertanyaan asli Anda
Designed queries: kueri yang dioptimalkan yang benar-benar dijalankan scout
Sources:         URL dengan tingkat keandalan (🟢 primer / 🟡 sekunder / ⚪ tersier)
Re-searches:     pencarian tambahan dan alasannya
Confidence:      High / Medium / Low beserta alasan
```

## Privasi

scout mengklasifikasikan URL ke dalam tiga tingkat sebelum mengambil:

| Klasifikasi | Routing | Contoh |
|---|---|---|
| **Publik** | API Cloud (Jina Reader / WebFetch) | Blog, dokumentasi, repo publik GitHub |
| **Rahasia** | Hanya Playwright lokal | localhost, wiki internal, panel admin |
| **Terautentikasi** | Playwright CDP | Notion, Slack, halaman setelah OAuth |

Klasifikasi ini berdasarkan penilaian LLM, bukan penegakan sistem. Perlakukan sebagai routing best-effort. Untuk data yang sangat sensitif, verifikasi klasifikasinya sebelum melanjutkan.

**URL rahasia tidak pernah dikirim ke API eksternal, bahkan saat gagal** — sistem tidak melakukan fallback ke alat cloud untuk halaman rahasia.

<details>
<summary>Setup mode debug Chrome (untuk halaman terautentikasi)</summary>

Untuk mengambil halaman yang memerlukan login (OAuth, dashboard SaaS), jalankan Chrome dalam mode debug. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Catatan profil browser</summary>

Fetcher berbasis Playwright menggunakan profil browser persisten (`tools/.chrome-profile/`) yang mungkin mengakumulasi cookie dan data sesi. Direktori ini dikecualikan dari Git melalui `.gitignore` tapi mungkin disalin oleh alat backup. Hapus secara berkala jika Anda mengambil halaman rahasia.
</details>

## Uninstall

Dua perintah untuk menghapus semuanya. Tidak ada sisa.

Hapus plugin (membersihkan cache, konfigurasi, dan data state):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Hapus Context7 jika Anda menambahkannya melalui scout:setup (cakupan user — menghapus dari semua proyek):

```bash
claude mcp remove context7
```

## Persyaratan

- **Claude Code** (wajib)
- `jq` (hanya untuk diagnostik setup)
- Python 3.10+ (hanya untuk pengambilan lokal Playwright)

## Keamanan

API key disimpan di `.mcp.json` dalam direktori plugin.
**Jangan commit `.mcp.json` ke Git.** Template `.mcp.json.dist` aman untuk didistribusikan.

## Disclaimer

Plugin ini disediakan "apa adanya" di bawah Lisensi MIT, tanpa jaminan apa pun.

**API Eksternal.** Plugin ini bergantung pada API pihak ketiga (Exa, Jina AI, dan lainnya). Penulis tidak memberikan jaminan tentang ketersediaan, akurasi, harga, atau keberlangsungan layanan ini dan tidak bertanggung jawab atas biaya yang timbul dari penggunaan API.

**Manajemen API Key.** Anda sepenuhnya bertanggung jawab untuk memperoleh, mengamankan, dan mengelola API key Anda sendiri, serta mematuhi ketentuan layanan setiap penyedia.

**Klasifikasi Konten.** Klasifikasi privasi URL berdasarkan penilaian LLM dan mungkin mengandung kesalahan. Jangan mengandalkannya sebagai satu-satunya perlindungan untuk informasi sensitif.

**Web Fetching & Automasi Browser.** Plugin ini menyertakan alat automasi browser headless melalui Playwright. Anda bertanggung jawab untuk memastikan penggunaan Anda mematuhi ketentuan layanan situs target, kebijakan robots.txt, dan hukum yang berlaku.

**Server MCP.** Plugin ini terhubung ke server MCP pihak ketiga. Penulis tidak mengontrol, mengaudit, atau menjamin perilaku atau keamanan server-server ini.

## Atribusi Pihak Ketiga

Tidak ada kode sumber pihak ketiga yang didistribusikan ulang — integrasi dilakukan melalui koneksi MCP, instalasi paket runtime, dan skrip wrapper.

| Alat | Penyedia | Lisensi |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Semua nama produk, logo, dan merek dagang adalah milik pemiliknya masing-masing.

## Bahasa

Instruksi setup disediakan dalam bahasa Anda oleh asisten AI. Terjemahan ini untuk kemudahan — **versi asli bahasa Inggris adalah yang berwenang**.

## Dukungan

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Laporan bug, permintaan fitur, dan pertanyaan

## Penulis

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Lisensi

[MIT License](../LICENSE) — bebas digunakan, dimodifikasi, dan didistribusikan. Copyright (c) 2026 shidoyu.
