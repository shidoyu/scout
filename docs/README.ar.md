🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 **العربية** · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **ملاحظة:** هذه الترجمة مقدّمة لأغراض التسهيل فقط. [النص الأصلي بالإنجليزية](../README.md) هو النسخة الرسمية.

<p align="center">
  <img src="assets/hero.png" alt="scout — فكّر أولاً. ابحث ثانياً." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  إضافة بحث ويب لـ <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  يحوّل الأسئلة الغامضة إلى استعلامات مُحسّنة متعددة المحركات تصل إلى المصادر الأولية.
</p>

<p align="center">
  <strong>فكّر أولاً. ابحث ثانياً.</strong>
</p>

---

خاصية WebSearch المدمجة في Claude Code تُرجع مقتطفات من 125 حرفاً وتعتمد على مطابقة الكلمات المفتاحية فقط. هذا كافٍ للبحث البسيط — لكن البحث الحقيقي يتطلب تصميم استعلامات، وتقييم مصادر، وتوجيه يراعي الخصوصية.

scout يفكّر قبل أن يبحث.

## البدء السريع

لا حاجة لمفاتيح API. لا تغييرات في البيئة. ثبّت وجرّب فوراً:

**1. أضف المتجر** (مرة واحدة):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. التثبيت**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. أعد تحميل الإضافات** (اكتب هذا داخل Claude Code):

```
/mcp
```

ثم اسأل Claude:

```text
/scout:search أريد شيئاً مثل Git blame لكن لقرارات التصميم
```

سيحوّل scout هذا المفهوم الغامض إلى المصطلح الصحيح (ADR — Architecture Decision Records)، ويُنفّذ استعلامات مُحسّنة عبر محركات متعددة، ويُقيّم جودة المصادر، ويُعيد الإجابة مع Research Trail يوضّح بالضبط كيف وصل إليها.

## ماذا يفعل scout

### اعثر على مفاهيم لا تعرف اسمها بعد

> "أعرف أن المفهوم موجود — شيء عن تسجيل سبب كل قرار تصميمي — لكن لا أعرف اسمه"

scout يترجم الأفكار الضبابية إلى مصطلحات دقيقة ويصل إلى المصادر الأولية.

### تجاوز ضوضاء SEO

> "إلى ماذا يجب أن أنتقل فعلاً من Terraform — ليس القوائم المموّلة، قصص هجرة حقيقية"

البحث التمهيدي يكتسب المفردات الصحيحة، ثم الاستعلامات المُوجّهة تتجاوز مزارع المحتوى.

### الوصول مباشرة إلى التوثيق الرسمي

> "كيف أُعدّ middleware في Next.js App Router؟"

