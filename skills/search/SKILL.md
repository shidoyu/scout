---
name: search
description: "Web search and content fetching. Find relevant sources and read web pages with precision."
---

# scout:search v1.0 — Query Design + Search Execution

## Purpose

Improve the rate of reaching primary sources via web search. Instead of relying on LLM prior knowledge, leverage search engine characteristics to reliably retrieve information. Preserve proper nouns rather than over-generalizing, and reach the target information with fewer queries.

## Usage

```
/scout:search what you want to find (natural language)
```

## Execution Flow

### Step 1: Analyze (Tentative Intent Classification)

From the user's input, tentatively determine the following (may change after Step 2 Pre-Research):

1. **Search intent** → See Intent Classification Table
2. **Presence of proper nouns**
3. **Information category** → See Language Selection Table
4. **User's language**

### Step 2: Pre-Research

**Always execute.** Investigate the search target with one query to improve query design accuracy.

1. **Search the target** (budget: 1 query, separate from main search budget)
   - Use the language closest to the target, with proper noun + attribute keywords
   - Default to WebSearch (Pre-Research prioritizes speed for concept understanding)
   - If needed, fetch source articles following the scout:fetch workflow (max 2 pages; the goal is concept understanding, not exhaustive research)
2. **Abstract the essence** — Describe the target's mechanism in one sentence
   - Example: "Stripe pricing" → "Online payment platform. Transaction fee-based (2.9% + 30¢/txn) + additional service-specific charges"
3. **Decompose into query vocabulary** — List keyword candidates derived from the abstraction
   - Example: `Stripe`, `pricing`, `fees`, `transaction`, `payment processing`, `plans`

**If Pre-Research does not reach full understanding**: Proceed to Step 3 based on current understanding. Note uncertain parts in the abstraction. Design main search queries using only what was reliably understood.

**For navigational intent**: Pre-Research only needs to confirm the target exists. Abstraction and vocabulary decomposition can be skipped.

### Step 3: Plan (Query Design)

Based on intent classification and language selection results, generate 1–3 queries following the output template. Design queries based on the **abstracted concept and query vocabulary** from Pre-Research.

- **Budget**: 2 queries by default, 3 max (Pre-Research query is separate). A 3rd query is added only when primary source language, English, and user language are all different. Navigational intent may complete with 1 query.
- **Differentiation**: Each query must differ in at least one of: language, intent axis (attribute/concept), or tool (WebSearch / Exa). Do not generate multiple queries with the same language + intent + tool combination.
- **HyDE mode**: When Exa is selected as the tool and the query's purpose is conceptual search (intent is `general` or `practice`), generate a hypothetical answer (2-3 sentences) to the user's question instead of keywords, and use it as the Exa query. Exa's semantic search performs better with semantically similar text than with keywords. Skip HyDE for `navigational` / `target` / `comparison` where keywords are more effective — use standard keyword queries for Exa in those cases (same format as WebSearch queries). Mark HyDE queries with `[HyDE]` tag in the output template (e.g., `Query 2: en [HyDE] "Persistent markdown files enable AI agents to carry context across sessions..." → Exa`).

### Step 4: Execute (Search Execution)

Refer to the Tool Selection Table and execute each query with the optimal tool.

**Early termination**: Only skip remaining queries when a navigational search has reached the target page. All other quality judgments happen in Step 5: Assess.

**Parallel execution**: Execute queries with the same language AND same tool sequentially (to allow refinement based on previous results). All other combinations (different language OR different tool) should be executed in parallel via the Agent tool.

**Source article deep-dive**: When search result snippets (125 characters) are insufficient for judgment, fetch URL content following the scout:fetch workflow. Source article retrieval is especially useful for verifying numbers, procedures, and specifications.

### Step 5: Assess (Search Result Evaluation)

After Execute completes, evaluate search results against three criteria. **If all are met, proceed to answering (no additional search).**

