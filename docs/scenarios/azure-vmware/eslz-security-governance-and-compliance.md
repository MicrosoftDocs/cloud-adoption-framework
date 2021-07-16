---
title: Security, Governance & Compliance disciplines for Azure VMware Solution
description: Get started with Security, Governance & Compliance considerations for Azure VMware Solution. Understand the potential risks if some important design considerations are ignored. Learn to mitigate those risks by using design recommendations as suggested in this article. 
author: Mahesh-MSFT, <jon-github-tba>, <sabine-github-tba>, <sundeep-github-tba>
ms.author: maksh, jchancellor, sablair, sundeeph
ms.date: 07/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Security, Governance & Compliance disciplines for Azure VMware Solution

This article covers implementing an Azure VMware Solution that is secure while holistically governing the solution for the duration of its lifecycle. It does this with the goal of assisting organizations meet their compliance requirements and by exploring specific design elements that should be considered when implementing Azure VMware Solution. The document also provides targeted recommendations regarding security, governance, and overall
design. Because there is significant value in the existing Enterprise Scale Landing Zone (ESLZ) and Azure services guidance, cross links to that documentation is included.

## Security

Consider the following when deciding who (system, user, or device) is allowed to perform functions within Azure VMware Solution and how to secure the overall platform.

### Identity Security

* **Limit Permanent Access** - Azure VMware Solution makes use of the contributor role at Azure resource group scope which hosts the AVS private cloud. A standing permanent access may result in intentional or unintentional contributor rights abuse.  

  Use a privileged account management solution to limit the time usage of highly privileged accounts as well as audit the usage of such accounts.

  Create an Azure Active Directory (AAD) privileged access group within Azure Privileged Identity Management (PIM). Azure Active Directory accounts (users and service principals) can be managed with a PIM group. Use these accounts to create and manage the AVS cluster using time-bound, justification-based access.For more information, see [Assign eligible owners and members for privileged access groups - Azure Active Directory](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/groups-assign-member-owner).

  Use Azure AD PIM audit history reports. These reports can include all AVS administrative activities (operations, assignments, etc.). They can be archived in Azure storage for any long-term retention consistent with audit needs. For more information, see [View audit report for privileged
  access group assignments in Privileged Identity Management (PIM) - Azure AD](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/groups-audit).

* **Centralize Identity Management** - Azure VMware Solution provided  administration accounts are visible to all contributors with RBAC access to Azure VMware Solution resources. Lack of multiple targeted identity objects (users, groups, etc.) can result in overuse/abuse of the built-in ***cloudadmin*** user when accessing the VMware control plane.  

  Use the RBAC capabilities within the VMWare control plane to properly manage role and account access using principles of least-privilege.

  Azure VMware Solution provides a ***cloudadmin*** and network ***admin*** credential for configuring the VMware environment. Limit access to the AVS provided cloudadmin and network admin accounts and configure them in a break-glass type configuration. Only use the built-in accounts when all other administration accounts become unusable.

  Using the provided cloudadmin account, integrate Active Directory Domain Services or Azure Active Directory Domain Services with the VMware VCenter and NSX-T control applications and source administrative identities from Domain Services. Use the Domain Services sourced users and/or groups for AVS management and operational activities and do not allow account sharing.

  Create vCenter custom roles and associate them with Active Directory Domain Services groups for fine-grained privileged access control to the VMware control surfaces.

  Azure VMware Solution provides options to rotate/reset vCenter and NSX-T admin account passwords. Configure a regular rotation of these accounts and rotate them any time the break-glass configuration is used. For more information, see [Rotate the cloudadmin credentials for Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/rotate-cloudadmin-credentials).

