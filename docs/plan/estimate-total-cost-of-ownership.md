---
title: Plan your Azure environment for cost estimation
description: Learn how to create accurate cost estimates for your Azure environment by documenting architectural decisions and service selections.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/17/2023
ms.topic: conceptual
---

# Plan your Azure environment for cost estimation

This article defines how to create accurate cost estimates for your Azure environment by documenting architectural decisions and service selections. A basic architecture provides the context required to estimate costs with precision. This foundational understanding ensures that cost models reflect the actual scope of services, platform dependencies, and operational requirements. Without this clarity, cost estimates lack the specificity needed for planning and governance.

## Plan your architecture

The architecture of your Azure environment includes your platform and all workloads. You need to have a general architecture plan, which you can modify and refine later, to estimate the total cost of ownership in Azure. Follow this guidance.

1. **Plan your platform architecture.** A platform architecture defines the shared services and centralized management capabilities that support all workloads in your Azure environment. This architecture is essential for estimating platform-level costs and planning for operational readiness. Follow these recommendations:

    - **Use an Azure landing zone as the foundation for your platform architecture.** Azure landing zones provide a scalable and secure foundation for enterprise environments. They include critical components such as identity, network, and governance controls. Use the guidance in [What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/).

    - **Defer platform architecture for early-stage startups.** Startups or small teams can begin without implementing shared services, hybrid or multi-cloud connectivity, or on-premises identity management. Instead, implement a resource hierarchy to organize and govern resources. As your environment scales, incrementally adopt Azure landing zone components to support growth and governance.

2. **Plan your workload (application) architecture.** A workload architecture defines the Azure services, regions, and configurations required to meet business and technical requirements. Identify the Azure services, regions, and configurations needed to meet business and technical goals. Include dependencies, performance needs, and compliance requirements. Use the [Azure Architecture Center](/azure/architecture/browse/) to get ideas. You can download most of the diagrams and tweak them to fit your needs.

## Select the appropriate Azure services

Azure offers hundreds of cloud services with different capabilities and pricing models. You need to choose the right services for your platform and workload requirements to create accurate cost estimates. Service selection directly impacts both initial and ongoing costs in your environment. Follow these recommendations:

1. **Use decision guides to select optimal services.** Decision guides help you navigate the complexity of Azure's service catalog and identify cost-effective options for your specific requirements. Use [Azure technology decision guides](/azure/architecture/guide/technology-choices/technology-choices-overview) to evaluate and select appropriate services based on technical requirements.

2. **Choose managed services for cloud-native workloads.** Managed services (PaaS offerings) provide reduced operational overhead compared to infrastructure services for security, reliability, and performance. Select platform as a service (PaaS) offerings for new workloads unless you require specific infrastructure-level control for performance, compliance, or compatibility reasons. This approach reduces operational costs and minimizes the need for infrastructure management. See [CAF Innovate](../innovate/index.md) for cloud-native guidance.

3. **Align service selection with your migration strategy.** Your migration approach determines which Azure services best fit your workloads. For rehosting (like-for-like) migrations, select services that match your current environment. For replatforming adn rearchitecting efforts, identify appropriate PaaS solutions that best support your modernized architecture. If you are migrating from other cloud providers, use the [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) or [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) to find the right services.

4. **Establish service selection standards.** Create consistent service selection guidelines across your organization to improve cost management and operational efficiency. Define and document standard service selections for common workload patterns to prevent unnecessary variation. These standards reduce support complexity, enable volume discounts, and simplify governance controls. For implementation guidance, see [CAF Govern](/azure/cloud-adoption-framework/govern/document-cloud-governance-policies).

## Choose the right service tier

Each Azure service offers multiple service tiers (or SKUs) with different performance and availability characteristics. You must select the right SKU based on workload requirements. Follow these recommendations:

