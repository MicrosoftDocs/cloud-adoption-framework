---
title: AI strategy - Guidance to set your organization's AI strategy
description: "Get guidance to set your organization's AI strategy: Identify use cases, choose Microsoft AI solutions, and build a responsible, data-driven AI strategy."
#customer intent: As a decision maker I want guidance to help align AI investments with business goals across my organization.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 06/26/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# AI strategy - Guidance to set your organization's AI strategy

**AI goal:** Every organization wants AI to add value to its people and processes. That value has to come from AI that stays secure and runs efficiently. It must fit the skills and data you already have and stay within budget. **AI challenge:** The goal is clear but reaching that value isn't always straightforward. Teams often experiment a great deal and see little return. Some build conflicting solutions across the organization. In other places, security concerns and low confidence restrict what people can use, which holds AI back.

**AI solution:** Many organizations have turned to Microsoft AI solutions to meet these challenges. Microsoft offers a broad set of capabilities that give you the flexibility to address each use case efficiently and to keep AI secure as it scales. This guidance gives decision makers a framework to direct that work and to align AI investments with business needs.

**Recommendation:** Create an AI strategy that fits your business needs by working through the decisions in the following sections in sequence. Each decision sets the constraints that shape the next one and keeps the focus on value creation.

:::image type="content" source="./images/ai-strategy.svg" alt-text="Diagram that shows the 6 phases of AI adoption: Strategy, Plan, Ready, Govern, Secure, Manage." lightbox="./images/ai-strategy.svg" border="false":::

<a name='identify-ai-use-cases'></a>

## 1. AI use case identification

The first step in framing your AI strategy is use case identification. This step defines how decision makers discover where AI can improve business outcomes across the organization. The goal is to surface meaningful opportunities first. The list doesn't need to be exhaustive, though it can be. Its purpose is to give everyone a common view of what matters most to the business. Work through it in order so that every use case traces back to real value.

1. **Start with business problems.** Look for where the organization needs better results before you consider AI at all. The clearest signals show up in how people work, such as repeated manual effort or slow approvals. Frame the search in plain terms such as "where do results miss expectations" or "where do people spend time on repetitive tasks." This approach keeps AI pointed at value rather than novelty. Tradeoff: A broad scan surfaces many opportunities, so stay focused on the outcome gaps that are both measurable and meaningful.

2. **Translate problems into use cases.** Turn each business problem into a short statement that names the activity and the expected result, such as "help support agents answer from internal documents so resolution time drops." Confirm the activity happens often enough to justify the investment. Tradeoff: Early scenarios tend to be vague, so refine them into clear and actionable descriptions before you move on.

3. **Classify use case.** Classify each use case based on how it creates value. Use this decision to guide later technology choices.

    - **Individual work:** These use cases improve how individuals or teams work inside existing tools. Examples include writing assistance or meeting preparation. They align strongly to generative AI solutions such as Microsoft 365 Copilot.
    
    - **Business automation:** These use cases change how the organization operates or delivers value. Examples include automated customer routing or demand forecasting. They often need integration with other systems and can combine more than one AI type.
    
4. **Consider AI type needed.** This is a consideration, not a final decision, and you can revisit it as the use case becomes clearer. A rough sense of how much consistency you want in the result narrows the technology choices that come next. You have the freedom to adjust it later.

    - **Generative AI (non-deterministic)** produces outputs that can vary even for the same input, and it works well when inputs are unstructured such as natural language or documents. It fits cases where the workflow isn't fixed and where you want the system to create content or assist a human decision. Lean this way when you don't know the exact steps in advance and some variation in the output is acceptable.

    - **Nongenerative AI (deterministic)** produces consistent and repeatable outputs from structured inputs. It fits cases where the workflow is defined and the same input should lead to the same result. Lean this way for tasks that depend on accuracy such as prediction or anomaly detection.

Apply this same sequence across every business area. A repeatable flow reduces confusion, prevents you from reaching for generative AI where it isn't needed, and prepares you to choose a solution path next.

<a name='define-an-ai-technology-strategy'></a>

## 2. AI technology strategy

*What Microsoft AI solution should you choose?* After you identify which use cases need which type of AI, start narrowing down how to build or buy each one. Microsoft offers four adoption models that trade customization for simplicity under a shared responsibility approach. They are ready-to-use Copilots, low-code SaaS development, managed PaaS development, and Azure infrastructure. As you move from the first model to the last, you gain control and give up speed.

