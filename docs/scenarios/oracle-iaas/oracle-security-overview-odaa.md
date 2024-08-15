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

- Network security groups (NSGs) aren't currently supported on Azure subnets where Oracle Database@Azure service is deployed.

- The Oracle Database@Azure solution uses many default Transmission Control Protocol (TCP) ports for various operations. For the full list of ports, see [Default port assignments](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmin/exadata-network-requirements.html#GUID-A454DAB3-7606-4288-9139-0C02A7669BE3).

- To store and manage keys Transparent Data Encryption (TDE), which is enabled by default, the Oracle Database@Azure solution can use [OCI Vault](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm), or [OKV](https://www.oracle.com/security/database-security/key-vault/). Integration with Azure Key Vault isn't possible at this time.

- You can use [OCI Vulnerability Scanning Service](https://docs.oracle.com/iaas/scanning/using/overview.htm) for vulnerability scanning on individual nodes in the Oracle Database@Azure solution. Integration with Microsoft Defender isn't possible at this time.

- Third-party and Oracle agents are permitted on the ExaCS OS, provided they do not alter or taint the OS kernel. Ensure these agents are installed in locations that will not be impacted by database (DB) or Grid Infrastructure patches.

## Design recommendations

Consider the following recommendations when you design your security for Oracle Database@Azure:

- Segment infrastructure access from data services access, especially when different teams access multiple databases on the same infrastructure for various reasons.

- Secure the data plane and virtual network access by limiting the source-IP address range on the individual Oracle Database@Azure host firewall software, which is [SELinux](https://docs.oracle.com/en/learn/ol-selinux/#introduction) for database servers and [cellwall](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-features.html#GUID-9858E126-0D9F-4F99-BE68-391E77916EC6) for storage servers. Open only the ports that are required for secure communication to prevent access to and from the internet.

- Configure network address translation (NAT) if you require internet access. Always require encryption for data in transit.

- Use OCI Vault to store and manage encryption keys. If you bring your own keys, set up a strict process for key rotation.

- Use the Oracle vulnerability scanning capabilities to detect security vulnerabilities that hackers might exploit, such as open ports, necessary patches, and operating system configurations.

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
