---
title: "Protect and recover - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Protect and recover - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Protect and recover in cloud management

Once requirements for [inventory and visibility](./inventory.md) and [operational compliance](./operational-compliance.md) have been met, cloud management teams can look forward and prepare for the potential of an outage of a workload. When planning for cloud management, the team must start with an assumption that something will fail.

No technical solution can consistently offer a 100% uptime SLA. Solutions with the most redundant architectures claim to deliver on "six 9s" or 99.9999% uptime. But even a "six 9s" solution goes down for 31.6 seconds in any given year. Sadly, seldom solutions warrant the large, ongoing operational investment required to reach "six 9s" of uptime.

Preparation for an outage will allow the team to detect failures sooner and recover more quickly. The focus of this discipline is on the next steps that come after a system fails. How do you protect workloads, so that they can be recovered quickly when an outage occurs.

## Translating protection and recovery conversations

The workloads which power business operations consist of applications, data, virtual machines, and other assets. Each of those assets may require a different approach to protection and recovery. The important aspect of this discipline is to establish a consistent commitment within the management baseline, to provide a starting point during business discussions.

At a minimum, every asset supporting any given workload should have a baseline approach with a clear commitment for speed of recovery (recovery time objectives or RTO) and risk of data loss (recovery point objectives or RPO).

### Recovery time objectives (RTO)

When disaster strikes, RTO is the amount of time it should take to recovery any given system to its pre-disaster state. For each workload, that would include the time required to restore minimum necessary functionality for the VMs and apps. It also includes the amount of time required to restore data required by the applications.

In business terms, RTO represents the amount of time that the business process will be out of service. For mission critical workloads, this variable should be relatively low, allowing the business processes to resume quickly. For lower priority workloads, a standard level of RTO may not have a noticeable impact on company performance.

The management baseline should establish a standard recovery time objective for non-mission-critical workloads. The business can then use that baseline as a way to justify additional investments in recovery times.

### Recovery point objectives (RPO)

In most cloud management systems, data is periodically captured and stored through some form of data protection. The last time data was captured is referred to as a recovery point. When a system fails, it can only be restored to the most recent recovery point.

If a system has a recovery point objective measured in hours or days, a system failure would result in the loss of data for those hours or days between the last recovery point and the outage. An RPO of 1 day would theoretically result in the loss of all transactions in the day leading up to the failure.

For mission critical systems, an RPO measured in minutes or seconds might be more appropriate to avoid a loss in revenue. But, a shorter RPO generally results in an increase in overall management costs.

A management baseline should focus on the longest acceptable RPO to minimize costs. The cloud management team can then increase the RPO of specific platforms or workloads, which would warrant more investment.

## Protect and recover workloads

Most of the workloads in an IT environment support a very small business or technical process. Systems that don't have a systemic impact on business operations often don't warrant the increased investments required to recovery quickly or minimize data loss. Establishing a baseline allows the business to clearly understand what level of recovery support can be offered at a consistent, manageable price point. This helps the business stakeholders evaluate the value of an increased investment in recovery.

For most cloud management teams, an enhanced baseline with specific RPO/RTO commitments for various assets, yields the most favorable path to mutual business commitments. The following sections outline a few common enhanced baselines that empower the business to easily add protection and recovery functionality through a repeatable process.

### Protect and recover data

Data is arguably the most valuable asset in the digital economy. The ability to protect and recover data more effectively is the most common enhanced baseline. For the data that powers a production workload, loss of data can be directly equated to loss in revenue or loss of profitability. It is generally encouraged that cloud management teams offer a level of enhanced management baseline that supports common data platforms.

Before implementing platform operations, it's common for cloud management teams to support improved operations for platform as a service data platform. For instance, it's easy for a cloud management team to enforce a higher frequency of backup or multi-region replication for Azure SQL or Cosmo DB solutions. Doing so, allows the development team to easily improve RPO by simply modernizing their data platforms.

This thought process will be revisited in more detail, in the [platform operations discipline](./platform.md).

### Protect and recover VMs

Most workloads have some dependency on virtual machines. Those virtual machines host various aspects of the solution. For the workload to support a business process after a system failure, a number of those virtual machines must be recovered quickly.

Every minute of downtime on those virtual machines could equate to lost revenue or reduced profitability. When downtime on VMs has a direct impact on the fiscal performance of the business, RTO is very important. Virtual machines can be recovered more quickly using replication to a secondary site and automated recovery, this model is referred to as a hot-warm recovery model. At the highest state of recovery, virtual machines can be replicated to a fully functional, secondary site. This more expensive approach is referred to as a high-availability, or hot-hot recovery model.

Each of the above models reduces the recovery time objective, resulting in a faster restoration of business process capabilities. However, each model also results in significantly increased cloud management costs.

This thought process will be revisited in more detail, in the [workload operations discipline](./workload.md).

## Next steps

Once this management baseline component is met, the team can look further ahead to avoid outages with [platform operations](./platform.md) and [workload operations](./workload.md).

> [!div class="nextstepaction"]
> [Platform Operations](./platform.md)
> [Workload Operations](./workload.md)
