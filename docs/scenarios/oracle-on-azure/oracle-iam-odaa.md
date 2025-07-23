---
title: Identity and Access Management for Oracle Database@Azure
description: Learn how to design your identity and access management approach for Oracle Database@Azure by focusing on security measures, user access, and system integration best practices.
author: sihbher
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 01/31/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Identity and access management for Oracle Autonomous Database@Azure and Oracle Exadata Database@Azure

This article builds on the guidance in [Identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). Use this information to review design considerations and recommendations for identity and access management that are specific to [Oracle Database@Azure](/azure/oracle/oracle-db/database-overview) deployments. Identity requirements for Oracle Database@Azure vary depending on its implementation in Azure. This article provides information based on the most typical scenarios.

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and is colocated in Azure datacenters at Microsoft. Microsoft and OCI jointly provide this offering, which requires you to manage identities and role-based access control (RBAC) across both platforms. This guide outlines best practices for identity and access management to create consistent deployment patterns for Oracle Autonomous Database@Azure and Oracle Exadata Database@Azure.

## Considerations

- Accept and enable the Oracle Database@Azure [private offer](/marketplace/private-offers-overview) on Azure Marketplace for your subscription. You must have the Contributor role for the subscription to deploy the Oracle Database@Azure service. For more information, see [Set up identity federation](https://docs.oracle.com/iaas/Content/database-at-azure/oaaonboard-task-8.htm#oaaonboard_task_8). If your operational model is aligned with Azure landing zone principles, the individual application development team that requires Oracle Database@Azure services manages the process. If your organization uses a centralized model, the platform team might need to handle parts of the process.

- When you deploy the initial Oracle Autonomous Database@Azure or Oracle Exadata Database@Azure instance, specific default groups are automatically created within Microsoft Entra ID and the corresponding OCI tenant. Some of these groups are replicated to OCI, where policies are defined. Use these groups to manage the various actions that Oracle Database@Azure services require. For more information, see [Groups and roles in Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles).

- You can assign custom Oracle Autonomous Database@Azure and Oracle Exadata Database@Azure group names, but they need to be configured manually. Policies are created for [specific group names](/azure/oracle/oracle-db/oracle-database-groups-roles). If you change the group name, you also need to change the policy statement in OCI.

- To enhance the granularity of access permissions, contact the OCI administrator to establish other groups and roles within the OCI tenant. OCI provides control over who can create and manage Oracle Database@Azure resources.

- For architectures that have multiple clusters, RBAC group permissions are applied to all clusters in the subscription. To assign RBAC to individual clusters separately, create customized group names and policies in OCI and Azure for each cluster.

- Federation to non-Microsoft identity providers or Microsoft Active Directory is supported. For more information about security recommendations beyond federation of identity and RBAC, see [Security guidelines for Oracle Database@Azure](./oracle-security-overview-odaa.md).

## Design recommendations

- [Implement federation between Azure and OCI](https://docs.oracle.com/iaas/Content/Identity/tutorials/azure_ad/lifecycle_azure/01-config-azure-template.htm#config-azure-template), including single sign-on and replication of users and groups.

- Configure federation between Microsoft Entra ID and OCI to enable users to sign in to OCI with their Microsoft Entra ID credentials. For more information, see [Steps to onboard Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database#steps-to-onboard-oracle-databaseazure).

- When you provision a new account and tenant, an Admin user role is created in OCI. Avoid using this Admin identity for day-to-day operations. Instead, use Microsoft Entra administrator groups to provide elevated access for the relevant individuals.

- Use Azure RBAC to control users' access to Oracle Database@Azure resources. Follow the principle of least privilege when you assign users to Database@Azure roles.

- To help ensure that Microsoft Entra ID-based users are secure, follow [identity management and access control best practices](/azure/security/fundamentals/identity-management-best-practices). When you help secure your Microsoft Entra ID-based users, enable [identity protection](/entra/id-protection/overview-identity-protection). Validate your security measures by using the [security checklist](/azure/security/fundamentals/steps-secure-identity) for identity and access management.

- Enable [Microsoft Entra ID audit logging](/entra/identity/monitoring-health/concept-audit-logs) to monitor access-related events.

## Next step

> [!div class="nextstepaction"]
> [Security guidelines for Oracle Database@Azure](./oracle-security-overview-odaa.md)
