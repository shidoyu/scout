🇯🇵 [日本語](README.ja.md) · 🇰🇷 **한국어** · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **참고:** 이 번역은 편의를 위한 것입니다. [영어 원문](../README.md)이 정식 버전입니다.

# scout — 웹 검색 및 콘텐츠 가져오기

Claude Code 내장 WebSearch는 125자 길이의 스니펫만 반환하며, 키워드 매칭에만 의존합니다. scout는 모호한 질문을 최적화된 멀티엔진 쿼리로 변환하고, 결과 품질을 평가하며, 필요에 따라 재검색을 수행해 더 빠르고 안정적으로 1차 출처에 도달합니다.

## 기능

- **scout:search** — 쿼리 설계 최적화를 갖춘 멀티엔진 웹 검색
- **scout:fetch** — 프라이버시를 고려한 도구 선택으로 URL 콘텐츠 가져오기

## 설치

```bash
claude plugin add shidoyu/scout
```

## 빠른 시작

scout는 설치 즉시 사용할 수 있습니다. 검색에는 WebSearch(내장)와 Exa(무료, 키 불필요)가 사용됩니다. 선택적 설정으로 더 많은 기능을 추가할 수 있습니다:

```bash
bash tools/setup.sh
```

## 스킬

### scout:search

지능형 웹 검색 기능:
- 쿼리 개선을 위한 사전 조사
- 다국어 쿼리 설계
- 복수의 검색 엔진 사용 (WebSearch, [Exa](https://exa.ai) 시맨틱 검색)
- Exa를 통한 개념적 쿼리에 HyDE([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) 적용
- 자동 재검색 루프를 포함한 품질 평가

사용법: `/scout:search 검색하려는 내용`

### scout:fetch

자동 프라이버시 분류를 통한 웹 페이지 콘텐츠 가져오기:
- **공개 페이지** → Jina Reader (API 키 필요) / WebFetch (내장 폴백)
- **기밀 페이지** → 로컬 Playwright (외부 API 호출 없음)
- **인증 필요 페이지** → Chrome DevTools (브라우저 세션 사용)

사용법: `/scout:fetch URL`

## 설정 (선택 사항)

`tools/setup.sh`를 실행하여 다음을 구성합니다:

1. **Exa** — 고급 AI 네이티브 검색 도구 (유료 기능에는 API 키 필요; 무료 티어는 설정 없이 사용 가능)
2. **Jina Reader** — 웹 페이지를 Markdown으로 고품질 가져오기 (API 키 필요; 없을 경우 공개 페이지는 WebFetch로 폴백)
3. **Playwright** — JavaScript 렌더링 페이지 및 기밀 페이지를 위한 브라우저 기반 가져오기 (~200MB 다운로드)

모든 단계는 건너뛸 수 있습니다. 설정 변경 시 언제든지 재실행할 수 있습니다.
설정 후 새 MCP 서버가 적용되려면 Claude Code를 재시작하거나 `/mcp`를 실행하세요.

## 프라이버시

scout는 콘텐츠를 가져오기 전에 URL을 세 가지 수준으로 분류합니다:
- **공개** → 클라우드 API (Jina Reader / WebFetch)
- **기밀** → 로컬 Playwright 전용 (의도된 라우팅: 기밀 URL은 외부 API로 전송되지 않음)
- **인증 필요** → Chrome DevTools (브라우저 세션 사용)

이 분류는 자동으로 이루어지지만 시스템 강제가 아닌 LLM 판단에 기반합니다. 자세한 내용은 [프라이버시 고지](#프라이버시-고지)를 참조하세요.

## 요구 사항

- Claude Code
- `jq` (설정 스크립트에만 필요)
- `npm`/`npx` ([MCP](https://modelcontextprotocol.io/) 서버: chrome-devtools)
- Python 3.10+ (선택 사항, Playwright 로컬 가져오기용)
- `uvx` 또는 `uv` (선택 사항, MCP 서버: markitdown — HTML→Markdown 변환)
- Chrome (선택 사항, DevTools를 통한 인증 페이지 가져오기용)

### Chrome DevTools 설정 (인증 필요 페이지용)

로그인이 필요한 페이지(OAuth, SaaS 대시보드 등)를 가져오려면 Chrome을 디버그 모드로 실행해야 합니다:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## 프라이버시 고지

scout는 URL을 민감도에 따라 분류하고 기밀 URL을 로컬 전용 도구로 라우팅합니다.
이 분류는 LLM 판단(도메인 패턴 및 컨텍스트)에 기반하며, **시스템이 강제하는 보장이 아닙니다**.
매우 민감한 데이터의 경우 진행하기 전에 분류를 직접 확인하세요.

**브라우저 프로필.** Playwright 기반 가져오기 도구(`fetch-page.py`)는 영구 브라우저 프로필(`tools/.chrome-profile/`)을 사용하며, 여기에 쿠키, 세션 데이터, 브라우징 기록이 누적될 수 있습니다. 이 디렉터리는 `.gitignore`를 통해 Git에서 제외되지만 백업 도구나 클라우드 동기화 서비스에 의해 복사될 수 있습니다. 기밀 페이지를 가져오는 경우 주기적으로 해당 디렉터리를 삭제하세요.

## 언어

설정 안내는 AI 어시스턴트가 사용자의 언어로 제공합니다.
번역된 안내는 편의를 위한 것입니다. **영어 원문이 정식 버전입니다**.

## 보안 주의사항

`setup.sh` 실행 후 API 키는 `.mcp.json`에 저장됩니다.
**`.mcp.json`을 Git에 커밋하지 마세요.** 배포용 템플릿으로는 `.mcp.json.dist`를 사용하세요.

## 면책 조항

이 플러그인은 MIT 라이선스에 따라 어떠한 보증 없이 "있는 그대로" 제공됩니다.

**외부 API.** 이 플러그인은 서드파티 API(Exa, Jina AI 등)에 의존합니다. 저자는 이러한 서비스의 가용성, 정확성, 가격, 지속성을 보장하지 않으며, API 사용으로 발생하는 비용에 대해 책임지지 않습니다.

**API 키 관리.** API 키의 발급, 보안 관리, 각 제공업체의 서비스 약관 준수에 대한 책임은 전적으로 사용자에게 있습니다.

**콘텐츠 분류.** 웹 콘텐츠를 가져올 때 플러그인은 프라이버시 민감도를 평가하고 적절한 검색 방법을 결정하기 위해 LLM 기반 분류를 사용할 수 있습니다. 이러한 분류는 최선의 노력에 기반하며 오류를 포함할 수 있습니다. 자동 분류를 민감하거나 기밀인 정보의 유일한 보호 수단으로 의존하지 마세요.

**웹 가져오기 및 브라우저 자동화.** 이 플러그인에는 Playwright 및 Chrome DevTools를 통한 헤드리스 브라우저 자동화 도구가 포함되어 있습니다. 사용이 대상 웹사이트의 서비스 약관, robots.txt 정책 및 관련 법률을 준수하는지 확인하는 것은 사용자의 책임입니다. 저자는 브라우저 자동화로 인한 사이트 차단, 계정 정지, IP 제한, 예상치 못한 스크립트 실행, 리소스 소모 또는 호환성 문제에 대해 책임지지 않습니다.

**MCP 서버.** 이 플러그인은 서드파티 MCP(Model Context Protocol) 서버에 연결됩니다. 저자는 이러한 서버의 동작이나 보안을 제어, 감사하거나 보장하지 않습니다.

## 서드파티 고지

이 플러그인은 다음 외부 도구 및 서비스와 통합됩니다. 서드파티 소스 코드는 재배포되지 않으며, 통합은 MCP 서버 연결, 런타임 패키지 설치, 플러그인 개발자가 작성한 래퍼 스크립트를 통해 이루어집니다.

| 도구 | 제공업체 | 라이선스 |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

모든 제품명, 로고 및 상표는 각 소유자의 재산입니다. 이 플러그인은 위에 나열된 서드파티 서비스와 제휴 관계에 있지 않으며 해당 서비스의 보증을 받지 않습니다.

## 지원

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — 버그 리포트, 기능 요청 및 문의

## 저자

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## 라이선스

[MIT License](../LICENSE) — 자유롭게 사용, 수정, 배포할 수 있습니다. Copyright (c) 2026 shidoyu.

