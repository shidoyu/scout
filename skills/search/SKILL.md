---
name: search
description: "Web search and content fetching. Find relevant sources and read web pages with precision."
---

# scout:search v2.1 — Adaptive Search with Primary-Source Focus

## Purpose

Maximize the rate of reaching primary sources via web search. Refine query precision through iterative abstraction, adapt search depth and tool selection to domain characteristics, and prioritize authoritative sources in evaluation and synthesis.

## Usage

```
/scout:search what you want to find (natural language)
```

## Design Principles

1. **Query refinement is the core.** Pre-Research → Abstraction → vocabulary acquisition → refined queries. This pipeline is the primary mechanism for reaching accurate information. Do not shortcut it.
2. **Primary sources are the goal, not the starting point.** Early phases (Pre-Research) may use secondary sources for concept understanding. Later phases (Main Search, Re-search) use refined queries to reach primary sources.
3. **Adapt to the domain.** Tool selection and search depth vary by domain characteristics. Not all queries need the same treatment.
4. **Quality over quantity.** Fewer high-quality sources beat many low-quality ones. Collect what's needed, not everything available.

## Execution Flow

### Step 0.5: Clarify (Conditional)

**Execute only when the query is ambiguous** and the search outcome would significantly differ based on interpretation.

Ambiguity indicators:
- Comparison axis is unclear (e.g., "best database" — for what use case?)
- Target version/era is unspecified for version-dependent topics
- Jurisdiction/region is omitted for location-dependent topics
- Scope is too broad to design effective queries (e.g., "Rust async best practices" — web backend? embedded? library design?)

**If ambiguous**: Ask one clarification question. Offer to proceed with an assumed interpretation if the user prefers not to answer.

**If clear**: Skip entirely. Do not ask unnecessary questions.

### Step 1: Analyze

From the user's input, determine:

1. **Search intent** → See Intent Classification Table
2. **Presence of proper nouns**
3. **Information category** → See Language Selection Table
4. **User's language**
5. **Domain characteristics** → See Domain Classification Table
6. **Risk level** — Is this a high-risk topic? (security, compliance, destructive operations, incident response)

All classifications are tentative and may change after Step 2 Pre-Research.

### Step 2: Pre-Research

**Always execute** unless the query is clearly routable (Step 2.5) — i.e., it names a specific library/framework and asks about API usage, config, or setup. In that case, attempt Source-Type Routing first; if it fully answers, Pre-Research is retrospectively unnecessary. If routing only partially answers or misses, execute Pre-Research before Step 3.

1. **Search the target** (budget: 1 query, separate from main search budget)
   - Use the language closest to the target, with proper noun + attribute keywords
   - Default to WebSearch (Pre-Research prioritizes speed for concept understanding)
   - If needed, fetch source articles following the scout:fetch workflow (max 2 pages; the goal is concept understanding, not exhaustive research)
   - **Secondary sources are acceptable here** — the goal is concept understanding and vocabulary acquisition, not authoritative answers
2. **Abstract the essence** — Describe the target's mechanism in one sentence
   - Example: "Stripe pricing" → "Online payment platform. Transaction fee-based (2.9% + 30¢/txn) + additional service-specific charges"
3. **Decompose into query vocabulary** — List keyword candidates derived from the abstraction
   - Example: `Stripe`, `pricing`, `fees`, `transaction`, `payment processing`, `plans`
4. **Re-evaluate domain classification** — Pre-Research may reveal that the domain is different from initial assessment (e.g., what looked like a simple technical query turns out to require academic research)

**If Pre-Research does not reach full understanding**: Proceed to Step 3 based on current understanding. Design main search queries using only what was reliably understood. Note uncertain parts in the abstraction for later verification.

**For navigational intent**: Pre-Research only needs to confirm the target exists. Abstraction and vocabulary decomposition can be skipped.

### Step 2.5: Route (Source-Type Routing)

**Check if the query can be answered by direct lookup** without general web search.

