---
title: "Business alignment: Cloud management and operations"
description: Business Alignment - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Create business alignment in cloud management

In on-premises environments, IT assets (applications, virtual machines, VM hosts, disk, servers, devices, and data sources) are managed by IT to support workload operations. In IT terms, a workload is a collection of IT assets that support a specific business operation. To help support business operations, IT management delivers processes that are designed to minimize disruptions to those assets. When an organization moves to the cloud, management and operations shift a bit, creating an opportunity to develop tighter business alignment.

## Business vernacular

The first step in creating business alignment is to ensure term alignment. IT management, like most engineering professions, has amassed a collection of jargon, or highly technical terms. Such terms can lead to confusion for business stakeholders and make it difficult to map management services to business value.

Fortunately, the process of developing a cloud adoption strategy and cloud adoption plan creates an ideal opportunity to remap these terms. The process also creates opportunities to rethink commitments to operational management, in partnership with the business. The following article series walks you through this new approach across three specific terms that can help improve conversations among business stakeholders: 

- **[Criticality](./criticality.md):** Mapping workloads to business processes. Ranking criticality to focus investments.
- **[Impact](./impact.md):** Understanding the impact of potential outages to aid in evaluating return on investment for cloud management.
- **[Commitment](./commitment.md):** Developing true partnerships, by creating and documenting agreements *with the business*.

> [!NOTE]
> Underlying these terms are classic IT terms such as SLA, RTO, and RPO. Mapping specific business and IT terms is covered in more detail in the [Commitment](./commitment.md) article.

## Ops Management planning workbook

To help capture decisions that result from this conversation about term alignment, an [Ops Management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) is available on our GitHub site. This workbook does not perform SLA or cost calculations. It serves only to help capture such measures and forecast return on loss-avoidance efforts.

Alternatively, these same workloads and associated assets could be tagged directly in Azure, if the solutions are already deployed to the cloud.

## Next steps

Start creating business alignment by defining [workload criticality](./criticality.md).

> [!div class="nextstepaction"]
> [Define workload criticality](./criticality.md)
