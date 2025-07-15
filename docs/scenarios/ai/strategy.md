---
title: AI strategy
description: Learn the process to develop a strategy for AI adoption with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# AI strategy

This article explains the process to prepare your organization for AI adoption. It describes how to select the right AI solutions, prepare your data, and ground your approach in responsible AI principles. A well-planned AI strategy aligns with your business objectives and ensures that AI projects contribute to overall success.

## Identify AI use cases

AI improves individual efficiency and enhances business processes. Generative AI increases productivity and improves customer experiences. Nongenerative AI, such as machine learning, analyzes structured data and automates repetitive tasks. Use this understanding to identify areas across your business where AI adds value.

1. **Identify automation opportunities.** Focus on processes suitable for automation to improve efficiency and reduce operational costs. Target repetitive tasks, data-heavy operations, or areas with high error rates where AI can have a significant impact.

2. **Gather customer feedback.** Use customer feedback to uncover use cases that improve customer satisfaction when automated with AI. This feedback helps prioritize impactful AI initiatives.

3. **Conduct an internal assessment.** Collect input from various departments to identify challenges and inefficiencies that AI can address. Document workflows and gather stakeholder input to uncover opportunities for automation, insight generation, or improved decision-making.

4. **Research industry use cases.** Investigate how similar organizations or industries use AI to solve problems or enhance operations. Use tools like the [AI architectures](/azure/architecture/ai-ml/) in the Azure Architecture Center for inspiration and to evaluate suitable approaches.

