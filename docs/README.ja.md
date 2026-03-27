🇯🇵 **日本語** · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **注意:** この翻訳は便宜上のものです。[英語の原文](../README.md)が正式版です。

# scout — Web 検索 & コンテンツ取得

Claude Code の組み込み WebSearch は 125 文字のスニペットを返すのみで、キーワードマッチングに依存しています。scout は曖昧な質問をマルチエンジン向けの最適化クエリに変換し、結果の品質を評価して必要であれば再検索を行うことで、一次情報により速く・より確実に到達します。

## 機能

- **scout:search** — クエリ設計最適化によるマルチエンジン Web 検索
- **scout:fetch** — プライバシーを考慮したツール選択による URL コンテンツ取得

## インストール

ターミナルで実行:

```bash
# ステップ 1: マーケットプレイスを登録
claude plugin marketplace add shidoyu/scout

# ステップ 2: プラグインをインストール
claude plugin install scout@shidoyu-scout
```

## クイックスタート

インストール直後から使用可能です。検索には WebSearch（組み込み）と Exa（無料、API キー不要）を使います。オプションのセットアップで追加機能を有効にできます。

```bash
bash tools/setup.sh
```

### 今すぐ試す

インストール後、Claude に聞いてみてください:

**名前がわからない概念を見つける:**
> 「Git blame みたいに、なぜこの設計にしたのかを追跡する方法はある？」

**日本のプラクティスの海外版を発見:**
> 「KPT ふりかえりに近い英語圏のプラクティスを探して — retrospective 以外のバリエーションも」

**曖昧な質問から専門知識へ:**
> 「ENOSPC エラーが出るけどディスク容量は余ってる、本当の原因は？」

**特定のページを読む:**
> 「https://docs.anthropic.com/en/docs/claude-code を取得して要約して」

## スキル

### scout:search

