---
title: "Assess each workload and refine plans"
description: Use the Cloud Adoption Framework for Azure to assess your environment's suitability for migration and which methods to consider.
author: matticusau
ms.author: mlavery
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: fasttrack-new, AQC
ms.localizationpriority: high
---

# Assess workloads and refine plans

The resources in this guide help you assess each workload, challenge assumptions about each workload's suitability for migration, and finalize architectural decisions about migration options.

<!-- markdownlint-disable MD025 -->

## [Tools](#tab/Tools)

If you didn't follow the guidance in the links above, you will likely need data and an assessment tool to make informed migration decisions. Azure Migrate is the native tool for assessing **and** migrating to Azure. If you haven't already, use these steps to create a new server migration project and collect the necessary data.

### Azure Migrate

Azure Migrate assesses on-premises infrastructure, applications, and data for migration to Azure. This service:

- Assesses the migration suitability of on-premises assets.
- Performs performance-based sizing.
- Provides cost estimates for running on-premises assets in Azure.

If you're considering a lift and shift approach, or are in the early assessment stages of migration, this service is for you. After completing the assessment, use Azure Migrate to execute the migration.

![Azure Migrate overview](./media/assess/azure-migrate-overview-1.png)

#### Create a new server migration project

Begin a server migration assessment using Azure Migrate via these steps:

1. Select **Azure Migrate**.
1. In **Overview**, select **Assess and migrate servers**.
1. Select **Add tools**.
1. In **Discover, assess and migrate servers**, select **Add tools**.
1. In **Migrate project**, select your Azure subscription, then create a resource group if you don't have one.
1. In **Project Details**, specify the project name and geography where you want to create the project, then select **Next**.
1. In **Select assessment tool**, select **Skip adding an assessment tool for now** > **Next**.
1. In **Select migration tool**, select **Azure Migrate: Server Migration** > **Next**.
1. In **Review + add tools**, review the settings, then select **Add tools**.
1. After adding the tool, it appears in **Azure Migrate project** > **Servers** > **Migration tools**.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/Microsoft_Azure_Migrate/AmhResourceMenuBlade/overview]" submitText="Assess and migrate servers" :::

::: zone-end

::: zone target="docs"

#### Learn more

- [Azure Migrate overview](/azure/migrate/migrate-services-overview)
- [Migrate physical or virtualized servers to Azure](/azure/migrate/tutorial-migrate-physical-virtual-machines)
- [Azure Migrate in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Migrate/AmhResourceMenuBlade/overview)

::: zone-end

### Service Map

Service Map automatically discovers application components on Windows and Linux systems and maps the communication between services. With Service Map, you can view your servers in the way that you think of them: as interconnected systems that deliver critical services. Service Map shows connections between servers, processes, inbound and outbound connection latency, and ports across any TCP-connected architecture, with no configuration required other than the installation of an agent.

Azure Migrate uses Service Map to enhance the reporting capabilities and dependencies across the environment. For full details of this integration, see [Dependency visualization](/azure/migrate/concepts-dependency-visualization). If you use the Azure Migrate service, then no additional steps are required to configure and obtain the benefits of Service Map. The following instructions are provided for your reference if you'd like to use Service Map for other purposes or projects.

#### Enable dependency visualization using Service Map

To use dependency visualization, download and install agents on each on-premises machine that you want to analyze.