5. **Define AI targets.** For each identified use case, define the goal (general purpose), objective (desired outcome), and success metric (quantifiable measure). These benchmarks guide your AI adoption and measure success. For more information, see [example AI strategy](#example-ai-strategy).

## Define an AI technology strategy

Technology strategy determines the right approach for your organization's capabilities, data assets, and budget requirements. This strategy prepares your organization for agent-based architectures that enable multiple AI systems to collaborate on complex tasks. You must evaluate technology options across three service models to select the most suitable approach for your needs.

1. **Understand AI agents.** AI agents are autonomous systems that use AI models to complete tasks without constant human oversight. These systems represent a shift from traditional automation to intelligent decision-making that adapts to changing conditions. You must plan for agent integration to support complex workflows and multi-system collaboration. Review [What are agents?](/azure/ai-foundry/agents/overview#what-is-an-ai-agent) to understand agent capabilities and prepare your organization for agent-based solutions.

2. **Adopt standard mechanisms for AI interoperability.** Standard protocols enable AI systems to communicate across different platforms and reduce custom implementations. These protocols support data sharing and system integration while maintaining flexibility for future technology changes. You should understand protocols like Model Context Protocol for cross-system data ingestion to ensure your AI systems support interoperability requirements. Evaluate tools like [NLWeb](https://github.com/microsoft/NLWeb?tab=readme-ov-file#what-is-nlweb) to prepare your content for the AI web. For example, see [Model Context Protocol in Microsoft Copilot Studio](/microsoft-copilot-studio/agent-extend-action-mcp#create-an-mcp-server) and [Exposing REST APIs as MCP servers](/azure/api-management/export-rest-mcp-server).

3. **Select the appropriate AI service model.** Microsoft offers three service models with varying levels of customization and [shared responsibility](/azure/security/fundamentals/shared-responsibility-ai): Software as a Service (SaaS), Platform as a Service (PaaS), and Infrastructure as a Service (IaaS). Each model requires different technical skills and provides different degrees of control over AI implementation. You must match your team's capabilities, data requirements, and customization needs with the appropriate service model. Use the AI decision tree below to guide your selection process.

:::image type="complex" source="./images/ai-decision-tree.svg" alt-text="Diagram showing Microsoft and Azure services with decision points for each service." lightbox="./images/ai-decision-tree.svg" border="false":::
    Start by identifying your AI use case. If the goal is to enhance individual productivity, use Microsoft 365 Copilot when focusing on Microsoft 365 apps. Use in-product Copilots for products like Azure, GitHub, Fabric, Dynamics 365, or Power Platform. Use role-aligned Copilots for domain-specific roles such as security, sales, service, or finance. If the use case is more general, use Microsoft Copilot or Copilot Pro. If you already use Microsoft 365 Copilot and need to create custom agents with domain-specific skills, use Extensibility Tools for Microsoft 365 Copilot. If the goal is to automate business functionality, use Copilot Studio for a SaaS tool that enables agent creation and deployment through natural language with integrated pricing. Use Azure AI Foundry for a full development platform with API access to both Azure OpenAI and Azure AI services. If you only need access to OpenAI models, use Azure OpenAI. If you need prebuilt non-generative models or Azure AI Search for agent support, use Azure AI services. If you need to train and deploy machine learning models with your own data, use Microsoft Fabric if you already work in that environment; otherwise, use Azure Machine Learning. Use Azure Container Apps for lightweight AI inferencing without managing GPU infrastructure. If you need to bring your own models and orchestrate them with Azure CycleCloud, Azure Batch, or Kubernetes, use Azure Virtual Machines.
:::image-end:::

### Buy AI with software services (SaaS)

Microsoft provides SaaS generative AI solutions, known as Copilots, to enhance productivity with minimal technical expertise. Refer to the table below for details.

| Microsoft Copilots | Description | User | Data needed | Skills required | Main cost factors |
|---------------------|-------------|------|-------------|-----------------|-------------------|
| Microsoft 365 Copilot | [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) provides web-based (internet) and work-based (Microsoft Graph) chat and in-app AI for Microsoft 365 apps. | Business | Yes. [Categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels and securely interact with your data in Microsoft Graph. | General IT and data management | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans) |
| Role-based Copilots | Agents that enhance efficiency for specific roles in [Security](/copilot/security/microsoft-security-copilot), [Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business | Yes. Data-connection and plug-in options are available. | General IT and data management | Licenses or [Security Compute Units (Copilot for Security)](https://azure.microsoft.com/pricing/details/microsoft-security-copilot) |
| In-product Copilots | AI within products like [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), [Microsoft Fabric](/fabric/fundamentals/copilot-fabric-overview), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | Yes. Most require minimal data preparation. | None | Free or subscription |
| Microsoft Copilot or Microsoft Copilot Pro | [Microsoft Copilot](https://copilot.microsoft.com/) is a free web-grounded chat application. [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) provides better performance, capacity, and access to Copilot in certain Microsoft 365 apps. | Individual | No | None | [Microsoft Copilot](https://copilot.microsoft.com/) is free. Microsoft Copilot Pro requires a [subscription](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) Microsoft 365 Copilot with more data or capabilities via declarative agents. Use tools like [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext), [agent builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), [Teams toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents), and [SharePoint](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Use [Microsoft Graph connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) to add data. | Data management, general IT, or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build, test, and deploy agents in a SaaS authoring environment. | Developer | Automates much of the data work to create custom copilots. | Platform to connect data sources, map prompts, and deploy copilots | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |

### Build AI workloads with Azure platforms (PaaS)

Azure provides multiple PaaS options tailored to your AI goals, skill set, and data needs. These platforms cater to various levels of technical expertise. Review the [pricing pages](https://azure.microsoft.com/products/) for each Azure service, and use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to develop cost estimates.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Build agents | Azure AI Foundry [Agent Service](/azure/ai-services/agents/overview) | Yes | [Environment setup](/azure/ai-services/agents/environment-setup), model selection, [tooling](/azure/ai-services/agents/how-to/tools/overview), grounding data storage, data isolation, [agent triggering](/azure/ai-services/agents/how-to/triggers), [connect agents](/azure/ai-services/agents/how-to/connected-agents?pivots=portal), [content filtering](/azure/ai-services/openai/how-to/content-filters?context=%2Fazure%2Fai-services%2Fagents%2Fcontext%2Fcontext), [private networking](/azure/ai-services/agents/how-to/virtual-networks), [agent monitoring](/azure/ai-services/agents/concepts/tracing), [service monitoring](/azure/ai-services/agents/how-to/metrics) | Consuming model tokens, storage, features, compute, grounding connections |
| Build RAG applications | [Azure AI Foundry](/azure/ai-foundry/concepts/retrieval-augmented-generation) | Yes | [Select models](/azure/ai-foundry/concepts/foundry-models-overview), orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune GenAI models | [Azure AI Foundry](/azure/ai-foundry/concepts/fine-tuning-overview) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference models | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) <br>or<br> [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume prebuilt AI models and services | [Azure AI services](/azure/ai-services/what-are-ai-services?context=%2Fazure%2Fai-foundry%2Fcontext%2Fcontext) and/or<br>[Azure OpenAI](/azure/ai-services/openai/overview)| Yes | Select AI models, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |
| Isolate AI apps | [Azure Container Apps](/azure/container-apps/gpu-serverless-overview) | Yes | Select AI models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |

### Bring AI models with infrastructure services (IaaS)

For greater customization and control, use Azure's IaaS solutions such as [Azure Virtual Machines through CycleCloud](./infrastructure/cycle-cloud.md) and [Azure Kubernetes Service](/azure/aks/gpu-cluster). These solutions enable training and deployment of custom AI models. Refer to the relevant [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator).

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines](./infrastructure/cycle-cloud.md) <br>or<br>[Azure Kubernetes Service](/azure/aks/gpu-cluster) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestrator, managed disks (optional), storage services, Azure Bastion, and other Azure services used |

## Develop an AI data strategy

Data strategy defines how you collect, manage, and use data for AI initiatives. This strategy ensures data assets support your AI use cases while maintaining security and compliance. You must establish governance frameworks, assess scalability needs, design lifecycle management, and implement responsible data practices.

1. **Establish data governance frameworks for AI workloads.** Data governance provides secure and compliant AI data usage through access controls and responsible use policies. Governance frameworks define requirements for different AI use cases and establish ongoing data management processes. You must define data classification schemes based on sensitivity and exposure levels. Use data security and compliance protections for generative AI apps in [Microsoft Purview](/purview/ai-microsoft-purview).

2. **Assess scalability requirements for AI data needs.** Scalability assessment ensures your data infrastructure handles current and future AI workload demands without performance issues or cost overruns. This assessment identifies volume, velocity, and variety requirements that guide technology selection. You must document current data volumes, processing frequencies, and data types for each AI use case.

3. **Design data lifecycle management for AI assets.** Lifecycle management keeps data accessible, secure, and cost-effective from collection to disposal while supporting AI requirements. This approach addresses collection strategies, storage optimization, and quality assurance processes. You must plan systematic data collection from databases, APIs, IoT devices, and third-party providers. Design storage strategies with appropriate tiers based on access patterns and retention needs. Establish ETL/ELT pipelines for data quality and use the [Responsible AI Dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) to identify and mitigate dataset bias.

4. **Implement responsible data practices for AI development.** Responsible practices ensure AI systems use data ethically and maintain regulatory compliance. These practices guide data collection, usage, and retention decisions throughout the AI lifecycle. You must implement data lineage tracking using [Microsoft Fabric](/fabric/governance/lineage) or [Microsoft Purview](/purview/concept-data-lineage) for transparency. Establish data quality standards, bias detection, and fairness considerations in training datasets. Define retention and disposal policies that balance AI performance with privacy and compliance requirements.

## Develop a responsible AI strategy

Responsible AI strategy ensures AI solutions remain trustworthy and ethical. This strategy establishes frameworks for ethical AI development that align with business objectives. You must establish accountability, define principles, select tools, and assess compliance to create a responsible AI strategy.

1. **Assign AI accountability to designated teams.** Accountability structures provide ownership for AI governance decisions and ensure responsive management of regulatory requirements. These structures define roles and decision-making authority for AI initiatives. You must assign individuals or teams to monitor AI technology changes and regulatory requirements. [Create an AI cloud center of excellence](./center-of-excellence.md) to centralize responsibilities and establish escalation procedures.

2. **Adopt responsible AI principles as business objectives.** Responsible AI principles provide the framework for ethical AI development that guides decision-making and aligns with industry standards. These principles become business objectives that shape AI project selection and development. You must adopt Microsoft's six [responsible AI principles](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy), which align with the [NIST AI Risk Management Framework (RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf). Integrate these principles into project planning, development processes, and success metrics.

3. **Select responsible AI tools for your AI portfolio.** Tool selection ensures appropriate mechanisms for ethical AI principles and maintains consistent application of responsible AI standards. Tool selection addresses integration approaches and operational processes. You must assess and select appropriate Responsible AI [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) that align with your AI use cases and risk profiles. Integrate these tools within development workflows to ensure consistent application.

4. **Identify compliance requirements for AI regulations.** Compliance assessment protects the organization from legal risks and ensures AI initiatives align with applicable laws and industry standards. Compliance requirements vary by industry, geography, and AI application. You must identify relevant local and international AI regulations that apply to your operations and AI use cases. Monitor regulatory changes and update compliance strategies to ensure ongoing alignment throughout your AI adoption journey.

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
