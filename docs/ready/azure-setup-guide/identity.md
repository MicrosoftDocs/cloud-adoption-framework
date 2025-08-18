---
title: Set up identity and access management in Azure
description: Set up identity and access management in Azure
author: stephen-sumner
ms.author: pnp
ms.date: 08/15/2025
ms.topic: conceptual
---


# Set up identity and access management in Azure

A secure identity and access management (IAM) foundation ensures that only authorized users can access Azure resources. This article outlines how to establish a secure and manageable IAM environment in Azure.

## Create individual user accounts

Every person who needs access to Azure should have their own user account in Microsoft Entra ID. This setup helps ensure accountability and makes it easier to track changes and enforce security policies.

1. **Add a custom domain.** When you create a Microsoft Entra ID tenant, it has a default domain (*yourtenant.onmicrosoft.com*). A custom domain allows sign-in names like *alex@contoso.com*. If you create accounts before adding your custom domain, you need to update them if you want users to sign in with the new domain. For detailed steps, see [Add your custom domain name to your tenant in Microsoft Entra ID](/entra/fundamentals/add-custom-domain).

1. **Create a new user account for each person who needs access to Azure.** Everyone who needs access to Azure should have their own user account. Don't allow people to share user accounts. Multiple people sharing a user account makes it impossible to trace changes or enforce responsibility. For step-by-step instructions, see [How to create, invite, and delete users in Microsoft Entra ID](/entra/fundamentals/how-to-create-delete-users).

## Assign identity management roles

Microsoft Entra ID uses role-based access control (RBAC) to assign roles to users, role-assinable groups, or service principals. These roles define what actions they can perform within the identity system. It includes creating accounts, managing groups, and configuring security policies.

1. **Use built-in roles.** Microsoft provides predefined roles for common tasks. Each role has a specific set of permissions. For example, the User Administrator role can create and manage user accounts. Review the list of [Microsoft Entra ID built-in roles](/entra/identity/role-based-access-control/permissions-reference) and assign only what you need.

2. **Assign roles based on least privilege.** Only give users the permissions they need to do their job. If someone doesn’t need to manage identity settings, leave them as a regular user with no role assignments.

3. **Use-just-in-time access.** If your organization has a license for [Microsoft Entra Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure), you can allow users to activate elevated permissions only when needed, and for a limited time. This setup reduces the risk of having too many users with permanent high-level access.

4. **Limit Global Administrator role access.** The [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator) has full control over your Microsoft Entra ID tenant. Don't use this role for everyday tasks. Limit the use of this role to [emergency-access accounts](/entra/identity/role-based-access-control/security-emergency-access).

5. **Review role assignments regularly.** Check who has roles assigned and remove any that are no longer needed. You can use built-in reports and alerts to help monitor changes.

For more information, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Configure multifactor authentication

New Microsoft Entra ID tenants have [security defaults](/entra/fundamentals/security-defaults) turned on automatically. These settings require all users to register for MFA, require administrators to perform MFA every sign-in, and require end users to do MFA when necessary

1. **Use Conditional Access for advanced scenarios.** If your organization needs more flexibility, you can create Conditional Access policies to enforce MFA only in specific situations, such as when users sign in from unfamiliar locations. Also, you can't use security defaults and Conditional Access at the same time. Security defaults must be disabled to use Conditional Access. This feature requires a premium license. See [Secure user sign-in with Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

1. **Verify that MFA is working.** Confirm that each user can sign in successfully with MFA. See [How to verify that users are set up for mandatory MFA](/entra/identity/authentication/how-to-mandatory-multifactor-authentication).

## Next step

> [!div class="nextstepaction"]
> [Organize resources](./organize-resources.md)