* **Centralize Guest VMs Identity Management** - Lack of centralized authentication and/or authorization for AVS Guests can contribute to unauthorized access to business data/processes and inefficient application management. AVS guests and applications must be managed as part of their lifecycle.  

  Configure guest VMs to take advantage of a centralized identity management solution when authenticating and authorizing for management and application use.

  Use a centralized Active Directory Domain Services and/or LDAP service for AVS Guest VM and application identity management needs. Ensure that the Domain Services implementation accounts for any outage scenarios within the architecture to ensure continued functionality during outage events. Connect the AD DS implementation with Azure Active Directory for a seamless authentication and authorization experience and for advanced management.

### Environment and Network Security

* **vCenter Access** - Uncontrolled access to AVS vCenter can increase attack surface area.

  Use a dedicated Privileged Access Workstation to securely access AVS vCenter and NSX Manager. Create a user group and add individual user account in that group. Provision access to this user group.

* **Use Azure Native Network Security Capabilities** - Lack of traffic filtering can result in unobstructed traffic between segments. Additionally, lack of compliance against OWASP Core rule set can expose AVS guest web application workloads to generic web attacks. Missing unified firewall rule management can result in duplicate or missing firewall rules increasing risk of unauthorized access. Missing DDoS protection can result in AVS workload exposed to attack resulting in financial loss and/or poor user experience.

  Use a stateful managed firewall architecture that allows for traffic flow, inspection, centralized rule management, and event collection. This will contribute to the larger network management and environment security posture for the Azure VMware Solution.

  Implement guest network traffic filtering devices by using [NSX](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.1/administration/GUID-6AB240DB-949C-4E95-A9A7-4AC6EF5E3036.html) and/or Network Virtual Appliance (NVA) capabilities to limit access between guest network segments appropriately.

  Use the Web Application Firewall (WAF) Open Web Application Security Project (OWASP) capabilities included with Azure Application Gateway to protect web applications hosted on AVS Guests. Enable prevention mode using the latest policy and ensure WAF logs are integrated into your logging strategy. For more information, see [Introduction to Azure Web Application Firewall](https://docs.microsoft.com/azure/web-application-firewall/overview).

  Apply DdoS protection on Azure Virtual Network hosting the ER Gateway used to terminate Azure VMware Solution ER connection. Consider to use Azure Policy for automatic enforcement of DdoS protection.

* **Inbound internet requests auditing for guest workloads** - Missing firewall audit reporting on HTTP and non-HTTP endpoints can result in non-compliance with regulatory standards (SOX, PCI, etc.)  

  Use Azure firewall or an approved NVA that maintains audit logs for incoming requests to guest VMs. Include those logs as an input to your Security Incident and Event Management (SIEM) solution to ensure appropriate monitoring and alerting.

  Use Azure Sentinel for Azure-side processing of event information and logging sourced from Azure before integration into existing SIEM solutions.

* **Outbound Connection Security - Session auditing for outbound internet connectivity** - Lack of rule control or session auditing of outbound internet connectivity from Azure VMware Solution can result in missed opportunities in identifying unexpected/suspicious outbound internet activity.

  Decide when and where to position outbound network inspection to ensure maximum security. Refer to [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-and-connectivity.md) for further guidance.

  Use specialized services (Firewall, NVA, vWAN) for outbound internet connectivity instead of relying on Azure VMware Solution’s default internet connectivity service. Use article on [Inspecting Azure VMware Solution traffic with Network Virtual Appliance in Azure vNet](https://avs.ms/nva/) for design recommendations.

  Use Service Tags and FQDN tags to whitelist egress traffic when performing egress filtering using Azure Firewall or a similar capability if using NVA.

* **Centrally manage and secure backups** - Using RBAC and delayed delete capabilities can help prevent intentional and accidental deletion of backup data that would be needed to recover the environment.

  Use Azure Key Vault for managing encryption keys and restrict access to the backup data storage location to minimize risk of deletion.

  Use Azure Backup or an AVS validated backup solution that provides encryption in transit as well as at rest. When using Azure recovery services vaults, usse resource locks and the soft-delete features to protect against accidental or intentional deletion of backups. Refer to [Enterprise-scale business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md) for additional considerations.

### Guest Application and VM Security

* **Extended Security Update (ESU) Keys** - Missing/misconfigured ESU keys can prevent getting security updates pushed and installed on AVS VMs.

  Use Volume Activation Management Tool for configuring ESU keys for AVS cluster. Use guidance on [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091) for more details.

* **Advanced Threat Detection** - Lack of endpoint security protection, security alert configuration, change control processes, vulnerability assessment, etc. can lead to various security risks and data breaches.

  Use Azure Security Center for threat management, endpoint protection, security alerting, OS patching, and a centralized view into enforcement of regulatory compliance.

  Deploy the Microsoft Monitoring Agent (MMA) on VMware VMs before starting a migration. Configure the MMA agent to send metrics and logs to an Azure Log Analytics Workspace. After the migration is complete, validate that the corresponding AVS VM reports alerts in Azure Monitor and Azure Security Center. For more information, see [see Integrate Azure Security Center with Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/azure-security-integration).

  Use Azure Arc for servers to onboard your guest VM’s.  Once onboarded, take advantage of Azure Log Analytics, Azure Monitor, and Azure Security Center to collect logs and metrics, create dashboards and alerts, and use Security Center’s Defender features to protect and alert on threats associated with VM guests. For more information, see [Integrate and deploy Azure native services in Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/integrate-azure-native-services#onboard-vms-to-azure-arc-enabled-servers).

  Alternatively use a solution capable of providing regulatory compliance against Center for Internet Security (CIS) requirements from an AVS certified Partner to assess security posture for VM Configurations.

* **Security Analytics** - Lack of cohesive security event collection, corelation and analytics from Azure VMware Solution VMs as well as other sources can lead to cyber-attacks going unnoticed/undetected.

  Use Azure Security Center as a data source for Azure Sentinel. Configure Azure Defender for Storage, Resource Manager, DNS and other relevant Azure services applicable in Azure VMware Solution deployment. Consider using a data connector for Azure VMware Solution from an Azure VMware Solution certified Partner.

* **Guest VM Encryption** - Azure VMware Solution provides data at rest encryption for the underlying VSAN storage platform. However, some workloads and environments may require additional encryption to protect data in the cases where filesystem access occurs. In these situations, consider enabling guest VM encryption to provide encryption of the guest OS and data.

  Use the [native guest OS encryption](https://docs.microsoft.com/azure/virtual-machines/windows/disk-encryption-overview#:~:text=Terminology%20%20%20%20Terminology%20%20%20,you%20c%20...%20%201%20more%20rows%20) tools to encrypt guest VMs. Use Azure Key Vault to store and protect the encryption keys.

* **Database Encryption & activity monitoring** - Lack of encryption for SQL and other database on Azure VMware Solution can result in easy access to data in case of a data breach. Lack of monitoring for unusual database activities can increase risk of an insider attack.

  For database workloads, look to encryption at rest methods such as Transparent Data Encryption (TDE) or equivalent native database feature. Ensure workloads are using encrypted disks, and that sensitive secrets are stored in a key vault dedicated to that resource group.

  Use native database monitoring (e.g., Activity Monitor) or an Azure VMware Solution certified partner solution. Consider using Azure Database Services for enhanced auditing controls.

  Use Azure Key Vault for customer-managed keys in scenarios where Bring Your Own Key
  (BYOK) is appropriate(e.g. [BYOK for Azure SQL TDE](https://docs.microsoft.com/azure/azure-sql/database/transparent-dataencryption-byok-overview)). Implement separation of duties for key management and data management where possible.

* **Code Security** - Lack of security considerations in DevOps workflow can introduce security vulnerabilities in Azure VMware Solution workloads.

  Use [GitHub Enterprise Server on Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/configure-github-enterprise-server) to have a versioned repository ensuring the integrity of the codebase. Run build/run agents either in AVS or in a secure Azure environment. Use modern authentication/authorization workflows such as OAuth/OIDC for Azure VMware Solution workloads.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of Azure VMware Solution.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for Azure VMware Solution.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.

