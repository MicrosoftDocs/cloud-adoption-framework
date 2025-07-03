---
title: Security guidelines for Oracle on Azure Virtual Machines landing zone accelerator
description: Learn about security guidelines for Oracle workloads on Azure Virtual Machines landing zone accelerator at every stage of their lifecycle.
author: jessiehaessler
ms.author: jhaessler
ms.date: 06/24/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Security guidelines for Oracle workloads on Azure Virtual Machines landing zone accelerator

This article describes how to safely run Oracle workloads on Azure Virtual Machines landing zone accelerator at every stage of their lifecycle. The article discusses specific design components and provides focused suggestions about Azure infrastructure as a service (IaaS) security for Oracle workloads.

## Overview

Security is essential for any architecture. Azure offers a comprehensive range of tools to help you effectively secure your Oracle workload. The purpose of this article is to provide security recommendations for the Azure control plane related to Oracle application workloads that are deployed on Virtual Machines. For detailed information and implementation guidelines regarding security measures within Oracle Database, see [Oracle Database security guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-oracle-database-security.html#GUID-41040F53-D7A6-48FA-A92A-0C23118BC8A0).

Most databases store sensitive data. Implementing security only at the database level isn't enough to secure the architecture where you deploy these workloads. Defense in-depth is a comprehensive approach to security that implements multiple layers of defense mechanisms to protect data. Instead of relying on a single security measure at a specific level, such as focusing only on network security mechanisms, the defense in-depth strategy uses a combination of different layer security measures to create a robust security posture. You can architect the defense in-depth approach for Oracle workloads by using a strong authentication and authorization framework, hardened network security, and encryption of data at rest and data in transit.

You can deploy Oracle workloads as an IaaS cloud model on Azure. Revisit the shared responsibility matrix for a clearer understanding of the specific tasks and responsibilities assigned to both the cloud provider and the customer. For more information, see [Shared responsibility in the cloud](/azure/security/fundamentals/shared-responsibility).

You should periodically assess the services and technologies that you use to ensure that your security measures align with the changing threat landscape.

## Use centralized identity management

Identity management is a fundamental framework that governs access to important resources. Identity management becomes critical when you work with different types of personnel, such as temporary interns, part-time employees, or full-time employees. These personnel require different levels of access that need to be monitored, maintained, and promptly revoked as necessary. There are four distinct identity management use cases to consider for your Oracle workloads, and each use case requires a different identity management solution.

- **Oracle applications**: Users can access Oracle applications without having to reenter their credentials after they're authorized via single sign-on (SSO). Use Microsoft Entra ID integration to access Oracle applications. The following table lists the supported SSO strategy for each Oracle solution.

  | Oracle application | Link to document |
  | --- | --- |
  |E-Business Suite (EBS)|[Enable SSO for EBS R12.2](https://docs.oracle.com/cd/E26401_01/doc.122/e22952/T156458T580814.htm)|
  |JD Edwards (JDE)|[Set up JDE SSO](https://docs.oracle.com/cd/E24705_01/doc.91/e24258/sso_thru_oam.htm#EOTSC00408)|
  |Hyperion|[Oracle support doc #2144637.1](https://support.oracle.com/knowledge/Enterprise%20Performance%20Management%20and%20Business%20Intelligence/2144637_1.html)|
  |Siebel|[Oracle support doc #2664515.1](https://support.oracle.com/knowledge/Siebel/2664515_1.html)|

- **Operating system (OS) level security**: Oracle workloads can run on different variants of the Linux OS or Windows OS. Organizations can improve the security of their Windows and Linux virtual machines (VMs) in Azure by integrating them with Microsoft Entra ID. For more information, see:

    - [Sign in to a Linux VM in Azure by using Microsoft Entra ID and OpenSSH](/entra/identity/devices/howto-vm-sign-in-azure-ad-linux).
      - As of July 2023, Oracle Linux (OL) and Red Hat Enterprise Linux (RHEL) are 100% binary compatible, which means that any instructions related to RHEL are applicable to OL.
      - As of July 2023, IBM has ceased to openly share RHEL source code. It's possible that OL and RHEL might diverge in the future, which will invalidate the previous statement.
    - [Sign in to a Windows VM in Azure by using Microsoft Entra ID](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows).

- **Azure Key Vault to store credentials**: Key Vault is a powerful tool for cloud applications and services that you can use to secure storage of secrets, such as passwords and database connection strings. You can use Key Vault to store credentials for both [Windows](/entra/identity/managed-identities-azure-resources/tutorial-windows-vm-access-nonaad) and [Linux](/entra/identity/managed-identities-azure-resources/tutorial-linux-vm-access-nonaad) VMs in a centralized and secure manner, regardless of the OS.

  - You can avoid the need to store credentials in plain text within your code or configuration files by using Key Vault. You can retrieve the credentials from the Key Vault at runtime, which adds an additional layer of security to your application and helps to prevent unauthorized access to your VMs. Key Vault integrates seamlessly with other Azure services, such as Virtual Machines, and you can control access to the Key Vault by using Microsoft Entra ID. This process ensures that only authorized users and applications can access the stored credentials.

- **Hardened OS images**: A Center for Internet Security (CIS) hardened image for Windows or Linux in Azure has multiple benefits. [CIS benchmarks](https://www.cisecurity.org/insights/blog/cis-hardened-images-now-in-microsoft-azure-marketplace) are globally recognized as the best practices for securing IT systems and data. These images are preconfigured to meet the security recommendations of CIS, which can save time and effort in hardening the OS. Hardened OS images can help organizations improve their security posture and comply with security frameworks like the National Institute of Standards and Technology (NIST) and Peripheral Component Interconnect (PCI).

## Harden the OS

Ensure the OS is hardened to eliminate vulnerabilities that could be exploited to attack the Oracle database.

- Use Secure Shell (SSH) key pairs for Linux account access instead of passwords.
- Disable password-protected Linux accounts and enable them only on request for a short period.
- Disable sign in access for privileged Linux accounts (root or Oracle), which allows sign in access only to personalized accounts.
- Instead of direct sign in access, use *sudo* to grant access to privileged Linux accounts from personalized accounts.
- Capture Linux audit trail logs and *sudo* access logs in Azure Monitor Logs by using the Linux SYSLOG utility.
- Apply security patches and OS patches or updates regularly from trusted sources only.
- Implement restrictions to limit access to the OS.
- Restrict unauthorized access to the server.
- Control server access at the network level to enhance overall security.
- Consider using the Linux firewall daemon for local protection in addition to Azure network security groups (NSGs).
- Configure the Linux firewall daemon to run automatically at startup.
- Scan network ports being listened upon to understand the potential access points, and be sure either Azure NSGs or the Linux firewall daemon controls the access to those ports. Use the Linux command `netstat –l` to find the ports. 
- Alias potentially destructive Linux commands, such as `rm` and `mv`, to force them into interactive mode so that you're prompted at least once before an irreversible command is performed. Advanced users can run an unalias command if needed.
- Configure the Oracle database unified system logs to send copies of the Oracle audit logs to Azure Monitor Logs by using the Linux SYSLOG utility.

## Use network security

Network security is the fundamental component of a layered security approach for Oracle workloads on Azure.

- **Use NSGs**: You can use an Azure NSG to filter network traffic between Azure resources in an Azure virtual network. An NSG contains security rules that allow or deny inbound network traffic to Azure resources or outbound network traffic from Azure resources. NSGs can filter the traffic between on-premises networks to and from Azure by using IP address ranges and specific ports. For more information, see [Network security group](/azure/virtual-network/network-security-groups-overview).

  The following table lists inbound port assignments for Oracle database VMs:

  | Protocol | Port number | Service name | Comment|
  | --- | --- | --- | ---|
  | TCP | 22   | SSH  | Management port for Linux VMs |
  | TCP | 1521 | Oracle TNS listener | Other port numbers frequently used for security purposes or connection load balancing purposes |
  | TCP |   3389 | RDP |  Management port for Windows VMs|

- **Decide how to connect to your VM**: The VM on which the Oracle database workload resides must be secured against unauthorized access. Management access is sensitive due to the higher permissions required for management users. In Azure, authorized users have several mechanisms available to securely manage the VM.

  - [Microsoft Defender for Cloud's just-in-time (JIT) access](/azure/defender-for-cloud/just-in-time-access-overview) makes intelligent use of Azure’s network security mechanisms to provide time-limited opportunities to access the management ports on your VM.
  - [Azure Bastion](/azure/bastion/bastion-overview) is a platform as a service (PaaS) solution that you deploy in Azure. Azure Bastion hosts a jump box.

You can use either solution to secure management of your Oracle database VM. If desired, you can combine both solutions for an advanced [multi-layered approach](/azure/architecture/solution-ideas/articles/multilayered-protection-azure-vm).

In general, JIT access minimizes but doesn't eliminate exposure to risks by restricting the times when management ports for SSH or RDP are available. JIT does leave open the possibility for access by other sessions tailgating during an obtained JIT window. Such tailgaters still must break past the exposed SSH or RDP ports, so the exposure risk is small. However, such exposures can make JIT access less palatable for blocking access from the open internet.

Azure Bastion is essentially a hardened jump box that helps prevent access from the open internet. However, there are [numerous limitations to Azure Bastion](/azure/bastion/bastion-faq) for you to consider.

- **Use X-Windows and Virtual Networking Computing (VNC)**: Oracle database software usually requires that you use X-Windows because connectivity between the Linux VM in Azure and your desktop or laptop might traverse across firewalls and Azure NSGs. Because of this, you should use SSH port forwarding to tunnel the X-Windows or VNC connections through SSH. For an example that uses the `-L 5901:localhost:5901` parameter, see [Open a VNC client and test your deployment](https://docs.oracle.com/en/learn/ol-install-vnc/#open-a-vnc-client-and-test-your-deployment).

## Azure policy-based security

There are no specific built-in Azure policy definitions for Oracle workloads on Virtual Machines landing zone accelerator. However, Azure Policy offers comprehensive coverage for the fundamental resources that are used by any Oracle solution on Azure, including VMs, storage, and networking. For more information, see [Azure Policy built-in policy definitions](/azure/governance/policy/samples/built-in-policies).

You can also create custom policies to address your organization's requirements to bridge the gap. For example, use custom Oracle policies to enforce storage encryption, manage NSG rules, or prohibit the assignment of public IP address to an Oracle VM.

## Use encryption to store data

- **Encrypt data in transit**: Applies to the state of data moving from one location to another and usually across a network connection. Data in transit can be encrypted in several ways, depending on the nature of the connection. By default, you must manually enable data encryption for data in transit inside Azure datacenters. For more information in the Azure documentation, see [Encryption of data in transit](/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit).

  - We recommend that you use the Oracle native network encryption and data integrity features. For more information, see [Configuring Oracle database native network encryption and data integrity](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/configuring-network-data-encryption-and-integrity.html#GUID-7F12066A-2BA1-476C-809B-BB95A3F727CF).

- **Encrypt data at rest**: You must also protect data when it's written to storage, while it's at rest. Confidential data can be exposed or altered when storage media is removed or accessed during use. Therefore, data should be encrypted to ensure that only authorized and authenticated users can view or modify it. Azure provides three layers of encryption at rest.
  - All data is encrypted at the lowest level when it's persisted into any Azure Storage device with [Storage service-side encryption](/azure/storage/common/storage-service-encryption#about-azure-storage-service-side-encryption). Service-side encryption ensures that it isn't necessary to erase or destroy the storage media when an Azure tenant is done using storage. Data that's always encrypted at rest can be lost permanently if the platform-managed key is discarded. Service-side encryption is quicker and more secure than trying to delete all data from storage.
  - Azure also provides an opportunity to [double encrypt](/azure/storage/common/infrastructure-encryption-enable) stored data inside the Storage infrastructure by using Storage infrastructure encryption, which uses two separate platform-managed keys.
  - In addition, [Azure disk encryption](/azure/virtual-machines/disk-encryption) is data at rest encryption that's managed within the guest OS ([BitLocker for Windows and DM-CRYPT for Linux](/azure/storage/common/storage-service-encryption#client-side-encryption-for-blobs-and-queues)).
  
The Storage infrastructure has up to three possible layers of data at rest encryption. If you have the [Oracle Advanced Security option](https://docs.oracle.com/en/database/oracle/oracle-database/19/asoag/introduction-to-oracle-advanced-security.html#GUID-5D7343A0-4934-444F-97A1-5F189385A5DE), the Oracle database can also encrypt database files with transparent data encryption (TDE) and provide another level of encryption at rest.

The Oracle Advanced Security option also offers a feature called [data redaction](https://docs.oracle.com/en/database/oracle/oracle-database/19/asoag/introduction-to-oracle-advanced-security.html#GUID-5D7343A0-4934-444F-97A1-5F189385A5DE), which is a form of dynamic data masking. When the database retrieves data, it masks the data value without altering the stored data value.

These multiple layers of encryption at rest represent the very definition of defense in-depth. If for some reason one of the forms of encryption at rest are compromised, there are still other layers of encryption to protect the data.

- **Manage keys**: If you implement Oracle TDE as another encryption layer, it's important to note that Oracle doesn't support the native key management solutions, such as Key Vault, provided by Azure or other cloud providers. Instead, the default location for the Oracle wallet is within the filesystem of the Oracle database VM.
  
For more information, see [Provisioning Oracle Key Vault in Azure](https://docs.oracle.com/en/database/oracle/key-vault/21.6/okvag/using_okv_as_oci_vm_compute_instance.html#GUID-E8154AEB-2964-4698-AE6E-64A108C06D11) to learn how to use Oracle Key Vault as an Azure key management solution.

### Integrate audit trails

Application log monitoring is essential for detecting security threats at the application level. Use the Microsoft Sentinel solution for Oracle Database workloads. The Oracle Database audit connector retrieves and ingests all Oracle database audit records into Azure Monitor Logs by using an industry-standard SYSLOG interface. This process permits those records to be reviewed along with Azure infrastructure audit records and guest OS (Linux or Windows) audit records. The Microsoft Sentinel solution is a cloud-native security information and event management (SIEM) solution that's built for your Oracle workload that runs on a Linux or Windows VM. For more information, see [Oracle database audit connector for Microsoft Sentinel](/azure/sentinel/data-connectors/oracle-database-audit).

## Next step

To understand how to plan for capacity requirements for Oracle workloads on Azure, see [Capacity planning for migrating Oracle workloads to Azure landing zones](oracle-capacity-planning.md).
