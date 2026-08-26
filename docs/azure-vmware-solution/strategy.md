---
title: Azure VMware Solution adoption strategy - Executive decision guide
description: Learn when Azure VMware Solution is right for your organization and how it accelerates VMware migration to Azure while protecting your existing investment.
#customer intent: As a business decision maker, I want to understand the scenarios where Azure VMware Solution makes sense, so that I can justify the investment to stakeholders.
author: stephen-sumner
ms.author: dsoderholm
ms.reviewer: ssumner
ms.date: 08/20/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Azure VMware Solution adoption strategy - Executive decision guide

*This article helps business and technology decision makers determine whether Azure VMware Solution is the right strategy for their organization.*

Organizations with significant VMware investments often need to move to the cloud without disrupting business-critical applications. Application modernization efforts can increase cost, risk, and migration timelines, making rapid cloud adoption difficult. [Azure VMware Solution](/azure/azure-vmware/introduction) provides a path to run VMware workloads in Azure with minimal application change while preserving existing VMware investments and operational practices. 

This article begins that decision process by helping decision makers evaluate the benefits, risks, and tradeoffs of Azure VMware Solution and determine whether it is the right strategy for their organization. The remaining guidance in this series helps organizations adopt, govern, operate, and migrate workloads to Azure VMware Solution successfully.

# [Conceptual](#tab/conceptual)

:::image type="complex" source="./images/azure-vmware-solution-landing-zone-conceptual.svg" alt-text="Diagram showing a conceptual view of an Azure VMware Solution in an Azure landing zone." lightbox="./images/azure-vmware-solution-landing-zone-conceptual.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above an application landing zones section. The application landing zones section contains three application landing zone boxes representing Azure workloads. The center application landing zone box contains an Azure VMware Solution workload. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the application landing zones, indicating optional AI capabilities for selected workloads.
:::image-end:::

*Conceptual view of Azure VMware Solution in an Azure landing zone architecture. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-azure-vmware-solution-azure-landing-zone.pptx) of this architecture.* 


# [Conceptual + integration](#tab/conceptualintegration)

:::image type="complex" source="./images/azure-vmware-solution-landing-zone-conceptual-enterprise-integration.svg" alt-text="Diagram showing a conceptual Azure landing zone architecture and how it integrates with your Microsoft enterprise architecture." lightbox="./images/azure-vmware-solution-landing-zone-conceptual-enterprise-integration.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above an application landing zones section. The application landing zones section contains three application landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the application landing zones, indicating optional AI capabilities for selected workloads.

    Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*Conceptual view of Azure VMware Solution in a Azure landing zone architecture that shows enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-azure-vmware-solution-azure-landing-zone.pptx) of this architecture.* 

# [Detailed](#tab/detailed)

:::image type="complex" source="./images/azure-vmware-solution-landing-zone-detailed.svg" alt-text="Diagram showing a detailed conceptual view of an Azure landing zone." lightbox="./images/azure-vmware-solution-landing-zone-detailed.svg" border="false":::
    A top section labeled "Unified identity, security, and governance across Azure, Microsoft, multicloud, and on-premises environments" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview.
    
Below, a large Azure landing zone box contains the platform landing zone and multiple application landing zones. The platform landing zone, managed by platform teams, contains management groups hierarchy with separation between centralized platform resources for security, management, networking and connectivity, and identity. Azure Policy and Azure RBAC are shown because they get applied to the management groups. A callout indicates the platform team's responsibility for centralized distribution of application landing zones to workload teams.

    The application landing zones section shows Azure VMware Solution deployed as a dedicated application landing zone within the Azure landing zone architecture. Azure VMware Solution workloads are organized under Internal or Online workload categories and include separate development, test, and production environments, each consisting of one or more Azure subscriptions. The diagram contrasts Azure VMware Solution application landing zones with other application landing zones, such as Microsoft Fabric compute and data and AI workloads. Microsoft Foundry resources can be connected to workload environments that require AI capabilities. Application landing zones are managed by workload teams and remain separate from the centrally managed platform landing zone.
:::image-end:::

*Detailed conceptual view of Azure VMware Solution in an Azure landing zone architecture. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-azure-vmware-solution-azure-landing-zone.pptx) of this architecture.* 


