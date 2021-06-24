---
title: "'data management and analytics' role based access control"
description: data management and analytics' role based access control
author: mboswell
ms.author: mboswell
ms.date: 06/24/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Authorization

## Overview

Authorization is the act of granting an *authenticated party* permission to do something. The key principle of access control is granting only the amount of access to users that they need to perform their jobs and only allow certain actions at a particular scope. Corresponding to this principle is role-based security or role-based access control (RBAC) which is used by the majority of organizations to control access based on defined roles or job functions, not per individual users. Users are
then assigned one or more security roles, each of which is given authorized permissions to perform specific tasks. For example, data engineers whose job function is data ingestion developer will be assigned the "Contributor" role on the data lake storage in the development environment. This "Contributor" role is granted permission
to manage all settings of the data lake storage except granting access.

When using Azure AD as the centralized identity provider, authorization to access data services and data storage can be made per user or per application based on its Azure AD identity. Authorization covers role-based access control to the service and access control list at file, folder, or object-level in the storage.

## Data Services Authorization

Microsoft Azure includes the standard, built-in role-based access control (RBAC) which is an authorization system built on Azure Resource Manager that provides fined-grain access management for Azure resources. RBAC roles help to control the level of access to resources – what a security principal, a user, group, service or application, can do with the resources and areas to which the security principal can access. When planning access control strategy, it's best to grant only the amount of access to users that they need to perform their jobs and only allow certain actions at a particular scope.

Followings are fundamental built-in roles for all Azure resource types including Azure data services:

|| Description |
|---|---|
| **Owner:**| Has full access to the resource and can manage everything about the resource including the right to grant access to the resource.|
| **Contributor:**|Can manage the resource except for granting access to the resource. |
| **Reader:**| Can view the resource and information about the resource except for sensitive information such as access keys or secrets and cannot make any resource changes.|

Some services have specific RBAC roles such as Storage Blob Data Contributor or Data Factory Contributor which means for these services, specific RBAC roles should be used.
RBAC is an additive model. Effective permissions are the addition of role assignments. RBAC also support "deny" assignments which take precedence over role assignments.

## RBAC General Practices for Enterprise Scale Anlaytics and AI

- Use RBAC roles for service management and operations and use service-specific roles for data access and workload-specific tasks.
  - Use RBAC roles on Azure resources for granting permission to security principals that need to perform resource management and operations tasks. For security principals that need to access data in a storage, they do not need an RBAC role on the resource because they don't need to manage the resource. Instead, grant permission to data objects directly; for example, a read access on a folder in ADLS Gen 2 or a contained database user and table permission on a database in SQL DB.
- Use built-in RBAC roles
  - Use the built-in RBAC roles for Azure resources for service management and operations role assignments to control access first. Create and use custom roles for Azure resources only when built-in roles do not meet specific needs.
- Manage access using groups
  - Assign access to Azure AD groups and manage membership of groups for on-going access management.
- Subscription and Resource Group Scopes
  - It makes sense to grant access at the resource group scope to segregate service management and operations access needs as opposed to granting access to individual resources especially in the non-prod environment but for workload-specific tasks such as data lake file system support and operations, do grant access to individual resources instead especially in the production environment. This is because in non-prod environment, developers and testers will need to be able to manage resources such as creating an ADF ingestion pipeline or creating a container in ADLS Gen 2 while in production, users only need to use resources such as viewing the status of a scheduled ADF ingestion pipeline or reading data files in ADLS Gen 2.
  - Never grant access at the subscription scope unnecessarily because this scope covers all resources within the subscription.
- Least privilege
  - As always, pick the right and only needed role for the job

