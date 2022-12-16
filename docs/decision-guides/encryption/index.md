---
title: Encryption decision guide
description: Learn how to implement an encryption policy, a core service in Azure migrations, that provides extra layers of security for your cloud-based workloads and data.
author: martinekuan
ms.author: martinek
ms.date: 02/11/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: internal
---

# Encryption decision guide

Encrypting data protects it against unauthorized access. Properly implemented encryption policy provides extra layers of security for your cloud-based workloads. It also guards against attackers and other unauthorized users from both inside and outside your organization and networks.

Jump to: [Key management](#key-management) | [Data encryption](#data-encryption) | [Learn more](#learn-more)

Cloud encryption strategy focuses on corporate policy and compliance mandates. Encrypting resources is important. Many Azure services, such as Azure Storage and Azure SQL Database enable encryption by default. But encryption has costs that can increase latency and overall resource usage.

For demanding workloads, striking the correct balance between encryption and performance, and determining how to encrypt data and traffic is essential. Encryption mechanisms vary in cost and complexity. Both technical and policy requirements can influence your decisions on how to apply encryption and how you store and manage critical secrets and keys.

Corporate policy and third-party compliance are the biggest drivers when planning an encryption strategy. Azure provides multiple standard mechanisms that meet common requirements for encrypting data, whether at rest or in transit. You'll need to develop a more sophisticated encryption strategy to support policies and compliance requirements that demand tighter controls. For example:

* Standardized secrets and key management
* Encryption in-use
* Data-specific encryption

## Key management

Encrypting data in the cloud depends on the secure storage, management, and operational use of encryption keys. A key management system is critical to your organization's ability to create, store, and manage cryptographic keys. A key management system also encrypts important passwords, connection strings, and other IT confidential information.

Modern key management systems, such as Azure Key Vault, support storage and management of software protected keys. This support covers dev/test usage and hardware security module (HSM) protected keys. It offers maximum protection of production workloads or sensitive data.

When you plan a cloud migration, the following table helps you decide how to store and manage encryption keys, certificates, and secrets that are critical for creating secure and manageable cloud deployments:

| Question | Cloud-native | Bring your own key | Hold your own key |
|--- |--------------|--------|-------------|
| Does your organization lack centralized key and secret management?                                                                    | Yes          | No     | No          |
| Will you need to limit keys and secrets creation to devices on your on-premises hardware, while using these keys in the cloud? | No           | Yes    | No          |
| Does your organization have rules or policies in place that would prevent keys from being stored offsite?                | No           | No     | Yes         |

### Cloud-native

With cloud-native key management, all keys and secrets are generated, managed, and stored in a cloud-based vault, such as Azure Key Vault. This approach simplifies many IT tasks related to key management, such as key backup, storage, and renewal.

**Cloud-native assumptions:** Using a cloud-native key management system includes these assumptions:

* You trust the cloud key management solution with creating, managing, and hosting your organization's secrets and keys.
* You enable all on-premises applications and services that rely on accessing encryption services or secrets to access the cloud key management system.

### Bring your own key (BYOK)

With a BYOK approach, you generate keys on dedicated HSM hardware within your on-premises environment. Then, you securely transfer these keys to a cloud-based management system, such as Azure Key Vault, for use with your cloud-hosted resources.

**Bring-your-own-key assumptions:** Generating keys on-premises and using them with a cloud-based key management system includes these assumptions:

* You trust the underlying security and access control infrastructure of the cloud platform for hosting and using your keys and secrets.
* Your cloud-hosted applications or services can access and use keys and secrets in a robust and secure way.
* You're required by regulatory or organizational policy to keep the creation and management of your organization's secrets and keys on-premises.

### On-premises (hold your own key)

Certain scenarios might have regulatory, policy, or technical reasons prohibiting the storage of keys on a cloud-based key management system. If so, you must generate keys using on-premises hardware, store and manage them using an on-premises key management system, and establish a way for cloud-based resources to access these keys for encryption purposes. Holding your own key might not be compatible with all Azure-based services.

**On-premises key management assumptions:** Using an on-premises key management system includes these assumptions:

* You're required by regulatory or organizational policy to create, manage, and host your organization's secrets and keys on-premises.
* Any cloud-based applications or services that rely on accessing encryption services or secrets can access the on-premises key management system.

## Data encryption

Consider several different states of data with different encryption needs when planning your encryption policy:

| Data state | Data |
|-----|-----|
| Data in transit | Internal network traffic, internet connections, connections between datacenters or virtual networks |
| Data at rest    | Databases, files, virtual drives, PaaS storage |
| Data in use     | Data loaded in RAM or in CPU caches |

### Data in transit

Data in transit is data moving between resources on the internal network, between datacenters or external networks, or over the internet.

Typically, data in transit is encrypted by requiring SSL/TLS protocols for network traffic. Always encrypt traffic between your cloud-hosted resources and external networks or the public internet. PaaS resources typically enforce SSL/TLS encryption by default. Your cloud adoption teams and workload owners should consider enforcing encryption for traffic between IaaS resources hosted inside your virtual networks.

**Assumptions about encrypting data in transit:** Implementing proper encryption policy for data in transit assumes the following conditions:

* All publicly accessible endpoints in your cloud environment communicate with the public internet using SSL/TLS protocols.
* When you connect cloud networks with on-premises or other external network over the public internet, use encrypted VPN protocols.
* When you connect cloud networks with on-premises or other external network using a dedicated WAN connection, such as ExpressRoute, you:
   * Use a VPN or other encryption appliance on-premises.
   * Pair the appliance with a corresponding virtual VPN or encryption appliance deployed to your cloud network.
* If you have sensitive data that shouldn't be included in traffic logs or other diagnostics reports visible to IT staff, encrypt all traffic between resources in your virtual network.

### Data at rest

Data at rest represents any data not being actively moved or processed. So data at rest can include files, databases, virtual machine drives, PaaS storage accounts, or similar assets. Encrypting stored data protects virtual devices or files against unauthorized access either from external network penetration, rogue internal users, or accidental releases.

PaaS storage and database resources generally enforce encryption by default. You can secure IaaS resources by encrypting data at the virtual disk level or by encrypting the entire storage account hosting your virtual drives. All of these assets can make use of either Microsoft-managed or customer-managed keys stored in Azure Key Vault.

Encryption for data at rest also encompasses more advanced database encryption techniques. An example of a more advanced encryption technique is column-level and row-level encryption, which provide much more control over exactly what data is being secured.

Your overall policy and compliance requirements, the sensitivity of the data being stored, and the performance requirements of your workloads determine which assets require encryption.

### Assumptions about encrypting data at rest

Encrypting data at rest assumes the following conditions:

* You're storing data that isn't meant for public consumption.
* Your workloads can accept the added latency cost of disk encryption.

### Data in use

Encryption for data in use involves securing data in nonpersistent storage, such as RAM or CPU caches. And using technologies, such as full memory encryption and enclave technologies, such as Intel's Secure Guard Extensions (SGX). This approach also includes cryptographic techniques, such as homomorphic encryption that you can use to create secure, trusted execution environments.

**Assumptions about encrypting data in use:** Encrypting data in use assumes the following condition:

* You're required to maintain data ownership separate from the underlying cloud platform always, even at the RAM and CPU level.

## Learn more

For more information about encryption and key management in Azure, see:

* [Azure encryption overview](/azure/security/fundamentals/encryption-overview): A detailed description of how Azure uses encryption to secure both data at rest and data in transit.
* [Azure Key Vault](/azure/key-vault/general/overview): Key Vault is the primary key management system for storing and managing cryptographic keys, secrets, and certificates within Azure.
* [Azure data security and encryption best practices](/azure/security/fundamentals/data-encryption-best-practices). A discussion of Azure data security and encryption best practices.
* [Confidential computing in Azure](https://azure.microsoft.com/solutions/confidential-compute/): Azure's confidential computing initiative provides tools and technology to create trusted execution environments or other encryption mechanisms to secure data in use.

## Next steps

Encryption is just one of the core infrastructure components requiring architectural decisions during a cloud adoption process. To learn about alternative patterns or models to use when making design decisions for other types of infrastructure, see the architectural decision guides overview.

> [!div class="nextstepaction"]
> [Architectural decision guides overview](../index.md)
