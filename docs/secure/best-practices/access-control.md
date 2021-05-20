---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---


Point to: https://docs.microsoft.com/en-us/security/compass/critical-impact-accounts

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "security controls for azure access" question at the CAF level

- There are tools and processes in place to grant just-in-time access.Minimizing the number of people who have access to secure information or resources reduces the chance of a malicious actor gaining access or an authorized user inadvertently impacting a sensitive resource. For example, Azure AD Privileged Identity Management provides time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused access permissions on resources that you care about.
- No user accounts have long-standing write access to production environments.Write-access to production systems should be limited to service principals and no user accounts have regular write-access.
- Appropriate emergency access accounts are configured for this workload in case of an emergency.While rare, sometimes extreme circumstances arise where all normal means of administrative access are unavailable and for this reason emergency access accounts (also refered to as 'break glass' accounts) should be available. These accounts are strictly controlled in accordance with best practice guidance, and they are closely monitored for unsanctioned use to ensure they are not compromised or used for nefarious purposes.
- Lines of responsibility and designated responsible parties were clearly defined for specific functions in Azure.Clearly documenting and sharing the contacts responsible for each of these functions will create consistency and facilitate communication. Examples of such contact groups include network security, network management, server endpoint security, incident response, policy management, identity...
- The application team has a clear view on responsibilities and individual/group access levels for this workload.Application roles and responsibility model need to be defined covering the different access level of each operational function (e.g publish production release, access customer data, manipulate database records). It's in the interest of the application team to include central functions (e.g. SecOps, NetOps, IAM) into this view.
- Workload infrastructure is protected with role-based access control (RBAC).Performing role-based or/or resource-based authorization with Azure Active Directory allows centralized management that supports principal of least privilege when accessing organizational resources. RBAC provides the necessary tools to maintain separation of concerns when it comes to accessing the application infrastructure. Aligned with the separation of duties section, users should have only the minimal set of permissions. Examples: "Developers can't access production infrastructure.", "Only the SecOps team can read and manage Key Vault secrets.", "Project A team can access and manage Resource Group A and all resources within."
- Resource locks are leveraged to protect critical infrastructure of this workload.Critical infrastructure typically doesn't change often. To prevent accidental/undesired modification of resources, Azure offers the locking functionality where only specific roles and users with permissions are able to delete/modify resources. Locks can be used on critical parts of the infrastructure, but special care needs to be taken in the DevOps process - modification locks can sometimes block automation.
- Direct access to the infrastructure through Azure Portal, command-line Interface (CLI) or REST API is limited and CI/CD is preferred.While it is recommended to deploy application infrastructure via automation and CI/CD. To maximize application autonomy and agility, restrictive access control need be balanced on less critical development and test environments.
- Permissions to Azure workloads are rarely based on individual resources and custom permissions are rarely used.Custom resource-based permissions are often not needed and can result in increased complexity and confusion as they do not carry the intention to new similar resources. This then accumulates into a complex legacy configuration that is difficult to maintain or change without fear of "breaking something" - negatively impacting both security and solution agility. Higher level permissions sets - based on resource groups or management groups - are usually more efficient.
- There are processes and tools being used to manage privileged activities. Long standing administrative access is avoided whenever possible.Zero-trust principle comes with the requirement of no standing access to an environment. Native and 3rd party solution can be used to elevate access permissions for at least highly privileged if not all activities. Azure AD Privileged Identity Management (Azure AD PIM) is the recommended and Azure native solution.
- There is a lifecycle management policy for critical accounts in this workload and privileged accounts are reviewed regularly.
