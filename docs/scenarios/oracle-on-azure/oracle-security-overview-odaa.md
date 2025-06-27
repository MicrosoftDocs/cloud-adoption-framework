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

- An Oracle Database@Azure client subnet doesn't support network security groups (NSGs).

- The Oracle Exadata Database@Azure solution uses a predefined list of [Transmission Control Protocol (TCP) ports](https://docs.public.content.oci.oraclecloud.com/en-us/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7). By default, these ports are inaccessible from other subnets because the NSGs within OCI manage them. 

- By default, Oracle Exadata Database@Azure enables data-at-rest encryption. It applies encryption at the database layer via the transparent data encryption feature. This encryption helps secure the container (CDB$ROOT) and pluggable databases.

- By default, the database is encrypted via Oracle-managed encryption keys. The keys use AES-128 encryption and are stored locally in a wallet within the file system of the VM cluster. For more information, see [Manage tablespace encryption](https://docs.oracle.com/iaas/exadatacloud/doc/exa-conf-db-features.html#GUID-A7949087-DF56-4EF0-A32B-9465BBC7EE0F).

- Store customer-managed encryption keys in [OCI Vault](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) or [Oracle Key Vault](https://www.oracle.com/security/database-security/key-vault/). Oracle Exadata Database@Azure doesn't support Azure Key Vault. 
- By default, database backups are encrypted with the same primary encryption keys. Use these keys during restore operations. 

- Install non-Microsoft and Oracle agents on Oracle Exadata Database@Azure. Ensure that they don't modify or compromise the database operating system kernel. 

## Design recommendations

Consider the following security recommendations when you design your Oracle Exadata Database@Azure deployment:

- Separate infrastructure access and data services access, especially when different teams access multiple databases on the same infrastructure for various reasons. To achieve network and management isolation at the workload level, deploy VM clusters in a different virtual network.
- Use NSG rules to limit the source IP address range, which helps secure the data plane and virtual network access. To prevent unauthorized access, only open the ports that you require for secure communication, and apply the [principle of least privilege](/entra/identity-platform/secure-least-privileged-access).
- Configure network address translation (NAT) or use a proxy like Azure Firewall or a non-Microsoft network virtual appliance if you require outbound internet access. 
- Consider the following key management recommendations:
    - Oracle Exadata Database@Azure has built-in integration with OCI Vault. If you store primary encryption keys in OCI Vault, the keys are also stored in OCI, outside of Azure.  
    - If you need to keep all data and services within Azure, use Oracle Key Vault. 
    
        Oracle Key Vault doesn't have built-in integration with Oracle Exadata Database@Azure. [Oracle Key Vault on Azure](https://docs.oracle.com/en/solutions/deploy-key-vault-database-at-azure/index.html) isn't offered as a managed service. You must install the solution, integrate databases on Oracle Exadata Database@Azure, and ensure that the solution remains highly available. For more information, see [Create an Oracle Key Vault image in Microsoft Azure](https://docs.oracle.com/en/database/oracle/key-vault/21.9/okvag/using_okv_as_oci_vm_compute_instance.html#GUID-E8154AEB-2964-4698-AE6E-64A108C06D11).  
    
      To ensure encryption key availability, create a multi-primary Oracle Key Vault deployment. For robust high availability, deploy a multi-primary Oracle Key Vault cluster that has four nodes that span at least two availability zones or regions. For more information, see [Oracle Key Vault multi-primary cluster concepts](https://docs.oracle.com/en/database/oracle/key-vault/21.9/okvag/multimaster_concepts.html#GUID-E1A92D83-760F-470F-877F-D769169C6ABC).  
    - Use Oracle Key Vault if you need a hybrid architecture that spans on-premises environments or other cloud platforms. These environments support this solution.  
         > [!NOTE]
        > Oracle Key Vault requires separate licensing.   
    - Start with a wallet that's stored locally in the software keystore if you need to finalize your key management platform or are conducting a proof of concept or pilot. 
   
         The process of transitioning to a keystore depends on your key management platform. If you choose OCI Vault, the transition is a dynamic operation. If you choose Oracle Key Vault, you need to manually migrate your encryption keys to the Oracle Key Vault platform.

- Establish a rigorous key rotation process to uphold security and compliance standards if you use your own encryption keys.
- Store encryption keys and database backups in separate environments to enhance security and minimize the risk of data compromise. 
- Retain old encryption keys for restoration operations when you perform long-term backups.

- Install non-Microsoft or Oracle agents on Oracle Exadata Database@Azure in locations where database or grid infrastructure patches don't interfere with them. 

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Business continuity and disaster recovery for Oracle Database@Azure](oracle-disaster-recovery-oracle-database-azure.md)
