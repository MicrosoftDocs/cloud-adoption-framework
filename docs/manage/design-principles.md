---
title: Design principles and advanced operations
description: Learn to apply design principles and advanced options to create an offering that provides a minimum level of business commitment for all supported workloads.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Apply design principles and advanced operations

The first three cloud management disciplines describe a management baseline. At a minimum, a management baseline should include a standard business commitment to minimize business interruptions and accelerate recovery if service is interrupted. Most management baselines include a disciplined focus on maintaining "inventory and visibility," "operational compliance," and "protection and recovery."

The purpose of a management baseline is to create a consistent offering that provides a minimum level of business commitment for all supported workloads. This baseline of common, repeatable management offerings allows the team to deliver a highly optimized degree of operational management, with minimal deviation. But that standard offering might not provide a rich enough commitment to the business.

The diagram in the next section illustrates three ways to go beyond the management baseline.

The management baseline should meet the minimum commitment required by 80 percent of the lowest criticality workloads in the portfolio. The baseline should not be applied to mission-critical workloads. Nor should it be applied to common platforms that are shared across workloads. Those workloads require a focus on design principles and advanced operations.

## Advanced operations options

There are three suggested paths for improving business commitments beyond the management baseline, as shown in the following diagram:

![Advanced operations](../_images/manage/beyond-the-baseline.png)

## Enhanced management baseline

As outlined in the Azure Management Guide, an enhanced management baseline uses cloud-native tools to improve uptime and decrease recovery times. The improvements are significant, but less so than with workload or platform specialization. The advantage of an enhanced management baseline is the equally significant reduction in cost and implementation time.

## Management specialization

Aspects of workload and platform operations might require changes to design and architecture principles. Those changes could take time and might result in increased operating expenses. To reduce the number of workloads requiring such investments, an enhanced management baseline could provide enough of an improvement to the business commitment.

For workloads that warrant a higher investment to meet a business commitment, specialization of operations is key.

## Areas of management specialization

There are two areas of specialization:

- **Platform specialization:** Invest in ongoing operations of a shared platform, distributing the investment across multiple workloads.
- **Workload specialization:** Invest in ongoing operations of a specific workload, generally reserved for mission-critical workloads.

### Central IT team or cloud center of excellence (CCoE)

Decisions between platform specialization and workload specialization are based on the criticality and impact of each workload. However, these decisions are also indicative of larger cultural decisions between central IT team and CCoE organizational models.

Workload specialization often triggers a cultural change. Traditional IT and centralized IT both build processes that can provide support at scale. Scale support is more achievable for repeatable services found in a management baseline, enhanced baseline, or even platform operations. Workload specialization doesn't often scale. This lack of scale makes it difficult for a centralized IT organization to provide necessary support without reaching organizational scale limitations.

Alternatively, a cloud center of excellence approach scales through purposeful delegation of responsibility and selective centralization. Workload specialization tends to better align with the delegated responsibility approach of a CCoE.

The natural alignment of roles in a CCoE is outlined as follows:

- The cloud platform team helps build common platforms that support multiple cloud adoption teams.
- The cloud automation team extends those platforms into deployable assets in a service catalog.
- Cloud management delivers the management baseline centrally and helps support the use of the service catalog.
- But the business unit (in the form of a business DevOps team or cloud adoption team) holds responsibility for day-to-day operations of the workload, pipeline, or performance.

As for aligning areas of management, central IT team and CCoE models can generally deliver on platform specialization, with minimal cultural change. Delivering on workload specialization might be more complex for central IT teams.

## Management specialization processes

Within each specialization, the following four-step process is delivered in a disciplined, iterative approach. This approach requires partnership among cloud adoption, cloud platform, cloud automation, and cloud management experts to create a viable and informed feedback loop.

- **Improve system design:** Improve the design of common systems (platforms) or specific workloads to effectively minimize interruptions.
- **Automate remediation:** Some improvements are not cost effective. In such cases, it might make more sense to automate remediation and reduce the impact of interruptions.
- **Scale the solution:** As systems design and automated remediation are improved, you can scale those changes across the environment through the service catalog.
- **Continuous improvement:** You can use various monitoring tools to discover incremental improvements to address in the next pass of system design, automation, and scale.

### Improve system design

Improving system design is the most effective approach to improving operations of any common platform. System design improvements can help increase stability and decrease business interruptions. Design of individual systems is out of scope for the environment view taken throughout the Cloud Adoption Framework.

As a complement to this framework, the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) provides guiding tenets for improving the quality of a platform or a specific workload. The framework focuses on improvement across five pillars of architecture excellence:

- **Cost optimization:** Manage costs to maximize the value delivered.
- **Operational excellence:** Follow operational processes that keep a system running in production.
- **Performance efficiency:** Scale systems to adapt to changes in load.
- **Reliability:** Design systems to recover from failures and continue to function.
- **Security:** Protect applications and data from threats.

Most business interruptions equate to some form of technical debt, or deficiency in the architecture. For existing deployments, systems design improvements can be viewed as payments against existing technical debt. For new deployments, systems design improvements can be viewed as avoidance of technical debt. The next section, "Automated remediation," looks at ways to address technical debt that can't or shouldn't be addressed.

To improve system design, learn more about the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/). As your system design improves, return to this article to find new opportunities to improve and scale the improvements across your environment.

### Automated remediation

Some technical debt can't or shouldn't be addressed. Resolution could be too expensive to correct. It could be planned but might have a long project duration. The business interruption might not have a significant business impact, or the business priority is to recover quickly instead of investing in resiliency.

When resolution of technical debt isn't the desired path, automated remediation is commonly the desired next step. Using Azure Automation and Azure Monitor to detect trends and provide automated remediation is the most common approach to automated remediation.

For guidance on automated remediation, see [Azure Automation and alerts](/azure/automation/automation-create-alert-triggered-runbook).

### Scale the solution with a service catalog

The cornerstone of platform specialization and platform operations is a well-managed service catalog. This is how improvements to systems design and remediation are scaled across an environment. The cloud platform team and cloud automation team align to create repeatable solutions to the most common platforms in any environment. However, if those solutions aren't consistently applied, cloud management can provide little more than a baseline offering.

To maximize adoption and minimize maintenance overhead of any optimized platform, the platform should be added to a service catalog. Each application in the catalog can be deployed for internal consumption via the service catalog, or as a marketplace offering for external consumers.

For information about publishing to a service catalog, see the series on [publishing to a service catalog](/azure/azure-resource-manager/managed-applications/publish-service-catalog-app).

### Continuous improvement

Platform specialization and platform operations both depend on strong feedback loops between adoption, platform, automation, and management teams. Grounding those feedback loops in data empowers each team to make wise decisions. For platform operations to achieve long-term business commitments, it's important to take advantage of insights that are specific to the centralized platform. Because containers and SQL Server are the two most common centrally managed platforms, consider beginning with continuous improvement data collection by reviewing the following articles:

- [Container performance](/azure/azure-monitor/containers/container-insights-overview)
- [PaaS database performance](/azure/azure-monitor/insights/azure-sql)
- [IaaS database performance](/azure/azure-monitor/insights/sql-assessment)
