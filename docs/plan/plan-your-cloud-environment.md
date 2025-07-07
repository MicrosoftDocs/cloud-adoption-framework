# Plan your Azure environment for cost estimation

This article defines how to create accurate cost estimates for your Azure environment by documenting architectural decisions and service selections. A basic architecture provides the context required to estimate costs with precision. This foundational understanding ensures that cost models reflect the actual scope of services, platform dependencies, and operational requirements. Without this clarity, cost estimates lack the specificity needed for planning and governance.

## Plan your platform architecture

A platform architecture defines the shared services and centralized management capabilities that support all workloads in your Azure environment. This architecture is essential for estimating platform-level costs and planning for operational readiness. Follow these recommendations:

1. **Use an Azure landing zone as the foundation for your platform architecture.** Azure landing zones provide a scalable and secure foundation for enterprise environments. They include critical components such as identity, network, and governance controls. Use the guidance in [What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/).

2. **Defer platform architecture for early-stage startups.** Startups or small teams can begin without implementing shared services, hybrid or multi-cloud connectivity, or on-premises identity management. Instead, implement a thoughtful resource hierarchy to organize and govern resources. As your environment scales, incrementally adopt Azure landing zone components to support growth and governance.

## Plan your workload architecture

A workload architecture defines the Azure services, regions, and configurations required to meet business and technical requirements. You must define workload architecture for both migrated and cloud-native workloads to ensure accurate cost modeling and operational readiness. Follow these recommendations:

1. **Document workload requirements and configurations.** Identify the Azure services, regions, and configurations needed to meet business and technical goals. Include dependencies, performance needs, and compliance requirements.

## Plan to use the right Azure services

For platform and workload resources, outline the services you should use based on your requirements. Follow these recommendations:

1. **Use the Azure Architecture Center and decision guides to select services.** Use the [Azure Architecture Center](/azure/architecture/browse/) and [Azure technology decision guides](/azure/architecture/guide/technology-choices/technology-choices-overview) to identify the most appropriate services for your scenario. For those migrating from other clouds, use the [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) or [GCP to Azure service mapping](/azure/architecture/gcp-professional/services).

2. **Plan to prefer managed services.** Use Platform as a Service (PaaS) offerings unless infrastructure-level control is required.

3. **Plan to standardize service selection.** Define and enforce service selection standards to reduce support complexity and prevent cost sprawl. Standardization improves operational efficiency and simplifies governance. For guidance, see [CAF Govern](/azure/cloud-adoption-framework/govern/document-cloud-governance-policies).

## Plan for single region vs multiregion deployment

A regional strategy defines the reliability and compliance posture of your workloads. For platform and workload resources, you must document whether workloads operate in a single region or across multiple regions and define their reliability requirements. Follow these recommendations:

1. **Document regional strategy and reliability requirements.** Identify whether the workload operates in a single region or multiple regions. Define service level objectives (SLOs), recovery point objectives (RPOs), and recovery time objectives (RTOs). For more information, see [Manage reliability in Azure](/azure/cloud-adoption-framework/manage/protect#manage-reliability).

2. **Ensure compliance with industry standards.** Validate that your architecture and backup configurations meet compliance requirements such as MARS-E.

## Choose the service SKU/tier

Each Azure service offers multiple SKUs or tiers with different performance and availability characteristics. You must select the right SKU based on workload requirements. Follow these recommendations:

1. **Use historical data for migrated workloads.** For workloads you migrate, use performance and usage data gathered during the assessment phase to select the appropriate SKU.

2. **Ensure high availability for critical workloads.** Choose SKUs that support Availability Zones for Mission Critical and Business Critical workloads.

## Estimate costs based on architecture

A cost estimate provides the financial foundation for cloud adoption planning. Accurate cost estimation supports budgeting, governance, and business case development. You must estimate costs based on your defined architecture and continuously refine those estimates to align with actual usage and business goals. Follow these recommendations:

1. **Use the Azure Pricing Calculator.** The [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/) allows you to estimate costs for each service in your architecture. For existing workloads, use historical usage data to inform estimates. For new workloads, estimate based on projected usage and test deployments. This approach ensures that cost estimates reflect realistic consumption patterns and architectural decisions.

2. **Use Azure Migrate for discovered inventory (migration only).** If you use Azure Migrate, you can [estimate costs](/azure/migrate/concepts-business-case-calculation?view=migrate) for all discovered on-premises workloads. This tool helps you understand the cost implications of migrating existing infrastructure to Azure. Use this data to inform migration planning and validate business case assumptions.

3. **Reevaluate cost estimates when projections are too high or low.** Review the output of the Azure Pricing Calculator and compare it to your organization’s budget expectations. If the estimate significantly exceeds or falls below expectations, it may indicate architectural misalignment, incorrect service selections, or unrealistic usage assumptions. Identify the architectural elements contributing most to the estimated cost. Focus on high-cost services, premium SKUs, or multi-region deployments. Validate whether these choices are necessary to meet business, performance, or compliance requirements. Adjust the architecture to better align with cost and performance goals.

4. **Test workloads in Azure to validate assumptions.** Deploy representative workloads in a test environment to observe actual usage patterns and resource consumption. Use this data to refine your cost model and validate whether the selected services and configurations meet performance and budget expectations.

5. **Record architecture decisions and cost estimates.** Document all service selections, SKUs, regions, and estimated costs. This documentation supports governance, enables future optimization, and provides traceability for architectural decisions. Include this information in your cloud adoption plan to ensure alignment across teams.

6. **Save cost estimates as a baseline.** Establish a cost baseline to compare estimated versus actual costs during and after deployment. This baseline supports cost governance, enables variance analysis, and informs future planning cycles.

7. **Enter all this information into your plan.** It becomes the blueprint for the Ready and Adopt phases. Save and document the estimated cost as a baseline and reference point for estimated vs. actual cost later.