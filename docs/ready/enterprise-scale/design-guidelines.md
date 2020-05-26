---
title: Design guidelines
description: Design guidelines
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design guidelines

Within the center of enterprise-scale architecture is a critical design path comprised of fundamental design topics with heavily interrelated and dependent design decisions. This repository provides design guidance across these architecturally significant technical domains to support the critical design decisions that must occur to define the enterprise-scale architecture. For each of the considered domains, readers should review the provided considerations and recommendations and use them to structure and drive designs within each area.

For example, a customer is likely to question how many subscriptions they require for their estate. In this instance, the reader should review the *C - management group and subscription organization -&gt; 2. Subscription organization and governance* section, using the outlined recommendations to help drive subscription decisions.

# Critical design areas

The following eight critical design areas are intended to support translating customer requirements to Microsoft Azure constructs and capabilities and to address the mismatch between on-premises infrastructure and cloud-design, which typically creates dissonance and friction between the enterprise-scale definition and Azure adoption.

The impact of decisions made within these critical areas will reverberate across enterprise-scale architecture and influence other decisions. Readers are advised to familiarize themselves with the eight areas below to better understand the consequences of encompassed decisions, which may later produce trade-offs within related areas.

- [A - enterprise enrollment and Azure AD tenants](./Enterprise-Enrollment-and-Azure-AD-Tenants.md)
- [B - identity and access management](./Identity-and-Access-Management.md)
- [C - management group and subscription organization](./Management-Group-and-Subscription-Organization.md)
- [D - network topology and connectivity](./Network-Topology-and-Connectivity.md)
- [E - management and monitoring](./Management-and-Monitoring.md)
- [F - business continuity and disaster recovery](./Business-Continuity-and-Disaster-Recovery.md)
- [G - security, governance, and compliance](./Security-Governance-and-Compliance.md)
- [H - platform automation and DevOps](./Platform-Automation-and-DevOps.md)
