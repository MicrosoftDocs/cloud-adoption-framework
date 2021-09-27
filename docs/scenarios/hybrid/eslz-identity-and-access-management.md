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
- Decide between Azure Active Directory(AAD) service principal versus on-premises Windows Active Directory service accounts to onboard Windows and Linux servers to Azure Arc control plane at scale.
- For servers running in other cloud environments, decide between Azure Active Directory service principal versus cloud identity provider which is federated with Azure Active Directory.
- Decide between single or multiple service principals to onboard servers owned by different business functions/units in an enterprise base on who operates these servers.
- Decide between Run As account vs managed identity for Hybrid Runbook Worker to provide user context to access Azure resources from runbooks on Arc-enabled servers for onboarding and update management.

## Design recommendations

- **Server on-boarding and administration**
  - Use security groups to assign local administrator rights to the identified users on the servers to onboard to Azure Arc.
  - Use Azure AD service principal to onboard servers to Azure Arc.
  - Use separate service principals to onboard severs when operated by different IT teams.
  - Assign only [Azure Connected Machine Onboarding](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) role to service principal at the resource group level.
  - /azure/automation/automation-hybrid-runbook-worker
  - Create an Azure AD security group or Windows Active Directory security group(synced to Azure AD) and assign [Hybrid Server Resource Administrator](/azure/azure-arc/servers/plan-at-scale-deployment#prerequisites) role to manage Azure Arc-enabled server resources in Azure, then assign individual users or principals to the security group.

- **Azure resource access**
  - Use [managed identities](/azure/azure-arc/servers/managed-identity-authentication) to access Azure resource management and data plane from applications running on servers on-premises and other cloud providers.
  - Restrict access to managed identities to allow applications that are authorized using Azure Active Directory application permissions.
  - Use *Hybrid agent extension applications* local security group on Windows or *himds*     group on Linux to grant access to users to request Azure resource access tokens from the Azure Arc-enabled server.

- **Azure Security Center**
  - For AWS accounts [create IAM role](/azure/security-center/quickstart-onboard-aws#create-an-iam-role-for-security-center) for Azure Security Center and assign required permissions.
  - For GCP accounts create a [dedicated service account](/azure/security-center/quickstart-onboard-gcp#step-3-create-a-dedicated-service-account-for-the-security-configuration-integration) and grant required permissions for security configuration integration.
