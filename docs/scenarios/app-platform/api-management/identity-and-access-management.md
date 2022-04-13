---
title: Identity and access management considerations for Azure API Management
description: <<Describe how this landing zone accelerator can improve identity and access management of Azure API Management.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Identity and access management considerations for API Management landing zone accelerator

[Intro paragraph. Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials.]

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of API Management.

Decide on the access management for API Management services through all possible channels like portal, ARM REST API, DevOps etc.
- Decide on the access management for API Management entities.
- Decide on how to sign up and authorize the developer accounts.
- Decide on how subscriptions are used.
- Decide on the visibility of products and APIs on the developer portal.
- Decide on access revocation policies.
- Decide on reporting requirements for access control.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of API Management.

- Use [built-in roles](/azure/api-management/api-management-role-based-access-control#built-in-roles) to control access to API Management service to delegate responsibilities across teams to manage the API Management instance.
- Using custom roles using API Management [RBAC Operations](/azure/role-based-access-control/resource-provider-operations#microsoftapimanagement) to set fine-grained access to API Management entities. For example. API developers, Backup operators, DevOps Automation, etc.
- Associate subscriptions at the appropriate scope like products.
- Create appropriate groups to control the visibility of the products.
- Manage access to the developer portal using [Azure Active Directory B2C](/azure/api-management/api-management-howto-aad-b2c).
- Reporting:
    - Make use of built-in analytics.
    - Review Audit logs.
    - Create custom reports.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for API Management.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.
