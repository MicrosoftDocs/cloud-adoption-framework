---
title: Adopt AI platforms (PaaS) - Recommendations for building AI apps with Azure platforms
description: Learn how to build AI workloads, including generative and nongenerative AI apps, by using Azure PaaS services. Get detailed recommendations and architecture guides.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Resource selection for AI workloads on Azure

This article provides recommendations for building AI workloads by using Azure platform as a service (PaaS). The goal is to define the level of effort and help that you'll need to be successful in AI workload development with Azure PaaS services like Azure AI Studio, Azure AI services, and Azure Machine Learning. The article outlines the components you need to build generative and nongenerative AI workloads. It also provides links to example architectures.

## Understand generative AI workloads

Generative AI workloads use large and small language models to generate responses based on an input or query. 

### Generative AI components

Most generative AI workloads Azure platforms share a common set of components. The current best practice is to ground generative AI workloads with the [retrieval augmented generation (RAG)](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide).

(1) An workload receives the user query. (2) An orchestrator like Prompt flow, Semantic Kernel, or LangChain manages the dataflow. (3) A search and retrieval mechanism finds the right grounding data to send to the generative AI endpoint. (4) A generative AI model endpoint creates a response based on the user query and grounding data.

:::image type="content" source="../images/generative-ai-app.svg" alt-text="Diagram showing the basic components of a generative AI workload." lightbox="./images/generative-ai-app.svg" border="false":::

### Generative AI resources

Generative AI workloads using RAG need a generative AI model endpoint, orchestrator, search and retrieval mechanisms, data sources, workload platform, and compute resources. Here are the high-level choices you need to make when you create a generative AI workload in Azure:

- *Pick a generative AI platform.* To deploy and consume a generative AI model endpoint, you need a generative AI platform. Use Azure OpenAI Service and Azure AI Studio to deploy generative AI models:

    - [Azure OpenAI Service](/azure/ai-services/openai/overview) gives you access to [OpenAI models](/azure/ai-services/openai/concepts/models), Embedding models, DALL-E, Whisper, and text to speech models with the security and enterprise promise of Azure. Azure OpenAI offers private networking, regional availability, and responsible AI content filtering.

    - [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) is a platform for developing and deploying generative AI apps and Azure AI APIs responsibly. It includes a rich set of AI capabilities, simplified user interface and code-first experiences, offering a one-stop shop to build, test, deploy, and manage intelligent solutions. Azure AI Studio is designed to help developers and data scientists efficiently build and deploy generative AI applications with the power of Azure's broad AI offerings. The model catalog in Azure AI Studio features hundreds of models across model providers such as Azure OpenAI Service, Mistral, Meta, Cohere, NVIDIA, and Hugging Face, including models that Microsoft trained. and built-in development tools, such as prompt flow, fine-tuning, model evaluation, content safety filters, and tracing.

- *Choose the right AI compute type.* For Azure AI Studio, you need compute instances for prompt flow, creating an index, and opening Visual Studio Code (Web or Desktop) in Azure AI Studio. GPUs are ideal for deep learning, complex matrix operations, and large datasets. Consider CPUs for data preprocessing tasks or for training machine learning models on small datasets. You might want to use CPUs to reserve your GPU quota.

- *Pick an orchestrator.* Popular generative AI orchestrators include Microsoft [Semantic Kernel](/semantic-kernel/overview/), [Prompt flow](https://microsoft.github.io/promptflow/index.html), and [LangChain](https://python.langchain.com/v0.2/docs/integrations/platforms/microsoft/). Semantic Kernel easily integrates with Azure services. LangChain is likely to have easier extensibility outside of the Microsoft ecosystem.

- *Pick a search and knowledge retrieval mechanism.* To ground generative AI models, you need to create an index or vector database to search and retrieve the most relevant grounding data. Use Azure AI Search to create traditional and vector indexes from various [data sources](/azure/search/search-indexer-overview#supported-data-sources), perform [data chunking](/azure/search/vector-search-integrated-vectorization), and implement [multiple query types](/azure/search/search-query-overview#types-of-queries). Azure AI Search provides the best results unless you have your data already in structured format in any of the other data stores. If your data is in a database or datastore that supports vector databases and vector search, consider using the database functionality. For example, [Azure Cosmos DB](/azure/cosmos-db/vector-database), [Azure Database for PostgreSQL,](/azure/postgresql/flexible-server/how-to-use-pgvector) and [Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview-vector-similarity).

- *Choose a data source for grounding data.* For unstructured data like images, audio, video, and large datasets, use Azure Blob Storage to host grounding data. Alternatively, you can use databases supported by [Azure AI Search](/azure/search/search-indexer-overview#supported-data-sources) or [vector databases](/dotnet/ai/conceptual/vector-databases#available-vector-database-solutions).

- *Pick a compute platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right workload platform for your workload.

## Understand nongenerative AI workloads

Nongenerative AI workloads use machine learning algorithms to automate business processes within workloads. This section provides high-level recommendations to help you choose the appropriate nongenerative AI platform, data sources, and workload platform. The following diagram shows the basic components of a nongenerative AI workload.

:::image type="content" source="../images/non-generative-ai-app.svg" alt-text="Diagram showing the basic components of a nongenerative AI workload." lightbox="./images/non-generative-ai-app.svg" border="false":::

Within the Azure ecosystem,  AI workloads need the following components:

1. An workload ingests incoming data.
1. An optional data processing mechanism extracts or manipulates the incoming data. This mechanism ensures that the data fits the expectations of the model format or extracts relevant data to send to the AI model endpoint. 
1. An analytical AI model endpoint integrates with the workload and analyzes the incoming data.
1. Training data is used to train machine learning models in Azure Machine Learning. Optionally, you can use fine-tuning data to customize prebuilt AI models in Azure AI services. Azure has various data sources to choose from for these tasks.

Here are the high-level choices you need to make when you create a nongenerative AI workload in Azure:

- *Pick a nongenerative AI platform.* Azure AI services and Azure Machine Learning both allow you to integrate AI models into workloads. Azure AI services provide more than 10 AI services. Developers don't need data science skills to use and consume AI models in workloads. To pick the right AI service, see [Choose an Azure AI services technology](/azure/architecture/data-guide/technology-choices/cognitive-services). You can use [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) to build and improve your own machine learning models with your own data and consume those models in workloads.

- *Choose the right AI compute.* For Azure Machine Learning, you need AI compute resources to build, evaluate, inference, or fine-tune your AI models and prompt flows. GPUs should be the default for most AI workloads. They're ideal for deep learning, complex matrix operations, and large datasets. Consider CPUs for data preprocessing tasks or for training machine learning models on small datasets. You might want to use CPUs to reserve your GPU quota.

- *Pick a data source.* For Azure Machine Learning, use one of the supported [data sources](/azure/machine-learning/how-to-access-data#supported-data-storage-service-types) to host your training data. For Azure AI services, many of the services don't require fine-tuning data, and some, like Azure AI Custom Vision, provide an option to upload local files to a managed data storage solution.

- *Pick a compute platform.* Use the Azure [compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree) to pick the right workload platform.

- *Pick a data processing service (optional).* Azure Functions is a common data processing choice because it provides a serverless option. Azure Event Grid is also a common trigger mechanism for kicking off a data processing pipeline.

## Next step

> [!div class="nextstepaction"]
> [Secure AI](secure.md)