| Criterion | How to judge |
|---|---|
| **Sufficiency** | Can the user's question be directly answered? |
| **Reliability** | Did we reach a primary source OR have corroboration from multiple independent sources? For time-sensitive information, do results include recent dates? |
| **Specificity** | Did we obtain concrete information such as numbers, procedures, or specifications? (If snippets are insufficient, deep-dive with scout:fetch) |

**If any criterion is unmet → Re-search (max 2 queries, 1 cycle only)**:

1. Identify which criteria are unmet
2. Design additional queries using new vocabulary/concepts from existing results
3. Apply differentiation rule: queries must differ from previous queries in at least one of language, tool, or intent axis
4. Execute additional queries
5. Re-search runs only once (no recursion — one correction cycle for maximum effect; recursion risks query drift)

**Skip condition**: Only when Step 4 navigational early termination occurred.

## Search Tools

Query design (Steps 1-3) and search tools are independent. Tool failures do not change query design. If a tool is unavailable, fall back to another.

### Tool Selection Table

| Purpose | Recommended | Fallback | Reason |
|---|---|---|---|
| Concept/meaning search (hit even without keyword match) | Exa | WebSearch | Semantic search; returns page content inline |
| Code examples, API usage | Exa (`get_code_context_exa`) | WebSearch | Specialized for GitHub/SO/official docs, returns code |
| Find a specific page/URL | WebSearch | — | Strong at URL/title identification |
| Broad, comprehensive collection | WebSearch (multiple queries) | — | Returns many sources |
| Speed-priority / quick check | WebSearch | — | Instant results |
| Find an official site/homepage | WebSearch | — | Best for navigational search |
| A vs B comparison | WebSearch (multiple queries) | — | Needs cross-referencing multiple sources |

### WebSearch

Claude Code's built-in tool. Keyword-match search.

**Limitation**: Search result citation text is **truncated to 125 characters max**. Judge content by title and snippet only. For details, fetch source articles following the scout:fetch workflow.

### Exa MCP

Semantic search engine. Finds pages by meaning similarity rather than keyword matching. Used via MCP.

**Dual configuration**: To save credits, scout uses two servers — `exa-free` (free) and `exa` (paid, advanced tools).

**`exa-free` tools (free, rate-limited)**:
- `web_search_exa` — General web search. Results include page content (no WebFetch needed)
  - `numResults`: Number of results (default 8)
  - `category`: Filter by `company` / `research paper` / `people`
  - `contextMaxCharacters`: Max content characters (default 10,000)
  - `type`: `auto` (default) / `fast` (high-speed mode)
- `get_code_context_exa` — Code & documentation search (GitHub, Stack Overflow, official docs)
  - `tokensNum`: Tokens to return (1,000-50,000, default 5,000)

**`exa` tools (API key required, costs credits)**:
- `web_search_advanced_exa` — Advanced filtering and structured output
- `crawling_exa` — URL-targeted crawl (**URL is sent to Exa. Never use for confidential URLs. Use scout:fetch for URL content retrieval instead**)
- `company_research_exa` — Company research
- `people_search_exa` — People search
- `deep_researcher_start` / `deep_researcher_check` — Multi-step autonomous research

**Strengths**:
- Semantic search: Hits relevant pages even for conceptual queries
- Content included: Retrieves article content without needing WebFetch
- Code-specialized tool: High accuracy for programming-related searches

**Usage**: Use `exa-free` tools by default (free). Use `exa` tools only when: (a) `exa-free` returned insufficient results, (b) company or people-specific research is needed, or (c) the user explicitly requests deep multi-step research. When `exa-free` rate limit is reached, fall back to WebSearch.

### URL Content Retrieval (Auxiliary)

For deep-diving into source articles from search results. Retrieves URL content. Not a search tool — used to follow up on search results.
Tool selection follows the **scout:fetch workflow** (privacy classification → tool selection → fallback). If the scout:fetch skill is not available, use WebFetch or Jina Reader directly for public URLs.

## Intent Classification Table

