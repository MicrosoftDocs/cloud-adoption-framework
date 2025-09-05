---
title: Create your strategy for AI adoption
description: Create your strategy for AI adoption
author: stephen-sumner
ms.author: ssumner
ms.date: 07/01/2025
ms.topic: conceptual
---

# Create your strategy for AI adoption

A successful AI strategy requires planning in four key areas. You need to identify the right **AI use cases** that deliver clear business value, select **Microsoft AI technologies** that match your team's skills, establish **data governance** that grows with your needs, and implement **responsible AI practices** that maintain trust and meet regulations.

:::image type="content" source="./images/ai-strategy.svg" alt-text="Diagram that shows the 6 phases of AI adoption: Strategy, Plan, Ready, Govern, Secure, Manage." lightbox="./images/ai-strategy.svg" border="false":::

**Why strategic AI planning matters**: Organizations with structured AI strategies achieve better results than those without a plan. This strategy guide provides practical steps for developing your AI strategy, including Microsoft Copilot deployment, Azure AI Foundry setup, and AI governance best practices.

## Identify AI use cases for maximum business impact

AI transforms businesses by making people more productive and automating routine work. **Generative AI** (AI that creates content like text and images) can boost knowledge worker productivity, while **analytical AI and machine learning** automate data-heavy tasks and eliminate repetitive manual work. Start by identifying high-impact areas where AI delivers measurable results and competitive advantages.

