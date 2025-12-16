---
title: Enterprise enrollment considerations for SAP
description: SAP guidelines for enterprise enrollment
author: PmeshramPM
ms.author: pameshra
ms.date: 05/01/2021
ms.topic: concept-article
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing "Azure Fence Agent" -->
<!-- docutune:ignore DB -->

# Enterprise enrollment for SAP

Azure landing zones for SAP do not introduce additional requirements that affect enterprise enrollment or Microsoft Entra ID tenant decisions.

However, review decisions that the cloud platform team has already made. These decisions may affect existing [enterprise enrollment or Microsoft Entra ID tenant choices](../../ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant.md).

Review the [identity and access management considerations](./eslz-identity-and-access-management.md) to see how the Microsoft Entra ID tenant supports authentication and authorization.

Also review the [resource organization considerations](./eslz-resource-organization.md). This guidance explains how enrollment can map to management groups, subscriptions, and resource groups.