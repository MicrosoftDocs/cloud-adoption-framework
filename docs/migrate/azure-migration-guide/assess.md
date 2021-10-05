---
title: Assess each workload and refine plans
description: Use the Cloud Adoption Framework for Azure to assess your environment's suitability for migration and which methods to consider.
author: matticusau
ms.author: brblanch
ms.date: 08/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.localizationpriority: high
ms.custom: think-tank, fasttrack-new, AQC
---

# Assess workloads and refine plans

The resources in this guide help you assess each workload, challenge assumptions about each workload's suitability for migration, and make architectural decisions about migration options.

## [Tools](#tab/Tools)

If you didn't follow the guidance in the links above, you'll need data and an assessment tool to make informed migration decisions. Azure Migrate is the native tool for assessing **and** migrating to Azure. If you haven't already, use these steps to create a new server migration project and collect the necessary data.

### Azure Migrate

Azure Migrate provides a centralized hub to assess and migrate to Azure on-premises servers, infrastructure, applications, and data. This service:

- Assesses whether on-premises servers are ready for migration to Azure.
- Estimates the size of Azure virtual machines (VMs), Azure SQL configuration, or number of Azure VMware Solution nodes after migration.
- Estimates costs for running on-premises servers in Azure.
- Identifies cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

If you're considering a lift-and-shift approach or are in the early assessment stages of migration, this service is for you. After completing the assessment, use Azure Migrate to execute the migration.

![Azure Migrate overview](./media/assess/azure-migrate-overview-1.png)

#### Create a new project

Begin server discovery, assessment, and migration using the following steps for Azure Migrate:

1. Select **Azure Migrate**.
2. In **Overview**, select **Discover, assess and migrate**.
3. Select **Add tools**.
4. In **Project**, select your Azure subscription, then create a resource group if you don't have one.
5. In **Project Details**, specify the project name and geography where you want to create the project, then select **Create**.
6. After creating the project, tools are visible in project and user can start with Discovery.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/Microsoft_Azure_Migrate/AmhResourceMenuBlade/overview]" submitText="Discover, assess and migrate" :::

::: zone-end

::: zone target="docs"

#### Learn more

- [Azure Migrate overview](/azure/migrate/migrate-services-overview)
- [Migrate physical or virtualized servers to Azure](/azure/migrate/tutorial-migrate-physical-virtual-machines)
- [Azure Migrate in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Migrate/AmhResourceMenuBlade/overview)

::: zone-end

### Dependency analysis

Dependency analysis identifies dependencies between discovered on-premises servers. It provides the following advantages:

- Gather servers into groups for a better assessment.
- Identify servers to migrate together. This step is useful if you're unsure which servers are part of an app deployment that you want to migrate.
- Identify whether servers are in use and which servers you can decommission instead of migrate.
- Analyze dependencies to ensure that nothing is left behind and avoid surprise outages after migration.

<!-- markdownlint-disable MD024 -->

#### Learn more

- [Azure Migrate dependency analysis](/azure/migrate/concepts-dependency-visualization)

## [Challenge assumptions](#tab/Challenge-Assumptions)

In an ideal migration, every asset would be compatible with a cloud platform and ready for migration or modernization. But in practice, you shouldn't migrate every workload to the cloud. Not every asset is compatible with cloud platforms. Before migrating a workload to the cloud, assess each workload and all dependent assets.