| Search intent | Label | Query composition | Example |
|---|---|---|---|
| Information about the target itself (profile, official page, spec) | `target` | Proper noun + attribute keywords | `Stripe pricing plans`, `Kubernetes pod spec` |
| Methods, practices, explanations related to the target | `practice` | Proper noun + concept keywords | `React server components data fetching`, `Terraform state management` |
| General knowledge, best practices | `general` | Concept keywords only | `AI agent memory system best practices` |
| Find an official site/homepage | `navigational` | Proper noun (alone or + `official`) | `Exa AI official`, `Tavily API` |
| A vs B comparison | `comparison` | Proper noun A + Proper noun B + comparison axis | `Exa vs Tavily search API comparison` |

**Default**: When proper nouns are present, always use hybrid (proper noun + concept keywords). Use concept-only when the intent is clearly "general knowledge" AND the proper noun does not help narrow results. When in doubt, go with `practice` (hybrid).

**Comparison note**: Include proper nouns for both comparison targets. Using only one leads to biased results.

## Language Selection Table

3-tier priority search: **Primary source language → English → User's language**. Normally max 2 languages. Use 3 only when all three are different.

| Information category | Primary language | Example |
|---|---|---|
| Laws, regulations, tax policy | Official language of the jurisdiction | US tax law → English, Japan tax → Japanese |
| Academic, technical specifications | English | Papers, RFCs, API documentation |
| Products, services | Provider's primary language | Stripe → English, SAP → English |
| People, organizations | Language of activity | US researcher → English |
| Local business, lifestyle info | Local language | NYC restaurants → English |

**Speed-priority**: Acceptable to use user's language only with 1 query (though quality may suffer if primary sources are in another language).

**Fallback**: If no category matches, or if the activity language of a person/organization is unknown, default to English.

## Output Template (Mandatory)

Output the following format before executing queries:

```
--- Phase A: Pre-Research (output → tool execution → results) ---
0. Pre-Research: [lang] [query] → [tool]

--- Phase B: Analysis & Main Search Plan (output after Pre-Research results) ---
0a. Abstraction: [one-sentence essence]
0b. Keywords: [query vocabulary derived from abstraction]
1. Intent: [target / practice / general / navigational / comparison]
2. Primary language: [Language Selection Table result]
3. Query 1: [lang] [query] → [WebSearch / Exa]
4. Query 2: [lang] [query or HyDE text] → [WebSearch / Exa] (optional, HyDE: [HyDE] tag)
5. Query 3: [lang] [query] → [WebSearch / Exa] (optional, 3-language condition only)

--- Phase C: Evaluation (output after Execute completes) ---
6. Assess: [Sufficiency ✓/✗] [Reliability ✓/✗] [Specificity ✓/✗]
7. Re-search 1: [lang] [query] → [tool] (reason: [unmet criterion]) (only if ✗)
8. Re-search 2: [lang] [query] → [tool] (reason: [unmet criterion]) (optional)
```

If Pre-Research results change the initial intent classification or query composition, **redesign Intent and queries based on the post-Pre-Research understanding**.

## Transliteration Rules

- When searching in another language, transliterate proper nouns to the common form in the target language
- Semantic translation is prohibited. Use phonetic transliteration or established forms
- When unknown, use the most common international spelling

## Hard Constraints

- Do not generalize proper nouns without justification (hybrid is the default)
- Do not semantically translate proper nouns in cross-language searches (see Transliteration Rules)
- Do not drop country/region names in searches involving jurisdictions, regulations, or government
- For comparisons, include proper nouns for both sides
- Use phrase matching (double quotes) only for official names and precise technical terms
- Initial plan: max 3 queries (Pre-Research is separate). Only +2 queries if Assess finds unmet criteria (total 5 queries + Pre-Research is the ceiling)
- Each query must be differentiated by language, intent axis, or tool (no redundant query repetition)
- For time-sensitive topics (pricing, regulations, benchmarks), append the current year to queries to prioritize recent results
- Never send confidential URLs to `crawling_exa` — use scout:fetch for URL content retrieval instead
- If all available tools fail during both Execute and Re-search, report the failure to the user with the specific errors encountered. Do not fabricate results from prior knowledge

