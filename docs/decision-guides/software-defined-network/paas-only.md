---
title: "Software Defined Networking: PaaS-only"
description: Learn about the advantages and limitations of a PaaS-only architectural model in Software Defined Networking in the cloud.
author: alexbuckgit
ms.author: abuck
ms.date: 02/11/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: internal
---

# Software Defined Networking: PaaS-only

When you implement a platform as a service (PaaS) resource, the deployment process automatically creates an assumed underlying network with a limited number of controls over that network, including load balancing, port blocking, and connections to other PaaS services.

In Azure, several PaaS resource types can be [deployed into a virtual network](/azure/virtual-network/virtual-network-for-azure-services) or [connected to a virtual network](/azure/virtual-network/virtual-network-service-endpoints-overview), integrating these resources with your existing virtual networking infrastructure. Other services, such as [App Service Environment](/azure/app-service/environment/intro), [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes), and [Service Fabric](/azure/service-fabric/service-fabric-overview) must be deployed within a virtual network. In many cases, a PaaS-only networking architecture, relying solely on the default native networking capabilities provided by PaaS resources, is sufficient to meet a workload's connectivity and traffic management requirements.

If you're considering a PaaS only networking architecture, be sure you validate that the required assumptions align with your requirements.

## PaaS-only assumptions

Deploying a PaaS-only networking architecture assumes the following:

- The application being deployed is a standalone application or depends only on other PaaS resources that do not require a virtual network.
- Your IT operations teams can update their tools, training, and processes to support management, configuration, and deployment of standalone PaaS applications.
- The PaaS application is not part of a broader cloud migration effort that will include IaaS resources.

These assumptions are minimum qualifiers aligned to deploying a PaaS-only network. While this approach may align with the requirements of a single application deployment, each cloud adoption team should consider these long-term questions:

- Will this deployment expand in scope or scale to require access to other non-PaaS resources?
- Are other PaaS deployments planned beyond the current solution?
- Does the organization have plans for other future cloud migrations?

The answers to these questions would not preclude a team from choosing a PaaS only option but should be considered before making a final decision.