You can use the [Plan methodology of the Cloud Adoption Framework](../../plan/index.md) for approaches to assess and plan for the migration. This plan advises you to use [incremental rationalization](../../digital-estate/rationalize.md#incremental-rationalization) and [power of 10](../../digital-estate/rationalize.md#release-planning) approaches. It also includes best practices for [using Azure Migrate to assess your digital estate](../../plan/contoso-migration-assessment.md).

The above links suggest that assumptions are acceptable and often encouraged during the planning stages of migration. Those assumptions should be challenged on a per-workload basis before migrating to the cloud.

### Two steps of incremental rationalization

Successfully delivering [incremental rationalization](../../digital-estate/rationalize.md#incremental-rationalization) requires two equally weighted steps. Both steps require data and insights into the environment. However, each approach respects the amount of time and granularity of detail needed to be successful in a migration effort.

- [Power of 10 release planning](../../digital-estate/rationalize.md#release-planning): During initial rationalization and release planning, only use one of the [five Rs of rationalization](../../digital-estate/5-rs-of-rationalization.md) in the assessment. Estimate and plan based on the rationalization option that best aligns with the overall motivations in the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx).

- **Detailed assessment of each workload:** The assumptions associated with Power of 10 release planning are good enough to build a plan. But those same assumptions can cause significant issues if not evaluated before migration.

### Challenge assumptions and update the plan

Closely review the assessment data in Azure Migrate or your chosen assessment tool. This data provides insights into compatibility issues, remediation requirements, sizing suggestions, and other considerations.

Before migration, use that data, along with discovery conversations, to evaluate the feasibility of migrating this specific workload. The discovery conversations take place with the product owner, development teams, administrators, and others. Use this discovery to challenge core assumptions about this workload. If the findings change the migration or adoption plan, update the plan as needed.

The first step in challenging these assumptions is a [review of all five Rs of rationalization](../../digital-estate/rationalize.md).

- Does the assumed rationalization approach work for this workload? Is it the best approach?
- Will any of the [physics of replication](../migration-considerations/migrate/replicate.md#replication-risks---physics-of-replication) impact the migration of this workload?
- Does this workload require any [remediation activities](../migration-considerations/assess/evaluate.md) before migration?

These types of questions help challenge assumptions and lead to the best path for each workload.

For more questions and a process for validating assumptions, see the [overview of assessment process improvements](../migration-considerations/assess/index.md).

## [Scenarios and stakeholders](#tab/Scenarios)

### Scenarios

This guide covers the following scenarios:

- **Legacy hardware:** Migrate to remove a dependency on legacy hardware that is nearing end of support or end of life.
- **Capacity growth:** Increase the capacity for assets like infrastructure, apps, and data that your current infrastructure can't provide.
- **Datacenter modernization:** Extend or modernize your datacenter with cloud technology to ensure that your business remains current and competitive.
- **Application or service modernization:** Update your applications to take advantage of cloud-native functionality. Your initial goal might be something like rehosting migration strategy. However, the ability to create plans for application or service review and potential modernization is a common process in any migration.

### Organizational alignment and stakeholders

The complete list of stakeholders changes between migration projects. It's best to assume you won't know all of the stakeholders at the start of migration planning. Stakeholders are often only identified during certain phases of the project. Before starting any migration projects, identify key business leaders from finance, IT infrastructure, and application groups that have a stake in your organization's overall cloud migration efforts.

Establish a core cloud strategy team built around these key high-level stakeholders. This team:

- Helps prepare your organization for cloud adoption and guides your overall cloud migration efforts.
- Is responsible for understanding cloud technologies and migration processes.
- Identifies the business justification for migrations.
- Determines the best high-level solutions for migration efforts.
- Helps identify and work with specific application and business stakeholders to ensure a successful migration.

For more information, see the Cloud Adoption Framework's [initial organization alignment](../../plan/initial-org-alignment.md) guidance.

## [Timelines](#tab/Timelines)

You can usually complete the migration scenario covered by this guide in one to six months.

When evaluating the timeline of your migration, consider:

- **Assets to migrate:** What is the number and diversity of assets like infrastructure, apps, and data?
- **Staff readiness:** Is your staff ready to manage the new environment or do they need training?
- **Funding:** Do you have the appropriate approval and budget to complete the migration?
- **Change management:** Does your business have specific requirements about change implementation and approval?
- **Segment regulations:** Do you have to comply with segment or industry regulations?

## [Cost management](#tab/ManageCost)

Assessing your environment provides a great opportunity to include a cost analysis step. Using the data collected by the assessment activities, you can analyze and predict costs. This cost prediction should factor both the consumption service costs and any one-time costs, like increased data ingress.

During migration, certain factors affect decisions and execution activities:

- **Digital estate size:** Understanding the size of your digital estate directly affects decisions and the resources required to do the migration.
- **Accounting models:** Shifting from a structured capital expense model to a fluid operating expense model.

::: zone target="docs"

The following resources provide related information:

- [Estimate cloud costs](../migration-considerations/assess/estimate.md)

::: zone-end