| Query type | Direct source | Action |
|---|---|---|
| **Library/framework docs, API usage, library/framework config** | **Context7 MCP** | **`resolve-library-id` → `query-docs`. If Context7 unavailable or library not indexed → continue to Step 3** |
| Package version / dependency info | npm, PyPI, crates.io, Maven Central | Fetch API/registry directly |
| RFC / Internet standard | IETF | Fetch directly |
| CVE / vulnerability | NVD, GitHub Advisory | Fetch directly |
| GitHub issue / PR / release | GitHub API | Fetch directly |
| Standard library docs | Official docs (MDN, docs.python.org, etc.) | Fetch directly |
| Law / regulation text | e-Gov, official gazette | Fetch directly |
| Kubernetes API / resource spec | kubernetes.io | Fetch directly |

**If routable**: Fetch the direct source. Route fetches are executed synchronously before proceeding to Step 3. If the direct source fully answers the query → skip Steps 3–5, go to Step 6: Synthesize (output abbreviated Assess ✓✓✓ for record). If partially answers → continue to Step 3 with the direct source as baseline.

**If not routable**: Continue to Step 3.

### Step 3: Plan (Query Design + Budget + Tool Selection)

Based on Pre-Research results, design the search plan.

#### 3a: Budget Allocation

Assign a budget tier based on intent and domain complexity:

| Tier | Queries | When | Re-search cycles |
|---|---|---|---|
| **S** | 1–2 | Navigational, source routing partial hit, simple factoid | 0 |
| **M** | 3–5 | Standard factual, comparison, how-to | max 1 |
| **L** | 6–8 | Multi-hop, conflicting claims, specialized research, multi-language | max 2 |

Budget is a **ceiling**, not a target. Use fewer queries if sufficient information is found early.

#### 3b: Domain-Aware Tool Selection

Select tool emphasis based on domain classification. This is a **directional guideline**, not a rigid allocation. For Tier S (1-2 queries), use the single best tool — the tool-diversity requirement is waived.

| Domain | Primary tool | Secondary tool | Rationale |
|---|---|---|---|
| **Technical** (library/framework docs) | WebSearch + Exa | — | Context7 was already called in Step 2.5. If it fully answered → skip to Step 6. If partial: use WebSearch/Exa for remaining gaps. Do not re-call Context7 here. |
| **Technical** (non-library: infra, OS, etc.) | WebSearch | Exa supplements | WebSearch reaches official docs directly. Exa adds community context |
| **Empirical** (academic/research) | Exa | WebSearch supplements | Exa HyDE excels at finding papers by meaning. WebSearch for DOI/publisher lookup |
| **Conceptual** (theory/philosophy) | Balanced | — | Both contribute; balance breadth and depth |
| **Regulatory** (law/policy/compliance) | WebSearch | Exa supplements | WebSearch for official sources + freshness. Exa for analytical context |

**Context7** is a pre-search step (Source-Type Routing), not a query budget item. If Context7 fully answers the query, no further search budget is consumed.

**Note**: Pre-Research is exempt from this guideline — use whatever tool is fastest for concept understanding.

#### 3c: Query Design

Design queries based on the **abstracted concept and query vocabulary** from Pre-Research.

- **Budget**: Per tier allocation (Tier S: 1–2, Tier M: 3–5, Tier L: 6–8). Pre-Research query is separate.
- **Differentiation**: Each query must differ in at least one of: language, intent axis (attribute/concept), or tool (WebSearch / Exa). Do not generate multiple queries with the same language + intent + tool combination.
- **Tool allocation**: Follow the domain-aware ratio from Step 3b.
- **HyDE mode**: When Exa is selected and the query's purpose is conceptual search (intent is `general` or `practice`), generate a hypothetical answer (2-3 sentences) as the Exa query. Skip HyDE for `navigational` / `target` / `comparison` — use keyword queries instead. Mark HyDE queries with `[HyDE]` tag in the output template (e.g., `Query 2: en [HyDE] "Teams using Terraform typically store state in remote backends..." → Exa`).
- **Freshness constraint**: For time-sensitive topics (pricing, regulations, benchmarks, API specs, version-dependent info), append the current year to queries and/or use date-range filters. Explicitly note freshness requirements in the plan.
- **Counter-Query** (conditional): When intent is `comparison`, add one counter-query per comparison target (e.g., "X drawbacks", "Y problems"). When risk level is high, add one counter-query (e.g., "X production issues", "why not X"). Counter-queries count toward the budget. This prevents confirmation bias in evaluative searches.
- **Primary source targeting**: For Tier M/L, design at least one query specifically aimed at primary sources (e.g., `site:docs.*`, `site:github.com`, official domain targeting). This leverages the refined vocabulary from Pre-Research to reach authoritative sources.

