---
title: Security guidelines for Oracle on Azure Virtual Machines landing zone accelerator
description: Learn about security guidelines for Oracle on Azure Virtual Machines landing zone accelerator.
author: gkayali
ms.author: guherk
ms.date: 04/04/2024
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Security guidelines for Oracle on Azure Virtual Machines landing zone accelerator

This article describes how to safely run Oracle workloads on Azure Virtual Machines landing zone accelerator at every stage of its lifecycle. The article discusses specific design components and gives focused suggestions for Oracle workloads on Azure infrastructure as a service (IaaS) security.

## Overview

Security is essential for any architecture. Azure offers a comprehensive range of tools to help you effectively secure your Oracle workload. The purpose of this article is to provide security recommendations for the Azure control plane related to Oracle application workloads that are deployed on Virtual Machines. For detailed information and implementation guidelines regarding security measures within the Oracle Database product, see [Oracle Database security guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-oracle-database-security.html#GUID-41040F53-D7A6-48FA-A92A-0C23118BC8A0).

Most databases store sensitive data. Implementing security only at the database level isn't enough to secure an architecture in which to land these workloads. Defense in-depth is a comprehensive approach to security that implements multiple layers of defense mechanisms to protect data. Instead of relying on a single security measure at a specific level, such as focusing only on network security mechanisms, the defense in-depth strategy uses a combination of different layer security measures to create a robust security posture. You can architect the defense in-depth approach for Oracle workloads by using a strong authentication and authorization framework, hardened network security, and encryption of data at rest and data in transit.

You can deploy Oracle workloads as an IaaS cloud model on Azure. Revisit the shared responsibility matrix for a clearer understanding of the specific tasks and responsibilities assigned to both the cloud provider and the customer. For more information about the shared responsibility model, see [Shared responsibility in the cloud](/azure/security/fundamentals/shared-responsibility).

You should periodically assess the services and technologies that you use to ensure that your security measures align with the changing threat landscape.

## Use centralized identity management

Identity management is a fundamental framework that governs access to important resources. Identity management becomes critical when you work with different types of personnel, such as temporary interns, part-time employees, or full-time employees. These personnel require different levels of access that need to be monitored, maintained, and promptly revoked as necessary. There are four distinct identity management use cases to consider for your Oracle workloads, and each use case requires a different identity management solution.

1. **Oracle applications**: Users can access Oracle applications without having to reenter their credentials once they have been authorized through single sign-on (SSO). Use Microsoft Entra ID integration to access Oracle applications. The supported SSO strategy for each Oracle solution is listed in the following table.
    | Oracle application | Link to document |
    | --- | --- |
    |E-Business Suite (EBS)|[Enable SSO for EBS R12.2](https://docs.oracle.com/cd/E26401_01/doc.122/e22952/T156458T580814.htm)|
    |JD Edwards (JDE)|[Set up JDE SSO](https://docs.oracle.com/cd/E24705_01/doc.91/e24258/sso_thru_oam.htm#EOTSC00408)|
    |PeopleSoft|[Enable SSO for PeopleSoft](https://docs.oracle.com/en/solutions/sso-peoplesoft-azure-ad/configure-oracle-peoplesoft1.html#GUID-470A312A-7F22-4688-AE95-80F164371875)|
    |Hyperion|[Oracle Support doc #2144637.1](https://support.oracle.com/knowledge/Enterprise%20Performance%20Management%20and%20Business%20Intelligence/2144637_1.html)|
    |Siebel|[Oracle Support doc #2664515.1](https://support.oracle.com/knowledge/Siebel/2664515_1.html)|

2. **Operating system (OS) level security**: Oracle workloads can run on different variants of the Linux OS or Windows. Organizations can improve the security of their Windows and Linux virtual machines (VMs) in Azure by integrating them with Microsoft Entra ID. For more information, see the following resources:

    - [Sign in to a Linux VM in Azure by using Microsoft Entra ID and OpenSSH](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-linux).
      - As of July 2023, Oracle Linux (OL) and Red Hat Enterprise Linux (RHEL) are 100% binary compatible, which means that any instructions related to RHEL are applicable to OL.
      - As of July 2023, IBM has ceased to openly share RHEL source. It's possible that OL and RHEL might diverge in the future, which will invalidate the previous statement.
    - [Sign in to a Windows VM in Azure by using Microsoft Entra ID](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-windows).

3. **Azure Key Vault to store credentials**: Key Vault is a powerful tool for cloud applications and services that you can use to secure storage of secrets, such as passwords and database connection strings. You can use Key Vault to store credentials for both [Windows](/azure/entra/identity/managed-identities-azure-resources/tutorial-windows-vm-access-nonaad) and [Linux](/azure/entra/identity/managed-identities-azure-resources/tutorial-linux-vm-access-nonaad) VMs in a centralized and secure manner, regardless of the OS.

      You can avoid the need to store credentials in plain text within your code or configuration files by using Key Vault. You can retrieve the credentials from the Key Vault at runtime, which adds an additional layer of security to your application and helps to prevent unauthorized access to your VMs. Key Vault integrates seamlessly with other Azure services, such as Virtual Machines, and you can control access to the Key Vault by using Azure Active Directory (Azure AD). This process ensures that only authorized users and applications can access the stored credentials.

4. **Use hardened OS images**: A CIS (Center for Internet Security) hardened image for Windows or Linux in Azure has multiple benefits. [CIS benchmarks](https://www.cisecurity.org/insights/blog/cis-hardened-images-now-in-microsoft-azure-marketplace) are globally recognized as the best practices for securing IT systems and data. These images are preconfigured to meet the security recommendations of the CIS, which can save time and effort in hardening the OS. This can help organizations improve their security posture and comply with security frameworks like the National Institute of Standards and Technology (NIST) and Peripheral Component Interconnect (PCI).

## OS hardening

Ensure the OS is hardened to eliminate vulnerabilities that could be exploited to attack the Oracle database.

- Use SSH key-pairs for Linux account access instead of passwords.
- Disable password-protected Linux accounts and enable only on request for a short period.
- Disable login access for privileged Linux accounts (that is root, oracle, etc.), which allows login access only to personalized accounts.
- Instead of direct login, use _sudo_ to grant access to privileged Linux accounts (that is, root, oracle, etc.) from personalized accounts.
- Ensure that Linux audit trail logs and _sudo_ access logs are captured into Azure Log Analytics by using Linux SYSLOG utility.
- Apply security patches and OS patches or updates regularly from trusted sources only.
- Implement restrictions to limit access to the OS.
- Restrict unauthorized access to the server.
- Control server access at the network level to enhance overall security.
- Consider using the Linux firewall daemon as local protection above and beyond Azure network security groups (NSGs).
- Ensure that the Linux firewall daemon is configured to start automatically at boot time.
- Scan network ports being listened upon (that is, Linux command netstat –l) to understand the potential access points, and be sure either Azure network security groups (NSGs) or the Linux firewall daemon controls the access to those ports.  
- Alias potentially destructive Linux commands (such as rm and mv) to force them into interactive mode so that you're prompted at least once before an irreversible command is performed. Advanced users know how to unalias if they wish.
- Set the Oracle database unified system logs to send copies of the Oracle audit logs to Azure Log Analytics using the Linux SYSLOG utility.

## Use network security

Network security is the fundamental component of a layered security approach for Oracle workloads on Azure.

**Use Network security group (NSG)**: You can use an Azure network security group to filter network traffic between Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to or outbound network traffic from several types of Azure resources. By using NSG, you can filter the traffic between on-premises networks to and from Azure by using IP address ranges and specific ports. For more information, see [Network security group](/azure/virtual-network/network-security-groups-overview).

General inbound port assignments for Oracle database Virtual Machines are listed in the following table:

  | Protocol | Port number | Service name | Comments|
  | --- | --- | --- | ---|
  | TCP | 22   | SSH  | Management port for Linux Virtual Machines |
  | TCP | 1521 | Oracle TNS listener | Other port numbers frequently used for security or for connection load balancing purposes |
  | TCP |   3389 | RDP |  Management port for Windows Virtual Machines|

- **Decide how to connect to your Virtual Machine**: The Virtual Machine on which the Oracle database workload resides must be secured against unauthorized access.  Management access is sensitive due to the higher permissions required for management users. In Azure, authorized users have several mechanisms available to securely manage the Virtual Machine.

- [Microsoft Defender for Cloud's just-in-time (JIT) access](/azure/defender-for-cloud/just-in-time-access-overview?tabs=defender-for-container-arch-aks) makes intelligent use of Azure’s network security mechanisms to provide time-limited opportunities to access the management ports on your Virtual Machine.
- [Azure Bastion](/azure/bastion/bastion-overview) is a platform as a service (PaaS) deployment in Azure for a jump box.

    You can use either solution to secure management of your Oracle database Virtual Machine. If desired, you can combine both solutions for an advanced [multi-layered approach](/azure/architecture/solution-ideas/articles/multilayered-protection-azure-vm).

    In general, JIT access minimizes but doesn't eliminate exposure to risks by restricting the times when management ports for SSH or RDP are available. JIT does leave open the possibility for access by other sessions tailgating during an obtained JIT window. Such tailgaters still must break past the exposed SSH or RDP ports, so the exposure risk is small. However, such exposures can make JIT access less palatable for blocking access from the open internet.

   A Bastion is a hardened jump box designed to protect access from the open internet. However, there are [numerous limitations to the Azure Bastion](/azure/bastion/bastion-faq) for you to consider.

- **X-Windows and VNC**: The installation of Oracle database software usually requires that you use X-Windows because connectivity between the Linux Virtual Machine in Azure and your desktop or laptop might traverse across firewalls and Azure network security groups. Because of this, you should use SSH port forwarding to tunnel the X-Windows or VNC connections through SSH, as illustrated with the -L 5901:localhost:5901 parameter for the following section that discusses [SSH command described in the Oracle document](https://docs.oracle.com/en/learn/install-vnc-oracle-linux/#open-a-vnc-client-and-test-your-deployment).

- **Cross-cloud interconnect options**: For connectivity from Oracle database workloads that run in Azure and workloads in Oracle Cloud Infrastructure (OCI), you can create private links or pipelines between applications by using the Azure/OCI interconnect between specific regions in Azure and OCI. Review the documentation [Set up a direct interconnection between Azure and Oracle Cloud Infrastructure](/azure/virtual-machines/workloads/oracle/configure-azure-oci-networking). This documentation doesn't cover the creation of firewalls on either side of the Azure/OCI interconnect, which is generally a requirement for any ingress or egress across clouds. This employs [Microsoft’s ZeroTrust Networking recommendations](https://www.microsoft.com/security/blog/2018/06/14/building-zero-trust-networks-with-microsoft-365/).

## Azure policy-based security

There are no specific built-in Azure policy definitions for Oracle on Virtual Machines landing zone accelerator. However, Azure Policy offers comprehensive coverage for the fundamental resources that are used by any Oracle solution on Azure, including VMs, storage, and networking. See [Azure Policy built-in policy definitions](/azure/governance/policy/samples/built-in-policies) for those resources.
Furthermore, you can always create custom policies to address your organization’s requirements to bridge the gap. Some examples of customized Oracle policies can be listed as no public IP address assigned to Oracle Virtual Machine, enforce storage encryption, NSG rules, and so on.

## Secure data using encryption

- **Encrypt data in transit**: Applies to the state of data moving from one location to another and usually across a network connection. Data in transit can be encrypted in several ways, depending on the nature of the connection. Customers must enable data encryption by default for data in transit inside Azure datacenters as it is not automatic. For more information in the Azure documentation, see [Encryption of data in transit](/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit).
Microsoft recommends using Oracle’s Native Network Encryption and Data Integrity features. For more information, see [Configuring Oracle Database Native Network Encryption and Data Integrity](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/configuring-network-data-encryption-and-integrity.html#GUID-7F12066A-2BA1-476C-809B-BB95A3F727CF).
- **Encrypt data at rest**: Data in transit and data at rest when it's written to storage must both be protected. Confidential data can be exposed or altered when storage media is removed or accessed during use. Therefore, data should be encrypted to ensure that only authorized and authenticated users can view or modify it. Azure provides three layers of encryption at rest.
  - All data is encrypted at the lowest level when it's persisted into any Azure Storage device with [Azure Storage service-side encryption](/azure/storage/common/storage-service-encryption#about-azure-storage-service-side-encryption). Service-side encryption ensures that it isn't necessary to erase or destroy the storage media when an Azure tenant is done by using storage. Data that is always encrypted at rest can be lost permanently if the platform managed key is discarded Service-side encryption is quicker and more secure than trying to delete all data from storage.
  - Azure also provides an opportunity to [doubly encrypt](/azure/storage/common/infrastructure-encryption-enable?tabs=portal) stored data inside the Storage infrastructure by using Storage infrastructure encryption, which uses two separate platform-managed keys.
  - In addition, [Azure disk encryption](/azure/virtual-machines/disk-encryption) is data at rest encryption managed within the guest OS [BitLocker for Windows, DM-CRYPT for Linux](/azure/storage/common/storage-service-encryption#client-side-encryption-for-blobs-and-queues).

The Storage infrastructure has up to three possible layers of data at rest encryption. The Oracle Database can also encrypt database files with transparent data encryption (TDE) and another level of data at rest encryption as part of the [Oracle Advanced Security option](https://docs.oracle.com/en/database/oracle/oracle-database/19/asoag/introduction-to-oracle-advanced-security.html#GUID-5D7343A0-4934-444F-97A1-5F189385A5DE).

Furthermore, the Oracle Advanced Security option also offers a feature called [Data Redaction](https://docs.oracle.com/en/database/oracle/oracle-database/19/asoag/introduction-to-oracle-advanced-security.html#GUID-5D7343A0-4934-444F-97A1-5F189385A5DE), which is a form of dynamic data masking. As the database retrieves data, it masks the data value without altering the stored data value.

These multiple layers of encryption at rest represent the very definition of defense in-depth. If for some reason one of the forms of encryption at rest are compromised, there are still other layers of encryption to protect the data.

- **Key management**: If you choose to implement Oracle Transparent Data Encryption (TDE) as another encryption layer, it's important to note that Oracle doesn't support the native key management solutions provided by Azure or other cloud providers, such as Key Vault. Instead, the primary solution for the Oracle Wallet location is the default location within the filesystem of the Oracle database Virtual Machine.
  
For more information, see [Provisioning Oracle Key Vault in Azure](https://docs.oracle.com/en/database/oracle/key-vault/21.6/okvag/using_okv_as_oci_vm_compute_instance.html#GUID-E8154AEB-2964-4698-AE6E-64A108C06D11) to learn how to use Oracle Key Vault as an Azure key management solution.

### Integrating audit trails

Application log monitoring is essential for detecting security threats at the application level. Use the Microsoft Sentinel Solution for Oracle Database workloads. The Oracle Database Audit connector retrieves and ingests all Oracle database audit records into Azure Log Analytics by using an industry-standard SYSLOG interface. This permits those records to be reviewed along with Azure infrastructure audit records and guest OS (that is, Linux or Windows) audit records. It’s a cloud-native security information and event management (SIEM) solution built for your Oracle workload that runs on a Linux or Windows Virtual Machine. For more information, see [Oracle Database Audit connector for Microsoft Sentinel](/azure/sentinel/data-connectors/oracle-database-audit).

## Next step

To understand how to plan for capacity requirements for Oracle workloads on Azure, see [Capacity planning for migrating Oracle workloads to Azure landing zones](oracle-capacity-planning.md).