1. **Use historical data for migrated workloads.** For workloads you migrate, use the [architecture component requirements](./assess-workloads-for-cloud-migration.md#assess-architecture-component-requirements) you gathered during the assessment phase to select the appropriate SKU.

2. **Use target metrics for new workloads.** For new workloads, use the estimated user base and tests to pick the right service tier.

3. **Ensure high availability for critical workloads.** Choose service tiers that support Availability Zones for Mission Critical and Business Critical workloads.

## Choose single region or multiregion deployment

A regional strategy defines the reliability and compliance posture of your workloads. For platform and workload resources, you must document whether workloads operate in a single region or across multiple regions and define their reliability requirements. Follow these recommendations:

1. **Document regional strategy and reliability requirements.** Identify whether the workload operates in a single region or multiple regions. Define service level objectives (SLOs), recovery point objectives (RPOs), and recovery time objectives (RTOs). For more information, see [Manage reliability in Azure](/azure/cloud-adoption-framework/manage/protect#manage-reliability).

2. **Ensure compliance with industry standards.** Validate that your architecture and backup configurations meet compliance requirements such as MARS-E.

## Estimate costs based on architecture

A cost estimate provides the financial foundation for cloud adoption planning. Accurate cost estimation supports budgeting, governance, and business case development. You must estimate costs based on your defined architecture and continuously refine those estimates to align with actual usage and business goals. Follow these recommendations:

1. **Use cost estimation tooling.** The [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) allows you to estimate costs for each service in your architecture. For existing workloads, use historical usage data to inform estimates. For new workloads, estimate based on projected usage and test deployments. This approach ensures that cost estimates reflect realistic consumption patterns and architectural decisions. If you use Azure Migrate, you can [estimate costs](/azure/migrate/concepts-business-case-calculation) for all discovered on-premises workloads. This tool helps you understand the cost implications of migrating existing infrastructure to Azure. Use this data to inform migration planning and validate business case assumptions.

2. **Estimate operational cost.** Identify required skills and training for teams to operate and support the target service model. Plan for changes in engineering practices and delivery processes that the new service model introduces. Engage stakeholders to validate assumptions and align service model decisions with business objectives.

3. **Reevaluate cost estimates when projections are too high or low.** Review the output of the Azure Pricing Calculator and compare it to your organization's budget expectations. If the estimate significantly exceeds or falls below expectations, it may indicate architectural misalignment, incorrect service selections, or unrealistic usage assumptions. Identify the architectural elements contributing most to the estimated cost. Focus on high-cost services, premium SKUs, or multi-region deployments. Validate whether these choices are necessary to meet business, performance, or compliance requirements. Adjust the architecture to better align with cost and performance goals.

4. **Test workloads in Azure to validate assumptions.** Deploy representative workloads in a test environment to observe actual usage patterns and resource consumption. Use this data to refine your cost model and validate whether the selected services and configurations meet performance and budget expectations. For a basic Azure environment setup, see [Azure setup guide](../ready/azure-setup-guide/index.md).

5. **Record architecture decisions and cost estimates.** Document all service selections, SKUs, regions, and estimated costs. This documentation supports governance, enables future optimization, and provides traceability for architectural decisions. Include this information in your cloud adoption plan to ensure alignment across teams.

6. **Save cost estimates as a baseline.** Establish a cost baseline to compare estimated versus actual costs during and after deployment. This baseline supports cost governance, enables variance analysis, and informs future planning cycles.

## Document the cloud adoption plan

A cloud adoption plan compiles all architectural, operational, and cost decisions into a single reference document. This plan guides the Ready and Adopt phases and ensures alignment across technical and business stakeholders. You must document plans for both migrated and cloud-native workloads, along with the people and process decisions that support adoption. Follow these recommendations:

## Document organization and process decisions

A complete cloud adoption plan includes the operating model, team responsibilities, and skilling plans. You must define how teams should operate, who is accountable for each function, and how skills will evolve to support cloud adoption. Ensure that both technical and business stakeholders review and approve the plan to establish shared ownership and alignment.

## Document the plan for each workload

- **Document plan for each workload you plan to migrate.** A migration plan defines how existing workloads transition to Azure. This plan includes an inventory of workloads, the treatment strategy for each workload (such as rehost, refactor, or replace), and the results of assessments that capture specifications, requirements, and dependencies. You must also define success metrics to evaluate the effectiveness of the migration. This documentation ensures that migration activities align with business goals and technical constraints.

- **Document the plan for each workload you build cloud-native.** A cloud-native plan defines the workloads you intend to build directly in Azure using cloud-native services. This plan includes a list of planned workloads, architectural decisions, service selections, and success metrics. You must define how each workload supports business objectives and how it will be deployed and operated in Azure. This documentation ensures that cloud-native development aligns with platform capabilities and governance requirements.

## Align with standards and frameworks

A cloud adoption plan must align with your organization’s project management office (PMO) standards and integrate into existing governance and delivery frameworks. This alignment ensures consistency in planning, reporting, and risk management across all cloud initiatives. You must embed cloud adoption activities into enterprise project structures to ensure visibility, accountability, and control. Follow these recommendations:



## Next step

By the end of the Plan phase, you have a cloud adoption roadmap that all stakeholders understand. You’ve made the big decisions: what goes to Azure, how it will go, when it will go, and who will do it. Now it’s time to get your Azure foundation ready.

[CAF Ready](../ready/index.md)
