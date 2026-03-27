🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 **繁體中文** · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **注意：** 此翻譯僅供參考。[英文原版](../README.md)為正式版本。

# scout — 網路搜尋與內容擷取

Claude Code 內建的 WebSearch 僅回傳 125 字元的摘要片段，且只依賴關鍵字比對。scout 能將模糊的問題轉化為最佳化的多引擎查詢，評估結果品質，並在必要時重新搜尋——更快速、更可靠地觸及一次資料來源。

## 功能特色

- **scout:search** — 多引擎網路搜尋，內建查詢設計最佳化
- **scout:fetch** — URL 內容擷取，具備隱私感知的工具選擇機制

## 安裝

在終端機中執行:

```bash
# 第 1 步：註冊 marketplace
claude plugin marketplace add shidoyu/scout

# 第 2 步：安裝外掛程式
claude plugin install scout@shidoyu-scout
```

## 快速開始

安裝後即可立即使用——搜尋功能使用 WebSearch（內建）與 Exa（免費，無需 API 金鑰）。選擇性設定可解鎖更多功能：

```bash
bash tools/setup.sh
```

### 立即體驗

安裝後，向 Claude 提問：

**發現你還無法命名的概念：**
> 「API 回傳太快前端來不及處理 要怎麼控制速度」

**發現台灣概念的國際對應：**
> 「台灣的電子發票系統在其他國家有類似的東西嗎」

**用白話獲取專業知識：**
> 「Mac 上開發的 Node.js 專案部署到 Linux 後 require 找不到模組 但路徑明明一樣」

**閱讀指定頁面：**
> 「https://react.dev/reference/react/useState 幫我讀這個頁面」

## Skills

### scout:search

智慧型網路搜尋，具備以下能力：
- 預搜尋以精鍊查詢
- 多語言查詢設計
- 多種搜尋引擎（WebSearch、[Exa](https://exa.ai) 語意搜尋）
- HyDE（[假設文件嵌入](https://arxiv.org/abs/2212.10496)）透過 Exa 處理概念性查詢
- 品質評估與自動重新搜尋循環

使用方式：`/scout:search 你的問題`

### scout:fetch

擷取網頁內容，並自動進行隱私等級分類：
- **公開頁面** → Jina Reader（需要 API 金鑰）/ WebFetch（內建備援）
- **機密頁面** → 本地 Playwright（不呼叫外部 API）
- **需驗證的頁面** → Chrome DevTools（使用瀏覽器工作階段）

使用方式：`/scout:fetch URL`

## 設定（選擇性）

執行 `tools/setup.sh` 來進行設定：

1. **Exa** — 進階 AI 原生搜尋工具（付費功能需要 API 金鑰；免費方案無需設定即可使用）
2. **Jina Reader** — 高品質網頁擷取為 Markdown 格式（需要 API 金鑰；若未設定，公開頁面將退回使用 WebFetch）
3. **Playwright** — 以瀏覽器為基礎的擷取工具，適用於 JavaScript 渲染及機密頁面（下載約 200MB）

所有步驟均可跳過。可隨時重新執行以更新設定。
設定完成後，請重新啟動 Claude Code（或執行 `/mcp`）使新的 MCP 伺服器生效。

## 隱私

scout 在擷取前會將 URL 分為三個等級：
- **公開** → 雲端 API（Jina Reader / WebFetch）
- **機密** → 僅使用本地 Playwright（預定路由：機密 URL 不會傳送至外部 API）
- **需驗證** → Chrome DevTools（使用您的瀏覽器工作階段）

此分類為自動進行，但基於 LLM 判斷，非系統強制保證。詳情請參閱[隱私免責聲明](#隱私免責聲明)。

## 系統需求

- Claude Code
- `jq`（僅設定腳本需要）
- `npm`/`npx`（用於 [MCP](https://modelcontextprotocol.io/) 伺服器：chrome-devtools）
- Python 3.10+（選擇性，用於 Playwright 本地擷取）
- `uvx` 或 `uv`（選擇性，用於 MCP 伺服器：markitdown — HTML→Markdown 轉換）
- Chrome（選擇性，用於透過 DevTools 擷取需驗證的頁面）

### Chrome DevTools 設定（用於需驗證的頁面）

若要擷取需要登入的頁面（OAuth、SaaS 儀表板），Chrome 必須以偵錯模式執行：

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## 隱私免責聲明

scout 依敏感度分類 URL，並將機密 URL 路由至僅限本地的工具。
此分類基於 LLM 判斷（網域模式與上下文），**並非系統強制的保證**。
對於高度敏感的資料，請在處理前自行確認分類結果。

**瀏覽器設定檔。** 基於 Playwright 的擷取工具（`fetch-page.py`）使用持久性瀏覽器設定檔（`tools/.chrome-profile/`），可能會累積 cookie、工作階段資料及瀏覽紀錄。此目錄已透過 `.gitignore` 排除在 Git 之外，但可能被備份工具或雲端同步服務複製。若您擷取機密頁面，請定期刪除此目錄。

## 語言

設定說明由 AI 助理以您的語言提供。
翻譯版說明僅供參考——**英文原版為正式版本**。

## 安全性注意事項

執行 `setup.sh` 後，API 金鑰將儲存於 `.mcp.json`。
**請勿將 `.mcp.json` 提交至 Git。** 請使用 `.mcp.json.dist` 作為發佈用範本。

## 免責聲明

本外掛程式依 MIT 授權條款「按現狀」提供，不附任何形式的保證。

**外部 API。** 本外掛程式依賴第三方 API（Exa、Jina AI 及其他服務）。作者對這些服務的可用性、準確性、定價或持續性不作任何保證，亦不對因 API 使用而產生的費用負責。

**API 金鑰管理。** 您須自行負責取得、保管及管理您的 API 金鑰，並遵守各服務提供商的服務條款。

**內容分類。** 在擷取網頁內容時，本外掛程式可能使用基於 LLM 的分類來評估隱私敏感度並決定適當的擷取方式。此類分類為盡力而為，可能存在錯誤。請勿將自動分類作為敏感或機密資訊的唯一保護措施。

**網頁擷取與瀏覽器自動化。** 本外掛程式包含透過 Playwright 和 Chrome DevTools 進行無頭瀏覽器自動化的工具。您須確保您的使用符合目標網站的服務條款、robots.txt 規範及適用法律。作者對因瀏覽器自動化而導致的網站封鎖、帳號停權、IP 限制、意外腳本執行、資源消耗或相容性問題概不負責。

**MCP 伺服器。** 本外掛程式連接第三方 MCP（Model Context Protocol）伺服器。作者不控制、審核或保證這些伺服器的行為或安全性。

## 第三方聲明

本外掛程式整合以下外部工具與服務。不重新發佈任何第三方原始碼——整合方式為 MCP 伺服器連線、執行時期套件安裝，以及由外掛程式開發者撰寫的包裝腳本。

| 工具 | 提供商 | 授權條款 |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | 專有（API 條款） |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

所有產品名稱、標誌及商標均為其各自所有人的財產。本外掛程式與上述任何第三方服務均無關聯，亦未獲得其背書。

## 支援

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — 錯誤回報、功能請求與問題諮詢

## 作者

**SHIDO, Yuichiro**（[@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)）— AI Operations Designer

## 授權條款

[MIT License](../LICENSE) — 可自由使用、修改及散佈。Copyright (c) 2026 shidoyu.