Each approach requires a different level of technical skill and returns a different degree of control. Use the decision tree in the following section to narrow the options. Then use the following guidance to weigh four factors for AI solution:

- **Capabilities:** Review the capabilities of Microsoft and Azure AI solutions to see if they meet the needs of your use case.
- **Data needed:** Confirm the required data exists and is accessible for the scenario.
- **Skills required:** Validate that each use case is achievable with current capabilities before you select a solution.
- **Cost:** Assess whether the solution fits your budget.

### Microsoft AI decision tree

:::image type="complex" source="./images/ai-decision-tree.svg" alt-text="Diagram showing Microsoft and Azure services with decision points for each service." lightbox="./images/ai-decision-tree.svg" border="false":::
    Start by identifying the AI use case. If the goal is to enhance individual productivity, use Microsoft 365 Copilot for Microsoft 365 apps. Use in-product Copilots for products like Azure, GitHub, Fabric, Dynamics 365, or Power Platform. Use role-aligned Copilots for roles such as security, sales, service, or finance. If the use case is general, use Microsoft Copilot. If you already use Microsoft 365 Copilot and need custom agents with domain-specific skills, use extensibility tools for Microsoft 365 Copilot. If the goal is to automate business functionality, use Copilot Studio as a SaaS tool that enables agent creation and deployment through natural language with integrated pricing. Use Foundry as a development platform with API access to Foundry Tools. If you need prebuilt non-generative models or Azure AI Search for agent support, use Foundry Tools. If you need to train and deploy machine learning models with your own data, use Microsoft Fabric if you already work in that environment; otherwise, use Azure Machine Learning. Use Azure Container Apps for lightweight AI inferencing without managing GPU infrastructure (regional availability and feature status varies; verify current serverless GPU support). If you need to bring your own models, use Azure Virtual Machines (optionally with Azure CycleCloud or Azure Batch) or Azure Kubernetes Service for containerized workloads.
:::image-end:::

### Microsoft Copilots (SaaS agents)

Microsoft ready-to-use AI solutions, called Copilots, raise efficiency quickly because they need little setup and work with data you already have. Microsoft 365 Copilot adds AI assistance across Office apps. In-product and role based Copilots focus on specific job roles and industries. **Tradeoff**: Copilots deliver the fastest results, but they offer less customization than a custom solution.

