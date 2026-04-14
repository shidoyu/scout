🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 [Français](README.fr.md) · 🇪🇸 **Español** · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Nota:** Esta traducción se proporciona por conveniencia. La [versión original en inglés](../README.md) es la versión oficial.

<p align="center">
  <img src="assets/hero.png" alt="scout — Primero piensa. Después busca." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Plugin de investigación web para <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Convierte preguntas vagas en consultas multi-motor optimizadas que alcanzan las fuentes primarias.
</p>

<p align="center">
  <strong>Primero piensa. Después busca.</strong>
</p>

---

La WebSearch integrada de Claude Code devuelve fragmentos de 125 caracteres y se basa únicamente en la coincidencia de palabras clave. Es suficiente para búsquedas sencillas — pero para una investigación real, se necesita diseño de consultas, evaluación de fuentes y enrutamiento consciente de la privacidad.

scout piensa antes de buscar.

## Inicio rápido

Sin claves API. Sin cambios de entorno. Instala y prueba inmediatamente:

**1. Agregar el marketplace** (una sola vez):

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Instalar**:

```bash
claude plugin install scout@shidoyu-scout
```

**3. Recargar plugins** (escribe esto dentro de Claude Code):

```
/mcp
```

Luego pregunta a Claude:

```text
/scout:search Busco algo como Git blame pero para decisiones de diseño
```

scout convertirá este concepto vago en el término correcto (ADR — Architecture Decision Records), buscará en múltiples motores con consultas optimizadas, evaluará la calidad de las fuentes y devolverá una respuesta con un Research Trail que muestra exactamente cómo llegó al resultado.

## Qué hace scout

### Encontrar conceptos que aún no sabes nombrar

> «Sé que el concepto existe — algo sobre registrar por qué tomamos cada decisión de diseño — pero no sé cómo se llama»

scout traduce ideas difusas en terminología precisa y alcanza las fuentes primarias.

### Atravesar el ruido del SEO

> «¿A qué debería migrar realmente desde Terraform? No las listas patrocinadas, sino historias reales de migración»

La pre-investigación adquiere el vocabulario adecuado, y luego las consultas dirigidas evitan las granjas de contenido.

### Llegar directamente a la documentación oficial

> «¿Cómo configuro middleware en Next.js App Router?»

