---
title: Define your tagging strategy
description: Learn about recommendations for tagging your Azure resources and assets and how to define your tagging strategy.
author: stephen-sumner
ms.author: pnp
ms.date: 06/19/2025
ms.topic: conceptual
---

# Define your tagging strategy

This article shows you how to create an effective tagging strategy that supports cost management, governance, and automation across your Azure environment. For guidance on developing a tagging convention, see [Define you naming convention](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging).

## Why use Azure resource tags?

Azure resource tags provide essential metadata that enables accurate cost tracking, automated policy enforcement, and operational oversight for all your Azure resources. Tags consist of key-value pairs (tag name: tag value) that you attach to Azure resources to categorize them according to your business and operational requirements. A comprehensive tagging strategy ensures consistent resource organization, improves visibility across your Azure environment, and supports automated management processes that scale with your organization's growth.

## Define your tagging requirements

A clear tagging strategy ensures your resources align with business goals and operational needs. Resource tags provide the foundation for cost management, governance, and automation across your Azure environment. You must assess your specific requirements to create effective tagging standards. Here's how:

1. **Evaluate existing policies.** Your Azure tagging approach must align with current organizational standards to maintain consistency. Inconsistent tagging creates confusion and reduces the effectiveness of resource management. To ensure your Azure tags complement these established practices, review your company's existing naming conventions and governance policies.

2. **Determine cost allocation needs.** Tags support detailed cost tracking for chargeback or showback reporting across departments and business units. Identify whether you need granular cost allocation beyond the subscription level to support accurate billing and budget management. For more information, see [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance).

3. **Identify operational and compliance requirements.** Resource tags capture critical operational metadata that supports automation and compliance reporting. Different resources require different operational details such as backup schedules, security classifications, or regulatory compliance status. Define which operational and compliance details your tags must track to support your requirements.

4. **Establish governance boundaries.** Clear governance defines which tags are mandatory and which remain optional across your organization. Centralized IT policies typically enforce core tags while allowing teams flexibility for custom requirements. Determine your mandatory tag requirements and establish guidelines for optional tags to balance governance with team autonomy.

## Implement consistent tagging

Tag consistency enables effective resource management and cost tracking across your entire Azure footprint. Inconsistent regional tagging creates operational complexity and reduces reporting accuracy. You need to use the same core tagging schema for all resources to maintain governance and simplify automation. Here's how:

