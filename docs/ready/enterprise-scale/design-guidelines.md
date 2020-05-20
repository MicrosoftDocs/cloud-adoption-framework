---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design guidelines

At the centre of the "enterprise-scale" architecture lies a critical design path, comprised of fundamental design topics with heavily interrelated and dependent design decisions. This repository provides design guidance across these architecturally significant technical domains to support the critical design decisions which must occur to define the "enterprise-scale" architecture. For each of the considered domains, readers should review provided considerations and recommendations, using them to structure and drive designs within each area.

For example, a customer is likely to question how many subscriptions they require for their estate. In this instance, the reader should review the *C - management group and subscription organization -&gt; 2. Subscription organization and governance* section, using the outlined recommendations to help drive subscription decisions.

## Critical design areas

The following eight critical design areas are intended to support the translation of customer requirements to Azure constructs and capabilities, to address the mismatch between on-premises infrastructure and cloud-design which typically creates dissonance and friction with respect to the "enterprise-scale" definition and Azure adoption.

The impact of decisions made within these critical areas will reverberate across the "enterprise-scale" architecture and influence other decisions. Readers are strongly advised to familiarize themselves with these eight areas, to better understand the consequences of encompassed decisions, which may later produce trade-offs within related areas.

- [A - enterprise enrollment and Azure AD tenants](./Enterprise-Enrollment-and-Azure-AD-Tenants.md)
- [B - identity and access management](./Identity-and-Access-Management.md)
- [C - management group and subscription organization](./Management-Group-and-Subscription-Organization.md)
- [D - network topology and connectivity](./Network-Topology-and-Connectivity.md)
- [E - management and monitoring](./Management-and-Monitoring.md)
- [F - business continuity and disaster recovery](./Business-Continuity-and-Disaster-Recovery.md)
- [G - security, governance and compliance](./Security-Governance-and-Compliance.md)
- [H - platform automation and DevOps](./Platform-Automation-and-DevOps.md)