scout primero consulta [Context7](https://github.com/upstash/context7) en busca de documentación oficial indexada — si la respuesta está ahí, no se necesita búsqueda web.

### Leer cualquier página web

> «Obtén y resume https://docs.anthropic.com/en/docs/claude-code»

Obtención consciente de la privacidad: las páginas públicas pasan por APIs en la nube, las páginas confidenciales se procesan en tu máquina.

## Niveles de configuración

scout funciona inmediatamente después de la instalación. Cada nivel añade capacidades — todos opcionales, todos reversibles.

### Nivel 1: Búsqueda integrada (por defecto)

Usa la WebSearch de Claude Code. Sin configuración necesaria. Es lo que obtienes de serie.

### Nivel 2: Documentación oficial + obtención más limpia

Agrega [Context7](https://github.com/upstash/context7) para acceder directamente a la documentación de bibliotecas y frameworks. Jina Reader elimina el ruido de la página, así menos texto ocupa tu contexto y ahorras tokens. Funciona sin clave (20 req/min); una API key gratuita desbloquea 500 req/min.

### Nivel 3: Búsqueda semántica

[Exa](https://exa.ai) para búsqueda basada en el significado — encuentra páginas relevantes incluso cuando no conoces las palabras clave correctas. La búsqueda semántica básica funciona con el nivel gratuito; una clave API desbloquea funciones avanzadas.

### Nivel 4: Navegador local

[Playwright](https://playwright.dev) para páginas renderizadas con JavaScript y URLs confidenciales que nunca deben salir de tu máquina. Requiere descargar Chromium (~200 MB).

**Ejecuta `/scout:setup` para configurar cada nivel de forma interactiva.** Cada paso muestra exactamente qué se añadirá a tu configuración antes de realizar cambios. Ejecútalo de nuevo en cualquier momento para agregar o actualizar herramientas.

## Skills

| Skill | Propósito |
|---|---|
| `/scout:search` | Búsqueda web multi-motor con diseño de consultas, evaluación de fuentes y re-búsqueda automática |
| `/scout:fetch` | Obtención de contenido de URLs con clasificación automática de privacidad |
| `/scout:setup` | Configuración interactiva guiada para motores de búsqueda y herramientas de obtención |

### Research Trail

Cada búsqueda termina con un registro estructurado que muestra cómo scout llegó a su respuesta:

```
🔍 Research Trail
───────────────────────────────
Query:           tu pregunta original
Designed queries: las consultas optimizadas que scout ejecutó realmente
Sources:         URLs con nivel de fiabilidad (🟢 primaria / 🟡 secundaria / ⚪ terciaria)
Re-searches:     búsquedas adicionales y sus razones
Confidence:      High / Medium / Low con justificación
```

## Privacidad

scout clasifica las URLs en tres niveles antes de obtenerlas:

| Clasificación | Enrutamiento | Ejemplos |
|---|---|---|
| **Público** | APIs en la nube (Jina Reader / WebFetch) | Blogs, documentación, repos públicos de GitHub |
| **Confidencial** | Solo Playwright local | localhost, wikis internos, paneles de administración |
| **Autenticado** | Playwright CDP | Notion, Slack, páginas post-OAuth |

Esta clasificación se basa en el juicio del LLM, no en una aplicación técnica. Trátala como enrutamiento de mejor esfuerzo. Para datos altamente sensibles, verifica la clasificación antes de proceder.

**Las URLs confidenciales nunca se envían a APIs externas, ni siquiera en caso de fallo** — el sistema no recurre a herramientas en la nube para páginas confidenciales.

<details>
<summary>Configuración del modo depuración de Chrome (para páginas autenticadas)</summary>

Para obtener páginas que requieren inicio de sesión (OAuth, paneles SaaS), inicia Chrome en modo depuración. Chrome 146+ requires a separate `--user-data-dir`:

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
<summary>Nota sobre el perfil del navegador</summary>

El fetcher basado en Playwright usa un perfil de navegador persistente (`tools/.chrome-profile/`) que puede acumular cookies y datos de sesión. Este directorio está excluido de Git mediante `.gitignore`, pero puede ser copiado por herramientas de respaldo. Elimínalo periódicamente si obtienes páginas confidenciales.
</details>

## Desinstalación

Dos comandos para eliminar todo. Sin residuos.

Eliminar el plugin (limpia caché, configuración y datos de estado):

```bash
claude plugin uninstall scout@shidoyu-scout
```

Eliminar Context7 si se añadió mediante scout:setup (alcance de usuario — se elimina de todos los proyectos):

```bash
claude mcp remove context7
```

## Requisitos

- **Claude Code** (requerido)
- `jq` (solo para diagnósticos de configuración)
- Python 3.10+ (solo para obtención local con Playwright)

## Seguridad

Las claves API se almacenan en `.mcp.json` dentro del directorio del plugin.
**No hagas commit de `.mcp.json` en Git.** La plantilla `.mcp.json.dist` es segura para distribuir.

## Descargo de responsabilidad

Este plugin se proporciona «tal cual» bajo la Licencia MIT, sin garantía de ningún tipo.

**APIs externas.** Este plugin depende de APIs de terceros (Exa, Jina AI y otros). El autor no garantiza la disponibilidad, exactitud, precios ni continuidad de estos servicios y no es responsable de los costos derivados del uso de las APIs.

**Gestión de claves API.** Eres el único responsable de obtener, proteger y gestionar tus propias claves API, y de cumplir con los términos de servicio de cada proveedor.

**Clasificación de contenido.** La clasificación de privacidad de URLs se basa en el juicio del LLM y puede contener errores. No dependas de ella como única salvaguarda para información sensible.

**Obtención web y automatización de navegador.** Este plugin incluye herramientas de automatización de navegador headless mediante Playwright. Eres responsable de asegurar que tu uso cumple con los términos de servicio de los sitios objetivo, sus políticas de robots.txt y las leyes aplicables.

**Servidores MCP.** Este plugin se conecta a servidores MCP de terceros. El autor no controla, audita ni garantiza el comportamiento ni la seguridad de estos servidores.

## Atribuciones de terceros

No se redistribuye código fuente de terceros — la integración se realiza mediante conexiones MCP, instalación de paquetes en tiempo de ejecución y scripts wrapper.

| Herramienta | Proveedor | Licencia |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Todos los nombres de productos, logos y marcas comerciales son propiedad de sus respectivos titulares.

## Idioma

Las instrucciones de configuración se proporcionan en tu idioma por el asistente de IA. Los README traducidos son por conveniencia — **la versión original en inglés es la oficial**.

## Soporte

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Reportes de errores, solicitudes de funcionalidades y preguntas

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licencia

[MIT License](../LICENSE) — libre para usar, modificar y distribuir. Copyright (c) 2026 shidoyu.