### Step 4: Execute (Search Execution)

Refer to the Tool Selection Table and execute each query with the assigned tool.

**Early termination**: Only skip remaining queries when a navigational search has reached the target page. All other quality judgments happen in Step 5: Assess.

**Parallel execution**: Execute queries with the same language AND same tool sequentially (to allow refinement based on previous results). All other combinations (different language OR different tool) should be executed in parallel via the Agent tool.

**Source article deep-dive**: When search result snippets (125 characters) are insufficient for judgment, fetch URL content following the scout:fetch workflow.

### Step 5: Assess (Search Result Evaluation)

After Execute completes, evaluate search results against three criteria. **If all are met, proceed to synthesis (no additional search).**

| Criterion | How to judge |
|---|---|
| **Sufficiency** | Can the user's question be directly answered? |
| **Reliability** | See Reliability sub-criteria below |
| **Specificity** | Did we obtain concrete information such as numbers, procedures, or specifications? (If snippets are insufficient, deep-dive with scout:fetch) |

#### Reliability Sub-Criteria

Reliability is evaluated along five dimensions (internal checklist, not separate pass/fail criteria):

| Dimension | What to check |
|---|---|
| **Provenance** | Source tier: primary (official docs, peer-reviewed papers, government sites) > secondary (expert blogs, reputable journalism) > tertiary (aggregator sites, forums, Wikipedia). Are primary sources present? |
| **Corroboration** | Do multiple independent sources agree? |
| **Recency** | Is the information fresh enough for the topic? (Critical for time-sensitive domains) |
| **Consistency** | Are there contradictions across sources? |
| **Perspective diversity** | Is the information from a single vendor/author, or are multiple viewpoints represented? (Especially important for comparison queries) |

**Tier scaling**: For Tier S, Reliability reduces to "did we reach the target page / official source?" For Tier M/L, evaluate all five dimensions.

**Primary-source check**: If the collected sources lack primary sources for key claims, flag this in the Reliability assessment. This becomes a trigger for Re-search.

#### Novelty Check (Re-search decision aid)

Before triggering Re-search, estimate whether additional searching will yield new information:

- Are there unexplored source types (e.g., searched blogs but not issue trackers)?
- Did the last search cycle produce genuinely new claims, or just restatements?
- Would new queries use significantly different vocabulary?

```
Re-search decision:
  IF criteria unmet AND novelty estimate is positive → Re-search
  IF criteria unmet AND novelty estimate is low → Finalize with uncertainty disclosure
```

#### Failure Mode Handling

| Failure mode | Action |
|---|---|
| **Zero results** | Reformulate query (generalize terms, try alternate spelling/transliteration). If still zero, report failure honestly |
| **All low-quality** | Switch tool (e.g., Exa → WebSearch) and target primary source domains specifically |
| **Contradictory results** | Present the contradiction explicitly with source attribution. Note which sources are primary vs. secondary |
| **Primary-source gap** | Re-search with primary-source-targeted queries (site: operators, official domain targeting) using refined vocabulary from current results |
| **Information saturation** | Novelty is low but criteria still unmet → Finalize with uncertainty disclosure. "Additional searching did not yield new authoritative sources" |

**If any criterion is unmet and novelty is positive → Re-search (max 2 queries per cycle, cycles per tier as defined in Budget Allocation table — Tier S: 0, Tier M: max 1, Tier L: max 2)**:

