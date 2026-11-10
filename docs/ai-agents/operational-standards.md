---
title: Operational standards for AI agents
ms.reviewer: ssumner
description: Learn how to establish operational standards for AI agent development, testing, deployment, monitoring, and cost management.
#customer intent: As a decision maker, I want to establish consistent operational standards for AI agents across my organization. I need to define how teams develop, evaluate, deploy, monitor, and manage agent costs throughout their lifecycle.
author: stephen-sumner
ms.author: pnp
ms.date: 11/09/2026
ms.update-cycle: 180-days
ms.topic: concept-article
ai-usage: ai-assisted
---

# Operational standards for AI agents

*This article helps decision makers establish consistent operational standards for AI agents across their organization.* 

:::image type="complex" border="false" source="./images/ai-agent-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for AI agent adoption." lightbox="./images/ai-agent-adoption-process.svg":::
    Diagram showing the phases of AI agent adoption process: Organizational readiness, Architecture and governance, and operational standards.
:::image-end:::

Operational standards for AI agents are the common requirements that govern how teams build and run agents. Agents need these standards because they make decisions and execute actions. Standards help teams develop reliable agents and manage their behavior throughout their lifecycle. This guidance helps decision makers establish common requirements across agent platforms.

Operational standards should apply across prebuilt and custom agents where relevant. Each platform provides its own controls. Employee-created agents and engineering-managed solutions need different implementation requirements. Not every standard requires the same implementation across all agent types.

**Outcome**: By the end of defining your operational standards, your organization should have established consistent requirements for developing and operating AI agents safely and efficiently at scale.

## AI agent decision tree and architecture

# [Decision tree](#tab/decisiontree)

:::image type="complex" source="./images/ai-agent-decision-tree.svg" alt-text="Decision tree diagram for selecting AI agent solutions based on business and technology requirements." lightbox="./images/ai-agent-decision-tree.svg" border="false":::
    A decision tree that guides organizations through decisions about when and how to use AI agents. It starts with "Potential agent use case" and branches into multiple decision paths. The business plan path determines if AI agents should be used. If the answer is "No," the path leads to "Use code or nongenerative AI models" with icons for GitHub, Microsoft Fabric, AI models in Foundry, and Machine Learning. If Yes, it asks if the task involves static question or answer or content generation without reasoning. The technology plan path checks if SaaS agents meet functional requirements. If Yes, the path leads to Use SaaS agents. There are icons representing Microsoft 365 Copilot agents (App Builder, Workflows, Researcher, Analyst, Surveys). Then there are icons for GitHub Copilot agent, Microsoft Fabric data agents, Azure Copilot agents, Dynamics 365 agents, and Security Copilot agents. If SaaS agents don't meet needs, the path leads to "Build AI agents" with options for GPUs & Containers (IaaS), Microsoft Foundry (PaaS pro-code), and Copilot Studio (SaaS no/low-code). You start with multiple-agent systems if the use case crosses security and compliance boundaries, has multiple teams involved, or you know there's going to be future growth of this system. Unless the system is low complexity, all other use cases should start with a single agent test to see if it could meet your requirements. Depending on the result, you'll align with a multi-agent system or single-agent system.
:::image-end:::
*AI agent decision tree.*

# [Conceptual](#tab/conceptual)

:::image type="complex" source="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" alt-text="Diagram showing a conceptual view of an Azure landing zone." lightbox="../ready/landing-zone/media/azure-landing-zone-conceptual-architecture.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above a workload landing zones section. The workload landing zones section contains three workload landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the workload landing zones, indicating optional AI capabilities for selected workloads.
:::image-end:::

*AI in an Azure landing zone. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

---

## 1. Development

*What organization-wide standards should we consider for agent development?* Development standards establish common requirements for agent capabilities without prescribing how teams build individual agents. These standards matter because inconsistent choices across teams multiply risk and support costs. The central decision is which capabilities need organizational restrictions and which choices teams can make independently. Standards that restrict too much push creators toward unapproved tools. Standards that restrict too little leave risk unmanaged.

### 1.1 Knowledge and actions

*What organization-wide standards should we consider for agent knowledge and actions?* Knowledge sources provide information that agents use to complete tasks. Tools allow agents to interact with systems and perform actions. Development standards should set boundaries for both capabilities without central approval for every integration.

- **Knowledge access**: Organizations should allow agents to access knowledge sources permitted by existing data governance policies. Additional approval should apply when access introduces risks that existing policies don't address. This approach avoids creating separate approval processes for routine integrations.

