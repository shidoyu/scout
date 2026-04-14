🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 **עברית** · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **הערה:** תרגום זה מסופק לנוחות בלבד. [המקור באנגלית](../README.md) הוא הגרסה הרשמית.

<p align="center">
  <img src="assets/hero.png" alt="scout — קודם לחשוב. אחר כך לחפש." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  תוסף מחקר ברשת עבור <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  הופך שאלות מעורפלות לשאילתות מותאמות מרובות מנועים שמגיעות למקורות ראשוניים.
</p>

<p align="center">
  <strong>קודם לחשוב. אחר כך לחפש.</strong>
</p>

---

ה-WebSearch המובנה של Claude Code מחזיר קטעים של 125 תווים ומסתמך על התאמת מילות מפתח בלבד. זה מספיק לחיפושים פשוטים — אבל למחקר אמיתי נדרשים עיצוב שאילתות, הערכת מקורות וניתוב מודע פרטיות.

scout חושב לפני שהוא מחפש.

## התחלה מהירה

ללא צורך במפתחות API. ללא שינויי סביבה. התקינו ונסו מיד:

**1. הוסיפו את ה-marketplace** (פעם אחת):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. התקנה**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. טענו מחדש את התוספים** (הקלידו בתוך Claude Code):

```
/mcp
```

ואז שאלו את Claude:

```text
/scout:search אני רוצה משהו כמו Git blame אבל עבור החלטות עיצוב
```

scout יהפוך את הרעיון המעורפל הזה למונח הנכון (ADR — Architecture Decision Records), יריץ שאילתות ממוקדות במנועים מרובים, יעריך את איכות המקורות, ויחזיר תשובה עם Research Trail שמראה בדיוק איך הגיע לתוצאה.

## מה scout עושה

### מצאו מושגים שעדיין לא ידוע לכם שמם

> "אני יודע שהמושג קיים — משהו על תיעוד הסיבות מאחורי כל החלטת עיצוב — אבל לא יודע איך קוראים לזה"

scout מתרגם רעיונות מעורפלים לטרמינולוגיה מדויקת ומגיע למקורות הראשוניים.

### חתכו דרך רעש ה-SEO

> "למה באמת כדאי לעבור מ-Terraform — לא הרשימות הממומנות, סיפורי מיגרציה אמיתיים"

מחקר מקדים רוכש את אוצר המילים הנכון, ואז שאילתות ממוקדות עוקפות את חוות התוכן.

### הגיעו ישירות לתיעוד הרשמי

> "איך מגדירים middleware ב-Next.js App Router?"

