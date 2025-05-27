---
title: Enterprise enrollment considerations for SAP
description: SAP guidelines for enterprise enrollment
author: PmeshramPM
ms.author: pameshra
ms.date: 05/01/2021
ms.topic: conceptual
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing "Azure Fence Agent" -->
<!-- docutune:ignore DB -->

# Enterprise enrollment for SAP

Azure landing zones for SAP do not have any specific considerations or recommendations which would impact enterprise enrollment or Active Directory tenant decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of existing [enterprise enrollment or Microsoft Entra tenant decisions](../../ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant.md).

You may also want to review the [identity and access management considerations](./eslz-identity-and-access-management.md) to understand how the Active Directory tenant is applied in the design of authentication and authorization solutions. You may also want to evaluate the [resource organization considerations](./eslz-resource-organization.md) to understand how the enrollment may be organized into management groups, subscriptions, and resource groups.
