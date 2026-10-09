---
title: Select Azure Platform as a Service (PaaS) Solutions for AI
description: Compare Microsoft Foundry, Foundry Tools, and Azure Machine Learning for generative and nongenerative AI workloads.
author: stephen-sumner
ms.author: ssumner
ms.date: 10/09/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Select Azure PaaS solutions for AI

This article explains how to select resources for Azure AI platform as a service (PaaS) solutions.

## Select resources for generative AI workloads

Generative AI uses multiple resources to process input data and produce meaningful outputs. To build effective applications, such as those that use [retrieval-augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide), select resources that ground AI models and deliver accurate results.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram that shows the basic components of a generative AI workload." lightbox="../images/generative-ai-app.svg" border="false":::

Here's a general generative AI workflow:

1. Receive the user request. The AI app or agent receives a user query or prompt.
2. Orchestrate the request. The orchestration layer coordinates retrieval and model invocation for the AI app or agent.
3. Retrieve relevant content. When grounding is required, the orchestration layer uses a search and retrieval mechanism to retrieve relevant content from an index or vector database.
4. Use grounding data. The index or vector database contains or indexes grounding data from sources such as Azure Storage, Azure SQL Database, or Azure Cosmos DB.
5. Generate and return the response. The orchestration layer combines the user request with any retrieved content and sends the request to the generative AI endpoint. The model generates a response that returns to the AI app or agent.

### Generative AI resource selection

Use Microsoft Foundry to build and manage generative AI applications and agents. Foundry provides models, agents, tools, evaluation, observability, and management capabilities.

1. **Select a model and deployment approach.** Choose a model that meets your functional, quality, compliance, and cost requirements. See [Deployment option](/azure/foundry/concepts/deployments-overview) and [Deployment type](/azure/foundry/foundry-models/concepts/deployment-types).

2. **Select an orchestrator.** Determine how your application or agent coordinates model requests, retrieval, tools, state, and application logic. Use [Foundry Agent Service](/azure/ai-foundry/agents/overview) when you need managed agent hosting and lifecycle capabilities. Use [Microsoft Agent Framework](/agent-framework/overview/agent-framework-overview) when your application owns the agent or workflow logic.

3. **Select a search and knowledge retrieval mechanism.** Use Azure AI Search when you need a managed search index across one or more content sources. Consider a database with vector capabilities when embeddings must remain with operational data. Use the [Azure vector search decision guidance](/azure/architecture/guide/technology-choices/vector-search) to compare supported services by latency, scale, update frequency, and integration requirements.

4. **Select a data source for grounding data.** Store grounding data in Azure Blob Storage for images, audio, video, or large datasets. You can also use databases supported by [Azure AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

5. **Select application hosting.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to select a compute service for your application and supporting components.

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

1. **Select a nongenerative AI platform.** Use Foundry Tools or Machine Learning based on your needs. Foundry Tools offer prebuilt models that simplify deployment and reduce the need for advanced data science skills. Machine Learning lets you develop custom models with your data and integrate them into your workloads.

2. **Select training and inference compute.** Azure Machine Learning uses [compute resources](/azure/machine-learning/concept-azure-machine-learning-v2) to run training jobs and deploy models. Select compute based on workload performance, scaling, and cost requirements. Most prebuilt Foundry Tools expose managed APIs, so you don't provision model-hosting compute for the service.

3. **Select a data source.** For Azure Machine Learning, select a supported [data sources](/azure/machine-learning/how-to-datastore) for training and validation data. For customizable Foundry Tools, review the selected tool's data, storage, and residency requirements.

4. **Select application hosting.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to select a compute service for your application and supporting components.

5. **Select a data processing approach (optional).** Determine whether the workload requires data transformation, event-driven processing, or other preprocessing before invoking the AI model. Select an Azure data processing service that meets the workload's processing requirements.

## Next steps

> [!div class="nextstepaction"]
> [Learn about Azure networking options](../../scenarios/ai/platform/networking.md)