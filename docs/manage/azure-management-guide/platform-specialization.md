---
title: Platform specialization for cloud management in Azure
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Improve platform-specific cloud management operations.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

# Platform specialization for cloud management

Much like the enhanced management baseline, platform specialization is extension beyond the standard management baseline. See below for a visual and bulleted list of the ways to expand the management baseline. This article addresses the platform specialization option.

![Beyond the cloud management baseline](../../_images/manage/beyond-the-baseline.png)

- **Workload operations:** Largest per workload operations investment. Highest degree of resiliency. Suggested for the +/- 20% of workloads that drive business value. Usually reserved for High criticality or mission critical workloads.
- **Platform operations:** Operations investment is spread across many workloads. Resiliency improvements impact all workloads which leverage the defined platform. Suggested for the +/- 20% of the highest criticality platforms. Usually reserved for medium to high criticality workloads.
- **Enhanced management baseline:** Lowest relative operations investment. Slightly improved business commitments using additional cloud-native operations tools and processes.

Both workload and platform operations will require changes to design and architecture principles. Those changes could take time and may result in increased operating expenses. To reduce the number of workloads requiring such investments, an enhanced management baseline could provide enough of an improvement to the business commitment.

The following table outlines a few common processes, tools, and potential impacts common in customers' enhanced management baselines.

|Process  |Tool  |Purpose  |Suggested Management Level  |
|---------|---------|---------|---------|
|Improve system design|Azure Architecture Framework|Improve the architectural design of the platform to improve operations|
|Automate remediation|Azure Automation|Respond to advanced platform data with platform specific automation|Platform Operations|
|Service Catalog|Managed applications center|Provide a self-service catalog of approved solutions that meet organizational standards|Platform Operations|
|Container performance|Azure Monitor for Containers|Monitoring and diagnostics of containers|Platform Operations|
|PaaS data performance|Azure SQL Analytics|Monitoring and diagnostics for PaaS DBs|Platform Operations|
|IaaS data performance|SQL Server Health Check|Monitoring and diagnostics for IaaS DBs|Platform Operations|

## High-level process

Platform specialization consists of a disciplined execution of the following four processes in an iterative approach. Each process is explained in more detail in the following sections of this article.

- **Improve system design:** Improve the design of common systems (or platforms) to effectively minimize interruptions.
- **Automate remediation:** Some improvements are not cost effective. In such cases, it may make more sense to automate remediation and reduce the impact of interruptions.
- **Scale the solution:** As systems design and automated remediation are improved, those changes can be scaled across the environment through the service catalog.
- **Continuous improvement:** Various monitoring tools can be used to discover incremental improvements that can be addressed in the next pass of system design, automation, and scale.

::: zone target="docs"

## Improve system design

::: zone-end
::: zone target="chromeless"

## [Improve system design](#tab/SystemsDesign)

::: zone-end

Improving system design is the most effective approach to improving operations of any common platform. Through system design improvements, stability can increase and business interruptions can decrease. Design of individual systems is out of scope for the environment view taken throughout the Cloud Adoption Framework. As a complement to this framework, the Azure Architecture Framework provides best practices for improving the resiliency and design of a specific system. Those design improvements can be applied to the systems design of a platform or a specific workload.

The Azure Architecture Framework focuses on improvement across five pillars of system design:

- **Scalability:** Scaling the common platform assets to handle increased load.
- **Availability:** Decreasing business interruptions by improving uptime potential.
- **Resiliency:** Improve recovery times to reduce duration of interruptions.
- **Security:** Protect applications and data from external threats.
- **Management:** Operational processes specific to those common platform assets.

Most business interruptions equate to some form of technical debt, or deficiency in the architecture. For existing deployments, systems design improvements can be viewed as payments against existing technical debt. For new deployments, systems design improvements can be viewed as avoidance of technical debt. The next tab, "Automated remediation", looks at ways to address technical debt that can't or shouldn't be addressed.

Learn more about [Azure Architecture Framework](https://docs.microsoft.com/azure/architecture/guide/pillars) to improve system design.

As system design improves, return to this article to find new opportunities to improve and scale those improvements across your environment.

::: zone target="docs"

## Automated Remediation

::: zone-end
::: zone target="chromeless"

## [Automated Remediation](#tab/AutomatedRemediation)

::: zone-end

Some technical debt can't be addressed. Resolution could be too expensive to correct. Resolution could be planned, but have a long project duration. It could be that the business interruption doesn't have a significant business impact or that the business priority is to recover quickly instead of investing in resiliency.

When resolution of technical debt isn't the desired path, automated remediation is commonly the desired next step. Using Azure Automation and Azure Monitor to detect trends and provide automated remediation is the most common approach to automated remediation.

For guidance on automated remediation, see this article on [Azure Automation and alerts](https://docs.microsoft.com/azure/automation/automation-create-alert-triggered-runbook).

::: zone target="docs"

## Scale the solution with a service catalog

::: zone-end
::: zone target="chromeless"

## [Scale the solution with a service catalog](#tab/ServiceCatalog)

::: zone-end

The cornerstone of platform specialization and platform operations is a well-managed service catalog. This is how improvements to systems design and remediation are scaled across an environment. The cloud platform team and cloud automation team align to create repeatable solutions to the most common platforms in any environment. But, if those solutions aren't consistently leveraged, cloud management can provide little more than a baseline offering.

To maximize adoption and minimize maintenance overhead of any optimized platform, the platform should be added to a service catalog within Azure. Each application in the catalog can be deployed for internal consumption via the service catalog, or as a marketplace offering for external consumers.

For instructions on publishing to a service catalog, see the article series on [publishing to a service catalog](https://docs.microsoft.com/azure/managed-applications/publish-service-catalog-app).

### Deploy applications from the service catalog

1. In the Azure portal, search for **Managed applications center (preview)**.
2. Click on **Service Catalog applications** under the **Browse** section of the portal navigation.
3. Click **+ Add** to chose an application definition from your company's service catalog.

Any managed applications you are servicing are displayed here.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/Microsoft_Azure_Appliance/ManagedAppsHubBlade/browseServiceCatalog]" submitText="Go to Virtual Machines" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

### Manage service catalog applications

1. In the Azure portal, search for **Managed applications center (preview)**.
2. Click on **Service Catalog applications** under the **Service** section of the portal navigation.

Any managed applications you are servicing are displayed here.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/Microsoft_Azure_Appliance/ManagedAppsHubBlade/serviceServiceCatalogApps]" submitText="Go to Virtual Machines" :::

::: zone-end

::: zone target="docs"

## Continuous improvement

::: zone-end
::: zone target="chromeless"

## [Continuous Improvement](#tab/ContinuousImprovement)

::: zone-end

Platform specialization and platform operations both depend on strong feedback loops between adoption, platform, automation, and management teams. Grounding those feedback loops in data empowers each team to make wise decisions. For platform operations to achieve long-term business commitments, it is important to leverage insights specific to the centralized platform. Since containers and SQL Server are the two most common centrally managed platforms, the following are a few articles to help get you started with continuous improvement data collection.

[Container performance](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview)
[PaaS database performance](https://docs.microsoft.com/azure/azure-monitor/insights/azure-sql)
[IaaS database performance](https://docs.microsoft.com/azure/azure-monitor/insights/sql-assessment)
