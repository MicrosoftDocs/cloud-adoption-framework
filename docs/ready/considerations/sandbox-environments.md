---
title: Landing zone sandbox environments
description: Guidance for the architecture of landing zone sandbox environments.
author: Mr-MSFT
ms.author: isiahhudson
ms.date: 06/01/2023
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Landing zone sandbox environments

A sandbox environment is an isolated environment where you can test and experiment without affecting other environments, like production, development, or user acceptance testing (UAT) environments. Test and experiment with Azure resources in a controlled environment. In a sandbox environment, you can also conduct proof of concepts (POCs) with Azure resources. Each sandbox should be its own Azure subscription controlled by Azure policies applied at the Sandboxes Management Group level which also inherits policy from the Management Group hierarchy above it. Depending on its purpose, an individual or a team can use a sandbox.

Management groups provide a governance scope above subscriptions.

>[!TIP]
> For information about the default Azure landing zones policy assignments, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#sandbox).

Sandbox environments are the best place for hands-on Azure learning. Some common use cases include:

- A developer needs a controlled Azure environment to quickly test application design patterns.
- A cloud architect needs a sandbox environment to evaluate Azure resources or conduct a POC for an Azure service or resource before formally approving them for their organization.
- A cloud engineer needs a sandbox environment to better understand what happens when a setting is changed on an Azure resource.
- A platform engineer wants to build and test out a new Azure policy and see how it behaves per the [Canary guidance](https://aka.ms/alz/canary).
- A developer wants to experiment with Azure services or resources while building an application.

## Sandbox architecture

The following image shows the management group and subscription layout.

![Flowchart that shows a single-use case sandbox architecture.](./media/single-usecase-sandbox.png)

Place the sandbox subscription in the management group for the sandbox. For more information about management group and subscription organization, see [Landing zone design areas and conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/design-areas). This allows Azure policies specifically created for sandboxes to be placed at the Sandboxes Management Group level. Sandbox environments inherit Azure policies from the management group hierarchy that's above it.

A sandbox subscription helps manage costs for each program or project. You can easily track costs and cancel sandboxes when budgets decrease or the sandbox expires.

### Networking

All sandbox subscription networking is left to the sandbox user to create what fits their needs. To keep the sandbox isolated it's important to ensure the networks created inside the sandbox subscriptions aren't peered with other networks outside of the sandbox. The [Deny VNet peering cross subscription](https://www.azadvertizer.net/azpolicyadvertizer/Deny-VNET-Peer-Cross-Sub.html) policy can be used to ensure each sandbox is its own isolated environment.

The [Deny ER/VPN/vWAN creation](https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html?desc=compareJson&left=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_1.0.0.json&right=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_2.0.0.json) policy can be used to deny creation of Express Route gateways, VPN gateways, and vWan hubs. Denying these resources helps ensure the sandbox subscriptions stay isolated from a network perspective.

### Audit logging

From a security perspective, it's important to ensure audit logging is enabled for a sandbox environment. A diagnostic setting that includes at least the administrative and security log categories (audit) should be enabled for all sandbox subscriptions. As per [Azure Landing Zone guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-platform#inventory-and-visibility-recommendations), they should be stored in a central destination (like the Azure Landing Zone default Log Analytics workspace) so that logs can be reviewed as necessary, or integrated with a SIEM like [Microsoft Sentinel](/azure/sentinel/overview).

The [Azure policies included in the enterprise-scale landing zone reference implementation](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#intermediate-root) already includes an Azure policy definition ("Configure Azure Activity logs to stream to specified Log Analytics workspace") that enables audit logging for all subscriptions. The Sandboxes Management Group should inherit this policy enabling diagnostic logging of the sandbox subscriptions.

### Sandbox access

The sandbox user(s) are given Owner access to the sandbox subscription. When sandboxes are canceled all sandbox users should have the Owner Role base access control (RBAC) removed.

## Other considerations

### Sandbox expiration

Sandboxes should be canceled or deleted at some point in time. Having a strategy to remove a sandbox is a cost saving and security measure. Cost and expiration dates are two important variables for determining when a sandbox should be removed. After a sandbox has expired it should be moved to the [Decommissioned](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#decommissioned) management group.

#### Cost

A key concern for any cloud-based sandbox environment is cost tracking. Azure Cost Management allows for the creation of budgets. The [budgets feature](/azure/cost-management-billing/costs/tutorial-acm-create-budgets#create-a-budget-in-the-azure-portal) allows alerts to be generated when actual spending or forecasted spending cross configured thresholds.

Whenever a sandbox is deployed, an Azure Cost Management budget can be created for it and assigned to the subscription. This budget alerts the sandbox users when spending thresholds are crossed (50%, 75%, and 100%). Optionally, automation can be used to take action when the 100% spend threshold is crossed, for example, the subscription is [canceled](/azure/cost-management-billing/manage/cancel-azure-subscription#what-happens-after-subscription-cancellation) or deleted. Note: the alert alone is just a warning mechanism.

All sandboxes should have a budget assigned. A default budget can be applied to all sandboxes by utilizing the [Deploy-Budget](https://www.azadvertizer.net/azpolicyadvertizer/Deploy-Budget.html) Azure Policy at the Sandboxes Management Group level. The default budget should be set to the maximum cost the organization would tolerate for any sandbox. The default budget would function to alert on cost for any sandbox that hasn't been assigned a more specific budget directly.

#### Expiration date

Most organizations will want to expire and delete sandboxes after a certain period. Expiring sandboxes provide cost control and security benefits. Sandbox environments are created for testing and learning purposes. Ideally once the sandbox user performs their test or gains the intended knowledge it makes sense to expire the sandbox as it is no longer needed. Each sandbox should be given an expiration date. When that date is reached the sandbox subscription should be [canceled](/azure/cost-management-billing/manage/cancel-azure-subscription#what-happens-after-subscription-cancellation) or deleted.

An Azure [tag](/azure/azure-resource-manager/management/tag-resources?tabs=json) with an expiration date can be placed on the subscription when a sandbox is created. Automation can then be used to cancel or delete the subscription when the expiration date is reached.

### Restrict Azure resources

Ensuring any Azure service can be used in sandbox environments will provide the most robust learning environment for sandbox users. Although unrestricted sandboxes are ideal, some organizations will have requirements to restrict which Azure services are allowed to be deployed to sandboxes. This can be controlled via Azure Policy. The [Azure service blocklist](https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html?desc=compareJson&left=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_1.0.0.json&right=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_2.0.0.json) policy can be used to deny specific Azure services from being deployed.

### Information protection

One concern most organizations have about sandbox environments is ensuring sensitive data doesn’t find its way in. The first line of defense for information protection is always user education. Users should be given disclaimers/information before being assigned a sandbox that clearly states any sensitive data shouldn't be added to the sandbox.

[Microsoft Purview](/azure/purview/overview) is a service that can be used to provide information protection for sandbox environments. Purview can be used to alert if data labeled by the organization as sensitive were to be added to sandbox environments.

## Next steps

To learn more and get hands-on experience with sandbox deployment, visit the [Azure sandbox guide](/azure/architecture/guide/azure-sandbox/azure-sandbox).

Once you're ready to learn how to landing zone governance will help you support adoption at scale, select:

> [!div class="nextstepaction"]
> [Improve landing zone governance](/azure/cloud-adoption-framework/ready/considerations/landing-zone-governance)
