---
title: "Azure Enterprise Scale Analytics management group and subscription organization for 'Enterprise Scale Analytics and AI'"
description: Describe how this enterprise-scale scenario can improve management group and subscription organization of 'Enterprise Scale Analytics and AI'
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management group and subscription organization for 'Enterprise Scale Analytics and AI' Enterprise-Scale scenario

Enterprise Scale Analytics and AI includes a Data Management Landing Zone subscription which has the standard services of an [Enterprise Scale framework](/azure/cloud-adoption-framework/ready/enterprise-scale/). It is  connected to the Data Landing Zone(s) and connectivity subscriptions via Virtual Network Peering. For further reading on the subscriptions in Enterprise Scale Analytics and AI, see the [Data Management Landing Zone](data-management-landing-zone.md) and [Data Landing Zone](data-landing-zone.md) sections.

Organizational standards can be further enforced by implementing guard rails that are based on business rules by using **Azure Policies**. These policies can be assigned to a scope of resources such as management groups, subscriptions, resource groups or individual resources. Enterprise Scale Analytics and AI contains custom Azure Policies which apply to the Data Management Landing Zone and Data Landing Zone subscriptions. For further reading, see [Policies](policies.md).
