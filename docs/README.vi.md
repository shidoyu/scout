🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇻🇳 [**Tiếng Việt**](README.vi.md)

> **Lưu ý:** Bản dịch này chỉ mang tính chất tham khảo. [Bản gốc tiếng Anh](../README.md) là phiên bản chính thức.

# scout

**Wrong search, wrong decision.**

> Suy nghĩ trước, tìm kiếm sau. — Plugin nghiên cứu web cho Claude Code.

Thiết kế truy vấn, tìm kiếm đa công cụ, tải nội dung bảo vệ quyền riêng tư.

WebSearch tích hợp sẵn của Claude Code chỉ trả về các đoạn trích 125 ký tự và chỉ dựa vào việc khớp từ khóa. scout biến một câu hỏi mơ hồ thành các truy vấn đa công cụ tìm kiếm đã được tối ưu, đánh giá chất lượng kết quả và tìm lại khi cần, để tiếp cận nguồn gốc nhanh hơn và đáng tin cậy hơn.

## Tính năng

- **scout:search** — Tìm kiếm web đa công cụ với tối ưu hóa thiết kế truy vấn
- **scout:fetch** — Lấy nội dung URL với lựa chọn công cụ theo mức độ bảo mật

## Cài đặt

Chạy trong terminal:

```bash
# Bước 1: Đăng ký marketplace
claude plugin marketplace add shidoyu/scout

# Bước 2: Cài đặt plugin
claude plugin install scout@shidoyu-scout
```

**Bước 3** — Thiết lập công cụ tìm kiếm và công cụ tải nội dung

Chạy từng lệnh này lần lượt trong Claude Code:

```text
/reload-plugins
```

```text
/scout:setup
```

