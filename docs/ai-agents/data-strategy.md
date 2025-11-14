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

A data strategy for AI agents establishes how your organization manages, prepares, and secures data to enable autonomous reasoning and decision-making. AI agents use language models to reason over data, extracting insights and making decisions that directly impact business operations. This article helps you build a foundation that balances agent autonomy with data security while optimizing data preparation for efficient retrieval.

:::image type="content" source="./images/ai-agent-adoption.png" alt-text="Diagram that shows the process outlined in this guidance: plan, govern, build and secure, integrate, and measure agents across your organization." lightbox="./images/ai-agent-adoption.png" border="false":::

## Establish unified data foundation

Before implementing agent-specific data strategies, establish a unified data platform that serves as your authoritative data source. Microsoft Fabric provides comprehensive capabilities to consolidate disparate data sources into golden datasets through mirrored data from your OLTP databases. This data lake architecture creates consistent, high-quality data that agents can reliably access while Microsoft Purview maintains governance, metadata management, and lineage tracking.

## Optimize data for agent retrieval

Agent effectiveness depends on quickly finding relevant information from vast data repositories. Poor data organization leads to increased latency, higher costs, and reduced accuracy. Azure AI Search provides specialized index creation and vector search capabilities that organizations must prepare for, while Azure AI Foundry Agent Service orchestrates the retrieval process.

### Structure data for efficient chunking

Transform documents and datasets into formats that optimize both retrieval speed and reasoning accuracy. Azure AI Search uses integrated chunking strategies when creating indexes that preserve context while enabling precise retrieval.

1. **Configure appropriate chunk sizes.** Set chunk sizes between 1024-2048 tokens to balance context preservation with retrieval precision. Smaller chunks improve precision but require more retrieval operations. Larger chunks provide more context but reduce retrieval accuracy. Use Azure AI Search's built-in chunking capabilities when creating indexes with page-based or fixed-size strategies. Test different configurations using your actual data to determine optimal settings. See [chunking configuration](https://learn.microsoft.com/azure/search/vector-search-how-to-chunk-documents) for implementation details.

2. **Implement overlapping chunks.** Configure 10-20% overlap between consecutive chunks to maintain context across boundaries. This overlap ensures agents don't lose critical information split between chunks. Use Azure AI Search's overlap settings when building indexes to preserve continuity. Store overlap metadata to help agents understand chunk relationships. Track chunk boundaries in your indexing pipeline.

3. **Preserve document structure.** Maintain hierarchical relationships between chunks, sections, and parent documents. Azure AI Foundry Agent Service uses this structure to navigate from summary to detail efficiently. Include parent document ID, section hierarchy, and sequential position in chunk metadata. Use [complex types](https://learn.microsoft.com/azure/search/search-howto-complex-data-types) to represent nested structures in your Azure AI Search indexes. Configure parent-child relationships in your index schema.

### Prepare data for vector and hybrid search

Azure AI Search combines vector similarity with keyword search to provide comprehensive retrieval capabilities that Azure AI Foundry Agent Service leverages. Prepare your data from Microsoft Fabric to support both search methods effectively.

1. **Generate high-quality embeddings.** Create vector representations of your content using appropriate embedding models. Choose models that understand your domain-specific terminology and context. Use Azure OpenAI's text-embedding-3-large model for general content when creating vectors in Azure AI Search. Deploy [custom embedding models](https://learn.microsoft.com/azure/ai-services/openai/how-to/embeddings) for specialized domains. Normalize embeddings to improve similarity calculations.

2. **Optimize for hybrid search.** Prepare content that performs well in both vector and keyword search scenarios within Azure AI Search indexes. Maintain original text alongside vector embeddings. Configure appropriate analyzers for keyword search based on content language and domain. Use Azure AI Search's [hybrid search capabilities](https://learn.microsoft.com/azure/search/hybrid-search-how-to-query) to combine vector and keyword results. Set RRF (Reciprocal Rank Fusion) parameters to balance search methods.

3. **Add semantic ranking metadata.** Include fields that support Azure AI Search's semantic ranking capabilities. These fields help Azure AI Foundry Agent Service identify the most relevant content within retrieved results. Configure title, content, and keyword fields for semantic ranking in your indexes. Use [semantic configuration](https://learn.microsoft.com/azure/search/semantic-how-to-query-request) to specify priority fields. Test different field combinations to optimize ranking quality.

### Enable agentic reasoning capabilities

Prepare your data to support the specific needs of Azure AI Foundry Agent Service, where agents reason over retrieved content from Azure AI Search to answer complex queries.

1. **Create reasoning-friendly summaries.** Generate concise summaries that capture key facts, decisions, and relationships within documents stored in Microsoft Fabric. Azure AI Foundry Agent Service uses these summaries to quickly assess relevance before detailed analysis. Use Azure OpenAI to create extractive and abstractive summaries. Store summaries as separate searchable fields in Azure AI Search indexes. Include summary confidence scores to help agents evaluate reliability.

2. **Extract structured information.** Convert unstructured content from your OLTP databases and Microsoft Fabric into structured formats that Azure AI Foundry Agent Service can process efficiently. Tables, lists, and key-value pairs enable faster reasoning than narrative text. Use [Azure Document Intelligence](https://learn.microsoft.com/azure/ai-services/document-intelligence/overview) to extract tables and forms. Store structured data in dedicated index fields within Azure AI Search. Maintain links between structured extracts and source documents.

3. **Add task-specific annotations.** Annotate content with information relevant to common agent tasks in your domain. These annotations guide Azure AI Foundry Agent Service reasoning and reduce processing time. Identify frequently asked questions and pre-compute answers. Add decision criteria and business rules as searchable metadata in Azure AI Search. Create task templates that agents can use as reasoning frameworks.

4. **Track data lineage and versioning.** Maintain records of data sources, transformations, and versions using Microsoft Purview. Azure AI Foundry Agent Service uses this information to assess data reliability and currency. Use [Microsoft Purview](https://learn.microsoft.com/azure/purview/overview) for comprehensive data lineage tracking and metadata management. Implement version control for critical datasets in Microsoft Fabric. Store lineage metadata in searchable fields within Azure AI Search indexes.

## Next step

> [!div class="nextstepaction"]
> [Responsible AI](./responsible-ai.md)