---
title: AI Strategy - Process to develop an AI strategy
description: Learn the process to develop a strategy for AI adoption with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Strategy - Process to develop an AI strategy

This article outlines the process to prepare your organization for AI adoption. You learn how to select the right AI solutions, prepare your data, and ground your approach in responsible AI principles. A well-planned AI strategy aligns with your business objectives and ensures that AI projects contribute to overall success. As a first step, create an [AI center of excellence](./center-of-excellence.md) (AI CoE) or appoint an AI lead to oversee your AI adoption.

:::image type="content" source="./images/ai-strategy.svg" alt-text="Diagram showing the AI adoption process: AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI." lightbox="./images/ai-strategy.svg" border="false":::

## Identify AI use cases

AI supports two main goals: enhancing individual efficiency and improving business processes. Generative AI fosters productivity and enhances customer experiences, while nongenerative AI, such as machine learning, is ideal for analyzing structured data and automating repetitive tasks. With this understanding, identify areas across your business where AI could add value. For more information, see [example AI use cases](#example-ai-use-cases).

- *Look for automation opportunities.* Identify processes suitable for automation to improve efficiency and reduce operational costs. Focus on repetitive tasks, data-heavy operations, or areas with high error rates where AI can have a significant effect.

- *Conduct an assessment.* Gather input from various departments to identify challenges and inefficiencies that AI could address. Document current workflows to find areas where AI can automate tasks or provide insights.

- *Explore industry use cases.* Use the [AI architectures](/azure/architecture/ai-ml/) in the Azure Architecture Center for insights on problems AI can solve. Research how other businesses use AI. Stay informed about emerging AI technologies and applications relevant to your industry.

- *Set AI targets.* For each use case, define a goal (general purpose), objective (desired outcome), and success metric (quantifiable measure) to guide your AI adoption. Clear AI targets drive you toward the right AI solution and help you measure and achieve value faster.

 For more information, see [example AI strategy](#example-ai-strategy).

## Define an AI technology strategy

An AI technology strategy involves selecting the right tools and platforms for your generative and nongenerative AI use cases. You need to pick AI solutions that align with your skill set, data readiness, and budget. Microsoft has various AI solutions to align with different needs. There are software-as-a-service (SaaS), platform-as-a-service (PaaS), and infrastructure-as-a-service (IaaS) options. The service model you choose affects the [AI shared responsibility](/azure/security/fundamentals/shared-responsibility-ai) between you and Microsoft.

Use the following AI decision tree to narrow down options for each AI use case. Review all the options before making your initial decision. When you identify an AI service, confirm that the service is a good fit. Use the following guidance to validate the skills needed, data needed, and cost factors to ensure success.

:::image type="content" source="./images/ai-decision-tree.svg" alt-text="Diagram that shows Microsoft and Azure services and decision points that indicate each service." border="false":::

### Buy AI software services (SaaS)

Microsoft offers various Copilot generative AI services that enhance individual efficiency. These Copilots allow you to purchase software as a service (SaaS) for AI capabilities across your business or for specific users. SaaS products generally require minimal technical skills.

In terms of data needed, *Microsoft 365 Copilot* uses enterprise data in Microsoft Graph. You can [categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels. *Role-based Copilots* have different data-connection and plug-in options to ingest data. Most *in-product Copilots* don’t require extra data preparation. *Extending Micorosoft 365 Copilot* allows you to add more data via Microsoft Graph or declarative agents that can pull from different data sources. *Copilot Studio* automates much of the data processing needed to create custom copilots for various business applications. Use the links in the following table for more information.

| Microsoft Copilots | Description | User| Data needed | Skills required | Main cost factors |
|-------|----|-----|----|-----|------|
| Microsoft 365 Copilot | Use [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) for an enterprise-wide solution that automates work in Microsoft 365 apps and provides an enhanced-security way to chat with business data in Microsoft Graph.| Business| Yes | General IT and data management | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans)|
| Role-based Copilots | Use [Microsoft Copilot for Security](/copilot/security/microsoft-security-copilot) and role-based agents for Microsoft 365 to enhance productivity for specific business roles. <br><br>Role-based agents include [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business| Yes | General IT and data management | Licenses or [Security Compute Units (Copilot for Security)](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security#pricing) |
| In-product Copilots | Use Copilots to enhance productivity within Microsoft products. <br><br>Products with in-product Copilots include [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | Yes | None| Free or subscription |
| Copilot Free or Pro | Use the [free](https://copilot.microsoft.com/) version for browser-based access to Azure OpenAI models. <br><br>Use [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) for better performance and more capacity. | Individual| No| None| None for Copilot Free or [subscription for Copilot Pro](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) (extend) Microsoft 365 Copilot with more data (knowledge) via [Microsoft Graph connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) or capabilities (skills) via declarative agents. <br><br>To build declarative agents, use extensibility tools such as [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext) (SaaS development), [agent builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), [Teams toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents) in VS Code (pro-code option), and [Sharepoint](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Yes | Data management, general IT, or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build test, and deploy agents in a SaaS authoring environment. | Developer | Yes | Using a platform to connect data sources, map out prompts, and deploy copilots to various locations | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |
| Role-based Copilots | Use [Microsoft Copilot for Security](/copilot/security/microsoft-security-copilot) and role-based agents for Microsoft 365 to enhance productivity for specific business roles. <br><br>Role-based agents include [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business| Yes | General IT and data management | Licenses or [Security Compute Units (Copilot for Security)](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security#pricing) |
| In-product Copilots | Use Copilots to enhance productivity within Microsoft products. <br><br>Products with in-product Copilots include [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | Yes | None| Free or subscription |
| Copilot Free or Pro | Use the [free](https://copilot.microsoft.com/) version for browser-based access to Azure OpenAI models. <br><br>Use [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) for better performance and more capacity. | Individual| No| None| None for Copilot Free or [subscription for Copilot Pro](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) (extend) Microsoft 365 Copilot with additional data (knowledge) via [Microsoft Graph connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) or capabilities (skills) via declarative agents. <br><br>To build declarative agents, use extensibility tools such as [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext) (SaaS development), [agent builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), [Teams toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents) in VS Code (pro-code option), and [Sharepoint](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Yes | Data management, general IT or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build test, and deploy agents in an authoring environment. | Developer | Yes | Using a platform to connect data sources, map out prompts, and deploy copilots to various locations | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |

### Build AI workloads with Azure AI platforms (PaaS)

Microsoft provides various platform-as-a-service (PaaS) options for building AI workloads. The platform you choose depends on your AI goals, required skills, and data needs. Azure offers platforms suitable for different expertise levels, from beginner-friendly tools to advanced options for experienced developers and data scientists. Review the [pricing pages](https://azure.microsoft.com/products/) and use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to estimate casts.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Build RAG applications with a code-first platform | [Azure AI Foundry](/azure/ai-studio/what-is-ai-studio) <br>or<br> [Azure OpenAI](/azure/ai-services/openai/overview) | Yes | Selecting models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, engineering prompt flow, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune generative AI models | [Azure AI Foundry](/azure/ai-studio/what-is-ai-studio) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference machine learning models by using your own data | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) <br>or<br> [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume nongenerative AI models in applications | [Azure AI services](/azure/ai-services/what-are-ai-services) | Yes | Picking the right AI model, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |

### Bring your own models with infrastructure services (IaaS)

For organizations needing more control and customization, Microsoft offers infrastructure-as-a-service (IaaS) solutions. While Azure AI platforms (PaaS) are preferred for AI workloads, [Azure Virtual Machines through CycleCloud](./infrastructure/cycle-cloud.md) and [Azure Kubernetes Service](/azure/aks/gpu-cluster) provides access to GPUs and CPUs for advanced AI needs. This setup allows you to bring your own models to Azure. Refer to the relevant [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator).

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines](./infrastructure/cycle-cloud.md) <br>or<br>[Azure Kubernetes Service](/azure/aks/gpu-cluster) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestrator, managed disks (optional), storage services, Azure Bastion, and other Azure services used |

 For more information, see [example AI strategy](#example-ai-strategy).

## Define an AI data strategy

For each AI use case, you should define an AI data strategy that outlines data collection, storage, and usage practices aligning with regulatory, ethical, and operational standards. Tailoring the strategy to each specific use case ensures reliable AI outputs and promotes data security and privacy. If needed, you can consolidate these individual strategies into a broader summary data strategy for your organization.

- *Establish data governance.* Define data governance principles specific to the AI use case to ensure workloads are transparent, accountable, and compliant with legal and ethical standards. Include categorization of data based on sensitivity and policies to control access, usage, and storage relevant to the use case.

- *Plan the data lifecycle.* Specify how you collect, store, process, and retire data for this particular AI use case. Include retention and disposal policies, and use version control to maintain accuracy during updates.

- *Set up AI fairness and bias controls.* Develop processes to detect and address bias in the data used for this AI use case. Use tools like Fairlearn to ensure models provide fair and equitable outcomes, especially when working with sensitive data attributes.

- *Promote collaboration between AI and data teams.* Align AI development with data engineering efforts to ensure models are built using high-quality, well-managed data. Establish a unified pipeline for AI model training and data updates.

- *Prepare for data scalability.* Forecast the volume, velocity, and variety of data needed for this AI workload. Use flexible architectures to scale with demand and consider cloud-based infrastructures for efficient resource management.

- *Incorporate data management automation.* Plan to use AI and machine learning to automate tasks like tagging, cataloging, and data quality checks. Automation improves accuracy and allows teams to focus on strategic efforts.

- *Plan for continuous monitoring and evaluation.* Establish regular audits of data and model outputs to ensure ongoing data quality, performance, and fairness. Monitor AI models and data pipelines to identify any shifts that might impact reliability or compliance.

 For more information, see [example AI strategy](#example-ai-strategy).

## Define a responsible AI strategy

For each AI use case, you should define a responsible AI strategy that outlines your role in ensuring AI solutions remain trustworthy and beneficial for all users. Responsibilities might vary depending on the technology adopted in each case. If necessary, create a broader summary responsible AI strategy that encompasses overarching principles derived from individual use cases.

- *Establish AI accountability.* As AI technology and regulations advance, assign someone to monitor and govern these changes. It's typically a responsibility of the [AI CoE](./center-of-excellence.md) or an AI lead.

- *Align with established responsible AI principles.* Microsoft follows six [responsible AI](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) principles that adhere to the [NIST Artificial Intelligence Risk Management Framework (AI RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf). Use these principles as business goals to define success and govern your AI adoption in each use case.

- *Identify responsible AI tools.* Responsible AI tools ensure that your AI aligns with broader responsible AI practices. As part of your strategy, identify which Responsible AI [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) are relevant.

- *Understand legal and regulatory compliance requirements.* Legal and regulatory compliance influence how you build and manage AI workloads. Research and adhere to the requirements governing AI where you operate.

 For more information, see [example AI strategy](#example-ai-strategy).

## Next step

> [!div class="nextstepaction"]
> [AI Plan](plan.md)

### Example AI use cases

These examples highlight various generative and nongenerative AI applications. While not exhaustive, they provide insights into how AI can be applied to different areas of your business.

| Generative AI| Nongenerative AI |
| --- | ---|
| Autonomous agents: Develop AI systems that perform tasks independently, such as virtual assistants managing schedules or customer inquiries.| Image recognition: Utilize AI to identify and classify objects within images or videos, useful in security or quality control systems.|
| Marketing: Automatically create social media posts and email newsletters. | Prediction: Forecast trends or optimize operations based on historical data. |
| E-commerce platforms: Generate personalized product recommendations and tailored shopping experiences. | Process automation: Automate routine tasks and workflows that don't require content generation, such as customer service bots. |
| Product design: Quickly create multiple variations of product prototypes or design elements. | Data analysis: Uncover patterns in structured data for insights and data-driven decisions. |
| Software development: Automate repetitive code generation, such as CRUD operations. | Model simulation: Simulate complex workloads (fluid dynamics, finite element analysis) to predict behavior and optimize designs or processes. |
| Educational platforms: Generate personalized study materials for students. | Anomaly detection: Identify unusual patterns in data. You can use this strategy for fraud detection or equipment failure prediction, for example. |
| Customer service: Provide context-based responses through AI-driven chatbots. | Recommendation: Offer personalized recommendations based on user behavior, commonly used in e-commerce and streaming services. |
| Advertising agencies: Create targeted ad variations for different audience segments. | Optimization: Improve efficiency by solving complex problems (supply chain optimization, resource allocation). |
| Health and wellness apps: Generate customized workout routines and meal plans. | Sentiment analysis: Analyze text from social media or customer reviews to gauge public sentiment and enhance the customer experience. |

### Example AI strategy

This example AI strategy is based on a fictional company, Contoso. Contoso operates a customer-facing e-commerce platform and employs sales representatives who need tools to forecast business data. The company also manages product development and inventory for production. Its sales channels include both private companies and highly regulated public sector agencies.

| AI use case | Goals | Objectives | Success metrics | AI approach | Microsoft solution | Data needs | Skill needs | Cost factors | AI data strategy | Responsible AI strategy |
|---|---|---|---|---|---|---|---|---|---|---|
| **E-commerce web application chat feature** | Automate business process | Improve customer satisfaction | Increased customer retention rate | PaaS, generative AI, RAG | Azure AI Foundry | Item descriptions and pairings | RAG and cloud app development | Usage | Establish data governance for customer data and implement AI fairness controls. | Assign AI accountability to AI CoE and align with Responsible AI principles. |
| **Internal app document-processing workflow** | Automate business process | Reduce costs | Increased completion rate | Analytical AI, fine-tuning | Azure AI services - Document Intelligence | Standard documents | App development | Estimated usage | Define data governance for internal documents and plan data lifecycle policies. | Assign AI accountability and ensure compliance with data handling policies. |
| **Inventory management and product purchasing** | Automate business process | Reduce costs | Shorter shelf life of inventory | Machine learning, training models | Azure Machine Learning | Historical inventory and sales data | Machine learning and app development | Estimated usage | Establish governance for sales data and detect and address biases in data. | Assign AI accountability and comply with financial regulations. |
| **Daily work across company** | Enhance individual productivity | Improve employee experience | Increased employee satisfaction | SaaS generative AI | Microsoft 365 Copilot | OneDrive data | General IT | Subscription costs | Implement data governance for employee data and ensure data privacy. | Assign AI accountability and utilize built-in responsible AI features. |
| **E-commerce app for regulated industry chat feature** | Automate business process | Increase sales | Increased sales | IaaS generative AI model training | Azure Virtual Machines | Domain-specific training data | Cloud infrastructure and app development | Infrastructure and software | Define governance for regulated data and plan lifecycle with compliance measures. | Assign AI accountability and adhere to industry regulations. |
