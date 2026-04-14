🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 **繁體中文** · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **注意：** 本翻譯僅供參考。[英文原文](../README.md)為正式版本。

<p align="center">
  <img src="assets/hero.png" alt="scout — 先思考，再搜尋。" width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  <a href="https://claude.com/claude-code">Claude Code</a> 的 Web 研究外掛。<br>
  將模糊的問題轉化為能抵達一手來源的最佳化多引擎查詢。
</p>

<p align="center">
  <strong>先思考，再搜尋。</strong>
</p>

---

Claude Code 內建的 WebSearch 僅回傳 125 個字元的摘要，且只依賴關鍵字比對。這對簡單的查詢已經足夠，但真正的研究需要查詢設計、來源評估，以及注重隱私的路由。

scout 在搜尋之前先進行思考。

## 快速開始

無需 API 金鑰。無需更改環境。安裝後即可立即使用。

**1. 新增市集**（僅需一次）：

```bash
claude plugin marketplace add shidoyu/scout
```

**2. 安裝**：

```bash
claude plugin install scout@shidoyu-scout
```

**3. 重新載入外掛**（在 Claude Code 內輸入）：

```
/mcp
```

直接向 Claude 提問：

```text
/scout:search 有沒有類似 Git blame 但用來追蹤設計決策的工具？
```

scout 會將這個模糊的概念轉化為正確的術語（ADR — Architecture Decision Records），在多個引擎上執行最佳化查詢，評估來源品質，並附帶 Research Trail（展示如何得出答案的紀錄）回傳結果。

## scout 能做什麼

### 找到你還說不出名字的概念

> 「我知道有這種概念 — 記錄每次設計決策背後原因的方法 — 但我不知道它叫什麼」

scout 將模糊的想法轉化為精確的術語，並抵達一手來源。

### 突破 SEO 雜訊

> 「從 Terraform 到底應該遷移到哪裡 — 不要贊助文章，我要真實的遷移案例」

透過預研取得正確的詞彙，再用針對性的查詢繞過內容農場。

### 直達官方文件

> 「如何在 Next.js App Router 中設定 middleware？」

