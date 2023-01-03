---
title: Protect and recover in cloud management
description: Learn the importance of preparing for a potential workload outage. This preparation allows your team to detect failures sooner and recover more quickly.
author: martinekuan
ms.author: martinek
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Protect and recover in cloud management

Prior to preparing for a potential workload outage, cloud management teams should first make sure they've met requirements for

- [inventory and visibility](./inventory.md) 
- [operational compliance](./operational-compliance.md)

As they plan, the teams must start with an assumption that something will fail when disaster strikes. Preparation for an outage allows the teams to detect failures sooner and recover more quickly. The focus of this discipline is on the steps that come immediately after a system fails. How do you protect workloads so that they can be recovered quickly when an outage occurs?

No technical solution can consistently offer an SLA that guarantees 100 percent uptime. Solutions with the most redundant architectures claim to deliver on "six 9s" or 99.9999 percent uptime. But even a "six 9s" solution goes down for 31.6 seconds in any given year. It's rare for a solution to warrant a large, ongoing operational investment that's required to reach "six 9s" of uptime.

## Translate protection and recovery conversations

The workloads that power business operations consist of

- applications
- data
- virtual machines (VMs)
- other assets

Each asset might require its own approach to protection and recovery. The important goal of this discipline is to establish a consistent commitment within the management baseline, which can provide a starting point for business discussions.

At a minimum, cloud management teams should create a baseline approach for each asset, with a clear commitment to quick recovery and minimal data loss. 

### Recovery time objectives (RTO)

A recovery time objective is the amount of time it should take to recover any system to its state prior to a disaster. This would include the time needed to

- restore minimal functionality to VMs and applications
- restore data required by applications.

In business terms, RTO represents the amount of time that business processes are out of service. For mission-critical workloads, this variable should be relatively low, allowing business processes to resume quickly. For lower-priority workloads, a standard level of RTO might not have a noticeable impact on company performance.

A business should create a management baseline that establishes a standard RTO for non-mission-critical workloads. The business can then use that baseline as a way to justify additional investments in recovery times.

### Recovery point objectives (RPO)

In most cloud management systems, some form of data protection periodically captures and stores data. The recovery point refers to the last time the data was captured. When a system fails, it can be restored only to the most recent recovery point.

The recovery point objective is measured from the most recent recovery point to an outage. If the RPO is measured in hours, a system failure results in the loss of data for the hours between the last recovery point and the outage. If the RPO is measured in days, a system failure results in the loss of data for the days between the last recovery point and the outage. A one-day RPO would theoretically result in the loss of all transactions in the day leading up to the failure.

For mission-critical systems, measuring an RPO in minutes or seconds might help avoid loss in revenue or profits. However, a shorter RPO generally results in increased management costs. To help minimize these costs, a business should create a management baseline that focuses on the longest acceptable RPO. The business can then decrease the RPO of the specific platforms or workloads that warrant more investment.

## Protect and recover workloads

Most of the workloads in an IT environment support a specific business or technical process. Systems that don't have a systemic impact on business operations usually don't warrant the increased investment required to recover systems quickly or minimize data loss. By establishing a baseline, a business can figure out what level of recovery support they need at a price point they can consistently manage. Understanding this helps business stakeholders evaluate the value of increased investment in recovery.

For most cloud management teams, an enhanced baseline, with specific RPO/RTO commitments for various assets, yields the most favorable path to mutual business commitments. The following sections outline a few common enhanced baselines that empower a business to easily add protection and recovery functionality through a repeatable process.

### Protect and recover data

Data is arguably the most valuable asset in the digital economy. Loss of the data that powers a production workload leads to loss in revenue or profits. The most common enhanced baseline is the ability to protect and recover data effectively. We encourage cloud management teams to offer a level of enhanced management baseline that supports common data platforms.

Before cloud management teams implement platform operations, it's common for them to support improved operations for a platform as a service (PaaS) data platform. For instance, it's easy for a cloud management team to enforce a higher frequency of backup or multiregional replication for Azure SQL Database or Azure Cosmos DB solutions. Doing so allows the development team to easily improve RPO by modernizing their data platforms.

To learn more about this thought process, see [Platform operations discipline](./platform.md).

### Protect and recover VMs

Most workloads somewhat depend on virtual machines, which host various aspects of the solution. A business must recover some virtual machines quickly for the workload to support its processes after a system failure.

Every minute of downtime on those virtual machines could cause lost revenue or reduced profits. When VM downtime has a direct impact on the fiscal performance of the business, RTO is very important. Cloud management teams can recover virtual machines quickly by replicating them to a secondary site and using automated recovery, a model that's referred to as a hot-warm recovery model. The teams can also replicate virtual machines to a functional, secondary site in an approach known as a hot-hot, or high-availability model. The hot-hot approach is more expensive, but it offers the highest state of recovery.

Each of these models reduces the RTO, which helps businesses restore their business capabilities faster. However, each model also results in significantly increased cloud management costs.

Also note that, apart from replication for high-availability, backup should be enabled for scenarios such as 

- accidental delete
- data corruption
- ransomware attacks

For more information about this thought process, see [Workload operations discipline](./workload.md).

## Next steps

After this management baseline component is met, the team can look ahead to avoid outages in its [platform operations](./platform.md) and [workload operations](./workload.md).

> [!div class="nextstepaction"]
> [Platform operations](./platform.md)
> [Workload operations](./workload.md)
