---
title: "Design Guidelines"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF NorthStar landing zone - Design Guidelines
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# Design Guidelines

At the centre of the CAF NorthStar architecture lies a critical design path, comprised of fundamental design topics with heavily interrelated and dependent design decisions. This repository provides design guidance across these architecturally significant technical domains to support the critical design decisions which must occur to define the CAF NorthStar architecture. For each of the considered domains, readers should review provided considerations and recommendations, using them to structure and drive designs within each area.

For example, a customer is likely to question how many subscriptions they require for their estate. In this instance, the reader should review the *C - Management Group and Subscription Organization -&gt; 2. Subscription Organization and Governance* section, using the outlined recommendations to help drive subscription decisions.

## Critical Design Areas

The following eight critical design areas are intended to support the translation of customer requirements to Azure constructs and capabilities, to address the mismatch between on-premises infrastructure and cloud-design which typically creates dissonance and friction with respect to the CAF NorthStar definition and Azure adoption.

[![Critical Design Areas](./media/critical-design-areas.png "Critical Design Areas")](./media/critical-design-areas.png)

The impact of decisions made within these critical areas will reverberate across the CAF NorthStar architecture and influence other decisions. Readers are strongly advised to familiarize themselves with these eight areas, to better understand the consequences of encompassed decisions, which may later produce trade-offs within related areas.

* [A - Enterprise Enrolment and Azure AD Tenants](./A-Enterprise-Enrolment-and-Azure-AD-Tenants.md)
* [B - Identity and Access Management](./B-Identity-and-Access-Management.md)
* [C - Management Group and Subscription Organization](./C-Management-Group-and-Subscription-Organization.md)
* [D - Network Topology and Connectivity](./D-Network-Topology-and-Connectivity.md)
* [E - Management and Monitoring](./E-Management-and-Monitoring.md)
* [F - Business Continuity and Disaster Recovery](./F-Business-Continuity-and-Disaster-Recovery.md)
* [G - Security, Governance, and Compliance](./G-Security-Governance-and-Compliance.md)
* [H - Platform Automation and DevOps](./H-Platform-Automation-and-DevOps.md)

## Next steps

Configuration of [Enterprise Enrolment and Azure AD Tenants](./A-Enterprise-Enrolment-and-Azure-AD-Tenants.md)

> [!div class="nextstepaction"]
> [Enterprise Enrolment and Azure AD Tenants](./A-Enterprise-Enrolment-and-Azure-AD-Tenants.md)