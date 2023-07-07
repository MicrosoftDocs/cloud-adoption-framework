---
title: Assess each workload and refine plans
description: Use the Cloud Adoption Framework for Azure to assess your environment's suitability for migration and which methods to consider.
author: Zimmergren
ms.author: tozimmergren
ms.date: 07/07/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank, fasttrack-new, AQC, UpdateFrequency2
---

# Assess workloads and refine plans

The resources in this guide help you assess each workload, challenge assumptions about each workload's suitability for migration, and make architectural decisions about migration options.

## Scenarios and stakeholders

This guide covers several migration scenarios and talks about the importance of identifying stakeholders throughout migration projects.

### Scenarios

- **Legacy hardware:** Migrate to remove a dependency on legacy hardware nearing end of support or end of life.
- **Capacity growth:** Increase the capacity for assets like infrastructure, apps, and data that your current infrastructure can't provide.
- **Datacenter modernization:** Extend or modernize your datacenter with cloud technology to ensure your business remains current and competitive.
- **Application or service modernization:** Update your applications to take advantage of cloud-native functionality. Your initial goal might be something like rehosting migration strategy. However, the ability to create plans for application or service review and potential modernization is a typical process in any migration.

### Organizational alignment and stakeholders

The complete list of stakeholders changes between migration projects. It's best to assume you'll only know some stakeholders at the start of migration planning. Stakeholders are often only identified during certain phases of the project. Before starting any migration projects, identify key business leaders from finance, IT infrastructure, and application groups with a stake in your organization's overall cloud migration efforts.

Establish a core cloud strategy team built around these key high-level stakeholders. This team:

- Helps prepare your organization for cloud adoption and guides your overall cloud migration efforts.
- Is responsible for understanding cloud technologies and migration processes.
- Identifies the business justification for migrations.
- Determines the best high-level solutions for migration efforts.
- Helps identify and work with specific applications and business stakeholders to ensure a successful migration.

It's also recommended to review the following resources prior to starting new migration projects, helping you come more prepared for successful migrations:

- **[Mature team structures](/azure/cloud-adoption-framework/organize/organization-structures)**: Review your alignment to various roles and functions to help throughout each cloud adoption effort. It's recommended to have at least an initial team structure mapped out to support and map dependencies necessary for the migration project.

- **[Share your strategy](/azure/cloud-adoption-framework/strategy/share-your-strategy)**: Consider ensuring that the strategy is understood as all decisions made during migrations ideally should align to the organizational strategy.

- **[Initial organization alignment](../../plan/initial-org-alignment.md)**: Review the guidance on initial organization alignment to come better prepared as cloud adoption and migration projects scales across the business and IT culture.

## Challenge assumptions

In an ideal migration, every asset would be compatible with a cloud platform and ready for migration or modernization. But in practice, you shouldn't migrate every workload to the cloud. Not every asset is compatible with cloud platforms. Before migrating a workload to the cloud, assess each workload and all dependent assets.