- **Action permissions**: Organizations should establish standards for which actions agents can execute autonomously. Routine actions can operate within approved permissions. Actions with significant business consequences might require additional restrictions or human approval. The appropriate controls depend on the potential impact of an incorrect action.

**Platform capabilities**: For Foundry, [Skills](/azure/foundry/agents/how-to/tools/skills) describes how builders package approved capabilities. For Copilot Studio, [Knowledge](/microsoft-copilot-studio/knowledge-copilot-studio) and [Tools](/microsoft-copilot-studio/agents-experience/tools-overview) describe how agents connect to approved sources and actions. [Skills in Copilot Studio](/microsoft-copilot-studio/agents-experience/skills-overview) covers reusable capabilities.

### 1.2 Model selection

*What organization-wide standards should we consider for AI model selection?* AI models determine how agents interpret information and generate responses. Model standards should prevent the use of models that fail organizational requirements without unnecessarily restricting teams to a small set of approved options. Organizations can control model selection in custom development platforms but have fewer choices in prebuilt SaaS agents.

- **Model governance**: Central governance should prohibit models that fail known organizational requirements. Other models can remain available when they satisfy established policies, such as requirements for model providers or data processing locations. This approach allows teams to select compliant models without requiring individual approval for every model. Enforcing these policies might require different controls across agent platforms.

- **Model provisioning**: Central provisioning is appropriate when many teams use the same models and shared management provides operational or financial benefits. Decentralized provisioning is appropriate when teams need specialized models or different deployment configurations. Organizations can combine both approaches by offering shared models as defaults and allowing other compliant models when necessary.

**Platform capabilities**: For Foundry, see [Foundry Models sold by Azure](/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure). For Copilot Studio, see [Choose a primary AI model](/microsoft-copilot-studio/authoring-select-agent-model) or [Bring your own model for your prompts](/microsoft-copilot-studio/bring-your-own-model-prompts).

### 1.3 Memory

*What organization-wide standards should we consider for agent memory?* Agent memory allows agents to retain information across interactions. Memory standards define what information agents can retain and how teams must protect it. These requirements should extend existing data governance and retention policies. Agent memory shouldn't outlast the business need or applicable retention requirements.

**Platform capabilities**: For Foundry, [Memory](/azure/foundry/agents/concepts/what-is-memory) and [Standard agent setup](/azure/ai-foundry/agents/concepts/standard-agent-setup) describe the options. [Memory in Copilot Studio](/microsoft-copilot-studio/agents-experience/memory-overview-customer-conversation) explains platform behavior.

### 1.5 Runtime safeguards

*What organization-wide standards should we consider for agent safeguards?* Runtime safeguards protect agents against harmful content and attacks, such as prompt injection.

- **Baseline safeguards**: A common baseline establishes minimum protections across agent platforms. This approach simplifies enforcement and provides consistent protection. Standards should identify which safeguards must remain enabled and which settings teams can adjust. Uniform requirements improve consistency but might unnecessarily restrict some legitimate use cases.

- **Scenario-specific safeguards**: Agents with greater exposure to untrusted information or consequential actions might require stronger protections. Existing governance policies should determine when these requirements apply. This approach accommodates different business needs but requires teams to apply the relevant controls consistently.

- **Exceptions**: Standards should establish how teams request exceptions to mandatory safeguards. Exceptions require documented justification and appropriate compensating controls. Some safeguards might remain mandatory without exception.

**Platform capabilities**: For Foundry, see [Guardrails and control overview](/azure/foundry/guardrails/guardrails-overview). For Copilot Studio, see [Copilot Studio security and governance](/microsoft-copilot-studio/security-and-governance).

### 1.6 Agent frameworks and interoperability

*What organization-wide standards should we consider for agent frameworks and interoperability?* Agent development frameworks provide the capabilities used to build and coordinate agent behavior. The development approach affects engineering responsibility and dependence on platform-specific capabilities.

- **Development approaches**: Organizations should support development approaches that meet their engineering and governance requirements. Standardizing on a limited set of frameworks can simplify support and promote reuse. Allowing multiple frameworks gives teams greater flexibility but increases the expertise required to maintain them. Organizations should establish preferred frameworks and define when teams can use alternatives.

