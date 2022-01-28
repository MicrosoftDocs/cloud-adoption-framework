---
title: Resource organization for enterprise-scale data management and analytics
description: Learn how this enterprise-scale scenario can improve management group and subscription organization for data management and analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 12/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Resource organization for data management and analytics scenario

To align with the Ready methodology of the Cloud Adoption Framework, implement a naming and tagging strategy. Your strategy should include business and operational details as components of resource names and metadata tags. For more information, see [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md).

Data management and analytics scenario includes a data management landing zone subscription. This subscription has the standard services of an [enterprise-scale framework](../../ready/enterprise-scale/index.md). It's connected to the data landing zones and connectivity subscriptions by using virtual network peering. For more information on the subscriptions in data management and analytics scenario, see [data management landing zone](./architectures/data-management-landing-zone.md) and [data landing zone](./architectures/data-landing-zone.md).

You can further enforce organizational standards based on business rules by using the Azure Policy service. Assign these policies to a scope of resources, such as management groups, subscriptions, resource groups, or individual resources. Data management and analytics scenario contains custom policies that apply to the data management landing zone and data landing zone subscriptions. For more information, see [Policies](./eslz-policies.md).

## Resource naming and tagging conventions

Organize your cloud assets to support governance, operational management, and accounting requirements. Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and showback accounting mechanisms.

## Next steps

[Security, governance, and compliance for enterprise-scale data management and analytics](./eslz-security-governance-and-compliance.md)
