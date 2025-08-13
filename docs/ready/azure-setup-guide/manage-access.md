---
title: Manage access to your Azure environment with Azure role-based access control
description: Learn how to set up access control for your Azure environment with Azure role-based access control.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---


# Set up Azure identity and access management

This article explains how to configure a secure identity and access foundation in a new Azure environment. It is intended for new Azure customers who have just created their Microsoft Entra ID tenant and have not yet deployed any resources or created any subscriptions. Establishing these identity and access settings early helps protect your future cloud resources and ensures your Azure tenant is managed correctly from the start.

## Add a custom domain to Microsoft Entra ID

By default, Entra ID tenant starts with a domain like *yourtenant.onmicrosoft.com*. You can add your organization’s own domain name (for example, *contoso.com*) to use for user accounts. A custom domain lets users sign in with familiar, professional-looking usernames (e.g. alice@contoso.com instead of alice@yourtenant.onmicrosoft.com). This makes the sign-in experience seamless and aligns Azure identities with your email addresses. It’s optional for starting out, but recommended if you plan to use Azure in a production or corporate setting where consistency is important. If you don’t have a custom domain yet, you can skip this for now and stick with the **.onmicrosoft.com default*. For detailed steps, see [Add your custom domain name to your tenant in Microsoft Entra ID](/entra/fundamentals/add-custom-domain).

## Create individual user accounts

Every person who needs access to Azure should have their own user account in Microsoft Entra ID. This is fundamental to identity management. Unique accounts allow you to assign permissions per person and audit who does what. For example, if you have 5 team members, create 5 separate user identities.

Do not have users share accounts. Having individual accounts means all actions in Azure (like creating a resource or modifying a setting) are logged under a specific user’s identity. This accountability is vital for security and troubleshooting. If people shared accounts, you’d lose the ability to trace changes or enforce personal responsibility. Unique accounts also let you tailor access — you might give one user access to certain resources while another user has different permissions.

By default, new user accounts in Entra ID have no admin privileges. They are regular users, which is good for security. You later grant specific roles with permissions based on the principle of “least privilege”. For step-by-step instructions, see [How to create, invite, and delete users in Microsoft Entra ID](/entra/fundamentals/how-to-create-delete-users).

## Enable multi-Factor authentication for all users

Multi-factor authentication (MFA) means users must provide a second form of verification, like a code from an authenticator app or a text message, in addition to their password. With MFA enabled, even if an attacker steals a user’s password, they likely cannot access the account without the second factor. This dramatically reduces the risk of breaches.

For most new tenants, [Security defaults in Microsoft Entra ID](/entra/fundamentals/security-defaults) are likely already turned on. Security defaults enforce MFA for all users (among other basic protections) without any complex setup. If your tenant has security defaults enabled, keep it on for a simple, strong baseline. If it’s not enabled or if you have more granular needs, plan to use Conditional Access policies to require MFA for all users, especially administrative accounts, in a more flexible way as your organization grows.

