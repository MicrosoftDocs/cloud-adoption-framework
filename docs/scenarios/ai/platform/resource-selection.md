---
title: Select Azure Platform as a Service (PaaS) Solutions for AI
description: Learn how to select the right Azure AI services, compute, and tools to build effective generative and nongenerative AI workloads.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/17/2025
ms.topic: concept-article
---

# Select Azure PaaS solutions for AI

This article explains how to select resources for Azure AI platform as a service (PaaS) solutions. The following table summarizes the main Azure AI PaaS solutions and key decision criteria.

| AI services | AI type | Description | Skills required |
|---------|------------|---------| --- |
| [Microsoft Foundry](/azure/ai-foundry/what-is-azure-ai-foundry) | Generative AI and nongenerative AI | A platform for building and deploying generative and nongenerative AI applications | Developer and data science skills |
| [Azure AI services](/azure/ai-services/what-are-ai-services) | Generative AI and nongenerative AI | Various services that provide prebuilt generative and nongenerative AI models | Developer skills |
| [Azure OpenAI](/azure/ai-foundry/openai/concepts/models) | Generative AI | A service for accessing OpenAI models | Developer and data science skills |
| [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) | Machine learning | A service for training and deploying machine learning models | Developer skills and advanced data science skills |

## Select resources for generative AI workloads

Generative AI uses multiple resources to process input data and produce meaningful outputs. To build effective applications, such as those that use [retrieval-augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide), select resources that ground AI models and deliver accurate results.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram that shows the basic components of a generative AI workload." lightbox="../images/generative-ai-app.svg" border="false":::

### Generative AI workflow

The following workflow matches the diagram above:

1. The AI app receives a user query.
2. An orchestrator, such as Foundry Agent Service or the [Microsoft Agent Framework](https://devblogs.microsoft.com/foundry/introducing-microsoft-agent-framework-the-open-source-engine-for-agentic-ai-apps/), manages data flow.
3. A search and retrieval mechanism finds the grounding data.
4. The mechanism sends the grounding data to a generative AI platform.
5. The generative AI platform creates a response using the user query and grounding data.

### Generative AI resource selection

Follow these steps to build generative RAG workloads:

1. **Select a generative AI platform.** Use Foundry or Azure OpenAI to deploy and manage generative AI models. Foundry offers a code-first platform with built-in tools for development, deployment, and orchestration. Choose Azure OpenAI if you only need access to [OpenAI models](/azure/ai-services/openai/concepts/models).

2. **Select an AI compute type.** Foundry requires [compute instances](/azure/ai-studio/how-to/create-manage-compute) for specific features. Pick a compute type that fits your performance and budget needs.

3. **Select an orchestrator.** Use orchestrators like [Foundry Agent Service](/azure/ai-foundry/agents/overview) or [Microsoft Agent Framework](https://devblogs.microsoft.com/foundry/introducing-microsoft-agent-framework-the-open-source-engine-for-agentic-ai-apps/) to manage data flow and interactions. If your workload uses multiple agents, make sure your orchestrator supports the [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) you need.

4. **Select a search and knowledge retrieval mechanism.** To ground generative AI models, create an index or vector database for relevant data. Use Azure AI Search to build traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), apply [data chunking](/azure/search/vector-search-integrated-vectorization), and use [multiple query types](/azure/search/search-query-overview#types-of-queries). For structured databases, consider [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-use-pgvector), or [Azure Managed Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

5. **Select a data source for grounding data.** Store grounding data in Azure Blob Storage for images, audio, video, or large datasets. You can also use databases supported by [AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

6. **Select a compute platform.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to choose the right platform for your workload.

## Select resources for nongenerative AI workloads

Nongenerative AI workloads use platforms, compute resources, data sources, and data processing tools to support machine learning tasks. Select resources that help you build AI workloads with prebuilt or custom solutions.

:::image type="content" source="../images/non-generative-ai-app.svg" alt-text="Diagram that shows the basic components of a nongenerative AI workload." lightbox="../images/non-generative-ai-app.svg" border="false":::

### Nongenerative AI workflow

The following workflow matches the diagram above:

1. The AI app ingests incoming data.
2. An optional data processing mechanism extracts or transforms the data.
3. An AI model endpoint analyzes the data.
4. You can use the data for training or fine-tuning AI models.

### Nongenerative AI resource selection

Follow these steps to build nongenerative AI workloads:

1. **Select a nongenerative AI platform.** Use AI services or Machine Learning based on your needs. AI services offer prebuilt models that simplify deployment and reduce the need for advanced data science skills. Machine Learning lets you develop custom models with your data and integrate them into your workloads.

2. **Select an AI compute type.** Machine Learning requires [compute resources](/azure/machine-learning/concept-azure-machine-learning-v2) to run jobs or host endpoints. Pick a compute type that fits your performance and budget needs. AI services do not require compute resources.

3. **Select a data source.** Use supported [data sources](/azure/machine-learning/how-to-datastore) to host training data for Machine Learning. Many AI services do not require fine-tuning data. Some AI services, such as Azure AI Custom Vision, let you upload local files to managed storage.

4. **Select a compute platform.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to choose the right platform for your workload.

5. **Select a data processing service (optional).** Use Azure Functions to process serverless data. Use Azure Event Grid to trigger data processing pipelines.

## Next steps

> [!div class="nextstepaction"]
> [Learn about Azure networking options](../platform/networking.md)