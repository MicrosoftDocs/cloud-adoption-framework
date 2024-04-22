---
title: Security guidelines for Oracle Database@Azure
description: Learn about security guidelines for Oracle Database@Azure
author: basimolimajeed
ms.author: bamajeed
ms.reviewer: janfaurs
ms.date: 04/03/2024
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
---

# Security guidelines for Oracle Database@Azure

This article builds on several considerations and recommendations defined in [Security design in Azure](../../ready/landing-zone/design-area/security.md). It offers key design considerations and recommendation for Oracle Database@Azure security measures.

## Overview

Most databases contain sensitive data, requiring a secure architecture beyond just database-level protections. The defense in depth strategy provides comprehensive security by layering multiple defense mechanisms. This approach avoids relying solely on one type of security, such as network defenses. Instead, it combines various measures like strong authentication, authorization frameworks, hardened network security, and encryption of data both at rest and in transit. This multilayered strategy is essential for securing Oracle workloads effectively.

To learn more about Oracle Exadata security refer to [Overview of Oracle Exadata Security](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-overview.html#GUID-4D178313-47E7-451B-8AF8-1FEAC2CD38B2) and [Security Features of Oracle Exadata Database Machine](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-features.html#GUID-31C2978A-238C-4F30-82C7-17B355727810).

## Design Considerations

- Oracle Database@Azure are resources deployed in Azure VNETs and datacenters. They are managed in part from the Azure control plane and in part from the Oracle Cloud Infrastructure (OCI) control plane. The initiation of the infrastructure and network connectivity is managed in Azure. Database management and individual node management is handled via the Oracle control plane. For more information, see [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles).
- The Oracle Database@Azure service is deployed in private subnets in Azure only. The service is not immediately accessible from the Internet.
- Network security groups are not currently supported on the Azure subnets where Oracle Database@Azure service is deployed.
- The Oracle Database@Azure solution uses a number of default TCP ports for various operations. For the full list of ports, see [Understanding the Network Requirements for Oracle Exadata](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmin/exadata-network-requirements.html#GUID-A454DAB3-7606-4288-9139-0C02A7669BE3).
- The Oracle Database@Azure solution uses [Oracle Cloud Infrastructure Vault (OCI Vault)](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) to store and manage keys for Transparent Data Encryption (TDE). Integration with Azure Key Vault is not possible at this time.
- For vulnerability scanning on individual nodes in the Oracle Database@Azure solution, you can use the Oracle Cloud Infrastructure Vulnerability Scanning Service. For more information, see [Oracle Cloud Infrastructure Vulnerability Scanning Service](https://docs.oracle.com/en-us/iaas/scanning/using/overview.htm). Integration with Microsoft Defender is not possible at this time.

## Design Recommendations

- Consider separating infrastructure access from data services access, especially when different teams access multiple databases on the same infrastructure for various purposes.
- Secure the data-plane and virtual network access by limiting the source-IP range on the individual Oracle Database@Azure host firewall software ([SELinux](https://docs.oracle.com/en/learn/ol-selinux/#introduction) for database servers and [cellwall](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-features.html#GUID-9858E126-0D9F-4F99-BE68-391E77916EC6) for storage servers). Open only the ports needed for secure communication, preventing access to and from the internet. Configure network address translation (NAT) if internet access is required. Always require data in transit to be encrypted.
- Use OCI Vault to store and manage encryption keys. If you decide to bring your own keys, set up a strict process for key rotation.
- Use the Oracle vulnerability scanning capabilities to detect security issues such as open ports, needed patches, and OS configurations that hackers might exploit and other vulnerabilities.

## Additional resources

- [Identity and Access Management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)