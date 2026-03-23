🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 **Español** · 🇫🇷 [Français](README.fr.md) · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **Nota:** Esta traducción es solo para conveniencia. El [original en inglés](../README.md) es la versión oficial.

# scout — Búsqueda Web y Obtención de Contenido

El WebSearch integrado de Claude Code devuelve fragmentos de 125 caracteres y se basa únicamente en coincidencia de palabras clave. scout convierte una pregunta vaga en consultas optimizadas para múltiples motores, evalúa la calidad de los resultados y realiza nuevas búsquedas cuando es necesario — llegando a las fuentes primarias de forma más rápida y confiable.

## Funcionalidades

- **scout:search** — Búsqueda web en múltiples motores con optimización del diseño de consultas
- **scout:fetch** — Obtención de contenido de URLs con selección de herramientas consciente de la privacidad

## Instalación

Ejecuta en tu terminal:

```bash
claude plugin add shidoyu/scout
```

## Inicio Rápido

scout funciona de inmediato tras la instalación — la búsqueda utiliza WebSearch (integrado) y Exa (gratuito, sin necesidad de clave). La configuración opcional añade más capacidades:

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Búsqueda web inteligente con:
- Pre-investigación para refinamiento de consultas
- Diseño de consultas en múltiples idiomas
- Múltiples motores de búsqueda (WebSearch, búsqueda semántica de [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) para consultas conceptuales mediante Exa
- Evaluación de calidad con bucle automático de nueva búsqueda

Uso: `/scout:search tu pregunta aquí`

### scout:fetch

Obtención de contenido de páginas web con clasificación automática de privacidad:
- **Páginas públicas** → Jina Reader (requiere clave de API) / WebFetch (alternativa integrada)
- **Páginas confidenciales** → Playwright local (sin llamadas a APIs externas)
- **Páginas autenticadas** → Chrome DevTools (sesión del navegador)

Uso: `/scout:fetch URL`

## Configuración (Opcional)

Ejecuta `tools/setup.sh` para configurar:

1. **Exa** — Herramientas de búsqueda avanzada nativas de IA (clave de API para funciones de pago; el nivel gratuito funciona sin configuración)
2. **Jina Reader** — Obtención de páginas web de alta calidad en Markdown (requiere clave de API; sin ella, las páginas públicas recurren a WebFetch)
3. **Playwright** — Obtención basada en navegador para páginas renderizadas con JavaScript y páginas confidenciales (~200 MB de descarga)

Todos los pasos son omitibles. Puedes volver a ejecutarlo en cualquier momento para actualizar la configuración.
Tras la configuración, reinicia Claude Code (o ejecuta `/mcp`) para que los nuevos servidores MCP surtan efecto.

## Privacidad

scout clasifica las URLs en tres niveles antes de obtener su contenido:
- **Público** → APIs en la nube (Jina Reader / WebFetch)
- **Confidencial** → Solo Playwright local (enrutamiento previsto: las URLs confidenciales no se envían a APIs externas)
- **Autenticado** → Chrome DevTools (utiliza tu sesión del navegador)

Esta clasificación es automática, pero se basa en el criterio del LLM, no en una aplicación a nivel de sistema. Consulta el [Aviso de Privacidad](#aviso-de-privacidad) para más detalles.

## Requisitos

- Claude Code
- `jq` (solo para el script de configuración)
- `npm`/`npx` (para el servidor [MCP](https://modelcontextprotocol.io/): chrome-devtools)
- Python 3.10+ (opcional, para obtención local con Playwright)
- `uvx` o `uv` (opcional, para el servidor MCP: markitdown — conversión HTML→Markdown)
- Chrome (opcional, para la obtención de páginas autenticadas mediante DevTools)

### Configuración de Chrome DevTools (para páginas autenticadas)

Para obtener páginas que requieren inicio de sesión (OAuth, paneles de SaaS), Chrome debe ejecutarse en modo depuración:

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
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

Tras ejecutar `setup.sh`, las claves de API se almacenan en `.mcp.json`.
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

