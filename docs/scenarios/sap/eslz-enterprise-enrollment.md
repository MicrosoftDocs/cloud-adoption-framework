---
title: Enterprise enrollment considerations for SAP
description: SAP guidelines for enterprise enrollment
author: brianblanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing "Azure Fence Agent" -->
<!-- docutune:ignore DB -->

# Enterprise enrollment for SAP

Azure Landing Zones for SAP do not have any specific considerations or recommendations which would impact enterprise enrollment or AD Tenant decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of existing [Enterprise enrollment or AD Tenant decisions](../../ready/enterprise-scale/enterprise-enrollment-and-azure-ad-tenants.md).

You may also want to review the [Identity and Access Management considerations](./eslz-identity-and-access-management.md) to understand how the AD Tenant is applied in the design of authentication and authorization solutions. You may also want to evaluate the [Resource organization considerations](./eslz-resource-organization.md) to understand how the enrollment may be organized into management groups, subscriptions, and resource groups.