# [Detailed + integration](#tab/detailedintegration)

:::image type="complex" border="false" source="./images/azure-vmware-solution-landing-zone-detailed-enterprise-integration.svg" alt-text="Diagram showing a detailed conceptual view of an Azure landing zone and how it integrates with your Microsoft enterprise architecture." lightbox="./images/azure-vmware-solution-landing-zone-detailed-enterprise-integration.svg":::
    A top section labeled "Unified identity, security, and governance across Azure, Microsoft, multicloud, and on-premises environments" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview.
    
Below, a large Azure landing zone box contains the platform landing zone and multiple application landing zones. The platform landing zone, managed by platform teams, contains management groups hierarchy with separation between centralized platform resources for security, management, networking and connectivity, and identity. Azure Policy and Azure RBAC are shown because they get applied to the management groups. A callout indicates the platform team's responsibility for centralized distribution of application landing zones to workload teams.

The Application landing zones section shows Azure VMware Solution deployed as a dedicated application landing zone within the Azure landing zone architecture. Azure VMware Solution workloads are organized under Internal or Online workload categories and include separate development, test, and production environments, each consisting of one or more Azure subscriptions. The diagram contrasts Azure VMware Solution application landing zones with other application landing zones, such as Microsoft Fabric compute and data and AI workloads. Microsoft Foundry resources can be connected to workload environments that require AI capabilities. Application landing zones are managed by workload teams and remain separate from the centrally managed platform landing zone.

Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*Detailed conceptual view of Azure VMware Solution in an Azure landing zone architecture that shows enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-azure-vmware-solution-azure-landing-zone.pptx) of this architecture.* 

---

## What is Azure VMware Solution?

Azure VMware Solution runs a VMware environment with vSphere, vSAN, NSX, and HCX, on dedicated Azure infrastructure that Microsoft manages. Your teams continue using familiar VMware tools, processes, and skills but gain native access to Azure services. When you deploy Azure VMware Solution, you create an **private cloud**. A private cloud is a self-contained VMware environment that Azure provisions for you with vCenter Server to manage virtual machines and NSX for networking, plus vSAN for storage. It runs on physical host servers, or *nodes*, which are dedicated physical servers reserved for your organization. Each host contributes its compute and storage to your virtual machines, and a private cloud groups hosts into clusters.

## When to use Azure VMware Solution?

Azure VMware Solution is often the right choice when the business value of moving to Azure is clear, and the cost, risk, or time required to redesign applications aren't acceptable. Consider Azure VMware Solution in the following situations:

- **VMware-accelerated migration:** If your organization must retire infrastructure, exit a colocation facility, or move out of another cloud provider, Azure VMware Solution provides a migration path with minimal application change. VMware HCX supports workload mobility and network extension capabilities that can simplify migration planning and reduce disruption.

- **VMware compatibility:** Some business-critical applications rely on operating systems, middleware, or vendor-supported configurations that aren't validated for Azure virtual machines. Azure VMware Solution preserves the VMware operating environment, which can help maintain application supportability and reduce migration risk.

- **VMware investment:** Organizations often invest heavily in VMware expertise, operational processes, monitoring platforms, backup solutions, and automation tools. Azure VMware Solution allows teams to continue using familiar VMware technologies while gradually building Azure capabilities at a pace that aligns with business priorities.

- **VMware integration with Azure:** Many organizations want to improve business outcomes without immediately modernizing every application. Azure VMware Solution enables low-latency connectivity between VMware workloads and Azure services, which supports scenarios such as AI, analytics, databases, backup, security, and monitoring. Use Azure Arc to manage VMware virtual machines through the Azure portal, creating a consistent administrator experience across platforms.

- **VMware disaster recovery:** Azure VMware Solution can serve as a recovery target for VMware environments running on-premises or in another cloud. This approach can improve resiliency without maintaining a second physical data center.

Azure VMware Solution isn't the best choice for every cloud strategy. Consider Azure-native infrastructure or platform services instead if:

- You plan to modernize or refactor applications in the near term.

- Your workloads run well on Azure virtual machines without VMware dependencies.

- You have a small VMware footprint and can migrate directly to Azure-native services.

