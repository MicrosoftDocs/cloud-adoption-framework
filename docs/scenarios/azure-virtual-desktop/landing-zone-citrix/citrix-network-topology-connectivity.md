---
title: Configure hybrid networking for Citrix on Azure
description: Learn how to use the Cloud Adoption Framework to design networking for your Azure landing zone to support multiple Citrix workloads on Azure.
author: BenMartinBaur
ms.author: bebaur
ms.date: 07/09/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Configure hybrid networking for Citrix Cloud and Azure

This article describes architectures for single-region and multiregion Azure and Citrix Cloud environments. It provides design considerations, design recommendations, and components that you can implement for a successful deployment.

## Single-region deployment

When you deploy your Azure and Citrix Cloud environment to a single region, use multiple subscriptions. Multiple Azure subscriptions provide agility for business units because they centralize policy, audit, and configuration requirements. So as a starting point, we recommend that you use a dedicated subscription for Citrix workloads on Azure.

### Architecture

:::image type="content" source="../media/citrix-network-topology-connectivity/citrix-cloud-azure-virtual-desktop-multiple-subscription.svg" alt-text="Diagram that shows a reference architecture of major design areas and design best practices in an Azure and Citrix Cloud multisubscription environment." border="false" lightbox="../media/citrix-network-topology-connectivity/citrix-cloud-azure-virtual-desktop-multiple-subscription.svg":::

*Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-cloud-azure-virtual-desktop-multiple-subscription.vsdx) of this architecture.*

### Components

This architecture consists of the following components:

- Active Directory Domain Services (AD DS) servers and custom Domain Name System (DNS) servers
- Network security groups
- Azure Network Watcher
- Outbound internet via a default Azure Virtual Network path
- Azure ExpressRoute or Azure VPN Gateway for hybrid connectivity to on-premises environments
- Azure private endpoints
- Azure Files storage accounts or Azure NetApp Files 
- Azure Key Vault
- Azure Compute Gallery

For more information, see [Compare profile storage options](/azure/storage/files/storage-files-netapp-comparison).

This architecture also includes the following Citrix components within the Azure landing zone:

