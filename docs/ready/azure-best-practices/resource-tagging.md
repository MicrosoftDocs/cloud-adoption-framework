---
title: Define your tagging strategy
description: Learn about recommendations for tagging your Azure resources and assets and how to define your tagging strategy.
author: Zimmergren
ms.author: pnp
ms.date: 12/28/2021
ms.topic: conceptual
ms.custom: internal, readiness, fasttrack-edit
---

# Define your tagging strategy

Tags are metadata elements that are attached to resources and are valid across all regions under your tenant. Tags consist of pairs of key-value strings. The values that you include in these pairs are based on the requirements of your business. When you incorporate your comprehensive naming and tagging policy, apply a consistent set of global tags for overall governance.

## Define your tagging requirements

A clear tagging strategy ensures your resources align with business goals and operational needs. Resource tags provide the foundation for cost management, governance, and automation across your Azure environment. You must assess your specific requirements to create effective tagging standards. Here's how:

1. **Evaluate existing policies.** Your Azure tagging approach must align with current organizational standards to maintain consistency. Inconsistent tagging creates confusion and reduces the effectiveness of resource management. Review your company's existing naming conventions and governance policies to ensure your Azure tags complement these established practices.

2. **Determine cost allocation needs.** Tags support detailed cost tracking for chargeback or showback reporting across departments and business units. Identify whether you need granular cost allocation beyond the subscription level to support accurate billing and budget management. For more information, see [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance).

3. **Identify operational and compliance requirements.** Resource tags capture critical operational metadata that supports automation and compliance reporting. Different resources require different operational details such as backup schedules, security classifications, or regulatory compliance status. Define which operational and compliance details your tags must track to support your requirements.

4. **Establish governance boundaries.** Clear governance defines which tags are mandatory and which remain optional across your organization. Centralized IT policies typically enforce core tags while allowing teams flexibility for custom requirements. Determine your mandatory tag requirements and establish guidelines for optional tags to balance governance with team autonomy.

## Implement consistent tagging

Tag consistency enables effective resource management and cost tracking across your entire Azure footprint. Inconsistent regional tagging creates operational complexity and reduces reporting accuracy. You need to use the same core tagging schema for all resources to maintain governance and simplify automation. Here's how:

