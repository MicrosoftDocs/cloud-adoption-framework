---
title: Networking considerations for the Azure Spring Apps landing zone accelerator
description: Networking considerations and recommendations for a Spring Boot workload.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Networking considerations for the Azure Spring Apps landing zone accelerator

This article provides design considerations and recommendations for the network in which the Spring Boot workload is placed. Your target design will depend on the requirements of the workload and the security and compliance requirements of your organization.  

The networking design area is shared responsibility between the centralized platform team and the application team of an organization. The platform team selects the [networking topology](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#topology), which could be a traditional hub-spoke model or Virtual WAN network topology (Microsoft-managed). The application team is responsible for the design choices of the spoke network. The workload is expected to have dependencies on shared services managed by the platform. The application team must understand the implications of those dependencies and communicate their requirements so that the overall goals of the workload are met. 

> For information about the platform design, see [Platform design: Network topology and connectivity](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity).

Follow these design considerations and recommendations as best practices for subnetting, ingress, and egress controls. 

## Design considerations

 - **Isolation**. The central team can provide a virtual network for the application team to run their workloads. If the Spring Boot workload has separation of concerns from other workloads, consider provisioning your own virtual network for the Spring App service runtime and the application.
 
 - **Subnetting**.  Consider the scalability of the application when deciding the size of the subnet and number of applications.

    If you're planning to use existing subnets or decide to bring your own route tables, have policies in place to make sure that rules added by Azure Spring Apps aren't updated or deleted.

    Another aspect is security. Consider rules that will allow or deny traffic into the subnet.

 - **Egress (outbound) traffic**. Traffic going from the virtual network must be routed through Azure Firewall or network virtual appliance (NVA). 

    Consider the limitations of the built-in load balancer provided by Azure Spring Apps. Based on your requirements, you might need to customize egress paths by using User Defined Routing (UDR), for instance to route all traffic through an NVA. 

- **Ingress (inbound) traffic**. Consider using a reverse proxy for traffic going to Azure Spring Apps. Based on your requirements, choose native options such as Azure Application Gateway, Front Door, regional services such as API Management (APIM). If those options don't meet the needs of the workload, non-Azure services can be considered.    

## Design recommendations

These recommendations provide prescriptive guidance for the preceding set of recommendations.

##### Virtual network and subnets

- Azure Spring Apps requires `Owner` permission to your virtual network. This role is required to grant a dedicated and dynamic service principal for deployment and maintenance. For more information, see [Deploy Azure Spring Apps in a virtual network](/azure/spring-apps/how-to-deploy-in-azure-virtual-network).

- Azure Spring Apps deployed in a private network provides a fully qualified domain name (FQDN) that's accessible only within the private network. Create an Azure Private DNS Zone for the IP address of your spring app, linking the private DNS to your virtual network and finally by assigning a private FQDN within Azure Spring Apps. For step-by-step instructions, see Refer [Access your application in a private network](/azure/spring-apps/access-app-virtual-network).


- Azure Spring Apps requires two dedicated subnets. One subnet has the service runtime and the other for the Spring Boot applications.

    The minimum CIDR block size of each of these subnets is /28. The runtime subnet needs a  minimum address space of /28. The application subnet also needs a minimum address space of /28. However, the number of spring apps that you can deploy will influence the size of that subnet. For information about the maximum app instances by subnet range, see [Using smaller subnet ranges](/azure/spring-apps/how-to-deploy-in-azure-virtual-network?tabs=azure-portal#using-smaller-subnet-ranges).

- If you use Azure Application Gateway as the reverse proxy in front of Azure Spring Apps, you'll need another subnet for that instance. For information, see [Using Application Gateway as the reverse proxy](/azure/architecture/reference-architectures/microservices/spring-cloud-reverse-proxy#scenario-1-using-application-gateway-as-the-reverse-proxy).

- Use Network Security Groups (NSGs) on subnets to filter east-west traffic, that is,  restricting traffic to your service runtime subnet. 

- Resource Groups and subnets managed by Azure Spring Apps deployment must not be modified.

##### Egress traffic

- By default, Azure Spring Apps has unrestricted outbound internet access. Use an NVA such as Azure Firewall to filter north-south traffic. Take advantage of Azure Firewall in the centralized hub network to reduce the management overhead. 

    > [!NOTE]
    >Egress traffic to Azure Spring components is required to support the service instances. For information about specific endpoints and ports, see [Azure Spring Apps network requirements](/azure/spring-apps/vnet-customer-responsibilities#azure-spring-apps-network-requirements)

- Azure Spring Apps provide a User Defined Route (UDR) Outbound Type to fully control egress traffic path. OutboundType should be defined when a new Azure Spring Apps service instance is created. It can't be updated afterwards. Also, OutboundType can be configured only with a virtual network. For more information, see [Customize Azure Spring Apps egress with a user-defined route](/azure/spring-apps/concept-outbound-type).

- The application will need to communicate with other Azure services in the solution. It's  recommended that you use Azure Private Link for supported services if private connectivity is required by your applications.


##### Ingress traffic
 
- Use a reverse proxy to ensure that malicious users are prevented from trying to bypass the web application firewall (WAF) or circumvent throttling limits. Azure Application Gateway with integrated WAF is recommended.

    If you're using the Enterprise tier, use the assigned endpoint of the Spring Cloud Gateway app as the back-end pool of the Application Gateway. This endpoint resolves to a private IP address in the Azure Spring Apps Service Runtime subnet.

    Add an NSG on the Service Runtime subnet that allows traffic only from the Application Gateway subnet, Spring Apps subnet and Azure Load Balancer.
 
    > [!NOTE]
    > You can choose an alternative for the reverse proxy are such as Azure Front Door or non-Azure services. For information about configuration options, see [Expose Azure Spring Apps through a reverse proxy](/azure/architecture/reference-architectures/microservices/spring-cloud-reverse-proxy).

- Azure Spring Apps can be deployed in a virtual network (through VNet injection) or outside the network. For additional considerations, see [Configuration summary](/azure/architecture/reference-architectures/microservices/spring-cloud-reverse-proxy#configuration-summary).

## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"] 
> [Security](./security.md)
