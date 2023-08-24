---
title: Resource naming and tagging decision guide
description: Learn about naming and tagging approaches when organizing cloud-based resources as part of the Cloud Adoption Framework for Azure.
author: martinekuan
ms.author: martinek
ms.date: 10/17/2022
ms.topic: conceptual
ms.custom: internal
---

# Resource naming and tagging decision guide

Organizing cloud-based resources is a crucial task for IT, unless all deployments are simple. For complicated or complex deployments, use naming and tagging standards to organize your resources for the following reasons:

- **Resource management:** Your IT teams need to quickly locate resources that are associated with specific workloads, environments, ownership groups, or other important information. Organizing resources is critical to assigning organizational roles and access permissions for resource management.

- **Cost management and optimization:** Making business groups aware of the consumption of cloud resources requires IT to understand the resources and workloads that each team uses. Cost-related tags support the following types of information:

  - [Cloud accounting models](../../strategy/cloud-accounting.md)
  - [ROI calculations](../../strategy/cloud-migration-business-case.md)
  - [Cost tracking](../../ready/azure-best-practices/track-costs.md)
  - [Budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Recurring spend tracking and reporting](../../govern/cost-management/compliance-processes.md)
  - [Post-implementation optimizations](../../govern/cost-management/discipline-improvement.md#operate-and-post-implementation)
  - [Cost-optimization tactics](../../govern/guides/complex/cost-management-improvement.md#incremental-improvement-of-best-practices)

- **Operations management:** Visibility on business commitments and SLAs is an important aspect of ongoing operations for the operations management team. Managing operations well requires tagging for [mission criticality](../../manage/considerations/criticality.md).

- **Security:** Classification of data and determining the security impact are vital when breaches or other security issues arise. Operating securely requires tagging for [data classification](../../govern/policy-compliance/data-classification.md).

- **Governance and regulatory compliance:** Maintaining consistency across resources helps with identifying divergence from policies. [Prescriptive guidance for resource tagging](../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) demonstrates how one of the tagging patterns that are described in [Resource tagging patterns](#resource-tagging-patterns), later in this article, can help with deployment of governance practices. Similar patterns are available to evaluate regulatory compliance by using tags.

- **Automation:** A proper organizational scheme enables you to take advantage of automation as part of creating resources, monitoring operations, and creating DevOps processes. Automation also makes resources easier for IT to manage.

- **Workload optimization:** Tagging can help with identifying patterns and resolving broad issues. Tagging can also help with identifying the assets that a single workload requires. Tagging all assets that are associated with each workload enables deeper analysis of your mission-critical workloads, which helps you to make sound architectural decisions.

## Tagging decision guide

Your approach to tagging can be simple or complex. It can support IT teams who manage cloud workloads or integrate information that's related to all aspects of the business.  

:::image type="content" alt-text="Diagram that shows plotting tagging options from least complex to most complex." source="../../_images/decision-guides/decision-guide-resource-tagging.png" lightbox="../../_images/decision-guides/decision-guide-resource-tagging.png":::

The following table describes the qualities and alignments that are shown in the diagram.

|   | Description |
|---|-------------|
| **Primary design considerations** | Baseline operations requirements, supplemented by additive business requirements. |
| **Baseline naming conventions**   | Resource naming is required for deployment. A standardized naming schema is the minimum tag. |
| **Functional**                    | Tags that describe the function of the virtual machine for easy identification.<br/>Example: workload; function in the workload (app, data, and so on); environment (such as development, staging, production). |
| **Classification**                | Tags that classify the value of an asset can aid in making decisions.<br/>Example: data classification (public, private, confidential, and so on); criticality; SLA. |
| **Accounting**                    | Tags that help to track costs that are associated with asset operations.<br/>Example: department, project, region, and so on. |
| **Purpose**                       | Tags that align an asset to a business function can be valuable in making investment decisions.<br/>Example: business process, business criticality, revenue impact. |

A tagging scheme that aligns with IT, such as tagging based on workload, application, or environment, reduces the complexity of monitoring assets. With less complexity, you can simplify the process of making management decisions that are based on operational requirements.

Tagging schemes that align with business, like accounting, business ownership, or business criticality, might require a larger investment of time. You need to invest more time to create tagging standards that reflect business interests and maintain those standards in the future. This investment yields a tagging system that provides improved accounting for costs and value of IT assets to the overall business. Linking an asset's business value to its operational cost can change the view of IT as a cost center within your wider organization.


## Baseline naming conventions

A standardized naming convention is the starting point for organizing your cloud-hosted resources. A properly structured naming system enables you to quickly identify resources for both management and accounting purposes. You might have existing IT-aligned naming conventions in other parts of your organization. If so, consider whether your cloud naming conventions should align with them, or if you should establish separate cloud-based standards.

> [!NOTE]
> [Naming rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules) vary by Azure resource. Your naming conventions must comply with these rules.

## Resource tagging patterns

For more sophisticated organization than a consistent naming convention alone provides, cloud platforms support the ability to tag resources.

Tags are metadata elements that are attached to resources. Tags consist of pairs of key-value strings. The values that you include in these pairs are up to you. However, the application of a consistent set of global tags, as part of a comprehensive naming and tagging policy, is a critical part of an overall governance policy.

As part of your planning process, use the following questions to determine the kind of information that your resource tags must support:

- Do your naming and tagging policies need to integrate with existing policies within your company?

- Will you implement a chargeback or showback accounting system? Do you need to associate resources with accounting information for departments, business groups, and teams in more detail than a simple subscription-level breakdown provides?

- Should tags represent details for a resource, such as regulatory compliance requirements? What about operational details such as uptime requirements, patching schedules, or security requirements?

- What tags are required for all resources based on centralized IT policy? What tags are optional? Are individual teams allowed to implement their own custom tagging schemes?

The following tagging patterns are examples of how you can use tagging to organize cloud assets. These patterns aren't meant to be exclusive, and you can use them in parallel. They provide multiple ways of organizing assets based on your company's needs.

| Tag type | Examples | Description |
|--|--|--|
| Functional | `app` = `catalogsearch1` <br> `tier` = `web` <br> `webserver` = `apache` <br> `env` = `prod` <br> `env` = `staging` <br> `env` = `dev` | Categorizes resources by their purposes within a workload, the environment they've been deployed to, or other functionality and operational details. |
| Classification | `confidentiality` = `private` <br> `SLA` = `24hours` | Classifies a resource by how it's used and the policies that apply to it. |
| Accounting | `department` = `finance` <br> `program` = `business-initiative` <br> `region` = `northamerica` | Associates a resource with specific groups within an organization for billing purposes. |
| Purpose | `businessprocess` = `support` <br> `businessimpact` = `moderate` <br> `revenueimpact` = `high` | Aligns resources to business functions to better support investment decisions. |

## Learn more

For more information about naming and tagging in Azure, see:

- [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md). For recommended naming conventions for Azure resources, see this guidance.

- [Use tags to organize your Azure resources and management hierarchy](/azure/azure-resource-manager/management/tag-resources). You can apply tags in Azure at the levels of both the resource group and individual resources, giving you flexibility in the granularity of any accounting reports that are based on applied tags.

## Next steps

Resource tagging is just one of the core infrastructure components that requires architectural decisions in a process of cloud adoption. To learn about alternative patterns or models for making design decisions about other types of infrastructure, see the architectural decision guides.

> [!div class="nextstepaction"]
> [Architectural decision guides](../index.md)
