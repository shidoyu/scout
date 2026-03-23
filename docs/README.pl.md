🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇵🇱 [**Polski**](README.pl.md)

> **Uwaga:** To tłumaczenie jest udostępnione wyłącznie dla wygody. [Oryginał w języku angielskim](../README.md) jest wersją oficjalną.

# scout — Wyszukiwanie w sieci i pobieranie treści

Wbudowany WebSearch w Claude Code zwraca fragmenty tekstu o długości 125 znaków i opiera się wyłącznie na dopasowaniu słów kluczowych. scout zamienia niejasne pytanie w zoptymalizowane zapytania do wielu wyszukiwarek, ocenia jakość wyników i w razie potrzeby wyszukuje ponownie — docierając do pierwotnych źródeł szybciej i pewniej.

## Funkcje

- **scout:search** — Wyszukiwanie w wielu wyszukiarkach z optymalizacją projektowania zapytań
- **scout:fetch** — Pobieranie treści z adresów URL z uwzględnieniem prywatności przy wyborze narzędzi

## Instalacja

Uruchom w terminalu:

```bash
claude plugin add shidoyu/scout
```

## Szybki start

scout działa od razu po instalacji — wyszukiwanie korzysta z WebSearch (wbudowanego) oraz Exa (bezpłatne, bez potrzeby podawania klucza). Opcjonalna konfiguracja dodaje więcej możliwości:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Inteligentne wyszukiwanie w sieci z funkcjami:
- Wstępne badanie tematu w celu doprecyzowania zapytań
- Projektowanie zapytań w wielu językach
- Wiele wyszukiwarek (WebSearch, semantyczne wyszukiwanie [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) dla zapytań koncepcyjnych poprzez Exa
- Ocena jakości z automatyczną pętlą ponownego wyszukiwania

Użycie: `/scout:search twoje pytanie tutaj`

### scout:fetch

Pobieranie treści stron internetowych z automatyczną klasyfikacją prywatności:
- **Strony publiczne** → Jina Reader (wymagany klucz API) / WebFetch (wbudowany fallback)
- **Strony poufne** → lokalny Playwright (bez zewnętrznych wywołań API)
- **Strony wymagające uwierzytelnienia** → Chrome DevTools (sesja przeglądarki)

Użycie: `/scout:fetch URL`

## Konfiguracja (opcjonalna)

Uruchom `tools/setup.sh`, aby skonfigurować:

1. **Exa** — Zaawansowane narzędzia wyszukiwania natywne dla AI (klucz API dla funkcji płatnych; bezpłatny plan działa bez konfiguracji)
2. **Jina Reader** — Wysokiej jakości pobieranie stron internetowych w formacie Markdown (wymagany klucz API; bez niego strony publiczne przełączają się na WebFetch)
3. **Playwright** — Pobieranie oparte na przeglądarce dla stron renderowanych przez JavaScript i stron poufnych (pobieranie ~200MB)

Wszystkie kroki można pominąć. Uruchamiaj ponownie w dowolnym momencie, aby zaktualizować ustawienia.
Po konfiguracji uruchom ponownie Claude Code (lub uruchom `/mcp`), aby nowe serwery MCP zaczęły działać.

## Prywatność

scout klasyfikuje adresy URL na trzy poziomy przed pobraniem:
- **Publiczne** → chmurowe API (Jina Reader / WebFetch)
- **Poufne** → wyłącznie lokalny Playwright (zamierzone przekierowanie: poufne adresy URL nie są wysyłane do zewnętrznych API)
- **Wymagające uwierzytelnienia** → Chrome DevTools (korzysta z sesji przeglądarki)

Ta klasyfikacja jest automatyczna, ale opiera się na ocenie LLM, a nie na wymuszeniu systemowym. Szczegóły znajdziesz w sekcji [Zastrzeżenie dotyczące prywatności](#zastrzeżenie-dotyczące-prywatności).

## Wymagania

- Claude Code
- `jq` (tylko do skryptu konfiguracyjnego)
- `npm`/`npx` (dla serwera [MCP](https://modelcontextprotocol.io/): chrome-devtools)
- Python 3.10+ (opcjonalnie, do lokalnego pobierania przez Playwright)
- `uvx` lub `uv` (opcjonalnie, dla serwera MCP: markitdown — konwersja HTML→Markdown)
- Chrome (opcjonalnie, do pobierania stron wymagających uwierzytelnienia przez DevTools)

### Konfiguracja Chrome DevTools (dla stron wymagających uwierzytelnienia)

Aby pobierać strony wymagające logowania (OAuth, panele SaaS), Chrome musi być uruchomiony w trybie debugowania:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Zastrzeżenie dotyczące prywatności

scout klasyfikuje adresy URL według wrażliwości i kieruje poufne adresy URL do narzędzi działających wyłącznie lokalnie.
Ta klasyfikacja opiera się na ocenie LLM (wzorce domenowe i kontekst) i **nie stanowi gwarancji wymuszonej przez system**.
W przypadku wysoce wrażliwych danych przed kontynuowaniem należy zweryfikować klasyfikację.

**Profil przeglądarki.** Narzędzie pobierające oparte na Playwright (`fetch-page.py`) używa trwałego profilu przeglądarki (`tools/.chrome-profile/`), który może gromadzić pliki cookie, dane sesji i historię przeglądania. Ten katalog jest wykluczony z Git przez `.gitignore`, ale może być kopiowany przez narzędzia do tworzenia kopii zapasowych lub usługi synchronizacji w chmurze. Usuwaj ten katalog okresowo, jeśli pobierasz strony poufne.

## Język

Instrukcje konfiguracji są dostarczane w Twoim języku przez asystenta AI.
Przetłumaczone instrukcje służą wyłącznie jako pomoc — **angielski oryginał jest wersją autorytatywną**.

## Uwaga dotycząca bezpieczeństwa

Po uruchomieniu `setup.sh` klucze API są przechowywane w `.mcp.json`.
**Nie commituj `.mcp.json` do Git.** Użyj `.mcp.json.dist` jako szablonu do dystrybucji.

## Zastrzeżenie

Ten plugin jest udostępniony „tak jak jest" na licencji MIT, bez jakichkolwiek gwarancji.

**Zewnętrzne API.** Ten plugin korzysta z zewnętrznych API (Exa, Jina AI i innych). Autor nie udziela żadnych gwarancji dotyczących dostępności, dokładności, cen ani ciągłości tych usług i nie ponosi odpowiedzialności za koszty poniesione w wyniku korzystania z API.

**Zarządzanie kluczami API.** Jesteś wyłącznie odpowiedzialny za uzyskanie, zabezpieczenie i zarządzanie własnymi kluczami API oraz za przestrzeganie warunków korzystania z usług każdego dostawcy.

**Klasyfikacja treści.** Podczas pobierania treści internetowych plugin może wykorzystywać klasyfikację opartą na LLM do oceny wrażliwości prywatności i określenia odpowiednich metod pobierania. Takie klasyfikacje są tworzone na zasadzie najlepszych starań i mogą zawierać błędy. Nie należy polegać na automatycznej klasyfikacji jako jedynym zabezpieczeniu wrażliwych lub poufnych informacji.

**Pobieranie stron internetowych i automatyzacja przeglądarki.** Ten plugin zawiera narzędzia do automatyzacji przeglądarki bez interfejsu graficznego za pomocą Playwright i Chrome DevTools. Jesteś odpowiedzialny za zapewnienie, że Twoje korzystanie jest zgodne z warunkami korzystania z docelowych stron internetowych, politykami robots.txt oraz obowiązującym prawem. Autor nie ponosi odpowiedzialności za blokowanie stron, zawieszenie kont, ograniczenia IP, nieoczekiwane wykonanie skryptów, zużycie zasobów ani problemy ze zgodnością wynikające z automatyzacji przeglądarki.

**Serwery MCP.** Ten plugin łączy się z zewnętrznymi serwerami MCP (Model Context Protocol). Autor nie kontroluje, nie audytuje ani nie gwarantuje zachowania ani bezpieczeństwa tych serwerów.

## Atrybucje stron trzecich

Ten plugin integruje się z następującymi zewnętrznymi narzędziami i usługami. Żaden kod źródłowy stron trzecich nie jest redystrybuowany — integracja odbywa się poprzez połączenia z serwerami MCP, instalację pakietów w czasie wykonywania i skrypty opakowujące napisane przez twórcę pluginu.

| Narzędzie | Dostawca | Licencja |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Zastrzeżona (warunki API) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Wszystkie nazwy produktów, logotypy i znaki towarowe są własnością ich odpowiednich właścicieli. Ten plugin nie jest powiązany z żadną z wymienionych powyżej usług stron trzecich ani przez nie popierany.

## Wsparcie

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Zgłoszenia błędów, prośby o funkcje i pytania

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licencja

[MIT License](../LICENSE) — bezpłatne do użytku, modyfikacji i dystrybucji. Copyright (c) 2026 shidoyu.

