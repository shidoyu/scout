🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 **Español** · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **Nota:** Esta traducción es solo para conveniencia. El [original en inglés](../README.md) es la versión oficial.

# scout

**Wrong search, wrong decision.**

> Primero pensar, después buscar. — Plugin de investigación web para Claude Code.

Diseño de consultas, búsqueda multi-motor, obtención con privacidad.

La WebSearch integrada de Claude Code devuelve fragmentos de solo 125 caracteres y se basa únicamente en coincidencias de palabras clave. scout convierte una pregunta vaga en consultas optimizadas para varios motores, evalúa la calidad de los resultados y vuelve a buscar cuando hace falta, para llegar a las fuentes primarias más rápido y con mayor fiabilidad.

## Funcionalidades

- **scout:search** — Búsqueda web en múltiples motores con optimización del diseño de consultas
- **scout:fetch** — Obtención de contenido de URLs con selección de herramientas consciente de la privacidad

## Instalación

Ejecuta en tu terminal:

```bash
# Paso 1: Registrar el marketplace
claude plugin marketplace add shidoyu/scout
```

```bash
# Paso 2: Instalar el plugin
claude plugin install scout@shidoyu-scout
```

**Paso 3** — Configurar motores de búsqueda y herramientas de obtención

Ejecuta estos comandos de uno en uno dentro de Claude Code:

```text
/reload-plugins
```

```text
/scout:setup
```

scout:setup te guía interactivamente para configurar Context7 (documentación de bibliotecas), Jina Reader (obtención de páginas web), Exa (búsqueda semántica) y Playwright (páginas renderizadas con JavaScript). Cada paso es opcional y se puede omitir.

> **Nota:** Si omites este paso, scout te lo pedirá al inicio de la próxima sesión. La búsqueda básica funciona de inmediato sin configuración.

## Inicio Rápido

Después de instalar, pregúntale a Claude (no se requiere configuración — la búsqueda básica funciona de inmediato):

### Pruébalo ahora

**Encontrar conceptos que aún no puedes nombrar:**
> "El patrón de diseño donde un objeto actúa como intermediario para controlar el acceso a otro objeto, por ejemplo para añadir caché o validación sin modificar el original"

**Descubrir equivalentes internacionales de conceptos locales:**
> "¿Existe un equivalente en inglés al concepto de 'chapuza' en programación — ese arreglo rápido y feo que funciona pero que sabes que te va a dar problemas?"

**Obtener respuestas expertas desde preguntas simples:**
> "Git no me deja hacer push porque dice que mi rama está detrás del remoto, pero yo no cambié nada — alguien más hizo push antes que yo"

**Leer una página específica:**
> "Lee https://git-scm.com/docs/git-rebase y explícame cuándo debería usar rebase en vez de merge"

## Skills

### scout:search

