---
title: "Overview of management group and subscription organization"
description: Management group and subscription organization for Enterprise Analytics and AI
author: abdale
ms.author: hamoodaleem
ms.date: 03/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management Group and Subscription Organization for data management Enterprise-Scale scenario

Enterprise Scale Analytics and AI includes a Data Management Landing Zone subscription which has the standard services of an [Enterprise Scale framework](/azure/cloud-adoption-framework/ready/enterprise-scale/). It is  connected to the Data Landing Zone(s) and connectivity subscriptions via Virtual Network Peering. For further reading on the subscriptions in Enterprise Scale Analytics and AI, see the [Data Management Landing Zone](eslz-data-management-landing-zone.md) and [Data Landing Zone](eslz-data-landing-zone.md) sections.

Organizational standards can be further enforced by implementing guard rails that are based on business rules by using **Azure Policies**. These policies can be assigned to a scope of resources such as management groups, subscriptions, resource groups or individual resources. Enterprise Scale Analytics and AI contains custom Azure Policies which apply to the Data Management Landing Zone and Data Landing Zone subscriptions. For further reading, see [Policies](eslz-policies.md).