scout يتحقق أولاً من [Context7](https://github.com/upstash/context7) للتوثيق الرسمي المفهرس — لا حاجة لبحث ويب إذا كانت الإجابة هناك.

### اقرأ أي صفحة ويب

> "اجلب ولخّص https://docs.anthropic.com/en/docs/claude-code"

جلب يراعي الخصوصية: الصفحات العامة تمر عبر واجهات API السحابية، والصفحات السرية تبقى على جهازك.

## مستويات الإعداد

scout يعمل فوراً بعد التثبيت. كل مستوى يضيف إمكانية — الكل اختياري، والكل قابل للتراجع.

### المستوى 1: البحث المدمج (افتراضي)

يستخدم WebSearch الخاص بـ Claude Code. لا حاجة لأي تهيئة. هذا ما تحصل عليه مباشرة.

### المستوى 2: التوثيق الرسمي + جلب أنظف

أضف [Context7](https://github.com/upstash/context7) للوصول المباشر إلى وثائق المكتبات وأُطر العمل. يزيل Jina Reader ضوضاء الصفحة، فيقلّ النص الذي يستهلك سياقك ويوفّر الرموز. يعمل من دون مفتاح (20 req/min)؛ ويمنحك مفتاح API مجاني 500 req/min.

### المستوى 3: البحث الدلالي

أضف [Exa](https://exa.ai) للبحث القائم على المعنى — يجد صفحات ذات صلة حتى لو لم تعرف الكلمات المفتاحية الصحيحة. البحث الدلالي الأساسي يعمل بالمستوى المجاني؛ مفتاح API يفتح الميزات المتقدمة.

### المستوى 4: متصفح محلي

أضف [Playwright](https://playwright.dev) للصفحات المُصيّرة بـ JavaScript وعناوين URL السرية التي لا ينبغي أن تغادر جهازك. يتطلب تنزيل Chromium (~200 ميجابايت).

**شغّل `/scout:setup` للمرور على كل مستوى بشكل تفاعلي.** كل خطوة تعرض بالضبط ما سيُضاف إلى تهيئتك قبل أي تغيير. أعد التشغيل في أي وقت لإضافة أو تحديث الأدوات.

## المهارات

| المهارة | الغرض |
|---|---|
| `/scout:search` | بحث ويب متعدد المحركات مع تصميم استعلامات، وتقييم مصادر، وإعادة بحث تلقائية |
| `/scout:fetch` | جلب محتوى URL مع تصنيف خصوصية تلقائي |
| `/scout:setup` | إعداد تفاعلي مُوجّه لمحركات البحث وأدوات الجلب |

### Research Trail

كل بحث ينتهي بسجل منظّم يوضّح كيف وصل scout إلى إجابته:

```
🔍 Research Trail
───────────────────────────────
Query:           سؤالك الأصلي
Designed queries: الاستعلامات المُحسّنة التي نفّذها scout فعلياً
Sources:         عناوين URL مع تصنيف الموثوقية (🟢 أولي / 🟡 ثانوي / ⚪ ثالثي)
Re-searches:     أي عمليات بحث إضافية وأسبابها
Confidence:      High / Medium / Low مع المبررات
```

## الخصوصية

scout يُصنّف عناوين URL إلى ثلاث فئات قبل الجلب:

| التصنيف | التوجيه | أمثلة |
|---|---|---|
| **عام** | واجهات API السحابية (Jina Reader / WebFetch) | مدونات، توثيق، مستودعات GitHub العامة |
| **سري** | Playwright محلي فقط | localhost، ويكي داخلي، لوحات الإدارة |
| **مُصادق عليه** | Playwright CDP | Notion، Slack، صفحات ما بعد OAuth |

هذا التصنيف مبني على حكم LLM، وليس إلزاماً من النظام. تعامل معه كتوجيه بأفضل جهد. للبيانات عالية الحساسية، تحقق من التصنيف قبل المتابعة.

**عناوين URL السرية لا تُرسل أبداً إلى واجهات API خارجية، حتى عند الفشل** — النظام لا يلجأ إلى أدوات سحابية للصفحات السرية.

<details>
<summary>إعداد وضع تصحيح Chrome (للصفحات المُصادق عليها)</summary>

لجلب الصفحات التي تتطلب تسجيل دخول (OAuth، لوحات SaaS)، شغّل Chrome في وضع التصحيح. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>ملاحظة حول ملف تعريف المتصفح</summary>

أداة الجلب المبنية على Playwright تستخدم ملف تعريف متصفح دائم (`tools/.chrome-profile/`) قد يتراكم فيه ملفات تعريف الارتباط وبيانات الجلسات. هذا المجلد مستبعد من Git عبر `.gitignore` لكن قد يُنسخ بواسطة أدوات النسخ الاحتياطي. احذفه دورياً إذا كنت تجلب صفحات سرية.
</details>

## إلغاء التثبيت

أمران لإزالة كل شيء. لا بقايا.

أزل الإضافة (ينظّف ذاكرة التخزين المؤقت والتهيئة وبيانات الحالة):

```bash
claude plugin uninstall scout@shidoyu-scout
```

أزل Context7 إذا أضفته عبر scout:setup (على مستوى المستخدم — يُزال من جميع المشاريع):

```bash
claude mcp remove context7
```

## المتطلبات

- **Claude Code** (مطلوب)
- `jq` (لتشخيص الإعداد فقط)
- Python 3.10+ (لجلب Playwright المحلي فقط)

## الأمان

مفاتيح API تُخزّن في `.mcp.json` داخل مجلد الإضافة.
**لا تُضف `.mcp.json` إلى Git.** القالب `.mcp.json.dist` آمن للتوزيع.

## إخلاء المسؤولية

هذه الإضافة مقدّمة "كما هي" بموجب رخصة MIT، دون أي ضمانات من أي نوع.

**واجهات API الخارجية.** تعتمد هذه الإضافة على واجهات API لأطراف ثالثة (Exa وJina AI وغيرها). لا يُقدّم المؤلف أي ضمانات بشأن توفر هذه الخدمات أو دقتها أو أسعارها أو استمراريتها، وليس مسؤولاً عن التكاليف الناتجة عن استخدام API.

**إدارة مفاتيح API.** أنت المسؤول الوحيد عن الحصول على مفاتيح API الخاصة بك وتأمينها وإدارتها، والامتثال لشروط خدمة كل مزوّد.

**تصنيف المحتوى.** تصنيف خصوصية URL مبني على حكم LLM وقد يحتوي على أخطاء. لا تعتمد عليه كضمانة وحيدة للمعلومات الحساسة.

**جلب الويب وأتمتة المتصفح.** تتضمن هذه الإضافة أدوات أتمتة متصفح بدون واجهة عبر Playwright . أنت مسؤول عن التأكد من أن استخدامك يتوافق مع شروط خدمة المواقع المستهدفة وسياسات robots.txt والقوانين المعمول بها.

**خوادم MCP.** تتصل هذه الإضافة بخوادم MCP لأطراف ثالثة. لا يتحكم المؤلف في سلوك أو أمان هذه الخوادم ولا يراقبها ولا يضمنها.

## إسناد الأطراف الثالثة

لا يُعاد توزيع أي كود مصدري لأطراف ثالثة — التكامل يتم عبر اتصالات MCP، وتثبيت حزم وقت التشغيل، وسكربتات مُغلّفة.

| الأداة | المزوّد | الرخصة |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

جميع أسماء المنتجات والشعارات والعلامات التجارية هي ملك لأصحابها المعنيين.

## اللغة

تُقدّم تعليمات الإعداد بلغتك عبر مساعد AI. الترجمات لأغراض التسهيل — **النص الأصلي بالإنجليزية هو المعتمد**.

## الدعم

[GitHub Issues](https://github.com/shidoyu/scout/issues) — تقارير الأخطاء، طلبات الميزات، والأسئلة

## المؤلف

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## الرخصة

[MIT License](../LICENSE) — حر الاستخدام والتعديل والتوزيع. Copyright (c) 2026 shidoyu.
