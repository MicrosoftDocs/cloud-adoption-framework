---
title: Data strategy for AI agents
ms.reviewer: ssumner
description: Learn how to develop a comprehensive data strategy that enables AI agents to deliver business value through effective data management, preparation, and security.
author: stephen-sumner
ms.author: pnp
ms.date: 11/14/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Data strategy for AI agents

Organizations need a clear data strategy to enable AI agents to deliver accurate, secure, and compliant outcomes. This strategy ensures that enterprise SaaS agents such as Microsoft 365 Copilot have governed access to productivity content, and that teams building custom AI agents can work with high-quality, well-prepared data. Without this foundation, AI adoption introduces unnecessary risk, inefficiency, and cost.

This guidance focuses on two priorities:

1. Preparing enterprise data for SaaS-based productivity agents like Microsoft 365 Copilot.
2. Preparing enterprise data for custom AI agent retrieval.

## Prepare data for Microsoft 365 Copilot and SaaS agents

Productivity agents such as Microsoft 365 Copilot depend on access to organizational content stored in OneDrive, SharePoint, Exchange, and other Microsoft 365 sources. These agents use Microsoft Graph to retrieve documents, emails, and collaboration artifacts while respecting existing permissions. See [Microsoft 365 Copilot privacy, data, and security](/microsoft-365-copilot/microsoft-365-copilot-privacy) and [Microsoft Graph overview](/graph/overview). To ensure secure and effective access, organizations must balance availability with least-privileged access principles. See [Least privilege guidance](/entra/identity/role-based-access-control/best-practices#1-apply-principle-of-least-privilege).

1. **Unify content under governed access.** Use Microsoft Graph APIs to integrate OneDrive, SharePoint, and other Microsoft 365 sources. See [OneDrive and SharePoint in Microsoft Graph](/onedrive/developer/rest-api/?view=odsp-graph-online). Consolidated access surfaces relevant content while enforcing existing access boundaries. Avoid fragmented permission models that create blind spots or expose sensitive data.

1. **Enforce least-privileged access.** Review and update access controls across Microsoft 365 repositories. Confirm users and agents only access data they are authorized to view. Use Microsoft Purview [sensitivity labels](/purview/sensitivity-labels) and [Purview DLP](/purview/dlp-learn-about-dlp) to reduce oversharing and apply consistent protection.

1. **Maintain metadata and traceable governance.** Apply metadata enrichment to productivity content (owners, timestamps, sensitivity classification). Use Microsoft Purview to capture lineage for supported data systems and audit access events where logging applies. See [Purview lineage overview](/purview/data-gov-classic-lineage) and [Purview audit solutions](/purview/audit-solutions-overview). Avoid implying universal coverage—traceability depends on service integration and enabled logging.

1. **Optimize search and indexing.** Confirm semantic capabilities and Microsoft 365 Copilot Search or semantic index are enabled. See [Semantic indexing for Microsoft 365 Copilot](/microsoftsearch/semantic-index-for-copilot) and configure Microsoft 365 Copilot connectors (formerly Graph connectors) for external sources (see [Copilot connectors overview](/microsoft-365-copilot/extensibility/overview-copilot-connector)). This improves natural language retrieval relevance without custom indexing infrastructure.

Without these measures, productivity agents risk exposing sensitive information or returning incomplete results. A governed approach improves predictable performance, reduces exposure, and supports compliance across collaboration tools.

## Prepare data for custom AI agent retrieval

Custom AI agents require structured, high-quality data to reason effectively. Fragmented or poorly indexed data increases latency, reduces accuracy, and complicates governance. Preparing data for agentic retrieval minimizes these risks and accelerates development.

### Establish a unified data foundation

Create a centralized analytics platform as the authoritative source for structured business data. Use Microsoft Fabric mirroring and curated semantic models (rather than “golden datasets”) to consolidate operational sources into governed analytical representations. See [Fabric mirroring overview](/fabric/mirroring/overview). Mirroring replicates supported OLTP sources into OneLake in an analytics-ready open Delta format, enabling consistent downstream use (BI, data science, and AI) while simplifying governance.

### Prepare data for agentic retrieval

Agentic retrieval enables AI agents to locate and interpret relevant data efficiently using natural language and hybrid search (semantic, vector, lexical). See [Agentic retrieval index design](/azure/search/agentic-retrieval-how-to-create-index). Preparing data involves several steps:

1. **Assess readiness of existing data assets.** Evaluate whether current datasets meet retrieval workloads. Confirm required indexes exist and semantic or hybrid configurations are active where natural language relevance is needed. See [Semantic index](/microsoftsearch/semantic-index-for-copilot). Identify gaps (missing indexes, inconsistent schemas) and prioritize remediation.

1. **Plan metadata enrichment and traceability.** Add identifiers (document names, section markers, source references), ownership, timestamps, and sensitivity labels (see [Sensitivity labels](/purview/sensitivity-labels)). This supports transparent relevance scoring, compliance, and selective access.

1. **Include enhancements for performance and relevance.** Consider [synonym maps](/azure/search/search-synonyms) and [scoring profiles](/azure/search/index-add-scoring-profiles) to boost critical fields. These improvements add maintenance overhead—balance benefit versus lifecycle cost.

1. **Structure data for efficient retrieval and reasoning.** Segment large documents into smaller, context-preserving chunks. See [chunking guidance](/azure/search/vector-search-how-to-chunk-documents). Chunking helps stay within embedding model token limits and improves retrieval precision when properly tuned; benefits depend on content structure and query patterns.

1. **Define chunk size and overlap strategies.** Start with evidence-based defaults (for example ~512 tokens with moderate overlap per Azure guidance) and iterate using real usage metrics. See [chunking examples](/azure/search/vector-search-how-to-chunk-documents#chunking-examples). Optimize for relevance first, then evaluate latency and cost impacts.

1. **Preserve relationships within data.** Maintain hierarchical links between chunks and parent documents (section → paragraph → chunk) to enable reconstruction of broader context. See [Advanced RAG ingestion considerations](/azure/developer/ai/advanced-retrieval-augmented-generation#ingestion).

1. **Integrate embeddings consistently.** Use the same embedding model for indexing and querying. See [Generate embeddings](/azure/search/vector-search-how-to-generate-embeddings) and [Integrated vectorization](/azure/search/vector-search-integrated-vectorization). Normalize or compress vectors when appropriate to control storage and improve similarity performance.

A unified foundation and structured preparation reduce complexity, improve relevance, and support governance. These steps allow teams to build agents that deliver accurate, auditable, and cost-efficient outcomes.

### Trade-offs and considerations

- **Effort vs. accuracy:** Metadata enrichment, synonym maps, and chunk strategy tuning improve retrieval quality and grounding reliability but increase maintenance.

- **Security vs. accessibility:** Least privilege and regular access reviews (see [Access reviews](/entra/id-governance/deploy-access-reviews)) reduce risk but require ongoing process maturity. Automating labeling and policy enforcement (see [Auto-labeling](/purview/apply-sensitivity-label-automatically)) lowers manual overhead.

- **Performance vs. flexibility:** Advanced relevance features (semantic ranking, scoring profiles, hybrid vector + lexical queries) raise computational cost. Apply selectively to critical content domains; monitor usage and adjust.

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)