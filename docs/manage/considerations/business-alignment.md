---
title: "Business Alignment - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Business Alignment - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Create business alignment in cloud management

In on-premises environments, IT assets (applications, virtual machines, VM hosts, disk, servers, devices, and data sources) are managed by IT to support workload operations. In IT terms, a workload is a collection of IT assets that support a specific business operation. In on-premises environments, IT management delivers processes design to minimize disruptions to those IT assets, in an attempt to minimize disruptions to the support business operations. When moving to the cloud, management and operations shifts a bit, creating an opportunity to develop tighter business alignment.

## Business vernacular

The first step in creating business alignment is term alignment. IT management, like most engineering professions, includes a fair bit of jargon or highly technical terms. Those terms can lead to confusion for business stakeholders and make it difficult to map management services to business value.

Fortunately, the processes for developing a cloud adoption strategy and cloud adoption plan, creates an ideal situation for the remapping of terms. It also creates a great opportunity to rethink commitments to operational management, in partnership with the business. The following article series walks through this new approach across three specific terms that can improve conversations with business stakeholders:

- **[Criticality](./criticality.md):** Mapping workloads to business processes. Ranking criticality to focus investments.
- **[Impact](./impact.md):** Understand the impact of potential outages to aid in evaluating return on investment for cloud management.
- **[Commitment](./commitment.md):** Develop true partnerships, by creating and documenting agreements **with the business**.

> [!NOTE]
> Beneath each of these terms are classic IT terms like SLA, RTO, and RPO. Mapping business and IT terms is covered in more detail in the article on commitment.

## Ops Management planning workbook

To help capture decisions as a result of this conversation, an [Ops Management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) is available in our GitHub repo. This workbook does not perform SLA or cost calculations. It serves only as a guide to capture those measures and forecast return on loss avoidance efforts.

Alternatively, these same workloads and associated assets could be tagged directly in Azure, if the solutions are already deployed to the cloud.

## Next steps

Start creating business alignment by defining [workload criticality](./criticality.md).

> [!div class="nextstepaction"]
> [Define workload criticality](./criticality.md)