## Examples

### Example 1: Target Information (Proper Noun + Attribute)

**Input**: "What are Stripe's pricing plans?"

```
Search Plan
0. Pre-Research: en Stripe payment processing pricing model → WebSearch
0a. Abstraction: Online payment platform. Transaction fee-based (2.9% + 30¢/txn) + additional service-specific charges
0b. Keywords: Stripe, pricing, fees, transaction, payment processing, plans
1. Intent: target
2. Primary language: en (Product/service → provider language)
3. Query 1: en Stripe pricing plans fees 2026 → WebSearch
4. (Query 2 omitted — single-language target search; 1 query sufficient)
```

### Example 2: Pre-Research → Abstraction → Query Design

**Input**: "How does Terraform manage state in multi-team environments?"

```
Search Plan
0. Pre-Research: en Terraform state management multi-team → WebSearch
0a. Abstraction: Terraform uses remote backends (S3, GCS, Terraform Cloud) with state locking and workspaces to isolate and share infrastructure state across teams
0b. Keywords: Terraform, remote state, backend, state locking, workspaces, multi-team, isolation
1. Intent: practice
2. Primary language: en (Technical → English)
3. Query 1: en Terraform remote state multi-team best practices workspaces → WebSearch
4. Query 2: en [HyDE] "Teams using Terraform typically store state in remote backends like S3 or Terraform Cloud, enabling state locking to prevent concurrent modifications and using workspaces to isolate environments per team." → Exa
```

### Example 3: General Knowledge + HyDE (Conceptual Search × Exa)

**Input**: "Best practices for LLM context management"

```
--- Phase A ---
0. Pre-Research: en LLM context management techniques overview → WebSearch

--- Phase B ---
0a. Abstraction: Techniques for efficiently managing information within LLM's finite context window (summarization, compression, external memory, RAG, etc.)
0b. Keywords: context window, memory management, summarization, RAG, external memory, token optimization
1. Intent: general
2. Primary language: en (Academic/technical → English)
3. Query 1: en LLM context management best practices 2026 → WebSearch
4. Query 2: en [HyDE] "Modern LLM applications manage context windows through hierarchical summarization, external memory stores like vector databases, and retrieval-augmented generation pipelines that dynamically inject relevant context." → Exa

--- Phase C ---
6. Assess: [Sufficiency ✓] [Reliability ✓] [Specificity ✓]
```

**Key point**: Query 2 uses HyDE mode. Since the intent is `general` and Exa is the selected tool, a hypothetical answer is used as the query instead of keywords. All criteria ✓ in Assess, so no Re-search needed.

### Example 4: Jurisdiction-Specific (Region Explicit)

**Input**: "Overview of the EU AI Act"

```
Search Plan
0. Pre-Research: en EU AI Act regulation overview → WebSearch
0a. Abstraction: EU regulation classifying AI systems by risk level (unacceptable/high/limited/minimal), imposing obligations on providers and deployers, with phased enforcement starting 2024
0b. Keywords: EU AI Act, risk classification, high-risk AI, compliance, regulation, enforcement
1. Intent: target
2. Primary language: en (Regulation → jurisdiction language; EU publishes in English)
3. Query 1: en EU AI Act risk classification compliance requirements 2026 → WebSearch
4. Query 2: en EU AI Act provider obligations enforcement timeline → Exa
```

### Example 5: Comparison (A vs B)

**Input**: "Compare Exa and Tavily search APIs"

```
Search Plan
0. Pre-Research: en Exa Tavily search API comparison → WebSearch
0a. Abstraction: Two leading AI-native search APIs. Exa uses semantic search (proprietary index); Tavily is RAG-optimized (cited results)
0b. Keywords: Exa, Tavily, semantic search, RAG, API, agent score, benchmark, pricing
1. Intent: comparison
2. Primary language: en (Tech services → English)
3. Query 1: en Exa vs Tavily search API comparison benchmark 2026 → WebSearch
4. Query 2: en Exa Tavily agent score accuracy pricing → Exa
```

