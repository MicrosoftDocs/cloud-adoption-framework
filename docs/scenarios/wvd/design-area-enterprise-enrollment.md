---
title: Enterprise enrollment design area for Azure Virtual Desktop
description: Explore the enterprise enrollment design area and how to apply it to an Azure Virtual Desktop implementation
author: DominicAllen
ms.author: doalle
ms.date: 06/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Enterprise enrollment considerations for an Azure Virtual Desktop implementation

For most customer implementations, standard best practices around enterprise enrollment and Active Directory tenants are unchanged when deploying Azure landing zones for Azure Virtual Desktop. There are seldom specific considerations or recommendations that would impact enterprise enrollment or Active Directory tenant decisions. See the following considerations to determine whether Azure Virtual Desktop requirements would impact existing tenant decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of existing [enterprise enrollment or Active Directory tenant decisions](../../ready/enterprise-scale/enterprise-enrollment-and-azure-ad-tenants.md).

You might also want to review the [identity and access management considerations](./eslz-identity-and-access-management.md) to understand how the Active Directory tenant is applied in the design of authentication and authorization solutions. You might also want to evaluate the [resource organization considerations](./design-area-resource-organization.md) to understand how the enrollment might be organized into management groups, subscriptions, and resource groups.
