🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇩🇪 [Deutsch](README.de.md) · 🇫🇷 **Français** · 🇪🇸 [Español](README.es.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇮🇹 [Italiano](README.it.md) · 🇳🇱 [Nederlands](README.nl.md) · 🇵🇱 [Polski](README.pl.md) · 🇨🇿 [Čeština](README.cs.md) · 🇺🇦 [Українська](README.uk.md) · 🇷🇺 [Русский](README.ru.md) · 🇸🇪 [Svenska](README.sv.md) · 🇩🇰 [Dansk](README.da.md) · 🇪🇪 [Eesti](README.et.md) · 🇹🇷 [Türkçe](README.tr.md) · 🇸🇦 [العربية](README.ar.md) · 🇮🇱 [עברית](README.he.md) · 🇻🇳 [Tiếng Việt](README.vi.md) · 🇮🇩 [Bahasa Indonesia](README.id.md) · 🇹🇭 [ไทย](README.th.md) · [English](../README.md)

> **Note :** Cette traduction est fournie à titre indicatif. La [version originale en anglais](../README.md) fait foi.

<p align="center">
  <img src="assets/hero.png" alt="scout — Réfléchir d'abord. Chercher ensuite." width="820">
</p>

<p align="center">
  <img src="assets/demo.gif" alt="scout demo" width="820">
</p>

<h1 align="center">scout</h1>

<p align="center">
  Plugin de recherche web pour <a href="https://claude.com/claude-code">Claude Code</a>.<br>
  Transforme des questions vagues en requêtes multi-moteurs optimisées qui atteignent les sources primaires.
</p>

<p align="center">
  <strong>Réfléchir d'abord. Chercher ensuite.</strong>
</p>

---

La WebSearch intégrée de Claude Code renvoie des extraits de 125 caractères et repose uniquement sur la correspondance de mots-clés. C'est suffisant pour des recherches simples — mais pour une vraie recherche, il faut de la conception de requêtes, de l'évaluation des sources et un routage respectueux de la vie privée.

scout réfléchit avant de chercher.

## Démarrage rapide

Aucune clé API requise. Aucune modification d'environnement. Installez et essayez immédiatement :

**1. Ajouter le marketplace** (une seule fois) :

```bash
claude plugin marketplace add shidoyu/scout
```

**2. Installer** :

```bash
claude plugin install scout@shidoyu-scout
```

**3. Recharger les plugins** (tapez ceci dans Claude Code) :

```
/mcp
```

Puis demandez à Claude :

```text
/scout:search Je cherche quelque chose comme Git blame mais pour les décisions de conception
```

scout transformera ce concept vague en terme exact (ADR — Architecture Decision Records), lancera des requêtes optimisées sur plusieurs moteurs, évaluera la qualité des sources et renverra une réponse avec un Research Trail montrant exactement comment il y est parvenu.

## Ce que fait scout

### Trouver des concepts qu'on ne sait pas encore nommer

> « Je sais que le concept existe — quelque chose pour tracer pourquoi on a fait chaque choix de conception — mais je ne connais pas le nom »

scout traduit les idées floues en terminologie précise et atteint les sources primaires.

### Percer le bruit du SEO

> « Vers quoi devrais-je vraiment migrer depuis Terraform — pas les listes sponsorisées, de vrais retours de migration »

La pré-recherche acquiert le vocabulaire adéquat, puis des requêtes ciblées contournent les fermes de contenu.

### Atteindre directement la documentation officielle

> « Comment configurer le middleware dans Next.js App Router ? »

scout vérifie d'abord [Context7](https://github.com/upstash/context7) pour la documentation officielle indexée — aucune recherche web nécessaire si la réponse s'y trouve.

### Lire n'importe quelle page web

> « Récupère et résume https://docs.anthropic.com/en/docs/claude-code »

Récupération respectueuse de la vie privée : les pages publiques passent par les API cloud, les pages confidentielles restent sur votre machine.

## Niveaux de configuration

scout fonctionne immédiatement après l'installation. Chaque niveau ajoute des capacités — tous optionnels, tous réversibles.

### Niveau 1 : Recherche intégrée (par défaut)

Utilise la WebSearch de Claude Code. Aucune configuration nécessaire. C'est ce que vous obtenez directement.

### Niveau 2 : Documentation officielle + récupération améliorée

Ajoutez [Context7](https://github.com/upstash/context7) pour accéder directement à la documentation des bibliothèques et frameworks. Le nettoyage du contenu superflu par Jina Reader est intégré — aucune configuration nécessaire. Le bruit des pages est automatiquement supprimé, ce qui réduit le texte occupant votre contexte.

### Niveau 3 : Recherche sémantique

[Exa](https://exa.ai) pour une recherche basée sur le sens — trouve des pages pertinentes même quand vous ne connaissez pas les bons mots-clés. La recherche sémantique de base fonctionne avec le niveau gratuit ; une clé API débloque les fonctionnalités avancées.

### Niveau 4 : Navigateur local

[Playwright](https://playwright.dev) pour les pages rendues en JavaScript et les URL confidentielles qui ne doivent jamais quitter votre machine. Nécessite le téléchargement de Chromium (~200 Mo).

**Exécutez `/scout:setup` pour configurer chaque niveau de manière interactive.** Chaque étape montre exactement ce qui sera ajouté à votre configuration avant toute modification. Relancez à tout moment pour ajouter ou mettre à jour des outils.

## Skills

| Skill | Fonction |
|---|---|
| `/scout:search` | Recherche web multi-moteurs avec conception de requêtes, évaluation des sources et re-recherche automatique |
| `/scout:fetch` | Récupération de contenu d'URL avec classification automatique de confidentialité |
| `/scout:setup` | Configuration interactive guidée pour les moteurs de recherche et les outils de récupération |

### Research Trail

Chaque recherche se termine par un protocole structuré montrant comment scout est parvenu à sa réponse :

```
🔍 Research Trail
───────────────────────────────
Query:           votre question originale
Designed queries: les requêtes optimisées que scout a réellement exécutées
Sources:         URLs avec niveau de fiabilité (🟢 primaire / 🟡 secondaire / ⚪ tertiaire)
Re-searches:     recherches supplémentaires éventuelles et leurs raisons
Confidence:      High / Medium / Low avec justification
```

## Confidentialité

scout classe les URL en trois niveaux avant de les récupérer :

| Classification | Routage | Exemples |
|---|---|---|
| **Public** | API cloud (Jina Reader / WebFetch) | Blogs, documentation, dépôts GitHub publics |
| **Confidentiel** | Playwright local uniquement | localhost, wikis internes, panneaux d'administration |
| **Authentifié** | Playwright CDP | Notion, Slack, pages post-OAuth |

Cette classification repose sur le jugement du LLM, pas sur une application technique. Considérez-la comme un routage au mieux. Pour les données hautement sensibles, vérifiez la classification avant de poursuivre.

**Les URL confidentielles ne sont jamais envoyées aux API externes, même en cas d'échec** — le système ne bascule pas sur les outils cloud pour les pages confidentielles.

<details>
<summary>Configuration du mode débogage Chrome (pour les pages authentifiées)</summary>

Pour récupérer des pages nécessitant une connexion (OAuth, tableaux de bord SaaS), lancez Chrome en mode débogage . Chrome 146+ requires a separate `--user-data-dir`:

macOS :

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --remote-debugging-port=9222 \
  --user-data-dir=$HOME/.chrome-debug
```

Linux :

```bash
google-chrome --remote-debugging-port=9222 --user-data-dir=$HOME/.chrome-debug
```

On first launch with a new `--user-data-dir`, you'll need to log in to your accounts again. After that, sessions persist across restarts.
</details>

<details>
<summary>Note sur le profil navigateur</summary>

Le fetcher basé sur Playwright utilise un profil navigateur persistant (`tools/.chrome-profile/`) qui peut accumuler des cookies et des données de session. Ce répertoire est exclu de Git via `.gitignore`, mais peut être copié par des outils de sauvegarde. Supprimez-le périodiquement si vous récupérez des pages confidentielles.
</details>

## Désinstallation

Deux commandes pour tout supprimer. Aucun résidu.

Supprimer le plugin (nettoie le cache, la configuration et les données d'état) :

```bash
claude plugin uninstall scout@shidoyu-scout
```

Supprimer Context7 s'il a été ajouté via scout:setup (portée utilisateur — supprimé de tous les projets) :

```bash
claude mcp remove context7
```

## Prérequis

- **Claude Code** (requis)
- `jq` (uniquement pour les diagnostics de configuration)
- Python 3.10+ (uniquement pour la récupération locale via Playwright)

## Sécurité

Les clés API sont stockées dans `.mcp.json` à l'intérieur du répertoire du plugin.
**Ne committez pas `.mcp.json` dans Git.** Le modèle `.mcp.json.dist` peut être distribué en toute sécurité.

## Avertissement

Ce plugin est fourni « tel quel » sous la licence MIT, sans garantie d'aucune sorte.

**API externes.** Ce plugin s'appuie sur des API tierces (Exa, Jina AI et autres). L'auteur ne garantit ni la disponibilité, ni l'exactitude, ni la tarification, ni la continuité de ces services et n'est pas responsable des coûts engendrés par l'utilisation des API.

**Gestion des clés API.** Vous êtes seul responsable de l'obtention, de la sécurisation et de la gestion de vos propres clés API, ainsi que du respect des conditions d'utilisation de chaque fournisseur.

**Classification du contenu.** La classification de confidentialité des URL repose sur le jugement du LLM et peut contenir des erreurs. Ne vous y fiez pas comme seule protection pour les informations sensibles.

**Récupération web & automatisation de navigateur.** Ce plugin inclut des outils d'automatisation de navigateur headless via Playwright. Vous êtes responsable de vous assurer que votre utilisation est conforme aux conditions d'utilisation des sites cibles, à leurs politiques robots.txt et aux lois applicables.

**Serveurs MCP.** Ce plugin se connecte à des serveurs MCP tiers. L'auteur ne contrôle, n'audite ni ne garantit le comportement ou la sécurité de ces serveurs.

## Attributions tierces

Aucun code source tiers n'est redistribué — l'intégration se fait via des connexions MCP, des installations de paquets à l'exécution et des scripts wrapper.

| Outil | Fournisseur | Licence |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Proprietary (API terms) |
| [Jina Reader API](https://jina.ai) (via r.jina.ai URL prefix) | Jina AI GmbH | — |
| [Context7 MCP](https://github.com/upstash/context7) | Upstash, Inc. | Apache License 2.0 |
| [markitdown](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tous les noms de produits, logos et marques sont la propriété de leurs détenteurs respectifs.

## Langue

Les instructions de configuration sont fournies dans votre langue par l'assistant IA. Les README traduits sont fournis à titre indicatif — **la version originale en anglais fait foi**.

## Support

[GitHub Issues](https://github.com/shidoyu/scout/issues) — Rapports de bugs, demandes de fonctionnalités et questions

## Auteur

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licence

[MIT License](../LICENSE) — libre d'utilisation, de modification et de distribution. Copyright (c) 2026 shidoyu.
