---
title: Protect and recover in cloud management
description: Learn the importance of preparing for a potential workload outage. This preparation allows your team to detect failures sooner and recover more quickly.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Protect and recover in cloud management

After they've met the requirements for [inventory and visibility](./inventory.md) and [operational compliance](./operational-compliance.md), cloud management teams can anticipate and prepare for a potential workload outage. As they're planning for cloud management, the teams must start with an assumption that something will fail.

No technical solution can consistently offer a 100 percent uptime SLA. Solutions with the most redundant architectures claim to deliver on "six 9s" or 99.9999 percent uptime. But even a "six 9s" solution goes down for 31.6 seconds in any given year. Sadly, it's rare for a solution to warrant a large, ongoing operational investment that's required to reach "six 9s" of uptime.

Preparation for an outage allows the team to detect failures sooner and recover more quickly. The focus of this discipline is on the steps that come immediately after a system fails. How do you protect workloads, so that they can be recovered quickly when an outage occurs?

## Translate protection and recovery conversations

The workloads that power business operations consist of applications, data, virtual machines (VMs), and other assets. Each of those assets might require a different approach to protection and recovery. The important aspect of this discipline is to establish a consistent commitment within the management baseline, which can provide a starting point during business discussions.

At a minimum, each asset that supports any given workload should have a baseline approach with a clear commitment to speed of recovery (recovery time objectives, or RTO) and risk of data loss (recovery point objectives, or RPO).

### Recovery time objectives (RTO)

When disaster strikes, a recovery time objective is the amount of time it should take to recovery any system to its state prior to the disaster. For each workload, that would include the time required to restore minimum necessary functionality for the VMs and applications. It also includes the amount of time required to restore the data that's required by the applications.

In business terms, RTO represents the amount of time that the business process will be out of service. For mission-critical workloads, this variable should be relatively low, allowing the business processes to resume quickly. For lower-priority workloads, a standard level of RTO might not have a noticeable impact on company performance.

The management baseline should establish a standard RTO for non-mission-critical workloads. The business can then use that baseline as a way to justify additional investments in recovery times.

### Recovery point objectives (RPO)

In most cloud management systems, data is periodically captured and stored through some form of data protection. The last time data was captured is referred to as a recovery point. When a system fails, it can be restored only to the most recent recovery point.

If a system has a recovery point objective that's measured in hours or days, a system failure would result in the loss of data for those hours or days between the last recovery point and the outage. A one-day RPO would theoretically result in the loss of all transactions in the day leading up to the failure.

For mission-critical systems, an RPO that's measured in minutes or seconds might be more appropriate to use to avoid a loss in revenue. But a shorter RPO generally results in an increase in overall management costs.

To help minimize costs, a management baseline should focus on the longest acceptable RPO. The cloud management team can then increase the RPO of specific platforms or workloads, which would warrant more investment.

## Protect and recover workloads

Most of the workloads in an IT environment support a specific business or technical process. Systems that don't have a systemic impact on business operations often don't warrant the increased investments required to recover quickly or minimize data loss. By establishing a baseline, the business can clearly understand what level of recovery support can be offered at a consistent, manageable price point. This understanding helps the business stakeholders evaluate the value of an increased investment in recovery.

For most cloud management teams, an enhanced baseline with specific RPO/RTO commitments for various assets yields the most favorable path to mutual business commitments. The following sections outline a few common enhanced baselines that empower the business to easily add protection and recovery functionality through a repeatable process.

### Protect and recover data

Data is arguably the most valuable asset in the digital economy. The ability to protect and recover data more effectively is the most common enhanced baseline. For the data that powers a production workload, loss of data can be directly equated to loss in revenue or loss of profitability. We generally encourage cloud management teams to offer a level of enhanced management baseline that supports common data platforms.

Before cloud management teams implement platform operations, it's common for them to support improved operations for a platform as a service (PaaS) data platform. For instance, it's easy for a cloud management team to enforce a higher frequency of backup or multiregion replication for Azure SQL Database or Azure Cosmos DB solutions. Doing so allows the development team to easily improve RPO by modernizing their data platforms.

To learn more about this thought process, see [Platform operations discipline](./platform.md).

### Protect and recover VMs

Most workloads have some dependency on virtual machines, which host various aspects of the solution. For the workload to support a business process after a system failure, some virtual machines must be recovered quickly.

Every minute of downtime on those virtual machines could cause lost revenue or reduced profitability. When VM downtime has a direct impact on the fiscal performance of the business, RTO is very important. Virtual machines can be recovered more quickly by using replication to a secondary site and automated recovery, a model that's referred to as a hot-warm recovery model. At the highest state of recovery, virtual machines can be replicated to a fully functional, secondary site. This more expensive approach is referred to as a high-availability, or hot-hot, recovery model.

Each of the preceding models reduces the RTO, resulting in a faster restoration of business process capabilities. However, each model also results in significantly increased cloud management costs.

Also note that, apart from replication for high-availability, backup should be enabled for scenarios such as accidental delete, data corruption and ransomware attacks.

For more information about this thought process, see [Workload operations discipline](./workload.md).

## Next steps

After this management baseline component is met, the team can look ahead to avoid outages in its [platform operations](./platform.md) and [workload operations](./workload.md).

> [!div class="nextstepaction"]
> [Platform operations](./platform.md)
> [Workload operations](./workload.md)
