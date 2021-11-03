---
title: Cloud Adoption Framework enterprise-scale design guidelines
description: Learn about enterprise-scale design guidelines in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Cloud Adoption Framework enterprise-scale design guidelines

This article outlines how the enterprise-scale architecture provides guidance on each of the [Azure landing zone design areas](../landing-zone/design-areas.md). To implement the design principles included in the enterprise-scale solution, follow the step-by-step design guidelines in the Critical design areas article series.

The core of enterprise-scale architecture contains a critical design path composed of fundamental design articles with interrelated and dependent design decisions. These articles provide design guidance across architecturally significant technical domains to support the critical design decisions that you must make to define the enterprise-scale architecture. For each of the considered domains, review the provided considerations and recommendations and use them to structure and drive designs within each area.

For example, you might ask how many subscriptions are needed for your estate. To do so, review [subscription organization and governance](./management-group-and-subscription-organization.md#subscription-organization-and-governance) and use the outlined recommendations to drive subscription decisions.

## Critical design areas

Use the guidelines in the following Critical design areas article series to help you translate your requirements to Azure constructs and capabilities. These eight critical design areas articles can help you address the mismatch between on-premises and cloud-design infrastructure, which typically creates dissonance between the enterprise-scale definition and Azure adoption.

Decisions you make within these critical areas reverberate across enterprise-scale architecture and influence other decisions. Familiarize yourself with these eight critical design areas to better understand the consequences of encompassed decisions, which might later produce trade-offs within related areas:

- [Enterprise Agreement enrollment and Azure Active Directory tenants](./enterprise-enrollment-and-azure-ad-tenants.md)
- [Identity and access management](./identity-and-access-management.md)
- [Management group and subscription organization](./management-group-and-subscription-organization.md)
- [Network topology and connectivity](./network-topology-and-connectivity.md)
- [Management and monitoring](./management-and-monitoring.md)
- [Business continuity and disaster recovery](./business-continuity-and-disaster-recovery.md)
- [Security governance and compliance](./security-governance-and-compliance.md)
- [Platform automation and DevOps](./platform-automation-and-devops.md)

## Next steps

After you've read each of the articles in the Critical design areas article series and familiarized yourself with these design areas, start reading about landing zones.

> [!div class="nextstepaction"]
> [Implement enterprise-scale landing zones](./implementation.md)