1. Identify which criteria are unmet and what's missing
2. Design additional queries using new vocabulary/concepts from existing results (apply the differentiation rule from Hard Constraints)
3. **If primary-source gap was flagged**: Prioritize primary-source-targeted queries in this cycle
4. Execute additional queries
5. Re-assess after each cycle

Re-search cycles per tier are defined in the Budget Allocation table (Step 3a). Absolute ceiling: Tier L main (8) + Re-search (2 cycles × 2 queries = 4) + Pre-Research (1) = 13 queries.

### Step 6: Synthesize (Answer Generation)

Generate the answer based on collected sources.

**Source weighting in synthesis**:
- Primary sources form the backbone of the answer
- Secondary sources provide supplementary context and explanation
- Tertiary sources are cited only when no better source exists, with appropriate caveats

**Uncertainty disclosure**: When the answer relies on secondary/tertiary sources for key claims, note this:
- "This is based on [source type] — official documentation should be consulted for authoritative confirmation"
- "Sources disagree on [point] — [Source A] states X while [Source B] states Y"

## Search Tools

Query design (Steps 1-3) and search tools are independent. Tool failures do not change query design. If a tool is unavailable, fall back to another.

### Tool Selection Table

| Purpose | Recommended | Fallback | Reason |
|---|---|---|---|
| **Library/framework official docs** | **Context7** (via Step 2.5 Route) | WebSearch | Direct access to indexed official docs; avoids secondary-source bias |
| Concept/meaning search (hit even without keyword match) | Exa | WebSearch | Semantic search; returns page content inline |
| Code examples, API usage | Context7 (via Step 2.5) / Exa (`get_code_context_exa`) | WebSearch | Context7 for official examples; Exa for community examples |
| Find a specific page/URL | WebSearch | — | Strong at URL/title identification |
| Broad, comprehensive collection | WebSearch (multiple queries) | — | Returns many sources |
| Speed-priority / quick check | WebSearch | — | Instant results |
| Find an official site/homepage | WebSearch | — | Best for navigational search |
| A vs B comparison | WebSearch (multiple queries) | — | Needs cross-referencing multiple sources |

### WebSearch

Claude Code's built-in tool. Keyword-match search.

**Limitation**: Search result citation text is **truncated to 125 characters max**. Judge content by title and snippet only. For details, fetch source articles following the scout:fetch workflow.

### Context7 MCP

Official documentation search for libraries and frameworks. Retrieves current, indexed docs directly — no web search noise.

**Two-step flow** (always in this order):
1. `resolve-library-id` — Resolve library name to Context7 ID (e.g., `"Next.js"` → `/vercel/next.js`)
2. `query-docs` — Query documentation with the resolved library ID

**Parameters**:
- `resolve-library-id`: `libraryName` (official name with proper punctuation) + `query` (specific question — used to rank results by relevance)
- `query-docs`: `libraryId` (from step 1) + `query` (specific question)

**Strengths**:
- Direct access to official, up-to-date documentation — no secondary-source bias
- Returns code snippets and structured content
- No API key required (free, npx-based)

**Limitations**:
- Only covers indexed libraries/frameworks (not all projects are indexed)
- Max 3 calls per tool per question (Context7 API constraint). Typical flow: resolve(1) + query(1) = 2 calls total
- Not suitable for non-library technical topics (infrastructure, OS, networking)

**Fallback conditions** (any triggers fallback to Step 3 — tool selection follows Domain-Aware Tool Selection in Step 3b):
- Context7 MCP not connected
- `resolve-library-id` returns no results or only ambiguous matches
- `query-docs` returns insufficient content (low snippet count or irrelevant results)
- Context7 times out

**Usage in scout**: Context7 is used in Source-Type Routing (Step 2.5), not as a main search query. It does not consume search budget.

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

**Exa's known bias**: HyDE tends to surface secondary sources (blog posts, explanatory articles) over primary sources (official docs, specs). This is a feature for concept understanding but a liability when authoritative answers are needed. Mitigate by using WebSearch for primary-source-targeted queries.

**Usage**: Use `exa-free` tools by default (free). Use `exa` tools only when: (a) `exa-free` returned insufficient results, (b) company or people-specific research is needed, or (c) the user explicitly requests deep multi-step research. When `exa-free` rate limit is reached, fall back to WebSearch.

