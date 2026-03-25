🇯🇵 [日本語](README.ja.md) · 🇰🇷 [한국어](README.ko.md) · 🇨🇳 [简体中文](README.zh-CN.md) · 🇹🇼 [繁體中文](README.zh-TW.md) · 🇧🇷 [Português](README.pt-BR.md) · 🇩🇪 [Deutsch](README.de.md) · 🇪🇸 [Español](README.es.md) · 🇫🇷 **Français** · 🇮🇱 [עברית](README.he.md) · 🇪🇪 [Eesti](README.et.md) · 🇸🇪 [Svenska](README.sv.md)

> **Note :** Cette traduction est fournie à titre indicatif. La [version originale en anglais](../README.md) fait foi.

# scout — Recherche Web & Récupération de Contenu

Le WebSearch intégré à Claude Code retourne des extraits de 125 caractères et repose uniquement sur la correspondance par mots-clés. scout transforme une question vague en requêtes optimisées pour plusieurs moteurs, évalue la qualité des résultats et relance la recherche si nécessaire — pour atteindre les sources primaires plus rapidement et de manière plus fiable.

## Fonctionnalités

- **scout:search** — Recherche web multi-moteurs avec optimisation de la conception des requêtes
- **scout:fetch** — Récupération de contenu d'URL avec sélection d'outil respectueuse de la vie privée

## Installation

Exécutez dans votre terminal :

```bash
# Étape 1 : Enregistrer le marketplace
claude plugin marketplace add shidoyu/scout

# Étape 2 : Installer le plugin
claude plugin install scout@shidoyu-scout
```

## Démarrage rapide

scout fonctionne immédiatement après l'installation — la recherche utilise WebSearch (intégré) et Exa (gratuit, sans clé requise). Une configuration optionnelle ajoute des capacités supplémentaires :

```bash
bash tools/setup.sh
```

## Skills

### scout:search

