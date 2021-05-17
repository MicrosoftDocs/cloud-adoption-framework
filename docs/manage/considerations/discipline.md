---
title: Management levels in cloud management
description: Learn how to narrow cloud management options to a consistent set of processes and tools that you can offer for workloads hosted in the cloud.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Cloud management disciplines

The keys to proper management in any environment are consistency and repeatable processes. There are endless of options for the things that can be done in Azure. Likewise, there are countless approaches to cloud management. To provide consistency and repeatability, it's important to narrow those options to a consistent set of management processes and tools that will be offered for workloads hosted in the cloud.

## Suggested management levels

Because the workloads in your IT portfolio vary, it's unlikely that a single level of management will suffice for each workload. To help you support a variety of workloads and business commitments, we suggest that your cloud operations team or platform operations team establish a few levels of operations management.

![Manage management levels and maturity in the Cloud Adoption Framework](../../_images/manage/cloud-management-maturity.png)

As a starting point, consider establishing the management levels that are shown in the preceding diagram and suggested in the following list:

- **Management baseline:** A cloud management baseline (or management baseline) is a defined set of tools, processes, and consistent pricing that serve as the foundation for all cloud management in Azure. To establish a cloud management baseline and determine which tools to include in the baseline offering to your business, review the list in the "cloud management disciplines" section.
- **Enhanced baseline:** Some workloads might require enhancements to the baseline that aren't necessarily specific to a single platform or workload. Although these enhancements aren't cost effective for every workload, there should be common processes, tools, and solutions for any workload that can justify the cost of the extra management support.
- **Platform specialization:** In any given environment, some common platforms are used by a variety of workloads. This general architectural commonality doesn't change when businesses adopt the cloud. Platform specialization is an elevated level of management that applies data and architectural subject matter expertise to provide a higher level of operational management. Examples of platform specialization would include management functions specific to SQL Server, containers, Active Directory, or other services that can be better managed through consistent, repeatable processes, tools, and architectures.
- **Workload specialization:** For workloads that are truly mission critical, there might be a cost justification to go much deeper into the management of that workload. Workload specialization applies workload telemetry to determine more advanced approaches to daily management. That same data often identifies automation, deployment, and design improvements that would lead to greater stability, reliability, and resiliency beyond what's possible with operational management alone.

Organizations might also choose to [outsource functions related to one or more of these management levels to a service provider](https://aka.ms/adopt/partneroffers). These service providers can use [Azure Lighthouse](/azure/lighthouse/overview) to provide greater precision and transparency.

The remaining articles in this series outline processes that are commonly found within each of these disciplines. In parallel, the [Azure Management Guide](../azure-management-guide/index.md) demonstrates the tools that can support each of those processes. For assistance with building your management baseline, start with the Azure Management Guide. After you've established the baseline, this article series and the accompanying best practices can help expand that baseline to define other levels of management support.

## Operations management discipline

Each suggested management level provides necessary operations management for all assets (apps, data, & infra) in the portfolio, with an increasing degree of specificity. This mapping is designed to make it easier for the relevant roles to find the most appropriate processes and tools to deliver on the required level of cloud management.

The [operations management processes](../operational-fitness-review.md) defines the iterative discipline required to deliver operations and meet business commitments. This iterative process delivers on three levels of operations on a recurring rhythm of business:

- **Operations baseline (or enhanced baseline):** Consistent operations management of all deployed assets. Centralized technology teams focus on portfolio health and implements broad sweeping changes.
- **Platform operations:** Elevated operations for mission critical technology platforms. Centralized teams focus on operational fitness of shared platforms.
- **Workload operations:** Workload operations for refined changes to defined workloads. Workload specific teams deliver architecture change based on the pillars of [Azure Well-Architected Framework](/azure/architecture/framework/) to improve operations through more granular improvements.

The [operations management processes](../operational-fitness-review.md) unite all three elevations of operations management in a holistic solution to improve operational fitness of all deployed assets regardless of the chosen operating model.

## Next steps

The next step toward defining each level of cloud management is an understanding of [inventory and visibility](./inventory.md).

> [!div class="nextstepaction"]
> [Inventory and visibility options](./inventory.md)
