---
title: Create and scale Azure subscriptions
description: Learn to create your initial Azure subscriptions and scale your subscriptions as your Azure environment grows.
author: stephen-sumner
ms.author: pnp
ms.date: 06/26/2025
ms.topic: conceptual
---

# Create and scale Azure subscriptions

This article helps you create your subscriptions the right way from day one. Subscriptions are the foundation for organizing, securing, and managing your cloud resources. A thoughtful setup now saves you time, money, and effort as your business grows.

## Start with subscription policies

Before you create your first subscription, it's important to define the appropriate way to deploy and manage them. Subscriptions help you manage access, costs, and security, so having a plan upfront helps you scale later. Here's how to get started:

1. **Use management groups to govern subscriptions.** Management groups enable hierarchical organization and policy inheritance, simplifying governance at scale. Group related subscriptions and enforce governance policies using Azure Policy. For advanced scenarios, see [Azure landing zone management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

1. **Establish subscription creation and management processes.** Define clear processes for who can request new subscriptions, approves them, and how you configure them (policy, access, budgets). Standardized processes ensure that all subscriptions meet your governance requirements while providing audit trails and accountability for subscription management activities.

1. **Use subscriptions to separate workloads.** Avoid placing multiple workload environments in the same subscription. Create separate subscriptions for production, nonproduction, and sandbox environments. Each environment requires distinct governance policies and access controls. This separation protects production workloads, supports innovation, and simplifies cost tracking, access control, and policy enforcement. For more information, see [Azure landing zone application environments](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments#environments-subscriptions-and-management-groups).

### Create your initial subscriptions

With policies in place, you're ready to create your first subscriptions. At a minimum, follow this guidance:

1. **Start with three core subscriptions to establish proper boundaries.** Create one production subscription for live workloads, one nonproduction subscription for development and testing, and one sandbox subscription for experimentation and learning. This structure provides essential separation while keeping management overhead low and costs predictable.

1. **Use Azure Dev/Test pricing to optimize costs in nonproduction environments.** [Azure Dev/Test offers](https://azure.microsoft.com/pricing/dev-test/) provide significant cost savings for development, testing, and training activities. These pricing benefits help small organizations maximize their cloud investment while maintaining proper environment separation and governance practices.

## Govern your subscriptions

Effective subscription governance ensures your cloud resources remain secure, compliant, and cost-effective throughout their lifecycle. You need to decide what all standard subscriptions should look like, including Azure role-based access controls, policies, tags, and resources. Here's how:

1. **Control resource deployments by default.** Use Azure Policy at the management group level for enforcing governance policies. Start with the [General](/azure/governance/policy/samples/built-in-policies#general) definitions in Azure Policy, which, for example, let you block resources, locations, and deletions. For more examples, see [Automated policy enforcement](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies#enforce-cloud-governance-policies-automatically).

1. **Apply Azure role-based access controls.** Role-based access control enables workload teams to manage their resources effectively while maintaining security boundaries. Assign Azure role-based access controls to subscriptions upon creation that provide workload teams the minimum permissions necessary to perform their responsibilities. Allow workload teams to grant access to resource groups and resources. For more information, see [Azure landing zone access controls](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones#general-recommendations).

1. **Apply budgets and cost alerts to each subscription.** Microsoft Cost Management tools provide financial governance and prevent unexpected spending. Set appropriate [budget thresholds](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?tabs=psbudget) with automated alerts at defined intervals to notify you before costs exceed limits. These controls help teams manage their cloud spending responsibly while providing visibility to financial stakeholders.

1. **Establish resource tagging standards for governance and cost allocation.** Consistent tagging enables accurate tracking and reporting across your environment. Define mandatory tags for ownership, cost center, environment, and application to support governance reporting and chargeback processes. This standardization improves visibility and accountability for all resources across your subscriptions. For more information, see [Define your tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging).

## Scale your subscriptions

As your cloud environment grows, your subscription strategy must evolve. Establish scalable patterns that support growth without compromising governance. Here's how:

1. **Use templates with predefined configurations.** Use infrastructure as code to ensure consistency and compliance by including policies, role assignments, tags, and baseline resources tailored to each subscription type. For examples, see [Azure landing zone Bicep templates](/azure/architecture/landing-zones/bicep/landing-zone-bicep#module-descriptions).

1. **Automate subscription provisioning and management.** Automation tools eliminate manual errors and ensure compliance at scale. These tools streamline subscription creation, configuration, and governance while accelerating response to business needs. For more information, see [subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

1. **Monitor subscription quotas and limits proactively.** Regular monitoring prevents unexpected service disruptions. Track resource usage against Azure subscription limits to identify when more subscriptions are needed before reaching critical thresholds. For details, see [Azure subscription limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits#general-limits).

1. **Optimize cross-subscription networking costs in your architecture.** Efficient network design balances isolation with cost management. Minimize unnecessary data transfers between subscriptions while maintaining workload isolation and shared service access. This approach ensures cost efficiency without compromising your operational requirements.

1. **Plan for Classic deployment model resource isolation.** Legacy resources created with the classic deployment model can't use Azure policies, role-based access control, resource grouping, or tags. Move these resources to dedicated subscriptions to avoid management complications and enable proper governance of modern resources. For more information, see [Move Azure resources to another resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

1. **Allow business needs to drive subscription creation.** Your Azure subscription strategy should evolve based on your organization’s priorities. As your business grows, specific needs, such as innovation, migration, cost control, operations, security, and governance, might justify creating more subscriptions.

1. **Decide how to move resources between subscriptions.** As your subscription model grows, you might decide that some resources belong in other subscriptions. Many types of resources can be moved between subscriptions. You can also use automated deployments to re-create resources in another subscription. For more information, see [Move Azure resources to another resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

## Monitor subscriptions

Ongoing monitoring and optimization ensure your subscription design continues to meet business needs. Regular reviews help identify improvements and prevent issues from escalating. Here's how:

1. **Conduct regular access reviews.** Review subscription access quarterly or annually to ensure alignment with business needs. Use Microsoft Entra Privileged Identity Management (PIM) to manage and audit privileged access.

1. **Plan for subscription lifecycle management.** Define processes for decommissioning unused subscriptions, transferring resources, and maintaining compliance. Effective lifecycle management prevents sprawl and keeps your environment organized and cost-effective.

## Next steps

> [!div class="nextstepaction"]
> [Azure landing zone subscription guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions)