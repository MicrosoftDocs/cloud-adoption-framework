---
title: End to End Governance
description: DESCRIPTION
author: julie-ng
ms.author: julng
ms.date: 04/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

## End to End Governance - from DevOps to Azure

It is not sufficient to plan and implement an [Azure RBAC model](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/roles) for ARM, which restricts access via Azure Portal and Azure CLI. 

If this model is not mirrored on the DevOps automation side, your organization may have a left open a **security back-door**. If a developer does not have access via ARM but still has sufficient permissions to change application code or Infrastructure as code and trigger an automation workflow, they can indirectly via DevOps access and make destructive chagnes to your ARM resources.

This article explains best practices to help plan for and avoid such a scenario.

### Single Identity Management Plane with Azure AD Groups

The first step is to integrate Azure Active Directory to leverage [single sign-on per identity management best practice](https://docs.microsoft.com/en-us/azure/security/fundamentals/identity-management-best-practices#enable-single-sign-on).

If are not using an Azure first party CI product like Azure DevOps, check if your vendor offers Azure AD integration, which many do.

The second step is to leverage Azure AD groups, the same groups you are already using for your Azure ARM RBAC model. It is [best practice to assign roles to Azure AD groups](https://docs.microsoft.com/en-us/azure/role-based-access-control/best-practices#assign-roles-to-groups-not-users), not to individuals. To create an end to end governance model, you will need to do this both for Azure ARM and for DevOps.

Azure DevOps has tight integration with Azure Active Directory including [AAD groups membership](https://docs.microsoft.com/en-us/azure/devops/organizations/security/add-ad-aad-built-in-security-groups?view=azure-devops&tabs=preview-page), making it easy to apply Role assignments to the same Azure AD group. 

(Note: if you are using another CI vendor, you may have an intermediary logical container for managing group memberships, which you also need to maintain if AAD group membership is not synchronized.)

The diagram below illustrates how Azure AD is used as the single identity management plane. In ARM and in our DevOps tooling (Azure DevOps in this diagram), we only need to manage **Role Assignments**, not memberships, which should be managed in Azure AD.

<img src="./../media/e2e-governance-overview.svg" alt="Diagram - End to End Governance">

_**Figure 1 - Secure ALL access to your Azure resources, both from ARM and CI/CD workflows**_

Please note the names follow recommended [Naming Conventions](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) and [Abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) for Azure Resources.

#### Example Scenario - remove contractor access with a single step, AAD membership

To make end to end governance concrete, let's examine the benefits with an example scenario.

If you use Azure AD as your single identity management plane as illustrated in figure 2 above, you can remove a developer's access to your Azure resources in one action - adjusting their _**Azure AD group memberships**_. For example, if a contractor's access should be revoked on project completion, removing their membership from the relevant Azure AD groups would remove both access to ARM as well as to Azure DevOps.

## Mirror RBAC Model with Role Assignments

When planned well, the RBAC model in your CI tooling will very closely mirror your Azure RBAC model. Although the Azure AD group name examples in the diagram above imply security rules, membership alone does not enforce securiy. Remember that RBAC is a combination of principals, definitions and scopes, which does not go into affect **until the role assignment is created**.

<img src="./../media/devsecops-role-assignments.svg" alt="Diagram - Azure Active Directory as Single Identity Management Plane">

_**Figure 2 - Leveraging Azure Active Directory as a single Identity Management Plane in Azure DevOps**_

Review figure 2 above closely and note:

- the diagram illustrates role assignment for a single AAD group, the `contoso-admins-group`
- this AAD group has "Owner" role on Azure ARM side at _multiple_ subscription scopes:
  - `contoso-dev-sub` subscription
  - `contoso-prod-sub` subscription
- this AAD group has "Project Administrator" role on the Azure DevOps side at a _single_ project scope.

Note: 

In this way, the Azure AD group has similarly privileged roles on both sides. Following this logic, if we have a developers group with "Contributor" access on the ARM side, we would not expect them to have "Project Administrator" access on the DevOps side. 

## Next Steps

Now that you understand you need to secure both ARM and DevOps workflows, you should 

- review your RBAC model and think about how the roles and responsibilities you have defined for ARM match to CI/CD workflow
- review your CI platform's identity management solutions and integrate Azure Active Directory, ideally including AAD group membership
- review the Roles and Access Levels offered by your CI tooling and compare with your Azure RBAC model. They will not map 1:1. Check your configuration however such that if a developer does not have acces on the ARM side, they should not be able to achieve that access on the DevOps side. In the simplest example, a developer who does not have Write permissions to production resources should not have direct access to trigger production pipeline runs. (TODO - link to Secure DevOps? That would be the next logical step)

## Further Reading

- [Cloud Adoption Framework - Operating Model - Governance design for multiple teams](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/resource-consistency/governance-multiple-teams)
- [Azure DevOps - Recommended method for granting and restricting permissions](https://docs.microsoft.com/azure/devops/organizations/security/restrict-access?view=azure-devops#recommended-method-for-granting-and-restricting-permissions)
- [Azure DevOps - Default permissions and access](https://docs.microsoft.com/azure/devops/organizations/security/permissions-access?view=azure-devops)
- [GitHub.com - Managing people's access to your organization with roles](https://docs.github.com/en/organizations/managing-peoples-access-to-your-organization-with-roles)