`scout:setup` hướng dẫn bạn cấu hình [Context7](https://github.com/upstash/context7) (tài liệu thư viện), [Jina Reader](https://jina.ai) (tải nội dung trang web), [Exa](https://exa.ai) (tìm kiếm ngữ nghĩa) và [Playwright](https://playwright.dev) (trang render bằng JavaScript) theo hình thức tương tác. Mọi bước đều là tùy chọn và có thể bỏ qua.

> **Lưu ý:** Nếu bạn bỏ qua bước này, scout sẽ nhắc bạn thiết lập khi bắt đầu phiên tiếp theo. Tìm kiếm cơ bản hoạt động ngay mà không cần thiết lập.

## Bắt đầu nhanh

Sau khi cài đặt, hãy hỏi Claude (không cần thiết lập — tìm kiếm cơ bản hoạt động ngay):

**Tìm những khái niệm bạn chưa biết tên:**
> "thuật toán mà app tự gợi ý sản phẩm dựa trên những gì người dùng khác có sở thích giống mình đã mua"

**Khám phá tương đương quốc tế của khái niệm Việt Nam:**
> "Tích hợp cổng thanh toán VNPay và MoMo vào app, cái nào dễ hơn cho developer?"

**Nhận câu trả lời chuyên gia từ câu hỏi đơn giản:**
> "Gõ tiếng Việt có dấu trong input field bị mất dấu hoặc hiện ký tự lạ khi submit form"

**Đọc một trang cụ thể:**
> "Đọc trang này https://nextjs.org/docs/getting-started/installation"

## Skills

### scout:search

Tìm kiếm web thông minh với:
- Nghiên cứu trước để tinh chỉnh truy vấn
- Thiết kế truy vấn đa ngôn ngữ
- Nhiều công cụ tìm kiếm (WebSearch, [Context7](https://github.com/upstash/context7) tài liệu chính thức, tìm kiếm ngữ nghĩa [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) cho truy vấn khái niệm qua Exa
- Đánh giá chất lượng với vòng lặp tìm kiếm lại tự động

Cách dùng: `/scout:search câu hỏi của bạn ở đây`

### scout:fetch

Lấy nội dung trang web với phân loại bảo mật tự động:
- **Trang công khai** → Jina Reader / WebFetch (dự phòng tích hợp sẵn)
- **Trang bảo mật** → Playwright cục bộ (không gọi API bên ngoài)
- **Trang yêu cầu xác thực** → Chrome DevTools (phiên trình duyệt)

Cách dùng: `/scout:fetch URL`

### scout:setup

Thiết lập tương tác có hướng dẫn cho công cụ tìm kiếm và công cụ tải nội dung:
- **Context7** — Đường đi trực tiếp tới tài liệu chính thức mới nhất của thư viện và framework, giúp câu hỏi kỹ thuật chạm vào docs nguồn nhanh hơn qua [Context7 MCP](https://github.com/upstash/context7) (không cần API key)
- **Jina Reader** — Lấy trang web thành Markdown gọn hơn bằng cách bỏ điều hướng và phần nội dung lặp lại, nên thường gửi ít văn bản hơn vào mô hình và tiết kiệm token ([API key miễn phí](https://jina.ai/?newKey))
- **Exa** — Tìm kiếm theo ngữ nghĩa cho các câu hỏi mơ hồ, mang tính khái niệm hoặc ngách khi chưa rõ đúng thuật ngữ ([API key](https://exa.ai))
- **Playwright** — Lấy cục bộ bằng trình duyệt cho các trang render bằng JavaScript hoặc trang nhạy cảm cần ở lại trên máy của bạn (~200MB tải xuống)

Tất cả các bước đều là tùy chọn. Chạy lại bất cứ lúc nào để cập nhật cài đặt.

Cách dùng: `/scout:setup`

## Quyền riêng tư

scout phân loại URL thành ba cấp độ trước khi lấy nội dung:
- **Công khai** → API đám mây (Jina Reader / WebFetch)
- **Bảo mật** → Chỉ Playwright cục bộ (định tuyến có chủ đích: URL bảo mật không được gửi đến API bên ngoài)
- **Yêu cầu xác thực** → Chrome DevTools (sử dụng phiên trình duyệt của bạn)

Phân loại này là tự động nhưng dựa trên phán đoán của LLM, không phải thực thi của hệ thống. Xem [Tuyên bố từ chối trách nhiệm về quyền riêng tư](#tuyên-bố-từ-chối-trách-nhiệm-về-quyền-riêng-tư) để biết chi tiết.

## Yêu cầu

- Claude Code
- `jq` (chỉ dùng cho thiết lập)
- `npm`/`npx` (cho [MCP](https://modelcontextprotocol.io/) server: chrome-devtools)
- Python 3.10+ (tùy chọn, cho lấy nội dung cục bộ bằng Playwright)
- `uvx` hoặc `uv` (tùy chọn, cho MCP server: markitdown — chuyển đổi HTML→Markdown)
- Chrome (tùy chọn, cho lấy nội dung trang xác thực qua DevTools)

### Thiết lập Chrome DevTools (cho trang yêu cầu xác thực)

Để lấy nội dung các trang yêu cầu đăng nhập (OAuth, bảng điều khiển SaaS), Chrome phải chạy ở chế độ debug:

Trên macOS:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

Trên Linux:

```bash
google-chrome --remote-debugging-port=9222
```

## Tuyên bố từ chối trách nhiệm về quyền riêng tư

scout phân loại URL theo mức độ nhạy cảm và định tuyến URL bảo mật đến các công cụ chỉ chạy cục bộ.
Phân loại này dựa trên phán đoán của LLM (mẫu tên miền và ngữ cảnh) và **không phải là đảm bảo được thực thi bởi hệ thống**.
Đối với dữ liệu nhạy cảm cao, hãy xác minh phân loại trước khi tiến hành.

**Hồ sơ trình duyệt.** Trình lấy nội dung dựa trên Playwright (`fetch-page.py`) sử dụng hồ sơ trình duyệt liên tục (`tools/.chrome-profile/`) có thể tích lũy cookie, dữ liệu phiên và lịch sử duyệt web. Thư mục này được loại trừ khỏi Git qua `.gitignore` nhưng có thể được sao chép bởi công cụ sao lưu hoặc dịch vụ đồng bộ đám mây. Xóa thư mục định kỳ nếu bạn lấy nội dung trang bảo mật.

## Ngôn ngữ

Hướng dẫn thiết lập được cung cấp bằng ngôn ngữ của bạn bởi trợ lý AI.
Hướng dẫn đã dịch chỉ mang tính tiện lợi — **bản gốc tiếng Anh là phiên bản chính thức**.

## Lưu ý bảo mật

Sau khi thiết lập, các API key được lưu trong `.mcp.json`.
**Không commit `.mcp.json` lên Git.** Dùng `.mcp.json.dist` làm template phân phối.

## Tuyên bố miễn trừ trách nhiệm

Plugin này được cung cấp "nguyên trạng" theo MIT License, không có bảo đảm dưới bất kỳ hình thức nào.

**API bên ngoài.** Plugin này phụ thuộc vào các API của bên thứ ba (Exa, Jina AI và các bên khác). Tác giả không đảm bảo về tính khả dụng, độ chính xác, giá cả hay tính liên tục của các dịch vụ này và không chịu trách nhiệm về chi phí phát sinh từ việc sử dụng API.

**Quản lý API Key.** Bạn hoàn toàn chịu trách nhiệm trong việc lấy, bảo mật và quản lý API key của mình, cũng như tuân thủ điều khoản dịch vụ của từng nhà cung cấp.

**Phân loại nội dung.** Khi lấy nội dung web, plugin có thể sử dụng phân loại dựa trên LLM để đánh giá mức độ nhạy cảm về quyền riêng tư và xác định phương thức truy xuất phù hợp. Các phân loại như vậy chỉ là nỗ lực tốt nhất và có thể có sai sót. Không dựa vào phân loại tự động như biện pháp bảo vệ duy nhất cho thông tin nhạy cảm hoặc bảo mật.

**Lấy nội dung web & Tự động hóa trình duyệt.** Plugin này bao gồm các công cụ tự động hóa trình duyệt không giao diện qua Playwright và Chrome DevTools. Bạn chịu trách nhiệm đảm bảo việc sử dụng của mình tuân thủ điều khoản dịch vụ của trang web đích, chính sách robots.txt và các luật hiện hành. Tác giả không chịu trách nhiệm về việc bị chặn trang web, đình chỉ tài khoản, hạn chế IP, thực thi script không mong muốn, tiêu thụ tài nguyên hoặc các vấn đề tương thích phát sinh từ tự động hóa trình duyệt.

**MCP Servers.** Plugin này kết nối với các MCP (Model Context Protocol) server của bên thứ ba. Tác giả không kiểm soát, kiểm tra hay đảm bảo hành vi hoặc bảo mật của các server này.

## Ghi nhận bên thứ ba

Plugin này tích hợp với các công cụ và dịch vụ bên ngoài sau đây. Không có mã nguồn bên thứ ba nào được phân phối lại — tích hợp thông qua kết nối MCP server, cài đặt gói lúc chạy và các wrapper script do nhà phát triển plugin tự viết.

| Công cụ | Nhà cung cấp | Giấy phép |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tất cả tên sản phẩm, logo và nhãn hiệu đều là tài sản của chủ sở hữu tương ứng. Plugin này không có liên kết hay được xác nhận bởi bất kỳ dịch vụ bên thứ ba nào được liệt kê ở trên.

## Hỗ trợ

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Báo cáo lỗi, yêu cầu tính năng và câu hỏi

## Tác giả

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Giấy phép

[MIT License](../LICENSE) — tự do sử dụng, chỉnh sửa và phân phối. Copyright (c) 2026 shidoyu.

