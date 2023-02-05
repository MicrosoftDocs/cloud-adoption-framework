---
title: Design guidance for Citrix on Azure
description: Learn about the resource organization design area and how to apply it to your Citrix on Azure implementation.
author: bebaur
ms.author: martinek
ms.date: 01/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Resource Organization Considerations for Citrix on Azure

These sections list things you should consider when planning your organization's Citrix landing zone structure.

**Citrix design recommendations**

The following sections offer recommendations for labelling and organizing resources when deploying Citrix on Azure.
Additional design guidance for Citrix DaaS on Microsoft Azure is available on [Citrix TechZone - Design Guidance for Citrix DaaS on Microsoft Azure](https://docs.citrix.com/en-us/tech-zone/toc/by-solution/daas-for-azure/design-guidance.html) and highlights the system, workload, user, and network considerations for Citrix technologies in alignment with Cloud Adoption Framework design principles. 

## Citrix Cloud naming and tagging
	
Naming and tagging standards help you organize resources and simplify resource management, cost tracking, and governance.
Maintain consistency across resources to help you identify any deviation from agreed-upon policies. [Prescriptive guidance for resource tagging](https://learn.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex/prescriptive-guidance#resource-tagging) describes how one of the following patterns is helpful for deploying governance practices. Similar patterns are available for using tags to evaluate regulatory compliance.
	
A standardized naming convention is your starting point for organizing cloud-hosted resources. Properly structured naming systems allow rapid resource identification for both management and accounting purposes. If you follow existing IT naming conventions in other parts of your organization, consider whether to align your cloud naming conventions with them or make your cloud naming conventions unique and separate.
	
Azure naming schemes should align with the associated resources in Citrix Cloud. For example, when using multiple subscriptions for a Citrix deployment, leverage naming schemes for [machine catalogs in Citrix Cloud](https://docs.citrix.com/en-us/citrix-daas/install-configure/machine-catalogs-manage.html) that identify the subscription they are associated with. An example would be something like **MC-USEast2Sub01-Win10-HR** and **MC-USEast2Sub02-Win10-HR** to represent Windows 10 VDI deployed for HR across two subscriptions in US East2. Multiple catalogs across multiple subscriptions or regions can be aggregated into a [Delivery Group](https://docs.citrix.com/en-us/citrix-daas/install-configure/delivery-groups-manage.html) to facilitate management of these disparate resources for a use case. In this example, the highlighted catalogues could then be aggregated into **DG-USEast2-Win10-HR**.

**Management groups and subscriptions**

An Azure subscription is a logical limit of scale by which resources can be allocated. These limits include [thresholds for numerous resource types](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits) and throttling limits based on reads and writes made against Azure. Subscription requests, such as virtual machine power management, [drive the recommended of Citrix machines per Microsoft Azure subscription](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/limits.html#machine-creation-services-mcs-limits). For this reason, it is recommended to use a dedicated subscription or subscriptions for the Citrix landing zone. 
Deciding between a single or multiple subscription architecture is often based off the following design areas:

Deciding between a single or multiple subscription architecture is often based off the following design areas:
-	**Scale** – What percentage of your organization will have workloads on Azure? Will long term usage exceed 5000 virtual machines?
-	**Use Cases** – Are your use cases known? If so, are your target use cases predominately virtualized applications or multi-session desktops? Is VDI considered more niche (<5-10% of total user count)?
-	**Operations** – Do you have a clear line of ownership between teams managing Server and Client Operating Systems? Do these teams also have separate cost centers? Is there a shared change control or user onboarding process?

In a multiple subscription architecture, management components should be deployed in a “Citrix Shared Services” subscription with the virtual apps and desktops contained in “Workload” subscriptions. [Azure Management Groups](https://docs.microsoft.com/azure/governance/management-groups/overview) are not necessary for every Citrix deployment in Azure. However, if a multi-subscription approach is required, they should be considered as key tool in simplifying application of Azure governance requirements to the overall Citrix deployment.

If a single subscription is the right approach today it doesn’t mean you can’t adapt a multi-subscription approach later. [Host connections](https://docs.citrix.com/en-us/citrix-daas/install-configure/resource-location/azure-resource-manager.html#connection-to-azure-resource-manager) within Citrix Cloud are modular and enable the ability to add new Azure subscriptions and share images across subscriptions for flexible growth. During the design process, establish the requirements and process to add new subscriptions so the team is prepared operationally if this becomes a requirement.

## Next steps

Review the critical design considerations and recommendations for network topology and connectivity specific to the deployment of Citrix on Azure.

- [Network topology and connectivity](./ctx-network-topology-and-connectivity.md)
- [Naming and tagging in Azure](../../decision-guides/resource-tagging/index.md)
