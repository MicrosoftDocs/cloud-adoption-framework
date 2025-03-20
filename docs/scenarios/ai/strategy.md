---
title: AI Strategy - Process to develop an AI strategy
description: Learn the process to develop a strategy for AI adoption with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Strategy - Process to develop an AI strategy

This article outlines the process to prepare your organization for AI adoption. You learn how to select the right AI solutions, prepare your data, and ground your approach in responsible AI principles. A well-planned AI strategy aligns with your business objectives and ensures that AI projects contribute to overall success.

:::image type="content" source="./images/ai-strategy.svg" alt-text="Diagram showing the AI adoption process: AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI." lightbox="./images/ai-strategy.svg" border="false":::

## Identify AI use cases

AI enhances individual efficiency and improves business processes. Generative AI fosters productivity and enhances customer experiences. Nongenerative AI, such as machine learning, is ideal for analyzing structured data and automating repetitive tasks. With this understanding, identify areas across your business where AI could add value. For more information, see [example AI use cases](#example-ai-use-cases).

- *Look for automation opportunities.* Identify processes suitable for automation to improve efficiency and reduce operational costs. Focus on repetitive tasks, data-heavy operations, or areas with high error rates where AI can have a significant effect.

- *Conduct an internal assessment.* Gather input from various departments to identify challenges and inefficiencies that AI could address. Document workflows and gather input from stakeholders to uncover opportunities for automation, insight generation, or improved decision-making.

- *Explore industry use cases.* Research how similar organizations or industries use AI to solve problems or enhance operations. Use tools like the [AI architectures](/azure/architecture/ai-ml/) in the Azure Architecture Center for inspiration and to evaluate which approaches might suit your needs.

- *Set AI targets.* For each identified use case, clearly define the goal (general purpose), objective (desired outcome), and success metric (quantifiable measure). These elements serve as benchmarks to guide your AI adoption and measure its impact.

 For more information, see [example AI strategy](#example-ai-strategy).

## Define an AI technology strategy

An AI technology strategy focuses on selecting the most suitable tools and platforms for your generative and nongenerative AI use cases. Microsoft offers a range of options, including software-as-a-service (SaaS), platform-as-a-service (PaaS), and infrastructure-as-a-service (IaaS), each with varying levels of customization and [shared responsibility](/azure/security/fundamentals/shared-responsibility-ai) between you and Microsoft. To guide your decision, use the following AI decision tree. For each service, evaluate the skills, data, and budget required to be successful with that service. There's guidance in this article to help with this evaluation process.

:::image type="content" source="./images/ai-decision-tree.svg" alt-text="Diagram that shows Microsoft and Azure services and decision points that indicate each service." border="false":::

### Buy AI software services (SaaS)

Microsoft offers various Copilot generative AI services that enhance individual efficiency. These Copilots allow you to purchase software as a service (SaaS) for AI capabilities across your business or for specific users. SaaS products generally require minimal technical skills.

In terms of data needed, *Microsoft 365 Copilot* uses enterprise data in Microsoft Graph. You can [categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels. *Role-based Copilots* have different data-connection and plug-in options to ingest data. Most *in-product Copilots* don’t require extra data preparation. *Extending Microsoft 365 Copilot* allows you to add more data via Microsoft Graph or declarative agents that can pull from different data sources. *Copilot Studio* automates much of the data processing needed to create custom copilots for various business applications. Use the links in the following table for more information.

| Microsoft Copilots | Description | User| Data needed | Skills required | Main cost factors |
|-------|----|-----|----|-----|------|
| Microsoft 365 Copilot | Use [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) for an enterprise-wide solution that automates tasks in Microsoft 365 Copilot apps like Word, Excel, and Teams. It provides a secure way to interact with business data in Microsoft Graph.| Business| Yes | General IT and data management | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans)|
| Role-based Copilots | Use [Microsoft Copilot for Security](/copilot/security/microsoft-security-copilot) and role-based agents for Microsoft 365 to enhance productivity for specific business roles. <br><br>Role-based agents include [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business| Yes | General IT and data management | Licenses or [Security Compute Units (Copilot for Security)](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security#pricing) |
| In-product Copilots | Use Copilots to enhance productivity within Microsoft products. <br><br>Products with in-product Copilots include [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | Yes | None| Free or subscription |
| Copilot Free or Pro | Use the [free](https://copilot.microsoft.com/) version for browser-based access to Azure OpenAI models. <br><br>Use [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) for better performance and more capacity. | Individual| No| None| None for Copilot Free or [subscription for Copilot Pro](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) (extend) Microsoft 365 Copilot with more data (knowledge) via [Microsoft Graph connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) or capabilities (skills) via declarative agents. <br><br>To build declarative agents, use extensibility tools such as [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext) (SaaS development), [agent builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), [Teams toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents) in VS Code (pro-code option), and [Sharepoint](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Yes | Data management, general IT, or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build test, and deploy agents in a SaaS authoring environment. | Developer | Yes | Using a platform to connect data sources, map out prompts, and deploy copilots to various locations | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |

### Build AI workloads with Azure platforms (PaaS)

Microsoft provides various platform-as-a-service (PaaS) options for building AI workloads. The platform you choose depends on your AI goals, required skills, and data needs. Azure offers platforms suitable for different expertise levels, from beginner-friendly tools to advanced options for experienced developers and data scientists. Review the [pricing pages](https://azure.microsoft.com/products/) and use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to estimate costs.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Build RAG applications with a code-first platform | [Azure AI Foundry](/azure/ai-studio/what-is-ai-studio) <br>or<br> [Azure OpenAI](/azure/ai-services/openai/overview) | Yes | Selecting models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, engineering prompt flow, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune generative AI models | [Azure AI Foundry](/azure/ai-studio/what-is-ai-studio) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference machine learning models by using your own data | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) <br>or<br> [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume nongenerative AI models in applications | [Azure AI services](/azure/ai-services/what-are-ai-services) | Yes | Picking the right AI model, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |

### Bring your own models with infrastructure services (IaaS)

For organizations needing more control and customization, Microsoft offers infrastructure-as-a-service (IaaS) solutions. While Azure platforms (PaaS) are preferred for AI workloads, [Azure Virtual Machines through CycleCloud](./infrastructure/cycle-cloud.md) and [Azure Kubernetes Service](/azure/aks/gpu-cluster) provides access to GPUs and CPUs for advanced AI needs. This setup allows you to bring your own models to Azure. Refer to the relevant [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator).

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines](./infrastructure/cycle-cloud.md) <br>or<br>[Azure Kubernetes Service](/azure/aks/gpu-cluster) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestrator, managed disks (optional), storage services, Azure Bastion, and other Azure services used |

 For more information, see [example AI strategy](#example-ai-strategy).

## Define an AI data strategy

For each AI use case, you should define an AI data strategy. The data strategy should outline data collection, storage, and usage practices aligning with regulatory, ethical, and operational standards. Tailor the strategy to each use case to ensure reliable AI outputs and promote data security and privacy. If needed, you can consolidate these individual strategies into a broader summary data strategy for your organization.

- *Establish data governance.* Specify how you collect, store, process, version, and retire data for each AI use case. Include retention and disposal policies, and use version control to maintain accuracy during updates. 

- *Plan the data lifecycle.* Define guidelines for collecting, storing, processing, versioning, and retiring data. Include recommendations for retention and disposal policies, emphasizing version control to maintain data accuracy.

    - *Data collection:* Identify data sources such as databases, APIs, IoT devices, third-party data, or Azure Data Factory for ingestion.

    - *Data storage:* Recommend storage solutions appropriate to different types and volumes of data, including structured, unstructured, and real-time data

    - *Data process:* Use ETL (Extract, Transform, Load) or ELT pipelines to clean, transform, and prepare data. Tools such as Shortcuts or Mirroring in Microsoft Fabric can streamline these processes.

- *Set up AI fairness and bias controls.* Establish clear procedures to identify and mitigate bias in AI data. Use tools like Fairlearn to ensure models produce fair and equitable outcomes, particularly for sensitive data attributes.

- *Promote collaboration between AI and data teams.* Align AI development with data engineering efforts to ensure models are built using high-quality, well-managed data. 

- *Prepare for data scalability.* Forecast the volume, velocity, and variety of data needed for this AI workload. Choose flexible architectures capable of scaling according to demand. Consider cloud-based infrastructure to manage resources efficiently.

- *Incorporate data management automation.* Utilize AI and machine learning for tasks such as tagging, cataloging, and conducting data quality checks. Automation enhances accuracy and allows teams to focus on strategic goals.

- *Plan for continuous monitoring and evaluation.* Establish regular audits of data and model outputs to ensure ongoing data quality, performance, and fairness. Monitor AI models and data pipelines to identify any shifts that might impact reliability or compliance. Implement automated data quality checks, including anomaly detection and validation rules. Regularly monitor data pipelines for failures or inconsistencies.

## Define a responsible AI strategy

For each AI use case, you should define a responsible AI strategy that outlines your role in ensuring AI solutions remain trustworthy and beneficial for all users. Responsibilities might vary depending on the technology adopted in each case. If necessary, create a broader summary responsible AI strategy that encompasses overarching principles derived from individual use cases.

- *Establish AI accountability.* As AI technology and regulations advance, assign someone to monitor and govern these changes. It's typically a responsibility of the [AI CoE](./center-of-excellence.md) or an AI lead.

- *Align with established responsible AI principles.* Microsoft follows six [responsible AI](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) principles that adhere to the [NIST Artificial Intelligence Risk Management Framework (AI RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf). Use these principles as business goals to define success and govern your AI adoption in each use case.

- *Identify responsible AI tools.* Responsible AI tools ensure that your AI aligns with broader responsible AI practices. As part of your strategy, identify which Responsible AI [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) are relevant.

- *Understand legal and regulatory compliance requirements.* Legal and regulatory compliance influence how you build and manage AI workloads. Research and adhere to the requirements governing AI where you operate.

 For more information, see [example AI strategy](#example-ai-strategy).

## Example AI use cases

These examples highlight various generative and nongenerative AI applications. While not exhaustive, they provide insights into how AI can be applied to different areas of your business.

| AI type         | Use case                | Description                                                                                                                                                                             |
|-----------------|-------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Generative AI   | Autonomous agents       | Create AI systems. They perform tasks on their own. Virtual assistants manage schedules and customer inquiries.                                                                        |
| Generative AI   | Marketing               | Automatically create social media posts and email newsletters.                                                                                                                          |
| Generative AI   | E-commerce platforms    | Generate personalized product recommendations. They also create tailored shopping experiences.                                                                                          |
| Generative AI   | Product design          | Quickly create multiple variations of product prototypes. They also create different design elements.                                                                                   |
| Generative AI   | Software development    | Automate repetitive code generation. The system generates CRUD operations.                                                                                                               |
| Generative AI   | Educational platforms   | Generate personalized study materials. They create content for students.                                                                                                                 |
| Generative AI   | Customer service        | Provide context-based responses using AI-driven chatbots.                                                                                                                               |
| Generative AI   | Advertising agencies    | Create targeted ad variations. They address different audience segments.                                                                                                                |
| Generative AI   | Health and wellness apps| Generate customized workout routines and meal plans.                                                                                                                                   |
| Nongenerative AI| Image recognition       | Identify and classify objects in images or videos. This approach supports security systems and quality control systems.                                                                    |
| Nongenerative AI| Prediction              | Forecast trends or optimize operations based on historical data.                                                                                                                         |
| Nongenerative AI| Process automation      | Automate routine tasks and workflows. They do not need content generation. Customer service bots illustrate this approach.                                                                 |
| Nongenerative AI| Data analysis           | Uncover patterns in structured data. This process provides insights and supports data-driven decisions.                                                                                   |
| Nongenerative AI| Model simulation        | Simulate complex workloads. The method predicts behavior and optimizes designs or processes. Fluid dynamics and finite element analysis serve as examples.                               |
| Nongenerative AI| Anomaly detection       | Identify unusual patterns in data. This strategy applies to fraud detection and equipment failure prediction.                                                                             |
| Nongenerative AI| Recommendation          | Offer personalized recommendations based on user behavior. The system applies this approach in e-commerce and streaming services.                                                         |
| Nongenerative AI| Optimization            | Solve complex problems to improve efficiency. The approach optimizes supply chains and allocates resources.                                                                              |
| Nongenerative AI| Sentiment analysis      | Analyze text from social media or customer reviews to gauge public sentiment. This analysis enhances the customer experience.                                                             |

## Example AI strategy

This example AI strategy is based on a fictional company, Contoso. Contoso operates a customer-facing e-commerce platform and employs sales representatives who need tools to forecast business data. The company also manages product development and inventory for production. Its sales channels include both private companies and highly regulated public sector agencies.

| AI use case | Goals | Objectives | Success metrics | AI approach | Microsoft solution | Data needs | Skill needs | Cost factors | AI data strategy | Responsible AI strategy |
|---|---|---|---|---|---|---|---|---|---|---|
| **E-commerce web application chat feature** | Automate business process | Improve customer satisfaction | Increased customer retention rate | PaaS, generative AI, RAG | Azure AI Foundry | Item descriptions and pairings | RAG and cloud app development | Usage | Establish data governance for customer data and implement AI fairness controls. | Assign AI accountability to AI CoE and align with Responsible AI principles. |
| **Internal app document-processing workflow** | Automate business process | Reduce costs | Increased completion rate | Analytical AI, fine-tuning | Azure AI services - Document Intelligence | Standard documents | App development | Estimated usage | Define data governance for internal documents and plan data lifecycle policies. | Assign AI accountability and ensure compliance with data handling policies. |
| **Inventory management and product purchasing** | Automate business process | Reduce costs | Shorter shelf life of inventory | Machine learning, training models | Azure Machine Learning | Historical inventory and sales data | Machine learning and app development | Estimated usage | Establish governance for sales data and detect and address biases in data. | Assign AI accountability and comply with financial regulations. |
| **Daily work across company** | Enhance individual productivity | Improve employee experience | Increased employee satisfaction | SaaS generative AI | Microsoft 365 Copilot | OneDrive data | General IT | Subscription costs | Implement data governance for employee data and ensure data privacy. | Assign AI accountability and utilize built-in responsible AI features. |
| **E-commerce app for regulated industry chat feature** | Automate business process | Increase sales | Increased sales | IaaS generative AI model training | Azure Virtual Machines | Domain-specific training data | Cloud infrastructure and app development | Infrastructure and software | Define governance for regulated data and plan lifecycle with compliance measures. | Assign AI accountability and adhere to industry regulations. |

## Next step

> [!div class="nextstepaction"]
> [AI Plan](plan.md)
