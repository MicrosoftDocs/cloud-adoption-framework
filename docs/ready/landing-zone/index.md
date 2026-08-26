---
title: What is an Azure landing zone?
description: Azure landing zones deliver a proven architecture for governing, securing, and scaling multi-subscription environments. Understand platform landing zone and application landing zones.
#customer intent: As a decision maker, I want to understand how my platform team should design our Azure environment to govern, secure, and scale our Azure workloads within our governance and security baselines without hindering their ability to deploy workloads.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 07/24/2025
ms.topic: concept-article
ai-usage: ai-assisted
---

# What is an Azure landing zone?

The Ready phase of the Cloud Adoption Framework helps you design your Azure landing zone to meet your organization's requirements. An Azure landing zone is a proven and flexible architecture for governing, securing, and scaling a multi-subscription Azure environment. An Azure landing zone consists of two components:

- **Platform landing zone:** The centralized foundation that establishes governance, security, and shared resources for all your Azure workloads.

- **Application (workload) landing zones:** The environments where workload teams deploy and operate workload resources within the guardrails of the platform landing zone. *A workload is a collection of Azure resources, code, AI models, data, and infrastructure that work together to achieve a defined business outcome*.

You can implement each component of your Azure landing zone in one of two ways:

- **Accelerators**: Microsoft-provided accelerators for both platform landing zone and application landing zone scenarios use infrastructure as code to deploy Azure environments based on recommended practices.

- **Custom build**: You design and build the solution internally or with support from Microsoft or Microsoft partners.

For most organizations, accelerators provide the fastest path to a deployment that aligns with Microsoft's recommended practices.

## Azure landing zone architecture

Every Azure landing zone starts with the platform landing zone. Before you build a platform landing zone, define organizational requirements across the Azure landing zone [design areas](design-areas.md). These decisions determine how you design your Azure landing zone. 

### Conceptual architectures

Conceptual architecture diagrams help you understand the core components of an Azure landing zone and how they work together. Start with these diagrams to understand the relationship between the platform landing zone, application landing zones, and Microsoft solutions.

# [Conceptual](#tab/conceptual)

:::image type="complex" source="./media/azure-landing-zone-conceptual-architecture.svg" alt-text="Diagram showing a conceptual view of an Azure landing zone." lightbox="./media/azure-landing-zone-conceptual-architecture.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above an application landing zones section. The application landing zones section contains three application landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the application landing zones, indicating optional AI capabilities for selected workloads.
:::image-end:::

