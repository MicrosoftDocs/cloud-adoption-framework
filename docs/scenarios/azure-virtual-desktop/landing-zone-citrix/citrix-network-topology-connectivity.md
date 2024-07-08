---
title: Hybrid networking with Citrix on Azure
description: Use the Cloud Adoption Framework to identify networking capabilities your Azure landing zone needs to support multiple Citrix workloads on Azure.
author: BenMartinBaur
ms.author: martinek
ms.date: 07/09/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Hybrid networking with Citrix Cloud and Azure

This article provides design recommendations for a single-region Azure and Citrix Cloud environment and a multi-region environment. It covers the components and design considerations you need for a successful deployment.

## Single-region deployment

When you deploy your Azure and Citrix Cloud environment to a single region, use multiple subscriptions. Multiple Azure subscriptions create agility for business units through a mechanism to centralize policy, audit, and configuration requirements. So as a starting point, we recommend that you use a dedicated subscription for Citrix workloads on Azure.

### Architecture

:::image type="content" source="../media/citrix-network-topology-connectivity/citrix-cloud-azure-virtual-desktop-multiple-subscription.svg" alt-text="Diagram of a reference architecture that demonstrates major design areas and design best practices in an Azure and Citrix Cloud multisubscription environment." border="false" lightbox="../media/citrix-network-topology-connectivity/citrix-cloud-azure-virtual-desktop-multiple-subscription.svg":::

*Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/Citrix-accelerator-enterprise-scale-alz-architecture.vsdx) of this architecture.*

### Components

This architecture consists of the following components:

- Active Directory Domain Services (AD DS) servers and custom Domain Name System (DNS) servers
- Network security groups
- Azure Network Watcher
- Outbound internet via a default Azure Virtual Network path
- Azure ExpressRoute or Azure VPN Gateway for hybrid connectivity to on-premises
- Azure private endpoints
- Azure Files storage accounts or Azure NetApp Files 
- Azure Key Vault
- Azure Compute Gallery

For more information, see [Compare profile storage options](/azure/storage/files/storage-files-netapp-comparison).

This scenario also includes the following Citrix components within the Azure landing zone:

