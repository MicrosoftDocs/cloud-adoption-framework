---
title: What is an Azure landing zone?
description: Azure landing zones deliver a proven architecture for governing, securing, and scaling multi-subscription environments. Understand platform landing zone and application landing zones.
#customer intent: As a decision maker, I want to understand how my platform team should design our Azure environment to govern, secure, and scale our Azure workloads within our governance and security baselines without hindering their ability to deploy workloads.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 07/24/2025
ms.topic: concept-article
---

# What is an Azure landing zone?

The Ready phase of the Cloud Adoption Framework helps you design your Azure landing zone to meet your organization's requirements. An Azure landing zone is a proven and flexible architecture for governing, securing, and scaling a multi-subscription Azure environment. An Azure landing zone consists of two components:

- **Platform landing zone:** The centralized foundation that establishes governance, security, and shared resources for all your Azure workloads.

- **Application landing zones:** Azure environments where you deploy and operate workload resources within the standards established by the platform landing zone.

You can implement Azure landing zones using one of two approaches:

- **Accelerators**: Microsoft-provided accelerators for both platform landing zone and application landing zone scenarios use infrastructure as code to deploy Azure environments based on recommended practices.

- **Custom build**: You design and build the solution internally or with support from Microsoft or Microsoft partners.

For most organizations, accelerators provide the fastest path to a deployment that aligns with Microsoft's recommended practices.

## Azure landing zone architecture

Every Azure landing zone starts with the platform landing zone. Before you build a platform landing zone, define organizational requirements across the Azure landing zone [design areas](design-areas.md). These decisions determine how you design your Azure landing zone.

The Azure landing zone reference architecture represents a recommended target architecture. Use it as a starting point and adapt it to meet your organization's requirements.

# [Conceptual](#tab/conceptual)

:::image type="complex" border="false" source="./media/conceptual-azure-landing-zone.svg" alt-text="Diagram that shows a conceptual view of an Azure landing zone and how it integrates with key services across your organization." lightbox="./media/conceptual-azure-landing-zone.svg":::
    A top section labeled "Unified identity, security, and governance across Azure, Microsoft, multicloud, and on-premises environments" holds four components: Microsoft Agent 365, Microsoft Defender, Microsoft Entra, and Microsoft Purview. Below it, a large box labeled Azure reads "Azure landing zone consists of one platform landing zone and many application landing zones." Inside, the Platform landing zone, managed by platform teams, contains Management groups, Azure Policy, Azure RBAC, and centralized resources, with a callout for centralized distribution of application landing zones through subscription vending.

    Beneath that, the application landing zones section, managed by workload teams, shows Microsoft Fabric compute and Data and AI/ML workloads (Azure Databricks, Azure Machine Learning) to the left, and Workload 1 and Workload n boxes each containing Azure resources. A Microsoft Foundry (Foundry IQ) box connects upward to the workloads to integrate AI. Dashed lines below link the Azure box to Microsoft Copilot Studio, Microsoft Fabric (Fabric IQ), and Microsoft 365 (Microsoft 365 Copilot, Work IQ). A bottom row labeled "All data sources" lists On-premises, Dataverse, Microsoft 365, Azure workloads, and Other clouds.
:::image-end:::

# [Hub & Spoke](#tab/hubspoke)

:::image type="complex" border="false" source="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg" alt-text="Diagram that shows an Azure landing zone using a hub and spoke networking topology." lightbox="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg":::
   At the top, an Enterprise Agreement/Microsoft Customer Agreement (A) shows a billing hierarchy leading to a subscription, alongside Identity and access management (B) and Microsoft Entra ID, which connects to on-premises Active Directory Domain Services. The center holds the Management group and subscription organization (C): under a tenant root group and Contoso sit Platform (Security, Management, Identity, Connectivity), Application landing zones (Corp, Online, Local), Decommissioned, and Sandbox, each mapping to subscriptions below. A DevOps section (I) with a Git repository, boards, and pipelines sits to the right.

   Around the middle are individual subscriptions as boxes. Security and Management subscriptions (D, upper left) contain Log Analytics workspaces, Microsoft Sentinel, and dashboards. The Identity subscription holds virtual networks with domain services and Recovery Services vaults. The Connectivity subscription (E) contains Azure DDoS Protection, Azure DNS, VPN/ExpressRoute gateways, Azure Firewall, and peered hub virtual networks across two regions. Application landing zone A2 and P1 subscriptions (F) hold application virtual networks, resource groups, and workload resources (G) and a Sandbox subscription (H) at right. Each subscription repeats a common toolset row: Action Groups, Alerts, Cost Management, Role assignment, Policy assignment, Network Watcher, Defender for Cloud, and Azure Update Manager.
