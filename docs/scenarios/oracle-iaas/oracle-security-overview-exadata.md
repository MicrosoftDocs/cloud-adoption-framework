---
title: Security Guidelines for Oracle Exadata Database@Azure
description: Learn about key design considerations and recommendations for Oracle Database@Azure security measures.
author: basimolimajeed
ms.author: bamajeed
ms.reviewer: janfaurs
ms.date: 02/10/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Security guidelines for Oracle Exadata Database@Azure

This article builds on considerations and recommendations in the [Azure security design area](../../ready/landing-zone/design-area/security.md). It provides specific key design considerations and recommendation for Oracle Exadata Database@Azure.

## Overview

Most databases contain sensitive data that requires a secure architecture beyond database-level protections. The defense-in-depth strategy consists of multiple defense mechanisms, which provides comprehensive security. This approach combines various measures so that you don't rely on only one type of security, such as network defenses. These measures include strong authentication and authorization frameworks, network security, encryption of data at rest, and encryption of data in transit. Use this multilayered strategy to help secure Oracle workloads effectively.

For more information, see [Security guide for Oracle Exadata Database@Azure on dedicated infrastructure](https://docs.oracle.com/en/engineered-systems/exadata-cloud-service/ecscm/ecs-security-guide.html#GUID-EBDA0EB5-734A-4AD2-A740-8C174B1FFE3B) and [Exadata security controls](https://www.oracle.com/a/ocom/docs/engineered-systems/exadata/exadata-cloud-service-security.pdf).

## Design considerations

Consider the following guidance when you design your security guidelines for Oracle Exadata Database@Azure:

- Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI), colocated in Microsoft datacenters.  
Managing Oracle Exadata Database@Azure resources involves the integration of the Azure and OCI cloud platforms, each governed by their respective security best practices. The Azure control plane manages the provisioning of the infrastructure, including virtual machine (VM) cluster, and network connectivity. The OCI console handles database management and individual node management. 

- The Oracle Database@Azure service is integrated into Azure virtual networks through subnet delegation.

    > [!NOTE]
    > Oracle Exadata Database@Azure doesn't have inbound or outbound internet access by default.

- Oracle Database@Azure client subnet currently doesn't support network security groups (NSGs).

- The Oracle Exadata Database@Azure solution uses a predefined list of [TCP ports](https://docs.public.content.oci.oraclecloud.com/en-us/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7). The ports are inaccessible from the other subnets by default, which are currently handled by the NSGs within OCI. 

- Oracle Exadata Database@Azure enables data-at-rest encryption by default. This encryption is applied at the database layer, which secures the container (CDB$ROOT) and pluggable databases (PDBs). The encrytion is implemented via the transparent data encryption feature.  

- By default, the database is encrypted via Oracle-managed encryption keys, which use AES-128 encryption and are stored locally in a wallet within the file system of the VM cluster. For detailed information, see [Manage tablespace encryption](https://docs.oracle.com/iaas/exadatacloud/doc/exa-conf-db-features.html#GUID-A7949087-DF56-4EF0-A32B-9465BBC7EE0F).

- Store customer-managed encryption keys either in [OCI Vault](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) or [Oracle Key Vault](https://www.oracle.com/security/database-security/key-vault/). Oracle Exadata Database@Azure doesn't support Azure Key Vault. 
- By default, database backups are encrypted with the same primary encryption keys. Use these keys during restore operations. 

- Install non-Microsoft and Oracle agents on Oracle Exadata Database@Azure if they don't modify or compromise the database operating system kernel. 

## Design recommendations

Consider the following security recommendations when you design your Oracle Exadata Database@Azure deployment:

- Segment infrastructure access from data services access, especially when different teams access multiple databases on the same infrastructure for various reasons. Deploy VM clusters in a different virtual network to achieve network and management isolation at the workload level.
- Use NSG rules to limit the source IP address range, which helps secure the data plane and virtual network access. To prevent unauthorized access, only open the necessary ports that you require for secure communication and apply the [principle of least privilege](/entra/identity-platform/secure-least-privileged-access). You can configure NSG rules on OCI.
- If you require outbound internet access, consider configuring network address translation (NAT) or use a proxy like Azure Firewall or a non-Microsoft network virtaul appliance. 
- Key management recommendations:
    - Oracle Exadata Database@Azure has built-in integration with OCI Vault. If you store primary encryption keys in OCI Vault, the keys are also stored in OCI, outside of Azure.  
    - If you need to keep all data and services within Azure, use Oracle Key Vault. 
    
        Oracle Key Vault doesn't have built-in integration with Oracle Exadata Database@Azure. [Oracle Key Vault on Azure](https://docs.oracle.com/en/solutions/deploy-key-vault-database-at-azure/index.html) isn't offered as a managed service. Customers must install the solution, integrate databases on Oracle Exadata Database@Azure, and ensure that the solution remains highly available. For more information about provisioning, see [Create an Oracle Key Vault image in Microsoft Azure](https://docs.oracle.com/en/database/oracle/key-vault/21.9/okvag/using_okv_as_oci_vm_compute_instance.html#GUID-E8154AEB-2964-4698-AE6E-64A108C06D11).  
    To ensure encryption key availability, create a multi-primary Oracle Key Vault deployment. For robust high availability, deploy a multi-primary Oracle Key Vault cluster that has four nodes that span at least two availability zones or regions. For more information, see [Oracle Key Vault multi-primary cluster concepts](https://docs.oracle.com/en/database/oracle/key-vault/21.9/okvag/multimaster_concepts.html#GUID-E1A92D83-760F-470F-877F-D769169C6ABC).  
    - If you need a hybrid architecture that spans on-premises environments or other cloud platforms, use Oracle Key Vault because these environments support the solution.  
         > [!NOTE]
        > Oracle Key Vault requires separate licensing.   
    -    If you haven't finalized your key management platform or are conducting a PoC or pilot, start with a wallet that's stored locally in the software keystore. 
   
         The process of transitioning to a keystore depends on your key management platform. If you choose OCI Vault, the transition is a dynamic operation. But if you choose Oracle Key Vault, you need to manually migrate your encryption keys to the Oracle Key Vault platform.

- If you use your own encryption keys, establish a rigorous key rotation process to uphold security and compliance standards.
- Store encryption keys and database backups in separate environments to enhance security and minimize the risk of data compromise. 
- For long-term backups, retain old encryption keys for restoration operations. 

- If you use non-Microsoft or Oracle agents on Oracle Exadata Database@Azure, install these agents in locations where database or grid infrastructure patches don't interfere with them. 

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Exadata Database@Azure](core-network-design.md)
- [Business continuity and disaster recovery for Oracle Exadata Database@Azure](business-continuity-disaster-recovery-connectivity-design.md)
