🇯🇵 [日本語](README.ja.md) · 🇰🇷 **한국어** · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **참고:** 이 번역은 편의를 위해 제공됩니다. [영어 원문](../README.md)이 정식 버전입니다.

<p align="center">
  <img src="assets/hero.png" alt="scout — 먼저 생각하고, 그 다음에 검색한다." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  <a href="https://claude.com/claude-code">Claude Code</a>용 웹 리서치 플러그인.<br>
  모호한 질문을 1차 출처에 도달하는 최적의 멀티엔진 쿼리로 변환합니다.
</p>

<p align="center">
  <strong>먼저 생각하고, 그 다음에 검색한다.</strong>
</p>

---

Claude Code의 내장 WebSearch는 125자 스니펫만 반환하며 키워드 매칭에만 의존합니다. 간단한 조회에는 충분하지만, 본격적인 리서치에는 쿼리 설계, 소스 평가, 프라이버시를 고려한 라우팅이 필요합니다.

scout는 검색하기 전에 생각합니다.

## 빠른 시작

API 키 불필요. 환경 변경 불필요. 설치 후 바로 사용할 수 있습니다.

**1. 마켓플레이스 등록** (최초 1회):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. 설치**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. 플러그인 새로고침** (Claude Code 내에서 입력):

```
/mcp
```

그대로 Claude에게 물어보세요:

```text
/scout:search Git blame처럼 설계 결정의 경위를 추적하는 방법이 있나요?
```

scout는 이 모호한 개념을 적절한 용어(ADR — Architecture Decision Records)로 변환하고, 여러 엔진에서 최적화된 쿼리를 실행하며, 소스 품질을 평가하고, 답에 도달한 과정을 보여주는 Research Trail과 함께 결과를 반환합니다.

## scout가 할 수 있는 일

### 아직 이름을 모르는 개념 찾기

> "이런 개념이 존재하는 건 알아 — 설계할 때마다 '왜 그렇게 결정했는지'를 기록하는 방법 — 그런데 이름을 모르겠어"

scout는 모호한 아이디어를 정확한 용어로 변환하고 1차 출처에 도달합니다.

### SEO 노이즈 돌파

> "Terraform에서 실제로 어디로 마이그레이션해야 해? 스폰서 기사 말고, 실제 마이그레이션 사례가 궁금해"

사전 조사로 적절한 어휘를 확보한 후, 타겟팅된 쿼리로 콘텐츠 팜을 우회합니다.

### 공식 문서에 직접 도달

> "Next.js App Router에서 미들웨어를 설정하려면?"

