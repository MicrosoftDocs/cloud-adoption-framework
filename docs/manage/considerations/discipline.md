---
title: "Management leveling across cloud management disciplines"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Management leveling across cloud management disciplines
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Management leveling across cloud management disciplines

The key to proper management in any environment is consistency and repeatable processes. There are endless of options for the things that can be done in Azure. Likewise, there are countless approaches to cloud management. To provide consistency and repeatability, it is important to narrow those options to a consistent set of management processes and tools that will be offered for workloads hosted in the cloud.

## Suggested management levels

Since the workloads in your IT portfolio are not all the same, it's unlikely that a single level of management will suffice for each workload. To support various workloads and various business commitments, it is suggested that the Cloud Operations team or Platform Operations team establish a few levels of operations management.

![Manage management levels and maturity in the Cloud Adoption Framework](../../_images/manage/cloud-management-maturity.png)

The following management levels (also pictured above) are a few suggested levels to serve as a starting point:

- **Management baseline**: A cloud management baseline (or management baseline) is the defined set of tools, processes, and consistent pricing that will serve as a the foundation for all cloud management in Azure. To establish a cloud management baseline, review the table in the following section and determine which tools will be included in the baseline offering to your business.
- **Enhanced baseline**: A number of workloads may require enhancements to the baseline that are not necessarily specific to a single platform or workload. While these enhancements are not cost effective for every workload, there should be common processes, tools, and solutions for any workload that can cost justify the extra management support.
- **Platform specialization**: In any given environment, there are common platforms which are used by multiple different workloads. This general architectural commonality doesn't change when businesses adopt the cloud. Platform specialization is an elevated level of management that leverages data and architectural subject matter expertise to provide a higher level of operational management. Examples of platform specialization would include management functions specific to SQL Server, Containers, Active Directory, or other services that can be better managed through consistent, repeatable processes, tools, and architectures.
- **Workload specialization**: For those workloads that are truly mission critical, there may be a cost justification to go much deeper into the management of that workload. Workload specialization leverages workload telemetry to determine more advance approaches to daily management. That same data often identifies automation, deployment, and design improvements that would lead to greater stability, reliability, and resiliency beyond what is possible with operational management alone.
- **Unsupported**: It is equally important to communicate common management processes that will not be delivered through cloud management disciplines for any workload that is classified as not supported or not critical.

The remaining articles in this series will outline a number of processes commonly found within each of these disciplines.
In parallel, the [Azure Management Guide](../azure-management-guide/index.md) demonstrates the tools which can support each of those processes. For assistance building your management baseline, start with the Azure Management Guide. Once the baseline is established, this article series and the accompanying best practices can help expand that baseline to define other levels of management support.

## Cloud management disciplines

Each of the suggested management levels may call on different cloud management disciplines. However, the mapping is designed to make it easier to find the suggested processes and tools to deliver on the appropriate level of cloud management.

In most cases, the "management baseline level" outlined above will consist of processes and tools from the following disciplines. In each case, a few processes and tools are highlighted to demonstrate "enhanced baseline functions".

- **Inventory and visibility**: At minimum, a management baseline should include a means of inventorying assets and creating visibility into the run state of each asset.
- **Operational compliance:** Regular management of configuration, sizing, cost, and performance of assets is key to maintaining performance expectations and a management baseline.
- **Protect and recover:** Minimizing operational interruptions and expediting recovery each help to avoid performance losses and revenue impacts. Detection and recovery are essential aspects of this discipline within any management baseline.

The platform specialization level of management pulls from the processes and tools aligned to the platform operations disciplines.
Likewise, the workload specialization level of management pulls from the processes and tools aligned to the workload operations disciplines.
  
## Next steps

The next step toward defining each level of cloud management is an understanding of [inventory and visibility](./inventory.md).

> [!div class="nextstepaction"]
> [Inventory and visibility options](./inventory.md)
