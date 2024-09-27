---
title: AI Strategy - Recommendations to develop an AI adoption strategy
description: Get recommendations for developing an AI adoption strategy. Identify use cases and define strategies for data, technologies, and Responsible AI. 
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Strategy - Recommendations to develop an AI adoption strategy

This article describes how to define an AI adoption strategy. As with any strategy, you need data to create an actionable vision for your organization. The data requires understanding of where AI can benefit your business (use cases) and identifying the right solution for each use case. We recommend that you appoint someone to lead this effort and set goals and success targets to measure progress.

## Identify AI use cases

Look for processes that can benefit from automation or optimization, especially repetitive tasks, data-intensive workflows, and areas that have high error rates. In general, AI accommodates two strategic goals: enhancing individual productivity and improving business processes.

- *Generative AI* fosters individual productivity and provides a more adaptive customer experience across many business areas.

- *Non-generative AI* includes machine learning and analytical AI, such as search, speech, translation, and vision. Use non-generative AI to analyze structured data, automate repetitive processes, and make data-driven decisions that are based on trends in historical data.

The following table shows examples of generative AI and non-generative AI use cases.

| **Generative AI**                                      | **Non-generative AI**                                                                 |
|--------------------------------------------------------|---------------------------------------------------------------------------------------|
| Marketing: Automatically create social media posts and email newsletters. | Prediction: Forecast trends or optimize operations based on historical data.           |
| E-commerce platforms: Generate personalized product recommendations and tailored shopping experiences. | Process automation: Automate routine tasks and workflows that don't require content generation, such as customer service bots. |
| Product design: Quickly create multiple variations of product prototypes or design elements. | Data analysis: Uncover patterns in structured data for insights and data-driven decisions. |
| Software development: Automate repetitive code generation, such as CRUD operations. | Model simulation: Simulate complex systems (fluid dynamics, finite element analysis) to predict behavior and optimize designs or processes. |
| Educational platforms: Generate personalized quizzes and study materials for students. | Anomaly detection: Identify unusual patterns in data (fraud detection, equipment failure prediction). |
| Customer service: Provide context-based responses through AI-driven chatbots. | Recommendation: Offer personalized recommendations based on user behavior. For example, you can use recommendations for e-commerce and streaming services. |
| Advertising agencies: Create targeted ad variations for different audience segments. | Optimization: Improve efficiency by solving complex problems. For example, you can optimize supply chains or resource allocation. |
| Health and wellness apps: Generate customized workout routines and meal plans. | Sentiment analysis: Analyze text from social media or customer reviews to gauge public sentiment and enhance customer experience. |

## Identify your AI technology

For each use case, you need to identify an AI technology to support it. Each AI technology requires a different skill set, different data, and a different amount of effort for the implementation of a production-ready solution. You need to take some time to understand the available technologies and identify and validate the right solutions for your business.

Microsoft provides software (SaaS), platform (PaaS), and infrastructure (IaaS) services that you can use to adopt AI. There are services to improve individual productivity and many platforms to automate business processes by using generative and non-generative AI. Use the following decision tree to narrow the options for each AI opportunity. After identifying a service, carefully validate the selection by reviewing the skills needed, the data needed, and cost factors.

:::image type="content" source="./images/ai-decision-tree.svg" alt-text="Diagram that shows Microsoft and Azure services and decision points that indicate each service." border="false":::

