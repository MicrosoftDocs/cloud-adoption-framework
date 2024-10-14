---
title: Resource selection for AI workloads on Azure platforms
description: Learn how to build AI workloads, including generative and nongenerative AI apps, by using Azure PaaS services. Get detailed recommendations and architecture guides.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Resource selection for AI workloads on Azure platforms

This article provides guidance on selecting the right Azure platform resources for different types of AI workloads. It covers both generative and nongenerative AI platforms. The following table lists the primary Azure AI platforms, AI type, and skills required to be successful.

| AI platform | AI type | Description | Skills required |
|---------|------------|---------| --- |
| Azure OpenAI | Generative AI | Platform for accessing OpenAI models | Developer and data science skills |
| Azure AI Studio | Generative AI | Platform for prompt engineering and deploy generative AI endpoints | Developer and data science skills |
| Azure AI services | Analytical AI | Platform for consuming prebuilt machine learning models | Developer skills |
| Azure Machine Learning | Machine learning | Platform for training and deploying machine learning models | Developer skills and advanced data science skills |

## Select resources for generative AI workloads

This section outlines key resource decisions and resources for selecting platforms, compute types, orchestrators, and data sources in Azure. The current best practice is to ground generative AI workloads with the [retrieval augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide). RAG helps scope and govern the output of generative AI models.

In a typical RAG workload, (1) the workload receives the user query. (2) An orchestrator like Prompt flow, Semantic Kernel, or LangChain manages the dataflow. (3) A search and retrieval mechanism finds the right (4) grounding data to send to the generative AI endpoint. (5) A generative AI model endpoint creates a response based on the user query and grounding data.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram showing the basic components of a generative AI workload." lightbox="./images/generative-ai-app.svg" border="false":::

Choosing the right resources for generative AI ensures efficient data processing, retrieval, and model execution. Use the following recommendations as framework to build generative RAG workloads.

- *Pick a generative AI platform.* Use Azure OpenAI Service or Azure AI Studio to deploy and manage generative AI models. [Azure OpenAI Service](/azure/ai-services/openai/overview) offers access to [OpenAI models](/azure/ai-services/openai/concepts/models) private networking, and content filtering. [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) is a code-first platform for developing generative AI workloads. It provides provides tools for building and deploying AI applications, with a large model catalog, prompt flow, fine-tuning, content safety filters, and more.

- *Choose the right AI compute type.* In Azure AI Studio, you need [compute instances](/azure/ai-studio/how-to/create-manage-compute) for prompt flow, creating an index, and opening Visual Studio Code (Web or Desktop) in Azure AI Studio. Use the compute type that meets your performance and budget needs.

- *Pick an orchestrator.* Popular generative AI orchestrators include Microsoft [Semantic Kernel](/semantic-kernel/overview/), [Prompt flow](https://microsoft.github.io/promptflow/index.html), and [LangChain](https://python.langchain.com/v0.2/docs/integrations/platforms/microsoft/). Semantic Kernel integrates with Azure services, while LangChain offers easier extensibility outside of Microsoft’s ecosystem.

- *Pick a search and knowledge retrieval mechanism.* To ground generative AI models, you need to create an index or vector database to search and retrieve the most relevant grounding data. Use Azure AI Search to create traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), perform [data chunking](/azure/search/vector-search-integrated-vectorization), and implement [multiple query types](/azure/search/search-query-overview#types-of-queries). Azure AI Search provides the best results unless you have your data already in structured format in any of the other data stores. If your data resides in structured databases, consider options like [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL,](/azure/postgresql/flexible-server/how-to-use-pgvector) and [Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

- *Choose a data source for grounding data.* For images, audio, video, and large datasets, use Azure Blob Storage to host grounding data. Alternatively, use databases supported by [Azure AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

- *Pick a compute platform for you application.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right  platform for your workload.

## Understand nongenerative AI workloads

This section discusses the major resource decisions, including platform selection, compute resources, data sources, and optional data processing services.

In a typical nongenerative AI workload, (1) the workload ingests data. (2) An optional data processing mechanism extracts or manipulates the incoming data. (3) An AI model endpoint integrates with the workload and analyzes the incoming data. (4) Data is used to train or fine-tune the AI models.

:::image type="content" source="../images/non-generative-ai-app.svg" alt-text="Diagram showing the basic components of a nongenerative AI workload." lightbox="./images/non-generative-ai-app.svg" border="false":::

Selecting the correct Azure resources for nongenerative AI workloads is essential for building a responsive and efficient AI system. Use the following recommendations as framework to build nongenerative AI workloads.

- *Pick a nongenerative AI platform.* Azure AI services and Azure Machine Learning both allow you to integrate AI models into workloads. [Azure AI services](/azure/ai-services/what-are-ai-services) provide more than 10 AI services. Developers don't need data science skills to use and consume AI models in workloads. To pick the right Azure AI service, see [Choose an Azure AI services technology](/azure/architecture/data-guide/technology-choices/cognitive-services). [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) provides a platform to build machine learning models with your own data and consume those models in AI workloads.

- *Choose the right AI compute.* For Azure Machine Learning, you need [compute resources](/azure/machine-learning/concept-azure-machine-learning-v2) to run a job or host an endpoint. Use the compute type that meets your performance and budget needs. Azure AI services doesn't require compute resources.

- *Pick a data source.* For Azure Machine Learning, use one of the supported [data sources](/azure/machine-learning/how-to-access-data#supported-data-storage-service-types) to host your training data. For Azure AI services, many of the services don't require fine-tuning data, and some, like Azure AI Custom Vision, provide an option to upload local files to a managed data storage solution.

- *Pick a compute platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right workload platform.

- *Pick a data processing service (optional).* Azure Functions is a common data processing choice because it provides a serverless option. Azure Event Grid is also a common trigger mechanism for kicking off a data processing pipeline.

## Next step

> [!div class="nextstepaction"]
> [PaaS AI Networking](../platform/networking.md)
