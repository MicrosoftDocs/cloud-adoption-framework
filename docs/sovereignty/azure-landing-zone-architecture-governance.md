---
title: Architecture and Governance for Sovereignty
description: "Learn how to integrate sovereignty into your Azure landing zone architecture across the public, private, and partner clouds"
#customer intent: As a cloud architect, I want to understand how sovereignty controls fit into my Azure landing zone architecture and understand what updates I need to make to my platform landing zone and application landing zones to establish a goveranace baseline.
author: stephen-sumner
ms.author: mileppo
ms.reviewer: ssumner
ms.date: 09/03/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Architecture and governance for sovereignty

*This article helps decision makers define their Azure landing zone and governance baselines across the public, private, and national partner clouds. It's the second step in the process to help decision makers with sovereignty adoption.*

:::image type="complex" border="false" source="./images/sovereignty-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for sovereignty adoption." lightbox="./images/sovereignty-adoption-process.svg":::
    Diagram showing the phases of the Microsoft Sovereign Cloud adoption process: Planning and readiness, Azure landing zone architecture and governance, and operational standards. An Azure landing zone is the prerequisite to start and each phase builds on the previous.
:::image-end:::

Sovereignty architecture and governance are the foundation for maintaining compliance over time. They establish the platform guardrails that workloads inherit and the controls used to enforce sovereignty requirements. This article builds on [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) and focuses only on the sovereign requirements that differ from standard Azure landing zone guidance. 

**Outcome**: By the end of architecture and governance planning, you have an approved target architecture, governance baseline, and implementation approach for each Microsoft Sovereign Cloud deployment model you use.

## Architectures and decision tree

# [Conceptual](#tab/conceptual)

:::image type="complex" source="./images/microsoft-sovereign-cloud-conceptual.svg" alt-text="Diagram showing a conceptual view of the three Microsoft Sovereign Cloud deployment options (Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Cloud) and sovereign workloads in an Azure landing zone." lightbox="./images/microsoft-sovereign-cloud-conceptual.svg" border="false":::
    Conceptual architecture diagram showing how an Azure landing zone supports sovereign workloads across multiple deployment models. At the center, a sovereign Azure landing zone in a sovereign public cloud contains a platform landing zone that provides shared governance and management services, along with application landing zones for individual workloads. One application landing zone hosts a sovereign public cloud workload and another hosts a sovereign private cloud workload. Microsoft 365 services, security, identity, and data governance services provide capabilities across the environment. The sovereign private cloud workload extends to an on-premises Azure Local environment, where workloads run on local hardware. A separate national partner cloud deployment model appears alongside the Azure landing zone and shows workloads running on partner-controlled infrastructure. The diagram illustrates how sovereignty controls can be applied across public cloud, private cloud, and partner-operated environments within a unified Cloud Adoption Framework architecture.
:::image-end:::

*Conceptual view of sovereign workloads across the three Microsoft Sovereign Cloud deployment options. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

# [Conceptual + integration](#tab/conceptualintegration)

:::image type="complex" source="./images/microsoft-sovereign-cloud-conceptual-enterprise-integration.svg" alt-text="Diagram showing a conceptual view of the three Microsoft Sovereign Cloud deployment options (Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Cloud), sovereign workloads in an Azure landing zone, and how it integrates with your Microsoft enterprise architecture." lightbox="./images/microsoft-sovereign-cloud-conceptual-enterprise-integration.svg" border="false":::
    Conceptual architecture diagram showing how an Azure landing zone supports sovereign workloads across multiple deployment models. At the center, a sovereign Azure landing zone in a sovereign public cloud contains a platform landing zone that provides shared governance and management services, along with application landing zones for individual workloads. One application landing zone hosts a sovereign public cloud workload and another hosts a sovereign private cloud workload. Microsoft 365 services, security, identity, and data governance services provide capabilities across the environment. The sovereign private cloud workload extends to an on-premises Azure Local environment, where workloads run on local hardware. A separate national partner cloud deployment model appears alongside the Azure landing zone and shows workloads running on partner-controlled infrastructure. The diagram illustrates how sovereignty controls can be applied across public cloud, private cloud, and partner-operated environments within a unified Cloud Adoption Framework architecture.
    Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*Conceptual view of sovereign workloads across the three Microsoft Sovereign Cloud deployment options that shows enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

