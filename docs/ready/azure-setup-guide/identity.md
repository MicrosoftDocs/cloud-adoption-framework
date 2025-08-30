---
title: Set up identity in Azure
description: Set up identity in Azure
author: stephen-sumner
ms.author: pnp
ms.date: 08/27/2025
ms.topic: conceptual
---


# Set up identity in Azure

Before anyone can use Azure, they need a secure and well-managed identity. Microsoft Entra ID is the backbone of identity and access management in Azure. This article walks you through the essential steps to establish a strong identity foundation. Whether you're setting up a new tenant or tightening security in an existing one, these best practices help you protect access to your cloud resources from day one.

## Create individual user accounts

Every person who needs access to Azure should have their own user account in Microsoft Entra. This setup helps ensure accountability and makes it easier to track changes and enforce security policies.

1. **Add a custom domain.** When you create a Microsoft Entra tenant, it comes with a default domain (*yourtenant.onmicrosoft.com*). When you add a custom domain (for example, *contoso.com*), users can sign in with familiar names like *alex@contoso.com*. If you create accounts before adding the custom domain, you need to update them later. For detailed steps, see [Add your custom domain name to your tenant in Microsoft Entra](/entra/fundamentals/add-custom-domain).

1. **Create a unique account for every user.** Don't allow shared accounts. Shared accounts make it difficult to track and assign responsibility for changes. For instructions, see [How to create, invite, and delete users in Microsoft Entra](/entra/fundamentals/how-to-create-delete-users).

1. **Create emergency access accounts.** Create two [emergency access accounts](/entra/identity/role-based-access-control/security-emergency-access) to ensure you can access your tenant if normal sign-in methods fail.

## Assign identity management roles

Microsoft Entra uses role-based access control (RBAC) to assign roles to users, role-assignable groups, or service principals. These roles define what actions they can perform within Microsoft Entra, Microsoft 365 Admin Center, Microsoft Defender, Microsoft Purview, and more. It includes creating accounts, managing groups, and configuring security policies.

1. **Use built-in roles.** Microsoft provides predefined roles for common tasks. Each role has a specific set of permissions. For example, the User Administrator role can create and manage user accounts. Review the list of [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference) and assign only what you need.

2. **Assign roles based on least privilege.** Only give users the permissions they need to do their job. If someone doesn’t need to manage Microsoft Entra, Microsoft 365 Admin Center, Microsoft Defender, or Microsoft Purview, leave them as a regular user with no role assignments.

3. **Use just-in-time access.** If your organization has a license for [Microsoft Entra Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure), you can allow users to activate elevated permissions only when needed, and for a limited time. This setup reduces the risk of having too many users with permanent high-level access.

4. **Limit Global Administrator role access.** The [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator) has full control over your Microsoft Entra tenant. Don't use this role for everyday tasks.

5. **Review role assignments regularly.** Check who has roles assigned and remove any that are no longer needed. You can use built-in reports and alerts to help monitor changes.

For more information, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Configure multifactor authentication

Multifactor authentication (MFA) helps protect your organization from compromised credentials and unauthorized access.

1. **Understand security defaults.** New Microsoft Entra tenants have [security defaults](/entra/fundamentals/security-defaults) turned on automatically. These settings require all users to register for MFA, require administrators to perform MFA every sign-in, and require end users to do MFA when necessary.

1. **Use Conditional Access for advanced scenarios.** If your organization needs more flexibility, you can create Conditional Access policies to enforce MFA only in specific situations, such as when users sign in from unfamiliar locations. Security defaults and Conditional Access can't be used simultaneously. To enable Conditional Access, you must first disable security defaults and acquire a premium license. See [Secure user sign-in with Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

## Next step

> [!div class="nextstepaction"]
> [Organize resources](./organize-resources.md)