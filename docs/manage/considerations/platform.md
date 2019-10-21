---
title: "Platform operations - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Platform operations - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Platform operations in cloud management

A cloud management baseline spanning [inventory and visibility](./inventory.md), [operational compliance](./operational-compliance.md), and [protection and recovery](./protect.md) may provide a sufficient level of cloud management for most workloads in the IT portfolio. However, that is seldom enough to support the full portfolio. This article builds on the most common next step in cloud management, portfolio operations.

A quick study of the assets in the IT portfolio will highlight patterns across the workloads being supported. Within those workloads, there will be a number of common platforms. Depending on the past technical decisions within the company, those platforms could be widely different. For some organizations, there will be a heavy dependence on SQL server, Oracle, or other open-source data platforms. In other organizations, the commonalities may be rooted in the hosting platforms for virtual machines or containers. Still others may have a common dependency on applications or Enterprise Resource Planning (ERP) systems like SAP, Oracle, or others.

Understanding these commonalities allows the cloud management team to specialize in higher levels of support for those prioritized platforms.

## Establish a service catalog

The objective of platform operations is to create reliable and repeatable solutions that can be leveraged by a cloud adoption team to deliver a platform, which provides a higher level of business commitment. That commitment could decrease the likelihood or frequency of downtime, improving reliability. The commitment could also decrease the amount of data loss or time to recovery, in case of a system failure. That commitment often includes ongoing, centralized operations to support the platform.

As the cloud management team establishes higher degrees of operational management and specialization related to specific platforms, those platforms are added to a growing service catalog. That service catalog provides self-service deployment of platforms in a specific configuration, which adheres to ongoing platform operations. During business alignment conversation, cloud management and cloud strategy teams can propose service catalog solutions as a way for the business to improve reliability, uptime, and recovery commitments in a controlled, repeatable process.

For reference, some organizations will refer to an early stage service catalog as an "approved list". The primary difference is that a service catalog comes with ongoing operational commitments from the cloud center of excellence. An "approved list" is similar, in that it provides a pre-approved list of solutions a team can use in the cloud, but there is not typically an operational benefit associated with "approved list" applications. Much like the debate between Central IT and CCoE, the difference is one of priorities. A service catalog assumes good intent but provides operational, governance, and security guardrails that accelerate innovation. An "approved list" hinders innovation until operations, compliance, and security gates can be passed for a solution. Both are viable solutions but require a company to make subtle prioritization decisions to invest more in innovation or compliance.

### Building the service catalog

Cloud management is seldom successful at delivering a service catalog in a silo. Proper development of the catalog requires a partnership across Central IT or the Cloud Center of Excellence (CCoE). This approach tends to be most successful when an IT organization reaches a CCoE level of maturity, but could be implemented sooner.

When building the service catalog within a CCoE model, the cloud platform team builds out the desired state platform. The cloud governance and cloud security teams validate governance and compliance within the deployment. The cloud management team establishes ongoing operations for that platform. The cloud automation team packages the platform for scalable, repeatable deployment.

Once packaged, the cloud management team can add the package to the growing service catalog. From there, the cloud adoption team can leverage that package or others in the catalog during deployment. Once the solution goes to production, the business gets the extra benefits of improved operational management and the potential of reduced business disruptions.

> [!NOTE]
> Building a service catalog requires a great deal of effort and time from multiple teams. Using the service catalog or whitelist as a gating mechanism will slow innovation. When innovation is a priority, service catalogs should be developed parallel to other adoption efforts.

## Defining your own platform operations

Management tools and processes can improve platform operations. But that is often not enough to achieve the desired state of stability and reliability. True platform operations requires a focus on architecture quality pillars. When a platform justifies a deeper investment in operations, the following five pillars should be considered before the platform becomes a part of any service catalog:

1. Scalability: The ability of a system to handle increased load.
2. Availability: The proportion of time that a system is functional and working.
3. Resiliency: The ability of a system to recover from failures and continue to function.
4. Management: Operations processes that keep a system running in production.
5. Security: Protecting applications and data from threats.

The [Azure Architecture Framework](https://docs.microsoft.com/azure/architecture/guide/pillars) provides an approach to evaluating specific workloads for adherence to these pillars, in an effort to improve overall operations. These pillars can be applied to both platform operations and workload operations.

## Getting started with specific platforms

Across typical Azure customers the following are common platforms, which can easily justify an investment in platform operations. Cloud management teams tend to start with these when building out platform operations requirements or a full service catalog.

### PaaS data operations

Data is often the first platform to warrant platform operations investments. When data is hosted in a platform as a service (PaaS) environment, business stakeholders tend to request a reduced RPO to minimize data loss. Depending on the nature of the application, they may also request a reduction in RTO. In either case, the architecture supporting PaaS-based data solutions can easily accommodate some increased level of management support.

In most scenarios, the cost of improving management commitments is easily justified, even for applications which are not mission critical. This platform operations improvement is so common, that many cloud management teams see it more as an enhanced baseline, as opposed to treating it like a true platform operations improvement.

### IaaS data operations

When data is hosted in a traditional infrastructure as a service (IaaS) solution, the effort to improve RTO and RPO can be significantly higher. Yet the business stakeholders' desire to achieve better management commitments is seldom affected by a PaaS vs. IaaS decision. If anything, an understanding of the fundamental differences in architecture, may prompt the business to ask for PaaS solutions or commitments that match what is available on PaaS solutions. Modernization of any IaaS data platforms should be considered as a first step into platform operations.

When modernization is not an option, cloud management teams will commonly prioritize IaaS-based data platforms, as a first required service in the service catalog. Providing the business with a choice between stand-alone data servers and clustered, high-availability, data solutions makes the business commitment conversation much easier to facilitate. A basic understanding of the operational improvements and the increased costs, will arm the business to make the best decision for the business processes and supporting workloads.

### Other common platform operations

In addition to data platforms, virtual machine hosts tend to be a common platform for operations improvements. Most commonly, cloud platform and cloud management teams will invest in improvements to VMWare hosts or container solutions to improve the stability and reliability of the hosts, which support the VMs, which power workloads. Proper operations on one host or container can improve the RPO/RTO of several workloads. This approach creates improved business commitments, but distributes the investment. Together, improved commitments and reduced costs makes it much easier to justify improvements to cloud management and platform operations.

## Next steps

In parallel with improvements to platform operations, cloud management teams will also focus on improving [workload operations](./workload.md) for the top 20% or less of production workloads.

> [!div class="nextstepaction"]
> [Improve workload Operations](./workload.md)
