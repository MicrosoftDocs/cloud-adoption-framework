---
title: Adopt AI platforms (PaaS) - Recommendations for building AI apps with Azure platforms
description: Learn how to build AI applications, including generative and nongenerative AI apps, by using Azure PaaS services. Get detailed recommendations and architecture guides.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Adopt AI platforms (PaaS) – Recommendations for building AI apps with Azure platforms

This article provides recommendations for building AI applications by using Azure platform as a service (PaaS). The goal is to define the level of effort and help that you'll need to be successful in AI application development with Azure PaaS services like Azure AI Studio, Azure AI services, and Azure Machine Learning. The article outlines the components you need to build generative and nongenerative AI applications. It also provides links to examples of architectures.

## Build generative AI applications

This section provides high-level recommendations to guide you through choosing the appropriate generative AI platform, orchestrator, search and retrieval mechanisms, data sources, application platform, and compute resources.

The following diagram shows the basic components of a generative AI application that implements Retrieval Augmented Generation (RAG). 

:::image type="content" source="./images/generative-ai-app.svg" alt-text="Diagram showing the basic components of a generative AI application." lightbox="./images/generative-ai-app.svg" border="false":::

Most generative AI applications implement RAG. At a high-level, RAG applications need the following components: 
1. An application receives the user query. 
1. An orchestrator like Prompt flow, Semantic Kernel, or LangChain manages the dataflow. 
1. A search and retrieval mechanism exposes data from several data sources in a way that ensures that the data can be consumed by AI apps. 
1. A generative AI model endpoint creates a response based on the user query and grounding data. 

For more information, see [Guide to designing and developing a RAG solution](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide). 

Here are the high-level choices you need to make when you create a generative AI application in Azure:

- *Pick a generative AI platform.* To deploy and consume a generative AI model endpoint, you need a generative AI platform. Depending on your needs, you can use either [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) or Azure OpenAI Service as the default and use Azure OpenAI if you just need to access OpenAI models. Azure AI Studio provides a code-first development experience. You get access to a wide variety of generative AI models and built-in development tools, such as prompt flow, fine-tuning, model evaluation, content safety filters, and tracing. Azure OpenAI gives you access to OpenAI models and is a good starting point if you just want to use those models.

