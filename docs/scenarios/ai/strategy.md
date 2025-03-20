---
title: AI Strategy - Process to develop an AI strategy
description: Learn the process to develop a strategy for AI adoption with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2025
ms.topic: conceptual
---

# AI Strategy - Process to develop an AI strategy

This article outlines the process to prepare your organization for AI adoption. You learn how to select the right AI solutions, prepare your data, and ground your approach in responsible AI principles. A well-planned AI strategy aligns with your business objectives and ensures that AI projects contribute to overall success.

:::image type="content" source="./images/ai-strategy.svg" alt-text="Diagram showing the AI adoption process: AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI." lightbox="./images/ai-strategy.svg" border="false":::

## Identify AI use cases

AI enhances individual efficiency and improves business processes. Generative AI fosters productivity and enhances customer experiences. Nongenerative AI, such as machine learning, is ideal for analyzing structured data and automating repetitive tasks. With this understanding, identify areas across your business where AI could add value. For more information, see [generative AI use cases](#generative-ai-use-cases) and [nongenerative AI use cases](#nongenerative-ai-use-cases).

- *Look for automation opportunities.* Identify processes suitable for automation to improve efficiency and reduce operational costs. Focus on repetitive tasks, data-heavy operations, or areas with high error rates where AI can have a significant effect.

- *Gather customer feedback.* Use customer feedback to uncover use cases that would have an impact on customer satisfaction when automated with AI.

- *Conduct an internal assessment.* Gather input from various departments to identify challenges and inefficiencies that AI could address. Document workflows and gather input from stakeholders to uncover opportunities for automation, insight generation, or improved decision-making.

- *Explore industry use cases.* Research how similar organizations or industries use AI to solve problems or enhance operations. Use tools like the [AI architectures](/azure/architecture/ai-ml/) in the Azure Architecture Center for inspiration and to evaluate which approaches might suit your needs.

- *Set AI targets.* For each identified use case, clearly define the goal (general purpose), objective (desired outcome), and success metric (quantifiable measure). These elements will serve as benchmarks to guide your AI adoption and measure its impact. For more information, see [example AI strategy](#example-ai-strategy).

## Define an AI technology strategy

Select AI technologies that align closely with your organization's skills, available data, and budget. Microsoft offers software-as-a-service (SaaS), platform-as-a-service (PaaS), and infrastructure-as-a-service (IaaS). These services provide different levels of customization and [shared responsibility](/azure/security/fundamentals/shared-responsibility-ai). To guide your decision, use the following AI decision tree and guidance.

:::image type="content" source="./images/ai-decision-tree.svg" alt-text="Diagram that shows Microsoft and Azure services and decision points that indicate each service." border="false":::

### Buy AI with software services (SaaS)

Microsoft provides SaaS generative AI solutions known as Copilots, designed to enhance productivity with minimal technical expertise required. Refer to the detailed table below for more information.

| Microsoft Copilots | Description | User| Data needed | Skills required | Main cost factors |
|-------|----|-----|----|-----|------|
| Microsoft 365 Copilot | Use [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) for an enterprise-wide solution that automates tasks in Microsoft 365 Copilot apps like Word, Excel, and Teams. | Business| Yes. [Categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels and securely interact with your data in Microsoft Graph. | General IT and data management | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans)|
| Role-based Copilots | Use [Microsoft Copilot for Security](/copilot/security/microsoft-security-copilot) and role-based agents to enhance productivity for specific business roles. <br><br>Role-based agents include [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business| Yes. There are different data-connection and plug-in options to ingest data. | General IT and data management | Licenses or [Security Compute Units (Copilot for Security)](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security#pricing) |
| In-product Copilots | Use Copilots to enhance productivity within Microsoft products. <br><br>Products with in-product Copilots include [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | Yes. Most don’t require extra data preparation. | None| Free or subscription |
| Copilot Free or Pro | Use the [free](https://copilot.microsoft.com/) version for browser-based access to Azure OpenAI models. <br><br>Use [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) for better performance and more capacity. | Individual| No| None| None for Copilot Free or [subscription for Copilot Pro](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) (extend) Microsoft 365 Copilot with more data (knowledge) or capabilities (skills) via declarative agents. <br><br>To build declarative agents, use extensibility tools such as [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext) (SaaS development), [agent builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), [Teams toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents) in VS Code (pro-code option), and [Sharepoint](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Yes. Use [Microsoft Graph connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) to add data to Microsoft 365 Copilot. | Data management, general IT, or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build test, and deploy agents in a SaaS authoring environment.| Developer | Yes. Copilot Studio automates much of the data work to create custom copilots for various business applications.  | Using a platform to connect data sources, map out prompts, and deploy copilots to various locations | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |

### Build AI workloads with Azure platforms (PaaS)

Azure provides multiple PaaS options tailored to your AI goals, skill sets, and data needs. These platforms cater to various levels of technical expertise. Review the [pricing pages](https://azure.microsoft.com/products/) and use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) for cost estimates..

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Build RAG applications with a code-first platform | [Azure AI Foundry](/azure/ai-studio/what-is-ai-studio) <br>or<br> [Azure OpenAI](/azure/ai-services/openai/overview) | Yes | Selecting models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, engineering prompt flow, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune generative AI models | [Azure AI Foundry](/azure/ai-studio/what-is-ai-studio) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference machine learning models by using your own data | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) <br>or<br> [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume nongenerative AI models in applications | [Azure AI services](/azure/ai-services/what-are-ai-services) | Yes | Picking the right AI model, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |
| Isolated generative AI apps | [Azure Container Apps](/azure/container-apps/gpu-serverless-overview) | Yes | Selecting models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, engineering prompt flow, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |

### Bring AI models with infrastructure services (IaaS)

For greater customization and control, use Azure's IaaS solutions such as [Azure Virtual Machines through CycleCloud](./infrastructure/cycle-cloud.md) and [Azure Kubernetes Service](/azure/aks/gpu-cluster). These solutions enable training and deployment of custom AI models. Refer to the relevant [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator).

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines](./infrastructure/cycle-cloud.md) <br>or<br>[Azure Kubernetes Service](/azure/aks/gpu-cluster) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestrator, managed disks (optional), storage services, Azure Bastion, and other Azure services used |

## Define an AI data strategy

Create a data strategy tailored to your AI use cases. Identify acceptable data sources, workload types (internal vs. external), and implement guidelines ensuring the responsible use of AI. Follow these steps:

- *Establish data governance.* Restrict internet-facing ("Online") workloads to public data only. Allow internal ("Corporate") workloads to utilize business data while maintaining defined data access boundaries. Use [Microsoft Purview](/purview/data-governance-overview) to govern data. Reference the [Data management landing zone](/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/data-management-landing-zone) for architecture guidance.

- *Prepare for data scalability.* Anticipate the volume, velocity, and variety of data required. Choose flexible architectures capable of scaling according to demand. For an architecture, see [Data landing zone](/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/data-landing-zone).

- *Plan the data lifecycle.* Develop clear guidelines for managing data throughout its lifecycle:

  - *Data collection:* Identify data sources such as databases, APIs, IoT devices, third-party data, or Azure Data Factory for ingestion. Maintain [data lineage](/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/govern-lineage) with [Microsoft Fabric](/fabric/governance/lineage) or [Microsoft Purview](/purview/concept-data-lineage).
  
  - *Data storage:* Recommend storage solutions aligned with data type and scale, including structured, unstructured, and real-time scenarios.
  
  - *Data processing:* Use ETL (Extract, Transform, Load) or ELT pipelines to ensure data quality and readiness. Utilize tools like [One Lake shortcuts](/fabric/onelake/onelake-shortcuts) or [Mirroring](/fabric/database/mirrored-database/overview) in Microsoft Fabric.
  
  - - *Data auditing.* Implement regular audits to identify and mitigate bias within AI datasets. Use tools in the [Responsible AI Dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) to analyze and audit data and model outputs.

## Define a responsible AI strategy

Understand your responsibilities in ensuring AI solutions remain trustworthy, ethical, and beneficial to all users. Responsibilities differ based on the specific AI technologies you use.

- *Establish AI accountability.* Assign a dedicated individual or team to monitor, manage, and respond to changes in AI technology and regulatory requirements.

- *Use responsible AI principles.* Adopt Microsoft's six [responsible AI](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) principles, which align with the [NIST AI Risk Management Framework (RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf). Use these principles as business objectives.

- *Identify responsible AI tools.* Select and apply appropriate Responsible AI [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) are relevant. These tools help ensure your AI initiatives align with responsible AI standards.

- *Understand compliance.* Legal and regulatory obligations shape AI project implementation. Identify, understand, and comply with relevant local and international AI regulations and legal standards that apply to your operations.

## Example AI strategy

This example AI strategy is based on a fictional company, Contoso. Contoso operates a customer-facing e-commerce platform and employs sales representatives who need tools to forecast business data. The company also manages product development and inventory for production. Its sales channels include both private companies and highly regulated public sector agencies.

| AI use case | Goals | Objectives | Success metrics | AI approach | Microsoft solution | Data needs | Skill needs | Cost factors | AI data strategy | Responsible AI strategy |
|---|---|---|---|---|---|---|---|---|---|---|
| **E-commerce web application chat feature** | Automate business process | Improve customer satisfaction | Increased customer retention rate | PaaS, generative AI, RAG | Azure AI Foundry | Item descriptions and pairings | RAG and cloud app development | Usage | Establish data governance for customer data and implement AI fairness controls. | Assign AI accountability to AI CoE and align with Responsible AI principles. |
| **Internal app document-processing workflow** | Automate business process | Reduce costs | Increased completion rate | Analytical AI, fine-tuning | Azure AI services - Document Intelligence | Standard documents | App development | Estimated usage | Define data governance for internal documents and plan data lifecycle policies. | Assign AI accountability and ensure compliance with data handling policies. |
| **Inventory management and product purchasing** | Automate business process | Reduce costs | Shorter shelf life of inventory | Machine learning, training models | Azure Machine Learning | Historical inventory and sales data | Machine learning and app development | Estimated usage | Establish governance for sales data and detect and address biases in data. | Assign AI accountability and comply with financial regulations. |
| **Daily work across company** | Enhance individual productivity | Improve employee experience | Increased employee satisfaction | SaaS generative AI | Microsoft 365 Copilot | OneDrive data | General IT | Subscription costs | Implement data governance for employee data and ensure data privacy. | Assign AI accountability and utilize built-in responsible AI features. |
| **E-commerce app for regulated industry chat feature** | Automate business process | Increase sales | Increased sales | IaaS generative AI model training | Azure Virtual Machines | Domain-specific training data | Cloud infrastructure and app development | Infrastructure and software | Define governance for regulated data and plan lifecycle with compliance measures. | Assign AI accountability and adhere to industry regulations. |

### Generative AI use cases

| Example use case  | Description  |
|-----|-----|
| Autonomous agents       | Create AI systems. They perform tasks on their own. Virtual assistants manage schedules and customer inquiries.  |
| Marketing               | Automatically create social media posts and email newsletters.  |
| E-commerce platforms    | Generate personalized product recommendations. They also create tailored shopping experiences.    |
| Product design          | Quickly create multiple variations of product prototypes. They also create different design elements.  |
| Software development    | Automate repetitive code generation. The system generates CRUD operations.  |
| Educational platforms   | Generate personalized study materials. They create content for students.   |
| Customer service        | Provide context-based responses using AI-driven chatbots.   |
| Advertising agencies    | Create targeted ad variations. They address different audience segments. |
| Health and wellness apps| Generate customized workout routines and meal plans.  |

### Nongenerative AI Use Cases

| Example use case   | Description |
|--------------------|------------------|
| Image recognition  | Identify and classify objects in images or videos. This approach supports security systems and quality control systems. |
| Prediction         | Forecast trends or optimize operations based on historical data. |
| Process automation | Automate routine tasks and workflows. They do not need content generation. Customer service bots illustrate this approach.      |
| Data analysis      | Uncover patterns in structured data. This process provides insights and supports data-driven decisions.   |
| Model simulation   | Simulate complex workloads. The method predicts behavior and optimizes designs or processes. Fluid dynamics and finite element analysis serve as examples. |
| Anomaly detection  | Identify unusual patterns in data. This strategy applies to fraud detection and equipment failure prediction.  |
| Recommendation     | Offer personalized recommendations based on user behavior. The system applies this approach in e-commerce and streaming services.  |
| Optimization       | Solve complex problems to improve efficiency. The approach optimizes supply chains and allocates resources.     |
| Sentiment analysis | Analyze text from social media or customer reviews to gauge public sentiment. This analysis enhances the customer experience. |

## Next step

> [!div class="nextstepaction"]
> [AI Plan](plan.md)
