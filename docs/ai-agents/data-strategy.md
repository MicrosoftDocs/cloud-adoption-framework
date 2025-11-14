---
title: Data strategy for AI agents
description: Learn how to develop a comprehensive data strategy that enables AI agents to deliver business value through effective data management, preparation, and security.
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Data strategy for AI agents

A data strategy for AI agents establishes how your organization manages, prepares, and secures data to enable autonomous reasoning and decision-making. Since agents actively reason over retrieved information to generate insights and take actions, your data strategy must address unique requirements beyond traditional data management. This article helps you build a foundation that supports agent reasoning, maintains security boundaries, and scales across your organization.

:::image type="content" source="./images/ai-agent-adoption.png" alt-text="Diagram that shows the process outlined in this guidance: plan, govern, build and secure, integrate, and measure agents across your organization." lightbox="./images/ai-agent-adoption.png" border="false":::

## Prepare data for agent reasoning

AI agents differ from traditional applications because they reason over data to make autonomous decisions. Without properly structured data, agents produce inconsistent results, miss critical connections, and fail to provide accurate insights. Your data preparation must support three core agent capabilities: retrieval accuracy, reasoning quality, and contextual understanding.

### Structure data for retrieval and reasoning

Transform your data to optimize how agents find and interpret information. Unstructured or poorly organized data causes agents to retrieve irrelevant information, leading to incorrect conclusions and reduced trust in agent outputs.

1. **Create semantic relationships.** Add metadata that explains connections between documents, entities, and concepts. When an agent retrieves customer purchase history, it needs links to product specifications, support tickets, and warranty information to provide complete recommendations.Tools like Microsoft Purview can help you discover and classify data relationships across your estate using [metadata attributes](https://learn.microsoft.com/purview/unified-catalog-custom-metadata).

2. **Build knowledge graphs.** Implement graph databases or knowledge structures that map relationships explicitly. These structures help agents traverse connected information and understand complex dependencies across your data estate. Start by modeling your core business entities and their relationships, then expand the graph as agents require more context. Use [Graph in Microsoft Fabric](https://learn.microsoft.com/fabric/graph/overview)

3. **Optimize chunking strategies.** Break large documents into semantically meaningful segments that preserve context. Poor chunking causes agents to miss critical information or misinterpret partial data. Use overlapping chunks of 512-1024 tokens with 10-20% overlap to maintain context across boundaries. Azure AI Search (Foundry IQ) provides built-in chunking capabilities that preserve document structure. Test different chunking sizes and overlap strategies to balance retrieval precision with reasoning completeness. See the different [chunking approaches](https://learn.microsoft.com/azure/search/vector-search-how-to-chunk-documents) in Foundry IQ (formerly Azure AI Search).

### Enhance data with context and grounding

Raw data often lacks the context agents need for accurate reasoning. Without proper grounding, agents hallucinate information or make incorrect assumptions about your business domain. Augment your data to reduce hallucinations and improve decision quality.

1. **Add temporal context.** Include timestamps, version histories, and validity periods with your data. Agents need this information to distinguish current policies from outdated ones or to understand seasonal patterns in business metrics. Implement slowly changing dimensions in your data warehouse. Use Data Factory to automate temporal data enrichment during ingestion.

2. **Provide domain grounding.** Create reference datasets that establish authoritative sources for key concepts, definitions, and business rules. These grounding documents prevent agents from making incorrect inferences about specialized terminology or processes. Store grounding documents in OneLake in Microsoft Fabric with proper versioning and access controls. For scenarios requiring broader storage options, use Azure Data Lake Storage Gen2. Use Azure OpenAI's system messages to inject this context into agent prompts.

3. **Include negative examples.** Document what agents should not do or conclude. Explicit negative examples help agents avoid common mistakes and understand boundaries in their reasoning. Create a library of edge cases and failure scenarios from production incidents. Store these examples in your vector database alongside positive examples to provide balanced training data.

## Secure data for autonomous operations

When agents operate autonomously, security becomes more complex. A single compromised agent can access vast amounts of data before detection. Traditional security models assume human oversight that doesn't exist with autonomous agents. Your strategy must protect data while enabling legitimate agent operations.

### Implement dynamic access controls

Static permissions fail when agents need different data access based on context and user authority. Without dynamic controls, you either over-provision access (creating security risks) or under-provision (limiting agent effectiveness).

1. **Use attribute-based access control (ABAC).** Define policies that evaluate multiple attributes including user role, data sensitivity, request context, and agent purpose. An agent helping HR might access salary data when processing payroll but not when answering general policy questions. Azure Active Directory provides ABAC capabilities that integrate with Azure services. Create policies using combinations of user attributes, resource tags, and environment conditions. [Implement ABAC in Azure](https://learn.microsoft.com/azure/role-based-access-control/conditions-overview).

2. **Create data access proxies.** Build intermediary services that evaluate and filter data before agents receive it. These proxies apply business rules, mask sensitive fields, and audit all access attempts. Use Azure API Management to create a gateway that enforces data policies. Implement field-level encryption for sensitive data and only decrypt when specific conditions are met. [Build secure API gateways](https://learn.microsoft.com/azure/api-management/api-management-howto-protect-backend-with-aad).

3. **Establish data use agreements.** Define explicit contracts that specify how agents can use different data types. Include restrictions on data combination, retention limits, and prohibited operations. Implement these agreements as code using Azure Policy to enforce compliance automatically. Create custom policies that prevent agents from combining certain data types or exceeding retention periods. [Create custom Azure policies](https://learn.microsoft.com/azure/governance/policy/tutorials/create-custom-policy-definition).

### Create specialized data stores

Different agent types need different data organizations. Generic storage solutions force compromises that reduce agent effectiveness. Build purpose-specific stores that optimize for particular reasoning patterns.

1. **Vector databases for semantic search.** Store embeddings that enable agents to find conceptually similar information across diverse sources. Optimize index structures for the query patterns your agents use most frequently. Azure AI Search (Foundry IQ) provides vector search capabilities with multiple index types. Choose HNSW indexes for high recall requirements or IVF for faster queries with acceptable recall trade-offs. [Configure vector search indexes](https://learn.microsoft.com/azure/search/vector-search-how-to-create-index).

2. **Time-series stores for trend analysis.** Organize temporal data to support pattern recognition and forecasting. Include aggregations at multiple time scales to enable both detailed and high-level reasoning. Azure Data Explorer excels at time-series analysis with built-in functions for anomaly detection and forecasting. Pre-compute common aggregations to reduce query latency. [Optimize time-series queries](https://learn.microsoft.com/azure/data-explorer/time-series-analysis).

3. **Graph databases for relationship reasoning.** Structure interconnected data to support traversal queries and network analysis. Define clear relationship types that agents can interpret consistently. Use Azure Cosmos DB for Apache Gremlin to store and query graph data. Design your graph schema to minimize traversal depth for common agent queries. [Design efficient graph queries](https://learn.microsoft.com/azure/cosmos-db/gremlin/query-optimization).

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)