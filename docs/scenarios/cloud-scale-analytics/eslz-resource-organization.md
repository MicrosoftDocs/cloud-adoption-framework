---
title: Resource organization for enterprise-scale cloud-scale analytics
description: Learn how this enterprise-scale scenario can improve management group and subscription organization for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Resource organization for cloud-scale analytics

To align with the Ready methodology of the Cloud Adoption Framework, implement a naming and tagging strategy. Your strategy should include business and operational details as components of resource names and metadata tags. For more information, see [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md).

Cloud-scale analytics includes a data management landing zone subscription. This subscription has the standard services of an [enterprise-scale framework](../../ready/enterprise-scale/index.md). It's connected to the data landing zones and connectivity subscriptions by using virtual network peering. For more information on the subscriptions in cloud-scale analytics, see [data management landing zone](./architectures/data-management-landing-zone.md) and [data landing zone](./architectures/data-landing-zone.md).

You can further enforce organizational standards based on business rules by using the Azure Policy service. Assign these policies to a scope of resources, such as management groups, subscriptions, resource groups, or individual resources. Cloud-scale analytics contains custom policies that apply to the data management landing zone and data landing zone subscriptions. For more information, see [Policies](./eslz-policies.md).

## Resource naming and tagging conventions

Organize your cloud assets to support governance, operational management, and accounting requirements. Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and showback accounting mechanisms.

## Next steps

- [Security, governance, and compliance for enterprise-scale cloud-scale analytics](./eslz-security-governance-and-compliance.md)