# [Detailed](#tab/detailed)

:::image type="complex" source="./images/microsoft-sovereign-cloud-detailed.svg" alt-text="Diagram showing a detailed conceptual view of the three Microsoft Sovereign Cloud deployment options (Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Cloud) and sovereign workloads in an Azure landing zone." lightbox="./images/microsoft-sovereign-cloud-detailed.svg" border="false":::
    The diagram highlights three deployment models. A National Partner Cloud hosts workloads on partner-controlled infrastructure outside Microsoft's public cloud. A Sovereign Public Cloud hosts sovereign workloads within Microsoft's public cloud under sovereignty controls. A Sovereign Private Cloud extends sovereign workloads to on-premises Azure Local infrastructure, including connected and disconnected deployment options.
    Below, it shows a sovereign Azure landing zone hosted in the Sovereign Public Cloud, where sovereignty controls are applied across platform landing zones and application landing zones. Application landing zones support sovereign public cloud workloads and sovereign private cloud clusters and billing environments. Connections between the Sovereign Public Cloud and Sovereign Private Cloud illustrate how sovereign workloads can span both environments while remaining governed through a unified Azure landing zone architecture.
    Below, a large Azure landing zone box contains the platform landing zone and multiple application landing zones. The platform landing zone, managed by platform teams, contains management groups hierarchy with separation between centralized platform resources for security, management, networking and connectivity, and identity. Azure Policy and Azure RBAC are shown because they get applied to the management groups. A callout indicates the platform team's responsibility for centralized distribution of application landing zones to workload teams.
:::image-end:::

*Detailed conceptual view of sovereign workloads across the three Microsoft Sovereign Cloud deployment options. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

# [Detailed + integration](#tab/detailedintegration)

:::image type="complex" source="./images/microsoft-sovereign-cloud-detailed-enterprise-integration.svg" alt-text="Diagram showing a detailed conceptual view of the three Microsoft Sovereign Cloud deployment options (Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Cloud) and sovereign workloads in an Azure landing zone." lightbox="./images/microsoft-sovereign-cloud-detailed-enterprise-integration.svg" border="false":::
    The diagram highlights three deployment models. A National Partner Cloud hosts workloads on partner-controlled infrastructure outside Microsoft's public cloud. A Sovereign Public Cloud hosts sovereign workloads within Microsoft's public cloud under sovereignty controls. A Sovereign Private Cloud extends sovereign workloads to on-premises Azure Local infrastructure, including connected and disconnected deployment options.
    Below, it shows a sovereign Azure landing zone hosted in the Sovereign Public Cloud, where sovereignty controls are applied across platform landing zones and application landing zones. Application landing zones support sovereign public cloud workloads and sovereign private cloud clusters and billing environments. Connections between the Sovereign Public Cloud and Sovereign Private Cloud illustrate how sovereign workloads can span both environments while remaining governed through a unified Azure landing zone architecture.
    Below, a large Azure landing zone box contains the platform landing zone and multiple application landing zones. The platform landing zone, managed by platform teams, contains management groups hierarchy with separation between centralized platform resources for security, management, networking and connectivity, and identity. Azure Policy and Azure RBAC are shown because they get applied to the management groups. A callout indicates the platform team's responsibility for centralized distribution of application landing zones to workload teams.
    Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*Detailed conceptual view of sovereign workloads across the three Microsoft Sovereign Cloud deployment options that shows enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

# [Decision tree](#tab/decisiontree)

