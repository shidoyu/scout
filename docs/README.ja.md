🇯🇵 **日本語** · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **注意:** この翻訳は便宜上のものです。[英語の原文](../README.md)が正式版です。

<p align="center">
  <img src="assets/hero.png" alt="scout — 考えてから、検索する。" width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  <a href="https://claude.com/claude-code">Claude Code</a> 用 Web リサーチプラグイン。<br>
  曖昧な質問を、一次情報にたどり着く最適なマルチエンジンクエリに変換します。
</p>

<p align="center">
  <strong>考えてから、検索する。</strong>
</p>

---

Claude Code 内蔵の WebSearch は 125 文字のスニペットを返すだけで、キーワード一致に頼っています。単純な調べ物には十分ですが、本格的なリサーチにはクエリ設計、ソース評価、プライバシーを考慮したルーティングが必要です。

scout は検索する前に考えます。

## クイックスタート

API キー不要。環境変更不要。インストールしたらすぐに試せます。

**1. マーケットプレイスを登録**（初回のみ）:

```bash
claude plugin marketplace add shidoyu/scout
```

**2. インストール**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. プラグインを読み込み**（Claude Code 内で入力）:

```
/mcp
```

そのまま Claude に聞いてみてください:

```text
/scout:search Git blame みたいに設計判断の経緯を追跡する方法はある？
```

scout はこの曖昧な問いを適切な用語（ADR — Architecture Decision Records）に変換し、複数のエンジンで最適化されたクエリを実行し、ソースの質を評価し、Research Trail（どうやってその答えにたどり着いたかの記録）付きで回答を返します。

## scout にできること

### まだ名前を知らない概念を見つける

> 「こういう概念があるのは知ってる — 設計のたびに"なぜそうしたか"を記録する方法 — でも名前がわからない」

scout は曖昧なアイデアを正確な用語に変換し、一次情報にたどり着きます。

### SEO ノイズを突破する

> 「Terraform から本当に移行すべき先は？ スポンサー記事じゃなくて、実際の移行事例が知りたい」

事前調査で適切な語彙を獲得してから、的を絞ったクエリでコンテンツファームを回避します。

### 公式ドキュメントに直接たどり着く

> 「Next.js App Router でミドルウェアを設定するには？」

