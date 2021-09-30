---
title: Connectivity to Azure PaaS services
description: Examine key design considerations and recommendations surrounding connectivity to Azure platform as a service technologies.
author: JefferyMitchell
ms.author: brblanch
ms.date: 07/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Connectivity to Azure PaaS services

Building on the previous connectivity sections, this section explores recommended connectivity approaches for using Azure PaaS services.

**Design considerations:**

- Azure PaaS services are typically accessed over public endpoints. However, the Azure platform provides capabilities to secure such endpoints or even make them entirely private:

  - Virtual network injection provides dedicated private deployments for supported services. Management plane traffic still flows through public IP addresses.

  - [Azure Private Link](/azure/private-link/private-endpoint-overview#private-link-resource) provides dedicated access by using private IP addresses to Azure PaaS instances or custom services behind Azure Load Balancer Standard tier. For more information, see [key benefits of Private Link](/azure/private-link/private-link-overview#key-benefits).

  - [Virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) provide service-level access from selected subnets to selected PaaS services. Review the list of supported services on the link provided.

  - [What is the difference between Service Endpoints and Private Endpoints?](/azure/private-link/private-link-faq#what-is-the-difference-between-service-endpoints-and-private-endpoints-) provides an explanation of the differences between Private Link Endpoints and VNet Service Endpoints.

- Enterprises often have concerns about public endpoints for PaaS services that must be appropriately mitigated.

- For [supported services](/azure/private-link/private-link-overview#availability), Private Link addresses data exfiltration concerns associated with VNet service endpoints. As an alternative, you can use outbound filtering via network virtual appliances (NVAs) to provide steps to mitigate data exfiltration.

**Design recommendations:**

- Use virtual network injection for supported Azure services to make them available from within your virtual network.

- Azure PaaS services that have been injected into a virtual network still perform management plane operations by using public IP addresses. Ensure that this communication is locked down within the virtual network by using UDRs and NSGs.

- Use Private Link, [where available](/azure/private-link/private-link-overview#availability), for shared Azure PaaS services. Private Link is generally available for several services and is in public preview for other services.

- Access Azure PaaS services from on-premises via [ExpressRoute with Private peering](/azure/expressroute/expressroute-circuit-peerings#privatepeering). Use either virtual network injection for dedicated Azure services or Azure Private Link for available shared Azure services. To access Azure PaaS services from on-premises when virtual network injection or Private Link isn't available, use [ExpressRoute with Microsoft peering](/azure/expressroute/expressroute-circuit-peerings#microsoftpeering). This method avoids transiting over the public internet.

  - Accessing Azure PaaS Services from on-premises via ExpressRoute with Microsoft Peering does not prevent access to the public endpoints of the PaaS service. This must be configured and restricted as required separately.

- Use virtual network service endpoints to secure access to Azure PaaS services from within your virtual network, but only when Private Link isn't available and there are no data exfiltration concerns. To address data exfiltration concerns with service endpoints, use NVA filtering or use virtual network service endpoint policies for Azure Storage.

- Don't enable virtual network service endpoints by default on all subnets.

- Don't use virtual network service endpoints when there are data exfiltration concerns, unless you use NVA filtering.

- We don't recommend that you implement forced tunneling to enable communication from Azure to Azure resources.
