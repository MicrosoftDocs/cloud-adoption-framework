---
title: Network topology and connectivity for the Azure Spring Apps landing zone accelerator
description: Learn about the network topology and connectivity for a Spring Boot workload. Learn the best practices for subnetting, ingress, and egress controls.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
--

# Network topology and connectivity for the Azure Spring Apps landing zone accelerator

This article describes design considerations and recommendations for the network where the Spring Boot workload is placed. Your target design depends on the requirements of the workload and the security and compliance requirements of your organization.  

The centralized platform team and the application team share the responsibility of the networking design area. The platform team selects the [networking topology](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#topology), which can be a traditional hub-spoke model or Virtual WAN network topology (Microsoft-managed). The application team is responsible for the design choices of the spoke network. The workload is expected to have dependencies on shared services that the platform manages. The application team must understand the implications of those dependencies and communicate their requirements so the overall goals of the workload are met.

For more information about the platform design, see [Network topology and connectivity](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

Follow these design considerations and recommendations as best practices for subnetting, ingress, and egress controls.

## Design considerations

- **Isolation**. The central team can provide a virtual network for the application team to run their workloads. If the Spring Boot workload has a separation of concerns from other workloads, consider provisioning your own virtual network for the Spring App service runtime and the application.

- **Subnetting**.  Consider the scalability of the application when you choose the size of the subnet and the number of applications.

    If you use existing subnets or bring your own route tables, have policies in place to ensure that rules added by Azure Spring Apps aren't updated or deleted.

    Another aspect is security. Consider rules that allow or deny traffic into the subnet.

- **Egress (outbound) traffic**. Traffic that goes from the virtual network must be routed through Azure Firewall or network virtual appliance (NVA).

    Consider the limitations of the built-in load balancer provided by Azure Spring Apps. Based on your requirements, you might need to customize egress paths by using user-defined routing (UDR), for instance to route all traffic through an NVA.

- **Ingress (inbound) traffic**. Consider using a reverse proxy for traffic going to Azure Spring Apps. Based on your requirements, choose native options, such as Azure Application Gateway, and Front Door, or regional services, such as API Management (APIM). If those options don't meet the needs of the workload, non-Azure services can be considered.

## Design recommendations

These recommendations provide prescriptive guidance for the preceding set of considerations.

### Virtual network and subnets

- Azure Spring Apps requires owner permission to your virtual network. This role is required to grant a dedicated and dynamic service principal for deployment and maintenance. For more information, see [Deploy Azure Spring Apps in a virtual network](/azure/spring-apps/how-to-deploy-in-azure-virtual-network).

- Azure Spring Apps deployed in a private network provides a fully qualified domain name (FQDN) that's accessible only within the private network. Create an Azure private DNS zone for the IP address of your Spring app. Link the private DNS to your virtual network by assigning a private FQDN within Azure Spring Apps. For step-by-step instructions, see [Access your application in a private network](/azure/spring-apps/access-app-virtual-network).

- Azure Spring Apps requires two dedicated subnets. One subnet has the service runtime, and the other subnet is for the Spring Boot applications.

    The minimum CIDR block size of each of these subnets is /28. The runtime subnet and the application subnet need a minimum address space of /28. But the number of Spring apps that you can deploy influence the size of the subnet. For information about the maximum app instances by subnet range, see [Using smaller subnet ranges](/azure/spring-apps/how-to-deploy-in-azure-virtual-network?tabs=azure-portal#using-smaller-subnet-ranges).

- If you use Azure Application Gateway as the reverse proxy in front of Azure Spring Apps, you need another subnet for that instance. For more information, see [Using Application Gateway as the reverse proxy](/azure/architecture/reference-architectures/microservices/spring-cloud-reverse-proxy#scenario-1-using-application-gateway-as-the-reverse-proxy).

- Use Network Security Groups (NSGs) on subnets to filter east-west traffic to restrict traffic to your service runtime subnet.

- Resource groups and subnets that Azure Spring Apps deployment manages must not be modified.

### Egress traffic

- By default, Azure Spring Apps has unrestricted outbound internet access. Use an NVA such as Azure Firewall to filter north-south traffic. Take advantage of Azure Firewall in the centralized hub network to reduce the management overhead.

    > [!NOTE]
    >Egress traffic to Azure Spring components is required to support the service instances. For information about specific endpoints and ports, see [Azure Spring Apps network requirements](/azure/spring-apps/vnet-customer-responsibilities#azure-spring-apps-network-requirements).

- Azure Spring Apps provide a user-defined route (UDR) outbound type to fully control the egress traffic path. `OutboundType` should be defined when a new Azure Spring Apps service instance is created. It can't be updated afterwards. `OutboundType` can be configured only with a virtual network. For more information, see [Customize Azure Spring Apps egress with a user-defined route](/azure/spring-apps/concept-outbound-type).

- The application needs to communicate with other Azure services in the solution. Use Azure Private Link for supported services if your applications require private connectivity.

### Ingress traffic

- Use a reverse proxy to ensure that malicious users are prevented from bypassing the web application firewall (WAF) or circumventing throttling limits. Azure Application Gateway with integrated WAF is recommended.

    If you're using the Enterprise tier, use the assigned endpoint of the Spring Cloud Gateway app as the back-end pool of the Application Gateway. This endpoint resolves to a private IP address in the Azure Spring Apps service runtime subnet.

    Add an NSG on the service runtime subnet that allows traffic only from the Application Gateway subnet, Azure Spring Apps subnet, and Azure Load Balancer.

    > [!NOTE]
    > You can choose an alternative for the reverse proxy, such as Azure Front Door or non-Azure services. For information about configuration options, see [Expose Azure Spring Apps through a reverse proxy](/azure/architecture/reference-architectures/microservices/spring-cloud-reverse-proxy).

- Azure Spring Apps can be deployed in a virtual network through VNet injection or outside the network. For more information, see [Configuration summary](/azure/architecture/reference-architectures/microservices/spring-cloud-reverse-proxy#configuration-summary).

## Next steps

[Security considerations for the Azure Spring Apps landing zone accelerator](./security.md)
