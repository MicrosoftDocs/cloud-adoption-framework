---
title: Architecture and governance for AI agents
ms.reviewer: ssumner
description: Learn how to govern AI agents across your organization.
#customer intent: As a platform owner, governance lead, decision maker, I want to know how to govern AI agents across my platform and organization.
author: stephen-sumner
ms.author: pnp
ms.date: 11/09/2026
ms.update-cycle: 180-days
ms.topic: concept-article
ai-usage: ai-assisted
---

# Architecture and governance for AI agents

*This article helps decision makers decide how to govern AI agents across their organization.*

:::image type="complex" border="false" source="./images/ai-agent-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for AI agent adoption." lightbox="./images/ai-agent-adoption-process.svg":::
    Diagram showing the phases of AI agent adoption process: Organizational readiness, Architecture and governance, and operational standards.
:::image-end:::

AI agents introduce new architectural requirements and governance risks as they gain access to enterprise systems and perform actions autonomously. Organizations should extend their existing architecture and governance frameworks to support AI agents rather than establish separate systems.

**Outcome**: By the end of architecture and governance planning, your organization should have defined architectural standards and governance policies that support secure AI agent deployment across the enterprise.

## AI architecture and decision tree

# [Conceptual](#tab/conceptual)

:::image type="complex" source="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" alt-text="Diagram showing a conceptual view of an Azure landing zone." lightbox="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above a workload landing zones section. The workload landing zones section contains three workload landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the workload landing zones, indicating optional AI capabilities for selected workloads.
:::image-end:::