### Example 6: Navigational (Find Official Site)

**Input**: "Find the Linkup official site"

```
Search Plan
0. Pre-Research: en Linkup search API official → WebSearch
0a. Abstraction: Search API service that emerged after Bing API deprecation. GDPR-compliant, premium content source access
0b. Keywords: Linkup, search API, official, documentation
1. Intent: navigational
2. Primary language: en
3. Query 1: en Linkup search API official site → WebSearch
```

### Example 7: "Does X already exist?" (Pre-Research → Abstraction → Conceptual Search)

**Input**: "Is there an existing approach for AI agents to auto-generate daily work plans?"

```
Search Plan
0. Pre-Research: en AI agent daily planning automation → WebSearch
0a. Abstraction: Using persistent markdown files (e.g., CLAUDE.md) with trigger definitions + Skills to have AI auto-generate daily work plans
0b. Keywords: AI agent, daily planning, markdown, persistent schedule, skill trigger, automated daily workflow
1. Intent: general (post-abstraction: conceptual search; no specific proper noun needed)
2. Primary language: en (Technical → English)
3. Query 1: en AI agent daily planning markdown persistent schedule automation → WebSearch
4. Query 2: en [HyDE] "AI coding agents can be configured to automatically generate daily work plans by reading persistent markdown instruction files and triggering scheduled skills that output structured task lists." → Exa
```

**Key point**: After Pre-Research, the intent shifts from `practice` (proper noun + concept) to `general` (concept only). The question "does X exist?" requires searching by the essence of X, not its name.

### Example 8: Re-search Cycle (Assess Finds Unmet Criteria)

**Input**: "What are the specific token limits for OpenAI's embedding models?"

```
--- Phase A ---
0. Pre-Research: en OpenAI embedding models token limits → WebSearch

--- Phase B ---
0a. Abstraction: OpenAI provides several embedding models (text-embedding-3-small, text-embedding-3-large, ada-002) with different dimension sizes and token input limits
0b. Keywords: OpenAI, embedding, token limit, text-embedding-3, dimensions, max input
1. Intent: target
2. Primary language: en (Product → provider language)
3. Query 1: en OpenAI embedding models token limit dimensions comparison 2026 → WebSearch
4. Query 2: en OpenAI text-embedding-3 API specification max tokens → Exa

--- Phase C ---
6. Assess: [Sufficiency ✓] [Reliability ✗] [Specificity ✗]
   — Snippets mention limits but exact numbers vary across sources. No primary source (OpenAI docs) reached.
7. Re-search 1: en site:platform.openai.com embedding models limits → WebSearch (reason: Reliability — need primary source)
```

**Key point**: Assess found Reliability and Specificity unmet — snippets gave conflicting numbers and no official source was reached. Re-search targets the primary source directly using `site:` operator. After Re-search, fetch the OpenAI docs page via scout:fetch if the snippet is still insufficient.

### Example 9: Multi-Language Search with Transliteration

**Input**: "What is Samsung's latest semiconductor investment plan?"

```
Search Plan
0. Pre-Research: en Samsung semiconductor investment plan 2026 → WebSearch
0a. Abstraction: Samsung Electronics announced major fab investments in Texas and South Korea, expanding advanced chip manufacturing capacity (3nm/2nm GAA process)
0b. Keywords: Samsung, semiconductor, fab investment, Texas, foundry, GAA, 3nm, 2nm
1. Intent: target
2. Primary language: ko (Company → headquarters language: Korean)
3. Query 1: ko 삼성전자 반도체 투자 계획 2026 → WebSearch
4. Query 2: en Samsung semiconductor foundry investment plan 2026 → Exa
```

**Key point**: Samsung's primary language is Korean. Query 1 uses Korean with transliterated proper noun (삼성전자 = Samsung Electronics). Query 2 uses English for international coverage. The two queries are differentiated by language.

## Changelog

- **v1.0** (2026-03-23): Initial release.

