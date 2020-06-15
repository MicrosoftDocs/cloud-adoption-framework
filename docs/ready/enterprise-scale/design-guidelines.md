---
title: Design guidelines
description: Design guidelines
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design guidelines

This article and the articles series that follows outline how the enterprise-scale architecture provides an opinionated position on each of the Microsoft [Azure landing zone design areas](../landing-zone/design-areas.md). This article series creates a step-by-step set of design guidelines that can be followed to implement the design principles embodied in the enterprise-scale solution.

The core of enterprise-scale architecture contains a critical design path comprised of fundamental design topics with heavily interrelated and dependent design decisions. This repo provides design guidance across these architecturally significant technical domains to support the critical design decisions that must occur to define the enterprise-scale architecture. For each of the considered domains, readers should review the provided considerations and recommendations and use them to structure and drive designs within each area.

For example, a customer is likely to ask how many subscriptions they need for their estate. In this case, the reader should review [subscription organization and governance](./management-group-and-subscription-organization.md#subscription-organization-and-governance) and use the outlined recommendations to drive subscription decisions.

## Critical design areas

The following eight critical design areas help to translate customer requirements to Microsoft Azure constructs and capabilities and to address the mismatch between on-premises and cloud-design infrastructure, which typically creates dissonance and friction between the enterprise-scale definition and Azure adoption.

The impact of decisions made within these critical areas will reverberate across enterprise-scale architecture and influence other decisions. Readers should familiarize themselves with the eight areas below to better understand the consequences of encompassed decisions, which may later produce trade-offs within related areas.

1. [Enterprise enrollment and Azure Active Directory tenants](./enterprise-enrollment-and-azure-ad-tenants.md)
2. [Identity and access management](./identity-and-access-management.md)
3. [Management group and subscription organization](./management-group-and-subscription-organization.md)
4. [Network topology and connectivity](./network-topology-and-connectivity.md)
5. [Management and monitoring](./management-and-monitoring.md)
6. [Business continuity and disaster recovery](./business-continuity-and-disaster-recovery.md)
7. [Security, governance, and compliance](./security-governance-and-compliance.md)
8. [Platform automation and DevOps](./platform-automation-and-devops.md)
