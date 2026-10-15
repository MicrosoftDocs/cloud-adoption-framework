---
title: AI adoption
description: Understand AI and how Microsoft's AI solutions can meet your organization's needs. 
#customer intent: As a decision maker I want guidance to help align AI investments with business goals across my organization.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 06/26/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# AI adoption

*This article provides an executive overview of Microsoft AI solutions and helps decision makers determine how their organization should adopt AI.*

Organizations are investing in AI to create business value. The challenge is determining where AI can deliver value and whether that value justifies the investment. Without a clear strategy, teams can experiment without producing enough value and AI investment can become fragmented.

Microsoft AI solutions address different business needs and provide different levels of customization. This range gives organizations options to align AI investments with the value they expect to achieve.

**Outcome:** This guidance helps decision makers establish the foundation for AI adoption and determine where their organization should invest.

## AI decision tree and architectures

# [AI decision tree](#tab/decisiontree)

:::image type="complex" source="./images/ai-decision-tree.svg" alt-text="Diagram showing Microsoft and Azure services with decision points for each service." lightbox="./images/ai-decision-tree.svg" border="false":::
    Start by identifying the AI use case. If the goal is to enhance individual productivity, use Microsoft 365 Copilot for Microsoft 365 apps. Use in-product Copilots for products like Azure, GitHub, Fabric, Dynamics 365, or Power Platform. Use role-aligned Copilots for roles such as security, sales, service, or finance. If the use case is general, use Microsoft Copilot. If you already use Microsoft 365 Copilot and need custom agents with domain-specific skills, use extensibility tools for Microsoft 365 Copilot. If the goal is to automate business functionality, use Copilot Studio as a SaaS tool that enables agent creation and deployment through natural language with integrated pricing. Use Foundry as a development platform with API access to Foundry Tools. If you need prebuilt non-generative models or Azure AI Search for agent support, use Foundry Tools. If you need to train and deploy machine learning models with your own data, use Microsoft Fabric if you already work in that environment; otherwise, use Azure Machine Learning. Use Azure Container Apps for lightweight AI inferencing without managing GPU infrastructure (regional availability and feature status varies; verify current serverless GPU support). If you need to bring your own models, use Azure Virtual Machines (optionally with Azure CycleCloud or Azure Batch) or Azure Kubernetes Service for containerized workloads.
:::image-end:::

*Microsoft AI decision tree.*

# [Conceptual](#tab/conceptual)

:::image type="complex" source="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" alt-text="Diagram showing a conceptual view of an Azure landing zone." lightbox="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above a workload landing zones section. The workload landing zones section contains three workload landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the workload landing zones, indicating optional AI capabilities for selected workloads.
:::image-end:::