- Your primary objective is long-term cloud optimization rather than VMware continuity.

- The majority of your workloads are new, and can be designed from the start as cloud-native, rather than being migrated from an on-premises environment.

In these scenarios, moving directly to Azure IaaS or PaaS services often provides greater cloud-native benefits and can reduce long-term platform costs.

## What Azure VMware Solution generation to use?

Azure VMware Solution is available in two private cloud generations. The most significant difference between them is the network architecture. The VMware software components, such as vCenter Server, ESXi, and NSX, are identical between Gen1 and Gen2.

Choose **Generation 2 (Gen2)** for new deployments. Gen2 deploys directly into an Azure Virtual Network. This design simplifies connectivity, supports Azure-native security controls, and aligns with Azure networking standards. Choose **Generation 1 (Gen1)** only when an existing deployment or technical dependency requires it. Gen1 uses a Microsoft-managed ExpressRoute networking model and can introduce additional design complexity. Make the generation decision early. Moving between generations requires workload migration.

## Who is responsible for operating Azure VMware Solution?

Microsoft operates and maintains the Azure infrastructure and VMware platform. This responsibility includes provisioning, hardware maintenance, and updating VMware software such as ESXi and vCenter Server.

Your organization remains responsible for applications, virtual machines, operating systems, data, security policies, compliance, backup, and business. Your responsibilities include monitoring resource consumption and scaling node (host) capacity to meet workload demands while balancing performance, resilience, and cost objectives.

Review the responsibility matrix before adoption. Confirm ownership for security, operations, and compliance. See [Azure VMware Solution responsibility matrix - Microsoft vs customer](/azure/azure-vmware/introduction#azure-vmware-solution-responsibility-matrix---microsoft-vs-customer).

## What does Azure VMware Solution cost?

Primary cost factors include Azure VMware Solution instance size, number of nodes (hosts), consumption duration, and the VMware VCF portable subscription required from Broadcom. You're billed by the number and size of Azure VMware Solution hosts, not by the number of virtual machines. Compare Azure VMware Solution against the full cost of your existing VMware platform. Include hardware refresh costs, datacenter expenses, and operational support. See [Azure VMware Solution pricing](https://azure.microsoft.com/pricing/details/azure-vmware/) and to develop workload estimates, use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/).

## How do I realize value from Azure VMware Solution?

Azure VMware Solution delivers the most value when you need to move VMware workloads to Azure quickly without major application changes. It helps reduce migration risk and enables teams to continue using existing VMware skills and processes.

Organizations often realize value fastest when retiring infrastructure, exiting a datacenter, improving disaster recovery, or accelerating cloud adoption.

## How to adopt Azure VMware Solution?

Adopting Azure VMware Solution requires decisions across planning, architecture, governance, operations, and migration. The following guidance helps you understand what changes are required to support Azure VMware Solution in your existing cloud environment.

:::image type="complex" border="false" source="./images/azure-vmware-solution-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for Azure VMware Solution adoption." lightbox="./images/azure-vmware-solution-adoption-process.svg":::
    The image shows a progresses through five phases connected by arrows: Planning and readiness, Azure landing zone architecture, Governance and security baselines, Operational standards, and Migration. Each phase builds on the previous phase to prepare, govern, operate, and migrate workloads to Azure VMware Solution.
:::image-end:::

1. [Planning and readiness](./plan-readiness.md): Understand the readiness requirements for Azure VMware Solution, including operating model considerations, roles and responsibilities, licensing, quotas, skills development, and cost management.

2. [Azure landing zone architecture](./architecture-landing-zone.md): Understand the architectural changes to your platform landing zone and application landing zones.

3. [Governance and security baselines](./governance-security.md): Establish the governance and security baselines required to operate Azure VMware Solution workloads.

4. [Operational standards](./operations-health-management.md): Understand the operational processes, monitoring requirements, health management practices, reliability considerations, and cost management activities needed to support Azure VMware Solution.

5. [Migration](./migration.md): Understand the process used to plan, prepare, execute, evaluate, and decommission VMware workload migrations to Azure VMware Solution.

## Next step

> [!div class="nextstepaction"]
> [Planning and readiness](./plan-readiness.md)
