---
title: Manage access to your Azure environment with Azure role-based access control
description: Learn how to set up access control for your Azure environment with Azure role-based access control.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
ms.custom: think-tank, fasttrack-edit, AQC, setup
---

# Manage access to your Azure environment with Azure role-based access control

Managing who can access your Azure resources and subscriptions is an important part of your Azure governance strategy.

## Understand access controls in Azure

Azure role-based access is the primary way to manage access to Azure resources. Azure role-based access control (RBAC) is a system that helps you manage who has access to Azure resources, what they can do with those resources, and which areas (scopes) they have access to.  It defines who can access what resources and what actions they can perform, within specific scopes (subscription, resource group, or resource). From the start, plan your access strategy with the least privilege principle: give each person only the permissions absolutely required for their role. For a startup, implementing Azure RBAC properly means you can secure your cloud environment from day one without excessive overhead. Instead of sharing one general administrator account, you assign roles to users (or groups) that define their permissions. This ensures each team member has only the access needed to do their job, aligning with the principle of least privilege. In a new Azure environment, this means you can safely grant developers, engineers, or contractors the access they require without accidentally giving them the keys to everything.

## Identify subscription owners

1. **Decide who your subscription owners should be.** These are people who have the [Owner](/azure/role-based-access-control/built-in-roles/privileged#owner) role for a subscription. These individuals have complete control of that subscription. They have the ability to assign roles to others. Have at most 3 people. Keeping the number of Owners low enforces security best practices by minimizing high-privilege accounts.

## Use security groups to manage access

Use a centralized model by creating security groups in Microsoft Entra ID to represent roles. For example, create an “AzureAdmins” group for your cloud admins, a “DevTeam” group for developers/engineers, and a “ViewOnly” group for read-only access. Managing access via groups simplifies maintenance and reduces errors. Add each team member to the appropriate group based on their job duties.

1. **Create a security groups for each role.**  Use Microsoft Entra ID to create groups such as `AzureAdmins`, `DevTeam`, and `ViewOnly`. Put users in these groups based on their job functions.

2. **Assign the Owner role to the admin group** In the Azure portal, go to **Subscription > Access control (IAM) > Add > Add role assignment**. Assign the Owner role to the `AzureAdmins` group to grant full control over the subscription.

3. **Assign the Contributor role to the development group**  
   At the appropriate scope (preferably a resource group), assign the Contributor role to the `DevTeam` group. This allows developers to manage resources without modifying access permissions.

4. **Assign the Reader role to the view-only group.** Assign the Reader role to the `ViewOnly` group at the subscription or resource group level. This provides read-only access for stakeholders such as auditors or finance teams.

## Scope access assignments precisely

Granular scoping enforces least privilege and limits potential damage from misconfigurations or compromised accounts. Use the narrowest scope possible for each role. Assign roles at the resource group or resource level when possible. Avoid assigning broad roles at the subscription level unless absolutely necessary.

## Validate and maintain access regularly

RBAC is not a one-time setup. Ongoing validation ensures that access remains appropriate as the organization evolves.

1. **Verify access using the “Check access” tool.** In the Azure portal, use **Access control (IAM) > Check access** to confirm that users have the correct permissions. Adjust role assignments or scopes as needed.

2. **Review and clean up role assignments regularly.** Periodically audit access to ensure it aligns with current responsibilities. Remove unnecessary roles, especially high-privilege ones. Use Azure Defender for Cloud to monitor for excessive administrator accounts

## Grant resource group access

To grant a user access to a resource group:

1. Go to [Resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups).
1. Select a resource group.
1. Select **Access control (IAM)**.
1. Select **+ Add** > **Add role assignment**.
1. Select a role, and then assign access to a user, group, or service principal.

## Grant subscription access

To grant a user access to a subscription:

1. Go to [Subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade).
1. Select a subscription.
1. Select **Access control (IAM)**.
1. Select **+ Add** > **Add role assignment**.
1. Select a role, and then assign access to a user, group, or service principal.

## Learn more

To learn more, see [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)
