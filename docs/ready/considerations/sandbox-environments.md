---
title: Landing zone sandbox environments
description: Learn about Azure landing zone sandboxes, which are isolated environments to perform tests, and learn how to manage a sandbox by using subscriptions and policies.
author: Mr-MSFT
ms.author: isiahhudson
ms.date: 06/01/2023
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Landing zone sandbox environments

A sandbox is an isolated environment where you can test and experiment without affecting other environments, like production, development, or user acceptance testing (UAT) environments. Conduct proof of concepts (POCs) with Azure resources in a controlled environment. Each sandbox has its own Azure subscription, and Azure policies control the subscription. The policies are applied at the sandbox management group level, and the management group inherits policies from the hierarchy above it. Depending on its purpose, an individual or a team can use a sandbox.

>[!TIP]
> For information about the default Azure landing zones policy assignments, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#sandbox).

Sandbox environments are the best place for hands-on Azure learning. Some common use cases include:

- A developer needs a controlled Azure environment to quickly test application design patterns.
- A cloud architect needs a sandbox environment to evaluate Azure resources or conduct POCs for an Azure service or resource before formally approving them for their organization.
- A cloud engineer needs a sandbox environment to better understand what happens when a setting is changed on an Azure resource.
- A platform engineer wants to build and test out a new Azure policy and see how it behaves per the [Canary guidance](https://aka.ms/alz/canary).
- A developer wants to experiment with Azure services or resources while building an application.

## Sandbox architecture

The following image shows the management group and subscription layout.

:::image type="content" source="./media/single-use-case-sandbox.png" alt-text="Flowchart that shows a single-use case sandbox architecture." lightbox="./media/single-use-case-sandbox.png#lightbox":::

Place the sandbox subscription in the sandbox management group. For more information about management group and subscription organization, see [Landing zone design areas and conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/design-areas). Azure policies that are created for sandboxes are placed at the management group level of the sandbox. Sandbox environments inherit Azure policies from the management group hierarchy that's above it.

A sandbox subscription helps manage costs for each program or project. You can easily track costs and cancel sandboxes when budgets decrease or the sandbox expires.

### Networking

Create the sandbox subscription networking that fits your needs. To keep the sandbox isolated, ensure that the networks that are created inside the sandbox subscriptions aren't peered with other works outside of the sandbox. You can use the [deny virtual network peering cross subscription](https://www.azadvertizer.net/azpolicyadvertizer/Deny-VNET-Peer-Cross-Sub.html) policy to ensure that each sandbox is its own isolated environment.

Use the [deny ExpressRoute/VPN/Virtual WAN creation](https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html?desc=compareJson&left=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_1.0.0.json&right=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_2.0.0.json) policy to deny the creation of ExpressRoute gateways, VPN gateways, and Virtual WAN hubs. When you deny these resources, it ensures that the sandbox subscription networks remain isolated.

### Audit logging

For security, it's important to enable audit logging for a sandbox environment. Enable a diagnostic setting that includes at least the administrative and security log categories (audit) for all sandbox subscriptions. Store audit logs in a central destination like the Azure landing zone default Log Analytics workspace so you can review them easily. Or you can integrate them with a security information and event management (SIEM) platform, like [Microsoft Sentinel](/azure/sentinel/overview). For more information, see [Inventory and visibility recommendations](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-platform#inventory-and-visibility-recommendations).

The [Azure policies included in the enterprise-scale landing zone reference implementation](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#intermediate-root) have an Azure policy definition ("Configure Azure activity logs to stream to specified Log Analytics workspace") that enables audit logging for all subscriptions. The sandbox management group should inherit this policy to enable sandbox subscription diagnostic logging.

### Sandbox access

The sandbox user has owner access to the sandbox subscription. When a sandbox is canceled, remove the owner role-based access control (RBAC) for all sandbox users.

## Other considerations

To ensure reliable and efficient sandbox environment performance, consider the following factors.

### Sandbox expiration

You can cancel or delete a sandbox when necessary. Plan a strategy for removing sandboxes to save on costs and ensure that security remains dependable. Consider the cost and sandbox expiration date to determine when to remove a sandbox. After a sandbox expires, move it to the [decommissioned](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#decommissioned) management group.

#### Cost

A key concern for cloud-based sandbox environments is cost tracking. To make tracking easier, you can create a budget in Microsoft Cost Management. The [budgets feature](/azure/cost-management-billing/costs/tutorial-acm-create-budgets#create-a-budget-in-the-azure-portal) sends you alerts when actual spending or forecasted spending crosses a configured threshold.

When you deploy a sandbox, you can create a Microsoft Cost Management budget and assign it to the subscription. The budget feature alerts the sandbox users when spending thresholds cross the percentage that you specify. For example, you can set an alert for when the budget crosses the 100% spend threshold. In that case, you might want to [cancel](/azure/cost-management-billing/manage/cancel-azure-subscription#what-happens-after-subscription-cancellation) or delete a subscription. The alert alone is just a warning mechanism.

You can assign a budget to all sandboxes. Apply a default budget by using the [Deploy-Budget](https://www.azadvertizer.net/azpolicyadvertizer/Deploy-Budget.html) Azure policy at the sandbox management group level. Set the default budget to the maximum cost the organization approves for a sandbox. The default budget sends cost alerts for any sandbox that isn’t assigned a more specific budget.

#### Expiration date

Most organizations want to expire and delete sandboxes after a period of time. Expire sandboxes to provide cost control and security benefits. Sandbox environments are created for testing and learning purposes. After the sandbox user performs their test or gains the intended knowledge, you can expire the sandbox because it's no longer needed. Give an expiration date to each sandbox. When that date is reached, [cancel](/azure/cost-management-billing/manage/cancel-azure-subscription#what-happens-after-subscription-cancellation) or delete the sandbox subscription.

When you create a sandbox, you can place an Azure [tag](/azure/azure-resource-manager/management/tag-resources?tabs=json) with an expiration date on the subscription. Use automation to cancel or delete the subscription when it reaches the expiration date.

### Restrict Azure resources

To provide the most robust learning environment for sandbox users, make all Azure services available in the sandbox environment. Unrestricted sandboxes are ideal, but some organizations have requirements to restrict which Azure services are deployed to sandboxes. Control these restrictions via Azure Policy. Use the [Azure service blocklist](https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html?desc=compareJson&left=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_1.0.0.json&right=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_2.0.0.json) policy to deny the deployment of specific Azure services.

### Information protection

Most organizations agree that it's important to keep sensitive data out of a sandbox environment. The first line of defense for information protection is user education. Before assigning a user to a sandbox, provide them with disclaimers and information that clearly states not to add sensitive data to the sandbox.

Use [Microsoft Purview](/azure/purview/overview) to provide information protection for sandbox environments. Purview can send alerts if a user adds data that the organization labels as sensitive to sandbox environments.

## Next steps

[Azure sandbox guide](/azure/architecture/guide/azure-sandbox/azure-sandbox)

> [!div class="nextstepaction"]
> [Improve landing zone governance](/azure/cloud-adoption-framework/ready/considerations/landing-zone-governance)