| Microsoft Copilots | Description | User | Data needed | Skills required | Main cost factors |
|---------------------|-------------|------|-------------|-----------------|-------------------|
| [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) | Web-grounded and Work IQ grounded chat and in-app help across Microsoft 365, grounded in your Microsoft data. | Business | [Apply](/azure/cloud-adoption-framework/data/governance-security-baselines-purview-data-estate-unify-data-platform#14-apply-sensitivity-labels) protective sensitivity labels to Microsoft 365 data so protection follows the content.. | General IT and data management | [Per-user license](https://www.microsoft.com/microsoft-365-copilot/pricing) |
| Role-based Copilots and agents | Role-specific help for [Security](/copilot/security/microsoft-security-copilot), [Sales agent](/microsoft-sales-copilot/sales-chat-overview), [Service](/microsoft-copilot-service/about-microsoft-copilot-for-service), and [Finance agent](/copilot/finance/welcome). | Business | Yes. Data-connection and plug-in options are available. | General IT and data management | Microsoft 364 Copilot access or [Security Compute Units (SCUs) for Security Copilot](https://azure.microsoft.com/pricing/details/microsoft-security-copilot) |
| In-product Copilots and agents | AI inside products such as [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](/power-apps/maker/canvas-apps/ai-overview), [Power BI](/power-bi/create-reports/copilot-introduction), [Dynamics 365](/dynamics365/copilot/ai-get-started), [Power Automate](/power-automate/copilot-overview), [Microsoft Fabric](/fabric/fundamentals/copilot-fabric-overview), [Microsoft Entra](/entra/fundamentals/copilot-entra-agents), and [Azure](/azure/copilot/overview). | Business and individual | Yes. Most require minimal data preparation. | Minimal (basic admin configuration and data readiness) | Free or subscription |
|[Microsoft Copilot](https://copilot.microsoft.com/) | Microsoft Copilot is a free web-grounded chat app. | Individual | No | None | Free |

<a name='ai-on-low-code-platforms'></a>

### SaaS AI development platforms (low-code)

Microsoft provides SaaS development options to build AI agents. Copilot Studio lets business users create AI assistants with natural language, while Microsoft 365 Copilot extensions let you customize enterprise Copilot with company-specific data and processes. **Tradeoff**: SaaS development platforms open development to business teams, but heavy customization reaches limits and might require a move to a managed platform.

| Platform | Description | User | Data needed | Skills required | Main cost factors |
|---------------------|-------------|------|-------------|-----------------|-------------------|
| Copilot Studio | Use [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) to build conversational AI agents and automation workflows with low-code tools and natural language. | IT | Automates much of the data integration to create custom copilots with connections to various data sources. | Platform configuration to connect data sources, design conversational flows, and deploy copilots | [License](https://www.microsoft.com/microsoft-365-copilot/pricing/copilot-studio) |
| Extensibility tools for Microsoft 365 Copilot | [Customize](/microsoft-365-copilot/extensibility/) Microsoft 365 Copilot with more data or capabilities via declarative agents. Use tools like [Copilot Studio](/microsoft-copilot-studio/microsoft-copilot-extend-copilot-extensions?context=%2Fmicrosoft-365-copilot%2Fextensibility%2Fcontext), [Agent Builder](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder), and [Agents Toolkit](/microsoft-365-copilot/extensibility/build-declarative-agents). | Business and individual | Use [Microsoft 365 Copilot connectors](/microsoft-365-copilot/extensibility/overview-graph-connector) to add data. | Data management, general IT, or developer skills | [Microsoft 365 Copilot license](/microsoft-365-copilot/extensibility/faq#license-questions) |

### AI on Azure platforms (PaaS)

Platform as a service is the starting point for most custom apps and agents. Choose it when low-code SaaS development can't give you enough customization but you still want Microsoft to run the platform for you. You get a managed environment to build custom agents and models. This work takes more effort than SaaS development but less effort than running infrastructure yourself. Microsoft manages the platform and you don't maintain servers or train the base models. **Tradeoff**: A managed platform gives you more control than SaaS development, but it requires engineering skill that SaaS development options don't.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Build agents | [Microsoft Foundry Agent Service](/azure/ai-foundry/agents/overview) | Yes | Agent type selection, adding tools and data, debugging with traces, evaluation, optimization, publish, monitor. See [Agent lifecycle](/azure/foundry/agents/concepts/development-lifecycle) | Consuming model tokens, storage, features, compute, grounding connections |
| Build RAG applications | [Foundry](/azure/foundry/concepts/retrieval-augmented-generation) | Yes | Select models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune GenAI models | [Foundry](/azure/foundry/openai/concepts/fine-tuning-considerations) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference models | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) <br>or<br> [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume prebuilt AI models and services | [Foundry Tools](/azure/foundry/agents/concepts/tool-catalog)| Yes | Select AI models, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |
| Isolate AI apps | [Azure Container Apps with serverless GPU support](/azure/container-apps/gpu-serverless-overview) | Yes | Select AI models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, prompt engineering, deploying endpoints, and consuming endpoints in apps; optional environment/VNet configuration for network isolation (regional availability and feature status may vary) | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |

See the individual pricing pages for products listed under [AI + machine learning](https://azure.microsoft.com/products/#ai-machine-learning) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to generate cost estimates.

<a name='ai-on-azure-infrastructure-services-iaas'></a>

### AI on Azure infrastructure

Azure infrastructure gives you full control over your own models and runtimes. It typically takes the longest to build and requires the most effort to maintain over time. Choose this option when you must bring your own models, use custom runtimes, or meet performance and compliance needs that managed platforms can't. **Tradeoff**: Infrastructure offers the most control, but it carries the most operational ownership.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|----|-------------| ---------| ---- |
| Train and run your own models on infrastructure you manage | [AI on Azure infrastructure](/azure/cloud-adoption-framework/ai/infrastructure/ai-azure-infrastructure) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestrator, managed disks (optional), storage services, Azure Bastion, and other Azure services used |

See GPU prices with [Linux](https://azure.microsoft.com//pricing/details/virtual-machines/linux/) and [Windows](https://azure.microsoft.com/pricing/details/virtual-machines/windows/) virtual machines. Use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) for estimates.

## 3. Responsible AI strategy

Whatever model and budget you choose in the steps above, responsible use is a condition of running AI in production at scale. Your organization needs to set the standards that keep AI fair and accountable for every team. The models you selected determine where these standards apply, but the standards themselves stay constant across the organization. Build on the Microsoft guidance for responsible AI rather than define those standards here. See the CAF guidance to create [Responsible AI policies](./responsible-ai-policies.md) to put a consistent framework in place.

## 4. Data strategy

A responsible AI standard is only as strong as the data behind it, so your data strategy comes next. Your data strategy determines whether your priority use cases have governed and high-quality data to work with. A durable strategy sources and classifies data and keeps it compliant as AI spreads across Microsoft 365 and Azure. Concentrate on governance baselines and lifecycle management rather than per-workload design. See the CAF guidance to create a  [Data strategy for AI and analytics](/azure/cloud-adoption-framework/data/executive-strategy-unify-data-platform).

## 5. How to adopt AI

With the strategy set, move to planning and readiness. The AI adoption guidance provides startup and enterprise checklists that carry each decision above into production with governance and security built in.

| AI adoption step | Applicable AI technology | Startup checklist | Enterprise checklist |
| --- | --- | --- | --- |
| [AI Plan](../scenarios/ai/plan.md) | Copilots<br>Azure | &#9744; [Access AI resources](./plan.md#access-ai-resources) <br> &#9744; [Establish responsible AI](./plan.md#implement-responsible-ai) | &#9744; [Assess AI skills](./plan.md#assess-ai-skills) <br> &#9744; [Acquire AI skills](./plan.md#acquire-ai-skills) <br> &#9744; [Access AI resources](./plan.md#access-ai-resources) <br> &#9744; [Prioritize AI use cases](./plan.md#prioritize-ai-use-cases) <br> &#9744; [Create an AI proof of concept](./plan.md#create-ai-proof-of-concepts) <br> &#9744; [Implement responsible AI](./plan.md#implement-responsible-ai)|
| [AI Ready](../scenarios/ai/ready.md) | Azure | &#9744; [Build an AI environment](./ready.md#build-an-ai-environment) <br> &#9744; [Choose an architecture](../scenarios/ai/platform/architectures.md) | &#9744; [AI governance](./ready.md#ai-governance) <br> &#9744; [AI networking](./ready.md#ai-networking) <br> &#9744; [AI reliability](./ready.md#ai-reliability) <br> &#9744; [AI foundation](./ready.md#ai-foundation) <br> &#9744; [Choose an architecture](../scenarios/ai/platform/architectures.md) <br> &#9744; [Use AI design areas](../scenarios/ai/platform/resource-selection.md) |
| [Govern AI](../scenarios/ai/govern.md) | Copilots<br>Azure | &#9744; [Enforce AI governance policies](./govern.md#3-enforce-ai-governance-policies) | &#9744; [Assess AI organizational risks](./govern.md#1-assess-ai-organizational-risks) <br> &#9744; [Document AI governance policies](./govern.md#2-document-ai-governance-policies) <br> &#9744; [Enforce AI policies](./govern.md#3-enforce-ai-governance-policies) <br> &#9744; [Monitor AI organizational risks](./govern.md#4-monitor-ai-organizational-risks) |
| [Secure AI](../scenarios/ai/secure.md) | Copilots<br>Azure | &#9744; [Protect AI resources and data](./secure.md#protect-ai-resources-and-data) | &#9744; [Discover AI security risks](./secure.md#discover-ai-security-risks) <br> &#9744; [Protect AI resources and data](./secure.md#protect-ai-resources-and-data) <br> &#9744; [Detect AI security threats](./secure.md#detect-ai-security-threats) |
| [Manage AI](../scenarios/ai/manage.md) | Copilots<br>Azure | &#9744; [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) | &#9744; [Manage AI operations](./manage.md#manage-ai-operations) <br> &#9744; [Manage AI deployment](./manage.md#manage-ai-deployment) <br> &#9744; [Manage AI models](./manage.md#manage-ai-models) <br> &#9744; [Manage AI costs](./manage.md#manage-ai-costs) <br> &#9744; [Manage AI data](./manage.md#manage-ai-data) <br> &#9744; [Manage AI business continuity](./manage.md#manage-ai-business-continuity) |

## Next step

> [!div class="nextstepaction"]
> [AI Plan](../scenarios/ai/plan.md)
