---
title: Identity and access management for Oracle Database@Azure
description: Learn how to design your identity and access management approach for Oracle Database@Azure.
author: sihbher
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Enterprise-scale identity and access management for Oracle Database@Azure

This article builds on the information found in [Identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). Use this information to examine design considerations and recommendations for identity and access management that's specific to the deployment of Oracle Database@Azure. Identity requirements for Oracle Database@Azure vary according to its implementation in Azure. The information provided in this article is based on the most common scenarios. 

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and is colocated in Azure datacenters at Microsoft. This offering, jointly provided by Microsoft and Oracle Cloud Infrastructure (OCI), requires managing identities and role-based access control (RBAC) across both platforms. This guide outlines best practices for identity and access management to create consistent deployment patterns for Oracle Database@Azure. 

Consider the following identity and access management recommendations for Oracle Database@Azure:

- Accept and enable the Oracle Database@Azure [private offer](/marketplace/private-offers-overview) on Azure Marketplace for your subscription. You need contributor access to the subscription to deploy the Oracle Database@Azure service. For more information, see [Set Up Identity Federation](https://docs.oracle.com/iaas/Content/database-at-azure/oaaonboard-task-8.htm#oaaonboard_task_8). If you aligned your operational model with Azure landing zone principles, the individual application development team that requires Oracle Database@Azure services manages the process. There might be parts of the process that a centralized platform team needs to handle if you run a more traditional model.
- When deploying the initial Oracle Exadata Database@Azure instance, certain default groups are automatically created within Microsoft Entra ID and the corresponding OCI tenant. Some of these groups are replicated to OCI, where policies are defined. These groups are used to manage the various actions required for Oracle Database@Azure services. For more information, see [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles).
- Custom Oracle Exadata Database@Azure group names can be assigned but need to be configured manually. Policies are created for [specific group names](/azure/oracle/oracle-db/oracle-database-groups-roles). If you change the group name, you also need to change the policy statement in OCI.
- Contact the OCI administrator to establish other groups and roles within the OCI tenant to enhance the granularity of access permissions. OCI provides control over who can create and manage Oracle Database@Azure resources.
- For architectures with multiple clusters, RBAC group permissions are applied to all clusters in the subscription. To specify RBAC to individual clusters separately, create customized group names and policies in OCI and Azure for each cluster.
- Federation to third party identity providers or Microsoft Active Directory is supported. 
- For security recommendations beyond federation of identity and RBAC, refer to [Security guidelines for Oracle Database@Azure](./oracle-security-overview-odaa.md).

## Design recommendations

- [Implement Federation between Azure and OCI](https://docs.oracle.com/iaas/Content/Identity/tutorials/azure_ad/lifecycle_azure/01-config-azure-template.htm#config-azure-template) including Single Sign On (SSO) and replication of users and groups. 
- Enable users to sign in to OCI by using their Microsoft Entra ID credentials by configuring federation between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI). To implement federation, follow the instructions in [Set Up Identity Federation](/azure/oracle/oracle-db/onboard-oracle-database#step-3-optional-create-identity-federation-using-azures-identity-service).
- When you provision a new account and tenant, an Admin user is created in OCI. Avoid using this Admin identity for day-to-day operations. Instead use the Microsoft Entra administrator groups to provide elevated access for the relevant individuals.
- Use Azure role-based access control (RBAC) to control user access to Oracle Database@Azure resources. Follow the principle of least privilege (PoLP) when assigning users to Database@Azure roles.
- Ensure Entra Id based users are secure. Follow [Identity Management access and best practices](/azure/security/fundamentals/identity-management-best-practices). When securing your entra ID based users, enable [identity protection](/entra/id-protection/overview-identity-protection). Validate by using the [security checklist](/azure/security/fundamentals/steps-secure-identity) for Identity & access management
- Enable [Entra ID Audit Logging](/entra/identity/monitoring-health/concept-audit-logs) to monitor access related events.

- [Security guidelines for Oracle Database@Azure](./oracle-security-overview-odaa.md)