**Focus on business outcomes first**: Successful AI projects target specific business results rather than adopting technology for its own sake. Organizations that follow structured approaches to identifying use cases achieve better success rates, as shown in the [Azure Architecture Center AI guidance](https://learn.microsoft.com/azure/architecture/ai-ml/).

1. **Identify automation opportunities.** Focus on processes suitable for automation to improve efficiency and reduce operational costs. Target repetitive tasks, data-heavy operations, or areas with high error rates where AI can have a significant impact.

2. **Gather customer feedback.** Use customer feedback to uncover use cases that improve customer satisfaction when you automate them with AI. This customer feedback helps prioritize impactful AI initiatives.

3. **Conduct an internal assessment.** Collect input from various departments to identify challenges and inefficiencies that AI can address. Document workflows and gather stakeholder input to uncover opportunities for automation, insight generation, or improved decision-making.

4. **Research industry use cases.** Investigate how similar organizations or industries use AI to solve problems or enhance operations. Use tools like the [AI architectures](/azure/architecture/ai-ml/) in the Azure Architecture Center for inspiration and to evaluate suitable approaches.

5. **Define AI targets.** For each identified use case, define the goal (general purpose), objective (desired outcome), and success metric (quantifiable measure). These benchmarks guide your AI adoption and measure success. For more information, see [example AI strategy](#example-ai-strategy).

## Define an AI technology strategy using Microsoft's service options

Your technology strategy determines the best approach based on your team's skills, data needs, and budget. Microsoft offers three main ways to deploy AI: ready-to-use software (SaaS), development platforms (PaaS), and infrastructure you manage (IaaS). Choose the approach that matches your technical capabilities and business requirements.

**Understanding AI agents**: Modern AI centers on **AI agents**, which are smart systems that can complete tasks, make decisions, and adapt to changes without constant supervision. Think of these AI agents as digital assistants that can handle complex workflows across your Microsoft 365, Dynamics 365, and Azure environments. Review [What are AI agents?](https://learn.microsoft.com/azure/ai-foundry/agents/overview#what-is-an-ai-agent) to understand how these agent systems work.

1. **Learn about AI agents.** **AI agents** are smart systems that use advanced AI models to complete tasks without someone watching over them constantly. These agent systems go beyond simple automation because they can adapt to changing situations and make intelligent decisions. Planning for AI agents means thinking about how these agents work with your existing systems and processes. See [enterprise workflow patterns](https://learn.microsoft.com/azure/architecture/ai-ml/guide/ai-agent-design-patterns) for examples of how AI agents work in business environments.

2. **Plan for AI system integration.** **AI interoperability** means different AI systems can work together smoothly, which reduces the need for custom connections. Standard protocols help AI systems share data and integrate while staying flexible for future changes. **Model Context Protocol (MCP)** is one such standard that helps AI systems access and share information across platforms. For setup guidance, see [Model Context Protocol in Microsoft Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/agent-extend-action-mcp#create-an-mcp-server).

3. **Choose your Microsoft AI service approach.** Microsoft offers three service models with different levels of control and [shared responsibility](https://learn.microsoft.com/azure/security/fundamentals/shared-responsibility-ai): **Software as a Service (SaaS)** for quick wins, **Platform as a Service (PaaS)** for custom development, and **Infrastructure as a Service (IaaS)** for full control. Each service approach requires different skills and gives you different levels of customization. Match your choice to your team's abilities, data needs, and how much control you want. Use the Microsoft AI decision tree below to guide your choice.

:::image type="complex" source="./images/ai-decision-tree.svg" alt-text="Diagram showing Microsoft and Azure services with decision points for each service." lightbox="./images/ai-decision-tree.svg" border="false":::
    Start by identifying your AI use case. If the goal is to enhance individual productivity, use Microsoft 365 Copilot when focusing on Microsoft 365 apps. Use in-product Copilots for products like Azure, GitHub, Fabric, Dynamics 365, or Power Platform. Use role-aligned Copilots for domain-specific roles such as security, sales, service, or finance. If the use case is more general, use Microsoft Copilot or Copilot Pro. If you already use Microsoft 365 Copilot and need to create custom agents with domain-specific skills, use Extensibility Tools for Microsoft 365 Copilot. If the goal is to automate business functionality, use Copilot Studio for a SaaS tool that enables agent creation and deployment through natural language with integrated pricing. Use Azure AI Foundry for a full development platform with API access to both Azure OpenAI and Azure AI services. If you only need access to OpenAI models, use Azure OpenAI. If you need prebuilt non-generative models or Azure AI Search for agent support, use Azure AI services. If you need to train and deploy machine learning models with your own data, use Microsoft Fabric if you already work in that environment; otherwise, use Azure Machine Learning. Use Azure Container Apps for lightweight AI inferencing without managing GPU infrastructure. If you need to bring your own models and orchestrate them with Azure CycleCloud, Azure Batch, or Kubernetes, use Azure Virtual Machines.
:::image-end:::

### Buy AI with Microsoft software services (SaaS) for quick wins

Microsoft's ready-to-use AI solutions, called **Copilots**, boost productivity with minimal setup. **Microsoft 365 Copilot** provides AI help across Office apps, while **specialized Copilots** focus on specific job roles and industries. Start with these out-of-the-box solutions to see quick results before you move to custom development.

| Microsoft Copilots | Description | User | Data needed | Skills required | Main cost factors |
|---------------------|-------------|------|-------------|-----------------|-------------------|
| Microsoft 365 Copilot | [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) provides web-grounded chat and in-app AI assistance across Microsoft 365 applications, integrating with your Microsoft Graph data. | Business | Yes. [Categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels and securely interact with your data in Microsoft Graph. | General IT and data management | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans) |
| Role-based Copilots | Agents that enhance efficiency for specific roles in [Security](/copilot/security/microsoft-security-copilot), [Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance). | Business | Yes. Data-connection and plug-in options are available. | General IT and data management | Licenses or [Security Compute Units (SCUs) for Security Copilot](https://azure.microsoft.com/pricing/details/microsoft-security-copilot) |
| In-product Copilots | AI within products like [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), [Microsoft Fabric](/fabric/fundamentals/copilot-fabric-overview), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | Yes. Most require minimal data preparation. | None | Free or subscription |
| Microsoft Copilot or Microsoft Copilot Pro | [Microsoft Copilot](https://copilot.microsoft.com/) is a free web-grounded chat application. [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) provides better performance, capacity, and access to Copilot in certain Microsoft 365 apps. | Individual | No | None | [Microsoft Copilot](https://copilot.microsoft.com/) is free. Microsoft Copilot Pro requires a [subscription](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |

### Build AI agents with Microsoft software services (SaaS) for easy customization

Microsoft provides low-code platforms for custom AI agent development without needing a development team. **Copilot Studio** lets business users create AI assistants with natural language, while **Microsoft 365 Copilot extensions** allow you to customize enterprise Copilot with your company's specific data and processes.

| Microsoft Copilots | Description | User | Data needed | Skills required | Main cost factors |
|---------------------|-------------|------|-------------|-----------------|-------------------|
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) Microsoft 365 Copilot with more data or capabilities via declarative agents. Use tools like [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext), [agent builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), [Teams toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents), and [SharePoint](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Use [Microsoft Graph connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) to add data. | Data management, general IT, or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build conversational AI agents and automation workflows with low-code tools and natural language. | IT | Automates much of the data integration to create custom copilots with connections to various data sources. | Platform configuration to connect data sources, design conversational flows, and deploy copilots | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |

### Build AI workloads with Azure platforms (PaaS) for custom development

Azure provides development platforms designed for different AI goals and skill levels. **Azure AI Foundry** is the main platform for creating **RAG applications** (AI that can search and use your documents), developing **AI agents**, and customizing **foundation models**. These managed platforms let developers focus on solution development while Azure handles the underlying infrastructure. Check [Azure AI pricing](https://azure.microsoft.com/products/) and use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to estimate costs.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Build agents | Azure AI Foundry [Agent Service](/azure/ai-services/agents/overview) | Yes | [Environment setup](/azure/ai-services/agents/environment-setup), model selection, [tooling](/azure/ai-services/agents/how-to/tools/overview), grounding data storage, data isolation, [agent triggering](/azure/ai-services/agents/how-to/triggers), [connect agents](/azure/ai-services/agents/how-to/connected-agents?pivots=portal), [content filtering](/azure/ai-services/openai/how-to/content-filters?context=%2Fazure%2Fai-services%2Fagents%2Fcontext%2Fcontext), [private networking](/azure/ai-services/agents/how-to/virtual-networks), [agent monitoring](/azure/ai-services/agents/concepts/tracing), [service monitoring](/azure/ai-services/agents/how-to/metrics) | Consuming model tokens, storage, features, compute, grounding connections |
| Build RAG applications | [Azure AI Foundry](/azure/ai-foundry/concepts/retrieval-augmented-generation) | Yes | [Select models](/azure/ai-foundry/concepts/foundry-models-overview), orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune GenAI models | [Azure AI Foundry](/azure/ai-foundry/concepts/fine-tuning-overview) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference models | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) <br>or<br> [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume prebuilt AI models and services | [Azure AI services](/azure/ai-services/what-are-ai-services?context=%2Fazure%2Fai-foundry%2Fcontext%2Fcontext) and/or<br>[Azure OpenAI](/azure/ai-services/openai/overview)| Yes | Select AI models, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |
| Isolate AI apps | [Azure Container Apps with serverless GPU support](/azure/container-apps/gpu-serverless-overview) | Yes | Select AI models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |

### Bring AI models with Azure infrastructure services (IaaS) for maximum control

Azure's infrastructure services give you complete control for specialized AI needs. **Azure Virtual Machines with GPU support** let you train custom models with frameworks like PyTorch and TensorFlow, while **Azure Kubernetes Service (AKS)** helps you run AI applications at scale. These infrastructure options work well when you want to **bring your own models** or need specialized configurations. See [Azure infrastructure pricing](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to plan costs.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines with CycleCloud for HPC workloads](./infrastructure/cycle-cloud.md) <br>or<br>[Azure Kubernetes Service](/azure/aks/gpu-cluster) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestrator, managed disks (optional), storage services, Azure Bastion, and other Azure services used |

## Develop an AI data strategy that grows with your needs

Your data strategy is the foundation for successful AI projects. This data strategy defines how you collect, manage, and use data for AI while you maintain security and compliance. A good data strategy ensures your data supports business-critical AI use cases across Microsoft 365, Azure, and hybrid environments. Focus on establishing governance, planning for growth, managing data throughout its lifecycle, and following responsible practices.

1. **Set up data governance for AI projects.** **Data governance** ensures you use AI data securely and comply with regulations through proper access controls and policies. Start by classifying your data based on how sensitive it is and who should have access. Use [Microsoft Purview AI governance](https://learn.microsoft.com/purview/ai-microsoft-purview) to protect your generative AI applications, which includes **Data Security Posture Management (DSPM)** - a set of tools designed specifically for AI data security.

2. **Plan for data growth and performance.** Ensure your data setup can handle both current AI projects and future growth without slowdown or excessive costs. Document how much data you have now, how often you process it, and what types of data each AI use case needs. This data information helps you choose the right Azure services for your needs.

3. **Manage data throughout its entire lifecycle.** Plan how you collect, store, and eventually delete data while you keep it accessible and secure for AI use. Set up systematic collection from databases, APIs, IoT devices, and third-party sources. Choose appropriate Azure storage tiers based on how often you access the data. Build **ETL/ELT pipelines** (data processing workflows) to maintain quality and use the [Responsible AI Dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) to check for bias in your training data.

4. **Follow responsible data practices.** Ensure your AI systems use data ethically and meet regulatory requirements. Track where your data comes from and how it's used with [Microsoft Fabric data lineage](https://learn.microsoft.com/fabric/governance/lineage) or [Microsoft Purview data lineage](https://learn.microsoft.com/purview/concept-data-lineage). Set quality standards, check for bias, and consider fairness in your training datasets. Create retention policies that balance AI performance with privacy and compliance needs.

## Develop a responsible AI strategy

Responsible AI ensures your AI solutions remain trustworthy, ethical, and compliant with regulations. This responsible AI strategy establishes clear guidelines for ethical AI development that align with your business goals. You need to assign accountability, adopt proven principles, choose the right tools, and stay compliant with regulations.

1. **Assign clear ownership for AI governance.** Designate specific people or teams to own AI governance decisions and manage regulatory requirements. These governance people define roles and decision-making authority for AI projects. Assign someone to monitor AI technology changes and new regulations. [Create an AI cloud center of excellence](./center-of-excellence.md) to centralize responsibilities and set up procedures for AI governance issues.

2. **Adopt responsible AI principles as business goals.** Use Microsoft's [responsible AI principles](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) as your framework for ethical AI development. These six AI principles align with the [NIST AI Risk Management Framework](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf) and become measurable business objectives that guide project selection and development. Integrate these AI principles into your project planning, development processes, and success metrics.

3. **Choose responsible AI tools for your projects.** Select tools that help you implement ethical AI principles across all your AI initiatives. Microsoft provides [responsible AI tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) that match different AI use cases and risk levels. Integrate these AI tools into your development workflows to ensure application of responsible AI practices.

4. **Stay compliant with AI regulations.** Identify relevant local and international AI regulations that apply to your operations and AI use cases. Compliance requirements vary by industry, location, and AI application type. Monitor regulatory changes and update your compliance strategies to stay aligned throughout your AI journey.

## Example AI strategy

This example AI strategy is based on a fictional company, Contoso. Contoso operates a customer-facing e-commerce platform and employs sales representatives who need tools to forecast business data. The company also manages product development and inventory for production. Its sales channels include both private companies and highly regulated public sector agencies.

| AI use case | Goals | Objectives | Success metrics | AI approach | Microsoft solution | Data needs | Skill needs | Cost factors | AI data strategy | Responsible AI strategy |
|---|---|---|---|---|---|---|---|---|---|---|
| **E-commerce web application chat feature** | Automate business process | Improve customer satisfaction | Increased customer retention rate | PaaS, generative AI, RAG | Azure AI Foundry | Item descriptions and pairings | RAG and cloud app development | Usage | Establish data governance for customer data and implement AI fairness controls. | Assign AI accountability to AI CoE and align with Responsible AI principles. |
| **Internal app document-processing workflow** | Automate business process | Reduce costs | Increased completion rate | Analytical AI, fine-tuning | Azure AI services - Document Intelligence | Standard documents | App development | Estimated usage | Define data governance for internal documents and plan data lifecycle policies. | Assign AI accountability and ensure compliance with data handling policies. |
| **Inventory management and product purchasing** | Automate business process | Reduce costs | Shorter shelf life of inventory | Machine learning, training models | Azure Machine Learning | Historical inventory and sales data | Machine learning and app development | Estimated usage | Establish governance for sales data and detect and address biases in data. | Assign AI accountability and comply with financial regulations. |
| **Daily work across company** | Enhance individual productivity | Improve employee experience | Increased employee satisfaction | SaaS generative AI | Microsoft 365 Copilot | OneDrive data | General IT | Subscription costs | Implement data governance for employee data and ensure data privacy. | Assign AI accountability and utilize built-in responsible AI features. |
| **E-commerce app for regulated industry chat feature** | Automate business process | Increase sales | Increased sales | IaaS generative AI model training | Azure Virtual Machines | Domain-specific training data | Cloud infrastructure and app development | Infrastructure and software | Define governance for regulated data and plan lifecycle with compliance measures. | Assign AI accountability and adhere to industry regulations. |

## Azure tools and resources for AI strategy implementation

| Category | Tool | Description |
|----------|------|-------------|
| AI Strategy Planning | [Azure AI Architecture Center](https://learn.microsoft.com/azure/architecture/ai-ml/) | Comprehensive reference architectures and design patterns for AI solutions across industries and enterprise use cases |
| Agent Development Platform | [Azure AI Foundry Agent Service](https://learn.microsoft.com/azure/ai-services/agents/overview) | Full-featured platform for building, deploying, and managing intelligent AI agents with enterprise security |
| Enterprise Generative AI | [Azure OpenAI Service](https://learn.microsoft.com/azure/ai-services/openai/overview) | Enterprise-grade access to GPT, DALL-E, and Codex models with security, compliance, and responsible AI features |
| AI Data Governance | [Microsoft Purview AI Governance](https://learn.microsoft.com/purview/ai-microsoft-purview) | AI-specific data governance including Data Security Posture Management (DSPM) for AI workloads |
| Responsible AI Tooling | [Microsoft Responsible AI Dashboard](https://github.com/microsoft/responsible-ai-toolbox#introducing-responsible-ai-dashboard) | Comprehensive tools for bias detection, fairness assessment, and AI model interpretability |
| AI Development Platform | [Azure AI Foundry](https://learn.microsoft.com/azure/ai-foundry/concepts/retrieval-augmented-generation) | Unified platform for RAG applications, foundation model fine-tuning, and AI workload deployment |
| Low-Code AI Development | [Microsoft Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) | Build conversational AI agents and automation workflows with natural language interface |
| Enterprise AI Productivity | [Microsoft 365 Copilot](https://learn.microsoft.com/copilot/microsoft-365/microsoft-365-copilot-overview) | AI-powered productivity across Microsoft 365 applications with enterprise data integration |

## Key takeaways for AI strategy success

**Strategic planning delivers faster results**: Organizations with structured AI strategies achieve better results than those without a plan. Success depends on identifying the right use cases, choosing Microsoft AI technologies that match your capabilities, and establishing data governance that scales with your needs.

**Microsoft's AI portfolio covers all your needs**: The integrated Microsoft AI ecosystem provides immediate productivity gains with **Microsoft 365 Copilot**, custom development with **Azure AI Foundry**, and specialized control through **Azure infrastructure services**. Start with ready-to-use solutions for quick wins, then expand to development platforms for custom solutions, and use infrastructure services for specialized requirements.

**Responsible AI is essential for long-term success**: Successful AI adoption integrates ethical considerations, bias detection, and regulatory compliance from the start. This proactive AI approach protects your organization from risks while ensuring AI solutions remain trustworthy and aligned with your business values.

**Important AI terms to know**: AI adoption framework, Azure AI Foundry, AI agents, generative AI, RAG applications (retrieval-augmented generation), Microsoft 365 Copilot, responsible AI governance, machine learning workloads, AI data strategy, Microsoft AI transformation, Copilot Studio, Azure OpenAI services, AI agent orchestration, Microsoft Purview AI governance.

## Next step

> [!div class="nextstepaction"]
> [AI Plan](plan.md)