- **Interoperability**: Organizations should establish interoperability standards where agents need to connect with shared tools or communicate across platforms. Protocols such as MCP and A2A can reduce integration complexity. Requiring these protocols for every agent can introduce unnecessary constraints. Standards should reflect actual interoperability requirements.

**Platform capabilities**: For Foundry, [Hosted agents](/azure/foundry/agents/concepts/hosted-agents) run code-based agents on managed infrastructure. [Microsoft Agent Framework](/agent-framework/overview/?pivots=programming-language-csharp) provides the code-based option in detail.

## 2. Testing and evaluation 

*How should we standardize testing and evaluation?* AI agents can execute successfully yet produce incorrect results or perform unintended actions. Testing and evaluation standards establish the evidence that teams must provide before deploying agents to production. Evaluation establishes whether an agent meets its intended outcomes. Testing establishes whether it behaves acceptably under expected and unexpected conditions. The organization needs standards for both.

### 2.1 Evaluation

*What organization-wide standards should we consider for agent evaluations?* Evaluation criteria define how teams measure whether an agent performs its intended tasks successfully. Standards should establish common evaluation expectations and require agent owners to define measurable success criteria for their business scenarios.

- **Common requirements**: All agents should demonstrate that they meet their intended purpose and operate within approved permissions. Central standards can establish minimum evaluation expectations. Agent owners should define scenario-specific criteria that reflect their business requirements. For example, knowledge agents might measure answer accuracy. An action-taking agent also needs evidence that it selects appropriate actions and respects approval boundaries.

- **Acceptance criteria**: Every production agent should have defined acceptance thresholds. Business owners should approve the criteria that determine whether an agent delivers acceptable outcomes. Agents that perform consequential actions might require additional review before deployment.

**Platform capabilities**: For Foundry, [Evaluation](/azure/foundry/concepts/evaluation-overview) describes built-in evaluators. For Copilot Studio, [Design and operationalize agent evaluation](/agents/agent-evaluation/?context=/microsoft-copilot-studio/guidance/context/context) describes the approach.

### 2.2 Testing

*What organization-wide standards should we consider for agent testing?* Testing standards define the assurance required before agents enter production. Organizations should establish minimum testing requirements for all agents and increase assurance based on the consequences of incorrect behavior. Existing software testing processes should provide the foundation, with additional requirements for agent-specific risks.

- **Baseline testing**: All production agents should demonstrate expected behavior within approved permissions. Lower-risk agents can use representative scenarios and platform-supported testing capabilities. This approach reduces approval effort but provides less assurance against unusual conditions.

- **Risk-based testing**: Agents that access sensitive information or perform consequential actions should undergo additional testing for unexpected behavior and misuse. Stronger testing improves confidence but increases delivery effort.

**Platform capabilities**: For Foundry, the [AI Red Teaming Agent](/azure/foundry/concepts/ai-red-teaming-agent) automates adversarial testing. For Copilot Studio, [Design a testing strategy for your agents](/microsoft-copilot-studio/guidance/sec-gov-phase4) describes testing practices.

## 3. Deployment and lifecycle standards

*What organization-wide standards should we consider for agent deployment and lifecycle management?* Deployment and lifecycle standards keep production agents consistent with their approved configuration. They also ensure that agents leave production cleanly when they no longer serve a purpose.

