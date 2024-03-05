---
title: Migration release checklist
description: Use the Cloud Adoption Framework for Azure to prepare your migrated workload and assets to be promoted to production.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/22/2024
ms.topic: conceptual
---

# Migration release checklist

After a collection of workloads and their supporting assets have been deployed to the cloud, it must be prepared before it can be released. In this phase of the migration effort, the collection of workloads are load tested and validated with the business. They're then optimized and documented. Once the business and IT teams have reviewed and signed off on workload deployments, those workloads can be released or handed off to governance, security, and operations teams for ongoing operations.

>
> TODO: Redefine the release overview and activities.
>

## Responsibilities

The following are a few activities that require assignments to responsible parties:

- **Business testing.** Resolve any compatibility issues that prevent the workload from completing its migration to the cloud.
- **Business change plan.** Development of a plan for user adoption, changes to business processes, and modification to business KPIs or learning metrics as a result of the migration effort.
- **Ready for production.** Prepare the workload and environment for the support of the workload's ongoing production usage.
- **Promote.** Redirect production traffic to the migrated and optimized workload. This activity represents the completion of a release cycle.

In addition to core activities, there are a few parallel activities that require specific assignments and execution plans:

- **Decommission.** Generally, cost savings can be realized from a migration, when the previous production assets are decommissioned and properly disposed of.
- **Retrospective.** Every release creates an opportunity for deeper learning and adoption of a growth mindset. When each release cycle is completed, the cloud adoption team should evaluate the processes used during migration to identify improvements.

## Optimization

Releasing workloads often come with opportunities to optimize the environment. This optimization can include resizing assets, implementing cost management, and ensuring that the environment is properly configured for ongoing operations.

- **Right-size assets**. Review the usage metrics for the services and right-size them to match the workload requirements. Use Azure Advisor recommendations.
  - [Manage reservations for Azure resources](/azure/cost-management-billing/reservations/manage-reserved-vm-instance).
  - [Resize a VM](/azure/virtual-machines/resize-vm)
  - [Azure VM sizing for maximum reservation usage](/partner-center/azure-usage)
- **Cost management**. Implement cost management and billing to monitor and manage the costs of the environment.
  - Use Azure Cost Management + Billing.
  - Use Azure Advisor to identify potential cost savings.
  - Use the [Build business case](/azure/migrate/how-to-build-a-business-case) feature of Azure Migrate can help you quickly shape and justify a use case for migration, including cost-specific angles, such as:
    - A view of on-premises vs. Azure total cost of ownership (TCO)
    - Understand long-term cost savings when moving from a capital expenditure model (CAPEX) to an Operating expenditure model (OPEX) by paying only for what you use.
    - Strengthen your cost planning process and add data insights-driven calculations.

## Next steps

With a general understanding of the optimization process, you're ready to begin communicating the changes.

> [!div class="nextstepaction"]
> [Change communication](./change-communication.md)
