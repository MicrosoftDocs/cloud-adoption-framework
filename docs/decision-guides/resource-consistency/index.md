---
title: Resource consistency decision guide
description: Understand the importance of your cloud estate's resource consistency and the factors that drive requirements for resource consistency.
author: doodlemania2
ms.author: dermar
ms.date: 05/06/2024
ms.topic: conceptual
ms.subservice: caf-general
ms.custom: internal
---
 
# Resource consistency decision guide

Azure [subscription design](../../ready/landing-zone/design-area/resource-org-subscriptions.md) defines how you organize your cloud assets in relation to your organization's structure, accounting practices, and workload requirements. In addition to this level of structure, addressing your organizational governance policy requirements across your cloud estate requires the ability to consistently organize, deploy, and manage resources within a subscription.

:::image type="content" source="../../_images/decision-guides/decision-guide-resource-consistency.png" alt-text="Diagram that shows plotting resource consistency options from least to most complex, aligned with jump links." lightbox="../../_images/decision-guides/decision-guide-resource-consistency.png":::

Jump to: [Basic grouping](#basic-grouping-resource-groups) | [Deployment consistency](#deployment-consistency) | [Policy consistency](#policy-consistency) | [Hierarchical consistency](#hierarchical-consistency) | [Automated consistency](#automated-consistency)

Decisions regarding the level of your cloud estate's resource consistency requirements are primarily driven by these factors: post-migration digital estate size, business or environmental requirements that don't fit neatly within your existing subscription design approaches, or the need to enforce governance over time after resources have been deployed.

As these factors gain importance, the benefits of ensuring consistent deployment, grouping, and management of cloud-based resources becomes even more vital. Gaining more advanced levels of resource consistency to meet increasing requirements takes greater effort across automation, tooling, and consistency enforcement. That effort results in more time spent on change management and tracking.

## Basic grouping: Resource groups

In Azure, [resource groups](/azure/azure-resource-manager/management/overview#resource-groups) are a core resource organization mechanism to logically group resources within a subscription.

You can use resource groups as containers for resources that have a common lifecycle and shared management constraints, such as policy or Azure role-based access control (RBAC) requirements. You can't nest resource groups, and resources can only belong to one resource group. All control plane actions affect all resources in a resource group. For example, deleting a resource group also deletes all resources within that group.

When you design or update your regional resource organization, consider the following factors. Is there a logical group of resources:

- That you can develop together?
- That you can manage, update, and monitor together? Can the same people or team carry out those tasks?
- That one team uses within a single geography/region?
- That you can retire together?

If the answer is _yes_ for any of these questions, consider placing those resources (deployed in region X) together in a resource group (also deployed in region X).

To minimize the effect of regional outages, place resources in the same region as the resource group. For more information, see [Resource group location alignment](/azure/azure-resource-manager/management/overview#resource-group-location-alignment).

> [!NOTE]
> If you have resources that are in the same resource group, but the resources are in different regions, consider moving your resources to a [new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

To [determine if your resource supports moving to another resource group](/azure/azure-resource-manager/management/move-support-resources), inventory your resources by cross-referencing them. Ensure that you meet the appropriate [prerequisites](/azure/azure-resource-manager/management/move-resource-group-and-subscription#checklist-before-moving-resources).

> [!TIP]
> [Audit](https://www.azadvertizer.net/azpolicyadvertizer/0a914e76-4921-4c19-b460-a2d36003525a.html) your resource group alignment with Azure Policy. [Assign a built-in Azure Policy definition](/azure/governance/policy/tutorials/create-and-manage) at the [intermediate root management group](/azure/governance/management-groups/overview#root-management-group-for-each-directory) level to verify whether the locations of the resources in your tenant hierarchy match the location of their respective resource groups.

## Deployment consistency

When you build on top of the base resource grouping mechanism, the Azure platform provides a system for using templates to deploy your resources to the cloud environment. You can use templates to create consistent organization and naming conventions when deploying workloads. Templates enforce those aspects of your resource deployment and management design.

[Azure Resource Manager templates](/azure/azure-resource-manager/templates/overview) let you repeatedly deploy your resources in a consistent state using a predetermined configuration and resource group structure. Resource Manager templates help you define a set of standards as a basis for your deployments.

For example, you can use a standard template to deploy a web server workload that contains two virtual machines as web servers combined with a load balancer to distribute traffic between the servers. You can then reuse this template to create a structurally identical set of virtual machines. The VMs have a load balancer whenever this type of workload is needed, and only changing the deployment name and IP addresses involved.

You can also programmatically deploy these templates and integrate them with your continuous integration and continuous delivery (CI/CD) systems.

## Policy consistency

Part of resource grouping design involves using a common configuration when deploying resources. Using a common configuration ensures that governance policies apply when you create resources.

By combining resource groups and standardized Resource Manager templates, you can enforce standards for what settings are required in a deployment and what [Azure Policy](/azure/governance/policy/overview) rules apply to each resource group or resource.

For example, you might have a requirement that all virtual machines deployed within your subscription connect to a common subnet managed by your central IT team. Use a standard template for deploying workload VMs to create a separate resource group for the workload and deploy the required VMs there. This resource group has a policy rule to only allow network interfaces within the resource group to be joined to the shared subnet.

For a more in-depth discussion of enforcing your policy decisions within a cloud deployment, see [Policy enforcement](../../govern/policy-compliance/policy-definition.md).

## Hierarchical consistency

Resource groups let you support extra levels of hierarchy inside your organization within the subscription. Hierarchies support Azure Policy rules and access controls at a resource group level. As the size of your cloud estate grows, you might need to support more complicated cross-subscription governance requirements. Use the Azure Enterprise Agreement's enterprise, department, account, subscription hierarchy.

[Azure management groups](/azure/governance/management-groups/) lets you organize subscriptions into more sophisticated organizational structures. You can group subscriptions in a hierarchy distinct from your Enterprise Agreement's hierarchy. This alternate hierarchy lets you apply access control and policy enforcement mechanisms across multiple subscriptions and the resources they contain. You can use management group hierarchies to match your cloud estate's subscriptions with operations or business governance requirements. For more information, see the [subscription decision guide](../../ready/landing-zone/design-area/resource-org-subscriptions.md).

## Automated consistency

For large cloud deployments, global governance becomes both more important and more complex. It's crucial to automatically apply and enforce governance requirements when deploying resources, and meet updated requirements for existing deployments.

An Azure landing zone is an environment that follows key design principles across eight design areas. These design principles accommodate all application portfolios and enable application migration, modernization, and innovation at scale. For more information about Azure landing zones, see [What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/).

IT and development teams can use Azure landing zones to rapidly deploy new workloads and networking assets that comply with changing organizational policy requirements. Platform teams can use [infrastructure as code (IaC) templates](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code), including [policy as code](/azure/governance/policy/concepts/policy-as-code) practices, to deploy and manage the Azure landing zone. Incorporate these practices into your CI/CD pipelines to ensure that you apply new governance standards as you update templates and definitions.

## Next step

Resource consistency is just one of the core infrastructure components that requires architectural decisions during a cloud adoption process. Visit the architectural decision guides overview to learn about the patterns and models for design decisions on various types of infrastructure.

> [!div class="nextstepaction"]
> [Architectural decision guides](../index.md)
