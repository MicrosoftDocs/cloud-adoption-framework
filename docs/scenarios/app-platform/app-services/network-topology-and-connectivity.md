---
title: Network topology and connectivity considerations for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for network topology and connectivity in the Azure App Service landing zone accelerator.
author: motasem13
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

When you deploy an App Service solution on Azure, you need to carefully consider networking requirements to ensure that your application functions properly. There are several key factors to consider when you plan a deployment:

- Determine the networking requirements for your application.
    - **Incoming traffic.** If your app provides web-based services such as a website or API, it probably needs to be able to receive incoming traffic from the internet. To ensure that your app can accept incoming connections, you need to configure it to listen on the appropriate ports.
    - **Access to other Azure resources.** Your app might need to be able to access resources on Azure, like storage accounts or databases, by using its private endpoint. These resources might be located within an Azure virtual network or other Azure services.
    - **SSL/TLS.** To help secure the communication between your app and its users, you need to enable SSL/TLS encryption. Doing so ensures that traffic between your app and its users is encrypted, which helps to protect sensitive information from being intercepted by third parties.
    - **IP restrictions.** Depending on your requirements, you might need to allow or block access to your app from specific IP addresses or ranges. Doing so can provide improved security and limit access to your app to specific users or locations.
    
- Choose an App Service plan tier. Use the networking requirements of your application to determine the appropriate tier for your App Service plan. It's a good idea to review the various App Service plan tiers and their features to determine which one is best suited to your needs.

### App Service multi-tenant service

- An App Service multi-tenant solution shares a single inbound IP address and multiple outbound IP addresses with other App Service resources in a single deployment unit.  These IP addresses can change for a [variety of reasons](/azure/app-service/overview-inbound-outbound-ips#how-ip-addresses-work-in-app-service). If you need consistent outbound IP addresses for a multi-tenant App Service solution, you can configure a [NAT gateway](/azure/app-service/networking/nat-gateway-integration) or use [virtual network integration](/azure/app-service/overview-vnet-integration).
- If you need a dedicated IP address for your App Service solution, you can use an [app-assigned address](/azure/app-service/networking-features#app-assigned-address), front your App Service instance with an [application gateway](/azure/app-service/networking/app-gateway-with-service-endpoints) (which is assigned a static IP address), or use an IP-based SSL certificate to assign a dedicated IP address to your app via the App Service platform.

- When you need to connect from an App Service solution to on-premises, private, or IP-restricted services, consider that:
  - In a multi-tenant App Service deployment, an App Service call can originate from a wide range of IP addresses. You might need [virtual network integration](/azure/app-service/overview-vnet-integration).
  - You can use services like [API Management](/azure/api-management/api-management-key-concepts) and Application Gateway to proxy calls between networking boundaries. These services can provide a static IP address if you need one.
- You can use a private or a public endpoint for a multi-tenant App Service deployment. When you use a [private endpoint](/azure/app-service/networking/private-endpoint), public exposure to the App Service solution is eliminated. If you need the private endpoint of the App Service solution to be accessible via the internet, consider using Application Gateway to expose the App Service solution.
- A multi-tenant App Service deployment exposes [a set of ports](/azure/app-service/networking-features#app-service-ports). There's no way to block or control access to these ports in a multi-tenant App Service deployment.
- Plan your subnets correctly for outbound virtual network integration and consider the number of IP addresses that are required. Virtual network integration depends on a dedicated subnet. When you provision an Azure subnet, Azure reserves five IPs. One IP address is used from the integration subnet for each App Service plan instance. When you scale your app to four instances, for example, four IP addresses are used. When you scale up or down, the required address space is doubled for a short time. This affects the available supported instances for a given subnet size.
- Because you can't change the size of a subnet after assignment, you need to use a subnet that's large enough to accommodate the scale that your app might reach. To avoid any issues with subnet capacity, use a /26 with 64 addresses for virtual network integration.
- If you're connecting to a multi-tenant App Service solution and you need a dedicated outbound address, use a [NAT gateway](/azure/app-service/networking/nat-gateway-integration).

### App Service Environment (single-tenant)

- Decide on an App Service Environment network design: external or internal load balancer. Use an external deployment when you need direct access from the internet. Use an internal load balancer deployment to expose access only from within the virtual network where the App Service Environment is deployed. The latter deployment provides another level of security and control over network access to the apps.
- App Services in an App Service Environment gets static, dedicated IP addresses for inbound and outbound communication, for the lifetime of the App Service Environment.
- When you need to connect from an App Service Environment to on-premises, private, or IP-restricted services, the App Service Environment runs within the context of a virtual network.
- You choose the size of the subnet when you deploy an App Service Environment. You can't change the size at a later time. We recommend a size of /24, which has 256 addresses and can handle a maximum-sized App Service Environment and any scaling needs.

## Design recommendations

The following best practices apply to any deployment of App Service.

- Connecting to an App Service solution:
  - Implement an Azure [web application firewall](/azure/web-application-firewall/overview) in front of your App Service solution. Use [Azure Front Door](/azure/web-application-firewall/afds/afds-overview), [Application Gateway](/azure/web-application-firewall/ag/ag-overview), or a partner service to provide this OWASP-based protection. You can use either Azure Front Door or Application Gateway for a single region, or both for multiple regions. If you need path routing in the region, use Application Gateway. If you need multi-region load balancing and Web Application Firewall, use Azure Front Door.
  - By using a private endpoint for App Service, you can access the app over a private, network-based endpoint rather than a public, internet-based endpoint. When you use a private endpoint, you can restrict access to the app to only users in your virtual network, which provides another layer of security for your app, reduced data egress costs, and improved performance.
  - Use access restrictions to ensure that the App Service solution can be reached only from valid locations. For example, if a multi-tenant App Service deployment is hosting APIs and is fronted by API Management, set up an access restriction so that the App Service solution can be accessed only from API Management.
- Connecting from an App Service solution:
  - Where you need private connectivity to other Azure services, use [Azure Private Link](/azure/private-link/private-link-overview) if it's [supported by the services](/azure/private-link/availability).
- Use the [built-in tools](https://azure.github.io/AppService/2021/04/13/Network-and-Connectivity-Troubleshooting-Tool.html) to troubleshoot networking problems.
- Avoid [SNAT port exhaustion](/azure/app-service/troubleshoot-intermittent-outbound-connection-errors) by using connection pools. Repeatedly creating connections to the same host and port can cause slow response times, intermittent 5xx errors, timeouts, or external endpoint connection problems.
- Follow the recommendations outlined in the [Network security section](/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#network-security) of the Azure security baseline for App Service.

The goal of network topology and connectivity considerations for the App Service landing zone accelerator is to provide a high-level blueprint for implementing a scalable and resilient environment for deploying App Services. This blueprint, focusing on network architecture and connectivity, can help you quickly and efficiently set up a landing zone in Azure to host App Services solutions. 