### URL Content Retrieval (Auxiliary)

For deep-diving into source articles from search results. Retrieves URL content. Not a search tool — used to follow up on search results.
Tool selection follows the **scout:fetch workflow** (privacy classification → tool selection → fallback). If the scout:fetch skill is not available, use WebFetch or Jina Reader directly for public URLs.

## Domain Classification Table

Classify the query's domain to guide tool selection and search strategy.

| Domain | Characteristics | Primary source types | Tool emphasis |
|---|---|---|---|
| **Technical** (library/framework) | Library/framework with indexed docs, API/config queries | Official docs via Context7, GitHub repos | Context7 (Step 2.5) → WebSearch + Exa (Step 3b if needed) |
| **Technical** (non-library) | Infra, OS, networking, version-dependent specs | Official docs, release notes, changelogs, CVE/NVD | WebSearch-primary |
| **Empirical** | Academic research, statistical data, effect sizes, experimental results | Peer-reviewed papers, systematic reviews, meta-analyses | Exa-primary |
| **Conceptual** | Theoretical frameworks, philosophical debates, design patterns | Foundational texts, survey papers, expert analyses | Balanced |
| **Regulatory** | Laws, regulations, compliance, policy, government actions | Official gazettes, regulatory bodies, legislative text | WebSearch-leaning |

**Default**: When uncertain, treat as Conceptual (balanced approach).

**Re-classification**: Domain classification may change after Pre-Research. If it does, adjust tool allocation accordingly before proceeding to Main Search.

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
--- Phase A: Pre-Research ---
0. Pre-Research: [lang] [query] → [tool]

--- Route (if applicable) ---
R. Source-Type Routing: [source] → [result: full / partial / miss]
   (If full → skip to Phase C. If partial/miss → continue to Phase B)

--- Phase B: Analysis & Plan ---
0a. Abstraction: [one-sentence essence]
0b. Keywords: [query vocabulary derived from abstraction]
1. Intent: [target / practice / general / navigational / comparison]
2. Domain: [technical / empirical / conceptual / regulatory]
3. Budget: Tier [S/M/L] ([N] queries)
4. Tool allocation: WebSearch [N]% / Exa [N]%
5. Primary language: [Language Selection Table result]
6. Query 1: [lang] [query] → [WebSearch / Exa] [primary-source-targeted? Y/N]
7. Query 2: [lang] [query or HyDE text] → [tool] (optional)
8. Query 3+: ... (as budget allows)
9. Counter-Query: [lang] [query] → [tool] (only if comparison/high-risk)
10. Freshness constraint: [year/date filter if applicable]

--- Phase C: Evaluation ---
11. Assess: [Sufficiency ✓/✗] [Reliability ✓/✗] [Specificity ✓/✗]
12. Primary sources found: [N] / [total sources]
13. Novelty estimate: [high/medium/low]
14. Re-search 1: [lang] [query] → [tool] (reason: [unmet criterion]) (only if ✗ and novelty > low)
15. Re-search 2: [lang] [query] → [tool] (optional)
```

If Pre-Research results change the initial intent/domain classification or query composition, **redesign from Step 3 based on the updated understanding**.

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
- Each query must be differentiated by language, intent axis, or tool (no redundant query repetition). This applies to both Main Search and Re-search
- For time-sensitive topics, append the current year to queries to prioritize recent results
- Never send confidential URLs to `crawling_exa` — use scout:fetch for URL content retrieval instead
- If all available tools fail during both Execute and Re-search, report the failure to the user with the specific errors encountered. Do not fabricate results from prior knowledge
- **Primary sources are the goal, not the starting point**: Do not force primary-source-only collection in Pre-Research. Allow concept understanding from any source type, then use refined queries to reach primary sources in Main Search and Re-search
- **Context7 two-step flow is mandatory**: Always call `resolve-library-id` before `query-docs`. Never guess or hardcode library IDs. If resolve returns no results or low-quality matches, fall back to WebSearch — do not force Context7. If `query-docs` returns results but does not address the specific version or feature queried, supplement with WebSearch — do not rely solely on Context7 output. After a partial Context7 resolution, do not re-call Context7 in Step 3 — use WebSearch/Exa for the remaining gaps

## Examples

### Example 1: Technical Domain — Context7 Routing (Full Resolution)

**Input**: "How do I set up middleware in Next.js App Router?"

```
--- Route (if applicable) ---
R. Source-Type Routing: Context7 → resolve-library-id("Next.js") → /vercel/next.js
   Context7 → query-docs(/vercel/next.js, "middleware setup App Router")
   Result: full — official code examples and configuration returned

