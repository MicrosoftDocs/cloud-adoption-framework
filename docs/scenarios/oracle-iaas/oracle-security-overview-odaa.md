---
title: Security guidelines for Oracle Database@Azure
description: Learn about key design considerations and recommendation for Oracle Database@Azure security measures.
author: basimolimajeed
ms.author: bamajeed
ms.reviewer: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Security guidelines for Oracle Database@Azure

This article builds on several considerations and recommendations that are defined in the [Azure security design area](../../ready/landing-zone/design-area/security.md). It provides key design considerations and recommendation for  Exadata Database Service on Oracle Database@Azure.

## Overview

Most databases contain sensitive data that requires a secure architecture beyond database-level protections. The defense-in-depth strategy provides comprehensive security by layering multiple defense mechanisms. This approach combines various measures to avoid relying solely on one type of security, such as network defenses. These measures include strong authentication and authorization frameworks, network security, encryption of data at rest, and encryption of data in transit. This multilayered strategy is essential for securing Oracle workloads effectively.

For more information, see [Security guide for Oracle Exadata Database Service on dedicated infrastructure](https://docs.oracle.com/en/engineered-systems/exadata-cloud-service/ecscm/ecs-security-guide.html#GUID-EBDA0EB5-734A-4AD2-A740-8C174B1FFE3B) and [Exadata security controls](https://www.oracle.com/a/ocom/docs/engineered-systems/exadata/exadata-cloud-service-security.pdf).

## Design considerations

Consider the following guidance when you design your security guidelines for Oracle Exadata Database@Azure:

- Oracle Database@Azure is an Oracle database service running on Oracle Cloud Infrastructure (OCI), colocated in Microsoft data centers.  
Managing Oracle Exadata Database@Azure resources involves the integration of two cloud platforms, with each governed by the security principles of Azure and Oracle Cloud Infrastructure(OCI). The Azure control plane manages the provisioning of the infrastructure, Virtual Machine(VM) Cluster, and network connectivity. The OCI console handles database management and individual node management. 

- The Oracle Database@Azure service is integrated into Azure virtual networks through subnet delegation.

    **Note** that Oracle Exadata Database@Azure does not have inbound or outbound Internet access by default.

- Oracle Database@Azure client subnet currently doesn't support network security groups (NSGs).

- The Oracle Exadata Database@Azure solution uses a predefined list of TCP ports which are defined [here](https://docs.public.content.oci.oraclecloud.com/en-us/iaas/exadatacloud/doc/ecs-security-guide.html#ECSCM-GUID-93DD9F98-AC6F-4538-AE78-13399C1C02A7). The ports are inaccessible from the other subnets by default (which are currently handled by the NSGs within OCI). 

- The Oracle Exadata Database@Azure service enables data-at-rest encryption by default. This encryption is applied at the database layer, securing both the container (CDB$ROOT) and pluggable databases (PDBs), and is implemented using the Transparent Data Encryption (TDE) feature.  

- By default, the database is encrypted by using Oracle-managed encryption keys, which utilize AES-128 encryption and are stored locally in a wallet within the file system of the VM cluster. For detailed information, refer to [here](https://docs.oracle.com/en-us/iaas/exadatacloud/doc/exa-conf-db-features.html#GUID-A7949087-DF56-4EF0-A32B-9465BBC7EE0F).

- Customer-managed encryption keys can be stored either in [OCI Vault](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) or [Oracle Key Vault](https://www.oracle.com/security/database-security/key-vault/). 

    Oracle Exadata Database@Azure  currently doesn't support Azure Key Vault. 
- By default, database backups are encrypted with the same master encryption keys. These keys must be used during the restore operation. 

- Non-Microsoft and Oracle agents can be installed on the Oracle Exadata Database@Azure if they don't modify or compromise the database operating system kernel. 

## Design recommendations

Consider the following security recommendations when designing your Oracle Exadata Database@Azure deployment:

- Segment infrastructure access from data services access, especially when different teams access multiple databases on the same infrastructure for various reasons. Deploy VM clusters in a different virtual network for achieving network and management isolation at the workload level.
- Use NSG rules to limit the source IP address range, which secures the data plane and virtual network access. To prevent unauthorized access, only open the necessary ports that you require for secure communication and apply [Principle of least privilege](/entra/identity-platform/secure-least-privileged-access). You can configure NSG rules on OCI.
- Configure network address translation (NAT) or use Azure Firewall or third party Network Virtaul Appliances as a proxy if you require outbound internet access. 
- Key Management recommendations:
    - Oracle Exadata Database@Azure has a built-in integration OCI Vault.  
    If you choose to store the master encryption keys in OCI Vault, keep in mind that the keys will be stored in OCI, outside of Azure.  
    - If there's a requirement to keep all data and services within Azure, use Oracle Key Vault (OKV). 
    
        OKV doesn’t have built-in integration with the Oracle Exadata Database@Azure solution. [Deploying OKV on Azure](https://docs.oracle.com/en/solutions/deploy-key-vault-database-at-azure/index.html) isn't offered as a managed service. Customers are responsible for installation, database integration on Oracle Exadata Database@Azure and ensuring high availability of the solution. For provisioning details, refer to [Creating Oracle Key Vault Image in Microsoft Azure](https://docs.oracle.com/en/database/oracle/key-vault/21.9/okvag/using_okv_as_oci_vm_compute_instance.html#GUID-E8154AEB-2964-4698-AE6E-64A108C06D11).  
    To ensure encryption key availability, create a multi-master OKV deployment. For robust high availability, it's recommended to deploy a multi-master OKV cluster with four nodes spanning at least two availability zones or regions. For multi-master architecture details, refer to [Oracle Key Vault Multi-Master Cluster Concepts](https://docs.oracle.com/en/database/oracle/key-vault/21.9/okvag/multimaster_concepts.html#GUID-E1A92D83-760F-470F-877F-D769169C6ABC).  
    - If you're targeting a hybrid architecture that spans on-premises or other cloud platforms, use Oracle Key Vault as the solution is supported across these environments.  
    **Note** that OKV requires separate licensing.  
    -    If you haven't yet finalized your key management platform or are conducting a PoC or pilot, it's recommended to start with a wallet stored locally in the software keystore. 
   
         The process of transitioning to a keystore depends on the key management platform you choose. 
        If you choose OCI Vault, the transition is a dynamic operation. However, if you select Oracle Key Vault (OKV), you'll need to manually migrate your encryption keys to the OKV platform.

- If you use your own encryption keys, establish a rigorous key rotation process to uphold security and compliance standards.
- Store encryption keys and database backups in separate environments to enhance security and minimize the risk of data compromise. 
- For long-term backups, it's important to retain old encryption keys as these are required for restoration operations. 

- If you use non-Microsoft or Oracle agents on Oracle Exadata Database@Azure,  make sure to install these agents in locations where database or grid infrastructure patches won’t interfere with them. 

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Business continuity and disaster recovery (BCDR) for Oracle Database@Azure](oracle-disaster-recovery-odaa.md)
