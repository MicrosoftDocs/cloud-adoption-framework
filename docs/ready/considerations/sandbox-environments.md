---
title: Sandbox environments
description: Guidance for the architecture of sandbox environments
author: Mr-MSFT
ms.author: isiahhudson
ms.date: 03/01/2023
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Sandbox Environments

## Sandbox Overview

A sandbox environment is an isolated environment that enables testing and experimentation without impacting any other environments (Production, Development, UAT, etc.). Azure landing zone sandboxes provide users with a controlled environment to test and experiment with Azure resources. Sandbox environments are also a great environment to conduct POCs (proof of concepts) with Azure resources. Each sandbox should be its own Azure subscription controlled by Azure policies applied at the Sandboxes Management Group level which also inherits policy from the Management Group hierarchy above it. A sandbox can be used by one person or a team depending on its purpose.


>[!TIP]
> Review the default Azure landing zones policy assignments that are documented here in [Policies included in Azure landing zones reference implementations](https://aka.ms/alz/policies)


Sandbox environments are the best place for hands on Azure learning. Below are some common use cases:

-   Developers need a controlled Azure environment to quickly test application design patterns.
-   Cloud architect needs a sandbox environment to evaluate Azure resources or conduct a PoC for an Azure service or resource before formally approving them for their organization.
-   A cloud engineer needs a sandbox environment to better understand what happens when a specific setting is changed on an Azure resource.
-   A platform engineer wants to build and test out a new Azure Policy and how it will behave as per the [Canary guidance](https://aka.ms/alz/canary)
-   Developers want to experiment with Azure services/resources while building an application


## Sandbox Architecture

### Management Group and Subscription Layout

![Single use case sandbox architecture](./media/single-usecase-sandbox.png)

All sandbox subscriptions should be placed in the Sandboxes Management Group. This allows Azure polices specifically created for sandboxes to be placed at the Sandboxes Management Group level. Sandbox environments will also inherit Azure policies from the Management Group hierarchy above it.


The Azure policies below will be applied directly to the Sandbox Management Group. The policies are already a part of the Azure landing zone default policy set. The table below is meant to outline and detail the specific Azure Landing Zone policies that apply directly to the Sandbox Management Group. 

| Azure Policy                                                                                                                                                                      | Description                                                                                                                                         |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| [Deny VNet peering cross subscription](https://www.azadvertizer.net/azpolicyadvertizer/Deny-VNET-Peer-Cross-Sub.html) | Deny any VNet peering with VNets outside of the sandbox subscription. This helps the sandbox environments stay isolated from a network perspective. |
| [Deny ER/VPN/vWAN creation](https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html?desc=compareJson&left=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_1.0.0.json&right=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_2.0.0.json) | This policy should be used to deny creation of Express Route gateways, VPN gateways, and vWan hubs. Denying these resources help ensure the sandbox environments stay isolated from a network perspective. |

One of the benefits of creating a sandbox subscription is the ability to manage costs for each program/project. This allows costs to be more easily tracked and for sandboxes to be cancelled when budgets or the expiration date of the sandbox has been reached.


### Networking

All sandbox networking is left to the sandbox user to create what fits their needs. To keep the sandbox isolated it is important to ensure the networks created inside the sandbox are not peered with other networks outside of the sandbox. This ensures each sandbox is its own isolated environment. The policies outlined in the table above limits the sandbox user's ability to peer with outside networks.


### Audit Logging

From a security perspective, it is important to ensure audit logging is enabled for any sandbox environment. Diagnostic settings should be enabled that sends at least the administrative and security log categories (audit) for all sandbox subscriptions. As per Azure Landing Zone guidance, they should be stored in a central destination (like the Azure Landing Zone default Log Analytics workspace) so that logs can be reviewed as necessary, or integrated with a SIEM like [Microsoft Sentinel](https://learn.microsoft.com/azure/sentinel/overview).

The [current Azure Landing Zone policy guidance](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies#intermediate-root) already includes an Azure policy defination ("Configure Azure Activity logs to stream to specified Log Analytics workspace") that enables audit logging for all subscriptions. The Sandboxes Management Group should inherit this policy enabling diagnostic logging of the sandbox subscriptions.

### Sandbox Permissions

The sandbox user(s) are given Owner access to the sandbox subscription. When sandboxes are cancelled all sandbox users should have the Owner RBAC role replaced by the Reader RBAC role. 

## Additional Considerations

### Sandbox Expiration

Sandboxes should be cancelled or deleted at some point in time. Having a strategy to remove a sandbox is a cost saving and security measure. Cost and expiration dates are two important variables for determining when a sandbox should be removed.


### Cost

A key concern for any cloud-based sandbox environment is cost tracking. Azure cost management allows the creation of budgets. The [budgets feature](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets#create-a-budget-in-the-azure-portal) allows alerts to be generated when actual spending or forecasted spending cross configured thresholds.

Whenever a sandbox is deployed, an Azure cost management budget can be created for it and assigned to the subscription. This budget alerts the sandbox users when spending thresholds are crossed (50%, 75%, and 100%). Optionally, automation can be used to take action when the 100% spend threshold is crossed, for example, the subscription is [cancelled](https://learn.microsoft.com/azure/cost-management-billing/manage/cancel-azure-subscription#what-happens-after-subscription-cancellation) or deleted. Note: the alert alone is just a warning mechanism.

Our guidance is that all sandboxes should have a budget assigned. A default budget can be applied to all sandboxes by utilizing the [Deploy-Budget](https://www.azadvertizer.net/azpolicyadvertizer/Deploy-Budget.html) Azure policy at the Sandboxes Management Group level. The default budget should be set to the maximum cost the organization would tolerate for any sandbox. The default budget would function to alert on cost for any sandbox that hasn't been assigned a more specific budget directly.

### Expiration Date

Most organizations will want to expire and delete sandboxes after a certain period. Expiring sandboxes provide cost control and security benefits. Sandbox environments are created for testing and learning purposes. Ideally once the sandbox user performs their test or gains the intended knowledge it makes sense to expire the sandbox as it is no longer needed. Each sandbox should be given an expiration date. When that date is reached the sandbox subscription should be [cancelled](https://learn.microsoft.com/azure/cost-management-billing/manage/cancel-azure-subscription#what-happens-after-subscription-cancellation) or deleted.

An Azure [tag](https://learn.microsoft.com/azure/azure-resource-manager/management/tag-resources?tabs=json) with an expiration date can be placed on the subscription when a sandbox is created. Automation can then be used to cancel or delete the subscription when the expiration date is reached.

All sandboxes should have an expiration date.

### Restricting Azure Resources

Some organizations will want to control which Azure services are eligible to be deployed to sandboxes. This can be controlled via Azure policy. The [Azure service blocklist](https://www.azadvertizer.net/azpolicyadvertizer/6c112d4e-5bc7-47ae-a041-ea2d9dccd749.html?desc=compareJson&left=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_1.0.0.json&right=https%3A%2F%2Fwww.azadvertizer.net%2Fazpolicyadvertizerjson%2F6c112d4e-5bc7-47ae-a041-ea2d9dccd749_2.0.0.json) policy can be used to deny specific Azure services from being deployed.

### Information Protection

One concern most organizations have about sandbox environments is ensuring sensitive data doesn’t find its way in. The first line of defense for information protection is always user education. Users should be given disclaimers/information before being assigned a sandbox that clearly states any sensitive data should not be added to the sandbox.

[Microsoft Purview](https://learn.microsoft.com/azure/purview/overview) is a service that can be used to provide information protection for sandbox environments. Purview can be used to alert if data labeled by the organization as sensitive were to be added to sandbox environments.
