---
title: Understand data management and role-based access control for the data management and analytics scenario in Azure
description: Learn about data management and role-based access control for the data management and analytics scenario in Azure.
author: mboswell
ms.author: mboswell
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand data management and role-based access control for the data management and analytics scenario in Azure

Authorization is the act of granting an authenticated party permission to perform an action. The key principle of access control is giving users only the amount of access that they need to do their jobs and only allowing certain actions at a particular scope. Role-based security/role-based access control (RBAC) corresponds to access control and is used by many organizations to control access based on defined roles or job functions versus individual users. Users are then assigned one or more security roles, each of which is given authorized permissions to perform specific tasks. For example, data engineers with the *data ingestion developer* job function will be assigned the Contributor role within Data Lake Storage in the development environment. This contributor gains permission to manage all Azure Data Lake Storage settings except granting access.

When using Azure Active Directory (Azure AD) as the centralized identity provider, authorization to access data services and storage can be granted per user or per application and is based on an Azure AD identity. Authorization covers RBAC to the service and access control list at the file, folder, or object level in the storage.

## Data service authorization

Microsoft Azure includes standard and built-in RBAC, which is an authorization system built on Azure Resource Manager that provides detailed access management to Azure resources. RBAC roles help to control access levels to resources; what can a security principal, user, group, service, or application do with the resources and areas to which they have access? When planning an access control strategy, it's recommended to grant users only the amount of access that they need to perform their jobs and only allow certain actions at a particular scope.

The following built-in roles are fundamental for all Azure resource types, including Azure data services:

|| Description |
|---|---|
| **Owner:**| This role has full access to the resource and can manage everything about the resource, including the right to grant access to it.|
| **Contributor:**| This role can manage the resource but can't grant access to it. |
| **Reader:**| This role can view the resource and information about it (except for sensitive information like access keys or secrets), but they can't make any changes to the resource.|

Some services have specific RBAC roles like Storage Blob Data Contributor or Data Factory Contributor, which means that specific RBAC roles should be used for these services. RBAC is an additive model where adding role assignments is an active permission. RBAC also supports *deny* assignments which take precedence over *role* assignments.

## RBAC general practices for the data management and analytics scenario in Azure

The following best practices can help you to get started with RBAC:

- **Use RBAC roles for service management and operations, and use service-specific roles for data access and workload-specific tasks:** Use RBAC roles on Azure resources for granting permission to security principals that need to perform resource management and operations tasks. For security principals that need to access data within storage, they don't an RBAC role on the resource because they don't need to manage it. Instead, grant permission to data objects directly; for example, read-access on a folder in Azure Data Lake Storage Gen2 or a contained database user and table permission on a database in Azure SQL database.

- **Use built-in RBAC roles:** First, use the built-in RBAC Azure resource roles to manage services and assign operations roles to control access. Create and use custom roles for Azure resources only when built-in roles don't meet specific needs.

- **Use groups to manage access:** Assign access to Azure AD groups, and manage group memberships for ongoing access management.

- **Subscription and resource group scopes:** While it makes sense to grant access at the resource group scope to separate service management and operations access needs versus granting access to individual resources (especially in the nonproduction environment), you can instead grant access to individual resources for workload-specific tasks like data lake file system support and operations, especially in the production environment. This is because in nonproduction environments, developers and testers will need to manage resources like creating an Azure Data Factory ingestion pipeline or creating a container in Data Lake Storage Gen2. While in production, users only need to use resources like viewing the status of a scheduled Data Factory ingestion pipeline or reading data files in Data Lake Storage Gen2.

- **Don't grant unnecessary access at the subscription scope:** This scope covers all resources within the subscription.

- **Opt for least-privilege access:** Select the right and only role for the job.

## Next steps

[Automating security](./security-provisioning.md)
