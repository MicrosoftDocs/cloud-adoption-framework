---
title: Identity and access management considerations for Azure Arc-enabled servers
description: Describes how to improve identity and access management for the Azure Arc-enabled servers.
author: Venkata Chintala
ms.author: vchintala
ms.date: 09/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-arc-enabled-servers
---

# Identity and access management considerations for Azure Arc-enabled servers

Your organization or enterprise needs to design right access controls to secure hybrid environments using on-premises and cloud identity management systems. On-premises and cloud identity management systems play an important role in designing, and implementing right access management controls in securing Azure Arc-enabled server infrastructure.

## Design considerations

- Decide who has access to onboarding servers from your organization to setup required permissions on the servers and in Azure resource manager.
- Decide who has access to manage Azure Arc-enabled servers and ability to view their data from Azure services and other cloud environments.
- Decide between single or multiple service principals to onboard servers owned by different business functions/units in an enterprise base on who operates these servers.
- Decide between short lived or long lived service principal credentials (client secrets) to onboard servers to Azure Arc.

## Design recommendations

- **Server on-boarding and administration**
  - Use security groups to assign local administrator rights to the identified users or service accounts on the servers to onboard to Azure Arc at scale.
  - Use [Azure AD service principal](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) to onboard servers to Azure Arc.
  - Use separate Azure AD service principals to onboard severs when operated by different IT teams.
  - Use short lived Azure AD service principal [credentials (client secret)](/azure/active-directory/develop/howto-create-service-principal-portal#option-2-create-a-new-application-secret) to onboard servers to Azure Arc.
  - Assign only [Azure Connected Machine Onboarding](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) role to service principal at the resource group level.
  - Create an Azure AD security group or Windows Active Directory security group(synced to Azure AD) and assign [Hybrid Server Resource Administrator](/azure/azure-arc/servers/plan-at-scale-deployment#prerequisites) role to manage Azure Arc-enabled server resources in Azure, then assign individual users or principals to the security group.

- **Azure AD protected resource access**
  - Use [managed identities](/azure/azure-arc/servers/managed-identity-authentication) from applications running on servers on-premises and other cloud environments to access resources protected by Azure Active Directory.
  - Restrict access to managed identities to [allow applications](/azure/active-directory/develop/v2-permissions-and-consent) that are authorized using Azure Active Directory application permissions.
  - Use [*Hybrid agent extension applications*](/azure/azure-arc/servers/security-overview#using-a-managed-identity-with-azure-arc-enabled-servers) local security group on Windows or *himds* group on Linux to grant access to users to request Azure resource access tokens from the Azure Arc-enabled servers.