--- Phase A: Pre-Research ---
0. Pre-Research: (not needed — Route fully answered)

--- Phase B: Analysis & Plan ---
(skipped — Route fully answered, skip to Phase C)

--- Phase C ---
11. Assess: [Sufficiency ✓] [Reliability ✓] [Specificity ✓]
12. Primary sources: 1/1 (Next.js official docs via Context7)
13. Novelty estimate: n/a
```

**Key point**: Context7 resolved the library and returned official docs directly. Zero search budget consumed.

### Example 1b: Technical Domain — Context7 Miss + WebSearch Fallback

**Input**: "How to configure HAProxy health checks for a Kubernetes backend?"

```
--- Route (if applicable) ---
R. Source-Type Routing: Context7 → resolve-library-id("HAProxy") → no indexed library found → miss

--- Phase A: Pre-Research (after Route miss) ---
0. Pre-Research: en HAProxy health check Kubernetes → WebSearch

--- Phase B ---
0a. Abstraction: HAProxy reverse proxy with active/passive health checking against K8s service endpoints
0b. Keywords: HAProxy, health check, Kubernetes, backend, httpchk, option httpchk, server-template
1. Intent: practice
2. Domain: technical (non-library — infrastructure tool)
3. Budget: Tier M (3 queries)
4. Tool emphasis: WebSearch-primary
5. Primary language: en
6. Query 1: en HAProxy health check configuration Kubernetes backend 2026 → WebSearch [primary-source: Y]
7. Query 2: en HAProxy httpchk server-template dynamic DNS → WebSearch
8. Query 3: en HAProxy Kubernetes ingress health check best practices → Exa

--- Phase C ---
11. Assess: [Sufficiency ✓] [Reliability ✓] [Specificity ✓]
12. Primary sources: 2/5 (HAProxy official docs, Kubernetes docs)
13. Novelty estimate: n/a
```

**Key point**: Context7 didn't have HAProxy indexed (infrastructure tool, not a library). Fell back to WebSearch as primary for non-library technical domain.

### Example 2: Empirical Domain — Exa-Primary + Re-search with Novelty Check

**Input**: "What's the evidence for spaced repetition effectiveness in language learning?"

```
--- Phase A ---
0. Pre-Research: en spaced repetition language learning research → WebSearch

--- Phase B ---
0a. Abstraction: Spaced repetition (expanding interval review) is widely used in language learning. Meta-analyses show moderate-to-large effect sizes for vocabulary retention
0b. Keywords: spaced repetition, language learning, meta-analysis, effect size, vocabulary retention, Leitner, Anki
1. Intent: practice
2. Domain: empirical
3. Budget: Tier L (6 queries — academic research needs breadth)
4. Tool emphasis: Exa-primary (empirical domain)
5. Primary language: en
6. Query 1: en [HyDE] "Meta-analyses of spaced repetition in L2 vocabulary acquisition show effect sizes of 0.5-0.8, with expanding schedules outperforming fixed intervals for long-term retention." → Exa [primary-source: Y]
7. Query 2: en spaced repetition language learning meta-analysis systematic review 2024 2025 → WebSearch [primary-source: Y]
8. Query 3: en spaced repetition vs massed practice vocabulary retention effect size → Exa
9. Counter-Query: n/a (not comparison/high-risk)
10. Freshness: 2024-2025 preferred for meta-analyses

