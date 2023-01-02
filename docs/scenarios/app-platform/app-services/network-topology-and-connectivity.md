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

The network topology and connectivity considerations for this architecture will depend on the specific requirements of the workloads being hosted, as well as the security and compliance requirements of the organization.


## Design considerations

Deploying an App Service in Azure requires careful consideration of networking requirements to ensure that your application is able to function properly. There are several key factors to consider when planning for a deployment:

- Decide on The Networking requirements of your application:
    - Incoming traffic: If your app provides web-based services such as a website or API, it will likely need to be able to receive incoming traffic from the internet. To ensure that your app is able to accept incoming connections, you will need to configure it to listen on the appropriate ports.
    - Access to other Azure resources: Your app may need to be able to access resources within Azure, such as storage accounts or databases, using its private endpoint. These resources may be located within an Azure Virtual Network or other Azure services.
    - SSL/TLS: To secure the communication between your app and its users, it is important to enable SSL/TLS encryption. This will ensure that all traffic between your app and its users is encrypted, protecting sensitive information from being intercepted by third parties.
    - IP restrictions: Depending on your requirements, you may need to allow or block access to your app from specific IP addresses or ranges. This can be useful for security purposes or to limit access to your app to specific users or locations.
    
- App Service Plan tier: The tier of your App Service Plan should be chosen based on the networking requirements of your application. It is a good idea to review the different App Service Plan tiers and their features in order to determine which one will be the most suitable for your needs.

### Multi-Tenant App Service

- Multi-Tenant App Service shares a single inbound IP Address and multiple outbound IP addresses with other App Service resources in the same deployment unit.  These IP addresses can change for a [variety of reasons](/azure/app-service/overview-inbound-outbound-ips#how-ip-addresses-work-in-app-service). If consistent outbound IP addresses are needed for multi-tenant App Service, a [NAT gateway](/azure/app-service/networking/nat-gateway-integration#:~:text=%20Set%20up%20NAT%20gateway%20through%20the%20portal%3A,Basics%20information%20and%20pick%20the%20region...%20More%20) can be configured, or [VNet Integration](/azure/app-service/overview-vnet-integration) can be used.
- If a dedicated IP address is required by which to address your App Service, you can make use of [App-assigned addresses](/azure/app-service/networking/app-gateway-with-service-endpoints), or you could front your App Service with an [Application Gateway](/azure/app-service/networking/app-gateway-with-service-endpoints) (which is assigned a static IP address), or you can use IP-based SSL certificate to get a dedicated IP address assigned to your app by the app service platform.

- When there's a need to connect from an App Service to on-prem, private, or IP-restricted services, consider that:
  - When running in a Multi-Tenant App Service environment, the App Service call can originate from a wide range of IP addresses, and [VNet Integration](/azure/app-service/overview-vnet-integration) may be needed.
  - Services like [API Management (APIM)](/azure/api-management/api-management-key-concepts) an Application Gateway could be used to proxy calls between networking boundaries and can provide a static IP if needed.
- Multi-Tenant App Service environment can be deployed with a private or a public endpoint.  When deployed with a [Private Endpoint](/azure/app-service/networking/private-endpoint), public exposure of the App Service is eliminated.  If there's a requirement for the private endpoint of the App Service to also be reachable via the Internet, consider the use of App Gateway to expose the app service.
- Multi-Tenant App Service exposes [a set of ports](/azure/app-service/networking-features#app-service-ports). There's no way to block or control access to these ports in the Multi-Tenant App Service.
- Plan your subnets correctly for outbound VNet integration and consider the number of IP addresses that are required. VNet Integration depends on a dedicated subnet. When you provision a subnet, the Azure subnet loses five IPs from the start. One IP address is used from the integration subnet for each App Service Plan instance. When you scale your app to X number instances, then X number of IP addresses are used. When you scale up or down in size, the required address space is doubled for a short period of time. This affects the real, available supported instances for a given subnet size.
- Since subnet size can't be changed after assignment, use a subnet that's large enough to accommodate whatever scale your app might reach. To avoid any issues with subnet capacity, you should use a /26 with 64 addresses for Vnet integration.
- If you need a dedicated outbound address when connecting to a multi-tenanted App Service, use a [NAT Gateway](/azure/app-service/networking/nat-gateway-integration).

### App Service Environment (Single-Tenant)

- Decide on the ASE network design, App Service Environment internal load balancer or External mode, whether it requires a direct access from the internet or accessible only from within the virtual network where the ASE is deployed, providing an additional level of security and control over network access to the apps
- App Services deployed on an ASE gets static, dedicated IP addresses for inbound and outbound communication, for the lifetime of the ASE.
- When there's a need to connect from an App Service Environment to on-prem, private, or IP-restricted services, the App Service Environment is running within the context of a Virtual Network
- The size of the subnet you select when deploying an ASE can't be changed later, We recommend a size of /24, which has 256 addresses and can handle a maximum-sized ASE and any scaling needs.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of Azure App Service.

- Connecting to an App Service:
  - Ensure you have a [Web Application Firewall](/azure/web-application-firewall/overview) (WAF) implemented in front of your App Service, using [Azure Front Door](/azure/web-application-firewall/afds/afds-overview), [Azure Application Gateway](/azure/web-application-firewall/ag/ag-overview), or a third-party service, to provide OWASP-based protection. You can use either Front Door or App Gateway for a single region, or both if you're doing multi-region. If you need path routing within the region, you would need App Gateway, and if you need multi-region load balancing and WAF, you would need Front Door.
  - Utilize a private endpoint for an Azure App Service enables you to access the app over a private, network-based endpoint rather than using a public, internet-based endpoint, by using a private endpoint, you can restrict access to the app to only those within your virtual network, providing an additional layer of security for your app, reduced data egress costs and improved performance
  - Employ the appropriate use of access restrictions so that the app service is only reachable from valid locations. For example, if the Multi-Tenant App Service is hosting APIs, and is fronted by APIM, set up an access restriction so that the app service is only accessible from APIM.
- Connecting from an App Service:
  - Where private connectivity to other Azure services is required, use [Private Link](/azure/private-link/private-link-overview) if [supported by those services](/azure/private-link/availability).
- Use the [built-in tools](https://azure.github.io/AppService/2021/04/13/Network-and-Connectivity-Troubleshooting-Tool.html) for troubleshooting any networking issues
- Avoid [SNAT port exhaustion](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors) by utilizing connection pools.  The creation of new connections repetitively to the same host and port can cause slow response times, intermittent 5xx errors, timeouts, or external endpoint connection issues.
- Review and follow the recommendations outlined in the [Network Security section](/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#network-security) of the Azure security baseline for App Service.

Overall, the goal of network topology and connectivity considerations for the Azure App Service landing zone accelerator is to provide a high-level blueprint for implementing a secure, scalable, and resilient environment for deploying Azure App Services. This blueprint helps organizations to quickly and efficiently set up a landing zone in Azure for hosting their App Services, with a focus on network architecture and connectivity. 
