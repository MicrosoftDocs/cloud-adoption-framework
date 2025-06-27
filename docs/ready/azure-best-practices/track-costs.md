---
title: Track costs across business units, environments, or projects
description: Learn how to create tracking mechanisms to monitor costs using the Cloud Adoption Framework for Azure.
author: Zimmergren
ms.author: pnp
ms.date: 05/07/2024
ms.topic: conceptual
ms.custom: internal
---

# Track costs across business units, environments, or projects

To build a [cost-conscious organization](../../organize/cost-conscious-organization.md), you need visibility and properly defined access to cost-related data. This best-practice article outlines decisions and implementation approaches to help you create tracking mechanisms to monitor costs. You'll learn how to apply fundamental Azure concepts to provide cost visibility.

:::image type="content" source="../../_images/ready/cost-optimization-process.png" alt-text="Diagram that shows the outline of the cost-conscious process." lightbox="../../_images/ready/cost-optimization-process.png":::

## Establish a well-managed environment

Cost control, much like governance and other management constructs, depends on a well-managed environment. To establish such an environment, especially a complex one, you need to consistently classify and organize all assets. Azure provides several mechanisms for classifying and organizing assets.

Assets, which are also known as resources, include all virtual machines, data sources, and applications deployed to the cloud. [Organize and manage your subscriptions](../azure-best-practices/organize-subscriptions.md) based on multiple criteria to establish a well-managed environment.

### Classify assets

*Tagging* is an easy way to classify assets. Tagging associates metadata to an asset. That metadata can be used to classify the asset based on various data points. Tagging is a fundamental part of any well-managed environment, and it's necessary for establishing proper governance of any environment.

