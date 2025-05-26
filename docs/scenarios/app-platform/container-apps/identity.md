---
title: Identity management in Azure Container Apps - Landing Zone Accelerator
description: Manage user identity in Azure Container Apps
author: craigshoemaker
ms.author: cshoe
ms.date: 11/01/2023
ms.topic: conceptual
---

# Identity management in Azure Container Apps - Landing Zone Accelerator

To secure your application, you can enable authentication and authorization via an identity provider such as Microsoft Entra ID or [Microsoft Entra External ID (preview)](/entra/external-id/external-identities-overview).

Consider using [managed identity](/azure/container-apps/managed-identity) instead of a service principal to connect to other resources in your container app. Managed identity is preferable as it negates the need for managing credentials. You can use [system-assigned or user-assigned managed identities](/entra/identity/managed-identities-azure-resources/overview). System-assigned managed identities offer the advantage of sharing a lifecycle with the Azure resource to which they are attached, such as a Container App. Conversely, a user-assigned managed identity is an independent Azure resource that can be reused across multiple resources, promoting a more efficient and centralized approach to identity management.

## Recommendations

- If authentication is required, use Azure Entra ID or [Azure Entra ID B2C](/entra/external-id/b2b-fundamentals) as an identity provider.

- Use separate app registrations for the application environments. For example, create a different registration for development vs. test vs. production.

- Use user-assigned managed identities unless there's a strong requirement for using system-assigned managed identities. The Landing Zone Accelerator implementation uses user-assigned managed identities for the following reasons:
    - Reusability: Because you can create and manage identities separately from the Azure resources to which they're assigned, this allows you to reuse the same managed identity across multiple resources, promoting a more efficient and centralized approach to identity management.
    - Identity Lifecycle Management: You can create, delete, and manage user-assigned managed identities independently, making it easier to manage identity-related tasks without impacting the Azure resources using them.
    - Granting Permissions: You have greater flexibility in granting permissions with user-assigned managed identities. You can assign these identities to specific resources or services as needed, making it easier to control access to various resources and services.

- Use Azure [built-in roles](/azure/role-based-access-control/built-in-roles) to assign least privilege permissions to resources and users.

- Ensure that access to production environments is limited. Ideally, no one has standing access to production environments, instead relying on automation to handle deployments and [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) for emergency access.

- Create production environments and non-production environments in separate Azure subscriptions to delineate their security boundaries.
