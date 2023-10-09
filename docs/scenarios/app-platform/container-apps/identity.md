---
title: Identity management in Azure Container Apps - Landing Zone Accelerator
description: Manage user identity in Azure Container Apps 
author: craigshoemaker
ms.author: cshoe
ms.date: 10/09/2023
ms.topic: conceptual
---

# Identity management in Azure Container Apps - Landing Zone Accelerator

To secure your application, you can enable authentication and authorization via an identity provider such as Azure Entra ID or [Azure Entra ID B2C](/azure/active-directory/external-identities/b2b-fundamentals).

Consider using [managed identity](https://learn.microsoft.com/azure/container-apps/managed-identity) instead of a service principal to connect to other resources in your container app. Managed identity is preferable as it negates the need for managing credentials. You can also use [system-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/overview). System-managed identities share a lifecycle with an Azure resource such as a Container App, or a _user-assigned managed identity_, which is a standalone Azure resource available to multiple applications.

## Recommendations

- If authentication is required, use Azure Entra ID or [Azure Entra ID B2C](/azure/active-directory/external-identities/b2b-fundamentals) as an identity provider.

- Use separate app registrations for the application environments. For example, create a different registration for development vs. test vs. production.

- Use system-assigned managed identities unless there's a strong requirement for using user-managed identities

- Use Azure [built-in roles](/azure/role-based-access-control/built-in-roles) to assign least privilege permissions to resources and users.

- Ensure that access to production environments is limited. Ideally, no one has standing access to production environment, instead relying on automation to handle deployments and [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) for emergency access.