- *Pick an orchestrator.* Popular generative AI orchestrators include Microsoft [Semantic Kernel](/semantic-kernel/overview/), [Prompt flow](https://microsoft.github.io/promptflow/index.html), and [LangChain](https://python.langchain.com/v0.2/docs/integrations/platforms/microsoft/). Semantic Kernel easily integrates with Azure services. LangChain is likely to have easier extensibility outside of the Microsoft ecosystem.

- *Pick a search and knowledge retrieval mechanism.* To ground generative AI models, you need to create an index or vector database to search and retrieve the most relevant grounding data. Use Azure AI Search to create traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), perform [data chunking](/azure/search/vector-search-integrated-vectorization), and use [multiple query types](/azure/search/search-query-overview#types-of-queries). Azure AI Search gives you the best results unless you have your data already in structured format in any of the other data store. If your data is in a database or datastore that supports vector databases and vector search, consider using the database functionality. For example, [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL,](/azure/postgresql/flexible-server/how-to-use-pgvector) and [Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

- *Choose a data source for grounding data.* For unstructured data like images, audio, videos, and large datasets, use Azure Blob Storage for hosting grounding data. Alternatively, you can use databases supported by [Azure AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

- *Pick an application platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right application platform for your application.

- *Choose the right compute.* For Azure AI Studio and Azure Machine Learning, you need compute resources to build, evaluate, inference, or fine-tune your AI models and prompt flows. GPUs should be the default for most AI workloads. They're ideal for deep learning, complex matrix operations, and large datasets. Consider CPUs for data preprocessing tasks or training machine learning models on small datasets. You might want to use CPUs to reserve your GPU quota.

- *Get implementation guidance.* Microsoft has detailed implementation guidance and deployable assets for creating enhanced-security generative AI applications. Use this guidance as a baseline and adapt the baseline to your needs. (See the following table.)

- *Harden Azure resources.* Apply [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for every Azure resource. Also, follow the security recommendations in [Azure service guides](/azure/well-architected/service-guides/). 

The following table provides links to implementation guidance for building generative AI applications.

| Reference architectures  | Technical guides |
| --- | --- |
| [Baseline OpenAI end-to-end chat reference architecture](/azure/architecture/ai-ml/architecture/baseline-openai-e2e-chat) | [Access Azure OpenAI and other language models through a gateway](/azure/architecture/ai-ml/guide/azure-openai-gateway-guide) |
| [Basic OpenAI end-to-end chat reference architecture](/azure/architecture/ai-ml/architecture/basic-openai-e2e-chat) | [Azure OpenAI Landing Zone Solution Accelerator](https://github.com/Azure/azure-openai-landing-zone/tree/main) |
| [Azure OpenAI chat baseline architecture in an Azure landing zone](/azure/architecture/ai-ml/architecture/azure-openai-baseline-landing-zone) |

## Build nongenerative AI applications

Nongenerative AI applications use machine learning algorithms to automate business processes within applications. This section provides high-level recommendations to guide you through choosing the appropriate nongenerative AI platform, data sources, and application platform.

The following diagram shows the basic components of a nongenerative AI application.

:::image type="content" source="./images/non-generative-ai-app.svg" alt-text="Diagram showing the basic components of a nongenerative AI application." lightbox="./images/non-generative-ai-app.svg" border="false":::


Within the Azure ecosystem, analytical AI applications need the following components: 

1. An application ingests incoming data. 
1. An optional data processing mechanism extracts or manipulates the incoming data. This mechanism makes the data fit the expectations of the model format or extracts relevant data to send to the AI model endpoint. 
1. An analytical AI model endpoint integrates with the application and analyzes the incoming data. 
1. Training data is used to train machine learning models in Azure Machine Learning. Optionally, you can use fine-tuning data to customize prebuilt AI models in Azure AI services. Azure has various data sources to choose from for these tasks. 

Here are the high-level choices you need to make when you create a nongenerative AI application in Azure:

- *Pick a nongenerative AI platform.* Azure AI services and Azure Machine Learning both allow you to integrate AI models into applications. Azure AI services provide more than 10 AI services. Developers don't need data science skills to use and consume AI models in applications. To pick the right AI service, see [Choose an Azure AI services technology](/azure/architecture/data-guide/technology-choices/cognitive-services). You can use [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) to build and improve your own machine learning models with your own data and consume those models in applications.

- *Pick a data source.* For Azure Machine Learning, use one of the supported [data sources](/azure/machine-learning/how-to-access-data#supported-data-storage-service-types) to host your training data. For Azure AI services, many of the services don't require fine-tuning data, and some, like Azure AI Custom Vision, provide an option to upload local files to a managed data storage solution.

- *Pick an application platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right application platform.

- *Pick a data processing service (optional).* Azure Functions is a common data processing choice because it provides a serverless option. Azure Event Grid is also a common trigger mechanism for kicking off a data processing pipeline.

- *Harden Azure resources.* As a starting point, apply [Azure security baselines](/security/benchmark/azure/security-baselines-overview) and follow the security recommendations in [Azure service guides](/azure/well-architected/service-guides/) for every Azure resource in your AI workloads. Additionally, you must follow the AI workload security guidance in [Secure AI](secure.md).

- *Get implementation guidance.* Microsoft provides detailed implementation guidance and deployable assets for creating enhanced-security nongenerative AI applications. Use this guidance as a baseline, and adapt the baseline to your needs. Review the [machine learning and AI architectures](/azure/architecture/ai-ml/) to see guidance that's aligned to different use cases.


## Next step

> [!div class="nextstepaction"]
> [Secure AI](secure.md)