You can use the [Plan methodology of the Cloud Adoption Framework](../../plan/index.md) for approaches to assess and plan for the migration. This plan advises you to use [incremental rationalization](../../digital-estate/rationalize.md#incremental-rationalization) and [power of 10](../../digital-estate/rationalize.md#release-planning) approaches. It also includes best practices for [using Azure Migrate to assess your digital estate](../../plan/contoso-migration-assessment.md).

The above links suggest that assumptions are acceptable and often encouraged during the planning stages of migration. Those assumptions should be challenged per-workload before migrating to the cloud.

### Two steps of incremental rationalization

Successfully delivering [incremental rationalization](../../digital-estate/rationalize.md#incremental-rationalization) requires two equally weighted steps. Both steps require data and insights into the environment. However, each approach respects the amount of time and granularity of detail needed to be successful in a migration effort.

- [Power of 10 release planning](../../digital-estate/rationalize.md#release-planning): During initial rationalization and release planning, only use one of the [five Rs of rationalization](../../digital-estate/5-rs-of-rationalization.md) in the assessment. Estimate and plan based on the rationalization option that best aligns with the overall motivations in the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx).

- **Detailed assessment of each workload:** The assumptions associated with Power of 10 release planning are good enough to build a plan. But those same assumptions can cause significant issues if not evaluated before migration.

### Challenge assumptions and update the plan

Closely review the assessment data in Azure Migrate or your chosen assessment tool. This data provides insights into compatibility issues, remediation requirements, sizing suggestions, and other considerations.

Before migration, use that data, along with discovery conversations, to evaluate the feasibility of migrating this specific workload. The discovery conversations occur with the product owner, development teams, administrators, and others. Use this discovery to challenge core assumptions about this workload. If the findings change the migration or adoption plan, update the plan as needed.

The first step in challenging these assumptions is a [review of all five Rs of rationalization](../../digital-estate/rationalize.md).

- Does the assumed rationalization approach work for this workload? Is it the best approach?
- Will any of the [physics of replication](../migration-considerations/migrate/replicate.md#replication-risks-physics-of-replication) impact the migration of this workload?
- Does this workload require any [remediation activities](../migration-considerations/assess/evaluate.md) before migration?

These questions help challenge assumptions and lead to the best path for each workload.

For more questions and a process for validating assumptions, see the [overview of assessment process improvements](../migration-considerations/assess/index.md).

## Timelines

You can usually complete the migration scenario covered by this guide in one to six months.

When evaluating the timeline of your migration, consider the following:

- **Assets to migrate:** What is the number and diversity of assets like infrastructure, apps, and data? Do they have any dependencies that need to be migrated too?
- **Staff readiness:** Is your staff ready to manage the new environment or do they need training?
- **Funding:** Do you have the appropriate approval and budget to complete the migration?
- **Change management:** Does your business have specific change implementation and approval requirements?
- **Segment regulations:** Do you have to comply with segment or industry regulations?

## Cost management

Assessing your environment provides an excellent opportunity to include a cost analysis step. You can analyze and predict costs using the data collected by the assessment activities. This cost prediction should factor in the consumption service costs and any one-time costs, like increased data ingress.

During migration, certain factors affect decisions and execution activities:

- **Digital estate size:** Understanding the size of your digital estate directly affects decisions and the resources required to migrate.
- **Accounting models:** Shifting from a structured capital expense model to a fluid operating expense model.

While doing this assessment, it's also important to factor in cost of running the workloads as-is. This helps in creating a business case and gives more clarity on TCO of your workloads.

::: zone target="docs"

The following resources provide related information:

- [Estimate cloud costs](../migration-considerations/assess/estimate.md)
- [Business Case for Cloud Migration](../../strategy/cloud-migration-business-case.md)
  
::: zone-end

## Tools

You need data, an assessment tool and organizational understanding to make informed migration decisions. Azure Migrate is the native tool for assessing **and** migrating to Azure.

### Azure Migrate

Azure Migrate provides a centralized hub to assess and migrate to Azure on-premises servers, infrastructure, applications, and data. This service:

- Assesses whether on-premises servers, databases or applications are ready for migration to Azure.
- Estimates the size of Azure virtual machines (VMs), Azure SQL configuration, or the number of Azure VMware Solution nodes after migration.
- Estimates costs for running on-premises servers in Azure.
- Identifies cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

If you're considering a lift-and-shift approach or are in the early assessment stages of migration, this service is for you. After completing the assessment, use Azure Migrate to execute the migration.

![Azure Migrate overview](./media/assess/azure-migrate-overview-1.png)

#### Create a new project

::: zone target="chromeless"

Begin server discovery, assessment, and migration by using the following steps for Azure Migrate:

1. Select **Azure Migrate**.
2. In **Get started**, select **Discover, assess and migrate**.
3. In **Servers, databases and web apps**, select **Create project**.
4. In **Create project**, select the Azure subscription and resource group. Create a resource group if you don't have one.
5. In **Project Details**, specify the project name and the geography in which you want to create the project, then select **Create**.
6. After creating the project, tools are visible, and the user can start with Discovery.

::: zone-end

::: zone target="docs"

To begin server discovery, assessment, and migration, see [create and manage projects](/azure/migrate/create-manage-projects) with Azure Migrate.

#### Assess on-premises workloads

Assess various on-premises workloads to measure cloud readiness, identify risks, and estimate costs and complexity. See the following resources to learn how Azure Migrate can help you in your migration assessment:

- [Create an Azure VM assessment](/azure/migrate/how-to-create-assessment)
- [Create an Azure SQL assessment](/azure/migrate/how-to-create-azure-sql-assessment)
- [Create an Azure App Service assessment](/azure/migrate/how-to-create-azure-app-service-assessment)
- [Create an Azure VMware Solution assessment](/azure/migrate/how-to-create-azure-vmware-solution-assessment)

Additional resources:

- [Migrate physical or virtualized servers to Azure](/azure/migrate/tutorial-migrate-physical-virtual-machines)
- [Azure Migrate in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Migrate/AmhResourceMenuBlade/overview)

::: zone-end

#### Azure Migrate dependency analysis

[Azure Migrate dependency analysis](/azure/migrate/concepts-dependency-visualization) identifies dependencies between discovered on-premises servers. It provides the following advantages:

- Gather servers into groups for a better assessment.
- Identify servers to migrate together. This step is helpful if you need clarification on which servers are part of an app deployment you want to migrate.
- Identify whether servers are in use and which servers you can decommission instead of migrate.
- Analyze dependencies to ensure nothing is left behind and avoid surprise outages after migration.
- Use the Azure Migrate [Business case](/azure/migrate/how-to-build-a-business-case) capability to help you analyze dependencies and build a business proposal to understand how migrating to Azure brings the most value to your business.

#### Azure Migrate discovery and assessment prerequisites

If you rely on the [Azure Migrate: Discovery and assessment](/azure/migrate/migrate-services-overview#azure-migrate-discovery-and-assessment-tool) tool, make sure you review the prerequisites for various types of assessments, as listed below:

- [Support matrix for VMware discovery](/azure/migrate/migrate-support-matrix-vmware)
- [Support matrix for Hyper-V assessment](/azure/migrate/migrate-support-matrix-hyper-v)
- [Support matrix for physical server discovery and assessment](/azure/migrate/migrate-support-matrix-physical)

<!-- markdownlint-disable MD024 -->

#### Azure Advisor Service Retirement workbook

Being informed about upcoming Azure services and feature retirements is essential to understand their impact on your workloads and planning migration.

The Service Retirement workbook gives you a centralized resource-level view of service retirements. This workbook helps you assess, evaluate options, and plan for migration from retiring services and features.

To learn more, see [Prepare migration of your workloads impacted by service retirement](/azure/advisor/advisor-how-to-plan-migration-workloads-service-retirement).