scout はまず [Context7](https://github.com/upstash/context7) でインデックス済みの公式ドキュメントを確認します。答えがそこにあれば Web 検索は不要です。

### 任意の Web ページを読む

> 「https://docs.anthropic.com/en/docs/claude-code を取得して要約して」

プライバシーを考慮した取得: 公開ページはクラウド API 経由、機密ページはローカルで処理します。

## セットアップレベル

scout はインストール直後から動作します。各レベルは機能を追加するもので、すべて任意、すべて元に戻せます。

### レベル 1: 内蔵検索（デフォルト）

Claude Code の WebSearch を使用します。設定不要。インストールしたそのままの状態です。

### レベル 2: 公式ドキュメント + よりクリーンな取得

[Context7](https://github.com/upstash/context7) でライブラリ/フレームワークの公式ドキュメントに直接アクセス、[Jina Reader](https://jina.ai) でよりクリーンなページ読み取り。Context7 は API キー不要。Jina はレート制限緩和のためのオプションキーあり。

### レベル 3: セマンティック検索

[Exa](https://exa.ai) で意味ベースの検索。正しいキーワードがわからなくても関連ページを見つけられます。無料枠で基本的なセマンティック検索が可能。API キーで高度な機能を利用できます。

### レベル 4: ローカルブラウザ

[Playwright](https://playwright.dev) で JavaScript レンダリングページと、外部に送信すべきでない機密 URL をローカルで処理。Chromium のダウンロード（約 200MB）が必要です。

**`/scout:setup` で各レベルを対話的に設定できます。** 変更を適用する前に、設定にどのような内容が追加されるかを必ず表示します。いつでも再実行してツールの追加や更新が可能です。

## スキル

| スキル | 用途 |
|---|---|
| `/scout:search` | クエリ設計、ソース評価、自動再検索を備えたマルチエンジン Web 検索 |
| `/scout:fetch` | プライバシー自動分類による URL コンテンツ取得 |
| `/scout:setup` | 検索エンジンとフェッチツールの対話型セットアップガイド |

### Research Trail

すべての検索の最後に、scout がどのように答えにたどり着いたかを示す構造化された記録を表示します:

```
🔍 Research Trail
───────────────────────────────
Query:           あなたの元の質問
Designed queries: scout が実際に実行した最適化クエリ
Sources:         信頼性ランク付き URL（🟢 一次情報 / 🟡 二次情報 / ⚪ 三次情報）
Re-searches:     追加検索とその理由
Confidence:      High / Medium / Low（根拠付き）
```

## プライバシー

scout は取得前に URL を 3 段階に分類します:

| 分類 | ルーティング | 例 |
|---|---|---|
| **公開** | クラウド API（Jina Reader / WebFetch） | ブログ、ドキュメント、GitHub 公開リポ |
| **機密** | ローカル Playwright のみ | localhost、社内 Wiki、管理画面 |
| **認証済み** | Playwright CDP | Notion、Slack、OAuth 認証後のページ |

この分類は LLM の判断に基づくもので、システムによる強制ではありません。ベストエフォートのルーティングとして扱ってください。機密性の高いデータの場合、処理前に分類結果を確認してください。

**機密 URL は、取得に失敗した場合でも外部 API には送信されません** — 機密ページに対してクラウドツールへのフォールバックは行いません。

<details>
<summary>Chrome デバッグモードのセットアップ（認証済みページ用）</summary>

ログインが必要なページ（OAuth、SaaS ダッシュボードなど）を取得するには、Chrome をデバッグモードで起動します. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>ブラウザプロファイルについて</summary>

Playwright ベースのフェッチャーは永続的なブラウザプロファイル（`tools/.chrome-profile/`）を使用し、Cookie やセッションデータが蓄積されることがあります。このディレクトリは `.gitignore` で Git の追跡対象外ですが、バックアップツールによりコピーされる可能性があります。機密ページを取得した場合は、定期的に削除してください。
</details>

## アンインストール

2 つのコマンドですべて削除できます。残留物はありません。

プラグインを削除（キャッシュ、設定、状態データをクリーンアップ）:

```bash
claude plugin uninstall scout@shidoyu-scout
```

scout:setup で追加した Context7 を削除（ユーザースコープのため、すべてのプロジェクトから削除されます）:

```bash
claude mcp remove context7
```

## 動作環境

- **Claude Code**（必須）
- `jq`（セットアップ診断のみ）
- Python 3.10+（Playwright ローカル取得のみ）

## セキュリティ

API キーはプラグインディレクトリ内の `.mcp.json` に保存されます。
**`.mcp.json` を Git にコミットしないでください。** 配布用テンプレートとして `.mcp.json.dist` を使用してください。

## 免責事項

このプラグインは MIT ライセンスのもと「現状のまま」提供され、いかなる保証もありません。

**外部 API。** このプラグインはサードパーティの API（Exa、Jina AI など）に依存しています。著者はこれらサービスの可用性、正確性、料金、継続性について一切の保証をせず、API 使用によって発生した費用についても責任を負いません。

**API キーの管理。** API キーの取得・保管・管理、および各プロバイダーの利用規約の遵守はご自身の責任で行ってください。

**コンテンツ分類。** URL のプライバシー分類は LLM の判断に基づいており、誤りが含まれる可能性があります。機密情報の唯一の保護手段として依存しないでください。

**Web 取得 & ブラウザ自動化。** このプラグインは Playwright によるヘッドレスブラウザ自動化ツールを含みます。対象サイトの利用規約、robots.txt ポリシー、適用法令への準拠はご自身の責任で確認してください。

**MCP サーバー。** このプラグインはサードパーティの MCP サーバーに接続します。著者はこれらサーバーの動作やセキュリティを管理・監査・保証するものではありません。

## サードパーティへの帰属表示

サードパーティのソースコードは再配布していません。連携は MCP 接続、ランタイムパッケージインストール、およびラッパースクリプトを通じて行われます。

| ツール | 提供元 | ライセンス |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

すべての製品名、ロゴ、商標はそれぞれの所有者の財産です。

## 言語

セットアップ手順は AI アシスタントによってお使いの言語で提供されます。翻訳は便宜上のものであり、**英語の原文が正式版です**。

## サポート

[GitHub Issues](https://github.com/shidoyu/scout/issues) — バグ報告、機能リクエスト、質問

## 著者

**SHIDO, Yuichiro**（[@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)）— AI Operations Designer

## ライセンス

[MIT License](../LICENSE) — 自由に使用・改変・配布可能。Copyright (c) 2026 shidoyu.