scout בודק קודם ב-[Context7](https://github.com/upstash/context7) תיעוד רשמי מאונדקס — אין צורך בחיפוש ברשת אם התשובה שם.

### קראו כל דף אינטרנט

> "הבא ותמצת https://docs.anthropic.com/en/docs/claude-code"

שליפה מודעת פרטיות: דפים ציבוריים עוברים דרך API-ים בענן, דפים סודיים נשארים על המחשב שלכם.

## רמות הגדרה

scout עובד מיד לאחר ההתקנה. כל רמה מוסיפה יכולת — הכול אופציונלי, הכול הפיך.

### רמה 1: חיפוש מובנה (ברירת מחדל)

משתמש ב-WebSearch של Claude Code. אין צורך בהגדרה. זה מה שמקבלים ישר מהקופסה.

### רמה 2: תיעוד רשמי + שליפה נקייה יותר

הוסף את [Context7](https://github.com/upstash/context7) לגישה ישירה לתיעוד ספריות ופריימוורקים, ואת [Jina Reader](https://jina.ai) להסרת רעשי רקע מהדפים כדי שפחות עומס ימלא את ההקשר שלך. אין צורך ב-API key לאף אחד מהם — Jina עובד בחינם עם מגבלה של 20 req/min ללא מכסה.

### רמה 3: חיפוש סמנטי

הוסיפו [Exa](https://exa.ai) לחיפוש מבוסס משמעות — מוצא דפים רלוונטיים גם כשלא ידועות לכם מילות המפתח הנכונות. חיפוש סמנטי בסיסי עובד בחינם; מפתח API פותח תכונות מתקדמות.

### רמה 4: דפדפן מקומי

הוסיפו [Playwright](https://playwright.dev) עבור דפים שדורשים JavaScript וכתובות URL סודיות שלא צריכות לעזוב את המחשב שלכם. מוריד Chromium (~200MB).

**הריצו `/scout:setup` כדי לעבור על כל רמה באופן אינטראקטיבי.** כל שלב מראה בדיוק מה יתווסף להגדרות לפני כל שינוי. הריצו מחדש בכל עת כדי להוסיף או לעדכן כלים.

## מיומנויות

| מיומנות | ייעוד |
|---|---|
| `/scout:search` | חיפוש ברשת מרובה מנועים עם עיצוב שאילתות, הערכת מקורות וחיפוש חוזר אוטומטי |
| `/scout:fetch` | שליפת תוכן URL עם סיווג פרטיות אוטומטי |
| `/scout:setup` | הגדרה מודרכת אינטראקטיבית למנועי חיפוש וכלי שליפה |

### Research Trail

כל חיפוש מסתיים בעקבות מובנה שמראה איך scout הגיע לתשובה:

```
🔍 Research Trail
───────────────────────────────
Query:           השאלה המקורית שלכם
Designed queries: השאילתות המותאמות ש-scout הריץ בפועל
Sources:         כתובות URL עם דירוג אמינות (🟢 ראשוני / 🟡 משני / ⚪ שלישוני)
Re-searches:     חיפושים נוספים ומדוע
Confidence:      High / Medium / Low עם נימוק
```

## פרטיות

scout מסווג כתובות URL לשלוש רמות לפני השליפה:

| סיווג | ניתוב | דוגמאות |
|---|---|---|
| **ציבורי** | API-ים בענן (Jina Reader / WebFetch) | בלוגים, תיעוד, מאגרי GitHub ציבוריים |
| **סודי** | Playwright מקומי בלבד | localhost, ויקי פנימי, פאנלי ניהול |
| **מאומת** | Playwright CDP | Notion, Slack, דפים לאחר OAuth |

סיווג זה מבוסס על שיקול דעת LLM, לא על אכיפה מערכתית. התייחסו אליו כניתוב best-effort. עבור נתונים רגישים במיוחד, אמתו את הסיווג לפני שתמשיכו.

**כתובות URL סודיות לעולם לא נשלחות ל-API-ים חיצוניים, גם בכישלון** — המערכת לא נופלת חזרה לכלי ענן עבור דפים סודיים.

<details>
<summary>הגדרת מצב דיבאג של Chrome (עבור דפים מאומתים)</summary>

לשליפת דפים שדורשים התחברות (OAuth, דאשבורדים של SaaS), הפעילו את Chrome במצב דיבאג. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>הערה לגבי פרופיל הדפדפן</summary>

כלי השליפה מבוסס Playwright משתמש בפרופיל דפדפן קבוע (`tools/.chrome-profile/`) שעשוי לצבור עוגיות ונתוני סשן. תיקייה זו מוחרגת מ-Git באמצעות `.gitignore` אך עשויה להיות מועתקת על ידי כלי גיבוי. מחקו אותה מעת לעת אם אתם שולפים דפים סודיים.
</details>

## הסרה

שתי פקודות להסרת הכול. ללא שאריות.

הסירו את התוסף (מנקה מטמון, הגדרות ונתוני מצב):

```bash
claude plugin uninstall scout@shidoyu-scout
```

הסירו Context7 אם הוספתם אותו דרך scout:setup (ברמת המשתמש — מוסר מכל הפרויקטים):

```bash
claude mcp remove context7
```

## דרישות

- **Claude Code** (נדרש)
- `jq` (לאבחון הגדרות בלבד)
- Python 3.10+ (רק לשליפה מקומית עם Playwright)

## אבטחה

מפתחות API נשמרים ב-`.mcp.json` בתוך תיקיית התוסף.
**אל תעשו commit ל-`.mcp.json` ב-Git.** התבנית `.mcp.json.dist` בטוחה להפצה.

## כתב ויתור

תוסף זה מסופק "כמות שהוא" תחת רישיון MIT, ללא אחריות מכל סוג.

**API-ים חיצוניים.** תוסף זה מסתמך על API-ים של צדדים שלישיים (Exa, Jina AI ואחרים). המחבר אינו מתחייב לזמינות, דיוק, תמחור או המשכיות של שירותים אלה ואינו אחראי לעלויות שנגרמות משימוש ב-API.

**ניהול מפתחות API.** אתם האחראים הבלעדיים להשגה, אבטחה וניהול מפתחות ה-API שלכם, ולציות לתנאי השירות של כל ספק.

**סיווג תוכן.** סיווג פרטיות URL מבוסס על שיקול דעת LLM ועשוי לכלול שגיאות. אל תסתמכו עליו כמגן היחיד למידע רגיש.

**שליפת אינטרנט ואוטומציית דפדפן.** תוסף זה כולל כלים לאוטומציית דפדפן headless באמצעות Playwright. אתם אחראים לוודא שהשימוש שלכם עומד בתנאי השירות של אתרי היעד, מדיניות robots.txt והחוקים החלים.

**שרתי MCP.** תוסף זה מתחבר לשרתי MCP של צדדים שלישיים. המחבר אינו שולט, מבקר או מבטיח את ההתנהגות או האבטחה של שרתים אלה.

## ייחוס צדדים שלישיים

לא מופץ מחדש קוד מקור של צדדים שלישיים — האינטגרציה מתבצעת דרך חיבורי MCP, התקנת חבילות בזמן ריצה וסקריפטים עוטפים.

| כלי | ספק | רישיון |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

כל שמות המוצרים, הלוגואים והסימנים המסחריים הם רכושם של בעליהם בהתאמה.

## שפה

הוראות ההגדרה מסופקות בשפתכם על ידי עוזר ה-AI. התרגומים הם לנוחות — **המקור באנגלית הוא המוסמך**.

## תמיכה

[GitHub Issues](https://github.com/shidoyu/scout/issues) — דיווחי באגים, בקשות תכונות ושאלות

## מחבר

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## רישיון

[MIT License](../LICENSE) — חופשי לשימוש, שינוי והפצה. Copyright (c) 2026 shidoyu.