scout는 먼저 [Context7](https://github.com/upstash/context7)에서 인덱싱된 공식 문서를 확인합니다. 답이 거기에 있으면 웹 검색이 필요 없습니다.

### 모든 웹 페이지 읽기

> "https://docs.anthropic.com/en/docs/claude-code 를 가져와서 요약해 줘"

프라이버시를 고려한 페치: 공개 페이지는 클라우드 API를 거치고, 기밀 페이지는 로컬에서 처리합니다.

## 설정 레벨

scout는 설치 직후부터 작동합니다. 각 레벨은 기능을 추가하며, 모두 선택 사항이고 되돌릴 수 있습니다.

### 레벨 1: 내장 검색 (기본값)

Claude Code의 WebSearch를 사용합니다. 별도 설정 불필요. 설치한 그대로의 상태입니다.

### 레벨 2: 공식 문서 + 더 깔끔한 페치

[Context7](https://github.com/upstash/context7)을 추가하면 라이브러리와 프레임워크 문서에 직접 접근할 수 있습니다. Jina Reader가 페이지 노이즈를 제거해 컨텍스트를 덜 차지하고 토큰을 절약할 수 있습니다. 키 없이 20 req/min, 무료 API 키로 500 req/min까지 사용할 수 있습니다.

### 레벨 3: 시맨틱 검색

[Exa](https://exa.ai)로 의미 기반 검색 — 올바른 키워드를 모르더라도 관련 페이지를 찾을 수 있습니다. 무료 티어로 기본 시맨틱 검색 가능. API 키로 고급 기능 이용 가능.

### 레벨 4: 로컬 브라우저

[Playwright](https://playwright.dev)로 JavaScript 렌더링 페이지와 외부로 보내서는 안 되는 기밀 URL을 로컬에서 처리. Chromium 다운로드(약 200MB) 필요.

**`/scout:setup`을 실행하면 각 레벨을 대화형으로 설정할 수 있습니다.** 변경을 적용하기 전에 설정에 추가될 내용을 반드시 먼저 표시합니다. 언제든 다시 실행하여 도구를 추가하거나 업데이트할 수 있습니다.

## 스킬

| 스킬 | 용도 |
|---|---|
| `/scout:search` | 쿼리 설계, 소스 평가, 자동 재검색을 갖춘 멀티엔진 웹 검색 |
| `/scout:fetch` | 프라이버시 자동 분류 기반 URL 콘텐츠 페치 |
| `/scout:setup` | 검색 엔진 및 페치 도구의 대화형 설정 가이드 |

### Research Trail

모든 검색의 마지막에 scout가 어떻게 답에 도달했는지를 보여주는 구조화된 기록을 표시합니다:

```
🔍 Research Trail
───────────────────────────────
Query:           원래 질문
Designed queries: scout가 실제로 실행한 최적화 쿼리
Sources:         신뢰도 등급 포함 URL (🟢 1차 출처 / 🟡 2차 출처 / ⚪ 3차 출처)
Re-searches:     추가 검색과 그 이유
Confidence:      High / Medium / Low (근거 포함)
```

## 프라이버시

scout는 페치하기 전에 URL을 3단계로 분류합니다:

| 분류 | 라우팅 | 예시 |
|---|---|---|
| **공개** | 클라우드 API (Jina Reader / WebFetch) | 블로그, 문서, GitHub 공개 리포 |
| **기밀** | 로컬 Playwright만 사용 | localhost, 사내 위키, 관리자 패널 |
| **인증 필요** | Playwright CDP | Notion, Slack, OAuth 인증 후 페이지 |

이 분류는 LLM의 판단에 기반하며, 시스템에 의한 강제가 아닙니다. 최선의 노력에 따른 라우팅으로 간주해 주세요. 기밀성이 높은 데이터의 경우 처리 전에 분류 결과를 확인하세요.

**기밀 URL은 페치에 실패하더라도 외부 API로 전송되지 않습니다** — 기밀 페이지에 대해 클라우드 도구로의 폴백은 수행하지 않습니다.

<details>
<summary>Chrome 디버그 모드 설정 (인증이 필요한 페이지용)</summary>

로그인이 필요한 페이지(OAuth, SaaS 대시보드 등)를 페치하려면 Chrome을 디버그 모드로 실행합니다. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>브라우저 프로필 참고사항</summary>

Playwright 기반 페처는 영구 브라우저 프로필(`tools/.chrome-profile/`)을 사용하며, 쿠키와 세션 데이터가 축적될 수 있습니다. 이 디렉터리는 `.gitignore`로 Git 추적에서 제외되어 있지만, 백업 도구에 의해 복사될 수 있습니다. 기밀 페이지를 페치한 경우 주기적으로 삭제하세요.
</details>

## 제거

두 개의 명령어로 모든 것을 제거할 수 있습니다. 잔여물은 없습니다.

플러그인 제거 (캐시, 설정, 상태 데이터 정리):

```bash
claude plugin uninstall scout@shidoyu-scout
```

scout:setup으로 추가한 Context7 제거 (사용자 범위이므로 모든 프로젝트에서 제거됩니다):

```bash
claude mcp remove context7
```

## 요구 사항

- **Claude Code** (필수)
- `jq` (설정 진단용)
- Python 3.10+ (Playwright 로컬 페치용)

## 보안

API 키는 플러그인 디렉터리 내의 `.mcp.json`에 저장됩니다.
**`.mcp.json`을 Git에 커밋하지 마세요.** 배포용 템플릿으로 `.mcp.json.dist`를 사용하세요.

## 면책 조항

이 플러그인은 MIT 라이선스에 따라 "있는 그대로" 제공되며, 어떠한 보증도 하지 않습니다.

**외부 API.** 이 플러그인은 서드파티 API(Exa, Jina AI 등)에 의존합니다. 저자는 이러한 서비스의 가용성, 정확성, 요금, 지속성에 대해 보증하지 않으며, API 사용으로 인해 발생한 비용에 대해서도 책임지지 않습니다.

**API 키 관리.** API 키의 취득, 보관, 관리 및 각 제공자의 이용 약관 준수는 사용자 본인의 책임입니다.

**콘텐츠 분류.** URL 프라이버시 분류는 LLM의 판단에 기반하며 오류가 포함될 수 있습니다. 민감한 정보의 유일한 보호 수단으로 의존하지 마세요.

**웹 페치 & 브라우저 자동화.** 이 플러그인은 Playwright를 통한 헤드리스 브라우저 자동화 도구를 포함합니다. 대상 사이트의 이용 약관, robots.txt 정책, 적용 법률의 준수는 사용자의 책임입니다.

**MCP 서버.** 이 플러그인은 서드파티 MCP 서버에 연결합니다. 저자는 이러한 서버의 동작이나 보안을 관리, 감사, 보증하지 않습니다.

## 서드파티 귀속 표시

서드파티 소스 코드는 재배포하지 않습니다. 연동은 MCP 연결, 런타임 패키지 설치, 래퍼 스크립트를 통해 이루어집니다.

| 도구 | 제공자 | 라이선스 |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

모든 제품명, 로고, 상표는 각 소유자의 자산입니다.

## 언어

설정 안내는 AI 어시스턴트가 사용자의 언어로 제공합니다. 번역은 편의를 위한 것이며, **영어 원문이 정식 버전입니다**.

## 지원

[GitHub Issues](https://github.com/shidoyu/scout/issues) — 버그 리포트, 기능 요청, 질문

## 저자

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## 라이선스

[MIT License](../LICENSE) — 자유롭게 사용, 수정, 배포 가능. Copyright (c) 2026 shidoyu.
