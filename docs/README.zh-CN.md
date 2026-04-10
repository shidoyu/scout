🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 **简体中文** · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **注意：** 本翻译仅供参考。[英文原版](../README.md)为正式版本。

# scout

**Wrong search, wrong decision.**

> 先思考，再搜索。 — Claude Code 网页研究插件。

查询设计、多引擎搜索、隐私感知抓取。

Claude Code 内置的 WebSearch 只返回 125 个字符的片段，并且仅依赖关键词匹配。scout 会把模糊的问题改写成优化过的多引擎查询，评估结果质量，并在需要时重新搜索，从而更快、更可靠地抵达一手来源。

## 功能

- **scout:search** — 带查询设计优化的多引擎网页搜索
- **scout:fetch** — 兼顾隐私分类的 URL 内容获取

## 安装

在终端中运行:

```bash
# 第 1 步：注册 marketplace
claude plugin marketplace add shidoyu/scout
```

```bash
# 第 2 步：安装插件
claude plugin install scout@shidoyu-scout
```

**第 3 步** — 设置搜索引擎和抓取工具

请在 Claude Code 中按顺序逐条运行以下命令：

```text
/reload-plugins
```

```text
/scout:setup
```

scout:setup 将以交互方式引导你配置 Context7（库文档搜索）、Jina Reader（网页抓取）、Exa（语义搜索）和 Playwright（JavaScript 渲染页面）。所有步骤均为可选，可随时跳过。

> **注意：** 如果跳过此步骤，scout 将在下次会话开始时提示你。基本搜索功能无需设置即可立即使用。

## 快速开始

安装后即可使用（无需设置 — 基本搜索功能立即可用）：

### 立即体验

安装后，向 Claude 提问：

**发现你还无法命名的概念：**
> "数据库里那个不用锁也能并发读写的技术叫什么"

**发现本地概念的国际对应：**
> "996工作制在硅谷有对应的说法吗"

**用大白话获取专业知识：**
> "Docker容器里时间和宿主机不一样 差了8小时"

**阅读指定页面：**
> "https://cn.vuejs.org/guide/essentials/reactivity-fundamentals.html 读一下这个页面"

## Skills

### scout:search

