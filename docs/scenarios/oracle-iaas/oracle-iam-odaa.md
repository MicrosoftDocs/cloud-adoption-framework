---
title: Identity and Access Management for Oracle Database@Azure
description: Design your identity and access management approach for Oracle Database@Azure.
author: sihbher
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---
# Identity and Access Management for Oracle Database@Azure

This article builds on some of the considerations and recommendations that are defined in the [Azure landing zone design](/azure/cloud-adoption-framework/ready/landing-zone/). It offers key design considerations and recommendation for Oracle Database@Azure identity and access management.

## Design Considerations

- Accept and enable the Oracle Database@Azure private offer on the Azure Marketplace for your subscription. You need contributor access to the subscription to deploy the Oracle Database@Azure service. For more information, see [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database). If you aligned your operational model with Azure landing zone principles, the individual application development team that requires Oracle Database@Azure services manages the process. If you run a more traditional model, there might be parts of the process that a centralized platform team needs to handle.
- Oracle Database@Azure doesn't natively support Microsoft Entra ID for identity and access management. However, you can configure federation between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI) to enable users to sign in to OCI using their Microsoft Entra ID credentials.
- The process of deploying the initial Oracle Database@Azure creates specific groups within Microsoft Entra ID and in the corresponding OCI tenant. For more information, see [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles). The groups created in the OCI tenant have the necessary permissions to create and manage Container Databases (CDB) and Pluggable Databases (PDB) on all the Oracle Database@Azure instances in that OCI tenant.

## Design Recommendations

- Have the Azure landing zone platform team configure federated access between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI) to enable users to sign in to OCI using their Microsoft Entra ID credentials. It's possible for users sign in with OCI credentials only, but this setup isn't recommended. Signing in with OCI credientials only creates more user identities that you have to manage. To enable federation, follow the instructions in [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database#step-3-optional-create-identity-federation-using-azures-identity-service).
- When you provision a new account and tenant, an Admin user is created in OCI. Avoid using this Admin identity for day-to-day operations. Instead use the Microsoft Entra administrator groups to provide elevated access to the relevant individuals.
- To enhance the granularity of access permissions, contact the OCI administrator to establish other groups and roles within the OCI tenant. OCI provides more control over who can create and manage Container Databases (CDBs) and Pluggable Databases (PDBs) on the Oracle Database@Azure instances.

## See also

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
