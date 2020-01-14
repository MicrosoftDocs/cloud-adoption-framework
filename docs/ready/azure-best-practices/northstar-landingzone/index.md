---
title: "North Star architecture guide"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: North Star landing zone - Enterprise Enrolment and Azure AD Tenants
author: 
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

[![North Star Playbook](./docs/media/icon.png "North Star Playbook")](#)

This guide will explore actionable architectural and implementation guidelines for large-scale enterprise Azure adoption, focusing on the platform “North Star” design that must occur prior to application deployments, to support cloud migrations and position customers on a strategic transformation path for cloud-native innovation.

In this regard, this repository is intended to support enterprise Azure adoption by leveraging learnings from previous engineering engagements to provide a common “North Star” design pattern for the CSU to better serve customers, where the “North Star” represents a strategic and ever-evolving design path for the customer platform, that is fully aligned with the Azure platform roadmap.

## Navigation Menu
* [North Star Architecture](./docs/North Star-Architecture.md)
    -	[Design Principles](./docs/Design-Principles.md)
* [Design Guidelines](./docs/Design-Guidelines.md)
    -	[A - Enterprise Enrolment and Azure AD Tenants](./docs/A-Enterprise-Enrolment-and-Azure-AD-Tenants.md)
    -	[B - Identity and Access Management](./docs/B-Identity-and-Access-Management.md)
    -	[C - Management Group and Subscription Organisation](./docs/C-Management-Group-and-Subscription-Organisation.md)
    -	[D - Network Topology and Connectivity](./docs/D-Network-Topology-and-Connectivity.md)
    -	[E - Management and Monitoring](./docs/E-Management-and-Monitoring.md)
    -	[F - Business Continuity and Disaster Recovery](./docs/F-Business-Continuity-and-Disaster-Recovery.md)
    -	[G - Secutiry Governance and Compliance](./docs/G-Security-Governance-and-Compliance.md)
    -	[H - Platform Automation and DevOps](./docs/H-Platform-Automation-and-DevOps.md)
* [Implementation Guide](./docs/Implementation-Guide.md)

## Objective

The primary objective of this guide is to **help CSAs define a “North Star” architecture for their customers**, considering requisite design decisions across fundamental technical topics and “what-must-be-true” before organization wide Azure adoption can occur.

## Audience

This guide outlines architectural guidance for large-scale Azure adoption to provide critical insights for **CSAs and the broader CSU technical community** in support of enterprise migration/transformation projects.

## Prerequisites

To fully leverage the guidance contained within this guide, readers must have a collaborative engagement with key customer stakeholders across critical technical domains, such as identity, security, and networking. Ultimately, the success of any large-scale migration hinges on cross-discipline cooperation within the customer organisation, since key requisite ”North Star” design decisions are cross cutting, and to be authoritative must involve domain SMEs and stakeholders within the customer.

It is also assumed that readers have a broad understanding of key Azure constructs and services in order to fully contextualise the prescriptive recommendations contained within this guide.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
