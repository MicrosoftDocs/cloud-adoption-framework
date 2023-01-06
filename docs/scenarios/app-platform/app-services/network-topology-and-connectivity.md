---
title: Network topology and connectivity considerations for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for network topology and connectivity in the Azure App Service landing zone accelerator.
author: martinekuan
ms.author: martinek
ms.date: 01/05/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Network topology and connectivity considerations for the App Service landing zone accelerator

This article provides design considerations and recommendations for network topology and connectivity that you can apply when you use the Azure App Service landing zone accelerator. Networking is central to almost everything in a landing zone.

The network topology and connectivity considerations for this architecture depend on the requirements of the workloads being hosted and on the security and compliance requirements of your organization.


## Design considerations

When you deploy App Service on Azure, you need to carefully consider networking requirements to ensure that your application functions properly. There are several key factors to consider when you plan a deployment:

- Determine the networking requirements for your application.
    - **Incoming traffic.** If your app provides web-based services such as a website or API, it probably needs to be able to receive incoming traffic from the internet. To ensure that your app is able to accept incoming connections, you need to configure it to listen on the appropriate ports.
    - **Access to other Azure resources.** Your app might need to be able to access resources on Azure, like storage accounts or databases, by using its private endpoint. These resources might be located within an Azure virtual network or other Azure services.
    - **SSL/TLS.** To help secure the communication between your app and its users, you need to enable SSL/TLS encryption. Doing so ensures that traffic between your app and its users is encrypted, which helps to protect sensitive information from being intercepted by third parties.
    - **IP restrictions.** Depending on your requirements, you might need to allow or block access to your app from specific IP addresses or ranges. Doing so can provide a level of security and limit access to your app to specific users or locations.
    
- Choose an App Service plan tier. You should use the networking requirements of your application to determine the appropriate tier for your App Service plan. It's a good idea to review the various App Service Plan tiers and their features to determine which one is best suited to your needs.

### App Service multi-tenant service

- An App Service multi-tenant solution shares a single inbound IP address and multiple outbound IP addresses with other App Service resources in a single deployment unit.  These IP addresses can change for a [variety of reasons](/azure/app-service/overview-inbound-outbound-ips#how-ip-addresses-work-in-app-service). If you need consistent outbound IP addresses for a multi-tenant App Service solution, you can configure a [NAT gateway](/azure/app-service/networking/nat-gateway-integration) or use [virtual network integration](/azure/app-service/overview-vnet-integration).
- If you need a dedicated IP address for your App Service instance, you can use an [app-assigned address](/azure/app-service/networking-features#app-assigned-address), front your App Service instance with an [application gateway](/azure/app-service/networking/app-gateway-with-service-endpoints) (which is assigned a static IP address), or use an IP-based SSL certificate to assign a dedicated IP address to your app via the App Service platform.

- When you need to connect from an App Service instance to on-premises, private, or IP-restricted services, consider that:
  - In a multi-tenant App Service solution, an App Service call can originate from a wide range of IP addresses. You might need [virtual network integration](/azure/app-service/overview-vnet-integration).
  - You can use services like [API Management](/azure/api-management/api-management-key-concepts) and Application Gateway to proxy calls between networking boundaries. These services can provide a static IP address if you need one.
- You can use a private or a public endpoint for a multi-tenant App Service solution. When you use a [private endpoint](/azure/app-service/networking/private-endpoint), public exposure to the App Service instance is eliminated. If you need the private endpoint of the App Service instance to accessible via the internet, consider using Application Gateway to expose the App Service instance.
- A multi-tenant App Service solution exposes [a set of ports](/azure/app-service/networking-features#app-service-ports). There's no way to block or control access to these ports in a multi-tenant App Service deployment.
- Plan your subnets correctly for outbound virtual network integration and consider the number of IP addresses that are required. VNet Integration depends on a dedicated subnet. When you provision a subnet, the Azure subnet loses five IPs from the start. One IP address is used from the integration subnet for each App Service Plan instance. When you scale your app to X number instances, then X number of IP addresses are used. When you scale up or down in size, the required address space is doubled for a short period of time. This affects the real, available supported instances for a given subnet size.
- Since subnet size can't be changed after assignment, use a subnet that's large enough to accommodate whatever scale your app might reach. To avoid any issues with subnet capacity, you should use a /26 with 64 addresses for Vnet integration.
- If you need a dedicated outbound address when connecting to a multi-tenanted App Service, use a [NAT Gateway](/azure/app-service/networking/nat-gateway-integration).

### App Service Environment (single-tenant)

- Decide on the ASE network design, App Service Environment internal load balancer or External mode, whether it requires a direct access from the internet or accessible only from within the virtual network where the ASE is deployed, providing an additional level of security and control over network access to the apps
- App Services deployed on an ASE gets static, dedicated IP addresses for inbound and outbound communication, for the lifetime of the ASE.
- When there's a need to connect from an App Service Environment to on-prem, private, or IP-restricted services, the App Service Environment is running within the context of a Virtual Network
- The size of the subnet you select when deploying an ASE can't be changed later, We recommend a size of /24, which has 256 addresses and can handle a maximum-sized ASE and any scaling needs.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of Azure App Service.

- Connecting to an App Service:
  - Ensure you have a [Web Application Firewall](/azure/web-application-firewall/overview) (WAF) implemented in front of your App Service, using [Azure Front Door](/azure/web-application-firewall/afds/afds-overview), [Azure Application Gateway](/azure/web-application-firewall/ag/ag-overview), or a third-party service, to provide OWASP-based protection. You can use either Front Door or App Gateway for a single region, or both if you're doing multi-region. If you need path routing within the region, you would need App Gateway, and if you need multi-region load balancing and WAF, you would need Front Door.
  - Utilizing a private endpoint for an Azure App Service enables you to access the app over a private, network-based endpoint rather than a public, internet-based endpoint. By using a private endpoint, you can restrict access to the app to only those within your virtual network, providing an additional layer of security for your app, reduced data egress costs and improved performance.
  - Employ the appropriate use of access restrictions so that the app service is only reachable from valid locations. For example, if the Multi-Tenant App Service is hosting APIs, and is fronted by APIM, set up an access restriction so that the app service is only accessible from APIM.
- Connecting from an App Service:
  - Where private connectivity to other Azure services is required, use [Private Link](/azure/private-link/private-link-overview) if [supported by those services](/azure/private-link/availability).
- Use the [built-in tools](https://azure.github.io/AppService/2021/04/13/Network-and-Connectivity-Troubleshooting-Tool.html) for troubleshooting any networking issues
- Avoid [SNAT port exhaustion](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors) by utilizing connection pools.  The creation of new connections repetitively to the same host and port can cause slow response times, intermittent 5xx errors, timeouts, or external endpoint connection issues.
- Review and follow the recommendations outlined in the [Network Security section](/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#network-security) of the Azure security baseline for App Service.

Overall, the goal of network topology and connectivity considerations for the Azure App Service landing zone accelerator is to provide a high-level blueprint for implementing a secure, scalable, and resilient environment for deploying Azure App Services. This blueprint helps organizations to quickly and efficiently set up a landing zone in Azure for hosting their App Services, with a focus on network architecture and connectivity. 
