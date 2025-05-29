---
title: Identity and access management considerations for Azure API Management
description: Learn about design considerations and recommendations for identity and access management in the Azure API Management landing zone accelerator
author: Zimmergren
ms.author: pnp
ms.date: 04/12/2022
ms.topic: conceptual
ms.custom: internal
---

# Identity and access management considerations for the API Management landing zone accelerator

This article provides design considerations and recommendations for identity and access management when using the API Management landing zone accelerator. Identity and access management covers multiple aspects including access to manage the API Management instance, API developer access, and client access to APIs.

Learn more about the [identity and access management](../../../ready/landing-zone/design-area/identity-access.md) design area.

## Design considerations

- Decide on the access management for API Management services through all possible channels including portal, ARM REST API, DevOps, etc.
- Decide on the access management for API Management entities.
- Decide how to sign up and authorize the developer accounts.
- Decide how subscriptions are used.
- Decide on the visibility of products and APIs on the developer portal.
- Decide on access revocation policies.
- Decide on reporting requirements for access control.

## Design recommendations

- Use [built-in roles](/azure/api-management/api-management-role-based-access-control#built-in-roles) to delegate responsibilities across teams to manage the API Management instance.
- Use custom roles based on API Management [RBAC operations](/azure/role-based-access-control/resource-provider-operations#microsoftapimanagement) to set fine-grained access to API Management entities. Examples: API developers, backup operators, DevOps automation, etc.
- Associate subscriptions at the appropriate scope, such as products.
- Create appropriate [groups](/azure/api-management/api-management-howto-create-groups) to control the visibility of the products.
- Manage access to the developer portal using [Azure Active Directory B2C](/azure/api-management/api-management-howto-aad-b2c).
- Reporting:
  - Make use of built-in [analytics](/azure/api-management/howto-use-analytics).
  - Integrate API Management with [Application Insights](/azure/api-management/api-management-howto-app-insights).
  - Review [diagnostic logs](/azure/api-management/api-management-howto-use-azure-monitor#resource-logs).
  - Create custom reports.