- **Release standards**: Controlled and repeatable deployment should be the organizational standard. The organization should extend existing release processes and accommodate platform-native deployment capabilities. Deployment methods can vary by platform. Expectations for configuration management and production approval stay consistent. The [Sample Solution Gallery](https://adoption.microsoft.com/sample-solution-gallery/) offers working examples of proven agent patterns.

- **Change management**: Changes that can materially affect agent behavior should trigger re-evaluation before production deployment. Model replacements and instruction updates can change agent outputs. Expanded permissions can introduce additional risks. Standards should require evaluation proportional to the potential impact rather than mandate full testing for every change.

- **Version management**: Teams should retain sufficient version history to identify changes and restore approved configurations where supported. Existing release management processes should provide the foundation for agent change control.

- **Retirement**: Standards should establish conditions that trigger agent retirement. These conditions can include loss of business ownership or unacceptable operational risk. Agents that no longer deliver sufficient value should also be considered for retirement. Retirement should disable agent execution and revoke associated permissions. Stored information should follow applicable retention requirements. Agent owners should confirm that retirement is complete.

**Platform capabilities**: For Foundry, see [Bicep](/azure/foundry/how-to/create-resource-template) and [Terraform](/azure/foundry/how-to/create-resource-terraform). For Copilot Studio, see [Copilot Studio and agent samples](/microsoft-copilot-studio/guidance/agent-samples).


## 4. Monitoring

*What organization-wide standards should we consider for agent monitoring?* Monitoring standards define what agent owners observe in production. Traditional monitoring detects outages. Agent monitoring must also detect wrong answers and unintended actions from agents that appear healthy.

### 4.1 Telemetry

*What organization-wide standards should we consider for agent telemetry?* Telemetry is the data that agents emit about their activity. Telemetry depth should scale with risk. Organizations should establish minimum visibility requirements for production agents. These requirements should support identifying usage and failures. Agents that perform consequential actions require additional records to support investigation and accountability. Detailed tracing should depend on risk and applicable data protection requirements.

For Foundry, [Observability in generative AI](/azure/foundry/concepts/observability) describes tracing. For Copilot Studio, [Monitor agent performance in Copilot Studio](/microsoft-copilot-studio/analytics-overview) describes analytics.

### 4.2 Quality

*What organization-wide standards should we consider for agent quality?* Quality monitoring checks whether production agents still meet their evaluation criteria. Organizations should establish minimum quality monitoring requirements for production agents. User-facing agents can use feedback to identify problems. Agents that perform consequential actions might require systematic evaluation of production behavior. Monitoring depth should reflect the consequences of undetected failures.

**Platform capabilities**: For Foundry, see [Observability in generative AI](/azure/foundry/concepts/observability). For Copilot Studio, see [Monitor agent performance in Copilot Studio](/microsoft-copilot-studio/analytics-overview).

## 5. Incident response

*What organization-wide standards should we consider for agent incidents?* Agent incident response defines how organizations identify and contain harmful agent behavior. Agent incidents differ from outages because a healthy agent can still take harmful actions. Leaders need to decide which failures count as incidents and who can stop an agent. Organizations should extend existing incident management processes to include agent-specific failures. Incident severity should reflect the consequences of agent actions, not just service availability.

- **Incident classification**: Organizations should define incidents involving incorrect actions or unauthorized access. Routine quality failures can follow established support processes. Failures with significant business consequences should trigger formal incident management.

- **Agent suspension**: Organizations should establish conditions that require immediate suspension or restriction of agent capabilities. High-impact failures may justify automatic containment. Lower-impact failures can follow an approved remediation process. Stronger containment reduces exposure but might interrupt business operations.

- **Recovery authority**: Incident policies should identify who can approve restoration after an agent incident. Higher-risk agents might require additional assurance before resuming operation. Recovery should depend on evidence that the underlying issue is resolved.

## 6. Cost management

*What organization-wide standards should we consider for agent cost management?* Agent cost management standards define how agent owners manage resource consumption and improve operational efficiency. Agent costs can vary significantly because a single business task might trigger multiple model requests or tool executions.

- **Spending thresholds**: Organizations should establish spending thresholds based on agent criticality and approved budgets. Experimental agents should have restrictive consumption limits to prevent unexpected costs. Business-critical agents might require higher limits and escalation procedures to avoid service interruptions.

- **Cost monitoring**: Organizations should establish consistent cost reporting across agent platforms. Reporting should provide business owners with visibility into spending against approved budgets. Where supported, consumption should be attributable to individual agents or business functions.

- **Cost efficiency**: Organizations should establish requirements for measuring agent operating costs against successful business outcomes. Cost per successful task provides a useful measure when outcomes are comparable. Teams should optimize consumption without reducing quality below approved acceptance criteria.

- **Optimization requirements**: Agent owners should periodically review operating costs against expected outcomes. Sustained cost increases or declining task success rates should trigger additional review. Agents that no longer justify their operating costs should undergo optimization or retirement.

**Platform capabilities**: For Foundry, see [Plan and manage costs](/azure/foundry/concepts/manage-costs), [Manage and increase quotas](/azure/foundry/how-to/quota), and [Agent optimizer](/azure/foundry/agents/concepts/agent-optimizer-overview). For Copilot Studio, see [Billing rates and management](/microsoft-copilot-studio/requirements-messages-management) and [View agent's billing consumption](/microsoft-copilot-studio/analytics-consumption).

## Next step

> [!div class="nextstepaction"]
> [AI workload design (WAF)](/azure/well-architected/ai/)

> [!div class="nextstepaction"]
> [AI architectures (AAC)](/azure/architecture/ai-ml/ai-get-started)