1. **Enforce tagging compliance with Azure Policy.** Azure Policy provides built-in and custom policy definitions to enforce your tagging requirements consistently across all regions. Automated policy enforcement ensures tagging compliance without manual oversight. Configure [policy assignments](/azure/governance/policy/assign-policy-portal) with [resource selectors](/azure/governance/policy/concepts/assignment-structure#resource-selectors) like *resourceLocation* to target specific regions and enforce region-appropriate tagging rules within your defined scope. For more information, see [Assign policy definitions for tag compliance](/azure/azure-resource-manager/management/tag-policies).

1. **Do not add sensitive values to tags.** Tags store data as plain text and remain visible through cost reports, API responses, deployment histories, exported templates, and monitoring logs. Don't store sensitive values such as passwords, personal information, or confidential business data in resource tags.

1. **Understand case sensitivity in tags.** Tag names (keys) are case insensitive, but tag values are case-sensitive. Case sensitivity differences can create confusion when you filter resources or generate reports based on tag values. Apply consistent casing for tag values to ensure accurate resource management and reporting. Use lowercase for tag names (keys) and maintain consistent capitalization for tag values. For example, `Environment: production` and `environment: production` represent the same tag. However, `environment: Production` and `environment: production` are different values that appear separately in cost reports and resource queries.

1. **Include tags that indicate region.** Multi-region Azure operations need clear regional visibility to support compliance, cost allocation, and operational management requirements. Add region-specific tags like "region: eastus" to maximize operational efficiency and enable accurate regional reporting across your deployments.

1. **Understand which services support tags.** Not every Azure resource supports tags. For a list, see [Tag support for Azure resources](/azure/azure-resource-manager/management/tag-support).

## Apply core tagging patterns

Core tagging patterns provide proven frameworks for organizing Azure resources according to different business and operational needs. Multiple tagging approaches work together to support comprehensive resource management across your organization. You must implement foundational tagging patterns that align with your governance requirements and operational processes. Here's how:

1. **Use functional tags for operational management.** Functional tags categorize resources by their technical role, environment, and deployment characteristics within your workloads. Operational teams need clear resource identification to support deployment automation, monitoring, and troubleshooting activities. To enable effective resource organization and operational oversight, apply functional tags like application name, tier, environment, and region.

1. **Apply classification tags for governance and security.** Classification tags identify the sensitivity level, compliance requirements, and usage policies that apply to each resource. Security and compliance teams need clear resource classification to enforce appropriate protection measures and access controls. Implement classification tags such as data confidentiality levels and service level agreement (SLA) requirements to support automated policy enforcement and compliance reporting.

1. **Implement accounting tags for cost management.** Accounting tags associate resources with specific organizational units, projects, or cost centers to enable accurate financial tracking and reporting. Finance teams need detailed cost attribution to support chargeback, showback, and budget management processes. Use accounting tags like department, program, and region for precise cost allocation. For more information, see [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance). Cost-related tags support [cloud accounting models](../../strategy/cloud-accounting.md), [return on investment (ROI) calculations](../../strategy/cloud-migration-business-case.md), [cost tracking](../../ready/azure-best-practices/track-costs.md), [budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json), [spending alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json), and [automated cost governance](../../govern/enforce-cloud-governance-policies.md#automate-cost-governance).

1. **Establish purpose tags for business alignment.** Purpose tags connect resources to specific business functions, processes, and impact levels to support investment decisions and priority management. Business stakeholders need clear visibility into how IT resources support organizational objectives and revenue generation. Deploy purpose tags such as business process, business impact, and revenue impact to demonstrate IT value and guide resource optimization decisions.

1. **Define ownership tags for accountability.** Ownership tags identify the business units and operational teams responsible for each resource to ensure clear accountability and effective communication. Resource management requires defined ownership to support incident response, change management, and lifecycle planning activities. Establish ownership tags including business unit and operations team to maintain clear responsibility boundaries and enable efficient resource governance.

| Tag type | Description | Examples |
|--|--|--|
| Functional | Categorizes resources by their purposes within a workload, environment, and region they're deployed to, or other functionality and operational details | `app : catalogsearch1` <br> `tier : web` <br> `webserver : apache` <br> `env : prod` <br> `env : staging` <br> `env : dev` <br> `region : eastus` <br> `region : uksouth` |
| Classification | Classifies a resource by use and the policies that apply to it | `confidentiality : private` <br> `sla : 24hours` |
| Accounting | Associates a resource with specific groups within an organization for billing purposes. | `department : finance` <br> `program : business-initiative` <br> `businesscenter : northamerica` |
| Purpose | Aligns resources to business functions to better support investment decisions. | `businessprocess : support` <br> `businessimpact : moderate` <br> `revenueimpact : high` |
| Ownership | Owner or team accountable for subscription. | `businessunit : finance` <br> `businessunit : marketing` <br> `businessunit : product xyz` <br> `businessunit : corp` <br> `businessunit : shared` <br> `opsteam : central it` <br> `opsteam : cloud operations` <br> `opsteam : controlcharts team` <br> `opsteam : msp-contoso` |

## Use tags to support Microsoft assessments

For Microsoft to use during workload assessment, apply existing tags that accurately identify the workload. If the workload doesn't already have tags, refer to the following examples to guide the creation of new tags. See [Label mission-critical workloads](/azure/azure-resource-manager/management/tag-mission-critical-workload)

## Tag examples

Use the following tags to increase visibility into the usage of Azure resources.

| Tag name | Description | Tag name: tag value examples |
|--|--|--|
| **Application name** | Added granularity, if the workload is subdivided across multiple applications or services. | `app : issuetrackingsystem` |
| **Approver name** | Person responsible for approving costs related to the resource. | `approver : chris@contoso.com` |
| **Budget required/approved** | Money approved for the application, service, or workload. | `budget : $200,000` |
| **Cost center** | Accounting cost center associated with the resource. | `costcenter : 55332` |
| **Disaster recovery** | Business criticality of the application, workload, or service. | `criticality : mission-critical` <br> `criticality : critical` <br> `criticality : essential` |
| **End date of the project** | Date when the application, workload, or service is scheduled for retirement. | `enddate : 2023-10-15` |
| **Environment** | Deployment environment of the application, workload, or service. | `environment : prod` <br> `environment : dev` <br> `environment : qa` <br> `environment : stage` <br> `environment : test` |
| **Azure region** | Region where you create the resource. | `region : westeurope` <br> `region : uksouth` <br> `region : eastus` <br> `region : japaneast` <br> `region : qatarcentral` |
| **Owner name** | Owner of the application, workload, or service. | `owner : jane@contoso.com` |
| **Requester name** | User who requested the creation of the application. | `requester : john@contoso.com` |
| **Service class** | Service-level agreement level of the application, workload, or service. | `serviceclass : dev` <br> `serviceclass : bronze` <br> `serviceclass : silver` <br> `serviceclass : gold` |
| **Start date of the project** | Date when the application, workload, or service was first deployed. | `startdate : 2020-10-15` |

## Next step

> [!div class="nextstepaction"]
> [Move resource groups and assets between subscriptions](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
