---
title: Manage access to your Azure environment with Azure role-based access control
description: Learn how to set up access control for your Azure environment with Azure role-based access control.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---


# Set up Azure identity and access management

This article shows you how to establish a secure identity and access foundation in a new Azure environment. It’s designed for customers who have just created a Microsoft Entra ID tenant and haven’t yet deployed resources or created subscriptions. Setting up these controls early helps protect future cloud resources and ensures your Azure tenant is managed correctly from the start.

## Add a custom domain to Microsoft Entra ID

When you create a Microsoft Entra ID tenant, it starts with a default domain such as *yourtenant.onmicrosoft.com*. To provide a professional sign-in experience, add your own domain name, for example, *contoso.com*. This allows sign-in names like *alex@contoso.com* instead of *alex@yourtenant.onmicrosoft.com*.

1. Verify that you own the domain you want to add.
1. Add the domain in Microsoft Entra ID and complete the DNS verification steps.
1. Update user accounts to use the new domain for sign-in.

If you do not have a custom domain yet, continue using the *.onmicrosoft.com* default for now.

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

1. **Use Conditional Access as you mature.** If security defaults are not enabled or you need more granular control, use Conditional Access policies to require MFA for all users or at least all administrators. Conditional Access requires a Premium P1 or P2 license. Create a policy that enforces MFA under specific conditions, such as when users sign in from unfamiliar locations. For detailed steps, see [Secure user sign-in with Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

1. **Verify MFA enforcement.** After enabling MFA, confirm that each user can sign in successfully with MFA. See [How to verify that users are set up for mandatory MFA](/entra/identity/authentication/how-to-mandatory-multifactor-authentication).

## Assign Microsoft Entra ID roles

Microsoft Entra ID uses role-based access control (RBAC) to manage what users can do within the identity directory. These roles are different from Azure RBAC, which control access to Azure resources. Entra ID RBAC roles govern critical identity and security tasks such as managing users, groups, domains, and authentication settings. Assigning these roles carefully is essential because giving too many users high-privilege roles can lead to accidental or malicious changes that affect your entire organization.

1. **Understand built-in roles.** Review the list of Microsoft Entra ID [built-in roles](/entra/identity/role-based-access-control/permissions-reference). Each role has specific permissions. Assign the role that matches the user’s responsibilities.

2. **Assign roles based on least privilege.** Only grant the minimum permissions required for a user’s job. If a user does not need to manage directory settings, leave them as a regular user with no role assignments.

3. **Use-just-in-time access.** For administrator, use Microsoft Entra Privileged Identity Management (PIM) to assume privileged roles for a limited time.

4. **Limit Global Administrator access.** The [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator) is a highly privileged role and should be limited to two [emergency-access accounts](/entra/identity/role-based-access-control/security-emergency-access) and . Don't use this role for regular operations.

5. **Review and monitor role assignments regularly.** Remove unnecessary roles promptly. Use role assignment reports and alerts to maintain security.

For detailed guidance and best practices, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Plan Azure role-based access control for Azure Resources

In addition to Microsoft Entra ID roles, you need to plan Azure role-based access control (Azure RBAC) for managing access to Azure subscriptions, resource groups, and individual resources such as Azure AI Foundry, App Service, Storage Accounts, and databases. Azure RBAC is separate from Entra ID roles and applies to Azure resources. It also follows the principle of least privilege and integrates with Entra ID users and groups.

1. **Start with built-in roles rather than creating custom roles.** Microsoft provides dozens of roles for common scenarios.

    | Common roles | Permissions | Use Case |
    |--------------|-------------|----------|
    | Owner | Full access to manage everything, including access control | Assign to a very limited number of users who need full control over all resources. |
    | Contributor | Can create and manage resources but cannot assign roles | Assign to users or teams responsible for managing resources without needing access control. |
    | Reader | Can view resources but cannot make changes | Assign to users who only need to monitor or review resources, such as auditors or analysts. |

See [Azure RBAC built-in roles](/azure/role-based-access-control/role-assignments-portal) for details.

1. **Limit the number of Owner roles on subscriptions** The Owner role at the subscription level allows full control over all resources and access assignments in that subscription. By default, the account that creates a subscription becomes an Owner. Add at most one or two additional Owners for backup. A good guideline is to have no more than three subscription Owners in total.

    | Role        | Recommended Scope       | Description                                                                 | Example Use                                                                 |
    |-------------|-------------------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------------|
    | Contributor | Resource group level    | Can create and manage resources but cannot assign roles.                   | Assign Contributor at the resource group level for project-specific teams. |
    | Contributor | Subscription level      | Avoid assigning Contributor at the subscription level unless necessary.    | Use only when a team requires broad access across all resources in a subscription. |
    | Reader      | Resource group or resource | Can view resources but cannot make changes.                                | Assign Reader to users who only need to view resources, such as finance staff or support engineers. |

1. **Use groups to manage resource access.** Instead of assigning roles to individual users, create Microsoft Entra ID security groups for each function. For example, if you are a small startup, you might create groups like "Developers" for developers who manage Azure resources and "Business" for someone who only needs to view cost reports.

Assign Azure RBAC roles to these groups at the appropriate scope (subscription, resource group, or resource). Then, as your team grows, simply add or remove users from the group instead of updating individual role assignments. This approach simplifies access management as your team scales. It keeps role assignments organized and easier to audit, and it helps you stay within Azure’s role assignment limits.

## Plan to review access regularly

Schedule periodic reviews (monthly or quarterly) of both Microsoft Entra ID roles and Azure RBAC assignments. Remove unnecessary roles promptly when users change teams or projects end. Use tools like [Access Reviews](/entra/id-governance/access-reviews-overview) (Microsoft Entra ID Premium P2) or export role assignments for manual checks. Treat access governance as ongoing maintenance to keep your environment secure as it grows.
