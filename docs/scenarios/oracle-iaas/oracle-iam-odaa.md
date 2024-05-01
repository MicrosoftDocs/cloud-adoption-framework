---
title: Identity and access management for Oracle Database@Azure
description: Design your identity and access management approach for Oracle Database@Azure.
author: sihbher
ms.author: gereyeso
ms.reviewer: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---
# Identity and access management for Oracle Database@Azure

This article builds on the considerations and recommendations that are defined in the [Azure landing zone design areas](/azure/cloud-adoption-framework/ready/landing-zone/). It provides key design considerations and recommendations for Oracle Database@Azure identity and access management.

## Design considerations

Consider the following identity and access management recommendations for Oracle Database@Azure:

- Accept and enable the Oracle Database@Azure private offer on Azure Marketplace for your subscription. You need contributor access to the subscription to deploy the Oracle Database@Azure service. For more information, see [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database). If you aligned your operational model with Azure landing zone principles, the individual application development team that requires Oracle Database@Azure services manages the process. There might be parts of the process that a centralized platform team needs to handle if you run a more traditional model.

- Oracle Database@Azure doesn't natively support Microsoft Entra ID for identity and access management. However, you can configure federation between Microsoft Entra ID and Oracle Cloud Infrastructure (OCI) to enable users to sign in to OCI by using their Microsoft Entra ID credentials. Users can sign in with OCI credentials only, but we don't recommend that setup. When you sign in with OCI credentials only, you have more user identities to manage. To enable federation, follow the instructions in [Onboard with Oracle Database@Azure](/azure/oracle/oracle-db/onboard-oracle-database#step-3-optional-create-identity-federation-using-azures-identity-service).

- Deploy the initial Oracle Database@Azure instance to create specific groups within Microsoft Entra ID and in the corresponding OCI tenant. For more information, see [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles). The groups created in the OCI tenant have the necessary permissions to create and manage container databases (CDBs) and pluggable databases (PDBs) on all the Oracle Database@Azure instances in that OCI tenant.

- When you provision a new account and tenant, an Admin user is created in OCI. Avoid using this Admin identity for day-to-day operations. Instead use the Microsoft Entra administrator groups to provide elevated access for the relevant individuals.

- Contact the OCI administrator to establish other groups and roles within the OCI tenant to enhance the granularity of access permissions. OCI provides more control over who can create and manage CDBs and PDBs on Oracle Database@Azure instances.

## Next steps

- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
