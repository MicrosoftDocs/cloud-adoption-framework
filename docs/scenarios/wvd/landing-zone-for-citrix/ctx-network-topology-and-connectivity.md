---
title: Networking for Citrix on Azure
description: Use the Cloud Adoption Framework for Azure to identify networking capabilities that your landing zone needs to support Citrix on Azure workloads.
author: bebaur
ms.author: martinek
ms.date: 01/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Citrix: Hybrid connectivity using Citrix Cloud and Azure 

**Architectural Components**
You can implement this scenario with: 
- AD DS servers and custom DNS servers.
- Network security groups.
- Network Watcher.
- Outbound internet via default Azure vNet path.
- Express route or VPN virtual network gateway for hybrid connectivity to on-premises.
- Azure private endpoints.
- Azure files service on storage accounts.
- Azure key vault.

In addition to above, this scenario includes the following Citrix components within the Azure landing zone:

- [Citrix Cloud Connector](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/technical-details.html#system-requirements) - Establishes a connection between Citrix Cloud and your resource locations.
- [Citrix Virtual Delivery Agent](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/install-vdas.html) - Citrix agent installed on a master image or target device hosting the desired apps or desktops. This agent enables connectivity, provisioning, and orchestration of these resources as persistent or non-persistent machines. It is compatible with physical or virtual devices and Windows Server, Windows Client, or Linux OS.
- [Citrix Workspace](https://docs.citrix.com/en-us/tech-zone/learn/tech-briefs/citrix-workspace.html) - Citrix Workspace is a cloud service that delivers secure access to the information, apps, and other content that is relevant to an end user’s role in your organization. It integrates Azure and on-premises assets, enabling unified access to all the resources available to your users in one location from anywhere, on any device.

## Architecture

The following diagram shows a conceptual reference architecture that demonstrates major design areas and design best practices in an Citrix Cloud and Azure environment with multiple subscriptions. 

**Multi subscription deployment**
[![Diagram of the hub and spoke with hybrid connectivity scenario with multiple subscriptions](../media/citrix-cloud-azure-virtual-desktop-architecture-2.png)](../media/citrix-cloud-azure-virtual-desktop-architecture-2.png#lightbox)

## Optional Citrix components within the Azure landing zone

The following components are optional and should be considered if advanced functionality is required:

- [Citrix Federated Authentication Service](https://docs.citrix.com/en-us/xenapp-and-xendesktop/7-15-ltsr/secure/federated-authentication-service.html) (FAS) is dynamically issuing certificates for users, allowing them to log on to an Active Directory environment as if they had a smart card. This enables single sign-on when using a SAML-based authentication and allows a broader range of authentication options, such third-party identity providers (Okta, Ping, etc.) (Okta, Ping, etc.)
- [Citrix StoreFront](https://www.citrix.com/products/citrix-daas/citrix-storefront.html) - Alternative internal user access point from Citrix Workspace (cloud service).  StoreFront is self-managed and seamlessly aggregates resources across multiple on-prem and Azure environments. It often used in lift and shift scenarios for existing Citrix deployments to maintain existing user access while workloads are moved to Azure. 
- [Citrix ADC (NetScaler)](https://www.citrix.com/products/citrix-adc/) - Alternative external user access point from Citrix Workspace and Gateway Service (cloud services). Citrix ADC (NetScaler) is a self-managed virtual appliance within your Azure tenant that provides secure proxy for external connectivity and authentication. It can be integrated with StoreFront or Workspace and is often used in lift and shift scenarios for existing Citrix deployments to maintain existing user access while workloads are moved to Azure.
- [Citrix Provisioning](https://docs.citrix.com/en-us/provisioning/current-release/architecture.html) – A network-based image management solution that can be deployed within you Azure tenant to enable scalable deployment of up to thousands of non-persistent machines. Citrix Provisioning enables rapid updates and reduced Storage requirements by streaming centralized images over an Azure virtual network.
- [Citrix App Layering Appliance](https://docs.citrix.com/en-us/citrix-app-layering/4/install-appliance/ms-azure.html) – Central component for App Layering technology that hosts the management console and allows the creation and management of layers, layer assignments, and image templates. App Layering helps to manage single instances of OSes and apps and compose images from layers – greatly reducing effort in environments with a sizable number of golden images.

**Citrix design considerations**

Design guidance for Citrix DaaS on Microsoft Azure is available on [Citrix TechZone - Design Guidance for Citrix DaaS on Microsoft Azure](https://docs.citrix.com/en-us/tech-zone/toc/by-solution/daas-for-azure/design-guidance.html) and highlights the system, workload, user, and network considerations for Citrix technologies in alignment with Cloud Adoption Framework design principles.

The Citrix on Azure solution requires a given amount of throughput for each user, various protocols and ports, and other network considerations as outlined [here](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/azure-system-considerations.html). As such, all network appliances (ADCs, firewalls, etc.) must be sized accordingly to handle load increases during DR scenarios. 

Guidance is also available regarding Azure network segmentation and logically segmenting subnets. When reviewing this guidance, you can use the following guidelines to help with initial planning on network segmentation for Citrix workloads:

- **Segmenting by Workload Types** – Creating separate single-session and multi-session virtual networks or subnets enables growth of both persona types without impacting the scalability of the other. For example, filling a shared multi-session and single-session subnet with VDI, resulting in the creation of a new hosting unit to support an application use case. This forces the usage of multiple machine catalogs (Citrix terminology for resource pools) to support scaling the application or migrating the existing app catalogs to a new subnet. If using [workload subscriptions](https://www.citrix.com/blogs/2020/10/14/citrix-tips-citrix-on-azure-enterprise-scale-landing-zones-part-1/) as part of a multi-subscription architecture, consider [Citrix Machine Creation Services limits](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/limits.html#machine-creation-services-mcs-limits) on the number of VMs per Azure subscription as you plan for [IP addressing](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity#plan-for-ip-addressing) and your virtual network design.

- **Segmenting by Tenant / Business Unit / Security Zone** – If you are running a multi-tenanted deployment, such as a [Citrix Service Provider architecture](https://docs.citrix.com/en-us/tech-zone/design/reference-architectures/csp-cvads.html), isolating tenants between networks or subnets is a recommended practice. For separate business units or security zones within the same organization, this should be considered if there are specific isolation requirements needed at a network level based on your existing security standards. Segmenting business units outside of workload specific networks should be weighed against the impact of increased complexity on the overall environment. This methodology should be the exception rather than the rule and applied with the right justification and projected scale. For example, creating a network for 1,000 contractors supporting finance to accommodate security needs above and beyond the standard single-session VDI network. [Application security groups](https://docs.microsoft.com/en-us/azure/virtual-network/application-security-groups) can be used to limit access to business unit application backends to specific VMs on a shared virtual network. For example, limiting CRM backend access to the CRM machine catalog VMs used by Marketing in the multi-session VDA network.

## Next steps

Follow Azure networking best practices and Learn how to plan for virtual networks based on your isolation, connectivity, and location requirements.

- [Plan virtual networks](/azure/virtual-network/virtual-network-vnet-plan-design-arm)

Review the critical design considerations and recommendations for management and monitoring specific to the deployment of Citrix on Azure.

- [Management and Monitoring](./ctx-management-and-monitoring.md)