:::image type="complex" source="./images/sovereignty-decision-tree.svg" alt-text="Diagram showing a decision tree for Microsoft Sovereign Cloud that guides organizations from sovereignty requirements to a recommended deployment model, governance architecture, and operational standards." lightbox="./images/sovereignty-decision-tree.svg" border="false":::
    If you need to define sovereignty requirements and controls, start with Sovereignty Planning. If standard Microsoft cloud capabilities and governance controls are sufficient, use Azure Public Cloud. If the workload requires sovereignty controls for governance, data residency, confidentiality, encryption, key management, or operator access oversight, use Sovereign Public Cloud. If the workload requires customer-controlled infrastructure or local operations, determine whether Azure connectivity is required. If connectivity is required, use Sovereign Private Cloud Connected. If connectivity isn't required, use Sovereign Private Cloud Disconnected. If the workload requires infrastructure operated under national jurisdiction by a local provider, use National Partner Cloud. Before onboarding workloads, determine whether sovereignty architecture and governance guidance is required and whether sovereignty operational standards are needed to maintain ongoing compliance. The process concludes with onboarding workloads to the selected Microsoft Sovereign Cloud environment.
:::image-end:::

*Decision tree for the Microsoft Sovereign Cloud. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-microsoft-sovereign-cloud.pptx) of this architecture.* 

---

## 1. Sovereign Public Cloud architecture

The Sovereign Public Cloud is Azure. Workloads run in Azure regions and use the same service catalog as any other subscription. Azure landing zone best practice applies, including the base management group hierarchy and centralized platform resources.

### 1.1 Platform landing zone

