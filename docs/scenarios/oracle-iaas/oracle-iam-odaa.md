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
In this article
1.	Design considerations
2.	Design recommendations
3.	Next steps

This article builds on the information found in [Identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). Use this information to examine design considerations and recommendations for identity and access management that's specific to the deployment of Oracle Database@Azure. Identity requirements for Oracle Database@Azure may vary according to its implementation in Azure. The information provided in this article is based on the most common scenarios. 

Oracle Database@Azure is a multi-cloud solution where Oracle Exadata runs directly within an Azure data centre, using Azure infrastructure. This offering, jointly provided by Microsoft and Oracle Cloud Infrastructure (OCI), requires managing identities and RBAC across both platforms. This guide outlines best practices for identity and access management to create consistent deployment patterns for Oracle Database@Azure. 


## Design considerations

Consider the following identity and access management recommendations for Oracle Database@Azure:

- Accept and enable the Oracle Database@Azure [private offer](https://learn.microsoft.com/marketplace/private-offers-overview) on Azure Marketplace for your subscription. You need contributor access to the subscription to deploy the Oracle Database@Azure service. For more information, see [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database). If you aligned your operational model with Azure landing zone principles, the individual application development team that requires Oracle Database@Azure services manages the process. There might be parts of the process that a centralized platform team needs to handle if you run a more traditional model.
- You can configure federation between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI) to enable users to sign in to OCI by using their Microsoft Entra ID credentials. To enable federation, follow the instructions in [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database#step-3-optional-create-identity-federation-using-azures-identity-service).
- Deploy the initial Oracle Database@Azure instance to create specific groups within Microsoft Entra ID and in the corresponding OCI tenant. For more information, see [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles). The groups created in the OCI tenant have the necessary permissions to create and manage Oracle Database@Azure services.
- Custom Oracle Database@Azure group names can be assigned but require manual setup.  Policies are created for [specific group names](/azure/oracle/oracle-db/oracle-database-groups-roles).  If you change the group name you also need to change the policy statement in OCI.  
- When you provision a new account and tenant, an Admin user is created in OCI. Avoid using this Admin identity for day-to-day operations. Instead use the Microsoft Entra administrator groups to provide elevated access for the relevant individuals.
- Contact the OCI administrator to establish other groups and roles within the OCI tenant to enhance the granularity of access permissions. OCI provides control over who can create and manage Oracle Database@Azure resources.
- There are two pre-defined roles for Oracle Database@Azure for infrastructure and cluster administration: [odbaa-exa-infra-administrator and odbaa-vm-cluster-administrator](/azure/oracle/oracle-db/oracle-database-groups-roles#groups-and-roles-in-azure).  These roles can be assigned to groups.  By default, these roles will be assigned to the odbaa-exa-infra-administrators and odbaa-vm-cluster-administrators groups respectively.
- For architectures with multiple clusters, RBAC group permissions assigned will be applied to all clusters in the subscription.  To specify RBAC to individual clusters separately, create customized group names and policies in OCI and Azure for each cluster.
- Federation to third party identity providers or Microsoft Active Directory is supported.  
- For security recommendations beyond federation of identity and RBAC, please refer to [Security guidelines for Oracle Database@Azure](./oracle-security-overview-odaa).

## Design recommendations

- [Implement Federation between Azure and OCI](https://docs.oracle.com/iaas/Content/Identity/tutorials/azure_ad/lifecycle_azure/01-config-azure-template.htm#config-azure-template) including Single Sign On (SSO) and replication of users and groups.  
- Use federated Microsoft Entra ID credentials to log into OCI. Although users can sign in with OCI credentials, this practice is not recommended as it increases the number of user identities that need to be managed.
- Use Azure role-based access control (RBAC) to control user access to Oracle Database@Azure resources.  Follow the principle of least privilege (PoLP) when assigning users to Database@Azure roles.
- Ensure Entra Id based users are secure.  Follow [Identity Management access and best practices](/azure/security/fundamentals/identity-management-best-practices).  To secure your entra ID based users please enable [identity protection](https://learn.microsoft.com/en-us/entra/id-protection/overview-identity-protection). Validate by using the [security checklist](/azure/security/fundamentals/steps-secure-identity) for Identity & access management
- Enable [Entra ID Audit Logging](https://learn.microsoft.com/entra/identity/monitoring-health/concept-audit-logs) to monitor access related events.

## Next steps

- [Security guidelines for Oracle Database@Azure](./oracle-security-overview-odaa)
