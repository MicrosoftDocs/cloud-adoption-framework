---
title: Identity and access management for Azure Arc-enabled servers
description: Describes how to improve identity and access management for the Azure Arc-enabled servers.
author: chintalavr
ms.author: vchintala
ms.date: 11/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Identity and access management for Azure Arc-enabled servers


Your organization needs to design the right access controls to secure hybrid environments using on-premises and cloud-based identity management systems.

These identity management systems play an important role. They help designing and implementing reliable access management controls for securing Azure Arc-enabled servers infrastructure.

### Managed identity

The Azure AD system-assigned identity can only be used to update the status of the Azure Arc-enabled servers (for example, the 'last seen' heartbeat). It's still possible to allow an application on your server to use the system-assigned identity, to access Azure resources (for example, to request secrets from a key vault). You should:

- Consider which legitimate use-cases exist for server applications to [obtain access tokens](/azure/azure-arc/servers/managed-identity-authentication) and access Azure resources, while also planning for access control of these resources.
- Control privileged user roles on Azure Arc-enabled servers (members of the local administrators or hybrid agent extensions applications group on Windows and members of the [himds](/azure/azure-arc/servers/agent-overview#agent-component-details) group on Linux) to avoid system-managed identities being misused to gain unauthorized access to Azure resources.
- Use Azure RBAC to control and manage the permission for Azure Arc-enabled servers managed identities and perform periodic access reviews for these identities.

## Role-based access control (RBAC)

Following the [least privilege principle](/security/benchmark/azure/baselines/arc-enabled-security-baseline#pa-7-follow-just-enough-administration-least-privilege-principle)-users, groups, or applications assigned with roles like "contributor" or "owner" or "Azure Connected Machine Resource Administrator" are able to execute operations like deploying extensions, which basically has root access on Azure Arc-enabled servers. These roles should be used with caution, to limit the possible blast radius or eventually replaced by custom roles.

To limit the privilege of a user and only allow them to onboard servers to Azure, the Azure Connected Machine Onboarding role is suitable. This role can only be used to onboard servers and cannot reonboard or delete the server resource. Make sure to review the [Azure Arc-enabled servers security overview](/azure/azure-arc/servers/security-overview) for more information about access controls.

Review the [Identity and access management for Azure Arc-enabled servers](./eslz-identity-and-access-management.md) section of this guide for more identity and access related content.

Also consider the sensitive data that is sent to the Azure Monitor Log Analytics workspace, the same RBAC principle should be applied to the data itself. Azure Arc-enabled servers provides RBAC access to log data collected by the Log Analytics agent, stored in the Log Analytics workspace the machine is registered to. Review how to implement granular Log Analytics workspace access in the [designing your Azure Monitor Logs deployment documentation](/azure/azure-monitor/logs/design-logs-deployment#access-control-overview).

## Architecture

The following diagram shows a reference architecture that demonstrates the roles, permissions, and flow of actions for Azure Arc-enabled servers:

[ ![The following image shows reference architecture that demonstrates the identities, roles, permissions and flow of actions for Azure Arc-enabled servers.](./media/arc-enabled-servers-iam.png)](./media/arc-enabled-servers-iam.png#lightbox)

## Design considerations

- Decide who from your organization should have access to onboarding servers to set up required permissions on the servers and in Azure.
- Decide who should manage Azure Arc-enabled servers. Then, decide who can view their data from Azure services and other cloud environments.
- Decide how many service principal accounts you need. These accounts are used to onboard servers that are owned by different business functions or units in an enterprise that is based on operational responsibility and ownership.
- Review the [identity and access management design area](/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) of Azure landing zone enterprise-scale. Review the area to assess the impact of Azure Arc-enabled servers on your overall identity and access model.

## Design recommendations

- **Server onboarding and administration**
  - Use security groups to assign local administrator rights to the identified users or service accounts on the servers to onboard to Azure Arc at scale.
  - Use [Azure AD service principal](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) to onboard servers to Azure Arc. Consider using multiple Azure AD service principals in a decentralized operating model, where servers are managed by different IT teams.
  - Use a short-lived Azure AD service principal [client secrets](/azure/active-directory/develop/howto-create-service-principal-portal#option-2-create-a-new-application-secret).
  - Assign the [Azure Connected Machine Onboarding](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) role at the resource group level.
  - Use Azure AD security groups and grant the [Hybrid Server Resource Administrator](/azure/azure-arc/servers/plan-at-scale-deployment#prerequisites) role. Grant the role to teams and individuals that will manage Azure Arc-enabled server resources in Azure.
- **Azure AD protected resource access**
  - Use [managed identities](/azure/azure-arc/servers/managed-identity-authentication) for applications running on your on-premises servers (and other cloud environments) to provide access to cloud resources protected by Azure AD.
  - Restrict access to managed identities to [allow applications](/azure/active-directory/develop/v2-permissions-and-consent) that are authorized using Azure Active Directory application permissions.
  - Use [`Hybrid agent extension applications`](/azure/azure-arc/servers/security-overview#using-a-managed-identity-with-azure-arc-enabled-servers) local security group on Windows or the *himds* group on Linux to grant access to users to request Azure resource access tokens from the Azure Arc-enabled servers.

## Next steps

For more guidance for your hybrid cloud adoption journey, review the following articles:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers
- To learn more about Azure Arc, check out the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/)
