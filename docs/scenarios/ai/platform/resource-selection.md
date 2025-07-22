---
title: Select Azure Platform as a Service (PaaS) Solutions for AI
description: Learn how to select the right Azure AI services, compute, and tools to build effective generative and nongenerative AI workloads.
author: stephen-sumner
ms.author: ssumner
ms.date: 03/27/2025
ms.topic: conceptual
---

# Select Azure PaaS solutions for AI

This article describes how to choose appropriate resources for Azure AI platform as a service (PaaS) solutions. The following table provides an overview of the primary Azure AI PaaS solutions and important decision criteria.

| AI services | AI type | Description | Skills required |
|---------|------------|---------| --- |
| [Azure AI Foundry](/azure/ai-foundry/what-is-azure-ai-foundry) | Generative AI and nongenerative AI | A platform for building and deploying generative and nongenerative AI applications | Developer and data science skills |
| [Azure AI services](/azure/ai-services/what-are-ai-services) | Generative AI and nongenerative AI | Various services that provide prebuilt generative and nongenerative AI models | Developer skills |
| [Azure OpenAI](/azure/ai-foundry/openai/concepts/models) | Generative AI | A service for accessing OpenAI models | Developer and data science skills |
| [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) | Machine learning | A service for training and deploying machine learning models | Developer skills and advanced data science skills |

## Select resources for generative AI workloads

Generative AI combines various resources to process input data and generate meaningful outputs. Select the right resources to ensure that applications, such as applications that use [retrieval-augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide), deliver accurate results by grounding AI models effectively.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram that shows the basic components of a generative AI workload." lightbox="../images/generative-ai-app.svg" border="false":::

The following RAG workload workflow corresponds to the previous diagram:

1. The workload receives a user query. 

1. An orchestrator, such as Azure AI Foundry Agent Service, Semantic Kernel, or LangChain, manages the data flow.

1. A search and retrieval mechanism identifies the appropriate grounding data.

1. The mechanism sends the grounding data to a generative AI endpoint.

1. The generative AI model endpoint generates a response based on the user query and grounding data.

Use the following recommendations to build generative RAG workloads:

1. **Choose a generative AI platform.** Use Azure AI Foundry or Azure OpenAI to deploy and manage generative AI models. Azure AI Foundry provides a code-first platform that includes built-in tools to develop, deploy, and orchestrate applications. Use Azure OpenAI if you only need access to [OpenAI models](/azure/ai-services/openai/concepts/models).

1. **Choose the appropriate AI compute type.** Azure AI Foundry requires [compute instances](/azure/ai-studio/how-to/create-manage-compute) for specific capabilities. Select a compute type that meets your performance and budget needs.

1. **Pick an orchestrator.** Use popular orchestrators like [Azure AI Foundry Agent Service](/azure/ai-services/agents/overview), [Semantic Kernel](/semantic-kernel/overview/), or [LangChain](https://python.langchain.com/v0.2/docs/integrations/platforms/microsoft/) to manage data flow and interactions. For workloads that have multiple collaborating agents, your orchestrator must support the [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) that you use.

1. **Pick a search and knowledge retrieval mechanism.** To ground generative AI models, create an index or vector database for relevant data retrieval. Use Azure AI Search to build traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), apply [data chunking](/azure/search/vector-search-integrated-vectorization), and use [multiple query types](/azure/search/search-query-overview#types-of-queries). For structured databases, consider [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-use-pgvector), or [Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

1. **Choose a data source for grounding data.** Store grounding data in Azure Blob Storage for images, audio, video, or large datasets. Alternatively, use databases that [AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions) support.

1. **Pick a compute platform.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to select the right platform for your workload.

## Select resources for nongenerative AI workloads

Nongenerative AI workloads use platforms, compute resources, data sources, and data processing tools to support machine learning tasks. Select the right resources to ensure that you can build AI workloads by using prebuilt or custom solutions effectively.

:::image type="content" source="../images/non-generative-ai-app.svg" alt-text="Diagram that shows the basic components of a nongenerative AI workload." lightbox="../images/non-generative-ai-app.svg" border="false":::

The following RAG workload workflow corresponds to the previous diagram:

1. The workload ingests data.

1. An optional data processing mechanism extracts or manipulates incoming data.

1. An AI model endpoint analyzes the data.

1. Data supports training or fine-tuning of AI models.

Use the following recommendations to build nongenerative AI workloads:

1. **Choose a nongenerative AI platform.** Use AI services or Machine Learning based on your requirements. AI services provides prebuilt AI models that simplify deployment and reduce the need for deep data science expertise. Machine Learning provides a platform to develop custom machine learning models by using your data. It also integrates those models into your workloads.

1. **Choose the appropriate AI compute type.** Machine Learning requires [compute resources](/azure/machine-learning/concept-azure-machine-learning-v2) to run jobs or host endpoints. Select a compute type that meets your performance and budget needs. AI services don't require compute resources.

1. **Pick a data source.** Use supported [data sources](/azure/machine-learning/how-to-datastore) to host training data for Machine Learning. Many AI services don't require fine-tuning data. And some AI services, like Azure AI Custom Vision, allow you to upload local files to a managed data storage solution.

1. **Pick a compute platform.** Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to select the right platform for your workload.

1. **Pick a data processing service (optional).** Use Azure Functions to process serverless data or Azure Event Grid to trigger data processing pipelines.

## Next step

> [!div class="nextstepaction"]
> [Networking](../platform/networking.md)
