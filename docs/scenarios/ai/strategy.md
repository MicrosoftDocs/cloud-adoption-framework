---
title: AI Strategy - Recommendations to develop an AI adoption strategy
description: Recommendations to develop an AI adoption strategy
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Strategy - Recommendations to develop an AI adoption strategy

This article shows you how to define an AI adoption strategy. As with any strategy, you need data to create an actionable vision for your organization. The data requires understanding of where AI can benefit your business (use cases) and identifying the right solution for each use case. It’s advisable to appoint someone to lead this effort and set goals and success targets to measure progress.

## Identify AI use cases

Compile a comprehensive list of possible AI use cases. Don't limit ideas to current capabilities. Consider future possibilities as well. Later, when you choose your AI technology, you evaluate the technical capability or can acquire it to implement each use case. For now, focus on compiling use cases. For an example, see [Example AI strategy](strategy.md#example-ai-strategy]. 

- *Understand AI.* In general, AI accommodates two strategic goals, enhancing individual efficiency and improving business processes.  Generative AI fosters individual productivity and provides a more adaptive customer experience across many business areas. Non-generative AI includes machine learning and analytical AI, such as search, speech, translation, and vision. It’s best for analyzing structured data, automating repetitive processes, and making data-driven decisions based on trends in historical data. 

- *Analyze business processes for automation opportunities.* Identifying processes suitable for automation can greatly enhance efficiency and reduce operational costs. Examine your workflows to find repetitive tasks, data-heavy operations, or areas with high error rates where AI can make a significant impact.  

- *Conduct an assessment.* Gather input from various departments to understand challenges and inefficiencies that could be addressed with AI. Document current workflows to spot areas where AI can automate tasks or provide insights. 

- *Align AI initiatives with strategic goals.* Aligning AI projects with your strategic objectives ensures that efforts contribute to overall business success. Map out how AI can enhance productivity or streamline processes and prioritize use cases that directly support your company's mission and goals. 

- *Explore industry use cases.* Research how other businesses are using AI to gain insights. Stay informed about emerging AI technologies and applications relevant to your industry. 

## Identify your AI technology

For each use case, you need to identify an AI technology to support it. Each AI technology choice requires a different skillset, data, and effort to implement a production-ready solution. You need to take some time to understand the technology available and start identifying and validating the right solutions for your business.

Microsoft has software (SaaS), platforms (PaaS), and infrastructure (IaaS) services you can use to adopt AI. There are services to improve individual productivity and many platforms to automate business processes using generative and non-generative AI. Use the following AI decision tree to help narrow the options for each AI opportunity. After identifying a service, carefully validate the selection by reviewing the skills needed, data needed, and cost factors.

:::image type="content" source="./images/ai-decision-tree.png" alt-text="Diagram showing Microsoft and Azure services on the right and decision points that lead to each service." lightbox="./images/ai-decision-tree.png" border="false":::

### Buy Microsoft Copilots (SaaS) to improve efficiency.

