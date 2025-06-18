---
title: Develop your naming and tagging strategy for Azure resources
description: Read an overview of resource naming and tagging strategy for enterprise cloud adoption efforts.
author: paulgrimley
ms.author: paulgr
ms.date: 05/22/2025
ms.topic: conceptual
ms.custom: internal, readiness, fasttrack-edit, UpdateFrequency3
---

# Develop your naming and tagging strategy for Azure resources

Organize your cloud assets to support governance, operational management, and accounting requirements. Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and showback accounting mechanisms.

Define your naming and tagging strategy as early as possible. Use the following links to help you define and implement your strategy:

- [Define your naming convention](./resource-naming.md)
- [Recommended abbreviations for Azure resource types](./resource-abbreviations.md)
- [Define your tagging strategy](./resource-tagging.md)\
- [Resource naming and tagging decision guide](./resource-naming-and-tagging-decision-guide.md)
- [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules)

Every business has its own organizational and management requirements. These recommendations help start a discussion with your cloud adoption teams. As the discussion proceeds, use the tools below to document the naming and tagging decisions you make when aligning these recommendations to your specific business needs.
>

## Purpose of naming and tagging

Accurately representing and naming your resources is essential for security purposes. If you come upon a security incident, it's critical to quickly identify affected systems, what functions those systems support, and the potential business impact. Security services such as [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction) and [Microsoft Sentinel](/azure/sentinel/) reference resources and their associated logging and alert information by resource name.

Azure defines [naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules). This guidance provides you with detailed recommendations to support enterprise cloud adoption efforts.

Changing resource names can be difficult. Establish a comprehensive naming convention before you begin any large cloud deployment.

For complicated or complex deployments, use naming and tagging standards to organize your resources for:

- **Resource management**: Your IT teams need to quickly locate resources that are associated with specific workloads, regions, environments, ownership groups, or other important information. Organize resources to ensure that you properly assign organizational roles and access permissions.

- **Cost management and optimization**: Ensure that your IT team understands the resources and workloads that each team uses so that business groups know how much cloud resources consume. Cost-related tags support the following types of information:

  - [Cloud accounting models](../../strategy/cloud-accounting.md)
  - [Return on investment (ROI) calculations](../../strategy/cloud-migration-business-case.md)
  - [Cost tracking](../../ready/azure-best-practices/track-costs.md)
  - [Budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Automate cost governance](../../govern/enforce-cloud-governance-policies.md#automate-cost-governance)

- **Operations management**: Ensure that the operations management team has visibility into business commitments and service-level agreements (SLAs) for ongoing operations.

- **Security**: Classify data and determine the security impact to prepare for breaches or other security problems. Create tags for [data classification](../../govern/policy-compliance/data-classification.md) to ensure that your operation is secure.

- **Governance and regulatory compliance**: Maintain consistency across resources to help identify divergence from policies. [Prescriptive guidance for resource tagging](../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) demonstrates how one of the tagging patterns that are described in [Resource tagging patterns](#resource-tagging-patterns), later in this article, can help with deployment of governance practices. Similar patterns are available to evaluate regulatory compliance by using tags.

- **Automation**: Have a proper organizational scheme so you can use automation to create resources, monitor operations, and create DevOps processes. Automation also makes resources easier for IT to manage.

- **Workload optimization**: Use tagging to help resolve broad problems, identify patterns, and identify the assets that a single workload requires. Tag all assets that are associated with each workload so that you can deeply analyze your mission-critical workloads, which helps you make sound architectural decisions.


## Naming and tagging strategy

A naming and tagging strategy includes business and operational details as components of resource names and metadata tags:

- The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource along with the business owners who are responsible for resource costs.

- The operational side ensures that names and tags include necessary information. IT teams use this information to identify the workload, application, environment, criticality, and other information useful for managing resources.

## Next steps

Learn about the considerations for defining your naming convention of your Azure resources and assets, and review example names for resources and assets in Azure.

> [!div class="nextstepaction"]
> [Name your Azure resources and assets](./resource-naming.md)