If using Conditional Access (requires Azure AD Premium P1/P2 license), create a policy that requires MFA for all users (or all admins) under certain conditions. In either case, every user will need to register an authentication method. Encourage users to set up the Microsoft Authenticator app as their primary method for convenience and security. See [Secure user sign-in with Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

Once MFA is enforced, test that each user can sign in with MFA. You can verify in the Azure portal under Users > Per-user MFA or by checking sign-in logs. See [How to verify that users are set up for mandatory MFA](/entra/identity/authentication/how-to-mandatory-multifactor-authentication).

## Assign Microsoft Entra ID roles

In Entra ID, role-based access within the directory itself is controlled by Microsoft Entra ID roles. These are different from Azure role-based access control (RBAC) roles. Microsoft Entra ID roles define what users can do within the identity directory, such as managing users, groups, domains, and security settings. These Entra ID roles control critical settings (like adding/deleting users or changing security configurations). Over-assigning high-privilege roles could lead to accidental or malicious changes that impact your whole organization.

By default, the account that created the tenant is a Global Administrator. Only a very small number of users should have this role. Treat it like the keys to the kingdom. Beyond that, you should carefully assign directory roles to additional users based on least privilege. If a user doesn’t need to perform directory management tasks, they should remain a normal user with no role assignments. This reduces security risk. Follow the [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Plan Azure role-based access control for Azure Resources

In addition to Entra ID roles, you need to plan your Azure role-based access control (RBAC) roles. Azure RBAC roles provide access to Azure subscriptions, resource groups, and resources like Azure AI Foundry, Azure App Service, Storage Accounts, and databases. This is a separate set of roles and permissions that apply to Azure subscriptions, resource groups, and resources. Azure RBAC also operates on a least-privilege principle and integrates with Entra ID users and groups.

Examples Azure RBAC roles include:

Owner: Full access to manage everything, including access control.
Contributor: Can create and manage resources but not assign roles.
Reader: Can view resources but not make changes.

1. Grant the Subscription Owner role to a very limited set of administrators. The Owner role at subscription level is very powerful (can alter or delete any resource, and also manage access). By default, the account that creates a subscription becomes an Owner for that subscription. You should add at most one or two additional Owners if needed for backup. A good guideline is to have no more than 3 subscription Owners in total (Microsoft Defender for Cloud even flags if you exceed this, as a risk). Fewer owners means fewer chances for a compromised account or human error to have catastrophic impact. In practice, your main Azure admin (or small admin team) will be Owners, and everyone else will be assigned less-privileged roles. You can assign or remove Owner on a subscription via the Azure Portal by going to Subscriptions > Access control (IAM) and adding a role assignment.

1. **Assign other users the lowest privilege needed at the right scope.** Determine what access each team or user will need once subscriptions are created, and plan to grant the lowest privileged role at the most narrow scope that meets that need.

    - **Assign contributor roles to workload teams.** Give individuals who will deploy and manage only resources related to a specific project the Contributor role on the resource group for that project only. This way they can work freely on their project’s resources but have no permissions elsewhere. void giving Contributor at the subscription level unless truly necessary, because that lets the person modify anything in the entire subscription. It’s usually better to scope Contributor to specific resource groups for containment.
    
    - **Assign reader roles to support individuals.** Give the reader role to someone who just needs to view resources, such as a finance person checking costs, or a support engineer reviewing settings. They can be a Reader on the subscription or resource group as appropriate.
    
    - **Use the built-in roles** Avoid creating custom roles initially. Microsoft provides dozens of roles covering most needs. See the /azure/role-based-access-control/role-assignments-portal for more details.

1. Use groups to manage resource access. Instead of assigning roles to individual user accounts one by one, create Microsoft Entra ID groups that correspond to roles, and assign the Azure RBAC roles to those groups. For example, make a group called “Production Contributors” and give that group the Contributor role on the production resource group. Then simply add or remove users from the “Production Contributors” group as staffing changes, and they will automatically gain or lose the corresponding access. This approach is important for keeping your RBAC manageable over time. It also helps stay within Azure’s role assignment limits by using one group assignment in place of many individual assignments. In Microsoft Entra ID, under Groups, create a security group for each team or function (dev, operations, auditors, etc.), and add members. Then in the subscription’s Access control (IAM), assign the appropriate Azure role to the whole group. This way, your access control is cleanly organized and easier to audit.
Establish a process to review and adjust access regularly. As a final step in setting up RBAC, plan to periodically audit who has access to what. Over-provisioned access can creep in over time if not reviewed. All customers should schedule routine checks (for instance, monthly or quarterly) of Microsoft Entra ID admin roles and Azure RBAC assignments. Remove users from roles or groups if they no longer need access (for example, if someone changes teams or a project ends). Azure provides tools like the Access review feature (in Microsoft Entra ID Premium P2) and access reports that list role assignments. Even without premium tools, you can manually export role assignments and verify them. The key is to treat access governance as ongoing maintenance. This ensures your initial identity and access setup remains effective and secure as your organization and Azure usage evolve.


