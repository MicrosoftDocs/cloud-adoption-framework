---
title: Assess workloads and validate assessment assumptions before migration
description: Use the Cloud Adoption Framework for Azure to learn how to validate assessment assumptions before beginning migration to the cloud.
author: Zimmergren
ms.author: tozimmergren
ms.date: 12/05/2023
ms.topic: conceptual
---

# Assess workloads and validate assumptions before migration

Many of your existing workloads are ideal candidates for cloud migration. Not every asset, though, is compatible with cloud platforms and not all workloads can benefit from hosting in the cloud. [Digital estate planning](../../../digital-estate/index.md) allows you to generate an overall [migration backlog](../prerequisites/technical-complexity.md#migration-backlog) of potential workloads to migrate. However, this planning effort is high level. It relies on assumptions made by the cloud strategy team and doesn't dig deeply into technical considerations.

As a result, before migrating a workload to the cloud it's critical to assess the individual assets associated with that workload for their migration suitability. Your cloud adoption team should evaluate technical compatibility, required architecture, performance/sizing expectations, and dependencies. Use this information to ensure the migrated workload can be deployed to the cloud effectively.

The *assess* process is the first of four incremental activities that occur within an iteration. As discussed in the [technical complexity and change management article](../prerequisites/technical-complexity.md), a decision should be made in advance to determine how you should run this phase. In particular, will the cloud adoption team complete assessments during the same sprint as the actual migration effort? Or, will a wave or factory model be used to complete assessments in a separate iteration? If the answer to these questions can't be answered by every member of the team, revisit the [Prerequisites for migration](../prerequisites/index.md) article.

## Goals

* Assess a migration candidate.
* Evaluate the workload, associated assets, and dependencies before migration.

## Definition of done

This process is complete when the following are known about a single migration candidate:

* The path from on-premises to cloud, including production promotion approach decision, has been defined.
* Any required approvals, changes, cost estimates, or validation processes have been completed to allow the cloud adoption team to execute the migration.

## Accountability during assessment

The cloud adoption team is accountable for the entire assessment process. However, members of the cloud strategy team have a few responsibilities, as listed in the following section.

## Responsibilities during assessment

Along with the high-level accountability, there are actions that an individual or group needs to be directly responsible for. The following are a few activities that require assignments to responsible parties:

- **Business priority.** The team understands the purpose for migrating this workload, including any intended effects on the business.
  - A member of the cloud strategy team should carry final responsibility for this activity, under the direction of the cloud adoption team.
- **Stakeholder alignment.** The team aligns expectations and priorities with internal stakeholders, identifying success criteria for the migration. What does success look like post-migration?
- **Refined rationalization.** Evaluate the initial assumptions about rationalization. Should a different [rationalization approach](../../../digital-estate/rationalize.md) be used to migrate this specific workload?
- **Modernization decisions.** Whatever the rationalization decision, should the team modernize various assets in the workload to use PaaS-based solutions?
- **Cost.** Estimate the cost of the target architecture, and adjust the overall budget.
- **Migration support.** The team decides how they'll complete the technical work of the migration, including decisions about partner or Microsoft support.
- **Evaluation.** The team evaluates the workload for compatibility and dependencies.
  - Assign this activity to a subject matter expert who is familiar with the architecture and operations of the candidate workload.
- **Architect.** The team agrees on the final state architecture for the migrated workload.
- **Migration tooling.** Depending on modernization and architecture approaches, use different kinds of migration tools to automate the migration. Based on the proposed architecture, will this migration use the best [migration tools](../../azure-migration-guide/migration-tools-decision-guide.md)?
- **Backlog alignment.** The cloud adoption team reviews requirements and commits to the migration of the candidate workload. After commitment, the team updates the release backlog and iteration backlog.
- **Work breakdown structure or work-back schedule.** The team establishes a schedule of major milestones identifying goals for when to complete planning, implementation, and review processes.
- **Final approval.** Any necessary approvers have reviewed the plan and have signed off on the approach to migrate the asset.
  - To avoid surprises later in the process, involve at least one representative of the business in the approval process.

> [!CAUTION]
> This full list of responsibilities and actions can support large and complex migrations involving multiple roles with varying levels of responsibility, and requiring a detailed approval process. Smaller and simpler migration efforts may not require all of roles and actions described here. To determine which of these activities add value and which are unnecessary, your cloud adoption team and the cloud strategy team should use this complete process as part of your first workload migration. After the workload has been verified and tested, the team can evaluate this process and choose which actions to use moving forward.

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

## Next steps

With a general understanding of the assessment process, you're ready to begin the process by [classifying workloads](./classify.md).

> [!div class="nextstepaction"]
> [Classify workloads](./classify.md)
