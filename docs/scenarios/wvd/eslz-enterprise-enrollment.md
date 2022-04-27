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

When Azure landing zones for Azure Virtual Desktop are deployed, the standard best practices around enterprise enrollment and Active Directory tenants are not changed for most customer implementations. There are several specific considerations or recommendations that impacts enterprise enrollment or Active Directory tenant decisions.

See the following considerations to determine whether Azure Virtual Desktop requirements can create an impact in existing tenant decisions:

- It is important for the cloud platform team to understand the existing [enterprise enrollment or Active Directory tenant decisions](../../ready/landing-zone/design-area/azure-billing-ad-tenant.md).

- You can review the [identity and access management considerations](./eslz-identity-and-access-management.md) to understand how the Active Directory tenant is applied in authentication and authorization solutions design.

- You can also refer to the [resource organization considerations](./eslz-resource-organization.md) to understand how the enrollment is organized into management groups, subscriptions, and resource groups.