- [Microsoft Monitoring Agent](/azure/log-analytics/log-analytics-agent-windows) must be installed on each machine.
- The [Microsoft Dependency Agent](/azure/azure-monitor/insights/vminsights-enable-hybrid-cloud#install-the-dependency-agent-on-windows) must be installed on each machine.
- Also, if you have machines with no internet connectivity, download and install Log Analytics gateway on those machines.

<!-- markdownlint-disable MD024 -->

#### Learn more

- [Using Service Map solution in Azure](/azure/azure-monitor/insights/service-map)
- [Azure Migrate and Service Map: Dependency visualization](/azure/migrate/concepts-dependency-visualization)

## [Challenge assumptions](#tab/Challenge-Assumptions)

In an ideal migration, every asset (infrastructure, app, or data) would be compatible with a cloud platform and ready for migration or modernization. In reality, not every workload should be migrated to the cloud. Not every asset is compatible with cloud platforms. Before migrating a workload to the cloud, assess each workload and all dependent assets (infrastructure, apps, and data).

The [Plan methodology of the Cloud Adoption Framework](../../plan/index.md) advises readers to use [incremental rationalization](../../digital-estate/rationalize.md#incremental-rationalization) and [power of ten](../../digital-estate/rationalize.md#release-planning) approaches to assess and plan for the migration. That guidance also includes a detailed best practice for [using Azure Migrate to assess your digital estate](../../plan/contoso-migration-assessment.md).

The above links suggest that assumptions are acceptable and often encouraged during the planning stages of migration. But now, it's time to take action. Those assumptions should be challenged on a per-workload basis before migrating to the cloud.

### Two steps of incremental rationalization

Two equally weighted steps are required to successfully deliver [incremental rationalization](../../digital-estate/rationalize.md#incremental-rationalization). Both steps require data and insights into the environment. However, each approach respects the amount of time and granularity of detail required to be successful in a migration effort.

- [Power of 10 release planning](../../digital-estate/rationalize.md#release-planning): During initial rationalization and release planning, only one of the [five Rs of rationalization](../../digital-estate/5-rs-of-rationalization.md) is to be used in the assessment. Estimate and plan based on the rationalization option that best aligns with the overall motivations defined in the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx).

- **Detailed assessment of each workload:** The assumptions associated with Power of 10 release planning are acceptable enough to build a plan. But those same assumptions can cause significant issues, if not evaluated prior to migration.

### Challenge assumptions and update the plan

Closely review the assessment data in Azure Migrate or your chosen assessment tool. This data will provide insights into compatibility issues, remediation requirements, sizing suggestions, and other considerations.

Before migration, use that data, along with discovery conversations with the product owner, development teams, administrators, and others to evaluate the feasibility of migrating this specific workload. Use this discovery to challenge core assumptions about this workload. If the findings change the migration or adoption plan, update the plan accordingly.

The first step in challenging these assumptions is a [review of all five Rs of rationalization](../../digital-estate/rationalize.md).

- Does the assumed rationalization approach work for this workload? Is it the best approach?
- Will any of the [physics of replication](../migration-considerations/migrate/replicate.md#replication-risks---physics-of-replication) impact the migration of this workload?
- Does this workload require any [remediation activities](../migration-considerations/assess/evaluate.md) before migration?

These types of questions help challenge assumptions and lead to the best path for each workload.

For an extended list of questions and a defined process for validating assumptions, see the [overview of assessment process improvements](../migration-considerations/assess/index.md).

## [Scenarios and stakeholders](#tab/Scenarios)

### Scenarios

This guide covers the following scenarios:

- **Legacy hardware:** Migrate to remove a dependency on legacy hardware that is nearing end of support or end of life.
- **Capacity growth:** Increase the capacity for assets (infrastructure, apps, and data) that your current infrastructure can't provide.
- **Datacenter modernization:** Extend your datacenter or modernize your datacenter with cloud technology to ensure your business remains current and competitive.
- **Application or service modernization:** Update your applications to take advantage of cloud-native functionality. Even if your initial objective is a rehost migration strategy, the ability to create plans for application or service review and potential modernization is a common process in any migration.

### Organizational alignment and stakeholders

The complete list of stakeholders varies between migration projects. It is best to assume that you won't know all of the stakeholders at the start of migration planning, since stakeholders are often only identified during certain phases of the project. However, before starting any migration projects, identify key business leaders from finance, IT infrastructure, and application groups that have a stake in your organization's overall cloud migration efforts.

Establishing a core cloud strategy team, built around these key high-level stakeholders, can help prepare your organization for cloud adoption and guide your overall cloud migration efforts. This team is responsible for understanding cloud technologies and migration processes, identifying the business justification for migrations, and determining the best high-level solutions for migration efforts. They also help identify and work with specific application and business stakeholders to ensure a successful migration.

For more information about preparing your organization for cloud migration efforts, see the Cloud Adoption Framework's guidance on [initial organization alignment](../../plan/initial-org-alignment.md).

## [Timelines](#tab/Timelines)

Customers typically find that the migration scenario covered by this guide can be completed in one to six months.

When evaluating the timeline of your migration, consider:

- **Assets (infrastructure, apps, and data) to migrate:** The number of and diversity of assets.
- **Staff readiness:** Is your staff ready to manage the new environment or do they need training?
- **Funding:** Do you have the appropriate approval and budget to complete the migration?
- **Change management:** Does your business have specific requirements regarding change implementation and approval?
- **Segment regulations:** Do you have to comply with segment or industry regulations?

## [Cost management](#tab/ManageCost)

Assessing your environment provides a great opportunity to include a cost analysis step. Using the data collected by the assessment activities, you should be able to analyze and predict costs. This cost prediction should factor both the consumption service costs in addition to any one-time costs (such as increased data ingress).

During migration, certain factors that affect decisions and execution activities:

- **Digital estate size:** Understanding the size of your digital estate will directly affect decisions and the resources required to perform the migration.
- **Accounting models:** Shifting from a structured capital expense model to a fluid operating expense model.

::: zone target="docs"

The following resources provide related information:

- [Estimate cloud costs](../migration-considerations/assess/estimate.md)

::: zone-end