scout 會先在 [Context7](https://github.com/upstash/context7) 中查詢已索引的官方文件。如果答案已經在那裡，就無需進行 Web 搜尋。

### 讀取任意網頁

> 「擷取並摘要 https://docs.anthropic.com/en/docs/claude-code」

注重隱私的擷取：公開頁面透過雲端 API 處理，機密頁面在本機處理。

## 設定層級

scout 安裝後即可使用。每個層級增加功能 — 全部可選，全部可復原。

### 層級 1：內建搜尋（預設）

使用 Claude Code 的 WebSearch。無需設定。開箱即用的狀態。

### 層級 2：官方文件 + 更乾淨的擷取

加入 [Context7](https://github.com/upstash/context7) 以直接存取函式庫與框架的文件。Jina Reader 的冗餘內容清理功能已內建，無需任何設定。它會自動去除頁面雜訊，讓更少的文字佔用你的上下文空間。

### 層級 3：語意搜尋

新增 [Exa](https://exa.ai) 進行基於語意的搜尋 — 即使不知道正確的關鍵字也能找到相關頁面。免費方案即可使用基本語意搜尋；API 金鑰解鎖進階功能。

### 層級 4：本機瀏覽器

新增 [Playwright](https://playwright.dev) 處理 JavaScript 算繪頁面和不應傳送到外部的機密 URL。需要下載 Chromium（約 200MB）。

**執行 `/scout:setup` 可互動式地逐步設定。** 在進行任何變更之前，會精確顯示將要新增到設定中的內容。隨時可以重新執行以新增或更新工具。

## 技能

| 技能 | 用途 |
|---|---|
| `/scout:search` | 具備查詢設計、來源評估和自動重新搜尋的多引擎 Web 搜尋 |
| `/scout:fetch` | 基於隱私自動分類的 URL 內容擷取 |
| `/scout:setup` | 搜尋引擎和擷取工具的互動式設定精靈 |

### Research Trail

每次搜尋結束時都會顯示一筆結構化紀錄，展示 scout 如何得出答案：

```
🔍 Research Trail
───────────────────────────────
Query:           你的原始問題
Designed queries: scout 實際執行的最佳化查詢
Sources:         附可靠性等級的 URL（🟢 一手來源 / 🟡 二手來源 / ⚪ 三手來源）
Re-searches:     額外搜尋及其原因
Confidence:      High / Medium / Low（附理由）
```

## 隱私

scout 在擷取前將 URL 分為三個等級：

| 分類 | 路由 | 範例 |
|---|---|---|
| **公開** | 雲端 API（Jina Reader / WebFetch） | 部落格、文件、GitHub 公開儲存庫 |
| **機密** | 僅限本機 Playwright | localhost、內部 Wiki、管理面板 |
| **需認證** | Playwright CDP | Notion、Slack、OAuth 認證後的頁面 |

此分類基於 LLM 的判斷，而非系統強制執行。請將其視為盡力而為的路由。對於高度敏感的資料，請在處理前驗證分類結果。

**機密 URL 即使擷取失敗也不會傳送到外部 API** — 系統不會對機密頁面回退到雲端工具。

<details>
<summary>Chrome 偵錯模式設定（用於需認證的頁面）</summary>

要擷取需要登入的頁面（OAuth、SaaS 儀表板等），請以偵錯模式啟動 Chrome： Chrome 146+ requires a separate `--user-data-dir`:

macOS：

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --remote-debugging-port=9222 \
  --user-data-dir=$HOME/.chrome-debug
```

Linux：

```bash
google-chrome --remote-debugging-port=9222 --user-data-dir=$HOME/.chrome-debug
```

On first launch with a new `--user-data-dir`, you'll need to log in to your accounts again. After that, sessions persist across restarts.
</details>

<details>
<summary>瀏覽器設定檔說明</summary>

基於 Playwright 的擷取工具使用持久化的瀏覽器設定檔（`tools/.chrome-profile/`），可能會累積 Cookie 和工作階段資料。該目錄已透過 `.gitignore` 排除在 Git 追蹤之外，但可能會被備份工具複製。如果你擷取過機密頁面，請定期刪除該目錄。
</details>

## 解除安裝

兩條指令即可完全移除。不留任何殘留。

移除外掛（清理快取、設定和狀態資料）：

```bash
claude plugin uninstall scout@shidoyu-scout
```

移除透過 scout:setup 新增的 Context7（使用者層級，會從所有專案中移除）：

```bash
claude mcp remove context7
```

## 環境需求

- **Claude Code**（必要）
- `jq`（僅用於設定診斷）
- Python 3.10+（僅用於 Playwright 本機擷取）

## 安全性

API 金鑰儲存在外掛目錄內的 `.mcp.json` 中。
**請勿將 `.mcp.json` 提交到 Git。** 散佈用範本為 `.mcp.json.dist`。

## 免責聲明

本外掛依據 MIT 授權條款「按原樣」提供，不作任何保證。

**外部 API。** 本外掛依賴第三方 API（Exa、Jina AI 等）。作者不對這些服務的可用性、準確性、定價或持續性作任何保證，也不對 API 使用產生的費用承擔責任。

**API 金鑰管理。** API 金鑰的取得、保管、管理以及遵守各提供者的服務條款，均由使用者自行負責。

**內容分類。** URL 隱私分類基於 LLM 判斷，可能存在誤差。請勿將其作為保護敏感資訊的唯一手段。

**Web 擷取與瀏覽器自動化。** 本外掛包含透過 Playwright 進行的無頭瀏覽器自動化工具。確保使用行為符合目標網站的服務條款、robots.txt 政策及適用法律，由使用者自行負責。

**MCP 伺服器。** 本外掛連接到第三方 MCP 伺服器。作者不控制、稽核或保證這些伺服器的行為或安全性。

## 第三方歸屬

不重新散佈第三方原始碼。整合透過 MCP 連線、執行時期套件安裝和包裝腳本實現。

| 工具 | 提供者 | 授權條款 |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

所有產品名稱、標誌和商標均為其各自擁有者的財產。

## 語言

設定說明由 AI 助手以您的語言提供。翻譯僅供參考 — **英文原文為正式版本**。

## 支援

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Bug 回報、功能請求和問題諮詢

## 作者

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## 授權條款

[MIT License](../LICENSE) — 可自由使用、修改和散佈。Copyright (c) 2026 shidoyu.