The first step is to develop a [naming convention](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) and [tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging). The second step is to ensure that the tagging standard is consistently applied by [automating cost governance](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies#automate-cost-governance).

When tags are used to classify assets as part of a cost management effort, companies often need the following tags: business unit, department, billing code, geography, environment, project, and workload or application categorization. [Microsoft Cost Management](/azure/cost-management-billing/), a tool for setting budgets and gaining visibility into cloud costs for Azure or AWS, can use these tags to create different views of cost data.

### Organize assets

There are several approaches to organizing assets. Microsoft's enterprise-scale [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) design provides an architecture that can be used as the basis of any Azure cloud environment.  The landing zone [resource organization](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org) documentation provides detailed guidance on organizing [management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) and [subscriptions](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups). Understanding the [design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-principles) used in designing the conceptual architecture will give you a foundation in best practices as you adapt the architecture to meet your specific business needs. Deviations to the design may be necessary to meet your business requirements, but understanding the impact of those deviations will prepare you for any necessary mitigations.

The following model for management groups, subscriptions, and resource groups creates a hierarchy that provides each team with the right level of visibility to perform their duties. When the enterprise needs cost controls to prevent budget overrun, it can apply governance tooling like Azure Policy to the subscriptions within this structure to quickly block future cost errors.

:::image type="content" source="../landing-zone/media/sub-organization.png" alt-text="Diagram that shows the Azure landing zone accelerator management group structure." lightbox="../landing-zone/media/sub-organization.png":::

The rest of this article assumes the use of the best-practice approach in the preceding diagram. But the following articles can help you apply the approach to a resource organization that best fits your company:

- [Scale your Azure environment with multiple subscriptions](../azure-best-practices/scale-subscriptions.md)
- [Organize and manage your Azure subscriptions](../azure-best-practices/organize-subscriptions.md)
- [Deploy a governance MVP to govern well-managed environment standards](../../govern/guides/complex/index.md)

## Provide the right level of cost access

Managing cost is a team activity. The organization readiness section of the Cloud Adoption Framework defines a few core teams and outlines how those teams support cloud adoption efforts.

For the proper level of visibility into cost management data, the members of the team are assigned scope and roles. **Roles** define what a user can do to various assets. The **Scope** defines which assets, such as user, group, service principal, or managed identity, that a user can affect. As a general best practice, we suggest a least-privilege model in assigning people to various roles and scopes.

### Roles

<!-- docutune:casing Owner Contributor Reader -->

Cost Management supports the following built-in roles for each scope:

- [Owner](/azure/role-based-access-control/built-in-roles#owner): Can view costs and manage everything, including cost configuration.
- [Contributor](/azure/role-based-access-control/built-in-roles#contributor): Can view costs and manage everything, including cost configuration, but excluding access control.
- [Reader](/azure/role-based-access-control/built-in-roles#reader): Can view everything, including cost data and configuration, but can't make changes.
- [Cost Management Contributor](/azure/role-based-access-control/built-in-roles#cost-management-contributor): Can view costs and manage cost configuration.
- [Cost Management Reader](/azure/role-based-access-control/built-in-roles#cost-management-reader): Can view cost data and configuration.

As a general best practice, members of all teams should be assigned the role of Cost Management Contributor. This role grants access to create and manage budgets to more effectively monitor and report on costs. But members of the [cloud strategy team](../../organize/cloud-strategy.md) should be set to Cost Management Reader only, because they're not involved in setting budgets within the Cost Management tool.

### Scope

The following scope and role settings will create the required visibility into cost management. This best practice might require minor changes to align to asset organization decisions.

- [Cloud adoption team](../../organize/cloud-adoption.md). As cloud adoption teams primarily focus on implementation of cloud technologies, cost management access to production environments is not typically required. By virtue of normally having Contributor access to non-production or Sandbox subscriptions, this team would inherently have access to cost management data for those subscriptions.

- [Cloud strategy team](../../organize/cloud-strategy.md). Responsibilities for tracking costs across multiple projects and business units require [Cost Management Reader](/azure/role-based-access-control/built-in-roles#cost-management-reader) access at the root level of the management group hierarchy.

  - Assign Cost Management Reader access to this team at the management group, which ensures ongoing visibility into all deployments associated with the subscriptions governed by that management group hierarchy.

- [Cloud governance team](../../organize/cloud-governance.md). Responsibilities for managing cost, budget alignment, and reporting across all adoption efforts requires [Cost Management Contributor](/azure/role-based-access-control/built-in-roles#cost-management-contributor) access at the root level of the management group hierarchy.

  - In a well-managed environment, the cloud governance team likely has a higher degree of access already, making additional scope assignment for Cost Management Contributor unnecessary.

- [Cloud center of excellence](../../organize/cloud-center-of-excellence.md). Responsibility for managing costs related to shared services requires [Cost Management Contributor](/azure/role-based-access-control/built-in-roles#cost-management-contributor) access at the subscription level. Additionally, this team might require Cost Management Contributor access to resource groups or subscriptions that contain assets deployed by CCoE automation processes to understand how those processes affect costs.

  - **Shared services.** When a cloud center of excellence is engaged, best practice suggests that assets managed by the CCoE are supported from a centralized shared service subscription within a hub and spoke model. In this scenario, the CCoE likely has Contributor or Owner access to that subscription, making additional scope assignment for Cost Management Contributor unnecessary.
  
  - **CCoE automation/controls.** The CCoE commonly provides controls and automated deployment scripts to cloud adoption teams. The CCoE has a responsibility to understand how these accelerators affect costs. To gain that visibility, the team needs Cost Management Contributor access to any resource groups or subscriptions running those accelerators.

- **Cloud operations team.** Responsibility for managing ongoing costs of production environments requires [Cost Management Contributor](/azure/role-based-access-control/built-in-roles#cost-management-contributor) access to the Landing Zone and Platform management group nodes.

  - The general recommendation puts production and nonproduction assets in separate subscriptions that are governed by nodes of the management group hierarchy associated with production environments. In a well-managed environment, members of the operations team likely have Owner or Contributor access to production subscriptions already, making the Cost Management Contributor role unnecessary.

## Extra cost management resources

After you establish access to a well-managed environment hierarchy, the following articles can help you use that tool to monitor and control costs.

### Use Cost Management

- [Create and manage budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets)
- [Export cost data](/azure/cost-management-billing/costs/tutorial-export-acm-data)
- [Optimize costs based on recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations)
- [Use cost alerts to monitor usage and spending](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending)

### Use Cost Management to govern AWS costs

- [Set up AWS Cost and Usage Reports integration](/azure/cost-management-billing/costs/aws-integration-set-up-configure)
- [Manage AWS costs](/azure/cost-management-billing/costs/aws-integration-manage)

### Establish access, roles, and scope

- [Understanding cost management scope](/azure/cost-management-billing/costs/understand-work-scopes)
- [Setting scope for a resource group](/azure/role-based-access-control/quickstart-assign-role-user-portal)

## Next steps

To get started with Cost Management, see [How to optimize your cloud investment with Cost Management](/azure/cost-management-billing/costs/cost-mgt-best-practices).
