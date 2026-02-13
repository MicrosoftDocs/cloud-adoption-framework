---
title: Identity and Access Management for Oracle Database@Azure
description: Learn how to design identity and access management for Oracle Database@Azure with security, user access, and integration best practices.
author: sihbher
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 09/01/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Identity and access management for Oracle Exadata Database@Azure

This article provides identity and access management guidance for Oracle Exadata Database@Azure deployments. These recommendations enable secure, compliant access across both Azure and Oracle Cloud Infrastructure (OCI) while maintaining operational efficiency.

Oracle Database@Azure requires coordinated identity management across Azure and OCI platforms. Implement these recommendations to establish consistent security posture, enable seamless user access, and maintain compliance with organizational policies while supporting Oracle Exadata Database@Azure services.

## Establish federated identity foundation

Identity federation between Azure and OCI enables unified access management across both platforms. Configure federation before deploying Oracle Database@Azure services to ensure consistent security and access patterns.

1. **Configure Microsoft Entra ID federation with OCI.** Establish [identity federation between Azure and OCI](https://docs.oracle.com/iaas/Content/Identity/tutorials/azure_ad/lifecycle_azure/01-config-azure-template.htm#config-azure-template) to enable single sign-on (SSO) and automated user provisioning. This federation allows users to access OCI resources by using their existing Azure credentials. For Microsoft Entra ID integration patterns, see [Application provisioning in Microsoft Entra ID](/entra/identity/app-provisioning/user-provisioning).

2. **Enable SSO capabilities.** Configure SSO between Microsoft Entra ID and OCI to streamline user authentication across both platforms. This configuration reduces credential management overhead and improves user experience. For SSO configuration guidance, see [Microsoft Entra SSO](/entra/identity/enterprise-apps/what-is-single-sign-on).

3. **Implement automated user and group synchronization.** Set up automated replication of users and groups from Microsoft Entra ID to OCI to maintain consistent access policies across platforms. This automation reduces administrative overhead and ensures access consistency. For provisioning configuration, see [Plan an automatic user provisioning deployment](/entra/identity/app-provisioning/plan-auto-user-provisioning).

4. **Validate federation before Oracle Database@Azure deployment.** Test identity federation functionality before you deploy Oracle Database@Azure services to ensure seamless integration. Verify that user authentication, group membership synchronization, and access policy enforcement work correctly across both platforms.

## Deploy Oracle Database@Azure with proper permissions

Oracle Database@Azure deployment requires specific Azure permissions and creates default identity groups. Plan the deployment process to align with your organization's identity governance and operational model.

1. **Assign Contributor role for Oracle Database@Azure deployment.** Ensure that deployment personnel have the [Contributor role](/azure/role-based-access-control/built-in-roles#contributor) for the target subscription before accepting the [private offer](/marketplace/private-offers-overview) on Microsoft Marketplace. This role provides the minimum required permissions for Oracle Database@Azure service deployment. For subscription access management, see [Assign Azure roles by using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

2. **Plan for automatic group creation.** Oracle Database@Azure deployment automatically creates specific default groups in Microsoft Entra ID and the corresponding OCI tenant during provisioning. These [groups](/azure/oracle/oracle-db/oracle-database-groups-roles) include predefined permissions for Oracle Database@Azure operations.

3. **Follow the deployment team operational model.** Align the deployment process with your organization's operating model. Application development teams should manage Oracle Database@Azure deployment in decentralized models, while platform teams handle deployment in centralized operational models. For landing zone guidance, see [Azure landing zone design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas).

4. **Document automatic group assignments.** Record the automatically created groups and their associated permissions for future reference and security auditing. This documentation supports ongoing identity governance and compliance reporting.

## Configure role-based access control for Oracle Database@Azure

Implement granular access control with Azure role-based access control (Azure RBAC) and OCI policies to enforce least privilege access across Oracle Database@Azure resources. Configure access controls that align with your organizational security requirements.

1. **Apply least privilege principles to Database@Azure roles.** Use Azure RBAC to control user access to Oracle Database@Azure resources with minimum required permissions. Assign users to specific Oracle Database@Azure roles based on their job functions instead of granting broad access. For more information, see [Best practices for Azure RBAC](/azure/role-based-access-control/best-practices).

2. **Customize group names for enhanced security.** Create custom group names for Oracle Database@Azure roles when default names don't align with organizational naming conventions. Custom group names require manual policy configuration in both Azure and OCI. For policy management guidance, see [Azure Policy overview](/azure/governance/policy/overview).

3. **Establish granular permissions through OCI administrator coordination.** Work with OCI administrators to create extra groups and roles within the OCI tenant for enhanced access granularity. This coordination ensures consistent permissions across both platforms while meeting specific organizational requirements.

4. **Implement cluster-specific RBAC for multi-cluster architectures.** Create separate customized groups and policies for each cluster when you manage multiple Oracle Database@Azure clusters. Default RBAC group permissions apply to all clusters within a subscription. Administrators must configure custom settings to enforce cluster-specific access control.

5. **Configure Azure Arc-enabled servers with managed identities for Azure Key Vault TDE integration in Oracle Exadata Database@Azure.** Oracle Exadata Database@Azure integrates with Azure Key Vault through Azure Arc-enabled servers with system-assigned managed identities for each database node. Use Azure RBAC with Microsoft Entra ID security groups assigned Key Vault Crypto Officer and Key Vault Reader roles to manage encryption key access. This group-based approach simplifies permission management across multiple database nodes while maintaining least-privilege principles. For complete identity configuration procedures including Oracle Identity Connector setup, managed identity authentication, and RBAC assignments, see [Azure Key Vault integration for Oracle Exadata Database@Azure](oracle-azure-key-vault-integration-exadata.md).

## Integrate Azure Arc identity management

Azure Arc integration with Oracle Database@Azure requires dedicated service principals and hybrid identity planning. Configure Arc identity components to support governance and monitoring capabilities without disrupting existing OCI federation.

1. **Create dedicated service principals for Azure Arc operations.** Establish service principals specifically for Arc agent onboarding and ongoing management operations. Assign the [Azure Connected Machine Onboarding](/azure/role-based-access-control/built-in-roles#azure-connected-machine-onboarding) role for Azure Arc agent registration and [Log Analytics Contributor](/azure/role-based-access-control/built-in-roles#log-analytics-contributor) permissions for centralized monitoring. For more information, see [Create a service principal for onboarding at scale](/azure/azure-arc/servers/onboard-service-principal).

2. **Implement managed identity authentication for Azure Arc agents.** Use [managed identity authentication](/azure/azure-arc/servers/managed-identity-authentication) for Azure Arc agents where possible to minimize credential management overhead. This approach reduces security risks associated with stored credentials and simplifies credential life cycle management.

3. **Secure service principal credentials by using Azure Key Vault.** Store service principal credentials securely by using [Key Vault](/azure/key-vault/general/overview) when managed identity authentication isn't available. Implement automated credential rotation policies that align with existing Azure identity governance frameworks.

4. **Plan hybrid identity integration points.** Azure Arc creates extra identity touch points between Azure and OCI platforms. Plan service principal life cycle management, including credential rotation and permission updates, to avoid interference with existing OCI identity federation.

For more information about Azure Arc connectivity requirements, see [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md).

## Enhance security with Microsoft Defender integration

Microsoft Defender for Cloud provides enhanced security monitoring and identity protection for Oracle Database@Azure infrastructure. Integrate Defender for Cloud recommendations with identity controls to strengthen the overall security posture.

1. **Apply Defender for Cloud security recommendations to identity controls.** Review and implement [Defender for Cloud security recommendations](/azure/defender-for-cloud/security-policy-concept) that enhance identity and access management. These recommendations provide actionable guidance for strengthening identity security across Oracle Database@Azure deployments.

2. **Validate security posture with identity management checklist.** Use the [security checklist for identity and access management](/azure/security/fundamentals/steps-secure-identity) to validate comprehensive security measures across Oracle Database@Azure environments. Regular validation ensures ongoing compliance with security best practices.

For comprehensive security guidance beyond identity management, see [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md).

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Identity federation | [Microsoft Entra ID](/entra/fundamentals/what-is-entra) | Identity and access management platform for Azure and OCI federation |
| Access control | [Azure RBAC](/azure/role-based-access-control/overview) | RBAC for Oracle Database@Azure resources |
| Privileged access | [Microsoft Entra Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) | Just-in-time privileged access management |
| Identity protection | [Microsoft Entra ID Protection](/entra/id-protection/overview-identity-protection) | Risk-based identity security and automated remediation |
| Security monitoring | [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Security posture management and threat protection |
| Hybrid management | [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) | Hybrid server management and governance |
| Credential management | [Key Vault](/azure/key-vault/general/overview) | Secure credential storage and management |

## Related resources

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md)