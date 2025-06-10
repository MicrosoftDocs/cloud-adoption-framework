---
title: Resource selection recommendations for AI workloads on Azure
description: Organizations learn to select the right resources for Azure AI workloads with recommendations and best practices.
author: stephen-sumner
ms.author: ssumner
ms.date: 03/27/2025
ms.topic: conceptual
---

# Resource selection recommendations for AI workloads on Azure

This article offers resource selection recommendations for organizations running AI workloads on Azure. It focuses on Azure AI platform-as-a-service (PaaS) solutions, including Azure AI Foundry, Azure OpenAI, Azure Machine Learning, and Azure AI Services. It covers both generative and nongenerative AI workloads.

Making informed AI resource choices enables organizations to achieve better performance, scalability, and cost-effectiveness when managing AI workloads. The following table provides an overview of the primary Azure AI PaaS solutions and important decision criteria.

| AI services | AI type | Description | Skills required |
|---------|------------|---------| --- |
| [Azure AI Foundry](/azure/ai-foundry/what-is-azure-ai-foundry) | Generative AI & non-generative AI | A platform for building and deploying generative and non-generative AI applications | Developer and data science skills |
| [Azure AI services](/azure/ai-services/what-are-ai-services) | Generative AI & non-generative AI | Various services that provide prebuilt generative and non-generative AI models | Developer skills |
| [Azure OpenAI](/azure/ai-services/openai/) | Generative AI | A service for accessing OpenAI models | Developer and data science skills |
| [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning?view=azureml-api-2) | Machine learning | A service for training and deploying machine learning models | Developer skills and advanced data science skills |

## Select resources for generative AI workloads

Generative AI requires the combination of different resources to process and generate meaningful outputs based on input data. Proper selection ensures that generative AI applications, such as those using [retrieval augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide), deliver accurate by grounding AI models.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram showing the basic components of a generative AI workload." lightbox="../images/generative-ai-app.svg" border="false":::

In a typical RAG workload, (1) the workload receives the user query. (2) An orchestrator, such as the Azure AI Foundry Agent Service, Semantic Kernel, or LangChain, manages the data flow. (3) A search and retrieval mechanism finds the appropriate (4) grounding data to send to the generative AI endpoint. (5) A generative AI model endpoint generates a response based on the user query and grounding data. Use the following recommendations as framework to build generative RAG workloads.

- *Choose a generative AI platform.* Use Azure AI Foundry or Azure OpenAI to deploy and manage generative AI models. [Azure AI Foundry](/azure/ai-studio/what-is-ai-studio) offers a code-first platform for developing AI workloads. It has built-in tools for building, deploying, and orchestrating applications. Use [Azure OpenAI Service](/azure/ai-services/openai/overview) if you only need access to [OpenAI models](/azure/ai-services/openai/concepts/models).

- *Choose the appropriate AI compute type.* Azure AI Foundry requires [compute instances](/azure/ai-studio/how-to/create-manage-compute) for certain capabilities. Choose a compute type based on your performance and budget needs.

- *Pick an orchestrator.* Popular orchestrators for generative AI include [Azure AI Foundry Agent Service](/azure/ai-services/agents/overview), [Semantic Kernel](/semantic-kernel/overview/), and [LangChain](https://python.langchain.com/v0.2/docs/integrations/platforms/microsoft/).

- *Pick a search and knowledge retrieval mechanism.* To ground generative AI models, create an index or vector database for relevant data retrieval. Use Azure AI Search to build traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), apply [data chunking](/azure/search/vector-search-integrated-vectorization), and use [multiple query types](/azure/search/search-query-overview#types-of-queries). If your data resides in structured databases, consider using [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-use-pgvector), and [Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

- *Choose a data source for grounding data.* For images, audio, video, or large datasets, store grounding data in Azure Blob Storage. Alternatively, use databases supported by [Azure AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

- *Pick a compute platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right  platform for your workload.

## Select resources for nongenerative AI workloads

Nongenerative AI workloads rely on platforms, compute resources, data sources, and data processing tools to support machine learning tasks. Selecting the right resources allows you to build AI workloads using both prebuilt and custom solutions.

:::image type="content" source="../images/non-generative-ai-app.svg" alt-text="Diagram showing the basic components of a nongenerative AI workload." lightbox="../images/non-generative-ai-app.svg" border="false":::

In a nongenerative AI workload, (1) the workload ingests data. (2) An optional data processing mechanism extracts or manipulates incoming data. (3) An AI model endpoint analyzes the data. (4) Data supports training or fine-tuning of the AI models. Use the following recommendations as framework to build nongenerative AI workloads.

- *Choose a nongenerative AI platform.* Select an appropriate nongenerative AI platform based on your needs:

    - *[Azure AI services](/azure/ai-services/what-are-ai-services):* Azure AI services provide prebuilt AI models that don’t require deep data science expertise. You can deploy endpoints either individually for a specific AI service or collectively for all AI services. For enhanced security, deploy only the endpoints essential for your use case. When deploying individual AI services, each service has its own credentials, isolating them from each other and reducing the risk of a security incident affecting multiple services simultaneously. For more details, refer to the [Choose an Azure AI services technology](/azure/architecture/data-guide/technology-choices/cognitive-services). 
    
    - *[Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning):* If you require a platform to develop custom machine learning models using your data and integrate those models into your AI workloads, select Azure Machine Learning.

- *Choose the appropriate AI compute.* For Azure Machine Learning, you need [compute resources](/azure/machine-learning/concept-azure-machine-learning-v2) to run a job or host an endpoint. Use the compute type that meets your performance and budget needs. Azure AI services don't require compute resources.

- *Pick a data source.* For Azure Machine Learning, use one of the supported [data sources](/azure/machine-learning/how-to-access-data#supported-data-storage-service-types) to host your training data. For Azure AI services, many of the services don't require fine-tuning data, and some, like Azure AI Custom Vision, provide an option to upload local files to a managed data storage solution.

- *Pick a compute platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right workload platform.

- *Pick a data processing service (optional).* Azure Functions is a common data processing choice because it provides a serverless option. Azure Event Grid is also a common trigger mechanism for kicking off a data processing pipeline.

## Next step

> [!div class="nextstepaction"]
> [Networking PaaS AI](../platform/networking.md)