Microsoft has four different types of SaaS generative AI services. Use the table for an overview and links for more information.

    | SaaS AI Copilot products | Description | User |
    |--------|--------|-------|
    | Copilot for Microsoft 365 | Use [Copilot for Microsoft 365](/copilot/microsoft-365/microsoft-365-copilot-overview) for an enterprise-wide solution that automates work in M365 apps and provides a secure way to chat with business data in Microsoft Graph. | Business |
    | Role-based agents for Microsoft 365 | Use to enhance productivity for specific business roles, such as [Microsoft 365 Copilot for Security](/copilot/security/microsoft-security-copilot), [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business |
    | Copilots in Microsoft products | Use to enhance productivity within Microsoft products, such as [Copilot in GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual |
    | Copilot in browser and mobile apps | Use [free](https://copilot.microsoft.com/) version for browser-based access to GPT models and [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) version for better performance and more capacity. | Individual |

### Build intelligent apps with Azure AI platform services (PaaS)

Microsoft provides a range of platform-as-a-service (PaaS) solutions, from low-code to code-first platforms. These platforms cater to different skill levels and provide options for deploying building AI, analytical AI, and machine learning applications.

    | AI platform products | Description | Skills required |
    |---------|------------|---------|
    | Copilot Studio | Low-code platform to build generative AI applications | Without developer or data science skills |
    | Azure AI Services | Code-first platform to build analytical AI applications | Developer skills |
    | Azure AI Studio | Code-first platform to develop generative AI applications | Developer and data science skills |
    | Azure Machine Learning and Microsoft Fabric | Platform to train and deploy AI models using your own data | Developer and advanced data science skills |

### Use Azure infrastructure services (IaaS) to bring your own AI models

For more advanced AI needs, Azure Virtual Machines and Azure Kubernetes Service provide access to GPUs and CPUs with virtual machine images to bring your own AI models to Azure. Azure PaaS solutions are the preferred adoption pathway and should be used first before attempting IaaS.

### Understand the skills needed to adopt AI

There are different approaches to adopting AI, and each approach requires different skills *(see table).* Adopting SaaS products requires very few skills to adopt. Building a RAG application with generative AI or training an AI model on your own data requires more advanced skills. Use the following table to see the skills required adopt AI for each AI approach:

*Table. Summary of skills required to adopt*
| AI type | Service model | General use | Solution | Data needed | Skills required to adopt |
|---------|--------------|-----------------|----------|-------------|-------------------------|
| Generative AI | SaaS | Individual productivity | Copilot (Free or Pro) | No | None |
| Generative AI | SaaS | Individual productivity and chatting with business data | Copilot for M365 and other SaaS Copilot products | Yes | General IT |
| Generative AI | Low-code PaaS | Build RAG applications | Copilot Studio | Yes | Ability to use low-code platform to connect data sources, map out prompts, and deploy copilots to various locations |
| Generative AI | PaaS | Build RAG applications | Azure AI Studio or Azure OpenAI | Yes | Ability to select models, orchestrate dataflow, chunk data, enrich chunks, choose indexing, query type (full-text, vector, hybrid), filter/facets, reranking, engineer prompt flow, deploy endpoints, consume endpoints in app |
| Generative AI | PaaS | Fine-tune generative AI models | Azure AI Studio | Yes | Preprocess data, split into training and validation data, validate models, configure additional parameters, improve model, deploy model, consume endpoints in app |
| Machine learning | PaaS | Train and inference machine learning models using our own data | Azure Machine Learning or Microsoft Fabric | Yes | Preprocess data, train models with code or automation, improve model, deploy ML model, consume endpoints in app |
| Analytical AI | PaaS | Consume analytical AI models in applications | Azure AI services | Yes | Picking the right AI model, secure endpoints, consume endpoints in app, fine-tune as needed |
| Generative AI, machine learning, analytical AI | IaaS | Train and inference your own AI models. Bring your own models to Azure | Azure Virtual Machines, Azure Kubernetes, Azure Container Apps | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploy endpoints, secure endpoint, consume endpoints in app |

### Understand the data needed

AI solutions have varying data needs. Some require only general enterprise data, such as Copilot for M365. Other AI solutions need specific domain-specific information, such as RAG applications. The level of expertise needed to gather and prepare the required data also varies. Some solutions require no special skills while others demand advanced data science capabilities. Knowing these data requirements in advance helps you set the right expectations and choose the appropriate AI service for your needs.

- *Understand SaaS Copilots data needs.* Copilot for M365 uses enterprise data in Microsoft Graph. There’s no provisioning needed use just need to [categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels. Copilots for specific business roles have different data connection and plugin options, and most in-product SaaS Copilots don’t require additional data preparation. Check the documentation for each service for more information.

- *Understand Copilot Studio (low-code, generative AI platform) data needs.* You need to [connect data](/microsoft-copilot-studio/knowledge-copilot-studio) (knowledge sources) from across your enterprise and external public websites. Copilot Studio automates much of the data processing needed to create custom copilots for various business applications.

- *Understand Azure AI Studio and Azure OpenAI (code-first, generative AI platforms) data needs.* Creating generative AI apps typically requires grounding data for retrieval augmented generation. The grounding data needs to be limited to your specific use case. You don’t want to mix different types of information or irrelevant data in the grounding data. Unstructured data needs to be in the [right format](/azure/search/search-how-to-create-search-index?tabs=portal#prerequisites) and [properly processed](/azure/architecture/ai-ml/guide/rag/rag-solution-design-and-evaluation-guide) to create an [index](/azure/search/search-how-to-create-search-index).

    For structured data in databases, you need to embed and connect the data to your app. For example, [Azure SQL Database](/azure/azure-sql/database/ai-artificial-intelligence-intelligent-applications) natively connects to Azure AI Search. You can also use certain database capabilities, such as the vector database capability in [Azure Cosmos DB](/azure/cosmos-db/vector-database) supports database vectorization. [Azure Database for PostgreSQ](/azure/postgresql/flexible-server/generative-ai-azure-overview)L allows you to connect to Azure AI via code.

- *Understand Azure Machine Learning and Microsoft Fabric data needs.* Training machine learning models in Azure Machine Learning or Fabric requires large data sets on a specific domain. You need to preprocess, clean, and filter before splitting, training, and validating AI models.

- *Understand Azure AI services (analytical AI platforms) data needs.* Most Azure AI services don’t require additional data, but you can fine-tune some models, like models in Custom Vision.

### Understand cost factor for each AI solution

Cost is an important consideration when validating your AI solution choice. The goal here is to make it easy to find and estimate the costs of different services. Microsoft Saas Copilots and Copilot Studio have a subscription or license. The main cost factors for Azure AI PaaS services are model usage, data storage, and compute costs. Azure Virtual Machines (CPUs or GPUs) are the primary cost for AI models running on. For Azure services, use the individual product [pricing page](https://azure.microsoft.com/products/) and [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to develop full estimates.

*Table. Overview of Microsoft AI solutions*
| Service | AI approach supported | Access | Main cost factors |
|---------|----------------------|--------|-------------------|
| [Copilot (free)](https://copilot.microsoft.com/) | SaaS Generative AI | Free in browser or mobile app | None |
| Copilot Pro | SaaS Generative AI | Available in browser or mobile app with subscription | [Subscription](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |
| [Copilot for Microsoft 365](/copilot/microsoft-365/microsoft-365-copilot-overview) | SaaS Generative AI with RAG | Add to an existing Microsoft 365 subscription | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans) |
| [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) | PaaS generative AI with RAG via low-code platform | Browser | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |
| [Azure AI services](/azure/ai-services/what-are-ai-services) | PaaS analytical AI | Azure | Use of model endpoints consumed, storage, data transfer, compute (if custom model training) |
| Azure OpenAI | PaaS generative AI with and without RAG for OpenAI models | Azure | Use of tokens in/out and compute |
| [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) | PaaS generative AI with and without RAG, PaaS fine-tune generative AI models | Azure | Use of compute, tokens in/out, AI services consumed, storage, data transfer |
| [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) | PaaS train machine learning and generative AI models | Azure | Use of compute, storage, data transfer |
| [Virtual Machines](/azure/virtual-machines/overview) | IaaS, train any AI model | Azure | Use of compute, compute node orchestration, managed disks, storage transactions, public IPs, and other Azure services used |

## Identify your AI data

When you are training, grounding, or using AI models, you want to ensure you only send the right data to the model and abide by ethical and regulatory standards. Your data strategy should outline acceptable data use and prepare your business to use ethical, accurate, high-quality data. Evaluate the completeness, relevance, and representativeness of the data to support reliable AI outputs.

- *Protect data security and privacy.* Establish robust security measures to safeguard sensitive data in AI processes, including encryption, access controls, and anonymization. Define access controls to protect data from unauthorized use or breaches. Don’t let data boundaries blur when fed into AI systems. For example, AI workloads for all employees should only use data appropriate for all employees. Internet-facing AI workloads must only use data that’s appropriate for public use.

- *Manage the data lifecycle.* Define how data will be collected, stored, processed, and retired. Ensure compliance with data retention and disposal policies, and use version control to maintain accuracy across model updates and data changes.

- *Define acceptable use.* Provide limits around how individuals and systems interact with AI. Read the data security and privacy policies for individual products to define what data should be shared. Some services, like Azure OpenAI, allow you to elevate privacy levels above the platform default.

- *Monitor and evaluate continuously.* Set up ongoing monitoring of AI models and data pipelines to ensure data quality, performance, and fairness over time. Regularly audit data and model outputs to catch any shifts that could affect reliability or compliance.

## Identify your AI responsibility

Adopting AI responsibly is an iterative process with regular monitoring and measuring to ensure AI meets your business objectives. Microsoft follows six [Responsible AI](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) principles when developing AI systems. They govern the process of building AI workloads that are beneficial to all end users. You need to define or adopt similar principles to guide your process of managing AI workloads. Microsoft has [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) to help you map, measure, and manage the AI applications you build in accordance with Responsible AI.

- *Set up data governance and accountability.* Create a governance framework to assign responsibility for managing data quality, enforcing ethical AI practices, and ensuring proper data usage. Implement auditing processes to maintain accountability throughout AI data handling

- *Mitigate data biases.* Identify potential biases in datasets and apply strategies to reduce them. Regularly assess fairness, address imbalances, and ensure AI outputs are unbiased toward any group or demographic

- *Ensure data transparency.* Enable stakeholders to understand how data is collected, used, and processed in AI systems. Provide clear traceability of data inputs and AI decisions to foster trust and accountability

## Next step

> [!div class="nextstepaction"]
> [Create a plan to adopt AI](plan.md)

## Example AI use cases

| **Generative AI**                                      | **Non-Generative AI**                                                                 |
|--------------------------------------------------------|---------------------------------------------------------------------------------------|
| Marketing: Automatically create social media posts and email newsletters. | Prediction: Forecast trends or optimize operations based on historical data.           |
| E-commerce platforms: Generate personalized product recommendations and tailored shopping experiences. | Process automation: Automate routine tasks and workflows that don't require content generation, such as customer service bots. |
| Product design: Quickly create multiple variations of product prototypes or design elements. | Data analysis: Uncover patterns in structured data for insights and data-driven decisions. |
| Software development: Automate repetitive code generation, such as CRUD operations. | Model simulation: Simulate complex systems (fluid dynamics, finite element analysis) to predict behavior and optimize designs or processes. |
| Educational platforms: Generate personalized quizzes and study materials for students. | Anomaly detection: Identify unusual patterns in data (fraud detection, equipment failure prediction). |
| Customer service: Provide context-based responses through AI-driven chatbots. | Recommendation: Offer personalized recommendations based on user behavior, commonly used in e-commerce and streaming services. |
| Advertising agencies: Create targeted ad variations for different audience segments. | Optimization: Improve efficiency by solving complex problems (supply chain optimization, resource allocation). |
| Health and wellness apps: Generate customized workout routines and meal plans. | Sentiment analysis: Analyze text from social media or customer reviews to gauge public sentiment and enhance customer experience. |

## Example AI adoption strategy

Use this example AI adoption strategy to build your own strategy. The table is based on a fictional company, **Contoso**, that has a customer-facing ecommerce application and sales employees with a need to forecast business data. The company develops a product and needs to manage inventory for production. Their sales channels include private companies and highly-regulated public sector agencies. These agencies require a separate, custom ecommerce app to meet regulations. Here’s their AI adoption strategy.

| Goals                        | Objectives                | Opportunities                                             | Success Metrics                      | AI Approach                   | Microsoft Solution                        | Data Needs                              | Skill Needs                      | Cost Factors                           |
|------------------------------|---------------------------|-----------------------------------------------------------|--------------------------------------|--------------------------------|-------------------------------------------|-----------------------------------------|-----------------------------------|-----------------------------------------|
| Automate business process     | Improve customer satisfaction | Ecommerce web application chat feature                      | Increased customer retention rate    | PaaS, GenAI, RAG               | Azure AI Studio                            | Item descriptions and pairings           | RAG and cloud app development     | Usage                                   |
| Automate business process     | Lower costs               | Internal app document processing workflow                  | Increased completion rate            | Analytical AI, fine tune       | Azure AI services - Document Intelligence  | Standard documents                      | App development                   | Estimated usage                         |
| Automate business process     | Lower costs               | Inventory management application and product purchasing     | Shorten shelf life of inventory      | Machine learning, train model  | Azure Machine Learning                     | Historical inventory and sales data      | Machine learning and app development | Estimated usage                         |
| Enhance individual productivity | Improve employee experience | Daily work across company                                   | Increased employee satisfaction survey results | SaaS generative AI          | Copilot free and Copilot for M365          | OneDrive data                            | General IT                        | Subscription costs                      |
| Automate business process     | Increase sales            | Ecommerce application for regulated industry chat feature   | Increased sales                      | IaaS generative AI model training | Azure Virtual Machines                     | Vast training data on domain specific data | Cloud infrastructure, app dev, VM maintenance, networking | Infrastructure and software |


