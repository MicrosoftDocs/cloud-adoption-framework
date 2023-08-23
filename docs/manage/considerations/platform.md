---
title: Platform operations in cloud management
description: Learn how to build an understanding of the dependency within your organization for common platform operations in cloud management.
author: martinekuan
ms.author: martinek
ms.date: 10/17/2019
ms.topic: conceptual
ms.custom: internal
---

# Platform operations in cloud management

A cloud management baseline that spans [inventory and visibility](./inventory.md), [operational compliance](./operational-compliance.md), and [protection and recovery](./protect.md) might provide a sufficient level of cloud management for most workloads in the IT portfolio. But that baseline is seldom enough to support the full portfolio. This article builds on the most common next step in cloud management, portfolio operations.

A quick study of the assets in the IT portfolio highlights existing patterns across the supported workloads. Within those workloads, there are common platforms. The platforms could vary widely depending on the past technical decisions within the company.

For some organizations, there's a heavy dependence on SQL Server, Oracle, or other open-source data platforms. In other organizations, the commonalities might be rooted in the hosting platforms for virtual machines (VMs) or containers. Still others might have a common dependency on applications or enterprise resource planning (ERP) systems such as SAP or Oracle.

When you understand these commonalities, your cloud management team can specialize in higher levels of support for those prioritized platforms.

## Establish a service catalog

The objective of platform operations is to create reliable and repeatable solutions for a cloud adoption team to use. The cloud adoption team can then deliver a platform that provides a higher level of business commitment. That commitment could decrease the likelihood or frequency of downtime, which improves reliability. If there's a system failure, the commitment can also help decrease the amount of data loss or time to recovery. Such a commitment often includes ongoing, centralized operations to support the platform.

As the cloud management team establishes higher degrees of operational management and specialization related to specific platforms, they add platforms to a growing service catalog. The service catalog provides self-service platform deployment in a specific configuration, which adheres to ongoing platform operations. During the business-alignment conversation, cloud management and cloud strategy teams can propose service catalog solutions for the business. The service catalog solutions improve reliability, uptime, and recovery commitments in a controlled, repeatable process.

For reference, some organizations refer to an early-stage service catalog as an *approved list*. The primary difference is that a service catalog comes with ongoing operational commitments from the cloud center of excellence (CCoE). An approved list is similar. It provides a preapproved list of solutions that a team can use in the cloud. But typically there isn't an operational benefit associated with applications on an approved list.

Much like the debate between centralized IT and CCoE, the difference is one of priorities. A service catalog assumes good intent but provides operational, governance, and security guardrails that accelerate innovation. An approved list hinders innovation until operations, compliance, and security gates are passed for a solution. Both solutions are viable, but they require the company to make subtle prioritization decisions to invest more in innovation or compliance.

### Build the service catalog

Cloud management is seldom successful at delivering a service catalog in a silo. Proper development of the catalog requires a partnership across the central IT team or the CCoE. This approach tends to be most successful when an IT organization reaches a CCoE level of maturity, but it could be implemented sooner.

When the cloud platform team builds the service catalog within a CCoE model, they build out the desired-state platform. The cloud governance and cloud security teams validate governance and compliance within the deployment. The cloud management team establishes ongoing operations for that platform. And the cloud automation team packages the platform for scalable, repeatable deployment.

After the platform is packaged, the cloud management team can add it to the growing service catalog. From there, the cloud adoption team uses the package or others in the catalog during deployment. After the solution goes to production, the business realizes the extra benefits of improved operational management and potentially reduced business disruptions.

> [!NOTE]
> Building a service catalog requires a great deal of effort and time from multiple teams. Using the service catalog or approved list as a gating mechanism slows innovation. When innovation is a priority, develop service catalogs in parallel to other adoption efforts.

## Define your own platform operations

Although management tools and processes can improve platform operations, it's often not enough to achieve the desired states of stability and reliability. True platform operations require a focus on pillars of architecture excellence. When a platform justifies a deeper investment in operations, consider the following five pillars before the platform becomes a part of any service catalog:

- **Reliability:** Design systems to recover from failures and continue to function.
- **Security:** Protect applications and data from threats.
- **Cost optimization:** Manage costs to maximize the value delivered.
- **Operational excellence:** Follow operational processes that keep a system running in production.
- **Performance efficiency:** Scale systems to adapt to changes in load.

The [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) provides an approach to evaluating specific workloads for adherence to these pillars, to improve overall operations. You can apply these pillars to both platform operations and workload operations.

## Get started with specific platforms

The platforms discussed in the next sections are common to typical Azure customers, and they can easily justify an investment in platform operations. Cloud management teams tend to start with them when they're building out platform operations requirements or a full service catalog.

### PaaS data operations

Data is often the first platform to warrant platform operations investments. When data is hosted in a platform as a service (PaaS) environment, business stakeholders tend to request a reduced recovery point objective (RPO) to minimize data loss. Depending on the nature of the application, they might also request a reduction in recovery time objective (RTO). In either case, the architecture that supports PaaS-based data solutions can easily accommodate some increased level of management support.

In most scenarios, the cost of improving management commitments is easily justified, even for applications that aren't mission critical. This platform operations improvement is so common that many cloud management teams see it more as an enhanced baseline, rather than as a true platform operations improvement.

### IaaS data operations

When data is hosted in a traditional infrastructure as a service (IaaS) solution, the effort to improve RPO and RTO can be higher. Yet the business stakeholders' desire to achieve better management commitments is seldom affected by a PaaS versus IaaS decision. If anything, an understanding of the fundamental differences in architecture might prompt the business to ask for PaaS solutions or commitments that match what's available on PaaS solutions. Consider modernization of any IaaS data platforms as a first step into platform operations.

When modernization isn't an option, cloud management teams commonly prioritize IaaS-based data platforms as a first required service in the service catalog. Providing the business with a choice between standalone data servers and clustered, high-availability, data solutions makes the business commitment conversation much easier to facilitate. A basic understanding of the operational improvements and increased costs helps the business make the best decision for its business processes and supporting workloads.

### Other common platform operations

In addition to data platforms, virtual machine hosts tend to be a common platform for operations improvements. Cloud platform and cloud management teams most commonly invest in improvements to VMware hosts or container solutions. Such investments can improve the stability and reliability of the hosts, which support the VMs, which in turn power the workloads. Proper operations on one host or container can improve the RPO or RTO of several workloads. This approach creates improved business commitments but distributes the investment. Improved commitments and reduced costs combine to make it much easier to justify improvements to cloud management and platform operations.

## Next steps

In parallel with improvements to platform operations, cloud management teams also focus on improving [workload operations](./workload.md) for the top 20 percent or less of production workloads.

> [!div class="nextstepaction"]
> [Improve workload operations](./workload.md)