1. **Enforce tagging compliance with Azure Policy.** Azure Policy provides built-in and custom policy definitions to enforce your tagging requirements consistently across all regions. Automated policy enforcement ensures tagging compliance without manual oversight. Configure [policy assignments](/azure/governance/policy/assign-policy-portal) with [resource selectors](/azure/governance/policy/concepts/assignment-structure#resource-selectors) like *resourceLocation* to target specific regions and enforce region-appropriate tagging rules within your defined scope. For more information, see [Assign policy definitions for tag compliance](/azure/azure-resource-manager/management/tag-policies).

1. **Do not add sensitive values to tags.** Tags store data as plain text and remain visible through cost reports, API responses, deployment histories, exported templates, and monitoring logs. Don't store sensitive values such as passwords, personal information, or confidential business data in resource tags.

1. **Understand case sensitivity in tags.** Tag keys are case insensitive, but tag values are case-sensitive. Case sensitivity differences can create confusion when you filter resources or generate reports based on tag values. Apply consistent casing for tag values to ensure accurate resource management and reporting. Use lowercase for tag keys and maintain consistent capitalization for tag values. For example, `Environment: production` and `environment: production` represent the same tag. However, `environment: Production` and `environment: production` are different values that appear separately in cost reports and resource queries.

1. **Include tags that indicate region.** Multi-region Azure operations need clear regional visibility to support compliance, cost allocation, and operational management requirements. Add region-specific tags like "region: eastus" to maximize operational efficiency and enable accurate regional reporting across your deployments.

1. **Understand which services support tags.** Not every Azure resource supports tags. For a list, see [Tag support for Azure resources](/azure/azure-resource-manager/management/tag-support).

## Apply core tagging patterns

Core tagging patterns provide proven frameworks for organizing Azure resources according to different business and operational needs. Multiple tagging approaches work together to support comprehensive resource management across your organization. You must implement foundational tagging patterns that align with your governance requirements and operational processes. Here's how:

1. **Use functional tags for operational management.** Functional tags categorize resources by their technical role, environment, and deployment characteristics within your workloads. Operational teams need clear resource identification to support deployment automation, monitoring, and troubleshooting activities. Apply functional tags like application name, tier, environment, and region to enable effective resource organization and operational oversight.

1. **Apply classification tags for governance and security.** Classification tags identify the sensitivity level, compliance requirements, and usage policies that apply to each resource. Security and compliance teams need clear resource classification to enforce appropriate protection measures and access controls. Implement classification tags such as data confidentiality levels and SLA requirements to support automated policy enforcement and compliance reporting.

1. **Implement accounting tags for cost management.** Accounting tags associate resources with specific organizational units, projects, or cost centers to enable accurate financial tracking and reporting. Finance teams need detailed cost attribution to support chargeback, showback, and budget management processes. Use accounting tags like department, program, and region to facilitate precise cost allocation and financial accountability. For more information, see [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance).

1. **Establish purpose tags for business alignment.** Purpose tags connect resources to specific business functions, processes, and impact levels to support investment decisions and priority management. Business stakeholders need clear visibility into how IT resources support organizational objectives and revenue generation. Deploy purpose tags such as business process, business impact, and revenue impact to demonstrate IT value and guide resource optimization decisions.

1. **Define ownership tags for accountability.** Ownership tags identify the business units and operational teams responsible for each resource to ensure clear accountability and effective communication. Resource management requires defined ownership to support incident response, change management, and lifecycle planning activities. Establish ownership tags including business unit and operations team to maintain clear responsibility boundaries and enable efficient resource governance.

| Tag type | Examples | Description |
|--|--|--|
| Functional | `app` = `catalogsearch1` <br> `tier` = `web` <br> `webserver` = `apache` <br> `env` = `prod` <br> `env` = `staging` <br> `env` = `dev` <br> `region` = `eastus` <br> `region` = `uksouth` | Categorizes resources by their purposes within a workload, environment, and region they're deployed to, or other functionality and operational details |
| Classification | `confidentiality` = `private` <br> `SLA` = `24hours` | Classifies a resource by use and the policies that apply to it |
| Accounting | `department` = `finance` <br> `program` = `business-initiative` <br> `region` = `northamerica` | Associates a resource with specific groups within an organization for billing purposes.  |
| Purpose | `businessprocess` = `support` <br> `businessimpact` = `moderate` <br> `revenueimpact` = `high` | Aligns resources to business functions to better support investment decisions. |
| Ownership | *BusinessUnit* <br><br> <li> `Finance` <li> `Marketing` <li> `Product XYZ` <li> `Corp` <li> `Shared` *OpsTeam* <br><br> <li> `Central IT` <li> `Cloud operations` <li> `ControlCharts team` <li> `MSP-{Managed Service Provider name}` | Top-level division of your company that owns the subscription or workload that the resource belongs to. In smaller organizations, this tag might represent a single corporate or shared top-level organizational element. Team accountable for day-to-day operations. |

## Use tags to support Microsoft assessments

For Microsoft to use during workload assessment, apply existing tags that accurately identify the workload. If the workload doesn't already have tags, refer to the following examples to guide the creation of new tags. See [Label mission-critical workloads](/azure/azure-resource-manager/management/tag-mission-critical-workload)

## Tag examples

Use the following tags to increase visibility into the usage of Azure resources.

| Tag name | Description | Key: value examples |
|--|--|--|
| **Application name** | Added granularity, if the workload is subdivided across multiple applications or services. | *ApplicationName* <br><br> <li> `IssueTrackingSystem` |
| **Approver name** | Person responsible for approving costs related to the resource. | *Approver* <br><br> <li> `chris@contoso.com` |
| **Budget required/approved** | Money approved for the application, service, or workload. | *BudgetAmount* <br><br> <li> `$200,000` |
| **Cost center** | Accounting cost center associated with the resource. | *CostCenter* <br><br> <li> `55332` |
| **Disaster recovery** | Business criticality of the application, workload, or service. | *DR* <br><br> <li> `Mission-critical` <li> `Critical` <li> `Essential` |
| **End date of the project** | Date when the application, workload, or service is scheduled for retirement. | *EndDate* <br><br> <li> `2023-10-15` |
| **Environment** | Deployment environment of the application, workload, or service. | *Env* <br><br> <li> `Prod` <li> `Dev` <li> `QA` <li> `Stage` <li> `Test` |
| **Azure region** | Region where you create the resource. | *AzureRegion* <br><br> <li> `West Europe` <li> `UK South` <li> `East US` <li> `Japan East` <li> `Qatar Central` |
| **Owner name** | Owner of the application, workload, or service. | *Owner* <br><br> <li> `jane@contoso.com` |
| **Requester name** | User who requested the creation of the application. | *Requester* <br><br> <li> `john@contoso.com` |
| **Service class** | Service-level agreement level of the application, workload, or service. | *ServiceClass* <br><br> <li> `Dev` <li> `Bronze` <li> `Silver` <li> `Gold` |
| **Start date of the project** | Date when the application, workload, or service was first deployed. | *StartDate* <br><br> <li> `2020-10-15` |

## Next step

> [!div class="nextstepaction"]
> [Move resource groups and assets between subscriptions](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
