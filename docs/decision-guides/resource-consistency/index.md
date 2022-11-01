---
title: Resource consistency decision guide
description: Understand the importance of your cloud estate's resource consistency and the factors that drive requirements for resource consistency.
author: doodlemania2
ms.author: dermar
ms.date: 08/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: internal
---

# Resource consistency decision guide

Azure [subscription design](../subscriptions/index.md) defines how you organize your cloud assets in relation to your organization's structure, accounting practices, and workload requirements. In addition to this level of structure, addressing your organizational governance policy requirements across your cloud estate requires the ability to consistently organize, deploy, and manage resources within a subscription.

![Plotting resource consistency options from least to most complex, aligned with jump links below](../../_images/decision-guides/decision-guide-resource-consistency.png)

Jump to: [Basic grouping](#basic-grouping) | [Deployment consistency](#deployment-consistency) | [Policy consistency](#policy-consistency) | [Hierarchical consistency](#hierarchical-consistency) | [Automated consistency](#automated-consistency)

Decisions regarding the level of your cloud estate's resource consistency requirements are primarily driven by these factors: post-migration digital estate size, business or environmental requirements that don't fit neatly within your existing subscription design approaches, or the need to enforce governance over time after resources have been deployed.

As these factors gain importance, the benefits of ensuring consistent deployment, grouping, and management of cloud-based resources becomes even more vital. Gaining more advanced levels of resource consistency to meet increasing requirements takes greater effort across automation, tooling, and consistency enforcement. That effort results in more time spent on change management and tracking.

## Basic grouping

In Azure, [resource groups](/azure/azure-resource-manager/management/overview#resource-groups) are a core resource organization mechanism to logically group resources within a subscription.

Resource groups are containers for resources with a common lifecycle and shared management constraints, such as policy or Azure role-based access control requirements. Resource groups can't be nested, and resources can only belong to one resource group. All control plane actions act on all resources in a resource group. For example, deleting a resource group also deletes all resources within that group. The preferred pattern for resource group management is to consider:

* Are the contents of the resource group developed together?
* Are the contents of the resource group managed, updated, and monitored together and done so by the same people or teams?
* Are the contents of the resource group retired together?

If you answered *no* to any of the above points, place the resource in another resource group.

> [!IMPORTANT]
> Resource groups are region specific; but it's common for resources to be in different regions within the same resource group because they're managed together as described above. For more information about region selection, see [Multiple regions](../../migrate/azure-best-practices/multiple-regions.md).

## Deployment consistency

When you build on top of the base resource grouping mechanism, the Azure platform provides a system for using templates to deploy your resources to the cloud environment. You can use templates to create consistent organization and naming conventions when deploying workloads. Templates enforce those aspects of your resource deployment and management design.

[Azure Resource Manager templates](/azure/azure-resource-manager/templates/overview) let you repeatedly deploy your resources in a consistent state using a predetermined configuration and resource group structure. Resource Manager templates help you define a set of standards as a basis for your deployments.

For example, you can use a standard template to deploy a web server workload that contains two virtual machines as web servers combined with a load balancer to distribute traffic between the servers. You can then reuse this template to create a structurally identical set of virtual machines. The VMs have a load balancer whenever this type of workload is needed, and only changing the deployment name and IP addresses involved.

You can also programmatically deploy these templates and integrate them with your CI/CD systems.

## Policy consistency

Part of resource grouping design involves using a common configuration when deploying resources. Using a common configuration ensures that governance policies apply when you create resources.

By combining resource groups and standardized Resource Manager templates, you can enforce standards for what settings are required in a deployment and what [Azure Policy](/azure/governance/policy/overview) rules apply to each resource group or resource.

For example, you might have a requirement that all virtual machines deployed within your subscription connect to a common subnet managed by your central IT team. Use a standard template for deploying workload VMs to create a separate resource group for the workload and deploy the required VMs there. This resource group has a policy rule to only allow network interfaces within the resource group to be joined to the shared subnet.

For a more in-depth discussion of enforcing your policy decisions within a cloud deployment, see [Policy enforcement](../policy-enforcement/index.md).

## Hierarchical consistency

Resource groups let you support extra levels of hierarchy inside your organization within the subscription. Hierarchies support Azure Policy rules and access controls at a resource group level. As the size of your cloud estate grows, you might need to support more complicated cross-subscription governance requirements. Use the Azure Enterprise Agreement's enterprise, department, account, subscription hierarchy.

[Azure management groups](/azure/governance/management-groups/) lets you organize subscriptions into more sophisticated organizational structures. You can group subscriptions in a hierarchy distinct from your Enterprise Agreement's hierarchy. This alternate hierarchy lets you apply access control and policy enforcement mechanisms across multiple subscriptions and the resources they contain. You can use management group hierarchies to match your cloud estate's subscriptions with operations or business governance requirements. For more information, see the [subscription decision guide](../subscriptions/index.md).

## Automated consistency

For large cloud deployments, global governance becomes both more important and more complex. It's crucial to automatically apply and enforce governance requirements when deploying resources, and meet updated requirements for existing deployments.

[Azure Blueprints](/azure/governance/blueprints/overview) enable organizations to support global governance of large cloud estates in Azure. Blueprints move beyond the capabilities provided by standard Azure Resource Manager templates. They create complete deployment orchestrations capable of deploying resources and applying policy rules. Blueprints support versioning, the ability to update all subscriptions where the blueprint was used, and the ability to lock down deployed subscriptions to avoid unauthorized creation and modification of resources.

These deployment packages allow IT and development teams to rapidly deploy new workloads and networking assets that comply with changing organizational policy requirements. Development teams can also integrate blueprints into CI/CD pipelines to apply revised governance standards to deployments as they're updated.

## Next steps

Resource consistency is just one of the core infrastructure components that requires architectural decisions during a cloud adoption process. Visit the architectural decision guides overview to learn about the patterns and models for design decisions on various types of infrastructure.

> [!div class="nextstepaction"]
> [Architectural decision guides](../index.md)