--- Phase C ---
11. Assess: [Sufficiency ✓] [Reliability ✗ — only 1 primary paper found, most results are blog summaries] [Specificity ✗ — need specific effect sizes]
12. Primary sources: 1/8
13. Novelty estimate: high (issue trackers / publisher databases unexplored)
14. Re-search 1: en site:scholar.google.com OR site:pubmed.ncbi.nlm.nih.gov spaced repetition vocabulary meta-analysis → WebSearch (reason: primary-source gap)
15. Re-search 2: en Nakata 2015 OR Ullman 2020 spaced repetition L2 acquisition → Exa (reason: specificity — need named studies)
```

**Key point**: Pre-Research with secondary sources (blogs) acquired the vocabulary ("L2 acquisition", "expanding schedules", "Leitner"). Refined queries then targeted primary sources (papers). Re-search was triggered by primary-source gap in Assess.

### Example 3: Comparison with Counter-Query + Freshness

**Input**: "Prisma vs Drizzle for TypeScript backend in 2026"

```
--- Phase A ---
0. Pre-Research: en Prisma Drizzle ORM TypeScript comparison → WebSearch

--- Phase B ---
0a. Abstraction: Two TypeScript ORMs. Prisma: schema-first, generated client, mature ecosystem. Drizzle: SQL-like, lightweight, type-safe, growing rapidly
0b. Keywords: Prisma, Drizzle, ORM, TypeScript, performance, migration, type safety, bundle size, serverless
1. Intent: comparison
2. Domain: technical
3. Budget: Tier M (4 queries — comparison needs multiple perspectives)
4. Tool emphasis: WebSearch-primary (technical domain)
5. Primary language: en
6. Query 1: en Prisma vs Drizzle TypeScript ORM comparison 2026 → WebSearch
7. Query 2: en Drizzle ORM production experience migration Prisma → Exa
8. Counter-Query: en Prisma drawbacks limitations 2025 2026 → WebSearch
9. Counter-Query: en Drizzle ORM problems issues production → WebSearch
10. Freshness: 2025-2026 required (rapid ecosystem changes)

--- Phase C ---
11. Assess: [Sufficiency ✓] [Reliability ✓] [Specificity ✓]
12. Primary sources: 3/10 (Prisma docs, Drizzle docs, GitHub benchmarks)
13. Novelty estimate: n/a
```

**Key point**: Counter-queries ("drawbacks", "problems") are automatically added for comparison intent. Both sides get counter-queries to avoid one-sided evaluation. Freshness constraint ensures 2025-2026 results for rapidly evolving ecosystem.

## Changelog

- **v2.1** (2026-04-08): Context7 MCP integration for Technical domain. Addresses Round 2 ROI -9 on library/framework docs. Changes: Context7 added to Source-Type Routing (Step 2.5), Domain-Aware Tool Selection split Technical into library vs non-library, Context7 tool documentation added, Example 1 updated with Context7 routing flow
- **v2.0** (2026-04-06): Major redesign based on 3-model cross-model discussion (3 rounds) + effectiveness evaluation data (4-domain cross-validation). Key changes:
  - Added Step 0.5 Clarify (conditional clarification for ambiguous queries)
  - Added Step 2.5 Route (Source-Type Routing for direct lookup)
  - Added Domain Classification (technical/empirical/conceptual/regulatory) with domain-aware tool selection
  - Added Budget Tiers (S/M/L) replacing fixed 6-query limit
  - Expanded Assess with Reliability sub-criteria (Provenance, Corroboration, Recency, Consistency, Perspective diversity)
  - Added Novelty Check as Re-search decision aid
  - Added Failure Mode Handling (zero results, all low-quality, contradictions, primary-source gap, information saturation)
  - Added Freshness constraints for time-sensitive topics
  - Added Counter-Query for comparison and high-risk queries
  - Expanded Re-search to max 2 cycles (intent-dependent) from 1 cycle
  - Added uncertainty disclosure guidance in synthesis
  - Documented Exa's secondary-source bias with mitigation strategy
  - Design principle: "Primary sources are the goal, not the starting point"
- **v1.0** (2026-03-23): Initial release
