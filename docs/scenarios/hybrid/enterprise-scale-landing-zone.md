---
title: Hybrid and multicloud adoption with Azure Arc and Azure landing zones
description: Learn how Azure Arc accelerates hybrid and multicloud adoption with Azure landing zones.
author: stephen-sumner
ms.author: pnp
ms.date: 09/29/2025
ms.topic: concept-article
---

# Implement hybrid and multicloud adoption with Azure Arc and Azure landing zones

Azure Arc landing zone accelerator enables organizations to implement scalable hybrid and multicloud architectures. Azure Arc projects and manages resources that exist outside Azure, such as on-premises servers, Kubernetes clusters, and multicloud services, into the Azure control plane. This hybrid and multicloud approach provides unified governance, security, and operations across distributed environments.

This article helps you integrate Azure Arc resources into your Azure landing zones. This integration defines how to treat external resources as first-class citizens in Azure, and this approach ensures consistent management and compliance across all environments.

**Quick link:** [Common patterns for Azure Arc resources in Azure landing zones](#apply-common-patterns-for-azure-arc-resources-in-azure-landing-zones)

:::image type="complex" source="./media/arc-unified-operations.png" alt-text="Diagram showing Azure Arc unified operations.":::
Azure Arc unified operations across Azure, on-premises, multicloud, and edge environments managed through a central Azure control plane with Azure Arc projecting external resources into Azure Resource Manager for centralized governance and operations.
:::image-end:::

## Establish a foundational Azure environment for hybrid and multicloud resources

Organizations must establish a well-structured Azure environment to support governance and management of hybrid and multicloud resources. Azure landing zones provide the foundation required for effective resource management.

1. **Deploy Azure landing zones to support hybrid and multicloud scenarios.** [Azure landing zones](/azure/cloud-adoption-framework/ready/) (platform and application) establish a scalable and secure foundation for your environment. These landing zones include design areas such as identity, network topology, resource organization, and governance. Select a landing zone architecture that aligns with your organization's cloud strategy. This alignment ensures that your environment scales appropriately as your organization grows.

2. **Design network architectures to connect hybrid and multicloud environments.** [Network architecture](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) must support secure and reliable connectivity between Azure and external environments. Consider VPNs, ExpressRoute, and private endpoints to integrate on-premises and multicloud resources with Azure. Network design provides the foundation for secure data transfer and consistent performance across all environments.

3. **Extend governance and operations with Azure Arc.** Azure Arc onboards external resources into Azure Resource Manager (ARM) to enable centralized management. Azure Arc enables centralized policy enforcement, monitoring, and automation using native Azure tools such as Azure Policy, Azure Monitor, and Microsoft Defender for Cloud. This centralized approach reduces operational complexity and ensures consistent governance across all environments.

:::image type="complex" source="./media/azure-arc-esu-landing-zone-flow-chart.png" alt-text="Flow chart showing Azure Arc landing zone guidance.":::
Azure Arc landing zone guidance with decision points for organizations with and without existing Azure Landing Zones, outlining pathways for implementing Extended Security Updates through Azure Arc for on-premises servers.
:::image-end:::

## Integrate Azure Arc resources with application landing zones

Azure Arc resources integrate into application architectures to provide unified management across environments. Common examples include Azure Arc-enabled servers, VMware vSphere, System Center Virtual Machine Manager, customer-managed Kubernetes clusters, and Azure Arc-enabled data services.

1. **Project on-premises IT assets into Azure with Azure Arc-enabled servers, VMware vSphere, and System Center Virtual Machine Manager.** These Azure Arc services project on-premises IT assets into the Azure control plane. This projection enables centralized management of on-premises infrastructure alongside Azure resources.

2. **Operate customer-managed Kubernetes clusters across multicloud environments.** Customer-managed Kubernetes clusters operate across multicloud environments with centralized control through Azure Arc. This centralized approach simplifies cluster management and ensures consistent policy enforcement across all environments.

3. **Extend Azure capabilities to edge locations with Azure Arc-enabled services.** Azure Arc-enabled data, application, and machine learning services extend Azure capabilities to edge locations where data sovereignty or latency requirements exist. This extension provides consistent Azure experiences regardless of physical location.

Application landing zone subscriptions include both native Azure resources and Azure Arc-enabled resources. Azure Arc resources run outside Azure and are projected into Azure Resource Manager as Azure resources you manage with the same governance and security controls. Treat Azure Arc resources like any other Azure resource in your landing zone (whether platform or application) aligned with the [design principles](../../ready/landing-zone/design-principles.md).

:::image type="complex" source="./media/landing-zone-design-revised.png" alt-text="Diagram showing landing zone design architecture.":::
Landing zone design architecture with management groups, subscriptions, and resource groups organized hierarchically to support Azure Arc integration, demonstrating how Azure Arc resources integrate into application landing zones as metadata resources.
:::image-end:::

## Apply common patterns for Azure Arc resources in Azure landing zones

These examples demonstrate how to project Azure Arc resources as metadata resources in Azure landing zones. Each pattern addresses specific organizational needs while maintaining consistent governance.

### Example one: Project domain controllers outside of Azure

Active Directory Domain Services (AD DS) deployments exist within most customer environments. Domain controllers are critical components of AD DS and the overall architecture that organizations use for identity services.

Azure landing zone reference architecture includes a dedicated identity landing zone subscription that hosts identity-based resources. You can host identity resources in Azure with AD DS domain controller (DC) virtual machines (VMs), or you can project identity resources into Azure from any other location through Azure Arc-enabled servers. This flexibility enables organizations to maintain existing identity infrastructure while they gain centralized management capabilities.

### Example two: Project on-premises datacenters into Azure

On-premises datacenters remain present in most customer environments. Datacenter footprints vary from single servers to large virtualized environments that require comprehensive management.

Organizations can treat their on-premises datacenters as normal landing zones and place datacenter resources into new or existing landing zones based on organizational needs. Common approaches include:

- Project resources into dedicated landing zone subscriptions for on-premises datacenter resources. In larger environments with multiple datacenters across the globe, organizations establish one landing zone per geopolitical region. These regional landing zones contain the resources from each region to provide logical separation of on-premises datacenters within Azure. This regional approach supports security, governance, and compliance requirements for different on-premises datacenters.
- Project resources into separate landing zone subscriptions based on other Azure resources that support the same application or service. This application-centric approach ensures that all components of an application are managed together regardless of their physical location.

### Example three: Project remote application resources into Azure

Organizations develop latency-sensitive applications or applications with data sovereignty requirements. These applications require resources to be hosted outside of Azure while maintaining centralized control, governance, security, and operations for all application components. Azure Arc enables organizations to achieve centralized management for distributed applications.

Organizations must project Azure Arc resources for their applications into the same application landing zone subscription that hosts their Azure resources. Organizations can then apply one set of controls to all resources from a single control plane regardless of where the resources are physically located. This unified approach simplifies operations and ensures consistent governance across all application components.

### Example four: Project on-premises servers that reached end of support into Azure to use Extended Security Updates delivered through Azure Arc

Windows Server versions reach end of support, and organizations cannot always meet end-of-support deadlines while servers need to remain on-premises. Organizations can purchase [Extended Security Updates](/windows-server/get-started/extended-security-updates-overview) enabled by [Azure Arc](https://azure.microsoft.com/products/azure-arc/) to maintain security support for these servers.

If organizations deploy Azure Landing Zones or already have Azure Landing Zones deployed, organizations can treat their on-premises datacenters as normal landing zones and place datacenter resources into new or existing landing zones based on their needs. Common approaches include:

- Project resources into dedicated landing zone subscriptions for on-premises datacenter resources. In larger environments with multiple datacenters across the globe, organizations establish one landing zone per geopolitical region. These regional landing zones contain the resources from each region to provide logical separation of on-premises datacenters within Azure. This regional approach supports security, governance, and compliance requirements for different on-premises datacenters.
- Project resources into separate landing zone subscriptions based on other Azure resources that support the same application or service.
- Organizations must review the Azure Arc-enabled Servers landing zone accelerator guidance to understand design considerations and recommendations across critical design areas.

## Next step

Learn how to [Deploy Azure Arc sandbox to accelerate adoption of hybrid or multicloud architectures](./arc-enabled-servers/enterprise-scale-landing-zone-sandbox.md).