- The [Citrix Cloud Connector](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/technical-details.html#system-requirements) establishes a connection between Citrix Cloud and the resource locations.

- [Citrix Virtual Delivery Agent (VDA)](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/install-vdas.html) is installed on a golden image or target device that hosts apps or desktops. This agent can be used to connect to, provision, and orchestrate apps and desktops as persistent or non-persistent machines. The VDA is compatible with physical devices or virtual devices, including Windows Server, Windows client, and Linux OS.
- [Citrix Workspace](https://community.citrix.com/tech-zone/learn/tech-briefs/citrix-workspace) is a cloud service that provides users secure access to information, apps, and other content. Citrix Workspace integrates Azure assets and on-premises assets so that users have a single point of access to all their resources from any location and on any device.

### Optional Citrix components

The following Citrix components within the Azure landing zone are optional. Consider these components if you need advanced functionality.

- [Citrix Federated Authentication Service](https://docs.citrix.com/en-us/xenapp-and-xendesktop/7-15-ltsr/secure/federated-authentication-service.html) dynamically issues certificates for users so that they can sign in to a Windows Server Active Directory environment. This method is similar to using a smartcard. Citrix Federated Authentication Service enables single sign-on when you use Security Assertion Markup Language-based authentication. You can use a broad range of authentication options and partner identity providers, such as Okta and Ping.

- [Citrix StoreFront](https://www.citrix.com/products/citrix-daas/citrix-storefront.html) is an alternative internal user access point for Citrix Workspace. StoreFront is self-managed and seamlessly aggregates resources across multiple on-premises environments and Azure environments. You can use StoreFront in a lift-and-shift scenario to maintain user access to existing Citrix deployments while you move workloads to Azure.
- [Citrix Application Delivery Controller (ADC) or NetScaler](https://www.citrix.com/products/citrix-adc/) is an alternative external user access point for Citrix Workspace and Citrix Gateway Service. Citrix ADC is a self-managed virtual appliance within your Azure tenant that provides secure proxy for external connectivity and authentication. You can integrate Citrix ADC with StoreFront or Workspace. Use Citrix ADC in a lift-and-shift scenario to maintain user access to existing Citrix deployments while you move workloads to Azure.
- [Citrix Provisioning](https://docs.citrix.com/en-us/provisioning/current-release/architecture.html) is a network-based image-management solution that you can deploy within your Azure tenant to enable scalable deployment of up to thousands of non-persistent machines. Citrix Provisioning streams centralized images over an Azure virtual network, which provides quick updates and minimizes storage requirements.
- The [Citrix App Layering appliance](https://docs.citrix.com/en-us/citrix-app-layering/4/install-appliance/ms-azure.html) is the central component for the App Layering technology that hosts the management console. You can use App Layering to create and manage layers, layer assignments, and image templates. You can also help manage single OS instances and app instances and compose images from layers, which reduces effort in environments that have several golden images.

### Citrix design considerations

Consider the [system, workload, user, and network guidance](https://community.citrix.com/tech-zone/by-product/citrix-daas#_=_) for Citrix technologies. This guidance aligns with Cloud Adoption Framework design principles.

The Citrix on Azure solution requires a certain amount of throughput for each user, various protocols and ports, and other network considerations. You must appropriately size all network appliances, such as Citrix ADC and firewalls, to handle load increases during disaster recovery scenarios. For more information, see [Azure-specific considerations](https://community.citrix.com/tech-zone/design/design-decisions/azure-system-considerations).

#### Network segmentation

Also consider the [Citrix guidance for Azure network segmentation and logically segmented subnets](https://community.citrix.com/tech-zone/design/reference-architectures/virtual-apps-and-desktops-azure/#wiki-header-45). Use the following guidelines to help plan your initial networking.

##### Segment by workload types

Create separate single-session and multisession virtual networks or subnets to enable growth of each network type without affecting the scalability of the other network type.

For example, if you fill a shared multisession and single-session subnet with virtual desktop infrastructure (VDI), you might need to create a new hosting unit to support applications. A new hosting unit requires that you either create multiple machine catalogs to support scaling applications or that you migrate the existing app catalogs to a new subnet.

If you use [workload subscriptions](https://www.citrix.com/blogs/2020/10/14/citrix-tips-citrix-on-azure-enterprise-scale-landing-zones-part-1/) in a multisubscription architecture, understand Citrix Machine Creation Services (MCS) [limits](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/limits.html#machine-creation-services-mcs-limits) for the number of virtual machines (VMs) per Azure subscription. Consider these limits when you design your virtual network and when you [plan for IP addressing](../../../ready/azure-best-practices/plan-for-ip-addressing.md).

##### Segment by tenant, business unit, or security zone

If you run a multitenant deployment, such as a [Citrix Service Provider architecture](https://docs.citrix.com/en-us/tech-zone/design/reference-architectures/csp-cvads.html), we recommend that you isolate tenants between networks or subnets. If your existing security standards need specific isolation requirements at the network level, consider isolating separate business units or security zones within your organization.

If you segment business units beyond workload-specific networks, the complexity of the overall environment increases. Determine whether this method is worth the increased complexity. Use this method as an exception rather than the rule, and apply it with the right justification and projected scale. For example, you might create a network for 1,000 contractors that support finance to accommodate security needs beyond the standard single-session VDI network.

You can use [application security groups](/azure/virtual-network/application-security-groups) to allow only specific VMs to access business unit application back ends on a shared virtual network. For example, you might limit customer relations management (CRM) back-end access to the CRM machine catalog VMs that the marketing team uses in the multisession VDA network.

## Multiregion deployment

When you deploy your workload in multiple regions, you should deploy hubs, shared resource spokes, and VDA spokes in each region. Carefully select a subscription model and a networking model. Determine your models based on the growth of your Azure footprint inside and outside the Citrix deployment.

You might have a small Citrix deployment and a large number of other resources that read and write heavily against the Azure API, which can negatively affect the Citrix environment. Alternatively, you might have several Citrix resources that consume an excessive number of available API calls, which reduces availability for other resources within the subscription.

For large-scale deployments, isolate workloads so that you can effectively scale out deployments and prevent a negative effect on the customer's Citrix environment. The following architectural diagram shows a single region that's in a multiregion Azure and Citrix Cloud environment.

### Architecture

:::image type="content" source="../media/citrix-network-topology-connectivity/citrix-accelerator-architecture-large-scale.svg" alt-text="Diagram that shows a reference architecture of major design areas and design best practices for a large-scale Azure and Citrix Cloud multisubscription environment." border="false" lightbox="../media/citrix-network-topology-connectivity/citrix-accelerator-architecture-large-scale.svg":::

*Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-accelerator-architecture-large-scale.vsdx) of this architecture.*

### Citrix design recommendations

Consider the following recommendations for your large-scale deployments.

#### Peer virtual networks with VDA spokes

For large-scale deployments, create dedicated shared service and management spokes, and directly peer them with your VDA spokes. This configuration minimizes latency and prevents you from reaching networking limits in your hub networks. The following points illustrate this approach, and they correspond to the preceding diagram.

*  *(A) Hub virtual network configuration*: Use the hub virtual network as the central point for firewalls and connectivity for cross-premises networks and external networks.

* *(B) Shared resource spoke peering*: Ensure that you peer your hub virtual network with the shared resource spoke to provide the [Citrix Cloud Connectors](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/technical-details.html) with 443 outbound connectivity. 
* *(C) Shared resource spoke virtual networks*: Host all required and optional Citrix components, and host shared services, such as profile storage accounts and Azure compute galleries, in the shared resource spoke virtual networks. To minimize latency and improve performance, peer these networks directly with the VDA spokes.
* *(D) VDA workload spokes configuration*: Host only the VDAs in the VDA workload spokes. Route all network traffic from VMs and services. For example, you can route profile traffic directly to a shared resource spoke if the resource spoke is within a specific datacenter region. Route all network traffic that leaves the datacenter region, like internet egress, hybrid, or cross-region connectivity, to the hub virtual network.
* *(E) Compute Gallery version replicas*: Specify the number of replicas that you want to keep in [Compute Gallery](/azure/virtual-machines/azure-compute-gallery#scaling). In multi-VM deployment scenarios, distribute VM deployments across different replicas. Use this approach so that when you create an instance, throttling doesn't occur due to overloading a single replica.

#### Understand resource limitations

When you design a deployment for a large-scale Citrix managed database service on Azure, understand [Citrix limitations](https://docs.citrix.com/en-us/citrix-daas/limits.html) and [Azure limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits#networking-limits). These limitations affect your design, configuration, and management of Citrix and Azure environments. They also affect the performance, scalability, and availability of virtual desktops and applications. The limits are dynamic, so check for updates frequently. If current limits don't meet your needs, promptly contact your Microsoft and Citrix representatives.

## Contributors

*This article is maintained by Microsoft. It was originally written by the following contributors.*

Principal authors:

* [Ben Martin Baur](https://www.linkedin.com/in/ben-martin-baur/) | Senior Cloud Endpoint Technical Specialist
* [Jen Sheerin](https://www.linkedin.com/in/jensheerin/) | Senior Customer Engineer
* [Ravi Varma Addala](https://www.linkedin.com/in/ravi-varma-addala-7b24011b/) | Senior Cloud Solution Architect, Azure Core Infrastructure

*To see non-public LinkedIn profiles, sign in to LinkedIn.*

## Next steps

To learn more about Azure networking best practices and how to plan for virtual networks based on isolation, connectivity, and location requirements, see [Plan virtual networks](/azure/virtual-network/virtual-network-vnet-plan-design-arm).

Review the critical design considerations and recommendations for [management and monitoring](citrix-management-monitoring.md) that are specific to the deployment of Citrix on Azure.


