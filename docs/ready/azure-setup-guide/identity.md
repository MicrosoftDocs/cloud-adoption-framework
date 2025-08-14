---
title: Establish identity and access management in Azure
description: Establish identity and access management in Azure
author: stephen-sumner
ms.author: pnp
ms.date: 08/15/2025
ms.topic: conceptual
---


# Establish identity and access management in Azure

This article shows you how to establish identity and access management foundation in a new Azure environment.

## Assign identity management roles

Before you deploy any Azure resources, you need to secure the identity layer. This means defining who can administer your directory, manage users and groups, and configure authentication policies. These tasks form the backbone of your organization’s security because every Azure resource relies on Microsoft Entra ID for authentication.

You manage these responsibilities through Microsoft Entra ID role-based access control (RBAC). Entra ID RBAC assigns roles that determine what actions someone can perform in the identity directory. These actions include creating users, managing groups, or configuring MFA. Set up your roles early so that only trusted individuals have administrative control and helps prevent privilege sprawl.

1. **Use built-in roles.** Review the list of [Microsoft Entra ID built-in roles](/entra/identity/role-based-access-control/permissions-reference). Each role has specific permissions. Assign the role that matches the user’s responsibilities.

2. **Assign roles based on least privilege.** Only grant the minimum permissions required for a user’s job. If a user does not need to manage directory settings, leave them as a regular user with no role assignments.

3. **Use-just-in-time access.** For administrator, use Microsoft Entra Privileged Identity Management (PIM) to assume privileged roles for a limited time if you have the required license. This reduces standing privilege risk.

4. **Limit Global Administrator access.** The [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator) is a highly privileged role and should be limited to two [emergency-access accounts](/entra/identity/role-based-access-control/security-emergency-access) and . Don't use this role for regular operations.

5. **Review and monitor role assignments regularly.** Remove unnecessary roles promptly. Use role assignment reports and alerts to maintain security.

For detailed guidance and best practices, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Create individual user accounts in Microsoft Entra ID

Every person who needs access to Azure should have their own user account in Microsoft Entra ID. It's a core principle of identity and access management.

1. **Add a custom domain.** When you create a Microsoft Entra ID tenant, it has a default domain (*yourtenant.onmicrosoft.com*). Add your own domain name, like *contoso.com*. A custom domain allows sign-in names like *alex@contoso.com* instead of *alex@yourtenant.onmicrosoft.com*. If you create accounts first using the default *.onmicrosoft.com* domain, you have to rename them later when you add your custom domain. For detailed steps, see [Add your custom domain name to your tenant in Microsoft Entra ID](/entra/fundamentals/add-custom-domain).

1. **Create a user for every person who needs access.** Everyone who needs access to Azure should have their own user account. Don't allow people to share users. Multiple people sharing a user account makes it impossible to trace changes or enforce responsibility. Ff you have three team members, create three users. For step-by-step instructions, see [How to create, invite, and delete users in Microsoft Entra ID](/entra/fundamentals/how-to-create-delete-users).

1. **Keep new accounts as regular users with no admin privileges.** Assign roles based on the principle of least privilege, giving users only the access they need.

## Enable multifactor authentication

Multifactor authentication (MFA) adds an extra layer of security by requiring users to provide a second form of verification, such as a code from an authenticator app or a text message, in addition to their password. Enabling MFA significantly reduces the risk of account compromise, even if a password is stolen.

1. **Start with security defaults.** New Microsoft Entra ID tenants have [security defaults](/entra/fundamentals/security-defaults) turned on. Security defaults enforce MFA for all users and apply other basic protections without complex configuration. If security defaults are enabled, keep them on for a strong, simple baseline.

1. **Use Conditional Access as you mature.** If you need more control than security defaults provide, use Conditional Access policies to enforce MFA for specific scenarios. Conditional Access requires a license. Create a policy that enforces MFA under specific conditions, such as when users sign in from unfamiliar locations. For detailed steps, see [Secure user sign-in with Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

1. **Verify MFA enforcement.** After enabling MFA, confirm that each user can sign in successfully with MFA. See [How to verify that users are set up for mandatory MFA](/entra/identity/authentication/how-to-mandatory-multifactor-authentication).

## Next step

> [!div class="nextstepaction"]
> [Organize resources](./organize-resources.md)