🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 **Tiếng Việt** · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Lưu ý:** Bản dịch này chỉ mang tính chất tham khảo. [Bản gốc tiếng Anh](../README.md) là phiên bản chính thức.

<p align="center">
  <img src="assets/hero.png" alt="scout — Suy nghĩ trước. Tìm kiếm sau." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Plugin nghiên cứu web cho <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Chuyển đổi những câu hỏi mơ hồ thành các truy vấn đa công cụ tối ưu, tiếp cận nguồn thông tin gốc.
</p>

<p align="center">
  <strong>Suy nghĩ trước. Tìm kiếm sau.</strong>
</p>

---

WebSearch tích hợp trong Claude Code chỉ trả về đoạn trích 125 ký tự và dựa hoàn toàn vào so khớp từ khóa. Điều này đủ cho các tra cứu đơn giản, nhưng nghiên cứu thực sự cần thiết kế truy vấn, đánh giá nguồn và định tuyến có ý thức bảo mật.

scout suy nghĩ trước khi tìm kiếm.

## Bắt đầu nhanh

Không cần API key. Không cần thay đổi môi trường. Cài đặt xong là dùng được ngay.

**1. Thêm marketplace** (chỉ cần một lần):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Cài đặt**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Tải lại plugin** (nhập trong Claude Code):

```
/mcp
```

Sau đó hỏi Claude:

```text
/scout:search Có công cụ nào giống Git blame nhưng dùng để theo dõi quyết định thiết kế không?
```

scout sẽ chuyển đổi khái niệm mơ hồ này thành thuật ngữ chính xác (ADR — Architecture Decision Records), thực thi truy vấn tối ưu trên nhiều công cụ tìm kiếm, đánh giá chất lượng nguồn, và trả về kết quả kèm Research Trail (bản ghi cho thấy cách scout đi đến câu trả lời).

## scout có thể làm gì

### Tìm khái niệm mà bạn chưa biết tên

> "Tôi biết có một khái niệm như vậy — cách ghi lại lý do đằng sau mỗi quyết định thiết kế — nhưng tôi không biết nó gọi là gì"

scout chuyển đổi ý tưởng mơ hồ thành thuật ngữ chính xác và tiếp cận nguồn thông tin gốc.

### Vượt qua nhiễu SEO

> "Thực sự nên chuyển từ Terraform sang đâu — không phải bài viết được tài trợ, mà là câu chuyện di chuyển thực tế"

Nghiên cứu sơ bộ giúp có được vốn từ vựng phù hợp, sau đó các truy vấn nhắm mục tiêu sẽ bỏ qua các trang nội dung kém chất lượng.

### Truy cập trực tiếp tài liệu chính thức

> "Cách thiết lập middleware trong Next.js App Router?"