*AI in an Azure landing zone. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Decision tree](#tab/decisiontree)

:::image type="complex" source="./images/ai-agent-decision-tree.svg" alt-text="Decision tree diagram for selecting AI agent solutions based on business and technology requirements." lightbox="./images/ai-agent-decision-tree.svg" border="false":::
    A decision tree that guides organizations through decisions about when and how to use AI agents. It starts with "Potential agent use case" and branches into multiple decision paths. The business plan path determines if AI agents should be used. If the answer is "No," the path leads to "Use code or nongenerative AI models" with icons for GitHub, Microsoft Fabric, AI models in Foundry, and Machine Learning. If Yes, it asks if the task involves static question or answer or content generation without reasoning. The technology plan path checks if SaaS agents meet functional requirements. If Yes, the path leads to Use SaaS agents. There are icons representing Microsoft 365 Copilot agents (App Builder, Workflows, Researcher, Analyst, Surveys). Then there are icons for GitHub Copilot agent, Microsoft Fabric data agents, Azure Copilot agents, Dynamics 365 agents, and Security Copilot agents. If SaaS agents don't meet needs, the path leads to "Build AI agents" with options for GPUs & Containers (IaaS), Microsoft Foundry (PaaS pro-code), and Copilot Studio (SaaS no/low-code). You start with multiple-agent systems if the use case crosses security and compliance boundaries, has multiple teams involved, or you know there's going to be future growth of this system. Unless the system is low complexity, all other use cases should start with a single agent test to see if it could meet your requirements. Depending on the result, you'll align with a multi-agent system or single-agent system.
:::image-end:::
*AI agent decision tree.*

---

## 1. Azure landing zone architecture

*How should we update our Azure landing zone?* AI agents hosted in Azure should follow your existing Azure landing zone architecture. Organizations need to determine whether their current platform standards support AI workloads and where agent infrastructure belongs.

- **Platform landing zone**: Agents hosted in Azure should follow the existing platform landing zone resource hierarchy. They don't need separate management groups. The platform team should use Azure Policy definitions to cover AI-specific infrastructure, such as Foundry resources and Azure infrastructure. Azure Policy enforces these rules across subscriptions.

- **Workload landing zones**: Agent resources should reside in workload landing zone subscriptions. Shared agent infrastructure can serve multiple workloads without becoming a platform landing zone resource. Organizations can assign a dedicated team to manage shared infrastructure and establish access policies for consuming workloads. Workload teams should manage their agent resources under existing workload governance standards.

See [Architecture for AI](../scenarios/ai/ready.md).

## 2. Governance

*How should we govern agents?* Agent governance establishes the policies that determine which agents can operate and what they're permitted to do. Extend existing governance frameworks and apply additional controls based on agent risk. Central functions should establish mandatory boundaries. Platform and workload teams should manage agents within those boundaries. Governance should be based on risk. Autonomy level and impact of incorrect action factors determine an agent's risk. 

### 2.1 Responsible AI

*How should we use agents responsibly?* Existing responsible AI policies should apply to all agents. Your organization should extend these policies to address autonomous actions and their potential consequences. An agent that makes consequential business decisions might require additional oversight and human approval. See [Responsible AI policies](../ai/responsible-ai-policies.md).

### 2.2 Sovereignty 

*How should we meet sovereignty requirements?* Your organization should extend existing sovereignty policies to AI agents based on applicable regulatory and contractual obligations. Evaluate where agent data is stored and processed, including data exchanged with models and connected services. Agent platforms and deployment configurations must support the required geographic and operational boundaries. Where a platform can't meet these requirements, workload teams should select an alternative deployment option or restrict the agent's use. See [Architecture and governance for sovereignty](/azure/cloud-adoption-framework/sovereignty/azure-landing-zone-architecture-governance). 

### 2.3 Centralized control

*How should we control agents centrally?* Your organization needs centralized visibility across agent platforms. Centralized visibility doesn't require central approval of every agent. Microsoft Agent 365 provides a common management experience for Microsoft agents and agents from supported third-party platforms. [Connected platforms in Microsoft Agent 365](/microsoft-agent-365/admin/connected-platforms)  lists current coverage. Agents outside this coverage rely on platform-native management capabilities.

- **Centralized visibility**: Every agent should be discoverable through an approved inventory process. [Microsoft Agent 365 Agent Registry](/microsoft-agent-365/admin/agent-registry-overview) discovers and manages agents within its coverage. Governance teams should add inventory data from other platforms so the inventory stays complete. Each inventory entry should identify the agent's accountable owner and risk classification.

- **Lifecycle control**: Your organization should establish consistent policies for agent visibility, access, distribution, and retirement across the tenant. The [Microsoft 365 admin center](/microsoft-agent-365/admin/agent-actions) provides governance and lifecycle management capabilities for agents through the Microsoft Agent 365 Agent Registry.

### 2.4 Data governance

*How should we govern agent data?* Data governance teams should define which data classifications agents can access and whether agents can use that information in external services. Workload teams should enforce these requirements through source-system permissions and supported platform controls. Use Microsoft Purview to apply supported data protection and compliance capabilities. See [Data governance](/azure/cloud-adoption-framework/data/data-governance-unified-data-platform?tabs=purview).

### 2.5 Security governance

*How should we secure agents?* Your organization should extend its existing security policies to address agent identities and autonomous access to enterprise systems. Security requirements should reflect the permissions agents receive and the consequences of unauthorized actions. Agent permissions should reflect the actions the agent is authorized to perform, not the maximum access its platform supports.

- **Agent identity**: Agent access should follow least privilege, and owners should review permissions periodically. Agents that act on behalf of users should respect delegated permissions. Autonomous agents should receive only the permissions their approved activities require. For example, an agent that summarizes support tickets needs read access to the ticketing system, not write access. [Microsoft Entra Agent ID](/entra/agent-id/what-is-microsoft-entra-agent-id) provides identity and access governance for supported agents.

- **Threat protection**: Security teams should extend existing threat detection and incident response processes to agents. Security policies should address agent-specific threats, such as prompt injection. Microsoft Agent 365 security capabilities extend Microsoft Entra access controls and Microsoft Defender threat protection where supported. AI threat protection in Microsoft Defender for Cloud covers agents hosted on Azure AI services. See [Microsoft Agent 365 security capabilities](/security/security-for-ai/agent-365-security?toc=/microsoft-agent-365/toc.json&bc=/microsoft-agent-365/breadcrumb/agent365/toc.json).

## Next step

> [!div class="nextstepaction"]
> [Operational standards for AI agents](./architecture-governance.md)