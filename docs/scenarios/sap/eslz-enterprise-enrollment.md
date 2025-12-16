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

# Decide how to enroll your enterprise when deploying SAP on Azure

Azure landing zones for SAP do not add new enterprise enrollment requirements. They also do not require you to create a new Microsoft Entra ID tenant.

Before you proceed, review the decisions your cloud platform team has already made.  
These decisions affect how you configure enterprise enrollment and your Microsoft Entra ID tenant. For background, see [enterprise enrollment and Microsoft Entra ID tenant choices](../../ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant.md).

Review the [identity and access management considerations](./eslz-identity-and-access-management.md). This article explains how your Microsoft Entra ID tenant manages authentication and authorization for SAP on Azure, such as user sign-in and role-based access.

Next, review the [resource organization considerations](./eslz-resource-organization.md).  
This article shows how enterprise enrollment maps to these Azure constructs:
- Management groups, which you use to organize subscriptions at scale
- Subscriptions, which define billing and access boundaries
- Resource groups, which hold and manage related Azure resources