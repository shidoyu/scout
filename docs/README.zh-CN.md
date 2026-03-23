🇯🇵 [日本語](docs/README.ja.md) · 🇰🇷 [한국어](docs/README.ko.md) · 🇨🇳 **简体中文** · 🇹🇼 [繁體中文](docs/README.zh-TW.md) · 🇧🇷 [Português](docs/README.pt-BR.md) · 🇩🇪 [Deutsch](docs/README.de.md) · 🇪🇸 [Español](docs/README.es.md) · 🇫🇷 [Français](docs/README.fr.md) · 🇮🇱 [עברית](docs/README.he.md) · 🇪🇪 [Eesti](docs/README.et.md) · 🇸🇪 [Svenska](docs/README.sv.md)

> **注意：** 本翻译仅供参考。[英文原版](../README.md)为正式版本。

# scout — 网页搜索与内容获取

Claude Code 内置的 WebSearch 仅返回 125 个字符的摘要片段，且只依赖关键词匹配。scout 能将模糊的问题转化为经过优化的多引擎查询，评估结果质量，并在必要时重新搜索——更快、更可靠地触达一手信息来源。

## 功能

- **scout:search** — 带查询设计优化的多引擎网页搜索
- **scout:fetch** — 兼顾隐私分类的 URL 内容获取

## 安装

```bash
claude plugin add shidoyu/scout
```

## 快速开始

安装后即可立即使用——搜索功能使用 WebSearch（内置）和 Exa（免费，无需 API 密钥）。可选配置可解锁更多功能：

```bash
bash tools/setup.sh
```

## Skills

### scout:search

智能网页搜索，具备以下能力：
- 预研究以优化查询词
- 多语言查询设计
- 多搜索引擎支持（WebSearch、[Exa](https://exa.ai) 语义搜索）
- HyDE（[假设性文档嵌入](https://arxiv.org/abs/2212.10496)）——通过 Exa 处理概念性查询
- 质量评估与自动重搜索循环

用法：`/scout:search 你的问题`

### scout:fetch

获取网页内容，并自动进行隐私分类：
- **公开页面** → Jina Reader（需要 API 密钥）/ WebFetch（内置回退方案）
- **机密页面** → 本地 Playwright（不调用外部 API）
- **需登录的页面** → Chrome DevTools（使用浏览器会话）

用法：`/scout:fetch URL`

## 配置（可选）

运行 `tools/setup.sh` 进行配置：

1. **Exa** — 先进的 AI 原生搜索工具（付费功能需要 API 密钥；免费版无需配置即可使用）
2. **Jina Reader** — 将网页高质量转换为 Markdown（需要 API 密钥；不配置时公开页面回退至 WebFetch）
3. **Playwright** — 基于浏览器的获取方式，适用于 JavaScript 渲染页面及机密页面（下载约 200MB）

所有步骤均可跳过。随时重新运行以更新设置。
配置完成后，请重启 Claude Code（或运行 `/mcp`）以使新的 MCP 服务器生效。

## 隐私

scout 在获取内容前会将 URL 分为三个级别：
- **公开** → 云端 API（Jina Reader / WebFetch）
- **机密** → 仅使用本地 Playwright（设计意图：机密 URL 不发送至外部 API）
- **需登录** → Chrome DevTools（使用你的浏览器会话）

此分类是自动进行的，但基于 LLM 的判断，并非系统层面的强制保证。详见[隐私免责声明](#隐私免责声明)。

## 依赖要求

- Claude Code
- `jq`（仅供安装脚本使用）
- `npm`/`npx`（用于 [MCP](https://modelcontextprotocol.io/) 服务器：chrome-devtools）
- Python 3.10+（可选，用于 Playwright 本地获取）
- `uvx` 或 `uv`（可选，用于 MCP 服务器：markitdown——HTML→Markdown 转换）
- Chrome（可选，用于通过 DevTools 获取需登录的页面）

### Chrome DevTools 配置（用于需登录的页面）

若要获取需要登录的页面（OAuth、SaaS 控制台等），Chrome 必须以调试模式启动：

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
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

运行 `setup.sh` 后，API 密钥将存储在 `.mcp.json` 中。
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