*AI in an Azure landing zone. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Conceptual + integration](#tab/conceptualintegration)

:::image type="complex" source="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture-enterprise-integration.svg" alt-text="Diagram showing a conceptual Azure landing zone architecture and how it integrates with your Microsoft enterprise architecture." lightbox="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture-enterprise-integration.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above a workload landing zones section. The workload landing zones section contains three workload landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the workload landing zones, indicating optional AI capabilities for selected workloads. Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*AI in an Azure landing zone plus enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

---

## 1. What is AI?

Artificial intelligence (AI) uses algorithms to analyze data and produce results. Many AI models learn patterns from existing data and use those patterns to process new information and produce results. AI capabilities generally fall into three broad areas:

- **Traditional AI (nongenerative)**: Analyzes data and produces results for a defined purpose, such as making predictions, classifying information, and detecting anomalies.

- **Generative AI**: Creates new content or responses based on a user's request and available context. Common uses include drafting content, answering questions, summarizing information, generating code, and assisting employees with their work.

- **Agentic AI**: Uses AI models with instructions and tools to pursue a goal and complete tasks. Agents can interpret requests, determine what to do, and use connected systems to take actions within defined permissions and controls.

These types can work together. For example, an agent might use generative AI to interpret a request and traditional AI to make a prediction before taking an authorized action. The business decision is therefore not simply whether to adopt AI. It is where AI can create value and which level of capability is appropriate for each use case.

## 2. Foundation of AI adoption

*What should leadership do first?* Successful AI adoption requires more than selecting the right technology. Leaders need to create the organizational conditions that allow teams to use AI productively and responsibly. Start with three actions:

- **Lead AI adoption**: *How should leaders guide AI adoption?* AI adoption works best when executive leaders establish a common direction for the organization. Leaders should define the business outcomes that AI is expected to support and provide visible sponsorship for those priorities. An AI strategy or charter should document organizational priorities and decision rights. It should also define how the organization measures the value of AI investments.

- **Centralize AI governance**: *What should we centralize?* AI creates governance decisions that apply across the organization. Successful organizations establish central ownership for organization-wide AI policies and standards. A central governance function, such as an AI Center of Excellence, can define Responsible AI requirements and common boundaries. Business groups can then pursue AI opportunities within those boundaries. See [Responsible AI Policies](./responsible-ai-policies.md).

- **Workforce access**: *Who should have access to AI?* Broad access to approved AI capabilities can help organizations identify valuable uses for AI and build organizational experience. Employees understand the business processes they perform every day and can identify opportunities where AI might improve their work. Organizations should pair access with training so employees understand how to use approved AI capabilities effectively and responsibly.

<a name='define-an-ai-technology-strategy'></a>
<a name='ai-technology-strategy'></a>

## 3. What AI should we use?

*What AI solutions should we make available?* Organizations generally adopt AI for two broad purposes:

- **Enhance individual efficiency**: AI helps employees complete work more effectively through capabilities such as drafting, research, meeting preparation, and information discovery.

- **Automate business functionality**: AI helps organizations augment or automate business functionality through capabilities such as agents, forecasting, and decision support.

Microsoft provides solutions for both purposes. Organizations should approve the solution that meets their requirements with the least operational responsibility. Greater customization generally requires more specialized skills and greater operational ownership. Use the [Microsoft AI decision tree](#ai-decision-tree-and-architectures).

### 3.1 Enhance individual efficiency

*Do you want to enhance individual efficiency?* If the goal is to improve how employees work, identify where you need assistance. Microsoft provides AI experiences that can support employees across the organization, within specific products, or within specific roles.

| AI solution | When to use | Main cost factors |
|-------------|-------------|-------------------|
| [Microsoft Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) | Use when you need to enhance individual efficiency across the organization with AI grounded in work and web context. | [License](https://www.microsoft.com/copilot/pricing/business)
| In-product Copilots and agents | When you need AI productivity assistance in [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](/power-apps/maker/canvas-apps/ai-overview), [Power BI](/power-bi/create-reports/copilot-introduction), [Dynamics 365](/dynamics365/copilot/ai-get-started), [Power Automate](/power-automate/copilot-overview), [Microsoft Fabric](/fabric/fundamentals/copilot-fabric-overview), [Microsoft Entra](/entra/fundamentals/copilot-entra-agents), and [Azure](/azure/copilot/overview). | Base product subscription or included |
| Role-based Copilots and agents | When you need role-specific help for [Security](/copilot/security/microsoft-security-copilot), [Sales agent](/microsoft-sales-copilot/sales-chat-overview), [Service](/microsoft-copilot-service/about-microsoft-copilot-for-service), and [Finance agent](/copilot/finance/welcome). | License or included |
|[Copilot chat](https://copilot.microsoft.com/) | Use when you need secure AI chat grounded primarily in web data and don't need the full licensed Microsoft Copilot experience. | Free |

### 3.2 Automate business functionality

*Do you want to automate business functionality?* If the goal is to augment or automate business processes, choose the AI solution that provides the required level of customization with the lowest operational responsibility.

<a name='ai-on-low-code-platforms'></a>

#### 3.2.1 AI on SaaS platforms

*Do you want to make SaaS (low-code, no-code) AI development platforms available?* SaaS and low-code platforms reduce the technical effort required to create AI capabilities. Start with these AI options when they provide enough customization for the business need. Microsoft Copilot Studio provides a managed platform for creating agents and connecting them to organizational data and systems.

| AI solution | When to use | Main cost factors |
|-------------|-------------|-------------------|
| [Extensibility tools](/microsoft-365-copilot/extensibility/) for Microsoft Copilot | Use when your organization uses Microsoft Copilot and needs to customize it with specialized knowledge and agents. | [Microsoft Copilot licensing and metered usage](/microsoft-365/copilot/extensibility/cost-considerations) |
| [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) | Use when you need a managed SaaS platform to create and deploy agents with low-code or natural-language development. | [Credits based on agent usage](/microsoft-copilot-studio/requirements-messages-management) |

#### 3.2.2 AI on Azure platforms (PaaS)

*Do you want to build AI with Azure platform-as-a-service solutions?* Managed Azure AI platforms provide greater customization than SaaS development without requiring organizations to manage the underlying compute infrastructure directly. Use this approach when SaaS capabilities don't provide enough control over models, application logic, data integration, or AI development.

| AI solution | When to use | Main cost factors |
|---|---|---|
| [Microsoft Foundry](/azure/foundry/what-is-foundry) | Use when you need a managed Azure platform to build custom AI applications and agents. | [Model usage](https://azure.microsoft.com/pricing/details/ai-foundry-models/microsoft/) and other tool usage |
| [Microsoft Fabric](/fabric/fundamentals/microsoft-fabric-overview) | Use when you need to train and deploy machine-learning models in Microsoft Fabric and your organization already uses Fabric for its data and analytics. | [Compute (capacity), storage, replication](/azure/cloud-adoption-framework/data/executive-strategy-unify-data-platform?tabs=conceptual#what-level-of-investment-is-required) |
| [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) | Use when you need to train and deploy machine-learning models on Azure using your own data. | [Compute](https://azure.microsoft.com/pricing/details/machine-learning/#pricing) and supporting components like storage and data transfer |
| [Azure Container Apps with serverless GPU support](/azure/container-apps/gpu-serverless-overview) | Use when you need to run AI inference or small models on GPU compute without managing GPU virtual machines. | [Compute](https://azure.microsoft.com/pricing/details/container-apps/) and supporting components like model usage, storage, and data transfer |

<a name='ai-on-azure-infrastructure-services-iaas'></a>

#### 3.2.3 AI on Azure infrastructure

Azure infrastructure shouldn't be the default approach for AI adoption. Use managed AI platforms when they meet business and technical requirements. Azure infrastructure is appropriate when the organization requires control over models or runtime environments that managed platforms can't provide. It can also support specialized performance or compliance requirements. Organizations that choose this approach must plan for greater technical expertise and ongoing operational responsibility.

| AI solution | When to use | Main cost factors |
|---|---|---|
| [AI on Azure infrastructure](/azure/cloud-adoption-framework/ai/infrastructure/ai-azure-infrastructure) | Use when you need to bring your own AI models or runtimes to Azure and require control that managed AI platforms don't provide. | [Compute](https://azure.microsoft.com/pricing/details/virtual-machines/windows/) and supporting components like model usage, storage, and data transfer |

## 4. How to prepare an AI data foundation

*How should data support AI?* AI doesn't require organizations to create an entirely new data strategy before adoption begins. The data capabilities required depend on the AI solutions and use cases the organization adopts. Identify the organizational data each AI capability requires, and ensure that you can access the data securely and govern it appropriately. For guidance, see [Unified data platform for AI and Analytics](/azure/cloud-adoption-framework/data/executive-strategy-unify-data-platform).

## 5. How to adopt AI

Microsoft's Cloud Adoption Framework gives you a structured path, and you can distill it into steps for AI adoption. Each step builds on the one before it.

:::image type="content" source="./images/ai-adoption-process.svg" alt-text="Diagram that shows the phases of AI adoption: Plan, Ready, Govern, Secure, Manage." lightbox="./images/ai-adoption-process.svg" border="false":::

- **[AI planning](./plan.md)**: Turn AI use cases into a plan for moving them into production.
- **[AI ready](./ready.md)**: Learn how AI workloads fit into your Azure landing zone and determine whether your architecture or governance needs to change.
- **[AI govern, secure, manage](./responsible-ai-policies.md)**: Establish standards for governing, securing, and managing AI workloads.
