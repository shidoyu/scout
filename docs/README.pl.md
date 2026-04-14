🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 **Polski** · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Uwaga:** To tłumaczenie udostępniane jest wyłącznie dla wygody. Wersją oficjalną jest [angielski oryginał](../README.md).

<p align="center">
  <img src="assets/hero.png" alt="scout — Najpierw pomyśl. Potem szukaj." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Wtyczka do badań internetowych dla <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Zamienia niejasne pytania w zoptymalizowane zapytania wielosilnikowe, które docierają do źródeł pierwotnych.
</p>

<p align="center">
  <strong>Najpierw pomyśl. Potem szukaj.</strong>
</p>

---

Wbudowane WebSearch w Claude Code zwraca fragmenty o długości 125 znaków i opiera się wyłącznie na dopasowaniu słów kluczowych. To wystarcza do prostych wyszukiwań, ale prawdziwe badania wymagają projektowania zapytań, oceny źródeł i routingu uwzględniającego prywatność.

scout myśli, zanim zacznie szukać.

## Szybki start

Nie potrzeba kluczy API. Nie trzeba zmieniać środowiska. Zainstaluj i od razu wypróbuj:

**1. Dodaj marketplace** (jednorazowo):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Zainstaluj**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Przeładuj wtyczki** (wpisz to w Claude Code):

```
/mcp
```

Następnie zapytaj Claude:

```text
/scout:search Szukam czegoś w stylu Git blame, ale do śledzenia decyzji projektowych
```

scout przekształci tę niejasną koncepcję w odpowiedni termin (ADR — Architecture Decision Records), przeszuka wiele silników zoptymalizowanymi zapytaniami, oceni jakość źródeł i zwróci odpowiedź z Research Trail pokazującym dokładnie, jak do niej dotarł.

## Co robi scout

### Znajduje koncepcje, których jeszcze nie potrafisz nazwać

> „Wiem, że taka koncepcja istnieje — coś o śledzeniu, dlaczego podjęto każdą decyzję projektową — ale nie znam jej nazwy"

scout tłumaczy rozmyte pomysły na precyzyjną terminologię i dociera do źródeł pierwotnych.

### Przebija się przez szum SEO

> „Na co faktycznie powinienem migrować z Terraform — nie sponsorowane listy, a prawdziwe historie migracji"

Wstępne badania pozwalają zdobyć odpowiednie słownictwo, a następnie ukierunkowane zapytania omijają farmy treści.

### Dociera bezpośrednio do oficjalnej dokumentacji

> „Jak skonfigurować middleware w Next.js App Router?"

