---
title: "Manage SAP in Azure"
description: Operations management considerations when managing SAP on Azure
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Manage SAP in Azure

Your long term operations management strategy has a big impact on your SAP migration and landing zone requirements. Achieving an understanding of your operations management requirements early is important. This article will focus on the later state of managing SAP, once it's in Azure to help shape your vision.

## SAP business alignment

Generally, SAP is viewed as a Mission-Critical platform. There will likely be investments above and beyond your operations baseline to support SAP. Most organizations require a mixture of platform operations and workload operations (outlined below). However, during business alignment, strive to separate environments and workloads from your core SAP platform when completing your business alignment.

Considerations during business alignment:

- Environments: Identify any non-production environments for SAP. Any development, QA, or other environments are less likely to need any form of specialized operations.
- Workloads: Often times, there will be a host of workloads that interact with and extend SAP. The basic operations baseline will provide a sufficient SLA for those dependent workloads. When a higher level of operations is required, consider workload operations on a case-by-case basis.

## Operations baseline

When adopting SAP in Azure, your operations baseline will not likely change. The assets that run your SAP platform & workloads will be included in the standard processes & tools for creating visibility, optimizing operations, and recovery.

The operations baseline may not need to be changed. However, you will likely need additional processes and tools as part of your SAP specific platform operations deployment.

## SAP platform operations

Given the mission critical nature of your SAP platform, most organizations have dedicated operations staff who are responsible for the operational management of the core SAP platform.

If your organization has a centralized SAP platform team, you will want to consider tooling to enhance operations of the core platform. The [enterprise scale scenario for SAP](./enterprise-scale-landing-zone.md) provides guidance on elevated management and DR/BC scenarios that can improve operations of the platform.

## SAP workload operations

Each of the workloads that depend on SAP are likely to have material impact on business processes. The downtime costs of those individual workloads is unlikely to impact the business to the same degree as downtime for the core SAP platform. Since there is less downtime impact, there is likely to be a lower ROI when investing in reliability and business continuity for each workload. However, some of those workloads will still require dedicated, specialized operations.

When dependent workloads have their own specialized operations requirements, run the [Well-Architected Review](https://docs.microsoft.com/en-us/assessments/?id=azure-architecture-review&mode=pre-assessment) and review the [Well-Architected Framework](https://docs.microsoft.com/azure/architecture/framework/) to understand how to optimize operations for those specific workloads.

## Next step: Your next migration iteration

Once the SAP migration is complete, the cloud adoption team can begin your next scenario-specific migration. Alternatively, if there are addition SAP platforms to be migrated, this article series can be used again to guide your next SAP migration or deployment.

- [Strategy for SAP](./strategy.md)
- [Plan for SAP](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate SAP](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)