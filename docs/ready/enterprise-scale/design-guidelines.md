---
title: Design guidelines
description: Design guidelines
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design guidelines

This article and the 8 part article series that follows outline how the enterprise-scale architecture provides an opinionated position on each of the [Azure landing zone design areas](../landing-zone/design-areas.md). Together this article series creates a step-by-step set of design guidelines which can be followed to implement the design principles embodied in the enterprise-scale solution.

Within the center of enterprise-scale architecture is a critical design path comprised of fundamental design topics with heavily interrelated and dependent design decisions. This repository provides design guidance across these architecturally significant technical domains to support the critical design decisions that must occur to define the enterprise-scale architecture. For each of the considered domains, readers should review the provided considerations and recommendations and use them to structure and drive designs within each area.

<!-- TODO: Fix reference below. -->

For example, a customer is likely to question how many subscriptions they require for their estate. In this instance, the reader should review the *C - management group and subscription organization -&gt; 2. Subscription organization and governance* section, using the outlined recommendations to help drive subscription decisions.

## Critical design areas

The following eight critical design areas help to translate customer requirements to Microsoft Azure constructs and capabilities and to address the mismatch between on-premises and cloud-design infrastructure, which typically creates dissonance and friction between the enterprise-scale definition and Azure adoption.

The impact of decisions made within these critical areas will reverberate across enterprise-scale architecture and influence other decisions. Readers are advised to familiarize themselves with the eight areas below to better understand the consequences of encompassed decisions, which may later produce trade-offs within related areas.

1. [Enterprise enrollment and Azure Active Directory tenants](./enterprise-enrollment-and-azure-ad-tenants.md)
2. [Identity and access management](./identity-and-access-management.md)
3. [Management group and subscription organization](./management-group-and-subscription-organization.md)
4. [Network topology and connectivity](./network-topology-and-connectivity.md)
5. [Management and monitoring](./management-and-monitoring.md)
6. [Business continuity and disaster recovery](./business-continuity-and-disaster-recovery.md)
7. [Security, governance, and compliance](./security-governance-and-compliance.md)
8. [Platform automation and DevOps](./platform-automation-and-devops.md)