Create a management group for each [sovereignty classification](./planning-readiness.md#12-classifications). Assign the Azure Policy definitions or initiatives and other governance controls that enforce that sovereignty classification's controls at the management group level. Place application landing zone subscriptions under the management group that matches the workload's assigned sovereignty classification. 

**Governance baseline**: To establish your Sovereign Public Cloud governance baseline, see the enforcement mechanisms in the [sovereignty controls table](./planning-readiness.md#2-controls).

**Implementation options**: Microsoft provides the [Sovereign Landing Zone accelerator](/azure/azure-sovereign-clouds/public/implementation-options), which adds specific sovereignty controls to the standard [platform landing zone accelerators](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) (*see following table for details*). You can also develop your own implementation or work with Microsoft or Microsoft partners to build a customized platform landing zone for your sovereignty requirements.

*See the following table to understand what the Sovereign Landing Zone accelerator adds to the platform landing zone accelerators.*

| What the Sovereign Landing Zone accelerator adds to Azure landing zone | Details |
|---|---|
| Management groups added | Public, Confidential Online, Confidential Corp |
| Data residency policies added | SLZ repo: [Enforce-Sov-L1-Regions](https://github.com/Azure/Azure-Landing-Zones-Library/blob/main/platform/slz/policy_assignments/Enforce-Sov-L1-Regions.alz_policy_assignment.json) Policy visualization: [Data Residency initiative](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/bebfcba2-e789-4da6-9043-726ef3a00d02.html) |
| Azure Key Vault Managed HSM policies added | SLZ repo: [Enforce-Sov-L2-CMKM](https://github.com/Azure/Azure-Landing-Zones-Library/blob/main/platform/slz/policy_assignments/Enforce-Sov-L2-CMKM.alz_policy_assignment.json) Policy visualization: [CMK with HSM initiative](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/7a00a7fc-fdf4-4ad8-8fa2-a94acc223e8e.html) |
| Customer-managed keys policies added | SLZ repo: [Enforce-Sov-L2-CMKP](https://github.com/Azure/Azure-Landing-Zones-Library/blob/main/platform/slz/policy_assignments/Enforce-Sov-L2-CMKP.alz_policy_assignment.json) Policy visualization: [CMK initiative](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/f15f4d95-c59c-4395-9317-be6978d0743f.html) |
| Encryption in transit (HTTPS) policies added | SLZ repo: [Enforce-Sov-L2-HTTPS](https://github.com/Azure/Azure-Landing-Zones-Library/blob/main/platform/slz/policy_assignments/Enforce-Sov-L2-HTTPS.alz_policy_assignment.json) Policy visualization: [HTTPS initiative](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/c7c0ab87-63da-4706-ba95-ff564e38402b.html) |
| Encryption in transit (latest TLS version) policies added | SLZ repo: [Enforce-Sov-L2-TLS](https://github.com/Azure/Azure-Landing-Zones-Library/blob/main/platform/slz/policy_assignments/Enforce-Sov-L2-TLS.alz_policy_assignment.json) Policy visualization: [TLS version initiative](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/f1fe6a81-eee9-47b8-9f7f-80685141209e.html) |
| Encryption in use policies added | SLZ repo: [Enforce-Sov-L3-Conf](https://github.com/Azure/Azure-Landing-Zones-Library/blob/main/platform/slz/policy_assignments/Enforce-Sov-L3-Conf.alz_policy_assignment.json) Policy visualization: [Encryption in use initiative](https://www.azadvertizer.net/azpolicyinitiativesadvertizer/7a76da03-ec94-45ea-a4fd-496c350c2a63.html) |

### 1.2 Application landing zones

The same principles apply as in Azure landing zone. You have one application landing zone per workload. You use one or more Azure subscriptions per workload environment (dev, test, prod).

### 1.3 Reliability

Data residency and workload resilience pull against each other. Decide the rule for the organization now. Set which regions inside your sovereign boundary a workload can use and whether it can span more than one. Where your boundary holds several approved regions, allow multiregion designs so workloads gain stronger recovery, and keep any disaster-recovery region inside the same boundary. Where your boundary holds a single approved region, say so plainly and require availability zones for in-region resilience and backup-based recovery, because teams can't meet the cross-region targets you ruled out. For the decisions to plan for, see [Reliability and sovereignty in Azure](/azure/reliability/concept-reliability-sovereignty) and [What are Azure availability zones?](/azure/reliability/availability-zones-overview)

### 1.4 Enterprise integration

Sovereign workloads in the public cloud integrate with Microsoft and Azure services like any other workload. The only major constraint is service availability. Confirm that each service you depend on runs in your approved regions and supports the sovereignty controls that classification requires. 

## 2. Sovereign Private Cloud architecture

Sovereign Private Cloud runs on [Azure Local](/azure/azure-local/), the infrastructure you own and operate in your own facilities. Your architecture must provide the applications, data, identity, management, security, networking, communications, and operational capabilities required for that decision. Size and distribute the environment based on workload demand, recovery objectives, permitted geographic boundaries, and failure domains. Avoid creating new concentration risks. Your architecture changes mainly by connectivity mode.Sovereign Private Cloud runs on , the infrastructure you own and operate in your own facilities. Your architecture changes mainly by connectivity mode.

### 2.1 Platform landing zone

You don't add new management groups. The Azure landing zone already includes a Local management group for Azure Local workloads. Place all Azure Local subscriptions there and update its policy assignments to enforce each classification's baseline. 

**Governance baseline**: See the enforcement mechanisms in the [sovereignty controls table](./planning-readiness.md#2-controls) to establish your Sovereign Private Cloud governance baseline.

**Implementation options**: Microsoft provides the [Sovereign Landing Zone accelerator](/azure/azure-sovereign-clouds/public/implementation-options), which adds specific sovereignty controls to the standard [platform landing zone accelerators](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options). You can also develop your own implementation or work with Microsoft or Microsoft partners to build a customized platform landing zone for your sovereignty requirements.

### 2.2 Application landing zones

Connected and disconnected operation differ in one way that matters to your decision.

- **Connected operations**: Use the same application landing zone principles used in Azure public cloud environments. Your workloads however, run on Azure Local hardware you own. See [Connected operations overview](/azure/azure-sovereign-clouds/private/azure-local/connected-operations-overview).

- **Disconnected operations**: Azure subscriptions are required for billing and licensing purposes. Operation of the workloads is fully on-premises. Apply the same application landing zone design principles to your on-premises workload environments. See [Disconnected operations for Azure Local overview](/azure/azure-local/manage/disconnected-operations-overview).

### 2.3 Reliability

Your primary decision is where sovereign workloads can recover. Define the geographic boundary for recovery and the level of disruption the organization must be able to withstand, such as a server failure, facility outage, or regional event.

- **Connected operations**: Decide whether workloads can recover only to Azure Local sites or also to approved Azure regions in the Sovereign Public Cloud. If you allow Sovereign Public Cloud recovery, define the approved locations and verify that they meet your sovereignty requirements.

- **Disconnected operations**: Decide whether recovery must remain within a single facility, across multiple facilities, or across a wider sovereign region. Select a recovery approach that supports your recovery objectives and remains independent of Azure connectivity. Ensure that identity, access, and other critical platform services remain available at the recovery location so workloads can continue operating after failover.

See [Infrastructure resiliency for Azure Local](/azure/azure-local/manage/disaster-recovery-infrastructure-resiliency).

### 2.4 Enterprise integration

You can run [Microsoft 365](/azure/azure-sovereign-clouds/private/m365-local/microsoft-365-local-overview), [Foundry AI models](/azure/azure-sovereign-clouds/private/azure-local/ai-workloads-overview), and [GitHub Enterprise](/azure/azure-sovereign-clouds/private/github-local/github-local-overview) on Azure Local connected or disconnected.

- **Connected**: Workloads can integrate with Azure services and Microsoft cloud services that support hybrid or on-premises connectivity.

- **Disconnected**: Disconnected operations affect how you manage the Azure Local environment and its connection to Azure management services. They don't inherently restrict workload or application integrations. Subject to your sovereignty requirements, workloads can still integrate with on-premises systems, partner environments, and Microsoft services. Organizations often choose disconnected operations to reduce dependencies on external services, but the deployment model itself doesn't prevent approved integrations. Azure subscriptions are still required for billing and licensing. See [Disconnected operations for Azure Local](/azure/azure-sovereign-clouds/private/azure-local/disconnected-operations-overview).

## 3. National Partner Cloud architecture

[National Partner Clouds](/azure/azure-sovereign-clouds/partner/overview-national-partner-clouds) operate independently of Microsoft, so their effect on your architecture is specific to the partner. Validate platform capabilities with the operator before you commit to a design.

Apply Azure landing zone practice and adapt it to the services the partner exposes and the needs of your workloads. You can use the [Sovereign Landing Zone acclerator](/azure/azure-sovereign-clouds/public/implementation-options) where the partner supports the required APIs and service versions, or build your own platform landing zone. Define the design and the integrations with your partner representative.

## 4. Architecture portability

Regulations, security requirements, and geopolitical conditions can change over time. Some organizations want the flexibility to move workloads between Sovereign Public Cloud, Sovereign Private Cloud, and National Partner Cloud environments without significant redesign. Architectural decisions you make today can affect the cost, complexity, and feasibility of future migrations.

- **Minimize deployment-model-specific dependencies.** Use common identity, governance, and security capabilities wherever possible, such as Microsoft Entra ID, Azure RBAC, and Azure Policy. When selecting compute and application platforms, favor technologies that are available across multiple deployment models and can operate consistently in different environments, such as virtual machines, containers, and Kubernetes. While deployment-model-specific services can provide valuable capabilities, they can also increase migration effort if requirements change in the future.

- **Validate target-platform support.** Before adopting a service or platform capability, verify that equivalent functionality exists in each deployment model where the workload might need to operate. Service availability varies across Sovereign Public Cloud, Sovereign Private Cloud, Azure Local (connected and disconnected), and National Partner Clouds.

For available services, see:
- [Sovereign Public Cloud](/azure)
- [Sovereign Private Cloud - Connected](/azure/azure-local/overview/hyperconverged-overview#common-azure-services-used-with-azure-local)
- [Sovereign Private Cloud - Disconnected](/azure/azure-local/manage/disconnected-operations-overview#supported-services)
- [National Partner Clouds](/azure/azure-sovereign-clouds/partner/overview-national-partner-clouds#integrated-microsoft-capabilities)

## Next step

> [!div class="nextstepaction"]
> [Operational standards](./operational-standards.md)