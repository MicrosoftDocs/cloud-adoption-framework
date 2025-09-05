---
title: Create your AI strategy
description: Learn how to create an effective AI adoption strategy using Microsoft AI technologies, data governance, and responsible AI practices for measurable business outcomes.
author: stephen-sumner
ms.author: ssumner
ms.date: 09/05/2025
ms.topic: conceptual
---

# Create your AI strategy

A successful AI strategy requires structured planning in four core areas. Identify **AI use cases** that deliver measurable business value, select **Microsoft AI technologies** that align to your team's skills, establish scalable **data governance**, and implement **responsible AI practices** that preserve trust and meet regulatory requirements. It applies to organizations of all sizes, including startups, small and medium businesses, large enterprises, nonprofits, and public sector institutions.

**Quick link:** [Microsoft AI decision tree](#microsoft-ai-decision-tree)

:::image type="content" source="./images/ai-strategy.svg" alt-text="Diagram that shows the 6 phases of AI adoption: Strategy, Plan, Ready, Govern, Secure, Manage." lightbox="./images/ai-strategy.svg" border="false":::

**Why strategic AI planning matters**: A documented AI strategy produces consistent, faster, auditable outcomes compared to ad-hoc experimentation. This guide lists actionable steps for Microsoft Copilot deployment, Azure AI Foundry environment setup, AI agent adoption, Azure OpenAI integration, and organization-wide AI governance with Microsoft Purview.

## Identify AI use cases for maximum business impact

AI transforms business operations by accelerating knowledge work and automating routine processes. **Generative AI** (systems that create content such as text, images, or code) increases knowledge worker productivity. **Analytical AI and machine learning** automate data-heavy tasks, reduce error rates, and produce predictive insights. Start by isolating processes with measurable friction where AI improves cost, speed, quality, or customer experience.

**Focus on business outcomes first**: Successful AI programs anchor each use case to a quantified business objective, not a model-first experiment. Structured discovery methods correlate with higher operationalization success rates, as reinforced by the [Azure Architecture Center AI guidance](/azure/architecture/ai-ml/).

1. **Identify automation opportunities.** Focus on processes suitable for automation to improve efficiency and reduce operational costs. Target repetitive tasks, data-heavy operations, or areas with high error rates where AI can have a significant impact.

2. **Gather customer feedback.** Use structured customer feedback (surveys, support transcripts, NPS comments) to uncover use cases that improve satisfaction when automated with AI. This feedback helps prioritize initiatives with measurable impact.

3. **Conduct an internal assessment.** Collect input from departments (operations, finance, legal, support, product) to identify challenges and inefficiencies AI can address. Document workflows and gather stakeholder input to uncover opportunities for automation, insight generation, or improved decision quality.

4. **Research industry use cases.** Investigate how similar organizations or industries use AI to solve problems or enhance operations. Use resources like the [AI architectures](/azure/architecture/ai-ml/) in the Azure Architecture Center for inspiration and to evaluate suitable approaches.

5. **Define AI targets.** For each use case, define the goal (general purpose), objective (desired outcome), and success metric (quantifiable measure). These benchmarks guide adoption and measure success. For more information, see the [example AI strategy](#example-ai-strategy).

## Define an AI technology strategy using Microsoft's service options

Your technology strategy determines the balance of speed, customization, and control. Microsoft provides three primary AI consumption patterns: ready-to-use software (SaaS), extensible development platforms (PaaS), and fully managed infrastructure (IaaS). Select the model that aligns with engineering maturity, compliance posture, data residency, and customization needs.

**Understand AI agents**: Modern enterprise AI centers on **AI agents**, which are goal-directed systems that invoke tools, reason over context, and adapt within governance constraints. These agents orchestrate workflows across Microsoft 365, Dynamics 365, and Azure environments when you provide appropriate connectors, permissions, and APIs. Review [What are AI agents?](/azure/ai-foundry/agents/overview#what-is-an-ai-agent) to establish shared vocabulary for agent capabilities, security boundaries, and lifecycle management.

1. **Learn about AI agents.** **AI agents** are systems that use AI models to complete tasks without constant human supervision. These agent systems extend automation by adapting to changing situations and making bounded decisions. Plan for AI agents by evaluating how they integrate with existing systems and processes. See [enterprise workflow patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns) for examples.

2. **Plan for AI system integration.** **AI interoperability** means different AI systems work together and reduce custom integration effort. Standard protocols help AI systems share data and integrate while remaining flexible for future changes. **Model Context Protocol (MCP)** in Microsoft Copilot Studio provides a standard way for agents to securely call external tools and data sources. For setup guidance, see [Model Context Protocol in Microsoft Copilot Studio](/microsoft-copilot-studio/agent-extend-action-mcp#create-an-mcp-server).

3. **Choose your Microsoft AI service approach.** Microsoft offers three service models with different levels of control and [shared responsibility](/azure/security/fundamentals/shared-responsibility-ai): **Software as a Service (SaaS)** for initial outcomes, **Platform as a Service (PaaS)** for custom development, and **Infrastructure as a Service (IaaS)** for full control. Each service approach requires specific skills and offers different customization. Match the choice to team abilities, data needs, and required control. Use the Microsoft AI decision tree below to guide selection.

### Microsoft AI decision tree

:::image type="complex" source="./images/ai-decision-tree.svg" alt-text="Diagram showing Microsoft and Azure services with decision points for each service." lightbox="./images/ai-decision-tree.svg" border="false":::
    Start by identifying the AI use case. If the goal is to enhance individual productivity, use Microsoft 365 Copilot for Microsoft 365 apps. Use in-product Copilots for products like Azure, GitHub, Fabric, Dynamics 365, or Power Platform. Use role-aligned Copilots for roles such as security, sales, service, or finance. If the use case is general, use Microsoft Copilot or Copilot Pro. If you already use Microsoft 365 Copilot and need custom agents with domain-specific skills, use extensibility tools for Microsoft 365 Copilot. If the goal is to automate business functionality, use Copilot Studio as a SaaS tool that enables agent creation and deployment through natural language with integrated pricing. Use Azure AI Foundry as a development platform with API access to Azure OpenAI and Azure AI services. If you only need OpenAI models, use Azure OpenAI. If you need prebuilt non-generative models or Azure AI Search for agent support, use Azure AI services. If you need to train and deploy machine learning models with your own data, use Microsoft Fabric if you already work in that environment; otherwise, use Azure Machine Learning. Use Azure Container Apps for lightweight AI inferencing without managing GPU infrastructure (regional availability and feature status varies; verify current serverless GPU support). If you need to bring your own models, use Azure Virtual Machines (optionally with Azure CycleCloud or Azure Batch) or Azure Kubernetes Service for containerized workloads.
:::image-end:::

### Adopt Microsoft software AI services (SaaS) for initial outcomes

Microsoft ready-to-use AI solutions, called **Copilots**, increase productivity with minimal setup. **Microsoft 365 Copilot** provides AI assistance across Office apps, while **specialized Copilots** focus on specific job roles and industries. Start with these solutions to achieve initial results before shifting to custom development.

| Microsoft Copilots | Description | User | Data needed | Skills required | Main cost factors |
|---------------------|-------------|------|-------------|-----------------|-------------------|
| Microsoft 365 Copilot | [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) provides web-grounded chat and in-app AI assistance across Microsoft 365 applications, integrating with your Microsoft Graph data. | Business | Yes. [Categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels and securely interact with your data in Microsoft Graph. | General IT and data management | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans) |
| Role-based Copilots | Agents that enhance efficiency for specific roles in [Security](/copilot/security/microsoft-security-copilot), [Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business | Yes. Data-connection and plug-in options are available. | General IT and data management | Licenses or [Security Compute Units (SCUs) for Security Copilot](https://azure.microsoft.com/pricing/details/microsoft-security-copilot) |
| In-product Copilots | AI within products like [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), [Microsoft Fabric](/fabric/fundamentals/copilot-fabric-overview), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | Yes. Most require minimal data preparation. | Minimal (basic admin configuration and data readiness) | Free or subscription |
| Microsoft Copilot or Microsoft Copilot Pro | [Microsoft Copilot](https://copilot.microsoft.com/) is a free web-grounded chat application. [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) provides better performance, capacity, and access to Copilot in certain Microsoft 365 apps. | Individual | No | None | [Microsoft Copilot](https://copilot.microsoft.com/) is free. Microsoft Copilot Pro requires a [subscription](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |

### Build AI agents with Microsoft software services (SaaS) for low-code customization

Microsoft provides low-code platforms for custom AI agent development without a full development team. **Copilot Studio** lets business users create AI assistants with natural language, while **Microsoft 365 Copilot extensions** let you customize enterprise Copilot with company-specific data and processes.

| Microsoft Copilots | Description | User | Data needed | Skills required | Main cost factors |
|---------------------|-------------|------|-------------|-----------------|-------------------|
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) Microsoft 365 Copilot with more data or capabilities via declarative agents. Use tools like [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext), [agent builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), [Teams Toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents), and [SharePoint](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Use [Microsoft Graph connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) to add data. | Data management, general IT, or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build conversational AI agents and automation workflows with low-code tools and natural language. | IT | Automates much of the data integration to create custom copilots with connections to various data sources. | Platform configuration to connect data sources, design conversational flows, and deploy copilots | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |

### Build AI workloads with Azure platforms (PaaS) for custom development

Azure provides development platforms for distinct AI solution patterns and maturity levels. **Azure AI Foundry** is the unified platform for creating **retrieval-augmented generation (RAG) applications**, building production **AI agents**, evaluating and customizing **foundation models**, and applying responsible AI controls. These managed capabilities let development teams focus on solution differentiation while Azure supplies security, governance, observability, and scalable infrastructure primitives. Use [Azure AI pricing](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) for cost modeling.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Build agents | Azure AI Foundry [Agent Service](/azure/ai-foundry/agents/overview) | Yes | [Environment setup](/azure/ai-foundry/agents/environment-setup), model selection, [tooling](/azure/ai-foundry/agents/how-to/tools/overview), grounding data storage, data isolation, [agent triggering](/azure/ai-foundry/agents/how-to/triggers), [connect agents](/azure/ai-foundry/agents/how-to/connected-agents?pivots=portal), [content filtering](/azure/ai-foundry/openai/how-to/content-filters), [private networking](/azure/ai-foundry/agents/how-to/virtual-networks), [agent monitoring](/azure/ai-foundry/agents/concepts/tracing), [service monitoring](/azure/ai-foundry/agents/how-to/metrics) | Consuming model tokens, storage, features, compute, grounding connections |
| Build RAG applications | [Azure AI Foundry](/azure/ai-foundry/concepts/retrieval-augmented-generation) | Yes | [Select models](/azure/ai-foundry/concepts/foundry-models-overview), orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune GenAI models | [Azure AI Foundry](/azure/ai-foundry/concepts/fine-tuning-overview) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference models | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) <br>or<br> [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume prebuilt AI models and services | [Azure AI services](/azure/ai-services/what-are-ai-services?context=%2Fazure%2Fai-foundry%2Fcontext%2Fcontext) and/or<br>[Azure OpenAI](/azure/ai-services/openai/overview)| Yes | Select AI models, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |
| Isolate AI apps | [Azure Container Apps with serverless GPU support](/azure/container-apps/gpu-serverless-overview) | Yes | Select AI models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps; optional environment/VNet configuration for network isolation (regional availability and feature status may vary) | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |

### Bring AI models with Azure infrastructure services (IaaS) for maximum control

Azure infrastructure services provide granular control for AI performance, isolation, or compliance requirements. **Azure Virtual Machines with GPU support** enable custom model training and benchmarking (PyTorch, TensorFlow, distributed fine-tuning). **Azure Kubernetes Service (AKS)** offers container orchestration, GPU pooling, autoscaling, and multitenant workload segmentation for inferencing and training pipelines. Use IaaS paths when you must **bring your own models**, use custom runtimes, or optimize for cost and performance beyond managed platform abstractions. Reference [Azure infrastructure pricing](https://azure.microsoft.com/products/) with the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) for capacity forecasting.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines with CycleCloud for HPC workloads](./infrastructure/cycle-cloud.md) <br>or<br>[Azure Kubernetes Service](/azure/aks/gpu-cluster) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestrator, managed disks (optional), storage services, Azure Bastion, and other Azure services used |

## Develop an AI data strategy that grows with your needs

Your data strategy is the control plane for scalable, trustworthy AI. It defines how data is sourced, classified, secured, enriched, monitored, and retired while sustaining compliance and minimizing exposure risk. A durable strategy ensures priority AI use cases across Microsoft 365, Azure, and hybrid estates have governed, high-quality, lineage-traceable data. Concentrate on governance baselines, elasticity planning, lifecycle instrumentation, and responsible usage enforcement.

1. **Set up data governance for AI projects.** **Data governance** ensures you use AI data securely and comply with regulations through access controls and policies. Start by classifying data based on sensitivity and required access. Use [Microsoft Purview Data Security Posture Management (DSPM) for AI](/purview/dspm-for-ai) to protect generative AI applications; it includes capabilities for AI data security.

2. **Plan for data growth and performance.** Ensure the data environment supports current AI projects and future growth without performance degradation or excessive cost. Document current data volume, processing frequency, and required data types per use case. This information helps you choose appropriate Azure services.

3. **Manage data throughout its lifecycle.** Define how you collect, store, and retire data while keeping it accessible and secure for AI use. Set up systematic collection from databases, APIs, IoT devices, and third-party sources. Choose Azure storage tiers based on access frequency. Build **ETL/ELT pipelines** (data processing workflows) to maintain quality and use the [Responsible AI Dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) to check for bias in training data.

4. **Follow responsible data practices.** Ensure AI systems use data ethically and meet regulatory requirements. Track data sources and usage with [Microsoft Fabric data lineage](/fabric/governance/lineage) or [Microsoft Purview data lineage](/purview/concept-data-lineage). Set quality standards, check for bias, and evaluate fairness in training datasets. Create retention policies that balance AI performance with privacy and compliance.

> [!TIP]
> **Data decision accelerators** (all derived from existing guidance):
>
> - Start classification before large-scale RAG ingestion to avoid rework.
> - Pair lineage tracking with retention policies to reduce orphaned sensitive data.
> - Treat bias evaluation (Responsible AI Dashboard) as a recurring control, not a one-time gate.
> - Use cost telemetry (tokens, storage, egress) early to flag unbounded data growth.
>

## Develop a responsible AI strategy

Responsible AI converts trust, safety, and regulatory alignment into operational controls across the AI lifecycle. A responsible AI strategy translates principles into enforceable controls, measurable checkpoints, and clear accountability. Maintain an auditable chain across design reviews, risk assessments, policy enforcement, model and agent monitoring, and incident response.

1. **Assign clear ownership for AI governance.** Designate specific people or teams to own AI governance decisions and manage regulatory requirements. Governance roles define decision-making authority for AI projects. Assign someone to monitor AI technology changes and new regulations. [Create an AI cloud center of excellence](./center-of-excellence.md) to centralize responsibilities and establish procedures for AI governance issues.

2. **Adopt responsible AI principles as business goals.** Use Microsoft's [responsible AI principles](https://www.microsoft.com/ai/responsible-ai) as the framework for ethical AI development. These six AI principles align with the [NIST AI Risk Management Framework](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf) and become measurable business objectives that guide project selection and development. Integrate these principles into project planning, development processes, and success metrics.

3. **Choose responsible AI tools for your projects.** Select tools that implement ethical AI principles across AI initiatives. Microsoft provides [responsible AI tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) that match different AI use cases and risk levels. Integrate these tools into development workflows to apply responsible AI practices.

4. **Stay compliant with AI regulations.** Identify local and international AI regulations that apply to operations and AI use cases. Compliance requirements vary by industry, location, and AI application type. Monitor regulatory changes and update compliance strategies to stay aligned.

## Example AI strategy

This example AI strategy uses a fictional company, Contoso. Contoso operates a customer-facing e-commerce platform and employs sales representatives who need tools to forecast business data. The company also manages product development and inventory for production. Sales channels include private companies and regulated public sector agencies.

| AI use case | Goals | Objectives | Success metrics | AI approach | Microsoft solution | Data needs | Skill needs | Cost factors | AI data strategy | Responsible AI strategy |
|---|---|---|---|---|---|---|---|---|---|---|
| **E-commerce web application chat feature** | Automate business process | Improve customer satisfaction | Increased customer retention rate | PaaS, generative AI, RAG | Azure AI Foundry | Item descriptions and pairings | RAG and cloud app development | Usage | Establish data governance for customer data and implement AI fairness controls. | Assign AI accountability to AI CoE and align with Responsible AI principles. |
| **Internal app document-processing workflow** | Automate business process | Reduce costs | Increased completion rate | Analytical AI, fine-tuning | Azure AI services – [Document Intelligence](/azure/ai-services/document-intelligence/overview) | Standard documents | App development | Estimated usage | Define data governance for internal documents and plan data lifecycle policies. | Assign AI accountability and ensure compliance with data handling policies. |
| **Inventory management and product purchasing** | Automate business process | Reduce costs | Shorter shelf life of inventory | Machine learning, training models | Azure Machine Learning | Historical inventory and sales data | Machine learning and app development | Estimated usage | Establish governance for sales data and detect and address biases in data. | Assign AI accountability and comply with financial regulations. |
| **Daily work across company** | Enhance individual productivity | Improve employee experience | Increased employee satisfaction | SaaS generative AI | Microsoft 365 Copilot | OneDrive data | General IT | Subscription costs | Implement data governance for employee data and ensure data privacy. | Assign AI accountability and utilize built-in responsible AI features. |
| **E-commerce app for regulated industry chat feature** | Automate business process | Increase sales | Increased sales | IaaS generative AI model training | Azure Virtual Machines | Domain-specific training data | Cloud infrastructure and app development | Infrastructure and software | Define governance for regulated data and plan lifecycle with compliance measures. | Assign AI accountability and adhere to industry regulations. |

## Azure tools and resources for AI strategy implementation

| Category | Tool | Description |
|----------|------|-------------|
| AI Strategy Planning | [Azure AI Architecture Center](/azure/architecture/ai-ml/) | Comprehensive reference architectures and design patterns for AI solutions across industries and enterprise use cases |
| Agent Development Platform | [Azure AI Foundry Agent Service](/azure/ai-foundry/agents/overview) | Full-featured platform for building, deploying, and managing intelligent AI agents with enterprise security |
| Enterprise Generative AI | [Azure OpenAI Service](/azure/ai-services/openai/overview) | Enterprise-grade access to GPT-4 family (including GPT-4o) and DALL·E models with security, compliance, and responsible AI features |
| AI Data Governance | [Microsoft Purview Data Security Posture Management (DSPM) for AI](/purview/dspm-for-ai) | AI data risk visibility, data protection controls, and monitoring for generative AI workloads |
| Responsible AI Tooling | [Microsoft Responsible AI Dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) | Comprehensive tools for bias detection, fairness assessment, and AI model interpretability |
| AI Development Platform | [Azure AI Foundry](/azure/ai-foundry/concepts/retrieval-augmented-generation) | Unified platform for RAG applications, foundation model fine-tuning, and AI workload deployment |
| Low-Code AI Development | [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) | Build conversational AI agents and automation workflows with natural language interface |
| Enterprise AI Productivity | [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) | AI-powered productivity across Microsoft 365 applications with enterprise data integration |

## Key takeaways for AI strategy success

**Strategic planning delivers faster results**: A documented AI strategy produces consistent, auditable outcomes. Success depends on prioritizing business-aligned use cases, selecting the correct Microsoft AI service model (SaaS, PaaS, IaaS), and instituting scalable data governance and DSPM controls.

**Microsoft AI portfolio supports adoption patterns**: The integrated Microsoft AI ecosystem increases productivity with **Microsoft 365 Copilot**, enables differentiated solutions with **Azure AI Foundry** (RAG, agents, evaluations, model orchestration), and provides specialization and isolation through **Azure infrastructure services**.

**Responsible AI is essential**: Embed governance, transparency tooling, content safety, fairness assessment, and regulatory alignment at inception, not post-deployment, to reduce remediation cost and strengthen stakeholder confidence.

**Important AI terms to know**: AI adoption framework, Azure AI Foundry, AI agents, generative AI, retrieval-augmented generation (RAG), Microsoft 365 Copilot, responsible AI governance, machine learning workloads, AI data strategy, Microsoft Purview Data Security Posture Management (DSPM) for AI, Copilot Studio, Azure OpenAI Service, AI agent orchestration, shared responsibility model, AI lineage, content safety, data minimization.

## In summary

An enterprise AI strategy combines outcome-driven use case prioritization, the appropriate Microsoft AI service model (SaaS for acceleration, PaaS for differentiation, IaaS for specialization), governed and lineage-traceable data foundations, and enforceable Responsible AI controls. Use Azure AI Foundry for unified agent and RAG development, use Microsoft 365 Copilot for early productivity impact, integrate Microsoft Purview DSPM for proactive data risk reduction, and apply continuous evaluation and observability to sustain trust, performance, and compliance at scale.

## Next step

> [!div class="nextstepaction"]
> [AI Plan](plan.md)