Recherche web intelligente avec :
- Pré-recherche pour affiner les requêtes
- Conception de requêtes multilingues
- Plusieurs moteurs de recherche (WebSearch, recherche sémantique [Exa](https://exa.ai))
- HyDE ([Hypothetical Document Embeddings](https://arxiv.org/abs/2212.10496)) pour les requêtes conceptuelles via Exa
- Évaluation de la qualité avec boucle de re-recherche automatique

Utilisation : `/scout:search votre question ici`

### scout:fetch

Récupération du contenu d'une page web avec classification automatique de la confidentialité :
- **Pages publiques** → Jina Reader (clé API requise) / WebFetch (solution de repli intégrée)
- **Pages confidentielles** → Playwright local (aucun appel API externe)
- **Pages authentifiées** → Chrome DevTools (session navigateur)

Utilisation : `/scout:fetch URL`

## Configuration (optionnelle)

Exécutez `tools/setup.sh` pour configurer :

1. **Exa** — Outils de recherche avancés natifs IA (clé API pour les fonctionnalités payantes ; le niveau gratuit fonctionne sans configuration)
2. **Jina Reader** — Récupération de pages web de haute qualité en Markdown (clé API requise ; sans elle, les pages publiques utilisent WebFetch comme solution de repli)
3. **Playwright** — Récupération basée sur le navigateur pour les pages rendues par JavaScript et les pages confidentielles (~200 Mo à télécharger)

Toutes les étapes sont facultatives. Relancez le script à tout moment pour mettre à jour les paramètres.
Après la configuration, redémarrez Claude Code (ou exécutez `/mcp`) pour que les nouveaux serveurs MCP prennent effet.

## Confidentialité

scout classe les URLs en trois niveaux avant la récupération :
- **Publique** → APIs cloud (Jina Reader / WebFetch)
- **Confidentielle** → Playwright local uniquement (routage prévu : les URLs confidentielles ne sont pas envoyées à des APIs externes)
- **Authentifiée** → Chrome DevTools (utilise votre session navigateur)

Ce classement est automatique mais basé sur le jugement du LLM, et non sur une application système. Consultez la section [Avertissement sur la confidentialité](#avertissement-sur-la-confidentialité) pour plus de détails.

## Prérequis

- Claude Code
- `jq` (pour le script de configuration uniquement)
- `npm`/`npx` (pour le serveur [MCP](https://modelcontextprotocol.io/) : chrome-devtools)
- Python 3.10+ (optionnel, pour la récupération locale via Playwright)
- `uvx` ou `uv` (optionnel, pour le serveur MCP : markitdown — conversion HTML→Markdown)
- Chrome (optionnel, pour la récupération de pages authentifiées via DevTools)

### Configuration de Chrome DevTools (pour les pages authentifiées)

Pour récupérer des pages nécessitant une connexion (OAuth, tableaux de bord SaaS), Chrome doit être lancé en mode débogage :

```bash
# macOS
open -a "Google Chrome" --args --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```

## Avertissement sur la confidentialité

scout classe les URLs par sensibilité et achemine les URLs confidentielles vers des outils locaux uniquement.
Ce classement est basé sur le jugement du LLM (patterns de domaine et contexte) et **n'est pas une garantie appliquée par le système**.
Pour les données hautement sensibles, vérifiez le classement avant de continuer.

**Profil de navigateur.** Le programme de récupération basé sur Playwright (`fetch-page.py`) utilise un profil de navigateur persistant (`tools/.chrome-profile/`) qui peut accumuler des cookies, des données de session et un historique de navigation. Ce répertoire est exclu de Git via `.gitignore`, mais peut être copié par des outils de sauvegarde ou des services de synchronisation cloud. Supprimez ce répertoire périodiquement si vous récupérez des pages confidentielles.

## Langue

Les instructions de configuration sont fournies dans votre langue par l'assistant IA.
Les instructions traduites sont fournies à titre indicatif uniquement — **la version originale en anglais fait foi**.

## Note de sécurité

Après l'exécution de `setup.sh`, les clés API sont stockées dans `.mcp.json`.
**Ne commitez pas `.mcp.json` dans Git.** Utilisez `.mcp.json.dist` comme modèle pour la distribution.

## Avertissement général

Ce plugin est fourni « en l'état » sous la licence MIT, sans garantie d'aucune sorte.

**APIs externes.** Ce plugin repose sur des APIs tierces (Exa, Jina AI, et autres). L'auteur ne garantit pas la disponibilité, l'exactitude, la tarification ou la continuité de ces services, et n'est pas responsable des coûts engagés par l'utilisation des APIs.

**Gestion des clés API.** Vous êtes seul responsable de l'obtention, de la sécurisation et de la gestion de vos propres clés API, ainsi que du respect des conditions d'utilisation de chaque fournisseur.

**Classification du contenu.** Lors de la récupération de contenu web, le plugin peut utiliser une classification basée sur un LLM pour évaluer la sensibilité en matière de confidentialité et déterminer les méthodes de récupération appropriées. De telles classifications sont fournies au mieux et peuvent contenir des erreurs. Ne vous fiez pas uniquement à la classification automatisée comme seule protection pour les informations sensibles ou confidentielles.

**Récupération web et automatisation du navigateur.** Ce plugin inclut des outils pour l'automatisation de navigateur sans interface graphique via Playwright et Chrome DevTools. Vous êtes responsable de vous assurer que votre utilisation est conforme aux conditions d'utilisation des sites web cibles, aux politiques robots.txt et aux lois applicables. L'auteur n'est pas responsable des blocages de sites, des suspensions de comptes, des restrictions d'IP, de l'exécution inattendue de scripts, de la consommation de ressources ou des problèmes de compatibilité résultant de l'automatisation du navigateur.

**Serveurs MCP.** Ce plugin se connecte à des serveurs MCP (Model Context Protocol) tiers. L'auteur ne contrôle pas, n'audite pas et ne garantit pas le comportement ou la sécurité de ces serveurs.

## Attributions tierces

Ce plugin s'intègre avec les outils et services externes suivants. Aucun code source tiers n'est redistribué — l'intégration se fait via des connexions de serveurs MCP, l'installation de packages à l'exécution et des scripts wrapper rédigés par le développeur du plugin.

| Outil | Fournisseur | Licence |
|---|---|---|
| [Exa API](https://exa.ai) | Exa Labs, Inc. | Propriétaire (conditions d'utilisation de l'API) |
| [Jina AI MCP Server](https://github.com/jina-ai/MCP) | Jina AI GmbH | Apache License 2.0 |
| [markitdown-mcp](https://github.com/microsoft/markitdown) | Microsoft Corporation | MIT License |
| [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Google LLC | Apache License 2.0 |
| [Playwright](https://github.com/microsoft/playwright-python) | Microsoft Corporation | Apache License 2.0 |

Tous les noms de produits, logos et marques commerciales sont la propriété de leurs propriétaires respectifs. Ce plugin n'est pas affilié à, ni approuvé par, aucun des services tiers listés ci-dessus.

## Assistance

- [GitHub Issues](https://github.com/shidoyu/scout/issues) — Rapports de bugs, demandes de fonctionnalités et questions

## Auteur

**SHIDO, Yuichiro** ([@SHIDO_Yuichiro](https://x.com/SHIDO_Yuichiro)) — AI Operations Designer

## Licence

[MIT License](../LICENSE) — libre d'utilisation, de modification et de distribution. Copyright (c) 2026 shidoyu.

