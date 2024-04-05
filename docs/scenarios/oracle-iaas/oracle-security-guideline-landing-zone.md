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

This article describes how to safely run Oracle workloads on Virtual Machines landing zone accelerator at every stage of its lifecycle. The article discusses specific design components and gives focused suggestions for Oracle workloads on Azure infrastructure as a service (IaaS) security.

## Overview

Ensuring security is crucial when it comes to any architecture. Azure offers a comprehensive range of tools to help you effectively secure your Oracle workload. The objective of this article is to provide security recommendations for the Azure control plane related to Oracle application workloads that are deployed on Azure Virtual Machines. For detailed information and implementation guidelines regarding security measures within the Oracle Database product, see [Oracle Database security guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-oracle-database-security.html#GUID-41040F53-D7A6-48FA-A92A-0C23118BC8A0).

Most databases store sensitive data. To have a secure architecture in which to land these workloads, implementing security only at the database level isn't sufficient. Defense-in-depth is a comprehensive approach to security that involves implementing multiple layers of defense mechanisms to protect data. Instead of relying on a single security measure at a specific level, for example focusing on network security mechanisms, the defense-in-depth strategy employs a combination of different layer security measures to create a robust security posture. The defense-in-depth approach can be architected for Oracle workloads through strong authentication and authorization framework, hardened network security, and encryption of data at rest and data in transit.

Oracle workloads currently can be deployed as infrastructure as a service (IaaS) cloud model on Azure. The shared responsibility matrix should be revisited to have a clear understanding of the specific tasks and responsibilities assigned to both the cloud provider and the customer. For more information about the shared responsibility model, see [Shared responsibility in the cloud.](/azure/security/fundamentals/shared-responsibility)

We suggest you periodically assess the services and technologies you employ to ensure that your security measures align with the changing threat landscape.

## Use centralized identity management

Identity management is a fundamental framework that governs access to important resources. When you work with different sorts of personnel, such as part-time employees, interns who join temporarily, or full-time employees, identity management becomes critical. These individuals require different levels of access that need to be monitored, maintained, and promptly revoked as necessary. For your Oracle workloads, there are two distinct identity management use cases to consider, and each use case requires a different identity management solution.

1. **Oracle application** - Users can access the Oracle applications without having to reenter their credentials once they have been authorized through SSO. Use Microsoft Entra ID integration to access Oracle applications. The supported SSO strategy for each Oracle solution is listed in the following table.

    | Oracle application | Link to document |
    | --- | --- |
    |E-business Suite (EBS)|[Enable Single-Sign-On for EBS R12.2](https://docs.oracle.com/cd/E26401_01/doc.122/e22952/T156458T580814.htm)|
    |JD Edwards (JDE)|[Set up JDE Single-Sign-On](https://docs.oracle.com/cd/E24705_01/doc.91/e24258/sso_thru_oam.htm#EOTSC00408)|
    |PeopleSoft|[Enable Single-Sign-On for PeopleSoft](https://docs.oracle.com/en/solutions/sso-peoplesoft-azure-ad/configure-oracle-peoplesoft1.html#GUID-470A312A-7F22-4688-AE95-80F164371875)|
    |Hyperion|[Oracle Support doc #2144637.1](https://support.oracle.com/knowledge/Enterprise%20Performance%20Management%20and%20Business%20Intelligence/2144637_1.html)|
    |Siebel|[Oracle Support doc #2664515.1](https://support.oracle.com/knowledge/Siebel/2664515_1.html)|

2. **Operating system level security** - Oracle workloads can run on various variants of the Linux operating system or Windows.  To enhance the security of Windows and Linux virtual machines in Azure, organizations can integrate them with Microsoft Entra ID. For more information, see the following resources:

    - [Sign in to a Linux virtual machine in Azure by using Microsoft Entra ID and OpenSSH](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-linux)
      - As of writing this document (July 2023) Oracle Linux (OL) and Red Hat Enterprise Linux (RHEL) are 100% binary compatible, so any instructions related to RHEL also apply to OL.
      - As of July 2023, IBM has ceased to openly share RHEL source, so it's possible that OL and RHEL might diverge in the future, invalidating the previous statement.
    - [Sign in to a Windows virtual machine in Azure by using Microsoft Entra ID](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-windows).

3. **Azure Key Vault to store credentials** – Key Vault is a powerful tool that enables the secure storage of secrets, such as passwords and database connection strings, for cloud applications and services. You can use Key Vault to store credentials for both [Windows](/azure/entra/identity/managed-identities-azure-resources/tutorial-windows-vm-access-nonaad) and [Linux](/azure/entra/identity/managed-identities-azure-resources/tutorial-linux-vm-access-nonaad) virtual machines (VMs) in a centralized and secure manner, regardless of the operating system (OS) being used.

      You can avoid the need to store credentials in plain text within your code or configuration files by using Key Vault. Instead, you can retrieve the credentials from the Key Vault at runtime, which adds an additional layer of security to your application and helps to prevent unauthorized access to your VMs. Key Vault integrates seamlessly with other Azure services, such as Azure Virtual Machines, and access to the Key Vault can be controlled by using Azure Active Directory. This process ensures that only authorized users and applications can access the stored credentials.

4. **Use Hardened Operating System Images** - Using a CIS (Center for Internet Security) hardened image for Windows or Linux in Azure can provide several benefits. [CIS benchmarks](https://www.cisecurity.org/insights/blog/cis-hardened-images-now-in-microsoft-azure-marketplace) are globally recognized as the best practices for securing IT systems and data. These images are preconfigured to meet the security recommendations of the CIS, which can save time and effort in hardening the operating system. This can help organizations improve their security posture and comply with security frameworks like NIST and PCI

## Operating system hardening

Ensure the operating system is hardened to eliminate vulnerabilities that could be exploited to attack the Oracle database.

- Use SSH key-pairs for Linux account access instead of passwords.
- Disable password-protected Linux accounts, enable only on request for a short period.
- Disable login access for privileged Linux accounts (that is, root, oracle, etc.), which allows login access to only personalized accounts.
- Instead of direct login, use "sudo" to grant access to privileged Linux accounts (that is, root, oracle, etc.) from personalized accounts.
- Ensure that Linux audit trail logs and “sudo” access logs are captured into Azure Log Analytics by using Linux SYSLOG utility
- Apply security patches and operating system patches/updates regularly from trusted sources only
- Implement restrictions to limit access to the operating system.
- Restrict unauthorized access to server.
- Control server access at the network level to enhance overall security.
- Consider using the Linux firewall daemon as local protection above and beyond Azure network security groups (NSGs).
- Ensure that the Linux firewall daemon is configured to start automatically at boot time.
- Periodically scan network ports being listened upon (that is, Linux command netstat –l) to understand which potential access points, and be sure either Azure network security groups (NSGs) or the Linux firewall daemon controls the access to those ports.  
- Alias potentially destructive Linux commands (such as rm and mv) to force them to interactive mode, so you're prompted at least once before an irreversible command is performed. Advanced users know how to unalias if they wish.
- Set the Oracle database unified system logs to send copies of the Oracle audit logs to the Azure Log Analytics using the Linux SYSLOG utility.

## Use network security

Network security is the fundamental component of a layered security approach for Oracle workloads on Azure.

- **Using Network Security Groups (NSG)**- You can use an Azure network security group to filter network traffic between Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. By using NSG, the traffic between on-premises network to/from Azure can be filtered as well by using IP address ranges and specific ports. For more information, see [Network security group](/azure/virtual-network/network-security-groups-overview).
General inbound port assignments for Oracle database Virtual Machines can be listed as in the following table:

    | Protocol | Port number | Service name        | Comments|
    | -------- | ----------- | ------------------- | --------|
    | TCP      | 22   | SSH                 | Management port for Linux Virtual Machines |
    | TCP      | 1521        | Oracle TNS listener | Other port numbers frequently used for security or for connection load balancing purposes |
    | TCP |   3389   | RDP |  Management port for Windows Virtual Machines|

- **Decide how to connect to your Virtual Machine** - The Virtual Machine on which the Oracle database workload resides must be secured against unauthorized access.  Management access is sensitive due to the higher permissions required for management users.  In Azure, authorized users have several mechanisms available to manage the Virtual Machine securely.

- [Microsoft Defender for Cloud's just-in-time (JIT) access](/azure/defender-for-cloud/just-in-time-access-overview?tabs=defender-for-container-arch-aks) makes intelligent use of Azure’s network security mechanisms to provide time-limited opportunities to access the management ports on your Virtual Machine.
- [Azure Bastion](/azure/bastion/bastion-overview) is a Platform-as-a-Service (PaaS) deployment in Azure for a jump box.

    Either solution can effectively secure management of your Oracle database Virtual Machine, and both solutions can even be used together in an advanced [multi-layered approach](/azure/architecture/solution-ideas/articles/multilayered-protection-azure-vm), if desired.

    In general, JIT access minimizes (but doesn't eliminate) exposures to risks by restricting the times when management ports for SSH or RDP are available, but it does leave open the possibility for access by other sessions “tailgating” during an obtained JIT window, but such tailgaters still must break past the exposed SSH or RDP ports, so the risk exposed is small. However, such exposures can make JIT access less palatable for blocking access from the open internet.

   In general, a Bastion is a hardened jump box designed to protect access from the open internet, but there are [numerous limitations to the Azure Bastion](/azure/bastion/bastion-faq), which is another consideration.

- **X-Windows and VNC** - The installation of Oracle database software usually requires using X-Windows and because connectivity between the Linux Virtual Machine in Azure and your desktop or laptop might traverse across firewalls and Azure network security groups, it's recommended to use SSH port forwarding to tunnel the X-Windows or VNC connections through SSH, as illustrated with the -L 5901:localhost:5901 parameter for the following section about [SSH command described in the Oracle document](https://docs.oracle.com/en/learn/install-vnc-oracle-linux/#open-a-vnc-client-and-test-your-deployment).

- **Cross-cloud interconnect options**- For connectivity from Oracle database workloads that run in Azure and workloads in Oracle cloud (OCI), private links or pipelines between applications can be created by using the Azure/OCI interconnect between specific regions in Azure and OCI. Review the documentation [Set up a direct interconnection between Azure and Oracle Cloud Infrastructure](/azure/virtual-machines/workloads/oracle/configure-azure-oci-networking). This documentation doesn't cover the creation of firewalls on either side of the Azure/OCI interconnect, which is generally a requirement for any ingress or egress across clouds, employing [Microsoft’s ZeroTrust Networking recommendations](https://www.microsoft.com/security/blog/2018/06/14/building-zero-trust-networks-with-microsoft-365/).

## Azure policy-based security

There are no specific built-in Azure policy definitions for Oracle on Azure Virtual Machines landing zone accelerator. However, Azure Policy offers comprehensive coverage for the fundamental resources that is used by any Oracle solution on Azure, including virtual machines, storage, and networking. See [Azure Policy built-in policy definitions](/azure/governance/policy/samples/built-in-policies) for those resources.
Furthermore, you can always create custom policies to address your organization’s requirements to bridge the gap. Some examples of customized Oracle policies can be listed as no public IP assigned to Oracle Virtual Machine, enforce storage encryption, NSG rules etc.

## Secure data using encryption

- **Encryption in transit** - Applies to the state of data moving from one location to another, usually across a network connection. Data in transit can be encrypted in several ways, depending on the nature of the connection. Azure doesn't provide encryption for data in transit inside Azure datacenters by default, so if encryption in transit is required, customers must enable it.  For more information in the Azure documentation, see [encryption of data in transit](/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit).
Microsoft recommends using Oracle’s Native Network Encryption and Data Integrity feature, and for more information, see [Configuring Oracle Database Native Network Encryption and Data Integrity](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/configuring-network-data-encryption-and-integrity.html#GUID-7F12066A-2BA1-476C-809B-BB95A3F727CF) by Oracle.
- **Encrypt data at rest** - In addition to protecting data as it is in transit, it's also necessary to protect data when it's written to storage, while it is at rest. Storage media can be removed and the data within examined, and storage media can be accessed while in use and confidential information revealed, so it's important that data be encrypted so that only authorized and authenticated users can view or modify it. Azure provides three layers of encryption at rest.
  - All data is encrypted at the lowest level when it's persisted into any Azure storage device, which is called [Azure Storage service-side encryption](/azure/storage/common/storage-service-encryption#about-azure-storage-service-side-encryption). This level of encryption is designed to ensure that it isn't necessary to erase or destroy the storage media when an Azure tenant is done by using storage.  When the data is always encrypted at rest, the data is gone forever if the platform managed key is discarded, and this is a lot faster and safer than attempting to erase all traces of data from storage.
  - Azure also provides an opportunity to [doubly encrypt](/azure/storage/common/infrastructure-encryption-enable?tabs=portal) stored data within the Azure Storage infrastructure using Azure Storage infrastructure encryption, using two separate platform-managed keys.
  - In addition, [Azure disk encryption](/azure/virtual-machines/disk-encryption) is at-rest encryption managed within the guest OS. That is,[BitLocker for Windows, DM-CRYPT for Linux](/azure/storage/common/storage-service-encryption#client-side-encryption-for-blobs-and-queues).

With one, two, or three possible layers of encryption at rest in the Azure storage infrastructure, the Oracle Database also offers transparent data encryption (TDE) of the database files, and another level of encryption at rest, as part of the [Oracle Advanced Security option](https://docs.oracle.com/en/database/oracle/oracle-database/19/asoag/introduction-to-oracle-advanced-security.html#GUID-5D7343A0-4934-444F-97A1-5F189385A5DE).

Furthermore, the Oracle Advanced Security option also offers a feature called [Data redaction](https://docs.oracle.com/en/database/oracle/oracle-database/19/asoag/introduction-to-oracle-advanced-security.html#GUID-5D7343A0-4934-444F-97A1-5F189385A5DE), which is a form of dynamic data masking. As the database retrieves data, it masks the data value, without altering the data value stored.
These multiple layers of encryption at rest represent the very definition of defense-in-depth. If for some reason one of the forms of encryption at rest are compromised, there are still other layers of encryption protecting the data.

- **Key management** - If you choose to implement Oracle Transparent Data Encryption (TDE) as another encryption layer, it's important to note that Oracle doesn't support the native key management solutions (for example, Key Vault, etc.) provided by Azure or other cloud providers. Now, the primary solution for the Oracle Wallet location is the default location within the filesystem of the Oracle database Virtual Machine.
  
However, you can utilize Oracle Key Vault as a key management solution on Azure. For detailed information, refer to the documentation on [Provisioning Oracle Key Vault in Azure](https://docs.oracle.com/en/database/oracle/key-vault/21.6/okvag/using_okv_as_oci_vm_compute_instance.html#GUID-E8154AEB-2964-4698-AE6E-64A108C06D11).

### Integrating audit trails

Application log monitoring is essential for detecting security threats at the application level. We recommend using the Microsoft Sentinel Solution for Oracle Database workloads. The Oracle Database Audit connector retrieves and ingests all Oracle database audit records into Azure Log Analytics by using an industry-standard SYSLOG interface. This permits those records to be reviewed along with Azure infrastructure audit records and guest OS (that is, Linux or Windows) audit records.  It’s a cloud-native security information and event management (SIEM) solution built for your Oracle workload that runs on a Linux or Windows Virtual Machine. For more information, see [Oracle Database Audit connector for Microsoft Sentinel](/azure/sentinel/data-connectors/oracle-database-audit).

## Next steps

To understand how to plan for capacity requirements for Oracle workloads on Azure, see [Capacity planning for migrating Oracle workloads to Azure landing zones](oracle-capacity-planning.md).
