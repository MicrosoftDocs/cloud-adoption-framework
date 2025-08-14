---
title: Establish identity and access controls in Azure
description: Learn how to set up access control for your Azure environment with Azure role-based access control.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---


# Establish identity and access controls in Azure

This article shows you how to establish a secure identity and access foundation in a new Azure environment. It’s designed for customers who have just created a Microsoft Entra ID tenant and haven’t yet deployed resources or created subscriptions. Set up these controls before deploying any resources to ensure secure, scalable access management from day one.

## Add a custom domain to Microsoft Entra ID

When you create a Microsoft Entra ID tenant, it starts with a default domain such as *yourtenant.onmicrosoft.com*. To provide a professional sign-in experience, add your own domain name, for example, *contoso.com*. This allows sign-in names like *alex@contoso.com* instead of *alex@yourtenant.onmicrosoft.com*. A custom domain improves professionalism and user experience during sign-in. If you do not have a custom domain yet, continue using the .onmicrosoft.com default for now.

1. Verify that you own the domain you want to add.
1. Add the domain in Microsoft Entra ID and complete the DNS verification steps.
1. Update user accounts to use the new domain for sign-in.

For detailed steps, see [Add your custom domain name to your tenant in Microsoft Entra ID](/entra/fundamentals/add-custom-domain).

## Create individual user accounts in Microsoft Entra ID

Every person who needs access to Azure should have their own user account in Microsoft Entra ID. This is a core principle of identity and access management.

1. **Create one account per person who needs access.** For example, if you have 3 team members, create 3 accounts.

1. **Do not allow users to share accounts.** Shared accounts make it impossible to trace changes or enforce responsibility.

1. **Keep new accounts as regular users with no admin privileges.** Later, assign roles based on the principle of least privilege, giving users only the access they need.

For step-by-step instructions, see [How to create, invite, and delete users in Microsoft Entra ID](/entra/fundamentals/how-to-create-delete-users).

## Enable multi-Factor authentication for all users

Multi-factor authentication (MFA) adds an extra layer of security by requiring users to provide a second form of verification, such as a code from an authenticator app or a text message, in addition to their password. Enabling MFA significantly reduces the risk of account compromise, even if a password is stolen.

1. **Start with security defaults.** New Microsoft Entra ID tenants have [security defaults](/entra/fundamentals/security-defaults) turned on by default. Security defaults enforce MFA for all users and apply other basic protections without complex configuration. If security defaults are enabled, keep them on for a strong, simple baseline.

1. **Use Conditional Access as you mature.** If you needs more control than security defaults provide, use Conditional Access policies to enforce MFA for specific scenarios. Conditional Access requires a license. Create a policy that enforces MFA under specific conditions, such as when users sign in from unfamiliar locations. For detailed steps, see [Secure user sign-in with Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

1. **Verify MFA enforcement.** After enabling MFA, confirm that each user can sign in successfully with MFA. See [How to verify that users are set up for mandatory MFA](/entra/identity/authentication/how-to-mandatory-multifactor-authentication).

## Set up identity governance

Before you deploy any Azure resources, you need to secure the identity layer. This means defining who can administer your directory, manage users and groups, and configure authentication policies. These tasks form the backbone of your organization’s security because every Azure resource relies on Microsoft Entra ID for authentication.

You manage these responsibilities through Microsoft Entra ID role-based access control (RBAC). Entra ID RBAC assigns roles that determine what actions someone can perform in the identity directory,such as creating users, managing groups, or configuring MFA. Setting this up early ensures that only trusted individuals have administrative control and helps prevent privilege sprawl.

1. **Use built-in roles.** Review the list of [Microsoft Entra ID built-in roles](/entra/identity/role-based-access-control/permissions-reference). Each role has specific permissions. Assign the role that matches the user’s responsibilities.

2. **Assign roles based on least privilege.** Only grant the minimum permissions required for a user’s job. If a user does not need to manage directory settings, leave them as a regular user with no role assignments.

3. **Use-just-in-time access.** For administrator, use Microsoft Entra Privileged Identity Management (PIM) to assume privileged roles for a limited time if you have the required license. This reduces standing privilege risk.

4. **Limit Global Administrator access.** The [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator) is a highly privileged role and should be limited to two [emergency-access accounts](/entra/identity/role-based-access-control/security-emergency-access) and . Don't use this role for regular operations.

5. **Review and monitor role assignments regularly.** Remove unnecessary roles promptly. Use role assignment reports and alerts to maintain security.

For detailed guidance and best practices, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Control access to Azure resources

Once your identity governance is in place, the next step is to control who can access and manage Azure resources. Even if you haven’t deployed any resources yet, it’s important to plan how you manage access. Managing Azure resource access means defining who can view, create, or modify resources such as subscriptions, resource groups, and services like Azure AI Foundry, App Service, Storage Accounts, and databases. These permissions determine how your cloud environment is deployed, operated, and secured.

You manage resource access through Azure role-based access control (Azure RBAC). Azure RBAC assigns roles at different scopes—subscription, resource group, or individual resource—to define what actions users or groups can perform. Azure RBAC is separate from Entra ID RBAC but integrates with Entra ID identities.

1. **Start with built-in roles rather than creating custom roles.** Microsoft provides roles for common scenarios. See [Azure RBAC built-in roles](/azure/role-based-access-control/role-assignments-portal) for details.

    | Common roles | Permissions | Use Case |
    |--------------|-------------|----------|
    | Owner | Full access to manage everything, including access control | Assign to 2-3 subscriptions owners who need full control over all resources. |
    | Contributor | Can create and manage resources but cannot assign roles | Assign to users or teams responsible for managing resources without needing access control. |
    | Reader | Can view resources but cannot make changes | Assign to users who only need to monitor or review resources, such as auditors or analysts. |

1. **Limit the number of Owner roles on subscriptions** The Owner role at the subscription level allows full control over all resources and access assignments in that subscription. The Owner role grants full control at the subscription level. Keep it to three or fewer per subscription. By default, the account that creates a subscription becomes an Owner.

1. **Use groups to manage resource access.** Instead of assigning roles to individual users, create Microsoft Entra ID security groups. These groups must align with the scopes of access required. For very small teams, one group per function (“Developers”, “Finance”, “Ops”) might be enough. As your environment grows, refine groups based on scope of access:

    | Use Case                          | Description                                                                 | Example Group Name       | Role Assignment | Scope               |
    |-----------------------------------|-----------------------------------------------------------------------------|--------------------------|-----------------|---------------------|
    | Engineering team manages all resources | Developers need to deploy and manage services across the entire subscription | Engineering-Contributors | Contributor     | Subscription level  |
    | Specific team manages a project workload | A product or feature team needs to manage resources in a dedicated resource group | RG-DataTeam or RG-WebTeam | Contributor     | Resource group level |
    | Finance or leadership needs visibility | Finance, operations, or leadership needs to monitor costs and usage without making changes | Finance-Readers          | Reader          | Subscription level  |

## Plan to review access regularly

Schedule periodic reviews (monthly or quarterly) of both Microsoft Entra ID roles and Azure RBAC assignments. Remove unnecessary roles promptly when users change teams or projects end. Use tools like [Access Reviews](/entra/id-governance/access-reviews-overview) (Microsoft Entra ID Premium P2) or export role assignments for manual checks. Treat access governance as ongoing maintenance to keep your environment secure as it grows.