- *Purchase Microsoft copilots (SaaS) to improve productivity.* Microsoft has four types of SaaS generative AI services. The following table gives you an overview and links to articles that provide more information.

    | SaaS AI Copilot products | Description | User |
    |--------|--------|-------|
    | Copilot for Microsoft 365 | Use [Copilot for Microsoft 365](/copilot/microsoft-365/microsoft-365-copilot-overview) for an enterprise-wide solution that automates work in M365 apps and provides a secure way to chat with business data in Microsoft Graph. | Business |
    | Role-based agents for Microsoft 365 | Use to enhance productivity for specific business roles, such as [Microsoft 365 Copilot for Security](/copilot/security/microsoft-security-copilot), [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business |
    | Copilots in Microsoft products | Use to enhance productivity within Microsoft products, such as [Copilot in GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual |
    | Copilot in browser and mobile apps | Use [free](https://copilot.microsoft.com/) version for browser-based access to GPT models and [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) version for better performance and more capacity. | Individual |

- *Build intelligent apps with Azure AI platform services (PaaS).* Microsoft provides a range of platform-as-a-service (PaaS) solutions, from low-code to code-first platforms. These platforms cater to different skill levels and provide options for deploying building AI, analytical AI, and machine learning applications.

    | AI platform products | Description | Skills required |
    |---------|------------|---------|
    | Copilot Studio | Low-code platform to build generative AI applications | Without developer or data science skills |
    | Azure AI Services | Code-first platform to build analytical AI applications | Developer skills |
    | Azure AI Studio | Code-first platform to develop generative AI applications | Developer and data science skills |
    | Azure Machine Learning and Microsoft Fabric | Platform to train and deploy AI models using your own data | Developer and advanced data science skills |

- *Use Azure infrastructure services (IaaS) to bring your own AI models.* For more advanced AI needs, Azure Virtual Machines and Azure Kubernetes Service provide access to GPUs and CPUs with virtual machine images to bring your own AI models to Azure. Azure PaaS solutions are the preferred adoption pathway. You should use them first before you try IaaS.

### Understand the skills needed to adopt AI

There are different approaches to adopting AI, and each approach requires different skills, as described in the following table. Adopting SaaS products requires very few skills to adopt. Building a Retrieval Augmented Generation (RAG) application with generative AI or training an AI model on your own data requires more advanced skills. Use the following table to see the skills required adopt AI for each AI approach:

| AI type | Service model | General use | Solution | Data needed | Skills required  |
|---------|--------------|-----------------|----------|-------------|-------------------------|
| Generative AI | SaaS | Increase individual productivity | Copilot (Free or Pro) | No | None |
| Generative AI | SaaS | Increase individual productivity and chat with business data | Copilot for Microsoft 365 and other SaaS Copilot products | Yes | General IT |
| Generative AI | Low-code PaaS | Build RAG applications | Copilot Studio | Yes | Ability to use a low-code platform to connect data sources, map out prompts, and deploy copilots to various locations |
| Generative AI | PaaS | Build RAG applications | Azure AI Studio or Azure OpenAI | Yes | Ability to select models, orchestrate dataflow, chunk data, enrich chunks, choose indexing, understand query types (full-text, vector, hybrid), understand filters and facets, perform reranking, engineer prompt flow, deploy endpoints, and consume endpoints in apps |
| Generative AI | PaaS | Fine-tune generative AI models | Azure AI Studio | Yes | Ability to preprocess data, split into training and validation data, validate models, configure additional parameters, improve model, deploy model, and consume endpoints in apps |
| Machine learning | PaaS | Train and inference machine learning models by using our own data | Azure Machine Learning or Microsoft Fabric | Yes | Ability to preprocess data, train models by using code or automation, improve models, deploy machine learning models, and consume endpoints in apps |
| Analytical AI | PaaS | Consume analytical AI models in applications | Azure AI services | Yes | Picking the right AI model, securing endpoints, consuming endpoints in apps, and fine-tuning as needed |
| Generative AI, machine learning, analytical AI | IaaS | Train and inference your own AI models. Bring your own models to Azure. | Azure Virtual Machines, Azure Kubernetes Service, Azure Container Apps | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps |

### Understand the data needed

AI solutions have varying data needs. Some, like Copilot for Microsoft 365, require only general enterprise data. Other AI solutions, like RAG applications, require specific domain-specific information. The level of expertise needed to gather and prepare the required data also varies. Some solutions require no special skills. Others require advanced data science capabilities. Knowing these data requirements in advance helps you set the right expectations and choose the appropriate AI service for your needs.

- *Understand SaaS copilot data needs.* Copilot for Microsoft 365 uses enterprise data in Microsoft Graph. No provisioning is needed. You just need to [categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) by using sensitivity labels. Copilots for specific business roles have different data connection and plug-in options, and most in-product SaaS copilots don’t require additional data preparation. Check the documentation for each service for more information.

- *Understand Copilot Studio (low-code, generative AI platform) data needs.* You need to [connect data](/microsoft-copilot-studio/knowledge-copilot-studio) (knowledge sources) from across your enterprise and external public websites. Copilot Studio automates much of the data processing needed to create custom copilots for various business applications.

- *Understand Azure AI Studio and Azure OpenAI (code-first, generative AI platforms) data needs.* Creating generative AI apps typically requires grounding data for RAG. The grounding data needs to be limited to your specific use case. You shouldn't mix different types of information or include irrelevant data in the grounding data. Unstructured data needs to be in the [right format](/azure/search/search-how-to-create-search-index?tabs=portal#prerequisites) and [properly processed](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide) when you create an [index](/azure/search/search-how-to-create-search-index).

For structured data in databases, you need to embed and connect the data to your app. For example, [Azure SQL Database](/azure/azure-sql/database/ai-artificial-intelligence-intelligent-applications) natively connects to Azure AI Search. You can also use certain database capabilities, such as the vector database capability in [Azure Cosmos DB](/azure/cosmos-db/vector-database). [Azure Database for PostgreSQ](/azure/postgresql/flexible-server/generative-ai-azure-overview)L allows you to connect to Azure AI via code.

- *Understand Azure Machine Learning and Microsoft Fabric data needs.* Training machine learning models in Azure Machine Learning or Fabric requires large data sets on a specific domain. You need to preprocess, clean, and filter data before you split, train, and validate AI models.

- *Understand Azure AI services (analytical AI platforms) data needs.* Most Azure AI services don't require additional data, but you can fine-tune some models, like models in Azure AI Custom Vision.

### Understand cost factors for each AI solution

Cost is an important consideration when you validate your choice of AI solutions. The goal of this section is to make it easy to find and estimate the costs of different services. Microsoft Saas copilots and Copilot Studio have a subscription or license. The main cost factors for Azure AI PaaS services are model usage, data storage, and compute costs. Virtual machines (CPUs or GPUs) are the primary cost for AI models running on Azure Virtual Machines. For Azure services, use the individual product [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to develop full estimates.

This table provides an overview of cost factors for Microsoft AI solutions:

| Service | Supported AI approach | Access | Main cost factors |
|---------|----------------------|--------|-------------------|
| [Copilot (free)](https://copilot.microsoft.com/) | SaaS generative AI | Free in browser or mobile apps | None |
| Copilot Pro | SaaS generative AI | With a subscription, available in browser or mobile apps| [Subscription](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |
| [Copilot for Microsoft 365](/copilot/microsoft-365/microsoft-365-copilot-overview) | SaaS generative AI with RAG | Add to an existing Microsoft 365 subscription | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans) |
| [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) | PaaS generative AI with RAG via low-code platform | Browser | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |
| [Azure AI services](/azure/ai-services/what-are-ai-services) | PaaS analytical AI | Azure | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |
| Azure OpenAI | PaaS generative AI, with and without RAG, for OpenAI models | Azure | Number of tokens in and out and compute |
| [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) | PaaS generative AI with and without RAG, PaaS fine-tuning generative AI models | Azure | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) | PaaS training machine learning and generative AI models | Azure | Compute, storage, and data transfer |
| [Virtual Machines](/azure/virtual-machines/overview) | IaaS, train any AI model | Azure | Compute, compute node orchestration, managed disks, storage transactions, public IPs, and other Azure services used |

## Identify your AI data

When you train, ground, or use AI models, be sure that you send only the right data to the model and abide by ethical and regulatory standards. Your data strategy should outline acceptable data use and prepare your business to use ethical, accurate, high-quality data. Evaluate the completeness, relevance, and representativeness of the data to support reliable AI outputs.

- *Protect data security and privacy.* Establish robust security measures, including encryption, access controls, and anonymization, to safeguard sensitive data in AI processes. Define access controls to protect data from unauthorized use and breaches. Don't let data boundaries blur when data is fed into AI systems. For example, AI workloads for all employees should only use data that's appropriate for all employees. Internet-facing AI workloads must only use data that's appropriate for public use.

- *Manage the data lifecycle.* Define how data will be collected, stored, processed, and retired. Ensure compliance with data retention and disposal policies, and use version control to maintain accuracy across model updates and data changes.

- *Define acceptable use.* Provide limits on how individuals and systems interact with AI. Read the data security and privacy policies for individual products to define what data should be shared. Some services, like Azure OpenAI, allow you to elevate privacy levels above the platform default.

- *Monitor and evaluate continuously.* Set up ongoing monitoring of AI models and data pipelines to ensure data quality, performance, and fairness over time. Regularly audit data and model outputs to catch any shifts that could affect reliability or compliance.

## Identify your AI responsibility

Adopting AI responsibly is an iterative process that implements regular monitoring and measuring to ensure that AI meets your business objectives. Microsoft follows six [Responsible AI](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) principles when developing AI systems. These principles govern the process of building AI workloads that are beneficial to all end users. You need to define or adopt similar principles to guide your process of managing AI workloads. Microsoft has [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) to help you map, measure, and manage the AI applications that you build in accordance with Responsible AI.

- *Set up data governance and accountability.* Create a governance framework to assign responsibility for managing data quality, enforcing ethical AI practices, and ensuring proper data usage. Implement auditing processes to maintain accountability throughout AI data handling.

- *Mitigate data biases.* Identify potential biases in datasets and apply strategies to reduce them. Regularly assess fairness, address imbalances, and ensure that AI outputs are unbiased toward any group or demographic.

- *Ensure data transparency.* Enable stakeholders to understand how data is collected, used, and processed in AI systems. Provide clear traceability of data inputs and AI decisions to foster trust and accountability.

## Next step

> [!div class="nextstepaction"]
> [Create a plan to adopt AI](plan.md)
