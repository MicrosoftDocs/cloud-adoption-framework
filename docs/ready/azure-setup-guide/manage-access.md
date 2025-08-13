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

## Add a custom domain to Microsoft Entra ID (Optional)

A custom domain in Microsoft Entra ID aligns your cloud identity with your organization’s email domain for a seamless sign-in experience. Using your own domain (instead of the default *.onmicrosoft.com) makes user accounts more intuitive and professional, which is important for consistency and future growth. Adding your custom DNS domain (for example, contoso.com) to your Microsoft Entra ID tenant allows users to sign in with familiar addresses. For more information, see [Add your custom domain name to your tenant in Microsoft Entra ID](/entra/fundamentals/add-custom-domain).

Adding a custom domain to Microsoft Entra ID is optional but recommended if your organization plans to use a branded email domain (@contoso.com) for user sign-in and identity consistency. This step is especially useful for production environments, external collaboration, or aligning Azure identities with your corporate domain. If you don’t have a custom domain yet, you can skip this step and use the default *.onmicrosoft.com domain for now.

## Create individual user accounts

User accounts in Microsoft Entra ID represent each person who access your Azure resources. A unique account for each team member is the basis of identity management and is essential for assigning permissions and tracking activity. Create a user account for each person who needs Azure access. Each team member should have their own Microsoft Entra ID user identity (no sharing of accounts) so that activities in Azure are attributable to the correct individual. By default, new users have no administrative privileges. They are standard users in the directory. This principle of least privilege means you grant extra access separately as needed. For step-by-step instructions, see [How to create, invite, and delete users in Microsoft Entra ID](/entra/fundamentals/how-to-create-delete-users).

## Enable multi-Factor authentication for all users

Multi-factor authentication (MFA) adds a critical layer of security to user sign-ins by requiring a second form of verification. Most new Microsoft Entra ID tenants have security defaults enabled by default, which enforces MFA and blocks legacy authentication. Entra ID security defaults are intended for organizations without complex security needs. As you mature, move from security defaults to Conditional Access for more flexible, risk-based MFA enforcement. For more information, see  [Security defaults in Microsoft Entra ID](/entra/fundamentals/security-defaults) and [Secure user sign-in with Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

After enabling MFA requirements, make sure each user sets up their authentication app or alternate contact when prompted. For more information, see [How to verify that users are set up for mandatory MFA](/entra/identity/authentication/how-to-mandatory-multifactor-authentication).

## Assign Microsoft Entra ID roles

Microsoft Entra ID roles define what users can do within the identity directory—such as managing users, groups, domains, and security settings. Assign Entra ID roles based on the principle of least privilege and ensure role assignments are intentional, auditable, and time-bound. Follow the [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Implement Role-Based Access Control for Azure Resources

Role-based access control (RBAC) on Azure resources ensures users and groups only have the permissions necessary to do their work. Establishing RBAC from the start prevents overly broad access and helps avoid accidents or security issues in your subscriptions and resource groups. The goal is to enforce least privilege at the Azure resource level, just as with identities in Microsoft Entra ID.

Azure RBAC roles are used to manage access to Azure resources like Azure AI Foundry, Azure App Service, storage accounts, and databases. These roles are assigned at the subscription, resource group, or resource level. Examples include:

Owner: Full access to manage everything, including access control.
Contributor: Can create and manage resources but not assign roles.
Reader: Can view resources but not make changes.

1. Grant the Subscription Owner role to a very limited set of administrators. The Owner role at the subscription scope allows full control of all resources and the ability to manage access. Only one or a few trusted individuals should be Owners of your Azure subscription. By default, the account that created the subscription is an Owner. You might add one additional co-owner for redundancy, but avoid having many owners. Fewer owners reduces the chance of unauthorized changes or mistakes that affect everything. Use Azure RBAC to add or remove owners via Access control (IAM) on the subscription. Azure’s best practices recommend a maximum of 3 owners per subscription for security.
Assign Azure roles to others based on least privilege and scope. Determine what access each team or user will need once subscriptions are created, and plan to grant the lowest privileged role at the most narrow scope that meets that need. For example, if developers will only need to manage resources within a particular resource group, assign the Contributor role to their account (or group) on that resource group only - not on the whole subscription. Similarly, use the Reader role for users who just need to view resources. Avoid giving out the Owner role or broad permissions to those who don’t absolutely require it. Azure includes many built-in roles (Contributor, Reader, Virtual Machine Operator, etc.) to cover common scenarios. You can assign these roles via the Azure portal’s Access control (IAM) blade on the specific subscription or resource group. See the https://learn.microsoft.com/azure/role-based-access-control/role-assignments-portal for more details.
Use Microsoft Entra ID security groups to manage resource access. Instead of assigning roles to individual user accounts one by one, create Microsoft Entra ID groups that correspond to roles, and assign the Azure RBAC roles to those groups. For example, make a group called “Production Contributors” and give that group the Contributor role on the production resource group. Then simply add or remove users from the “Production Contributors” group as staffing changes, and they will automatically gain or lose the corresponding access. This approach is important for keeping your RBAC manageable over time. It also helps stay within Azure’s role assignment limits by using one group assignment in place of many individual assignments. In Microsoft Entra ID, under Groups, create a security group for each team or function (dev, operations, auditors, etc.), and add members. Then in the subscription’s Access control (IAM), assign the appropriate Azure role to the whole group. This way, your access control is cleanly organized and easier to audit.
Establish a process to review and adjust access regularly. As a final step in setting up RBAC, plan to periodically audit who has access to what. Over-provisioned access can creep in over time if not reviewed. All customers should schedule routine checks (for instance, monthly or quarterly) of Microsoft Entra ID admin roles and Azure RBAC assignments. Remove users from roles or groups if they no longer need access (for example, if someone changes teams or a project ends). Azure provides tools like the Access review feature (in Microsoft Entra ID Premium P2) and access reports that list role assignments. Even without premium tools, you can manually export role assignments and verify them. The key is to treat access governance as ongoing maintenance. This ensures your initial identity and access setup remains effective and secure as your organization and Azure usage evolve.


