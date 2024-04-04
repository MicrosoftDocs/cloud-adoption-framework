---
title: Identity and Access Management for Oracle Database@Azure
description: Identity and Access Management for Oracle Database@Azure
author: sihbher
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
---
# Identity and Access Management for Oracle Database@Azure

This article builds on some of the considerations and recommendations that are defined in the [Azure landing zone design](/azure/cloud-adoption-framework/ready/landing-zone/). It offers key design considerations and recommendation for Oracle Database@Azure identity and access management.

## Design Considerations

- Once the Oracle Database@Azure private offer on the Azure Marketplace has been accepted and enabled for your subscription, (please see details on how to do this in [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database)), you will need contributor access to the subscription to deploy the Oracle Database@Azure service.
- Oracle Database@Azure does not natively support Microsoft Entra ID for identity and access management. However, you can configure federation between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI) to enable users to log in to OCI using their Microsoft Entra ID credentials.
- The process of deploying the initial Oracle Database@Azure will create specific groups within Microsoft Entra ID, as well as in the corresponding OCI tenant. For more details on the specific groups and roles created please refer to [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles). The groups created in the OCI tenant specifically has the necessary permissions to create and manage Container Databases (CDB) and Pluggable Databases (PDB) on all the Oracle Database@Azure instances in that OCI tenant.

## Design Recommendations

- Configure federated access between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI) to enable users to log in to OCI using their Microsoft Entra ID credentials. While it is possible to have users log in with OCI credentials only, this is not recommended as it will require additional management of user identities. How to do this is described in [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database#step-3-optional-create-identity-federation-using-azures-identity-service).
- An Admin user is created in OCI when a new account and tenancy is provisioned, avoid using this identity for day-to-day operations and instead leverage the Microsoft Entra Id administrator groups instead to provide the relevant individuals elevated access.
- For granularity in access permissions reach out to the OCI administrator to create additional groups and roles in the OCI tenant. This will allow for more granular control over who can create and manage CDBs and PDBs on the Oracle Database@Azure instances.

## See also

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