scout najpierw sprawdza [Context7](https://github.com/upstash/context7) pod kątem zindeksowanej dokumentacji oficjalnej — jeśli odpowiedź jest tam, wyszukiwanie w sieci nie jest potrzebne.

### Odczytuje dowolną stronę internetową

> „Pobierz i podsumuj https://docs.anthropic.com/en/docs/claude-code"

Pobieranie z uwzględnieniem prywatności: strony publiczne przechodzą przez API w chmurze, strony poufne pozostają na Twoim komputerze.

## Poziomy konfiguracji

scout działa natychmiast po instalacji. Każdy poziom dodaje możliwości — wszystkie są opcjonalne i odwracalne.

### Poziom 1: Wbudowane wyszukiwanie (domyślne)

Korzysta z WebSearch w Claude Code. Nie wymaga konfiguracji. To dostajesz od razu po instalacji.

### Poziom 2: Oficjalna dokumentacja + czystsze pobieranie

Dodaj [Context7](https://github.com/upstash/context7) do bezpośredniego dostępu do dokumentacji bibliotek i frameworków oraz [Jina Reader](https://jina.ai), który usuwa zbędne elementy stron i ogranicza szum w kontekście. Żadne z nich nie wymaga klucza API — Jina działa bezpłatnie z limitem 20 req/min bez żadnych dodatkowych kwot.

### Poziom 3: Wyszukiwanie semantyczne

Dodaj [Exa](https://exa.ai) do wyszukiwania opartego na znaczeniu — znajduje odpowiednie strony nawet wtedy, gdy nie znasz właściwych słów kluczowych. Podstawowe wyszukiwanie semantyczne działa w darmowym planie; klucz API odblokowuje zaawansowane funkcje.

### Poziom 4: Lokalna przeglądarka

Dodaj [Playwright](https://playwright.dev) do stron renderowanych przez JavaScript i poufnych adresów URL, które nie powinny opuszczać Twojego komputera. Pobiera Chromium (~200MB).

**Uruchom `/scout:setup`, aby interaktywnie przejść przez każdy poziom.** Każdy krok pokazuje dokładnie, co zostanie dodane do konfiguracji, zanim jakiekolwiek zmiany zostaną wprowadzone. Możesz uruchamiać ponownie w dowolnym momencie, aby dodać lub zaktualizować narzędzia.

## Umiejętności

| Umiejętność | Przeznaczenie |
|---|---|
| `/scout:search` | Wielosilnikowe wyszukiwanie internetowe z projektowaniem zapytań, oceną źródeł i automatycznym ponownym wyszukiwaniem |
| `/scout:fetch` | Pobieranie treści URL z automatyczną klasyfikacją prywatności |
| `/scout:setup` | Interaktywny przewodnik konfiguracji silników wyszukiwania i narzędzi pobierania |

### Research Trail

Każde wyszukiwanie kończy się ustrukturyzowanym zapisem pokazującym, jak scout dotarł do odpowiedzi:

```
🔍 Research Trail
───────────────────────────────
Query:           Twoje oryginalne pytanie
Designed queries: zoptymalizowane zapytania, które scout faktycznie wykonał
Sources:         adresy URL z poziomem wiarygodności (🟢 źródła pierwotne / 🟡 źródła wtórne / ⚪ źródła trzeciego rzędu)
Re-searches:     dodatkowe wyszukiwania i ich powody
Confidence:      High / Medium / Low z uzasadnieniem
```

## Prywatność

scout klasyfikuje adresy URL na trzy poziomy przed pobraniem:

| Klasyfikacja | Routing | Przykłady |
|---|---|---|
| **Publiczne** | API w chmurze (Jina Reader / WebFetch) | Blogi, dokumentacja, publiczne repozytoria GitHub |
| **Poufne** | Tylko lokalny Playwright | localhost, wewnętrzne wiki, panele administracyjne |
| **Z uwierzytelnieniem** | Playwright CDP | Notion, Slack, strony po uwierzytelnieniu OAuth |

Ta klasyfikacja opiera się na ocenie LLM, a nie na egzekwowaniu systemowym. Traktuj ją jako routing najlepszego wysiłku. W przypadku wysoce wrażliwych danych zweryfikuj klasyfikację przed kontynuowaniem.

**Poufne adresy URL nigdy nie są wysyłane do zewnętrznych API, nawet w przypadku niepowodzenia** — system nie przechodzi na narzędzia chmurowe dla stron poufnych.

<details>
<summary>Konfiguracja trybu debugowania Chrome (dla stron z uwierzytelnieniem)</summary>

Aby pobierać strony wymagające logowania (OAuth, panele SaaS), uruchom Chrome w trybie debugowania. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Uwaga dotycząca profilu przeglądarki</summary>

Moduł pobierania oparty na Playwright używa trwałego profilu przeglądarki (`tools/.chrome-profile/`), w którym mogą gromadzić się pliki cookie i dane sesji. Ten katalog jest wyłączony z Git przez `.gitignore`, ale może być kopiowany przez narzędzia do tworzenia kopii zapasowych. Usuwaj go okresowo, jeśli pobierasz strony poufne.
</details>

## Odinstalowanie

Dwa polecenia usuwają wszystko. Bez pozostałości.

Usuń wtyczkę (czyści pamięć podręczną, konfigurację i dane stanu):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Usuń Context7, jeśli dodałeś go przez scout:setup (zakres użytkownika — usuwany ze wszystkich projektów):

```bash
claude mcp remove context7
```

## Wymagania

- **Claude Code** (wymagane)
- `jq` (tylko do diagnostyki konfiguracji)
- Python 3.10+ (tylko do lokalnego pobierania przez Playwright)

## Bezpieczeństwo

Klucze API są przechowywane w pliku `.mcp.json` w katalogu wtyczki.
**Nie commituj `.mcp.json` do Git.** Szablon `.mcp.json.dist` jest bezpieczny do dystrybucji.

## Zastrzeżenie

Ta wtyczka jest udostępniana „tak jak jest" na licencji MIT, bez jakiejkolwiek gwarancji.

**Zewnętrzne API.** Ta wtyczka korzysta z API firm trzecich (Exa, Jina AI i inne). Autor nie gwarantuje dostępności, dokładności, cenników ani ciągłości tych usług i nie ponosi odpowiedzialności za koszty poniesione w wyniku korzystania z API.

**Zarządzanie kluczami API.** Pozyskiwanie, zabezpieczanie i zarządzanie własnymi kluczami API oraz przestrzeganie warunków usług każdego dostawcy leży wyłącznie w Twojej odpowiedzialności.

**Klasyfikacja treści.** Klasyfikacja prywatności adresów URL opiera się na ocenie LLM i może zawierać błędy. Nie polegaj na niej jako jedynym zabezpieczeniu informacji wrażliwych.

**Pobieranie stron i automatyzacja przeglądarki.** Ta wtyczka zawiera narzędzia do automatyzacji przeglądarki bezgłowej za pomocą Playwright. To Ty odpowiadasz za zgodność z warunkami usług odwiedzanych stron, politykami robots.txt i obowiązującym prawem.

**Serwery MCP.** Ta wtyczka łączy się z serwerami MCP firm trzecich. Autor nie kontroluje, nie audytuje ani nie gwarantuje działania i bezpieczeństwa tych serwerów.

## Przypisania stron trzecich

Kod źródłowy firm trzecich nie jest redystrybuowany — integracja odbywa się poprzez połączenia MCP, instalacje pakietów w czasie wykonania i skrypty opakowujące.

| Narzędzie | Dostawca | Licencja |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Wszystkie nazwy produktów, logo i znaki towarowe są własnością ich odpowiednich właścicieli.

## Język

Instrukcje konfiguracji są dostarczane w Twoim języku przez asystenta AI. Przetłumaczone pliki README służą wygodzie — **angielski oryginał jest wersją oficjalną**.

## Wsparcie

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Zgłoszenia błędów, prośby o funkcje i pytania

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licencja

[MIT License](../LICENSE) — można swobodnie używać, modyfikować i dystrybuować. Copyright (c) 2026 shidoyu.
