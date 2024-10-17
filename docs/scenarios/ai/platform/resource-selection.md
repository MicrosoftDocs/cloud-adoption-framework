---
title: Resource selection recommendations for AI workloads on Azure
description: Organizations learn to select the right resources for Azure AI workloads with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Resource selection recommendations for AI workloads on Azure

This article offers resource selection recommendations for organizations running AI workloads on Azure. It focuses on Azure AI platform-as-a-service (PaaS) solutions, including Azure AI Studio, Azure OpenAI, Azure Machine Learning, and Azure AI Services. It covers both generative and non-generative AI workloads.

Making informed resource choices enables organizations to achieve better performance, scalability, and cost-effectiveness when deploying AI solutions. The following table provides an overview of the primary Azure AI PaaS solutions and important decision criteria.

| AI platform | AI type | Description | Skills required |
|---------|------------|---------| --- |
| Azure OpenAI | Generative AI | Platform for accessing OpenAI models | Developer and data science skills |
| Azure AI Studio | Generative AI | Platform for prompt engineering and deploy generative AI endpoints | Developer and data science skills |
| Azure AI services | Analytical AI | Platform for consuming prebuilt machine learning models | Developer skills |
| Azure Machine Learning | Machine learning | Platform for training and deploying machine learning models | Developer skills and advanced data science skills |

## Select resources for generative AI workloads

Generative AI requires the combination of different resources to process and generate meaningful outputs based on input data. Proper selection ensures that generative AI applications, such as those using [retrieval augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide), deliver accurate by grounding AI models.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram showing the basic components of a generative AI workload." lightbox="../images/generative-ai-app.svg" border="false":::

In a typical RAG workload, (1) the workload receives the user query. (2) An orchestrator, such as Prompt flow, Semantic Kernel, or LangChain, manages the data flow. (3) A search and retrieval mechanism finds the appropriate (4) grounding data to send to the generative AI endpoint. (5) A generative AI model endpoint generates a response based on the user query and grounding data. Use the following recommendations as framework to build generative RAG workloads.

- *Choose a generative AI platform.* Use Azure OpenAI or Azure AI Studio to deploy and manage generative AI models. [Azure OpenAI Service](/azure/ai-services/openai/overview) provides access to [OpenAI models](/azure/ai-services/openai/concepts/models) private networking, and content filtering. [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) offers a code-first platform for developing AI workloads. It has built-in tools for building and deploying applications. It also features a large model catalog, prompt flow, fine-tuning, content safety filters, and more.

- *Choose the appropriate AI compute type.* Azure AI Studio requires [compute instances](/azure/ai-studio/how-to/create-manage-compute) for prompt flow, creating indexes, and opening Visual Studio Code (Web or Desktop) within the studio. Choose a compute type based on your performance and budget needs.

- *Pick an orchestrator.* Popular orchestrators for generative AI include [Semantic Kernel](/semantic-kernel/overview/), [Prompt flow](https://microsoft.github.io/promptflow/index.html), and [LangChain](https://python.langchain.com/v0.2/docs/integrations/platforms/microsoft/). Semantic Kernel integrates with Azure services. LangChain provides extensibility beyond Microsoft's ecosystem.

- *Pick a search and knowledge retrieval mechanism.* To ground generative AI models, create an index or vector database for relevant data retrieval. Use Azure AI Search to build traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), apply [data chunking](/azure/search/vector-search-integrated-vectorization), and use [multiple query types](/azure/search/search-query-overview#types-of-queries). If your data resides in structured databases, consider using [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-use-pgvector), and [Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

- *Choose a data source for grounding data.* For images, audio, video, or large datasets, store grounding data in Azure Blob Storage. Alternatively, use databases supported by [Azure AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

- *Pick a compute platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right  platform for your workload.

## Select resources for nongenerative AI workloads

Nongenerative AI workloads rely on platforms, compute resources, data sources, and data processing tools to support machine learning tasks. Selecting the right resources allows you to build AI workloads using both prebuilt and custom solutions.

:::image type="content" source="../images/non-generative-ai-app.svg" alt-text="Diagram showing the basic components of a nongenerative AI workload." lightbox="../images/non-generative-ai-app.svg" border="false":::

In a nongenerative AI workload, (1) the workload ingests data. (2) An optional data processing mechanism extracts or manipulates incoming data. (3) An AI model endpoint analyzes the data. (4) Data supports training or fine-tuning of the AI models. Use the following recommendations as framework to build nongenerative AI workloads.

- *Choose a nongenerative AI platform.* [Azure AI services](/azure/ai-services/what-are-ai-services) offer prebuilt AI models that don't require data science skills. For guidance on selecting the right Azure AI service, see [Choose an Azure AI services technology](/azure/architecture/data-guide/technology-choices/cognitive-services). [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) provides a platform to build machine learning models with your own data and consume those models in AI workloads.

- *Choose the appropriate AI compute.* For Azure Machine Learning, you need [compute resources](/azure/machine-learning/concept-azure-machine-learning-v2) to run a job or host an endpoint. Use the compute type that meets your performance and budget needs. Azure AI services don't require compute resources.

- *Pick a data source.* For Azure Machine Learning, use one of the supported [data sources](/azure/machine-learning/how-to-access-data#supported-data-storage-service-types) to host your training data. For Azure AI services, many of the services don't require fine-tuning data, and some, like Azure AI Custom Vision, provide an option to upload local files to a managed data storage solution.

- *Pick a compute platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right workload platform.

- *Pick a data processing service (optional).* Azure Functions is a common data processing choice because it provides a serverless option. Azure Event Grid is also a common trigger mechanism for kicking off a data processing pipeline.

## Next step

> [!div class="nextstepaction"]
> [PaaS AI Networking](../platform/networking.md)
