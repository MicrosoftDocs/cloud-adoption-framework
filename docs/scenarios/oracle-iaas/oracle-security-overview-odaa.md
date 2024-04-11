---
title: Security guidelines for Oracle Database@Azure
description: Learn about security guidelines for Oracle Database@Azure
author: basimolimajeed
ms.author: bamajeed
ms.reviewer: janfaurs
ms.date: 
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
---

# Security guidelines for Oracle Database@Azure

This article builds on several considerations and recommendations defined in [Security design in Azure](../../ready/landing-zone/design-area/security.md). It offers key design considerations and recommendation for Oracle Database@Azure security measures.

## Overview

Most databases store sensitive data. To have a secure architecture in which to land these workloads, implementing security only at the database level isn't sufficient. Defense in depth is a comprehensive approach to security that involves implementing multiple layers of defense mechanisms to protect data. Instead of relying on a single security measure at a specific level, such as, for example, focusing on network security mechanisms, the defense in depth strategy employs a combination of different layer security measures to create a robust security posture. Defense-in-depth approach can be architected for Oracle workloads through strong authentication and authorization framework, hardened network security and encryption of data at rest and in-transit.

To learn more about Oracle Exadata security refer to [Overview of Oracle Exadata Security](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-overview.html#GUID-4D178313-47E7-451B-8AF8-1FEAC2CD38B2) and [Security Features of Oracle Exadata Database Machine](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-features.html#GUID-31C2978A-238C-4F30-82C7-17B355727810).

## Design Considerations

- Oracle Database@Azure are resources deployed in Azure VNETs and datacenters, which are managed in part from the Azure control plane and in part from the Oracle Cloud Infrastructure (OCI) control plane. The initiation of the infrastructure and network connectivity is managed in Azure, while database managment and individual node management is handled via the Oracle control plane. For more details on roles and responsibilities refer to the [Groups and roles for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-groups-roles).
- The Oracle Database@Azure service is deployed in private subnets in Azure only. The service is not immediately accessible from the Internet. The solution consists of multiple database servers and storage servers, running Oracle Linux.
- Network Security Groups are not currently supported on the delegated Azure subnet.
- The Oracle Database@Azure solution leverages different default ports for various operations, for the full list and explanation please review the [Understanding the Network Requirements for Oracle Exadata](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmin/exadata-network-requirements.html#GUID-A454DAB3-7606-4288-9139-0C02A7669BE3).
- The Oracle Database@Azure solution leverages [Oracle Cloud Infrastructure Vault (OCI Vault)](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) to store and manage keys for Transparent Data Encryption (TDE). Integration with Azure Key Vault is not possible at this time.
- For vulnerability scanning on individual nodes in the Oracle Database@Azure solution, Oracle Cloud Infrastructure Vulnerability Scanning Service can be used. For more information refer to the [Oracle Cloud Infrastructure Vulnerability Scanning Service](https://docs.oracle.com/en-us/iaas/scanning/using/overview.htm). Integration with Microsoft Defender is not possible at this time.

## Design Recommendations

- Depending on your administrative model for the Oracle Database@Azure solution consider splitting up access to the infrastructure versus access to data services. This is particularly true if you are running multiple databases on the same infrastructure, with different teams accessing the databases for different purposes.
- Secure the data-plane and vNet access by limiting the source IP range, on the indidividual Oracle Database@Azure host firewall software ([SELinux](https://docs.oracle.com/en/learn/ol-selinux/#introduction) for database servers and [cellwall](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-features.html#GUID-9858E126-0D9F-4F99-BE68-391E77916EC6) for storage servers), allowing only ports needed for secure communication, preventing access from/to the internet (use NAT in case it is required), and always require data in transit to be encrypted (SSL).
- Use OCI Vault to store and manage encryption keys. If you decide to bring your own keys then set up a strict process for key rotation.
- Use the Vulnerability Scanning capabilities provided by Oracle to detect security issues such as ports that are unintentionally left open, OS packages that require updates and patches to address vulnerabilities and OS configurations that hackers might exploit and other vulnerabilities.

## See also

- [Identity and Access Management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)