Búsqueda web inteligente con:
- Pre-investigación para refinamiento de consultas
- Diseño de consultas en múltiples idiomas
- Múltiples motores de búsqueda (WebSearch, [Context7](https://github.com/upstash/context7) documentación oficial, búsqueda semántica de [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) para consultas conceptuales mediante Exa
- Evaluación de calidad con bucle automático de nueva búsqueda

Uso: `/scout:search tu pregunta aquí`

### scout:fetch

Obtención de contenido de páginas web con clasificación automática de privacidad:
- **Páginas públicas** → Jina Reader / WebFetch (alternativa integrada)
- **Páginas confidenciales** → Playwright local (sin llamadas a APIs externas)
- **Páginas autenticadas** → Chrome DevTools (sesión del navegador)

Uso: `/scout:fetch URL`

### scout:setup

Configuración interactiva guiada para motores de búsqueda y herramientas de obtención:
- **Context7** — Acceso directo a la documentación oficial y actual de bibliotecas y frameworks, para llegar antes a la fuente con [Context7 MCP](https://github.com/upstash/context7) (sin API key)
- **Jina Reader** — Captura más limpia de páginas web como Markdown, eliminando navegación y texto repetitivo, lo que a menudo reduce el texto enviado al modelo y ahorra tokens ([API key](https://jina.ai/?newKey))
- **Exa** — Búsqueda por significado para consultas vagas, conceptuales o de nicho cuando no tienes claros los términos exactos ([API key](https://exa.ai))
- **Playwright** — Obtención local en navegador para páginas renderizadas con JavaScript o páginas confidenciales que deben quedarse en tu equipo (~200MB de descarga)

Todos los pasos son opcionales. Vuelve a ejecutarlo en cualquier momento para actualizar la configuración.

Uso: `/scout:setup`

## Privacidad

scout clasifica las URLs en tres niveles antes de obtener su contenido:
- **Público** → APIs en la nube (Jina Reader / WebFetch)
- **Confidencial** → Solo Playwright local (enrutamiento previsto: las URLs confidenciales no se envían a APIs externas)
- **Autenticado** → Chrome DevTools (utiliza tu sesión del navegador)

Esta clasificación es automática, pero se basa en el criterio del LLM, no en una aplicación a nivel de sistema. Consulta el [Aviso de Privacidad](#aviso-de-privacidad) para más detalles.

## Requisitos

- Claude Code
- `jq` (solo para la configuración)
- `npm`/`npx` (para el servidor [MCP](https://modelcontextprotocol.io/): chrome-devtools)
- Python 3.10+ (opcional, para obtención local con Playwright)
- `uvx` o `uv` (opcional, para el servidor MCP: markitdown — conversión HTML→Markdown)
- Chrome (opcional, para la obtención de páginas autenticadas mediante DevTools)

### Configuración de Chrome DevTools (para páginas autenticadas)

Para obtener páginas que requieren inicio de sesión (OAuth, paneles de SaaS), Chrome debe ejecutarse en modo depuración:

En macOS:

```bash
open -a "Google Chrome" --args --remote-debugging-port=9222
```

En Linux:

```bash
google-chrome --remote-debugging-port=9222
```

## Aviso de Privacidad

scout clasifica las URLs según su sensibilidad y enruta las URLs confidenciales hacia herramientas de solo uso local.
Esta clasificación se basa en el criterio del LLM (patrones de dominio y contexto) y **no es una garantía aplicada a nivel de sistema**.
Para datos altamente sensibles, verifica la clasificación antes de continuar.

**Perfil del Navegador.** El obtenedor basado en Playwright (`fetch-page.py`) utiliza un perfil de navegador persistente (`tools/.chrome-profile/`) que puede acumular cookies, datos de sesión e historial de navegación. Este directorio está excluido de Git mediante `.gitignore`, pero puede ser copiado por herramientas de copia de seguridad o servicios de sincronización en la nube. Elimina el directorio periódicamente si obtienes páginas confidenciales.

## Idioma

Las instrucciones de configuración se proporcionan en tu idioma a través del asistente de IA.
Las instrucciones traducidas son solo de referencia — **el original en inglés es el texto autoritativo**.

## Nota de Seguridad

Tras la configuración, las claves de API se almacenan en `.mcp.json`.
**No confirmes `.mcp.json` en Git.** Usa `.mcp.json.dist` como plantilla para la distribución.

## Aviso Legal

Este plugin se proporciona "tal cual" bajo la Licencia MIT, sin garantía de ningún tipo.

**APIs Externas.** Este plugin depende de APIs de terceros (Exa, Jina AI y otras). El autor no ofrece garantías sobre la disponibilidad, precisión, precios o continuidad de estos servicios, y no es responsable de los costos derivados del uso de la API.

**Gestión de Claves de API.** Eres el único responsable de obtener, proteger y gestionar tus propias claves de API, así como de cumplir con los términos de servicio de cada proveedor.

**Clasificación de Contenido.** Al obtener contenido web, el plugin puede utilizar clasificación basada en LLM para evaluar la sensibilidad de privacidad y determinar los métodos de recuperación adecuados. Dichas clasificaciones son de mejor esfuerzo y pueden contener errores. No dependas de la clasificación automática como única salvaguarda para información sensible o confidencial.

**Obtención Web y Automatización del Navegador.** Este plugin incluye herramientas para la automatización de navegadores sin interfaz gráfica mediante Playwright y Chrome DevTools. Eres responsable de garantizar que tu uso cumple con los términos de servicio de los sitios web de destino, las políticas de robots.txt y las leyes aplicables. El autor no es responsable de bloqueos de sitios, suspensión de cuentas, restricciones de IP, ejecución inesperada de scripts, consumo de recursos o problemas de compatibilidad derivados de la automatización del navegador.

**Servidores MCP.** Este plugin se conecta a servidores MCP (Model Context Protocol) de terceros. El autor no controla, audita ni garantiza el comportamiento o la seguridad de estos servidores.

## Atribuciones de Terceros

Este plugin se integra con las siguientes herramientas y servicios externos. No se redistribuye código fuente de terceros — la integración se realiza mediante conexiones a servidores MCP, instalación de paquetes en tiempo de ejecución y scripts de envoltura elaborados por el desarrollador del plugin.

| Herramienta | Proveedor | Licencia |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Propietaria (términos de API) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Todos los nombres de productos, logotipos y marcas registradas son propiedad de sus respectivos dueños. Este plugin no está afiliado ni cuenta con el respaldo de ninguno de los servicios de terceros mencionados anteriormente.

## Soporte

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Informes de errores, solicitudes de funcionalidades y preguntas

## Autor

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licencia

[MIT License](../LICENSE) — libre de usar, modificar y distribuir. Copyright (c) 2026 shidoyu.
