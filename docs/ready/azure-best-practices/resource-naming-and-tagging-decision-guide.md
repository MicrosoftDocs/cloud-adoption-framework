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

Organize your cloud-based resources so that your IT team can easily work with them. For complicated or complex deployments, use naming and tagging standards to organize your resources for:

- **Resource management**: Your IT teams need to quickly locate resources that are associated with specific workloads, regions, environments, ownership groups, or other important information. Organize resources to ensure that you properly assign organizational roles and access permissions.

- **Cost management and optimization**: Ensure that your IT team understands the resources and workloads that each team uses so that business groups know how much cloud resources consume. Cost-related tags support the following types of information:

  - [Cloud accounting models](../../strategy/cloud-accounting.md)
  - [Return on investment (ROI) calculations](../../strategy/cloud-migration-business-case.md)
  - [Cost tracking](../../ready/azure-best-practices/track-costs.md)
  - [Budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Recurring spend tracking and reporting](../../govern/cost-management/compliance-processes.md)
  - [Post-implementation optimizations](../../govern/cost-management/discipline-improvement.md#operate-and-post-implementation)
  - [Cost-optimization tactics](../../govern/guides/complex/cost-management-improvement.md#incremental-improvement-of-best-practices)

- **Operations management**: Ensure that the operations management team has visibility into business commitments and service-level agreements (SLAs) for ongoing operations. Create tags for [mission criticality](../../manage/considerations/criticality.md) to properly manage operations.

- **Security**: Classify data and determine the security impact to prepare for breaches or other security problems. Create tags for [data classification](../../govern/policy-compliance/data-classification.md) to ensure that your operation is secure.

- **Governance and regulatory compliance**: Maintain consistency across resources to help identify divergence from policies. [Prescriptive guidance for resource tagging](../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) demonstrates how one of the tagging patterns that are described in [Resource tagging patterns](#resource-tagging-patterns), later in this article, can help with deployment of governance practices. Similar patterns are available to evaluate regulatory compliance by using tags.

- **Automation**: Have a proper organizational scheme so you can use automation to create resources, monitor operations, and create DevOps processes. Automation also makes resources easier for IT to manage.

- **Workload optimization**: Use tagging to help resolve broad issues, identify patterns, and identify the assets that a single workload requires. Tag all assets that are associated with each workload so that you can deeply analyze your mission-critical workloads, which helps you to make sound architectural decisions.

## Tagging decision guide

You can have a simple or complex approach to tagging. Your approach can support IT teams that manage cloud workloads, or your approach can integrate information that's related to all aspects of the business.  

:::image type="content" alt-text="Diagram that shows plotting tagging options from least complex to most complex." source="../../_images/decision-guides/decision-guide-resource-tagging.png" lightbox="../../_images/decision-guides/decision-guide-resource-tagging.png":::

The following table describes the considerations in the diagram.

| Consideration  | Description |
|---|-------------|
| **Primary design considerations** | Baseline operations requirements, supplemented by additive business requirements. |
| **Baseline naming conventions**   | Resource naming is required for deployment. A standardized naming schema is the minimum tag. |
| **Functional**                    | Tags that describe the function of the virtual machine for easy identification.<br/>For example, a workload tag might describe the function in the workload, such as app or data. An environment tag might describe a function, such as development, staging, or production. |
| **Classification**                | Tags that classify the value of an asset can aid in making decisions.<br/>For example, you can classify resources based on the data classification (public, private, or confidential), criticality, or SLA. |
| **Accounting**                    | Tags that help to track costs that are associated with asset operations.<br/>For example, use tags based on the department, project, or region. |
| **Purpose**                       | Tags that align an asset to a business function can be valuable in making investment decisions.<br/>For example, use tags based on the business process, business criticality, or revenue impact. |

A tagging scheme that aligns with IT, such as tagging based on the workload, application, environment, or region, reduces the complexity of monitoring assets. With less complexity, you can simplify the process of making management decisions that are based on operational requirements.

Tagging schemes that align with business, like accounting, business ownership, or business criticality, might require a larger investment of time. You need to invest more time to create tagging standards that reflect business interests and maintain those standards in the future. This investment yields a tagging system that provides improved accounting for costs and value of IT assets to the overall business. Linking an asset's business value to its operational cost can change the view of IT as a cost center within your wider organization.


## Baseline naming conventions

Use a standardized naming convention as a starting point to organize your cloud-hosted resources. When you have a properly structured naming system, you can quickly identify resources for both management and accounting purposes. You might have existing IT-aligned naming conventions in other parts of your organization. If so, consider whether your cloud naming conventions should align with them, or if you should establish separate cloud-based standards.

> [!NOTE]
> [Naming rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules) vary depending on the Azure resource. Your naming conventions must comply with these rules.

## Resource tagging patterns

In addition to consistent naming conventions, cloud platforms also support the ability to tag resources, which provides more extensive organization.

Tags are metadata elements that are attached to resources and are valid across all regions under your tenant. Tags consist of pairs of key-value strings. The values that you include in these pairs are based on the requirements of your business. For more information, see [Minimum suggested tags](../../ready/azure-best-practices/resource-tagging.md#minimum-suggested-tags). When you incorporate your comprehensive naming and tagging policy, apply a consistent set of global tags for overall governance.

When you plan for tagging, consider the following questions to determine the kind of information that your resource tags must support:

- Do your naming and tagging policies need to integrate with existing policies within your company?

- Will you implement a chargeback or showback accounting system? Do you need to associate resources with accounting information for departments, business groups, and teams in more detail than a simple subscription-level breakdown provides?

- Should tags represent details for a resource, such as regulatory compliance requirements? What about operational details such as uptime requirements, patching schedules, or security requirements?

- What tags are required for all resources based on centralized IT policy? What tags are optional? Are individual teams allowed to implement their own custom tagging schemes?

The following tagging patterns are examples of how you can use tagging to organize cloud assets. These patterns aren't meant to be exclusive, and you can use them in parallel. They provide multiple ways of organizing assets based on your company's needs.

| Tag type | Examples | Description |
|--|--|--|
| Functional | `app` = `catalogsearch1` <br> `tier` = `web` <br> `webserver` = `apache` <br> `env` = `prod` <br> `env` = `staging` <br> `env` = `dev` <br> `region` = `eastus` <br> `region` = `uksouth` | Categorizes resources by their purposes within a workload, the environment and region they're deployed to, or other functionality and operational details |
| Classification | `confidentiality` = `private` <br> `SLA` = `24hours` | Classifies a resource by how it's used and the policies that apply to it |
| Accounting | `department` = `finance` <br> `program` = `business-initiative` <br> `region` = `northamerica` | Associates a resource with specific groups within an organization for billing purposes |
| Purpose | `businessprocess` = `support` <br> `businessimpact` = `moderate` <br> `revenueimpact` = `high` | Aligns resources to business functions to better support investment decisions |

## Resource tagging multiregion

You can use Azure tags across various Azure regions to logically organize resources. Azure tags aren't tied to a specific location, so you can use the same tagging strategy across all your resources regardless of their location.

In a multiregion environment, consider including region details in your tagging strategy if your naming convention doesn't already cover operational and management requirements.

You can also use tagging to aggregate and compare resources across regions and subscriptions. For example, you might require advanced reporting or resource filtering based on the Azure region where you deploy resources. If you can't align subscriptions to acquire these capabilities, you can use tagging instead.

If the region where you create a resource is a resource object property, you don't need to tag the resource.

Azure has built-in policies to enforce tagging requirements. You can also create custom policies for more specific tagging requirements. For more information, see [Assign policy definitions for tag compliance](/azure/azure-resource-manager/management/tag-policies).

When you create an assignment for a policy, you can specify a resource selector, such as *resourceLocation*, to target and filter specific regions within a specified scope. For more information, see [Create a policy assignment](/azure/governance/policy/assign-policy-portal) and [Resource selectors](/azure/governance/policy/concepts/assignment-structure#resource-selectors).

## Next steps

- Resource tagging is just one of the core infrastructure components that requires architectural decisions in a process of cloud adoption. To learn about alternative patterns or models for making design decisions about other types of infrastructure, see the [architectural decision guides](../index.md).

- For recommended naming conventions for Azure resources, see [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md). 

- For information about applying tags at both the resource group level and individual resource level, see [Use tags to organize your Azure resources and management hierarchy](/azure/azure-resource-manager/management/tag-resources). Use this approach for flexibility in the granularity of accounting reports that are based on applied tags.


