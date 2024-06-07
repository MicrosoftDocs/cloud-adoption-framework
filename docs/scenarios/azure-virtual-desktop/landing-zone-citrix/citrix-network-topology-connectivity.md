---
title: Hybrid networking with Citrix on Azure
description: Use the Cloud Adoption Framework to identify networking capabilities your Azure landing zone needs to support multiple Citrix workloads on Azure.
author: BenMartinBaur
ms.author: martinek
ms.date: 02/08/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Hybrid networking with Citrix Cloud and Azure

This article describes a reference architecture that demonstrates major design areas and design best practices for an Azure and Citrix Cloud environment with multiple subscriptions.

## [WHAT TYPE OF DEPLOYMENT?]

[ADD]  The following architectural diagram shows an Azure and Citrix Cloud environment with multiple subscriptions.

### Architecture

[![Diagram of a reference architecture that demonstrates major design areas and design best practices in an Azure and Citrix Cloud multisubscription environment.](../media/citrix-cloud-azure-virtual-desktop-multiple.png)](../media/citrix-cloud-azure-virtual-desktop-multiple.png#lightbox)

[Download the Visio file.](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/Citrix-accelerator-enterprise-scale-alz-architecture.vsdx)

### Components

You can implement this architecture with the following components:

- Active Directory Domain Services (AD DS) servers and custom domain name system (DNS) servers
- Network security groups
- Azure Network Watcher
- Outbound internet via a default Azure Virtual Network path
- Azure ExpressRoute or Azure VPN Gateway for hybrid connectivity to on-premises
- Azure private endpoints
- Azure Files storage accounts or Azure NetApp Files [Compare profile storage options](/azure/storage/files/storage-files-netapp-comparison)
- Azure Key Vault

This scenario also includes the following Citrix components within the Azure landing zone:

- [Citrix Cloud Connector](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/technical-details.html#system-requirements) establishes a connection between Citrix Cloud and your resource locations.
- [Citrix Virtual Delivery Agent (VDA)](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/install-vdas.html) installs on a master image or target device that hosts your apps or desktops. This agent enables connectivity, provisioning, and orchestration of these resources as persistent or non-persistent machines. The VDA is compatible with physical or virtual devices and Windows Server, Windows Client, or Linux OS.
- [Citrix Workspace](https://docs.citrix.com/en-us/tech-zone/learn/tech-briefs/citrix-workspace.html) is a cloud service that delivers secure access to the information, apps, and other content relevant to end user roles. Citrix Workspace integrates Azure and on-premises assets, enabling unified access to all your users' resources in one location from anywhere, on any device.

### Optional Citrix components

The following Citrix components within the Azure landing zone are optional. Consider these components if you need advanced functionality.

- [Citrix Federated Authentication Service](https://docs.citrix.com/en-us/xenapp-and-xendesktop/7-15-ltsr/secure/federated-authentication-service.html) dynamically issues certificates for users, allowing them to log on to an Active Directory environment as if they had a smartcard. This service enables single sign-on when using Security Assertion Markup Language (SAML)-based authentication. You can use a broad range of authentication options and third-party identity providers, such as Okta and Ping.
- [Citrix StoreFront](https://www.citrix.com/products/citrix-daas/citrix-storefront.html) is an alternative internal user access point for Citrix Workspace. StoreFront is self-managed and seamlessly aggregates resources across multiple on-premises and Azure environments. Lift and shift scenarios often use StoreFront to maintain user access to existing Citrix deployments while moving workloads to Azure.
- [Citrix ADC (NetScaler)](https://www.citrix.com/products/citrix-adc/) is an alternative external user access point for Citrix Workspace and Gateway Service. Citrix ADC is a self-managed virtual appliance within your Azure tenant that provides secure proxy for external connectivity and authentication. You can integrate Citrix ADC with StoreFront or Workspace. Lift and shift scenarios often use Citrix ADC to maintain user access to existing Citrix deployments while moving workloads to Azure.
- [Citrix Provisioning](https://docs.citrix.com/en-us/provisioning/current-release/architecture.html) is a network-based image management solution that you can deploy within your Azure tenant to enable scalable deployment of up to thousands of non-persistent machines. Citrix Provisioning supports rapid updates and reduced storage requirements by streaming centralized images over an Azure virtual network.
- [Citrix App Layering appliance](https://docs.citrix.com/en-us/citrix-app-layering/4/install-appliance/ms-azure.html) is the central component for the App Layering technology that hosts the management console and allows the creation and management of layers, layer assignments, and image templates. App Layering helps manage single OS and app instances and compose images from layers, greatly reducing effort in environments with many golden images.

### Citrix design considerations

Design guidance for Citrix DaaS on Microsoft Azure is available on [Citrix TechZone - Design Guidance for Citrix DaaS on Microsoft Azure](https://docs.citrix.com/en-us/tech-zone/toc/by-product/citrix-daas/design-guidance.html). That guidance highlights the system, workload, user, and network considerations for Citrix technologies in alignment with Cloud Adoption Framework design principles.

The Citrix on Azure solution requires a certain amount of throughput for each user, various protocols and ports, and other network considerations. All network appliances, such as Citrix ADC and firewalls, must be sized appropriately to handle load increases during disaster recovery scenarios. For more information, see [Design Decision: Azure Specific Considerations](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/azure-system-considerations.html).

#### Network segmentation

Citrix also provides guidance for Azure network segmentation and logically segmented subnets. When you review the guidance on network segmentation for Citrix workloads, use the following guidelines to help with initial planning:

##### Segment by workload types

Create separate single-session and multisession virtual networks or subnets to enable growth of each network type without impacting the scalability of the other type.

For example, if you fill a shared multisession and single-session subnet with virtual desktop infrastructure (VDI), you might need to create a new hosting unit to support applications. A new hosting unit requires either creating multiple machine catalogs to support scaling applications, or migrating the existing app catalogs to a new subnet.

If you use [workload subscriptions](https://www.citrix.com/blogs/2020/10/14/citrix-tips-citrix-on-azure-enterprise-scale-landing-zones-part-1/) as part of a multisubscription architecture, understand Citrix Machine Creation Service (MCS) [limits](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/limits.html#machine-creation-services-mcs-limits) on the number of virtual machines (VMs) per Azure subscription. Consider these limits in your virtual network design and when you [plan for IP addressing](../../../ready/azure-best-practices/plan-for-ip-addressing.md).

##### Segment by tenant, business unit, or security zone

If you're running a multitenant deployment, such as a [Citrix Service Provider architecture](https://docs.citrix.com/en-us/tech-zone/design/reference-architectures/csp-cvads.html), it's best to isolate tenants between networks or subnets is recommended. If your existing security standards need specific isolation requirements at a network level, consider isolating separate business units or security zones within your organization.

Weigh business unit segmentation beyond workload-specific networks against the effect of increased complexity on the overall environment. This methodology should be the exception rather than the rule, and be applied with the right justification and projected scale. For example, you could create a network for 1,000 contractors supporting finance to accommodate security needs beyond the standard single-session VDI network.

You can use [application security groups](/azure/virtual-network/application-security-groups) to allow only specific VMs to access business unit application backends on a shared virtual network. For example, you could limit customer relations management (CRM) backend access to the CRM machine catalog VMs that Marketing uses in the multisession VDA network.

## Large scale enterprise deployments

The following architectural diagram shows a detailed guidance for large scale Azure and Citrix Cloud environments in a single region. When deploying in multiple regions, it is recommended to deploy hubs, shared resource spokes and VDA spokes in each regions.

### Architecture

[![Diagram of a reference architecture that demonstrates major design areas and design best practices in an Azure and Citrix Cloud multisubscription environment.](../media/citrix-accelerator-enterprise-scale-alz-architecture-largescale.png)](../media/citrix-accelerator-enterprise-scale-alz-architecture-largescale.png#lightbox)

[Download the Visio file.](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/Citrix-accelerator-enterprise-scale-alz-architecture.vsdx)

### Citrix Design recommendations

All the previous design recommendations apply to large-scale deployments. The following recommendations apply specifically to large-scale deployments:

*Understand resource limitations.* When you design a large-scale Citrix DaaS on Azure deployment, review the [Citrix DaaS limitations](https://docs.citrix.com/en-us/citrix-daas/limits.html) and [Azure limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits#networking-limits). These limitations affect your design, configuration, and management of Citrix and Azure environments. They also affect the performance, scalability, and availability of virtual desktops and applications. The information is dynamic, so check for updates frequently. If current limits do not meet your needs, contact your Microsoft and Citrix representatives early.

*Peer virtual networks with VDA spokes.* For large-scale deployments, create dedicated shared service and management spokes directly peered with your VDA spokes to minimize latency and to avoid hitting networking limits at your hub networks. The following points A-E illustrate this approach:

*  *(A) Hub virtual network configuration:* Use the hub virtual network as the central point for firewalls and connectivity for cross-premises networks and external networks.
* *(B) Peering with shared resources spoke:*  Ensure your hub virtual network is peered with the shared resources spoke to provide [Citrix Cloud Connectors](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/technical-details.html) with 443 outbound connectivity. 
* *(C) Shared resource spoke virtual networks:* Host all required and optional Citrix components, as well as shared services (such as Profile storage accounts, Azure Compute Galleries), in the shared resource spoke virtual networks. Peer these networks directly with the VDA spokes to minimize latency and improve performance.
* *(D) VDA workload spokes configuration*: Host only the VDAs in the VDA workload spokes. Route all network traffic from virtual machines and services e.g. profile traffic directly to the shared resource spoke as long as they within a specific data center region. All network traffic leaving the data center region like internet egress, hybrid or cross region connectivity should be routed to the hub virtual network.
* *(E) Azure Compute Gallery version replicas:* Specify the number of replicas you want to keep in the [Azure Compute Gallery](/azure/virtual-machines/azure-compute-gallery#scaling). In multi-VM deployment scenarios, distribute VM deployments across different replicas to reduce the chance of instance creation processing being throttled due to overloading of a single replica.

## Contributors

*This article is maintained by Microsoft. It was originally written by the following contributors.*

Principal author:

* [Ben Martin Baur](https://www.linkedin.com/in/BenMartinBaur) | Senior Cloud Endpoint Technical Specialist
* [Jen Sheerin](https://www.linkedin.com/in/...) | Senior Customer Engineer
* [Ravi Varma Addala](https://www.linkedin.com/in//) | Senior Cloud Solution Architect, Azure Core Infrastructure

## Next steps

To learn more about Azure networking best practices and how to plan for virtual networks based on isolation, connectivity, and location requirements, see [Plan virtual networks](/azure/virtual-network/virtual-network-vnet-plan-design-arm).

Review the critical design considerations and recommendations for management and monitoring specific to the deployment of Citrix on Azure.

- [Management and monitoring](citrix-management-monitoring.md)

