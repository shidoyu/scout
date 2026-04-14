🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 **简体中文** · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **注意：** 本翻译仅供参考。[英文原文](../README.md)为正式版本。

<p align="center">
  <img src="assets/hero.png" alt="scout — 先思考，再搜索。" width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  <a href="https://claude.com/claude-code">Claude Code</a> 的 Web 研究插件。<br>
  将模糊的问题转化为能到达一手来源的优化多引擎查询。
</p>

<p align="center">
  <strong>先思考，再搜索。</strong>
</p>

---

Claude Code 内置的 WebSearch 仅返回 125 个字符的摘要，并且只依赖关键词匹配。这对简单的查询足够了，但真正的研究需要查询设计、来源评估，以及注重隐私的路由。

scout 在搜索之前先进行思考。

## 快速开始

无需 API 密钥。无需更改环境。安装后即可立即使用。

**1. 添加市场**（仅需一次）：

```bash
claude plugin marketplace add shidoyu/scout
```

**2. 安装**：

```bash
claude plugin install scout@shidoyu-scout
```

**3. 重新加载插件**（在 Claude Code 内输入）：

```
/mcp
```

直接向 Claude 提问：

```text
/scout:search 有没有类似 Git blame 但用来追踪设计决策的工具？
```

scout 会将这个模糊的概念转化为正确的术语（ADR — Architecture Decision Records），在多个引擎上执行优化查询，评估来源质量，并附带 Research Trail（展示如何得出答案的记录）返回结果。

## scout 能做什么

### 找到你还说不出名字的概念

> "我知道有这么个概念 — 记录每次设计决策背后原因的方法 — 但我不知道它叫什么"

scout 将模糊的想法转化为精确的术语，并到达一手来源。

### 突破 SEO 噪音

> "从 Terraform 到底应该迁移到哪里 — 不要赞助文章，我要真实的迁移案例"

通过预研获取正确的词汇，然后用针对性的查询绕过内容农场。

### 直达官方文档

> "如何在 Next.js App Router 中设置中间件？"

scout 会先在 [Context7](https://github.com/upstash/context7) 中查找已索引的官方文档。如果答案已经在那里，就无需进行 Web 搜索。

### 读取任意网页

> "获取并总结 https://docs.anthropic.com/en/docs/claude-code"

注重隐私的抓取：公开页面通过云端 API 处理，机密页面在本地处理。

## 设置级别

scout 安装后即可使用。每个级别增加功能 — 全部可选，全部可撤销。

### 级别 1：内置搜索（默认）

使用 Claude Code 的 WebSearch。无需配置。开箱即用的状态。

### 级别 2：官方文档 + 更干净的抓取

添加 [Context7](https://github.com/upstash/context7) 以直接访问库和框架的文档。Jina Reader 的冗余内容清理功能已内置，无需任何配置。它会自动去除页面噪音，让更少的文本占用你的上下文空间。

### 级别 3：语义搜索

添加 [Exa](https://exa.ai) 进行基于语义的搜索 — 即使不知道正确的关键词也能找到相关页面。免费层即可使用基本语义搜索；API 密钥解锁高级功能。

### 级别 4：本地浏览器

添加 [Playwright](https://playwright.dev) 处理 JavaScript 渲染页面和不应发送到外部的机密 URL。需要下载 Chromium（约 200MB）。

**运行 `/scout:setup` 可交互式地逐步配置。** 在进行任何更改之前，会准确显示将要添加到配置中的内容。随时可以重新运行以添加或更新工具。

## 技能

| 技能 | 用途 |
|---|---|
| `/scout:search` | 具备查询设计、来源评估和自动重新搜索的多引擎 Web 搜索 |
| `/scout:fetch` | 基于隐私自动分类的 URL 内容抓取 |
| `/scout:setup` | 搜索引擎和抓取工具的交互式设置向导 |

### Research Trail

每次搜索结束时都会显示一条结构化记录，展示 scout 如何得出答案：

```
🔍 Research Trail
───────────────────────────────
Query:           你的原始问题
Designed queries: scout 实际执行的优化查询
Sources:         带可靠性等级的 URL（🟢 一手来源 / 🟡 二手来源 / ⚪ 三手来源）
Re-searches:     额外搜索及其原因
Confidence:      High / Medium / Low（附理由）
```

## 隐私

scout 在抓取前将 URL 分为三个等级：

| 分类 | 路由 | 示例 |
|---|---|---|
| **公开** | 云端 API（Jina Reader / WebFetch） | 博客、文档、GitHub 公开仓库 |
| **机密** | 仅限本地 Playwright | localhost、内部 Wiki、管理面板 |
| **需认证** | Playwright CDP | Notion、Slack、OAuth 认证后的页面 |

此分类基于 LLM 的判断，而非系统强制执行。请将其视为尽力而为的路由。对于高度敏感的数据，请在处理前验证分类结果。

**机密 URL 即使抓取失败也不会发送到外部 API** — 系统不会对机密页面回退到云端工具。

<details>
<summary>Chrome 调试模式设置（用于需认证的页面）</summary>

要抓取需要登录的页面（OAuth、SaaS 仪表盘等），请以调试模式启动 Chrome： Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>浏览器配置文件说明</summary>

基于 Playwright 的抓取工具使用持久化的浏览器配置文件（`tools/.chrome-profile/`），可能会积累 Cookie 和会话数据。该目录已通过 `.gitignore` 排除在 Git 跟踪之外，但可能会被备份工具复制。如果你抓取过机密页面，请定期删除该目录。
</details>

## 卸载

两条命令即可完全移除。不留任何残留。

移除插件（清理缓存、配置和状态数据）：

```bash
claude plugin uninstall scout@shidoyu-scout
```

移除通过 scout:setup 添加的 Context7（用户级别，会从所有项目中移除）：

```bash
claude mcp remove context7
```

## 环境要求

- **Claude Code**（必需）
- `jq`（仅用于设置诊断）
- Python 3.10+（仅用于 Playwright 本地抓取）

## 安全

API 密钥存储在插件目录内的 `.mcp.json` 中。
**请勿将 `.mcp.json` 提交到 Git。** 分发用模板为 `.mcp.json.dist`。

## 免责声明

本插件根据 MIT 许可证"按原样"提供，不作任何保证。

**外部 API。** 本插件依赖第三方 API（Exa、Jina AI 等）。作者不对这些服务的可用性、准确性、定价或持续性作任何保证，也不对 API 使用产生的费用承担责任。

**API 密钥管理。** API 密钥的获取、保管、管理以及遵守各提供商的服务条款，均由用户自行负责。

**内容分类。** URL 隐私分类基于 LLM 判断，可能存在误差。请勿将其作为保护敏感信息的唯一手段。

**Web 抓取与浏览器自动化。** 本插件包含通过 Playwright 进行的无头浏览器自动化工具。确保使用行为符合目标网站的服务条款、robots.txt 政策及适用法律，由用户自行负责。

**MCP 服务器。** 本插件连接到第三方 MCP 服务器。作者不控制、审计或保证这些服务器的行为或安全性。

## 第三方归属

不重新分发第三方源代码。集成通过 MCP 连接、运行时包安装和包装脚本实现。

| 工具 | 提供者 | 许可证 |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

所有产品名称、徽标和商标均为其各自所有者的财产。

## 语言

设置说明由 AI 助手以您的语言提供。翻译仅供参考 — **英文原文为正式版本**。

## 支持

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Bug 报告、功能请求和问题咨询

## 作者

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## 许可证

[MIT License](../LICENSE) — 可自由使用、修改和分发。Copyright (c) 2026 shidoyu.