- [Citrix Cloud Connector](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/technical-details.html#system-requirements) establishes a connection between Citrix Cloud and your resource locations.

- [Citrix Virtual Delivery Agent (VDA)](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/install-vdas.html) installs on a golden image or target device that hosts your apps or desktops. You can use this agent to connect to, provision, and orchestrate apps and desktops as persistent or non-persistent machines. The VDA is compatible with physical or virtual devices, including Windows Server, Windows client, and Linux OS.
- [Citrix Workspace](https://community.citrix.com/tech-zone/learn/tech-briefs/citrix-workspace) is a cloud service that delivers secure access to information, apps, and other content that's relevant to end user roles. Citrix Workspace integrates Azure assets and on-premises assets so that users have unified access to all their resources in one location from anywhere, on any device.

### Optional Citrix components

The following Citrix components within the Azure landing zone are optional. Consider these components if you need advanced functionality.

- [Citrix Federated Authentication Service](https://docs.citrix.com/en-us/xenapp-and-xendesktop/7-15-ltsr/secure/federated-authentication-service.html) dynamically issues certificates for users so that they can log on to an Active Directory environment. This process is similar to a smartcard. This service enables single sign-on when you use Security Assertion Markup Language (SAML)-based authentication. You can use a broad range of authentication options and partner identity providers, such as Okta and Ping.
- [Citrix StoreFront](https://www.citrix.com/products/citrix-daas/citrix-storefront.html) is an alternative internal user access point for Citrix Workspace. StoreFront is self-managed and seamlessly aggregates resources across multiple on-premises environments and Azure environments. Lift-and-shift scenarios often use StoreFront to maintain user access to existing Citrix deployments while moving workloads to Azure.
- [Citrix ADC (NetScaler)](https://www.citrix.com/products/citrix-adc/) is an alternative external user access point for Citrix Workspace and Citrix Gateway Service. Citrix ADC is a self-managed virtual appliance within your Azure tenant that provides secure proxy for external connectivity and authentication. You can integrate Citrix ADC with StoreFront or Workspace. Lift-and-shift scenarios often use Citrix ADC to maintain user access to existing Citrix deployments while moving workloads to Azure.
- [Citrix Provisioning](https://docs.citrix.com/en-us/provisioning/current-release/architecture.html) is a network-based image-management solution that you can deploy within your Azure tenant to enable scalable deployment of up to thousands of non-persistent machines. Citrix Provisioning streams centralized images over an Azure virtual network, which provides rapid updates and minimizes storage requirements.
- The [Citrix App Layering appliance](https://docs.citrix.com/en-us/citrix-app-layering/4/install-appliance/ms-azure.html) is the central component for the App Layering technology that hosts the management console. You can use App Layering to create and manage layers, layer assignments, and image templates. Use App Layering to help manage single OS instances and app instances and compose images from layers, which reduces effort in environments that have several golden images.

### Citrix design considerations

Consider the [system, workload, user, and network guidance]((https://docs.citrix.com/en-us/tech-zone/toc/by-product/citrix-daas/design-guidance.html)) for Citrix technologies that aligns with Cloud Adoption Framework design principles.

The Citrix on Azure solution requires a certain amount of throughput for each user, various protocols and ports, and other network considerations. You must appropriately size all network appliances, such as Citrix ADC and firewalls to handle load increases during disaster recovery scenarios. For more information, see [Azure-specific considerations](https://community.citrix.com/tech-zone/design/design-decisions/azure-system-considerations).

#### Network segmentation

Citrix also provides guidance for Azure network segmentation and logically segmented subnets. When you review the guidance on network segmentation for Citrix workloads, use the following guidelines to help with initial planning.

##### Segment by workload types

Create separate single-session and multisession virtual networks or subnets to enable growth of each network type without impacting the scalability of the other type.

For example, if you fill a shared multisession and single-session subnet with virtual desktop infrastructure (VDI), you might need to create a new hosting unit to support applications. A new hosting unit requires either creating multiple machine catalogs to support scaling applications, or migrating the existing app catalogs to a new subnet.

If you use [workload subscriptions](https://www.citrix.com/blogs/2020/10/14/citrix-tips-citrix-on-azure-enterprise-scale-landing-zones-part-1/) as part of a multisubscription architecture, understand Citrix Machine Creation Services (MCS) [limits](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/limits.html#machine-creation-services-mcs-limits) on the number of virtual machines (VMs) per Azure subscription. Consider these limits in your virtual network design and when you [plan for IP addressing](../../../ready/azure-best-practices/plan-for-ip-addressing.md).

##### Segment by tenant, business unit, or security zone

If you run a multitenant deployment, such as a [Citrix Service Provider architecture](https://docs.citrix.com/en-us/tech-zone/design/reference-architectures/csp-cvads.html), we recommend that you isolate tenants between networks or subnets. If your existing security standards need specific isolation requirements at a network level, consider isolating separate business units or security zones within your organization.

Weigh business unit segmentation beyond workload-specific networks against the effect of increased complexity on the overall environment. Use this methodology as an exception rather than the rule, and apply this method with the right justification and projected scale. For example, you could create a network for 1,000 contractors that support finance to accommodate security needs beyond the standard single-session VDI network.

You can use [application security groups](/azure/virtual-network/application-security-groups) to allow only specific VMs to access business unit application back ends on a shared virtual network. For example, you could limit customer relations management (CRM) back-end access to the CRM machine catalog VMs that the marketing team uses in the multisession VDA network.

## Multi-region deployment

When you deploy in multiple regions, deploy hubs, shared resource spokes, and VDA spokes in each region. The following architectural diagram shows detailed guidance for large-scale Azure and Citrix Cloud environments in a single region. Carefully select a subscription model and networking model.To choose your models, understand the growth of your Azure footprint inside and outside the Citrix deployment.

You might have a small Citrix deployment. But you might also have a large amount of other resources that read and write heavily against the Azure API, which can have a negative effect on the Citrix environment. Alternatively, you could have several Citrix resources that consume an inordinate number of available API calls, which reduces availability for other resources within the subscription.

For large-scale deployments, isolate workloads so that you can effectively scale out deployments and prevent a negative effect on the customer's Citrix environment.

### Architecture

:::image type="content" source="../media/citrix-network-topology-connectivity/citrix-accelerator-architecture-large-scale.svg" alt-text="Diagram of a reference architecture that demonstrates major design areas and design best practices for a large-scale Azure and Citrix Cloud multisubscription environment." border="false" lightbox="../media/citrix-network-topology-connectivity/citrix-accelerator-architecture-large-scale.svg":::

*Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/Citrix-accelerator-enterprise-scale-alz-architecture.vsdx) of this architecture.*

### Citrix design recommendations

Consider the following recommendations for your large-scale deployments.

#### Peer virtual networks with VDA spokes

For large-scale deployments, create dedicated shared service and management spokes and directly peer them with your VDA spokes. This configuration minimizes latency and prevents you from reaching networking limits in your hub networks. The following points illustrate this approach and correspond to the preceding diagram.

*  *(A) Hub virtual network configuration:* Use the hub virtual network as the central point for firewalls and connectivity for cross-premises networks and external networks.

* *(B) Peering with shared resources spoke:*  Ensure your hub virtual network is peered with the shared resources spoke to provide [Citrix Cloud Connectors](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/technical-details.html) with 443 outbound connectivity. 
* *(C) Shared resource spoke virtual networks:* Host all required and optional Citrix components, and also shared services, such as Profile storage accounts and Azure Compute Galleries, in the shared resource spoke virtual networks. Peer these networks directly with the VDA spokes to minimize latency and improve performance.
* *(D) VDA workload spokes configuration*: Host only the VDAs in the VDA workload spokes. Route all network traffic from VMs and services. e.g. profile traffic directly to the shared resource spoke as long as they within a specific data center region. Route all network traffic that leaves the datacenter region, like internet egress, hybrid, or cross-region connectivity, to the hub virtual network.
* *(E) Compute Gallery version replicas:* Specify the number of replicas that you want to keep in the [Compute Gallery](/azure/virtual-machines/azure-compute-gallery#scaling). In multi-VM deployment scenarios, distribute VM deployments across different replicas to reduce the chance that throttling occurs for an instance creation process due to overloading a single replica.

#### Understand resource limitations

When you design a deployment for a large-scale Citrix managed database service on Azure, review the [Citrix limitations](https://docs.citrix.com/en-us/citrix-daas/limits.html) and [Azure limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits#networking-limits). These limitations affect your design, configuration, and management of Citrix and Azure environments. They also affect the performance, scalability, and availability of virtual desktops and applications. The limits are dynamic, so check for updates frequently. If current limits don't meet your needs, promptly contact your Microsoft and Citrix representatives.

## Contributors

*This article is maintained by Microsoft. It was originally written by the following contributors.*

Principal authors:

* [Ben Martin Baur](https://www.linkedin.com/in/ben-martin-baur/) | Senior Cloud Endpoint Technical Specialist
* [Jen Sheerin](https://www.linkedin.com/in/jensheerin/) | Senior Customer Engineer
* [Ravi Varma Addala](https://www.linkedin.com/in/ravi-varma-addala-7b24011b/) | Senior Cloud Solution Architect, Azure Core Infrastructure

*To see non-public LinkedIn profiles, sign in to LinkedIn.*

## Next steps

To learn more about Azure networking best practices and how to plan for virtual networks based on isolation, connectivity, and location requirements, see [Plan virtual networks](/azure/virtual-network/virtual-network-vnet-plan-design-arm).

Review the critical design considerations and recommendations for management and monitoring that are specific to the deployment of Citrix on Azure.

- [Management and monitoring](citrix-management-monitoring.md)

