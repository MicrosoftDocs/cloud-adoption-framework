---
title: Identity and access management for Azure Arc-enabled servers
description: Learn how to secure Azure Arc-enabled servers with managed identities, role-based access control, and service principals.
author: chintalavr
ms.author: vchintala
ms.date: 11/12/2021
ms.topic: conceptual
ms.custom:
  - e2e-hybrid
  - think-tank
  - sfi-image-nochange
---

# Identity and access management for Azure Arc-enabled servers

This article explains how to secure hybrid servers by combining on-premises and cloud identity and access controls. It helps you design access controls for Azure Arc-enabled servers to reduce risk and manage access consistently.

Identity management systems play an important role. They help you design and implement reliable access controls for Azure Arc-enabled servers. The following diagram illustrates identities, roles, permissions, and action flows:

[![Reference architecture diagram for Azure Arc-enabled servers showing identities, roles, permissions, and action flows.](./media/arc-enabled-servers-iam.png)](./media/arc-enabled-servers-iam.png#lightbox)

## Configure managed identities

System-assigned managed identities provide secure authentication for Azure Arc-enabled servers without storing credentials. The Azure Connected Machine agent creates these identities automatically during server onboarding, but they have no permissions by default and require explicit Azure RBAC role assignments to access Azure resources.

1. **Identify legitimate use cases for managed identity access.** Applications on your servers need specific access tokens to call Azure resources like Key Vault or Storage. Plan access control for these resources before granting permissions to avoid security gaps.

2. **Control privileged user access to managed identity endpoints.** Members of local administrators or the [Hybrid Agent Extensions Applications group](/azure/azure-arc/servers/agent-overview#windows-agent-installation-details) on Windows and the [himds](/azure/azure-arc/servers/agent-overview#agent-component-details) group on Linux can request access tokens. Limit membership in these groups to prevent unauthorized access to Azure resources.

3. **Implement role-based access control for managed identities.** Use Azure RBAC to grant only the minimum required permissions to managed identities. Perform periodic access reviews to ensure permissions remain appropriate and remove unused access.

## Apply role-based access control

Role-based access control limits user privileges and reduces security risks. Users with broad roles like Contributor or Owner can deploy extensions and gain administrative access to Azure Arc-enabled servers, creating potential security vulnerabilities.

1. **Apply the least privilege principle to role assignments.** Users, groups, and applications should receive only the minimum permissions needed for their tasks. Roles like Contributor, Owner, or Azure Connected Machine Resource Administrator grant extensive access that can effectively delegate root access to servers.

2. **Use the Azure Connected Machine Onboarding role for server registration.** This role allows users to onboard servers to Azure Arc without granting broader management permissions. The role provides only the permissions needed to create and read Arc resources, not to manage extensions or delete servers.

3. **Secure access to monitoring data.** Read access to Azure Arc-enabled servers can expose log data collected by the Log Analytics agent. Apply RBAC controls to Log Analytics workspaces to limit who can view sensitive operational data.

Also consider the sensitive data that might be sent to the Azure Monitor Log Analytics workspace; apply the same RBAC principle to the data itself. Read access to Azure Arc-enabled servers can provide access to log data collected by the Log Analytics agent and stored in the associated Log Analytics workspace. Review how to implement granular Log Analytics workspace access in the [designing your Azure Monitor Logs deployment documentation](/azure/azure-monitor/logs/design-logs-deployment#access-control-overview).

## Plan identity and access responsibilities

Organizational clarity prevents security gaps and operational conflicts. Clear role definitions ensure the right people have appropriate access to onboard and manage Azure Arc-enabled servers.

1. **Define server onboarding responsibilities.** Identify who can onboard servers and set required permissions on both the servers and in Azure. This role requires local administrator access on servers and appropriate Azure permissions.

2. **Assign ongoing management responsibilities.** Determine who manages Azure Arc-enabled servers after onboarding and who can view operational data from Azure services. Separate these responsibilities based on operational needs and security requirements.

3. **Plan service principal distribution.** Create multiple Arc onboarding service principals when different business teams own and operate server groups. Scope each principal to the minimum required resource groups to limit potential security exposure.

4. **Assess enterprise-scale impact.** Review the [identity and access management design area](../../../ready/landing-zone/design-area/identity-access.md) of Azure landing zone enterprise-scale to understand how Azure Arc-enabled servers affect your overall identity strategy.

## Implement security controls

Security controls protect Azure Arc-enabled servers and the resources they can access. Proper implementation reduces attack surface and ensures compliance with security policies.

1. **Configure secure server onboarding.** Use security groups to assign local administrator rights to identified users or service accounts for Azure Arc onboarding at scale. This approach provides consistent access control across your server fleet.

2. **Deploy service principals with certificates.** Use a [Microsoft Entra service principal](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) with certificate authentication for server onboarding. Certificates are the recommended authentication method over client secrets because they provide stronger security, support conditional access policies, and reduce credential exposure risk. Scope each principal to the minimum required resource group or subscription.

3. **Secure client secrets when certificates are not available.** If you use client secrets for service principals, make them short-lived, rotate them regularly, and restrict the principal's scope and permissions to reduce security exposure.

4. **Apply appropriate role assignments.** Assign the [Azure Connected Machine Onboarding](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) role at the resource group level for onboarding operations. Grant the [Azure Connected Machine Resource Administrator](/azure/role-based-access-control/built-in-roles/management-and-governance#azure-connected-machine-resource-administrator) role to teams who manage server resources in Azure.

5. **Control managed identity access.** Use [managed identities](/azure/azure-arc/servers/managed-identity-authentication) for applications on servers to access Microsoft Entra protected resources. Restrict access to only authorized applications using Microsoft Entra application permissions.

6. **Manage local access to identity endpoints.** Use the [`Hybrid agent extension applications`](/azure/azure-arc/servers/security-overview#using-a-managed-identity-with-azure-arc-enabled-servers) security group on Windows or the *himds* group on Linux to control which users can request Azure resource access tokens from Arc-enabled servers.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Identity | [Microsoft Entra managed identities](/azure/azure-arc/servers/managed-identity-authentication) | Provides secure authentication for applications without storing credentials |
| Security | [Azure Role-Based Access Control](/security/benchmark/azure/baselines/arc-enabled-security-baseline#pa-7-follow-just-enough-administration-least-privilege-principle) | Controls access to resources based on least privilege principle |
| Onboarding | [Microsoft Entra service principal](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) | Enables automated server onboarding at scale |
| Security | [Azure Arc-enabled servers security overview](/azure/azure-arc/servers/security-overview) | Comprehensive security guidance for Arc-enabled servers |
| Monitoring | [Azure Monitor Logs deployment guide](/azure/azure-monitor/logs/design-logs-deployment#access-control-overview) | Implements granular access control for log data |
| Architecture | [Identity and access management design area](../../../ready/landing-zone/design-area/identity-access.md) | Enterprise-scale landing zone identity guidance |
| Permissions | [Microsoft Entra application permissions](/entra/identity-platform/permissions-consent-overview) | Controls application access to managed identities |
| Prerequisites | [Azure Arc-enabled servers prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) | Requirements for deploying Arc-enabled servers |
| Deployment | [At-scale deployment planning](/azure/azure-arc/servers/plan-at-scale-deployment) | Guidance for large-scale Arc server deployments |
| Learning | [Azure Arc learning path](/training/paths/manage-hybrid-infrastructure-with-azure-arc/) | Comprehensive training for Azure Arc management |

## Next steps

> [!div class="nextstepaction"]
> [Network topology and connectivity for Azure Arc-enabled servers](eslz-arc-servers-connectivity.md)
