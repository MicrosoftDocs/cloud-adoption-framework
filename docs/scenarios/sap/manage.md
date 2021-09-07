---
title: Manage SAP in Azure
description: Operations management considerations when managing SAP on Azure
author: JefferyMitchell
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Manage SAP in Azure

The long term operations management strategy has a big impact on your SAP migration and landing zone requirements.

To achieve an understanding of your operations management requirements once your data is in Azure, focus on the later stage guidelines to manage SAP and help shape your vision.

To better align your business, the SAP platform and dependent workloads are viewed as *mission-critical* technology assets. These are often investments above and beyond your operations baseline to support both the SAP platform and each of the dependent workloads.

Most organizations require a mixture of platform operations, **SAP Basis Operations**, and workload operations, such as:

- **Environments**, identify any non-production environment running an instance of the SAP platform, such as development, QA, or other environment less likely to need any form of specialized operations.
- **Workloads**, identify the host of workloads that interact with and extend the core SAP platform. This basic operations baseline will provide a sufficient SLA for these dependent workloads.

   > [!NOTE]
   > When a higher level of operations is required, consider workload operations on a case-by-case basis.

During business alignment, strive to separate the operation's needs of the environment, the workloads, and your core SAP platform to evaluate the right level of investments required at each level. This is in alignment to the **Modern Cloud Service Management**.

## Baseline operations

When adopting SAP in Azure, your operation's baseline will not likely change. The assets that run your SAP platform and workloads, will be included in the standard processes and tools to create visibility, optimize operations, and recover.

> [!NOTE]
> If operation's baseline are unchanged, you might still need additional processes and tools as part of your SAP specific platform operations deployment.

## Platform operations

Given the mission critical nature of your SAP platform, most organizations support a dedicated operations staff responsible for the operational management of the core SAP platform.

The core platform team, referred as **SAP Basis Operations**, is either staffed in-house or provided by a service provider, and is familiar with:

- The configuration of your SAP landing zone
- The operations baseline provided to all Azure resources
- Any shared services made available through the configuration of the broader Azure platform configuration decisions.

Those data points will aid this team to determine the levels of platform operations that must be added to meet operational requirements.

> [!NOTE]
> If your organization has a centralized SAP platform team, consider tooling to enhance operations of the core platform using an [enterprise-scale scenario for SAP](./enterprise-scale-landing-zone.md) for elevated management and BCDR scenarios that can improve operations of the platform.

## Workload operations

Each workload that depends on the SAP platform is likely to have a material impact on business processes, with the downtime costs of each individual workload as unlikely to impact the business to the same degree as downtime for the core SAP platform. With less impact, there's likely to be a lower ROI when investing in the reliability and business continuity per workload.

> [!NOTE]
> If a workload requires dedicated, specialized operations, run the [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) and review the [Azure Well-Architected Framework](/azure/architecture/framework/) to understand how to optimize operations per workload.

## Next steps

Once the SAP migration is complete, the cloud adoption team can begin scenario-specific migration iterations. Otherwise, use these articles again, if there are additional SAP platforms to migrate.

> [!div class="nextstepaction"]
> [Strategy for SAP](./strategy.md)
> [Plan for SAP](./plan.md)
> [Review your environment or Azure landing zones](./ready.md)
> [Migrate SAP](./migrate.md)
> [Innovate with SAP](./innovate.md)
> [Manage SAP](./manage.md)
