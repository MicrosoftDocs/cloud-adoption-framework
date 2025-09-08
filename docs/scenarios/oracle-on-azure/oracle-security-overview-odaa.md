---
title: Security Guidelines for Oracle Database@Azure
description: Learn about best practices for applying multiple defense mechanisms to ensure comprehensive security for Oracle Database@Azure workloads.
author: basimolimajeed
ms.author: bamajeed
ms.reviewer: janfaurs
ms.date: 02/10/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Security guidelines for Oracle Database@Azure

This article builds on considerations and recommendations in the [Azure security design area](../../ready/landing-zone/design-area/security.md). It provides key design considerations and recommendation for Oracle Exadata Database@Azure.

## Overview

Most databases contain sensitive data that requires a highly secure architecture beyond database-level protections. A defense-in-depth strategy consists of multiple defense mechanisms to help ensure comprehensive security. This approach prevents the reliance on a single type of security, such as network defenses. Defense mechanisms include strong authentication and authorization frameworks, network security, encryption of data at rest, and encryption of data in transit. You can use this multilayered strategy to help secure Oracle workloads effectively.

For more information, see [Security guide for Oracle Exadata Database@Azure on dedicated infrastructure](https://docs.oracle.com/en/engineered-systems/exadata-cloud-service/ecscm/ecs-security-guide.html#GUID-EBDA0EB5-734A-4AD2-A740-8C174B1FFE3B) and [Exadata security controls](https://www.oracle.com/a/ocom/docs/engineered-systems/exadata/exadata-cloud-service-security.pdf).

## Design considerations

Consider the following guidance when you design security measures for Oracle Exadata Database@Azure:

- Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI), which is colocated in Microsoft datacenters. 

  To manage Oracle Exadata Database@Azure resources, you need to integrate the Azure and OCI cloud platforms. Govern each platform with their respective security best practices. The Azure control plane manages the provisioning of the infrastructure, including the virtual machine (VM) cluster and network connectivity. The OCI console handles database management and individual node management.

- Oracle Database@Azure is integrated into Azure virtual networks through subnet delegation.

    > [!NOTE]
    > Oracle Exadata Database@Azure doesn't have inbound or outbound internet access by default.

- The Oracle Exadata Database@Azure solution uses a predefined list of [Transmission Control Protocol (TCP) ports](https://docs.public.content.oci.oraclecloud.com/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7). By default, these ports are inaccessible from other subnets because the NSGs within OCI manage them. 

- By default, Oracle Exadata Database@Azure enables data-at-rest encryption. It applies encryption at the database layer via the transparent data encryption feature. This encryption helps secure the container (CDB$ROOT) and pluggable databases.

- By default, the database is encrypted via Oracle-managed encryption keys. The keys use AES-128 encryption and are stored locally in a wallet within the file system of the VM cluster. For more information, see [Manage tablespace encryption](https://docs.oracle.com/iaas/exadatacloud/doc/exa-conf-db-features.html#GUID-A7949087-DF56-4EF0-A32B-9465BBC7EE0F).

- By default, database backups are encrypted with the same primary encryption keys. Use these keys during restore operations. 

- Install non-Microsoft and Oracle agents on Oracle Exadata Database@Azure. Ensure that they don't modify or compromise the database operating system kernel. 

## Design recommendations

Consider the following security recommendations when you design your Oracle Exadata Database@Azure deployment:

- Separate infrastructure access and data services access, especially when different teams access multiple databases on the same infrastructure for various reasons. To achieve network and management isolation at the workload level, deploy VM clusters in a different virtual network.

- Use [Advanced Networking](https://learn.microsoft.com/azure/oracle/oracle-db/oracle-database-network-plan#constraints) Network Security Group (NSG) rules to limit the source IP address range, which helps secure the data plane and virtual network access. To prevent unauthorized access, only open the ports that you require for secure communication, and apply the [principle of least privilege](/entra/identity-platform/secure-least-privileged-access).

- Configure network address translation (NAT) or use a proxy like Azure Firewall or a non-Microsoft network virtual appliance if you require outbound internet access. 

- Install non-Microsoft or Oracle agents on Oracle Exadata Database@Azure in locations where database or grid infrastructure patches don't interfere with them. 

- Store Oracle Transparent Data Encryption (TDE) master encryption keys (MEKs) in [Azure Key Vault](https://learn.microsoft.com/azure/oracle/oracle-db/manage-oracle-transparent-data-encryption-azure-key-vault).  Follow [best practices](https://microsoft-my.sharepoint.com/:w:/p/temandin/EQY8I1PYJxpMmMjEswWaL30BoPCoYIXSdzInoAxIF28vjA?CID=bf837309-fe35-eab4-1bfc-cfb8101bdadf&e=flgQCr&wdLOR=c9847C52B-9E51-4263-A301-BE1932B0E9D0) for using Azure Key Vault. 

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Business continuity and disaster recovery for Oracle Database@Azure](oracle-disaster-recovery-oracle-database-azure.md)