インテリジェントな Web 検索機能:
- クエリ改善のための事前調査
- 多言語クエリ設計
- 複数の検索エンジン（WebSearch、[Exa](https://exa.ai) セマンティック検索）
- Exa 経由の概念的クエリ向け HyDE（[Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)）
- 自動再検索ループによる品質評価

使用方法: `/scout:search 調べたいこと`

### scout:fetch

プライバシー自動分類による Web ページコンテンツ取得:
- **公開ページ** → Jina Reader（API キー必要）/ WebFetch（組み込みフォールバック）
- **機密ページ** → ローカル Playwright（外部 API 呼び出しなし）
- **認証が必要なページ** → Chrome DevTools（ブラウザセッションを使用）

使用方法: `/scout:fetch URL`

## セットアップ（任意）

`tools/setup.sh` を実行して設定します:

1. **Exa** — 高度な AI ネイティブ検索ツール（有料機能には API キーが必要。無料枠はセットアップなしで使用可能）
2. **Jina Reader** — Web ページを Markdown として高品質に取得（API キー必要。未設定の場合、公開ページは WebFetch にフォールバック）
3. **Playwright** — JavaScript で描画されるページや機密ページのブラウザ取得（約 200MB のダウンロード）

すべてのステップはスキップ可能です。設定を更新する際はいつでも再実行できます。
セットアップ後、新しい MCP サーバーを有効にするには Claude Code を再起動するか、`/mcp` を実行してください。

## プライバシー

scout は取得前に URL を 3 つのレベルに分類します:
- **公開** → クラウド API（Jina Reader / WebFetch）
- **機密** → ローカル Playwright のみ（設計上、機密 URL は外部 API に送信されません）
- **認証済み** → Chrome DevTools（ブラウザセッションを使用）

この分類は自動で行われますが、システムレベルでの保証ではなく LLM の判断に基づきます。詳細は[プライバシーに関する免責事項](#プライバシーに関する免責事項)をご覧ください。

## 動作環境

- Claude Code
- `jq`（セットアップスクリプト使用時のみ）
- `npm`/`npx`（[MCP](https://modelcontextprotocol.io/) サーバー: chrome-devtools 用）
- Python 3.10 以上（任意。Playwright ローカル取得用）
- `uvx` または `uv`（任意。MCP サーバー: markitdown — HTML→Markdown 変換用）
- Chrome（任意。DevTools 経由の認証済みページ取得用）

### Chrome DevTools のセットアップ（認証済みページ用）

ログインが必要なページ（OAuth、SaaS ダッシュボードなど）を取得するには、Chrome をデバッグモードで起動する必要があります:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## プライバシーに関する免責事項

scout は URL を機密度に応じて分類し、機密 URL をローカル専用ツールにルーティングします。
この分類は LLM の判断（ドメインパターンとコンテキスト）に基づくものであり、**システムによる保証ではありません**。
機密性の高いデータを扱う場合は、処理を進める前に分類結果を確認してください。

**ブラウザプロファイル。** Playwright ベースの取得ツール（`fetch-page.py`）は永続的なブラウザプロファイル（`tools/.chrome-profile/`）を使用し、Cookie、セッションデータ、閲覧履歴が蓄積される場合があります。このディレクトリは `.gitignore` によって Git の追跡対象外ですが、バックアップツールやクラウド同期サービスによってコピーされる可能性があります。機密ページを取得した場合は、定期的にこのディレクトリを削除してください。

## 言語

セットアップ手順は AI アシスタントによってお使いの言語で提供されます。
翻訳は便宜上のものであり、**英語の原文が正式版です**。

## セキュリティに関する注意

`setup.sh` を実行すると、API キーが `.mcp.json` に保存されます。
**`.mcp.json` を Git にコミットしないでください。** 配布用テンプレートとして `.mcp.json.dist` を使用してください。

## 免責事項

このプラグインは MIT ライセンスのもと「現状のまま」提供され、いかなる保証もありません。

**外部 API。** このプラグインはサードパーティの API（Exa、Jina AI など）に依存しています。著者はこれらサービスの可用性、正確性、料金、継続性について一切の保証をせず、API 使用によって発生した費用についても責任を負いません。

**API キーの管理。** API キーの取得・保管・管理、および各プロバイダーの利用規約の遵守はご自身の責任で行ってください。

**コンテンツ分類。** Web コンテンツ取得時、プラグインはプライバシーの機密性を評価して適切な取得方法を決定するために LLM ベースの分類を使用する場合があります。こうした分類はベストエフォートであり、誤りが含まれる可能性があります。機密情報や重要情報の保護をこの自動分類のみに頼ることは避けてください。

**Web 取得 & ブラウザ自動化。** このプラグインは Playwright と Chrome DevTools を介したヘッドレスブラウザ自動化ツールを含みます。対象サイトの利用規約、robots.txt ポリシー、適用法令への準拠はご自身の責任で確認してください。著者は、ブラウザ自動化に起因するサイトブロック、アカウント停止、IP 制限、予期しないスクリプト実行、リソース消費、互換性の問題について責任を負いません。

**MCP サーバー。** このプラグインはサードパーティの MCP（Model Context Protocol）サーバーに接続します。著者はこれらサーバーの動作やセキュリティを管理・監査・保証するものではありません。

## サードパーティへの帰属表示

このプラグインは以下の外部ツール・サービスと連携しています。サードパーティのソースコードは一切再配布しておらず、連携は MCP サーバー接続、ランタイムパッケージインストール、およびプラグイン開発者が作成したラッパースクリプトを通じて行われます。

| ツール | 提供元 | ライセンス |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

すべての製品名、ロゴ、商標はそれぞれの所有者の財産です。このプラグインは上記サードパーティサービスとは提携関係になく、それらによる推奨を受けているものでもありません。

## サポート

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — バグ報告、機能リクエスト、質問

## 著者

**SHIDO, Yuichiro**（[@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)）— AI Operations Designer

## ライセンス

[MIT License](LICENSE) — 自由に使用・改変・配布可能。Copyright (c) 2026 shidoyu.

