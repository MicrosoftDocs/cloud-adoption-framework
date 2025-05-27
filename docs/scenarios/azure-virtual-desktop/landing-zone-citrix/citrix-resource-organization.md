---
title: Resource organization considerations for Citrix on Azure
description: Learn about the resource organization design area and how to apply it to your Citrix on Azure implementation.
author: BenMartinBaur
ms.author: bebaur
ms.date: 02/06/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Resource organization considerations for Citrix on Azure

This article provides considerations that you should take into account when you plan your organization's Citrix landing zone structure.

## Citrix design recommendations

The following sections provide recommendations for labeling and organizing resources when you deploy Citrix on Azure.

Additional design guidance for Citrix DaaS on Azure is available on [Citrix TechZone](https://community.citrix.com/tech-zone/by-product/citrix-daas#_=_). The article highlights the system, workload, user, and network considerations for aligning Citrix deployments with Cloud Adoption Framework design principles. 

### Citrix Cloud naming and tagging

Naming and tagging standards help you organize resources and simplify resource management, cost tracking, and governance.

Maintaining consistency across resources can help you identify deviation from agreed-upon policies. [Prescriptive guidance for resource tagging](../../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) describes how one of the following patterns can help you deploy governance practices. Similar patterns are available for using tags to evaluate regulatory compliance.
	
A standardized naming convention is the starting point for organizing cloud-hosted resources. Properly structured naming systems enable you to quickly identify resources for management and accounting purposes. If you have existing IT naming conventions for other parts of your organization, consider whether you'll align your cloud naming conventions with them or make your cloud naming conventions unique and separate.
	
Azure naming schemes should align with the associated resources in Citrix Cloud. For example, when you use multiple subscriptions for a Citrix deployment, use naming schemes for [machine catalogs in Citrix Cloud](https://docs.citrix.com/en-us/citrix-daas/install-configure/machine-catalogs-manage.html) that identify the subscription that they're associated with. For example, you could use **MC-USEast2Sub01-Win10-HR** and **MC-USEast2Sub02-Win10-HR** to represent Windows 10 VDIs deployed for HR across two subscriptions in US East 2. You can aggregate multiple catalogs across multiple subscriptions or regions into a [delivery group](https://docs.citrix.com/en-us/citrix-daas/install-configure/delivery-groups-manage.html) to make it easy to manage these disparate resources for a use case. In this example, the highlighted catalogs could then be aggregated into **DG-USEast2-Win10-HR**.

## Management groups and subscriptions

An Azure subscription is a logical limit of scale that you can use to allocate resources. These limits include [thresholds for numerous resource types](/azure/azure-resource-manager/management/azure-subscription-service-limits) and throttling limits based on reads and writes made against Azure. Subscription requests, like virtual machine power management, [determine the recommended number of Citrix machines per Azure subscription](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/limits.html#machine-creation-services-mcs-limits). For this reason, we recommend that you use a dedicated subscription or subscriptions for the Citrix landing zone. 

The following considerations can help you decide between a single-subscription or multiple-subscription architecture:

-	**Scale.** What percentage of your organization will have workloads on Azure? Will long term usage exceed 5,000 virtual machines?
-	**Use cases.** Are your use cases known? If so, are your target use cases predominately virtualized applications or multi-session desktops? Is VDI considered more niche (less than 5-10% of total user count)?
-	**Operations.** Do you have a clear line of ownership between teams that manage server and client operating systems? Do these teams also have separate cost centers? Is there a shared change control or user onboarding process?

In a multiple-subscription architecture, you should deploy management components in a Citrix Shared Services subscription. The virtual apps and desktops should be contained in Workload subscriptions. [Azure management groups](/azure/governance/management-groups/overview) aren't needed for every Citrix deployment on Azure. However, if you use a multiple-subscription approach, management groups can help you simplify the application of Azure governance requirements to the overall Citrix deployment.

You can start with a single subscription and switch to a multiple-subscription approach later. [Host connections](https://docs.citrix.com/en-us/citrix-daas/install-configure/resource-location/azure-resource-manager.html#connection-to-azure-resource-manager) in Citrix Cloud are modular and enable you to add new Azure subscriptions and share images across subscriptions for flexible growth. During the design process, establish the requirements and process to add new subscriptions so the team is prepared operationally if this becomes a requirement.

## Next steps

- [Network topology and connectivity for Citrix on Azure](./citrix-network-topology-connectivity.md)
- [Naming and tagging in Azure](../../../ready/azure-best-practices/resource-naming-and-tagging-decision-guide.md)