:::image-end:::

*Azure landing zone architecture using a hub & spoke networking topology. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

# [Virtual WAN](#tab/vwan)

:::image type="complex" border="false" source="../enterprise-scale/media/azure-landing-zone-virtual-wan.svg" alt-text="Diagram that shows an Azure landing zone using the Virtual WAN networking topology." lightbox="../enterprise-scale/media/azure-landing-zone-virtual-wan.svg":::
    At the top, an Enterprise Agreement/Microsoft Customer Agreement (A) shows a billing hierarchy leading to a subscription, alongside Identity and access management (B) and Microsoft Entra ID, which connects to on-premises Active Directory Domain Services. The center holds the Management group and subscription organization (C): under a tenant root group and Contoso sit Platform (Security, Management, Identity, Connectivity), application landing zones (Corp, Online, Local), Decommissioned, and Sandbox, each mapping to subscriptions below. A DevOps section (I) with a Git repository, boards, and pipelines sits to the right.

    Around the middle are individual subscriptions as boxes. Security and Management subscriptions (D, upper left) contain Log Analytics workspaces, Microsoft Sentinel, and dashboards. The Identity subscription holds virtual networks with domain services and Recovery Services vaults. The Connectivity subscription (E) contains Azure DDoS Protection, Azure DNS, Azure Firewall, and two Azure Virtual WAN hubs (Region 1 and Region N) with VPN/ExpressRoute gateways. VWAN Hub Connection lines link these hubs to the application landing zone virtual networks. Application landing zone A2 and P1 subscriptions (F) hold application virtual networks, resource groups, and workload resources (G) and a Sandbox subscription (H) at right. Each subscription repeats a common toolset row: Action Groups, Alerts, Cost Management, Role assignment, Policy assignment, Network Watcher, Defender for Cloud, and Azure Update Manager.
:::image-end:::

*Azure landing zone architecture using an Azure Virtual WAN networking topology. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

# [Management Group Hierarchy Only](#tab/mgonly)

:::image type="complex" border="false" source="./media/azure-landing-zone-hierarchy.svg" alt-text="Diagram that shows an Azure landing zone management group hierarchy." lightbox="media/azure-landing-zone-hierarchy.svg":::
   This diagram is organized as a tree across two horizontal bands: Management groups on top and Subscriptions on the bottom. At the top of the Management groups band, a Tenant root group connects down to Contoso, which branches into four management groups: Platform, (Application) landing zones, Decommissioned, and Sandbox. Platform further branches into Security, Management, Identity, and Connectivity, while application landing zones branches into Corp, Online, and Local.

   In the Subscriptions band below, each management group links to its subscriptions. Security, Management, Identity, and Connectivity management groups each map to a matching subscription of the same name. Corp connects to the application landing zone A1, Application landing zone P1, and application landing zone A2 subscriptions. Local connects to application landing zone C1 subscription (Azure Local Clusters) and application landing zone A1 subscription (Applications). Decommissioned maps to a Decommissioned subscription, and Sandbox maps to Sandbox subscription 1 and Sandbox subscription 2. The Online management group has no subscription shown beneath it.
:::image-end:::

*Azure landing zone architecture's Management Group hierarchy only. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architeacture.pdf) of this architecture.*

# [Platform vs. application landing zones](#tab/platvsapp)