*Conceptual Azure landing zone architecture. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Conceptual + enterprise integration](#tab/conceptualintegration)

:::image type="complex" source="./media/azure-landing-zone-conceptual-architecture-enterprise-integration.svg" alt-text="Diagram showing a conceptual Azure landing zone architecture and how it integrates with your Microsoft enterprise architecture." lightbox="./media/azure-landing-zone-conceptual-architecture-enterprise-integration.svg" border="false":::
    Layered architecture diagram. A top banner labeled "Unified identity, security, and governance" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below, a large Azure landing zone box contains a platform landing zone centered above an application landing zones section. The application landing zones section contains three application landing zone boxes representing Azure workloads. Beneath the workloads, a Microsoft Foundry and Foundry IQ box connects by dashed arrows to the application landing zones, indicating optional AI capabilities for selected workloads.

    Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*Conceptual Azure landing zone architecture plus enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Detailed conceptual](#tab/detailed)

:::image type="complex" source="./media/azure-landing-zone-detailed-architecture.svg" alt-text="Diagram showing a detailed conceptual view of an Azure landing zone." lightbox="./media/azure-landing-zone-detailed-architecture.svg" border="false":::
    A top section labeled "Unified identity, security, and governance across Azure, Microsoft, multicloud, and on-premises environments" contains Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview.
    
Below, a large Azure landing zone box contains the platform landing zone and multiple application landing zones. The platform landing zone, managed by platform teams, contains management groups hierarchy with separation between centralized platform resources for security, management, networking and connectivity, and identity. Azure Policy and Azure RBAC are shown because they get applied to the management groups. A callout indicates the platform team's responsibility for centralized distribution of application landing zones to workload teams.

The Application landing zones section shows how workloads are organized under the Azure landing zone architecture. Workloads are grouped into Internal, Online, and Local categories. Each workload receives a dedicated application landing zone that contains all environments associated with that workload. Typical environments include development, test, and production, with each environment consisting of one or more Azure subscriptions. Internal workload examples include a Microsoft Fabric compute landing zone and a data and AI workload landing zone that uses services such as Azure Machine Learning, Azure Databricks, AI on Azure Infrastructure, and Azure Data Lake Storage. The diagram also shows that Microsoft Foundry resources can be added to workload environments where AI capabilities are required. Workload teams manage the application landing zones, which remain separate from the platform landing zone managed by platform teams.
:::image-end:::

*Detailed conceptual Azure landing zone architecture. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

# [Detailed conceptual + enterprise integration](#tab/detailedintegration)

:::image type="complex" border="false" source="./media/azure-landing-zone-detailed-architecture-enterprise-integration.svg" alt-text="Diagram showing a detailed conceptual view of an Azure landing zone and how it integrates with your Microsoft enterprise architecture." lightbox="./media/azure-landing-zone-detailed-architecture-enterprise-integration.svg":::
    Detailed Azure landing zone architecture diagram. A top layer labeled "Unified identity, security, and governance" spans the environment and includes Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview.

Below, the Azure landing zone is divided into a platform landing zone and application landing zones. The platform landing zone contains a tenant root group with a management group hierarchy. Management groups organize centralized platform resources for security, management, identity, and connectivity. Azure Policy and Azure RBAC are applied across the hierarchy. Application landing zones are grouped into Internal, Online, and Local categories, with separate management groups for sandbox and decommissioned resources.

The application landing zones section shows example workloads. Each workload has a dedicated application landing zone that contains production, test, and development environments. Example internal workloads include Microsoft Fabric compute and a data and AI workload. Microsoft Foundry connects to application landing zones, indicating that AI capabilities can be added to selected workload environments.

Beneath the Azure landing zone, Microsoft Copilot Studio, Microsoft Fabric, and Microsoft 365 are shown as integrated business, data, and AI solutions. At the bottom, data sources including on-premises systems, Dataverse, Microsoft 365, Azure workloads, and other clouds connect to these solutions. Bidirectional arrows indicate integration between data sources, Microsoft platforms, and Azure workloads.
:::image-end:::

*Detailed conceptual Azure landing zone architecture plus enterprise integration with Microsoft solutions. Download a [PowerPoint file](https://arch-center.azureedge.net/cloud-adoption-framework-conceptual-azure-landing-zone-architecture-v3.pptx) of this architecture.* 

---

### Reference architectures 

Reference architecture diagrams show recommended Azure landing zone implementation patterns and deployment models. Use these diagrams to understand how management groups, subscriptions, networking, and governance controls are organized in hub-and-spoke, Azure Virtual WAN, and other architecture designs.

# [Hub-Spoke](#tab/hubspoke)

:::image type="complex" border="false" source="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg" alt-text="Diagram that shows an Azure landing zone using a hub and spoke networking topology." lightbox="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg":::
   At the top, an Enterprise Agreement/Microsoft Customer Agreement (A) shows a billing hierarchy leading to a subscription, alongside Identity and access management (B) and Microsoft Entra ID, which connects to on-premises Active Directory Domain Services. The center holds the Management group and subscription organization (C): under a tenant root group and Contoso sit Platform (Security, Management, Identity, Connectivity), Application landing zones (Corp, Online, Local), Decommissioned, and Sandbox, each mapping to subscriptions below. A DevOps section (I) with a Git repository, boards, and pipelines sits to the right.

   Around the middle are individual subscriptions as boxes. Security and Management subscriptions (D, upper left) contain Log Analytics workspaces, Microsoft Sentinel, and dashboards. The Identity subscription holds virtual networks with domain services and Recovery Services vaults. The Connectivity subscription (E) contains Azure DDoS Protection, Azure DNS, VPN/ExpressRoute gateways, Azure Firewall, and peered hub virtual networks across two regions. Application landing zone A2 and P1 subscriptions (F) hold application virtual networks, resource groups, and workload resources (G) and a Sandbox subscription (H) at right. Each subscription repeats a common toolset row: Action Groups, Alerts, Cost Management, Role assignment, Policy assignment, Network Watcher, Defender for Cloud, and Azure Update Manager.
:::image-end:::

*Azure landing zone reference architecture showing a hub & spoke networking topology. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

# [Virtual WAN](#tab/vwan)

:::image type="complex" border="false" source="../enterprise-scale/media/azure-landing-zone-virtual-wan.svg" alt-text="Diagram that shows an Azure landing zone using the Virtual WAN networking topology." lightbox="../enterprise-scale/media/azure-landing-zone-virtual-wan.svg":::
    At the top, an Enterprise Agreement/Microsoft Customer Agreement (A) shows a billing hierarchy leading to a subscription, alongside Identity and access management (B) and Microsoft Entra ID, which connects to on-premises Active Directory Domain Services. The center holds the Management group and subscription organization (C): under a tenant root group and Contoso sit Platform (Security, Management, Identity, Connectivity), application landing zones (Corp, Online, Local), Decommissioned, and Sandbox, each mapping to subscriptions below. A DevOps section (I) with a Git repository, boards, and pipelines sits to the right.

    Around the middle are individual subscriptions as boxes. Security and Management subscriptions (D, upper left) contain Log Analytics workspaces, Microsoft Sentinel, and dashboards. The Identity subscription holds virtual networks with domain services and Recovery Services vaults. The Connectivity subscription (E) contains Azure DDoS Protection, Azure DNS, Azure Firewall, and two Azure Virtual WAN hubs (Region 1 and Region N) with VPN/ExpressRoute gateways. VWAN Hub Connection lines link these hubs to the application landing zone virtual networks. Application landing zone A2 and P1 subscriptions (F) hold application virtual networks, resource groups, and workload resources (G) and a Sandbox subscription (H) at right. Each subscription repeats a common toolset row: Action Groups, Alerts, Cost Management, Role assignment, Policy assignment, Network Watcher, Defender for Cloud, and Azure Update Manager.
:::image-end:::

*Azure landing zone reference architecture showing an Azure Virtual WAN networking topology. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

# [Management group hierarchy](#tab/mgonly)

:::image type="complex" border="false" source="./media/azure-landing-zone-hierarchy.svg" alt-text="Diagram that shows an Azure landing zone management group hierarchy." lightbox="media/azure-landing-zone-hierarchy.svg":::
   This diagram is organized as a tree across two horizontal bands: Management groups on top and Subscriptions on the bottom. At the top of the Management groups band, a Tenant root group connects down to Contoso, which branches into four management groups: Platform, (Application) landing zones, Decommissioned, and Sandbox. Platform further branches into Security, Management, Identity, and Connectivity, while application landing zones branches into Corp, Online, and Local.

   In the Subscriptions band below, each management group links to its subscriptions. Security, Management, Identity, and Connectivity management groups each map to a matching subscription of the same name. Corp connects to the application landing zone A1, Application landing zone P1, and application landing zone A2 subscriptions. Local connects to application landing zone C1 subscription (Azure Local Clusters) and application landing zone A1 subscription (Applications). Decommissioned maps to a Decommissioned subscription, and Sandbox maps to Sandbox subscription 1 and Sandbox subscription 2. The Online management group has no subscription shown beneath it.
:::image-end:::

*Baseline Azure landing zone management group hierarchy. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) of this architecture.*

# [Platform vs. application landing zones](#tab/platvsapp)

:::image type="complex" border="false" source="./media/alz-application-platform.svg" alt-text="Diagram that shows an Azure landing zone management group hierarchy." lightbox="media/alz-application-platform.svg":::
    Diagram titled "Azure landing zone (ALZ) – Terminology." A legend at the top right defines two color overlays: a purple shade for platform landing zone and a green shade for application landing zones. The purple overlay wraps the left portion of the diagram, grouping the Security subscription, Management subscription (D), Identity subscription, and Connectivity subscription (E), the last containing Azure DDoS Protection, Azure DNS, VPN/ExpressRoute gateways, Azure Firewall, and peered hub virtual networks. The green overlay wraps the lower-right portion, grouping the application landing zone A2 subscription (F), application landing zone P1 subscription, and Sandbox subscription (H), each holding application virtual networks and workload resources.

    The central and upper structures remain unshaded, above is the the Enterprise Agreement/Microsoft Customer Agreement billing hierarchy (A), Identity and access management (B), Microsoft Entra ID with on-premises Active Directory Domain Services, and Git repository, boards, and pipelines.
:::image-end:::

*Platform landing zone vs. application landing zones in the Azure landing zone reference architecture. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

---

<a name='platform-landing-zones-vs-application-landing-zones'></a>
<a name='platform-landing-zone-vs-application-landing-zones'></a>

## Platform landing zone

The platform landing zone establishes your organization's Azure foundation. It defines how you organize your Azure resources, enforce governance, and provide shared capabilities centrally. Most organizations should have only one platform landing zone per Microsoft Entra tenant.

A platform landing zone consists of a management group hierarchy and centralized resources (as needed). An important function of the platform is to have a way to distribute application landing zones to workload teams.

- **Management group hierarchy:** The management group hierarchy provides the governance structure for the Azure environment. It organizes all of your Azure subscriptions and applies governance standards to those subscriptions. The hierarchy separates platform resources and workload resources. A well-designed hierarchy allows you to apply governance standards consistently without creating unnecessary administrative complexity.

- **Centralized resources:** Many organizations provide certain capabilities centrally so every workload can use the same approved services and standards. Common examples include connectivity and networking, security monitoring, Active Directory identity services, and management services. What you centralize depends on your requirements. Only centralize capabilities that provide clear governance, operational, or economic benefits across multiple workloads.

- **Application landing zone distribution:** You need a repeatable process for requesting, creating, and distributing application landing zones to workload teams. A standardized approach ensures every new application landing zone follows your organization's governance and security baselines. You can do this process manually or automate it. As the number of application landing zone requests grows, automation becomes increasingly important. See [Subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

<a name='deploying-and-managing-azure-landing-zone'></a>

**Implementation options:** Microsoft provides several platform landing zone accelerators that implement recommended architecture patterns and organizational guardrails. See [Platform landing zone implementation options](./implementation-options.md). You can also develop your own implementation or work with Microsoft or Microsoft partners to build a customized platform landing zone.

<a name='application-landing-zones'></a>

## Application landing zone

Each workload has a single application landing zone. An application landing zone contains all the environments required to support that workload, such as development, test, and production. Each environment consists of one or more Azure subscriptions based on workload requirements, team ownership boundaries, or Azure subscription limits. The application landing zone includes all Azure resources that the workload team owns and operates across every environment.

Based on the requirements of the workload, the platform team places each application landing zone subscription in either the Online, Internal ("Corp"), or Local management group under the "(Application) Landing zones" management group. Each subscription and its Azure resources inherit the governance and security policies from the Azure Policies applied to the management group hierarchy. This model provides consistent guardrails and allows flexibility to meet workload-specific requirements.

**Implementation options:** Microsoft provides several accelerators to deploy different types of application landing zones. You can also implement your own approach or engage Microsoft or Microsoft partners for assistance. See the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy#application) for a list of application landing zone accelerators.


<a name='ai-in-azure-landing-zones'></a>

## Technology adoption in an Azure landing zone

An Azure landing zone supports new and emerging technologies without requiring changes to the overall architecture. You deploy workload resources into application landing zones regardless of workload type, such as AI. As new requirements emerge, you update the governance and security policies in the platform landing zone. Those policies are then applied consistently across application landing zones, which helps you adopt new technologies faster and maintain consistency across all workloads of that type.

The Cloud Adoption Framework provides guidance for common adoption scenarios to help you prepare your people, processes, and platform for successful adoption. See [Scenarios](/azure/cloud-adoption-framework/overview#cloud-adoption-framework-scenarios).

## Next steps

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)
