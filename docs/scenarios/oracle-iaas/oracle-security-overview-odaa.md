---
title: Security guidelines for Oracle Database@Azure
description: Learn about key design considerations and recommendation for Oracle Database@Azure security measures.
author: basimolimajeed
ms.author: bamajeed
ms.reviewer: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Security guidelines for Oracle Database@Azure

This article builds on several considerations and recommendations that are defined in the [Azure security design area](../../ready/landing-zone/design-area/security.md). It provides key design considerations and recommendation for Oracle Database@Azure security measures.

## Overview

Most databases contain sensitive data that requires a secure architecture beyond database-level protections. The defense-in-depth strategy provides comprehensive security by layering multiple defense mechanisms. This approach combines various measures to avoid relying solely on one type of security, such as network defenses. These measures include strong authentication and authorization frameworks, network security, encryption of data at rest, and encryption of data in transit. This multilayered strategy is essential for securing Oracle workloads effectively.

For more information, see [Security Guide for Oracle Exadata Database Service on Dedicated Infrastructure](https://docs.oracle.com/en/engineered-systems/exadata-cloud-service/ecscm/ecs-security-guide.html#GUID-EBDA0EB5-734A-4AD2-A740-8C174B1FFE3B) and [Exadata Security Controls](https://www.oracle.com/a/ocom/docs/engineered-systems/exadata/exadata-cloud-service-security.pdf). 

## Design considerations

Consider the following guidance when you design your security guidelines for Oracle Database@Azure:
 
- Oracle Database@Azure workloads contain resources that are deployed in Azure virtual networks and datacenters. The Azure control plane and the Oracle Cloud Infrastructure (OCI) control plane both manage these resources. The Azure control plane manages the initiation of the infrastructure and network connectivity. The Oracle control plane handles database management and individual node management. For more information, see [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles).
 
- The Oracle Database@Azure service is deployed on private subnets in Azure only. The service isn't immediately accessible from the internet.
 
- Network security groups (NSGs) aren't currently supported Oracle Database@Azure delegated subnets.
 
- The Oracle Database@Azure solution uses many default Transmission Control Protocol (TCP) ports for various operations. For the full list of ports, see [Default port assignments](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmin/exadata-network-requirements.html#GUID-A454DAB3-7606-4288-9139-0C02A7669BE3).
 
- To store and manage keys Transparent Data Encryption (TDE), which is enabled by default, the Oracle Database@Azure solution can use [OCI Vault](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm), or [OKV](https://www.oracle.com/security/database-security/key-vault/). Integration with Azure Key Vault isn't possible at this time.
 
- By default, the database is configured using Oracle-managed encryption keys. Customer managed keys (CMK) are also supported. 

- [Oracle Data Safe](https://docs.oracle.com/en/cloud/paas/data-safe/admds/register-oracle-cloud-database.html#GUID-F75522C5-5D6C-499C-875C-228ADE00472A) can be used with Oracle Database@Azure to enhance data protection.
 
- Third-party and Oracle agents are permitted on the Oracle Database@Azure OS, provided they do not alter or taint the OS kernel.
 
## Design recommendations
 
Consider the following recommendations when you design your security for Oracle Database@Azure:
 
- Segment infrastructure access from data services access, especially when different teams access multiple databases on the same infrastructure for various reasons.
 
- Secure the data plane and virtual network access by limiting the source IP address range using network security group (NSG) rules. Open only the necessary ports required for secure communication to prevent unauthorized access to and from the internet. NSG rules can be configured on OCI.
 
- Configure network address translation (NAT) if you require internet access. Always require encryption for data in transit.
 
- If you use your own encryption keys, establish a rigorous key rotation process to uphold security and compliance standards.
 
- If using third-party or Oracle agents on Oracle Database@Azure, ensure these agents are installed in locations that will not be impacted by database or Grid Infrastructure patches.

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Business continuity and disaster recovery (BCDR) for Oracle Database@Azure](oracle-disaster-recovery-odaa.md)
