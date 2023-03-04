---
title: Networking considerations for the Azure Spring Apps landing zone accelerator
description: The Azure Spring Apps landing zone accelerator set is an open-source collection of Terraform templates that you can use to automate the deployment of an environment capable of hosting Azure Spring Apps.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Networking considerations for the Azure Spring Apps landing zone accelerator

This article provides design considerations and recommendations for designing the network in which the  Spring Boot workload is placed. Your target design will depend on the requirements of the workload and the security and compliance requirements of your organization.  

The centralized platform team of the organization selects the [networking topology](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#topology), which could be a traditional hub-spoke model or Virtual WAN network topology (Microsoft-managed). Regardless of that choice, you will need to deploy the workload in the spoke network. Follow these design considerations and recommendations as best practices for subnetting, ingress and egress controls. 

## Design considerations

 - **Isolation**. The central team can provide a virtual network for the application team to run their workloads. If the Spring Boot workload has separation of concerns from other workloads, consider provisioning your own virtual network for the Spring App service runtime and the application.
 
 - **Subnetting**.  Consider the scalability of the application when deciding the size of the subnet and number of applications.

    If you are planning to use existing subnets or decide to bring your own route tables, have policies in place to make sure that rules added by Azure Spring Apps aren't updated or deleted.

 - **Egress (outbound) traffic**. Traffic going from the virtual network must be routed through Azure Firewall or network virtual appliance (NVA). 

    Consider the limitations of the built-in load balancer provided by Azure Spring Apps. Based on your requirements, you might need to customize egress paths by using User Defined Routing (UDR), for instance to route all traffic through an NVA. 

- **Ingress (inbound) traffic**. Consider using a reverse proxy for traffic going to Azure Spring Apps. Based on your requirements, choose native options such as Azure Application Gateway, Front Door, regional services such as API Management (APIM). If those options don't meet your the needs of the workload, non-Azure services can be considered.    

## Design recommendations

- Azure Spring Apps requires two dedicated subnets. One subnet has the service runtime and the other for the application(s).