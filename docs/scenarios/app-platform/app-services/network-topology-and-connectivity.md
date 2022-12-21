---
title: Enterprise-scale network topology and connectivity considerations for Azure App Service
description: Learn about design considerations and recommendations for network topology and connectivity in the Azure App Service landing zone accelerator
author: martinekuan
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Network topology and connectivity considerations for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for network topology and connectivity when using the Azure App Service landing zone accelerator. Networking is central to almost everything inside a landing zone.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Networking requirements
- Use cases
- Exposed to internal users, external users, or both
- App Service Plan tier required to support networking requirements
- Access Restrictions

### Multi-tenanted

- App Services in the multi-tenanted service share a single inbound and multiple outbound IP addresses with other App Services in the same deployment unit.  These IP addresses can change for a [variety of reasons](/azure/app-service/overview-inbound-outbound-ips#how-ip-addresses-work-in-app-service). If consistent outbound IP addresses are needed for multi-tenant App Service, a [NAT gateway](/azure/app-service/networking/nat-gateway-integration#:~:text=%20Set%20up%20NAT%20gateway%20through%20the%20portal%3A,Basics%20information%20and%20pick%20the%20region...%20More%20) can be configured, or [VNet Integration](/azure/app-service/web-sites-integrate-with-vnet) can be used.
- If a dedicated IP address is required by which to address your App Service, you can make use of [App-assigned addresses](/azure/app-service/networking/app-gateway-with-service-endpoints), or you could front your App Service with an [Application Gateway](/azure/app-service/networking/app-gateway-with-service-endpoints) (which is assigned a static IP address).
- When there's a need to connect from an App Service to on-prem, private, or IP-restricted services, consider that:
  - When running in the multi-tenanted environment, the App Service call can originate from a wide range of IP addresses, and [VNet Integration](/azure/app-service/web-sites-integrate-with-vnet) may be needed.
  - Services like [API Management (APIM)](/azure/api-management/api-management-key-concepts) could be used to proxy calls between networking boundaries and can provide a static IP if needed.
- App Services in the multi-tenanted environment can be deployed with a private or a public endpoint.  When deployed with a [Private Endpoint](/azure/app-service/networking/private-endpoint), public exposure of the App Service is eliminated.  If there's a requirement for the private endpoint of the App Service to also be reachable via the Internet, consider the use of App Gateway to expose the app service.
- The multi-tenanted App Service exposes [a set of ports](/azure/app-service/networking-features#app-service-ports), and these can't be changed or blocked.
- Plan your subnets correctly for outbound VNET integration and consider the number of IP addresses that are required. VNet Integration depends on a dedicated subnet. When you provision a subnet, the Azure subnet loses five IPs from the start. One address is used from the integration subnet for each plan instance. When you scale your app to four instances, then four addresses are used. When you scale up or down in size, the required address space is doubled for a short period of time. This affects the real, available supported instances for a given subnet size.

### App Service Environment

- App Services deployed on an ASE gets static, dedicated IP addresses for inbound and outbound communication, for the lifetime of the ASE.
- When there's a need to connect from an App Service to on-prem, private, or IP-restricted services, consider that:
  - When running in an ASE, the App Service is running within the context of a VNet.
  - A service like API Management (APIM) could be used to proxy calls between networking boundaries and can provide a static IP if needed.
- Consider whether your app services on an ASE need to be exposed externally or if they only need to be exposed on the private network.
- The size of the subnet you select when deploying an ASE can't be changed later, so be sure to consider your maximum scale needs.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of Azure App Service.

- Connecting to an App Service:
  - Ensure you have a [Web Application Firewall](/azure/web-application-firewall/overview) (WAF) implemented in front of your App Service, using [Azure Front Door](/azure/web-application-firewall/afds/afds-overview), [Azure Application Gateway](/azure/web-application-firewall/ag/ag-overview), or a third-party service, to provide OWASP-based protection. You can use either Front Door or App Gateway for a single region, or both if you're doing multi-region. If you need path routing within the region, you would need App Gateway, and if you need multi-region load balancing and WAF, you would need Front Door.
  - Employ the appropriate use of access restrictions so that the app service is only reachable from valid locations. For example, if the app service is hosting APIs, and is fronted by APIM, set up an access restriction so that the app service is only accessible from APIM.
- Connecting from an App Service:
  - Where private connectivity to other Azure services is required, use [Private Link](/azure/private-link/private-link-overview) if [supported by those services](/azure/private-link/availability).
- Use the [built-in tools](https://azure.github.io/AppService/2021/04/13/Network-and-Connectivity-Troubleshooting-Tool.html) for troubleshooting any networking issues
- Avoid [SNAT port exhaustion](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors) by utilizing connection pools.  The creation of new connections repetitively to the same host and port can cause slow response times, intermittent 5xx errors, timeouts, or external endpoint connection issues.
- Review and follow the recommendations outlined in the [Network Security section](/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#network-security) of the Azure security baseline for App Service.

## Additional considerations

### Multi-tenanted

- If you need a dedicated outbound Public IP address when connecting to a multi-tenanted App Service, use a [NAT Gateway](/azure/app-service/networking/nat-gateway-integration).
- Since subnet size can't be changed after assignment, use a subnet that's large enough to accommodate whatever scale your app might reach. To avoid any issues with subnet capacity, you should use a /26 with 64 addresses for Vnet integration.

### App Service Environment

- Your subnet should be sized with a /24 CIDR range, providing 256 addresses.
