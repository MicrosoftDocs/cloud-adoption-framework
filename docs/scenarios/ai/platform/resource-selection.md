---
title: Select Azure platform services (PaaS) for AI
description: Organizations learn to select the right resources for Azure AI workloads with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 03/27/2025
ms.topic: conceptual
---

# Select Azure platform services (PaaS) for AI

This article offers resource selection recommendations for Azure AI platform-as-a-service (PaaS) solutions. The following table provides an overview of the primary Azure AI PaaS solutions and important decision criteria.

| AI services | AI type | Description | Skills required |
|---------|------------|---------| --- |
| [Azure AI Foundry](/azure/ai-foundry/what-is-azure-ai-foundry) | Generative AI & non-generative AI | A platform for building and deploying generative and non-generative AI applications | Developer and data science skills |
| [Azure AI services](/azure/ai-services/what-are-ai-services) | Generative AI & non-generative AI | Various services that provide prebuilt generative and non-generative AI models | Developer skills |
| [Azure OpenAI](/azure/ai-services/openai/) | Generative AI | A service for accessing OpenAI models | Developer and data science skills |
| [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) | Machine learning | A service for training and deploying machine learning models | Developer skills and advanced data science skills |

## Select resources for generative AI workloads

Generative AI combines various resources to process input data and generate meaningful outputs. Selecting the right resources ensures that applications, such as those using [retrieval augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide), deliver accurate results by grounding AI models effectively.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram showing the basic components of a generative AI workload." lightbox="../images/generative-ai-app.svg" border="false":::

In a typical RAG workload: (1) The workload receives a user query. (2) An orchestrator, such as Azure AI Foundry Agent Service, Semantic Kernel, or LangChain, manages the data flow. (3) A search and retrieval mechanism identifies the appropriate (4) grounding data to send to the generative AI endpoint. (5) A generative AI model endpoint generates a response based on the user query and grounding data. Use the following recommendations to build generative RAG workloads:

1. **Choose a generative AI platform.** Select Azure AI Foundry or Azure OpenAI to deploy and manage generative AI models. Azure AI Foundry provides a code-first platform with built-in tools for developing, deploying, and orchestrating applications. Use Azure OpenAI Service if you only need access to [OpenAI models](/azure/ai-services/openai/concepts/models).

1. **Choose the appropriate AI compute type.** Azure AI Foundry requires [compute instances](/azure/ai-studio/how-to/create-manage-compute) for certain capabilities. Select a compute type that meets your performance and budget needs.

1. **Pick an orchestrator.** Use popular orchestrators like [Azure AI Foundry Agent Service](/azure/ai-services/agents/overview), [Semantic Kernel](/semantic-kernel/overview/), or [LangChain](https://python.langchain.com/v0.2/docs/integrations/platforms/microsoft/) to manage data flow and interactions.

1. **Pick a search and knowledge retrieval mechanism.** Ground generative AI models by creating an index or vector database for relevant data retrieval. Use Azure AI Search to build traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), apply [data chunking](/azure/search/vector-search-integrated-vectorization), and use [multiple query types](/azure/search/search-query-overview#types-of-queries). For structured databases, consider [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-use-pgvector), or [Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

1. **Choose a data source for grounding data.** Store grounding data in Azure Blob Storage for images, audio, video, or large datasets. Alternatively, use databases supported by [Azure AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

1. **Pick a compute platform.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to select the right platform for your workload.

## Select resources for nongenerative AI workloads

Nongenerative AI workloads use platforms, compute resources, data sources, and data processing tools to support machine learning tasks. Selecting the right resources ensures you can build AI workloads using prebuilt or custom solutions effectively.

:::image type="content" source="../images/non-generative-ai-app.svg" alt-text="Diagram showing the basic components of a nongenerative AI workload." lightbox="../images/non-generative-ai-app.svg" border="false":::

In a nongenerative AI workload: (1) The workload ingests data. (2) An optional data processing mechanism extracts or manipulates incoming data. (3) An AI model endpoint analyzes the data. (4) Data supports training or fine-tuning of AI models. Use the following recommendations to build nongenerative AI workloads:

1. **Choose a nongenerative AI platform.** Select Azure AI services or Azure Machine Learning based on your requirements. Azure AI services provide prebuilt AI models that simplify deployment and reduce the need for deep data science expertise. Use Azure Machine Learning if you need a platform to develop custom machine learning models using your data and integrate those models into your workloads.

1. **Choose the appropriate AI compute type.** Azure Machine Learning requires [compute resources](/azure/machine-learning/concept-azure-machine-learning-v2) to run jobs or host endpoints. Select a compute type that meets your performance and budget needs. Azure AI services don't require compute resources.

1. **Pick a data source.** Use supported [data sources](/azure/machine-learning/how-to-access-data#supported-data-storage-service-types) to host training data for Azure Machine Learning. For Azure AI services, many services don't require fine-tuning data, and some, like Azure AI Custom Vision, allow you to upload local files to a managed data storage solution.

1. **Pick a compute platform.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to select the right platform for your workload.

1. **Pick a data processing service (optional).** Use Azure Functions for serverless data processing or Azure Event Grid to trigger data processing pipelines.

## Next step

> [!div class="nextstepaction"]
> [Networking](../platform/networking.md)
