---
title: Specialized platforms for cloud management
description: Use the Cloud Adoption Framework for Azure to improve platform-specific cloud management operations, including improving the system design and automated remediation.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.localizationpriority: high
ms.custom: internal, fasttrack-edit, AQC
---

<!-- docutune:casing "SQL Server Health Check" -->

# Platform specialization for cloud management

Much like the enhanced management baseline, platform specialization is extension beyond the standard management baseline. See the following image and list that show the ways to expand the management baseline. This article addresses the platform specialization options.

![Beyond the cloud management baseline](../../_images/manage/beyond-the-baseline.png)

- **Workload operations:** The largest per-workload operations investment and the highest degree of resiliency. We suggest workload operations for the approximately 20% of workloads that drive business value. This specialization is usually reserved for high criticality or mission-critical workloads.
- **Platform operations:** Operations investment is spread across many workloads. Resiliency improvements affect all workloads that use the defined platform. We suggest platform operations for the approximately 20% of platforms that have the highest criticality. This specialization is usually reserved for medium to high criticality workloads.
- **Enhanced management baseline:** The relatively lowest operations investment. This specialization slightly improves business commitments by using additional cloud-native operations tools and processes.

Both workload and platform operations require changes to design and architecture principles. Those changes can take time and might result in increased operating expenses. To reduce the number of workloads requiring such investments, an enhanced management baseline might provide enough of an improvement to the business commitment.

This table outlines a few common processes, tools, and potential effects common in customers' enhanced management baselines:

| Process | Tool | Purpose | Suggested management level |
|---|---|---|---|
| Improve system design | Microsoft Azure Well-Architected Framework | Improving the architectural design of the platform to improve operations | N/A |
| Automate remediation | Azure Automation | Responding to advanced platform data with platform-specific automation | Platform operations |
| Service catalog | Managed applications center | Providing a self-service catalog of approved solutions that meet organizational standards | Platform operations |
| Container performance | Azure Monitor for containers | Monitoring and diagnostics of containers | Platform operations |
| Platform as a service (PaaS) data performance | Azure SQL Analytics | Monitoring and diagnostics for PaaS databases | Platform operations |
| Infrastructure as a service (IaaS) data performance | SQL Server Health Check | Monitoring and diagnostics for IaaS databases | Platform operations |

## High-level process

Platform specialization consists of a disciplined execution of the following four processes in an iterative approach. Each process is explained in more detail in later sections of this article.

- **Improve system design:** Improve the design of common systems or platforms to effectively minimize interruptions.
- **Automate remediation:** Some improvements aren't cost effective. In such cases, it might make more sense to automate remediation and reduce the effect of interruptions.
- **Scale the solution:** As systems design and automated remediation are improved, those changes can be scaled across the environment through the service catalog.
- **Continuous improvement:** Different monitoring tools can be used to discover incremental improvements. These improvements can be addressed in the next pass of system design, automation, and scale.

::: zone target="docs"

## Improve system design

::: zone-end
::: zone target="chromeless"

## [Improve system design](#tab/SystemsDesign)

::: zone-end

Improving system design is the most effective approach to improving operations of any common platform. Through system-design improvements, stability can increase and business interruptions can decrease. Design of individual systems is beyond the scope of the environment view that's taken throughout the Cloud Adoption Framework.

As a complement to this framework, the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) provides guiding tenets for improving the quality of a platform or a specific workload. The framework focuses on improvement across five pillars of architecture excellence:

- **Cost optimization:** Manage costs to maximize the value delivered.
- **Operational excellence:** Follow operational processes that keep a system running in production.
- **Performance efficiency:** Scale systems to adapt to changes in load.
- **Reliability:** Design systems to recover from failures and continue to function.
- **Security:** Protect applications and data from threats.

Technical debt and architectural flaws cause most business interruptions. For existing deployments, you can view system-design improvements as payments against existing technical debt. For new deployments, you can view those improvements as avoidance of technical debt.

The following **Automated remediation** tab shows ways to remediate technical debt that can't or shouldn't be addressed.

Learn more about the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) to improve system design.

As system design improves, return to this article to find new opportunities to improve and scale those improvements across your environment.

::: zone target="docs"

## Automated remediation

::: zone-end
::: zone target="chromeless"

## [Automated remediation](#tab/AutomatedRemediation)

::: zone-end

Some technical debt can't be addressed. Resolution might be too expensive to correct or might be planned but have a long project duration. The business interruption might not have a significant business effect. Or the business priority might be to recover quickly instead of investing in resiliency.

When resolution of technical debt isn't the desired approach, automated remediation is commonly the next step. Using Azure Automation and Azure Monitor to detect trends and provide automated remediation is the most common approach to automated remediation.

For guidance on automated remediation, see [Azure Automation and alerts](/azure/automation/automation-create-alert-triggered-runbook).

::: zone target="docs"

## Scale the solution with a service catalog

::: zone-end
::: zone target="chromeless"

## [Scale the solution with a service catalog](#tab/ServiceCatalog)

::: zone-end

A well-managed service catalog is the cornerstone of platform specialization and platform operations. Use of a catalog is how improvements to systems design and remediation are scaled across an environment.

The cloud platform team and cloud automation team align to create repeatable solutions to the most common platforms in any environment. But if those solutions aren't consistently used, cloud management can provide little more than a baseline offering.

To maximize adoption and minimize maintenance overhead of any optimized platform, you should add the platform to an Azure service catalog. You can deploy each application in the catalog for internal consumption via the service catalog or as a marketplace offering for external consumers.

For instructions on publishing to a service catalog, see the article series on [publishing to a service catalog](/azure/azure-resource-manager/managed-applications/publish-service-catalog-app).

### Deploy applications from the service catalog

1. In the Azure portal, go to **Managed applications center (preview)**.
2. On the **Browse** pane, select **Service Catalog applications**.
3. Select **+ Add** to choose an application definition from your company's service catalog.

Any managed applications you're servicing are displayed.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/Microsoft_Azure_Appliance/ManagedAppsHubBlade/browseServiceCatalog]" submitText="Go to Virtual Machines" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

### Manage service catalog applications

1. In the Azure portal, go to **Managed applications center (preview)**.
1. On the **Service** pane, select **Service Catalog applications**.

Any managed applications you're servicing are displayed.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/Microsoft_Azure_Appliance/ManagedAppsHubBlade/serviceServiceCatalogApps]" submitText="Go to Virtual Machines" :::

::: zone-end

::: zone target="docs"

## Continuous improvement

::: zone-end
::: zone target="chromeless"

## [Continuous improvement](#tab/ContinuousImprovement)

::: zone-end

Platform specialization and platform operations both depend on strong feedback loops among adoption, platform, automation, and management teams. Grounding those feedback loops in data helps each team make wise decisions. For platform operations to achieve long-term business commitments, it's important to use insights specific to the centralized platform.

Containers and SQL Server are the two most common centrally managed platforms. These articles can help you get started with continuous-improvement data collection on those platforms:

- [Container performance](/azure/azure-monitor/containers/container-insights-overview)
- [PaaS database performance](/azure/azure-monitor/insights/azure-sql)
- [IaaS database performance](/azure/azure-monitor/insights/sql-assessment)
