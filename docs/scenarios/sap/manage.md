---
title: Manage SAP in Azure
description: Operations management considerations when managing SAP on Azure
author: JefferyMitchell
ms.author: jemitche
ms.date: 07/01/2010
ms.topic: concept-article
ms.custom: think-tank, e2e-sap
---

# Manage SAP in Azure

Your long-term operations management strategy strongly affects your SAP migration and Azure landing zone requirements.

To understand your operations management requirements in Azure, focus on later-stage SAP management guidance. Use this guidance to shape your vision.

To better align your business, treat the SAP platform and its dependent workloads as *mission-critical* technology assets. These assets often require investments beyond your standard operations baseline to support the SAP platform and its dependent workloads.

Most organizations require a mix of platform operations, **SAP Basis operations**, and workload operations. SAP Basis operations manage the core technical foundation of SAP systems.

- **Environments**: Identify non-production SAP environments, such as development or quality assurance (QA). These environments usually require fewer specialized operations.
- **Workloads**: Identify workloads that interact with and extend the core SAP platform. A basic operations baseline usually provides a sufficient service-level agreement (SLA) for these workloads.

   > [!NOTE]
   > When a higher level of operations is required, consider workload operations on a case-by-case basis.

During business alignment, separate the operational needs of environments, workloads, and the core SAP platform. Use this separation to evaluate the right investment level for each area. This approach aligns with **Modern Cloud Service Management**, a model that emphasizes standardized, scalable cloud operations.

## Baseline operations

When you adopt SAP in Azure, your operations baseline likely remains the same. The assets that run your SAP platform and workloads remain part of standard processes and tools. These processes create visibility, optimize operations, and support recovery.

> [!NOTE]
> If the operations baseline is unchanged, you might still need additional processes and tools as part of your SAP specific platform operations deployment.

## Platform operations

Because the SAP platform is mission critical, most organizations use a dedicated operations team. This team manages the core SAP platform.

Organizations staff the core platform team, called **SAP Basis operations**, either in-house or through a service provider. This team understands the following areas:

- The configuration of your SAP landing zone
- The operations baseline provided to all Azure resources
- Any shared services that result from broader Azure platform configuration decisions.

These data points help the team determine which platform operations they must add to meet requirements.

> [!NOTE]
> If your organization has a centralized SAP platform team, consider tools that enhance core platform operations. Use an [enterprise-scale scenario for SAP](./enterprise-scale-landing-zone.md) to support advanced management and business continuity and disaster recovery (BCDR).

## Workload operations

Each workload that depends on SAP affects business processes. However, downtime for individual workloads usually costs less than downtime for the core SAP platform. Because these workloads have less impact, the return on investment (ROI) for reliability and business continuity is usually lower for each workload.

> [!NOTE]
> If a workload requires dedicated, specialized operations, run the [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) and review the [Azure Well-Architected Framework](/azure/architecture/framework/) to understand how to optimize operations per workload.

## Next steps

After the SAP migration finishes, the cloud adoption team can start scenario-specific migration iterations. Reuse these articles if you need to migrate additional SAP platforms.

> [!div class="nextstepaction"]
> [Strategy for SAP](./strategy.md)
> [Plan for SAP](./plan.md)
> [Review your environment or Azure landing zones](./ready.md)
> [Migrate SAP](./migrate.md)
> [Innovate with SAP](./innovate.md)
> [Manage SAP](./manage.md)