智能网页搜索，具备以下能力：
- 预研究以优化查询词
- 多语言查询设计
- 多搜索引擎支持（WebSearch、[Context7](https://github.com/upstash/context7) 官方文档、[Exa](https://exa.ai) 语义搜索）
- HyDE（[假设性文档嵌入](https://arxiv.org/abs/2212.10496)）——通过 Exa 处理概念性查询
- 质量评估与自动重搜索循环

用法：`/scout:search 你的问题`

### scout:fetch

获取网页内容，并自动进行隐私分类：
- **公开页面** → Jina Reader / WebFetch（内置回退方案）
- **机密页面** → 本地 Playwright（不调用外部 API）
- **需登录的页面** → Chrome DevTools（使用浏览器会话）

用法：`/scout:fetch URL`

### scout:setup

搜索引擎和抓取工具的交互式设置向导：
- **Context7** — 直达最新官方库与框架文档，让技术问题更快落到一手文档上（[Context7 MCP](https://github.com/upstash/context7)，无需 API 密钥）
- **Jina Reader** — 以更干净的 Markdown 抓取网页，去掉导航和重复模板内容，通常会减少发送给模型的文本量并节省 token（[免费 API 密钥](https://jina.ai/?newKey)）
- **Exa** — 面向模糊、概念性和小众问题的语义搜索，适合你还不清楚准确术语的时候（[API 密钥](https://exa.ai)）
- **Playwright** — 通过本地浏览器抓取 JavaScript 渲染页面或应留在你机器上的机密页面（下载约 200MB）

所有步骤均为可选。随时重新运行以更新设置。

用法：`/scout:setup`

## 隐私

scout 在获取内容前会将 URL 分为三个级别：
- **公开** → 云端 API（Jina Reader / WebFetch）
- **机密** → 仅使用本地 Playwright（设计意图：机密 URL 不发送至外部 API）
- **需登录** → Chrome DevTools（使用你的浏览器会话）

此分类是自动进行的，但基于 LLM 的判断，并非系统层面的强制保证。详见[隐私免责声明](#隐私免责声明)。

## 依赖要求

- Claude Code
- `jq`（仅供设置时使用）
- `npm`/`npx`（用于 [MCP](https://modelcontextprotocol.io/) 服务器：chrome-devtools）
- Python 3.10+（可选，用于 Playwright 本地获取）
- `uvx` 或 `uv`（可选，用于 MCP 服务器：markitdown——HTML→Markdown 转换）
- Chrome（可选，用于通过 DevTools 获取需登录的页面）

### Chrome DevTools 配置（用于需登录的页面）

若要获取需要登录的页面（OAuth、SaaS 控制台等），Chrome 必须以调试模式启动：

macOS：

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

Linux：

```bash
google-chrome --remote-debugging-port=9222
```

## 隐私免责声明

scout 根据敏感程度对 URL 进行分类，并将机密 URL 路由至仅限本地的工具处理。
此分类基于 LLM 的判断（域名模式与上下文），**并非系统强制保证**。
对于高度敏感的数据，请在处理前确认分类结果是否正确。

**浏览器配置文件。** 基于 Playwright 的获取工具（`fetch-page.py`）使用持久化浏览器配置文件（`tools/.chrome-profile/`），该目录可能会积累 Cookie、会话数据及浏览历史。此目录已通过 `.gitignore` 排除于 Git 之外，但可能被备份工具或云同步服务复制。如果你获取了机密页面，请定期删除该目录。

## 语言说明

配置说明将由 AI 助手以你的语言提供。
翻译内容仅供参考——**英文原版为权威版本**。

## 安全提示

设置后，API 密钥将存储在 `.mcp.json` 中。
**请勿将 `.mcp.json` 提交至 Git。** 请使用 `.mcp.json.dist` 作为分发模板。

## 免责声明

本插件依据 MIT 许可证"按原样"提供，不附带任何形式的保证。

**外部 API。** 本插件依赖第三方 API（Exa、Jina AI 等）。作者对这些服务的可用性、准确性、定价或持续性不作任何保证，亦不对因 API 使用产生的费用承担责任。

**API 密钥管理。** 你须独自负责获取、保管和管理自己的 API 密钥，并遵守各服务提供商的使用条款。

**内容分类。** 在获取网页内容时，本插件可能使用基于 LLM 的分类来评估隐私敏感度并确定适当的获取方式。此类分类属于尽力而为，可能存在误判。请勿将自动分类作为敏感或机密信息的唯一保护措施。

**网页获取与浏览器自动化。** 本插件包含通过 Playwright 和 Chrome DevTools 进行无头浏览器自动化的工具。你须自行确保使用行为符合目标网站的服务条款、robots.txt 规定及适用法律。作者对因浏览器自动化导致的站点封锁、账号停用、IP 限制、意外脚本执行、资源消耗或兼容性问题不承担任何责任。

**MCP 服务器。** 本插件连接第三方 MCP（Model Context Protocol）服务器。作者不控制、审计或保证这些服务器的行为或安全性。

## 第三方声明

本插件与以下外部工具和服务集成。不重新分发任何第三方源代码——集成方式为 MCP 服务器连接、运行时包安装以及由插件开发者编写的包装脚本。

| 工具 | 提供方 | 许可证 |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | 专有（API 条款） |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

所有产品名称、徽标和商标均归其各自所有者所有。本插件与上述任何第三方服务无关联，亦未获其认可。

## 支持

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — 问题反馈、功能请求及提问

## 作者

**SHIDO, Yuichiro**（[@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)）— AI Operations Designer

## 许可证

[MIT License](../LICENSE) — 可自由使用、修改和分发。Copyright (c) 2026 shidoyu.

