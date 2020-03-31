---
title: "Platform operations in cloud management"
description: Build an understanding of the dependency within your organization for common platform operations in cloud management.  
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Platform operations in cloud management

A cloud management baseline that spans [inventory and visibility](./inventory.md), [operational compliance](./operational-compliance.md), and [protection and recovery](./protect.md) might provide a sufficient level of cloud management for most workloads in the IT portfolio. However, that baseline is seldom enough to support the full portfolio. This article builds on the most common next step in cloud management, portfolio operations.

A quick study of the assets in the IT portfolio highlights patterns across the workloads that are being supported. Within those workloads, there will be a number of common platforms. Depending on the past technical decisions within the company, those platforms could vary widely.

For some organizations, there will be a heavy dependence on SQL Server, Oracle, or other open-source data platforms. In other organizations, the commonalities might be rooted in the hosting platforms for virtual machines (VMs) or containers. Still others might have a common dependency on applications or Enterprise Resource Planning (ERP) systems, such as SAP, Oracle, or others.

By understanding these commonalities, the cloud management team can specialize in higher levels of support for those prioritized platforms.

## Establish a service catalog

The objective of platform operations is to create reliable and repeatable solutions, which the cloud adoption team can use to deliver a platform that provides a higher level of business commitment. That commitment could decrease the likelihood or frequency of downtime, which improves reliability. In the event of a system failure, the commitment could also help decrease the amount of data loss or time to recovery. Such a commitment often includes ongoing, centralized operations to support the platform.

As the cloud management team establishes higher degrees of operational management and specialization related to specific platforms, those platforms are added to a growing service catalog. The service catalog provides self-service deployment of platforms in a specific configuration, which adheres to ongoing platform operations. During the business-alignment conversation, cloud management and cloud strategy teams can propose service catalog solutions as a way for the business to improve reliability, uptime, and recovery commitments in a controlled, repeatable process.

For reference, some organizations refer to an early-stage service catalog as an _approved list_. The primary difference is that a service catalog comes with ongoing operational commitments from the cloud center of excellence (CCoE). An approved list is similar, in that it provides a preapproved list of solutions that a team can use in the cloud. However, typically there isn't an operational benefit associated with applications on an approved list.

Much like the debate between Central IT and CCoE, the difference is one of priorities. A service catalog assumes good intent but provides operational, governance, and security guardrails that accelerate innovation. An approved list hinders innovation until operations, compliance, and security gates can be passed for a solution. Both solutions are viable, but they require the company to make subtle prioritization decisions to invest more in innovation or compliance.

### Build the service catalog

Cloud management is seldom successful at delivering a service catalog in a silo. Proper development of the catalog requires a partnership across Central IT or the CCoE. This approach tends to be most successful when an IT organization reaches a CCoE level of maturity, but could be implemented sooner.

When it's building the service catalog within a CCoE model, the cloud platform team builds out the desired-state platform. The cloud governance and cloud security teams validate governance and compliance within the deployment. The cloud management team establishes ongoing operations for that platform. And the cloud automation team packages the platform for scalable, repeatable deployment.

After the platform is packaged, the cloud management team can add it to the growing service catalog. From there, the cloud adoption team can use the package or others in the catalog during deployment. After the solution goes to production, the business realizes the extra benefits of improved operational management and potentially reduced business disruptions.

> [!NOTE]
> Building a service catalog requires a great deal of effort and time from multiple teams. Using the service catalog or approved list as a gating mechanism will slow innovation. When innovation is a priority, service catalogs should be developed parallel to other adoption efforts.

## Define your own platform operations

Although management tools and processes can help improve platform operations, that is often not enough to achieve the desired states of stability and reliability. True platform operations requires a focus on architecture-quality pillars. When a platform justifies a deeper investment in operations, the following five pillars should be considered before the platform becomes a part of any service catalog:

- **Scalability:** The ability of a system to handle increased load.
- **Availability:** The percentage of time that a system is functional and working.
- **Resiliency:** The ability of a system to recover from failures and continue to function.
- **Management:** The operations processes that keep a system running in production.
- **Security:** Protecting applications and data from threats.

The [Azure Architecture Framework](https://docs.microsoft.com/azure/architecture/guide/pillars) provides an approach to evaluating specific workloads for adherence to these pillars, in an effort to improve overall operations. These pillars can be applied to both platform operations and workload operations.

## Get started with specific platforms

The platforms discussed in the next sections are common to typical Azure customers, and they can easily justify an investment in platform operations. Cloud management teams tend to start with them when they're building out platform operations requirements or a full service catalog.

### PaaS data operations

Data is often the first platform to warrant platform operations investments. When data is hosted in a platform as a service (PaaS) environment, business stakeholders tend to request a reduced recovery point objective (RPO) to minimize data loss. Depending on the nature of the application, they might also request a reduction in recovery time objective (RTO). In either case, the architecture that supports PaaS-based data solutions can easily accommodate some increased level of management support.

In most scenarios, the cost of improving management commitments is easily justified, even for applications that are not mission critical. This platform operations improvement is so common that many cloud management teams see it more as an enhanced baseline, rather than as a true platform operations improvement.

### IaaS data operations

When data is hosted in a traditional infrastructure as a service (IaaS) solution, the effort to improve RPO and RTO can be significantly higher. Yet the business stakeholders' desire to achieve better management commitments is seldom affected by a PaaS versus IaaS decision. If anything, an understanding of the fundamental differences in architecture might prompt the business to ask for PaaS solutions or commitments that match what's available on PaaS solutions. Modernization of any IaaS data platforms should be considered as a first step into platform operations.

When modernization isn't an option, cloud management teams commonly prioritize IaaS-based data platforms as a first required service in the service catalog. Providing the business with a choice between standalone data servers and clustered, high-availability, data solutions makes the business commitment conversation much easier to facilitate. A basic understanding of the operational improvements and the increased costs will arm the business to make the best decision for the business processes and supporting workloads.

### Other common platform operations

In addition to data platforms, virtual machine hosts tend to be a common platform for operations improvements. Most commonly, cloud platform and cloud management teams invest in improvements to VMware hosts or container solutions. Such investments can improve the stability and reliability of the hosts, which support the VMs, which in turn power the workloads. Proper operations on one host or container can improve the RPO or RTO of several workloads. This approach creates improved business commitments, but distributes the investment. Improved commitments and reduced costs combine to make it much easier to justify improvements to cloud management and platform operations.

## Next steps

In parallel with improvements to platform operations, cloud management teams also focus on improving [workload operations](./workload.md) for the top 20 percent or less of production workloads.

> [!div class="nextstepaction"]
> [Improve workload operations](./workload.md)