scout kiểm tra [Context7](https://github.com/upstash/context7) để tìm tài liệu chính thức đã được lập chỉ mục trước. Nếu câu trả lời đã có ở đó thì không cần tìm kiếm web.

### Đọc bất kỳ trang web nào

> "Lấy và tóm tắt https://docs.anthropic.com/en/docs/claude-code"

Truy xuất có ý thức bảo mật: trang công khai đi qua API đám mây, trang bảo mật xử lý trên máy cục bộ.

## Cấp độ thiết lập

scout hoạt động ngay sau khi cài đặt. Mỗi cấp độ bổ sung thêm khả năng — tất cả đều tùy chọn, tất cả đều có thể hoàn tác.

### Cấp độ 1: Tìm kiếm tích hợp (mặc định)

Sử dụng WebSearch của Claude Code. Không cần cấu hình. Đây là trạng thái sẵn có ngay sau cài đặt.

### Cấp độ 2: Tài liệu chính thức + Truy xuất sạch hơn

Thêm [Context7](https://github.com/upstash/context7) để truy cập trực tiếp tài liệu thư viện/framework, và [Jina Reader](https://jina.ai) để đọc trang sạch hơn. Context7 không cần API key; Jina có key tùy chọn để nới lỏng giới hạn tốc độ.

### Cấp độ 3: Tìm kiếm ngữ nghĩa

Thêm [Exa](https://exa.ai) để tìm kiếm dựa trên ngữ nghĩa — tìm trang liên quan ngay cả khi bạn không biết từ khóa chính xác. Gói miễn phí hỗ trợ tìm kiếm ngữ nghĩa cơ bản; API key mở khóa tính năng nâng cao.

### Cấp độ 4: Trình duyệt cục bộ

Thêm [Playwright](https://playwright.dev) để xử lý trang render bằng JavaScript và các URL bảo mật không nên gửi ra bên ngoài. Cần tải Chromium (khoảng 200MB).

**Chạy `/scout:setup` để thiết lập từng cấp độ theo hướng dẫn tương tác.** Trước khi thực hiện bất kỳ thay đổi nào, hệ thống sẽ hiển thị chính xác những gì sẽ được thêm vào cấu hình. Có thể chạy lại bất cứ lúc nào để thêm hoặc cập nhật công cụ.

## Kỹ năng

| Kỹ năng | Mục đích |
|---|---|
| `/scout:search` | Tìm kiếm web đa công cụ với thiết kế truy vấn, đánh giá nguồn và tự động tìm kiếm lại |
| `/scout:fetch` | Truy xuất nội dung URL với phân loại bảo mật tự động |
| `/scout:setup` | Hướng dẫn thiết lập tương tác cho công cụ tìm kiếm và truy xuất |

### Research Trail

Mỗi lần tìm kiếm kết thúc bằng một bản ghi có cấu trúc cho thấy cách scout đi đến câu trả lời:

```
🔍 Research Trail
───────────────────────────────
Query:           câu hỏi gốc của bạn
Designed queries: các truy vấn tối ưu mà scout thực sự đã chạy
Sources:         URL kèm mức độ tin cậy (🟢 nguồn gốc / 🟡 nguồn thứ cấp / ⚪ nguồn bậc ba)
Re-searches:     các tìm kiếm bổ sung và lý do
Confidence:      High / Medium / Low (kèm căn cứ)
```

## Bảo mật

scout phân loại URL thành ba cấp độ trước khi truy xuất:

| Phân loại | Định tuyến | Ví dụ |
|---|---|---|
| **Công khai** | API đám mây (Jina Reader / WebFetch) | Blog, tài liệu, repo GitHub công khai |
| **Bảo mật** | Chỉ dùng Playwright cục bộ | localhost, wiki nội bộ, trang quản trị |
| **Cần xác thực** | Playwright CDP | Notion, Slack, trang sau xác thực OAuth |

Phân loại này dựa trên phán đoán của LLM, không phải do hệ thống bắt buộc. Hãy coi đây là định tuyến theo nỗ lực tốt nhất. Với dữ liệu có độ nhạy cảm cao, hãy xác minh kết quả phân loại trước khi tiếp tục.

**URL bảo mật không bao giờ được gửi đến API bên ngoài, ngay cả khi truy xuất thất bại** — hệ thống không chuyển sang công cụ đám mây cho các trang bảo mật.

<details>
<summary>Thiết lập chế độ gỡ lỗi Chrome (cho trang cần xác thực)</summary>

Để truy xuất các trang yêu cầu đăng nhập (OAuth, bảng điều khiển SaaS), hãy khởi chạy Chrome ở chế độ gỡ lỗi. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Lưu ý về hồ sơ trình duyệt</summary>

Trình truy xuất dựa trên Playwright sử dụng hồ sơ trình duyệt cố định (`tools/.chrome-profile/`), có thể tích lũy cookie và dữ liệu phiên. Thư mục này đã được loại trừ khỏi Git qua `.gitignore` nhưng có thể bị sao chép bởi các công cụ sao lưu. Nếu bạn đã truy xuất các trang bảo mật, hãy xóa thư mục này định kỳ.
</details>

## Gỡ cài đặt

Hai lệnh để xóa sạch mọi thứ. Không để lại gì.

Xóa plugin (dọn dẹp bộ nhớ đệm, cấu hình và dữ liệu trạng thái):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Xóa Context7 nếu bạn đã thêm qua scout:setup (phạm vi người dùng — xóa khỏi tất cả dự án):

```bash
claude mcp remove context7
```

## Yêu cầu

- **Claude Code** (bắt buộc)
- `jq` (chỉ dùng cho chẩn đoán thiết lập)
- Python 3.10+ (chỉ dùng cho Playwright truy xuất cục bộ)

## Bảo mật

API key được lưu trong `.mcp.json` bên trong thư mục plugin.
**Không commit `.mcp.json` vào Git.** Mẫu để phân phối là `.mcp.json.dist`.

## Tuyên bố miễn trừ

Plugin này được cung cấp "nguyên trạng" theo Giấy phép MIT, không có bất kỳ bảo đảm nào.

**API bên ngoài.** Plugin này phụ thuộc vào API của bên thứ ba (Exa, Jina AI và các dịch vụ khác). Tác giả không đảm bảo về tính khả dụng, độ chính xác, giá cả hoặc tính liên tục của các dịch vụ này và không chịu trách nhiệm cho các chi phí phát sinh từ việc sử dụng API.

**Quản lý API key.** Việc lấy, bảo mật, quản lý API key và tuân thủ điều khoản dịch vụ của từng nhà cung cấp hoàn toàn thuộc trách nhiệm của bạn.

**Phân loại nội dung.** Phân loại bảo mật URL dựa trên phán đoán của LLM và có thể có sai sót. Không nên coi đây là biện pháp bảo vệ duy nhất cho thông tin nhạy cảm.

**Truy xuất web & Tự động hóa trình duyệt.** Plugin này bao gồm các công cụ tự động hóa trình duyệt headless qua Playwright. Bạn có trách nhiệm đảm bảo việc sử dụng tuân thủ điều khoản dịch vụ, chính sách robots.txt và luật pháp hiện hành của các trang web mục tiêu.

**MCP server.** Plugin này kết nối đến các MCP server của bên thứ ba. Tác giả không kiểm soát, kiểm toán hoặc đảm bảo hành vi hay tính bảo mật của các server này.

## Ghi nhận bên thứ ba

Không phân phối lại mã nguồn của bên thứ ba. Tích hợp thông qua kết nối MCP, cài đặt gói thời gian chạy và script bọc.

| Công cụ | Nhà cung cấp | Giấy phép |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tất cả tên sản phẩm, logo và nhãn hiệu là tài sản của chủ sở hữu tương ứng.

## Ngôn ngữ

Hướng dẫn thiết lập được trợ lý AI cung cấp bằng ngôn ngữ của bạn. Các bản dịch chỉ mang tính tham khảo — **bản gốc tiếng Anh là phiên bản chính thức**.

## Hỗ trợ

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Báo lỗi, yêu cầu tính năng và câu hỏi

## Tác giả

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Giấy phép

[MIT License](../LICENSE) — Tự do sử dụng, chỉnh sửa và phân phối. Copyright (c) 2026 shidoyu.