:::image type="complex" border="false" source="./media/alz-application-platform.svg" alt-text="Diagram that shows an Azure landing zone management group hierarchy." lightbox="media/alz-application-platform.svg":::
    Diagram titled "Azure landing zone (ALZ) – Terminology." A legend at the top right defines two color overlays: a purple shade for platform landing zone and a green shade for application landing zones. The purple overlay wraps the left portion of the diagram, grouping the Security subscription, Management subscription (D), Identity subscription, and Connectivity subscription (E), the last containing Azure DDoS Protection, Azure DNS, VPN/ExpressRoute gateways, Azure Firewall, and peered hub virtual networks. The green overlay wraps the lower-right portion, grouping the application landing zone A2 subscription (F), application landing zone P1 subscription, and Sandbox subscription (H), each holding application virtual networks and workload resources.

    The central and upper structures remain unshaded, above is the the Enterprise Agreement/Microsoft Customer Agreement billing hierarchy (A), Identity and access management (B), Microsoft Entra ID with on-premises Active Directory Domain Services, and Git repository, boards, and pipelines.
:::image-end:::

*Azure landing zone architecture's management group hierarchy only. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

---

<a name='platform-landing-zones-vs-application-landing-zones'></a>
<a name='platform-landing-zone-vs-application-landing-zones'></a>

## Platform landing zone

The platform landing zone establishes your organization's Azure foundation. It defines how you organize your Azure resources, enforce governance, and provide shared capabilities centrally. Most organizations should have only one platform landing zone per Microsoft Entra tenant.

A platform landing zone consists of a management group hierarchy and centralized resources (as needed). An important function of the platform is to have a way to distribute application landing zones to workload teams.

- **Management group hierarchy:** The management group hierarchy provides the governance structure for the Azure environment. It organizes all of your Azure subscriptions and applies governance standards to those subscriptions. The hierarchy separates platform resources and workload resources. A well-designed hierarchy allows you to apply governance standards consistently without creating unnecessary administrative complexity.

- **Centralized resources:** Many organizations provide certain capabilities centrally so every workload can use the same approved services and standards. Common examples include connectivity and networking, security monitoring, Active Directory identity services, and management services. What you centralize depends on your requirements. Only centralize capabilities that provide clear governance, operational, or economic benefits across multiple workloads.

- **Key platform responsibility:** You need a repeatable process for requesting, creating, and distributing application landing zones to workload teams. A standardized approach ensures every new application landing zone follows your organization's governance and security baselines. You can do this process manually or automate it. As the number of application landing zone requests grows, automation becomes increasingly important. See [Subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

<a name='deploying-and-managing-azure-landing-zone'></a>

**Implementation options:** Microsoft provides several platform landing zone accelerators that implement recommended architecture patterns and organizational guardrails. See [Platform landing zone implementation options](./implementation-options.md). You can also develop your own implementation or work with Microsoft or Microsoft partners to build a customized platform landing zone.

## Application landing zones

Application landing zones host Azure workload resources. Most workloads use multiple application landing zones, with separate application landing zones for each environment such as development, testing, and production. An application landing zone can be one or more Azure subscriptions. You only need multiple Azure subscriptions when required to accommodate workload requirements, organizational boundaries, or Azure subscription limits.

The platform team places application landing zones in either the Online, Internal ("Corp"), or Local management group under the (application) "Landing zones" management group. The application landing zones inherit the governance and security policies from the Azure Policies applied to the management group hierarchy. This model provides consistent guardrails and allows flexibility to meet workload-specific requirements.

**Implementation options:** Microsoft provides several accelerators to establish application landing zones. You can also implement their own approach or engage Microsoft or Microsoft partners for assistance. See the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy#application) for a list of application landing zone accelerators.

<a name='ai-in-azure-landing-zones'></a>

## Technology adoption in an Azure landing zone

Azure landing zones support new and emerging technologies without requiring changes to the overall architecture. You deploy workload resources into application landing zones regardless of workload type, such as AI. As new requirements emerge, you update the governance and security policies in the platform landing zone. Those policies are then applied consistently across application landing zones, which helps you adopt new technologies faster and maintain consistency across all workloads of that type.

The Cloud Adoption Framework provides guidance for common adoption scenarios to help you prepare your people, processes, and platform for successful adoption. See [Scenarios](/azure/cloud-adoption-framework/overview#cloud-adoption-framework-scenarios).

## Next steps

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)
