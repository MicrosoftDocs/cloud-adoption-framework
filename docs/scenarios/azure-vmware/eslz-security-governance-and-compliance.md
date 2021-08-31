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

* **Limit Permanent Access** - Azure VMware Solution makes use of the contributor role at Azure resource group scope which hosts the Azure VMware Solution private cloud. A standing permanent access may result in intentional or unintentional contributor rights abuse.  

   Use a privileged account management solution to limit the time usage of highly privileged accounts as well as audit the usage of such accounts.

   Create an Azure Active Directory (AAD) privileged access group within Azure Privileged Identity Management (PIM). Azure Active Directory accounts (users and service principals) can be managed with a PIM group. Use these accounts to create and manage the Azure VMware Solution cluster using time-bound, justification-based access.For more information, see [Assign eligible owners and members for privileged access groups - Azure Active Directory](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/groups-assign-member-owner).

   Use Azure AD PIM audit history reports. These reports can include all Azure VMware Solution administrative activities (operations, assignments, etc.). They can be archived in Azure storage for any long-term retention consistent with audit needs. For more information, see [View audit report for privileged
   access group assignments in Privileged Identity Management (PIM) - Azure AD](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/groups-audit).

* **Centralize Identity Management** - Azure VMware Solution provided  administration accounts are visible to all contributors with RBAC access to Azure VMware Solution resources. Lack of multiple targeted identity objects (users, groups, etc.) can result in overuse/abuse of the built-in ***cloudadmin*** user when accessing the VMware control plane.  

   Use the RBAC capabilities within the VMWare control plane to properly manage role and account access using principles of least-privilege.

   Azure VMware Solution provides a ***cloudadmin*** and network ***admin*** credential for configuring the VMware environment. Limit access to the Azure VMware Solution provided cloudadmin and network admin accounts and configure them in a break-glass type configuration. Only use the built-in accounts when all other administration accounts become unusable.

   Using the provided cloudadmin account, integrate Active Directory Domain Services or Azure Active Directory Domain Services with the VMware VCenter and NSX-T control applications and source administrative identities from Domain Services. Use the Domain Services sourced users and/or groups for Azure VMware Solution management and operational activities and do not allow account sharing.

   Create vCenter custom roles and associate them with Active Directory Domain Services groups for fine-grained privileged access control to the VMware control surfaces.

   Azure VMware Solution provides options to rotate/reset vCenter and NSX-T admin account passwords. Configure a regular rotation of these accounts and rotate them any time the break-glass configuration is used. For more information, see [Rotate the cloudadmin credentials for Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/rotate-cloudadmin-credentials).

* **Centralize Guest VMs Identity Management** - Lack of centralized authentication and/or authorization for Azure VMware Solution Guests can contribute to unauthorized access to business data/processes and inefficient application management. Azure VMware Solution guests and applications must be managed as part of their lifecycle.  

   Configure guest VMs to take advantage of a centralized identity management solution when authenticating and authorizing for management and application use.

   Use a centralized Active Directory Domain Services and/or LDAP service for Azure VMware Solution Guest VM and application identity management needs. Ensure that the Domain Services implementation accounts for any outage scenarios within the architecture to ensure continued functionality during outage events. Connect the AD DS implementation with Azure Active Directory for a seamless authentication and authorization experience and for advanced management.

### Environment and Network Security

* **vCenter Access** - Uncontrolled access to Azure VMware Solution vCenter can increase attack surface area.

   Use a dedicated Privileged Access Workstation to securely access Azure VMware Solution vCenter and NSX Manager. Create a user group and add individual user account in that group. Provision access to this user group.

* **Use Azure Native Network Security Capabilities** - Lack of traffic filtering can result in unobstructed traffic between segments. Additionally, lack of compliance against OWASP Core rule set can expose Azure VMware Solution guest web application workloads to generic web attacks. Missing unified firewall rule management can result in duplicate or missing firewall rules increasing risk of unauthorized access. Missing DDoS protection can result in Azure VMware Solution workload exposed to attack resulting in financial loss and/or poor user experience.

   Use a stateful managed firewall architecture that allows for traffic flow, inspection, centralized rule management, and event collection. This will contribute to the larger network management and environment security posture for the Azure VMware Solution.

   Implement guest network traffic filtering devices by using [NSX](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.1/administration/GUID-6AB240DB-949C-4E95-A9A7-4AC6EF5E3036.html) and/or Network Virtual Appliance (NVA) capabilities to limit access between guest network segments appropriately.

   Use the Web Application Firewall (WAF) Open Web Application Security Project (OWASP) capabilities included with Azure Application Gateway to protect web applications hosted on Azure VMware Solution Guests. Enable prevention mode using the latest policy and ensure WAF logs are integrated into your logging strategy. For more information, see [Introduction to Azure Web Application Firewall](https://docs.microsoft.com/azure/web-application-firewall/overview).

   Apply DdoS protection on Azure Virtual Network hosting the ER Gateway used to terminate Azure VMware Solution ER connection. Consider to use Azure Policy for automatic enforcement of DdoS protection.

* **Inbound internet requests auditing for guest workloads** - Missing firewall audit reporting on HTTP and non-HTTP endpoints can result in non-compliance with regulatory standards (SOX, PCI, etc.)  

   Use Azure firewall or an approved NVA that maintains audit logs for incoming requests to guest VMs. Include those logs as an input to your Security Incident and Event Management (SIEM) solution to ensure appropriate monitoring and alerting.

   Use Azure Sentinel for Azure-side processing of event information and logging sourced from Azure before integration into existing SIEM solutions. Refer to guidance available on [Integrate Azure Security Center with Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/azure-security-integration).

* **Outbound Connection Security - Session auditing for outbound internet connectivity** - Lack of rule control or session auditing of outbound internet connectivity from Azure VMware Solution can result in missed opportunities in identifying unexpected/suspicious outbound internet activity.

   Decide when and where to position outbound network inspection to ensure maximum security. Refer to [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-and-connectivity.md) for further guidance.

   Use specialized services (Firewall, NVA, vWAN) for outbound internet connectivity instead of relying on Azure VMware Solution’s default internet connectivity service. Use article on [Inspecting Azure VMware Solution traffic with Network Virtual Appliance in Azure vNet](https://avs.ms/nva/) for design recommendations.

   Use Service Tags such as `Virtual Network` and FQDN tags to whitelist egress traffic when performing egress filtering using Azure Firewall or a similar capability if using NVA.

* **Centrally manage and secure backups** - Using RBAC and delayed delete capabilities can help prevent intentional and accidental deletion of backup data that would be needed to recover the environment.

   Use Azure Key Vault for managing encryption keys and restrict access to the backup data storage location to minimize risk of deletion.

   Use Azure Backup or an Azure VMware Solution validated backup solution that provides encryption in transit as well as at rest. When using Azure recovery services vaults, usse resource locks and the soft-delete features to protect against accidental or intentional deletion of backups. Refer to [Enterprise-scale business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md) for additional considerations.

### Guest Application and VM Security

* **Extended Security Update (ESU) Keys** - Missing/misconfigured ESU keys can prevent getting security updates pushed and installed on Azure VMware Solution VMs.

   Use Volume Activation Management Tool for configuring ESU keys for Azure VMware Solution cluster. Use guidance on [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091) for more details.

* **Advanced Threat Detection** - Lack of endpoint security protection, security alert configuration, change control processes, vulnerability assessment, etc. can lead to various security risks and data breaches.

   Use Azure Security Center for threat management, endpoint protection, security alerting, OS patching, and a centralized view into enforcement of regulatory compliance.

   Deploy the Microsoft Monitoring Agent (MMA) on VMware VMs before starting a migration. Configure the MMA agent to send metrics and logs to an Azure Log Analytics Workspace. After the migration is complete, validate that the corresponding Azure VMware Solution VM reports alerts in Azure Monitor and Azure Security Center. For more information, see [see Integrate Azure Security Center with Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/azure-security-integration).

   Use Azure Arc for servers to onboard your guest VM’s.  Once onboarded, take advantage of Azure Log Analytics, Azure Monitor, and Azure Security Center to collect logs and metrics, create dashboards and alerts, and use Security Center’s Defender features to protect and alert on threats associated with VM guests. For more information, see [Integrate and deploy Azure native services in Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/integrate-azure-native-services#onboard-vms-to-azure-arc-enabled-servers).

   Alternatively use a solution capable of providing regulatory compliance against Center for Internet Security (CIS) requirements from an Azure VMware Solution certified Partner to assess security posture for VM Configurations.

* **Security Analytics** - Lack of cohesive security event collection, corelation and analytics from Azure VMware Solution VMs as well as other sources can lead to cyber-attacks going unnoticed/undetected.

   Use Azure Security Center as a data source for Azure Sentinel. Configure Azure Defender for Storage, Resource Manager, DNS and other relevant Azure services applicable in Azure VMware Solution deployment. Consider using a data connector for Azure VMware Solution from an Azure VMware Solution certified Partner.

* **Guest VM Encryption** - Azure VMware Solution provides data at rest encryption for the underlying VSAN storage platform. However, some workloads and environments may require additional encryption to protect data in the cases where filesystem access occurs. In these situations, consider enabling guest VM encryption to provide encryption of the guest OS and data.

   Use the [native guest OS encryption](https://docs.microsoft.com/azure/virtual-machines/windows/disk-encryption-overview#:~:text=Terminology%20%20%20%20Terminology%20%20%20,you%20c%20...%20%201%20more%20rows%20) tools to encrypt guest VMs. Use Azure Key Vault to store and protect the encryption keys.

* **Database Encryption & activity monitoring** - Lack of encryption for SQL and other database on Azure VMware Solution can result in easy access to data in case of a data breach. Lack of monitoring for unusual database activities can increase risk of an insider attack.

   For database workloads, look to encryption at rest methods such as Transparent Data Encryption (TDE) or equivalent native database feature. Ensure workloads are using encrypted disks, and that sensitive secrets are stored in a key vault dedicated to that resource group.

   Use native database monitoring (e.g., Activity Monitor) or an Azure VMware Solution certified partner solution. Consider using Azure Database Services for enhanced auditing controls.

   Use Azure Key Vault for customer-managed keys in scenarios where Bring Your Own Key
   (BYOK) is appropriate(e.g. [BYOK for Azure SQL TDE](https://docs.microsoft.com/azure/azure-sql/database/transparent-dataencryption-byok-overview)). Refer to this [guidance](https://docs.microsoft.com/sql/connect/ado-net/sql/azure-key-vault-enclave-example?view=sql-server-ver15) on how SQL Server 2019 uses Azure Key Vault provider. Implement separation of duties for key management and data management where possible. 

* **Code Security** - Lack of security considerations in DevOps workflow can introduce security vulnerabilities in Azure VMware Solution workloads.

   Use [GitHub Enterprise Server on Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/configure-github-enterprise-server) to have a versioned repository ensuring the integrity of the codebase. Run build/run agents either in Azure VMware Solution or in a secure Azure environment. Use modern authentication/authorization workflows such as OAuth/OIDC for Azure VMware Solution workloads.

## Governance

Consider and implement the following recommendations when planning for environment and guest VM governance.

### Environment Governance

* **FTT (Failure to Tolerate) governance** - Maintaining FTT setting commensurate to the cluster size is needed for maintaining [SLA for Azure VMware Solution](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/).  

   Adjust the vSAN [storage policy](https://docs.microsoft.com/azure/azure-vmware/concepts-storage#storage-policies-and-fault-tolerance) to the appropriate FTT setting when changing the cluster size to ensure SLA compliance.

* **Network governance** - Inability to monitor internal network traffic can lead to malicious or unknown traffic and/or compromised networks.  

   Implement vRealize Network Insights (VRNI) and VRealize Operations Manager for detailed insights into the Azure VMware Solution networking operations.

* **vSAN slack storage space governance** - Insufficient vSAN storage space can impact SLA guarantees.  

   Review and understand customer/partner responsibilities as documented in the [SLA for Azure VMware Solution documentation](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/). Assign appropriate priorities and owners for alerts on “Percentage Datastore Disk Used” metric. For more information and guidance, see [Configure alerts and work with metrics in Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/configure-alerts-for-azure-vmware-solution).

* **VM templates Storage policy governance** - Default thick-provisioned storage policy can result in reserving high amounts of vSAN storage.  

   Create VM templates that use a thin-provisioned storage policy where space reservations are not required. This creates VMs that do not reserve the full amount of storage upfront and allow for more efficient storage resources.

* **ESXI config governance** - Access to Azure VMware Solution ESXi hosts is limited and can result in 3rd party software not working if access is required.

   Identify any Azure VMware Solution-supported 3rd party software running in the source environment that needs access to the ESXi host. Become familiar with and use the process of [raising a support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) for Azure VMware Solution from the Azure portal for situations where access to the ESXi host is required.

* **Alerts for security, planned maintenance, and service health governance** - Limited understanding and visibility of service health can result in the inability to plan and/or respond to outages and issues appropriately.

   Configure [Service Health Alerts](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/serviceIssues) for Azure VMware Solution service issues, planned maintenance, health advisories, and security advisories. Schedule and plan Azure VMware Solution workload activities outside of maintenance window suggested by Microsoft.

* **Host quota governance** - Insufficient host quota can lead to longer delays (5-7 days) in procuring any additional host capacity needed for growth and/or Disaster Recovery (DR) requirements.

   Factor growth and DR requirements into the solution design when requesting the host quota and periodically review environment growth and maximums to ensure proper lead time for expansion requests. E.g., If an Azure VMware Solution cluster of 3 nodes needs an additional 3 nodes for DR purposes then a host quota of 6 nodes should be requested. Host quota doesn’t incur extra costs.

* **Cost governance** - Inability to monitor costs can lead to poor financial accountability and budget allocation.

   Use a cost management solution for cost tracking, cost allocation, budget creation, cost alerts, and improved financial governance. For Azure billed charges, Use [Azure Cost Management](https://docs.microsoft.com/azure/cost-management-billing/cost-management-billing-overview) tools to create budgets, generate alerts, allocate costs, and produce reports for financial stakeholders.

* **ESXi hosts density/efficiency** - Inability to understand utilization of ESXi hosts can result in a poor Return on Investment (ROI.

   Define a healthy density of guest VMs to maximize Azure VMware Solution investments and then monitor the overall utilization of nodes against that threshold. Resize the Azure VMware Solution environment when indicated by the monitoring and allowing sufficient lead time for node additions.

* **Azure services integration governance** - Using the public endpoint of the Azure PaaS service can lead to traffic leaving the desired network boundaries.

   Access Azure services (SQL Database, Azure Blob, etc.) using a private endpoint to ensure that traffic remains within a defined virtual network boundary.

### Guest Application and VM Governance

* **Guest VM’s security posture governance** - Lack of security compliance awareness for Azure VMware Solution guest VMs makes it difficult to understand cybersecurity readiness and response, leading to gaps in security coverage for Azure VMware Solution guest VMs and applications.

   Enable [Azure Defender](https://docs.microsoft.com/azure/security-center/azure-defender) features in Azure Security Center associated with running Azure services and Azure VMware Solution guest VM workloads and use Azure Security Center’s regulatory compliance view to monitor compliance against security and regulatory benchmarks. Configure Azure Security Center’s workflow automation for tracking any deviation against the expected compliance posture. For more information, see [Azure Arc enabled servers Overview](https://docs.microsoft.com/azure/azure-arc/servers/overview).

* **DR governance** - Lack of Disaster Recovery (DR) orchestration can result in unexpected delays in ensuring business continuity during DR events. Undocumented RPO and RTO requirements can result in poor customer experiences and unmet operational goals during DR and Business Continuity (BC) events. 

   Use a DR solution for Azure VMware Solution, which provides DR orchestration capabilities while also providing the ability to detect and report on any failure and/or issues in the successful continuous replication to a DR site. Document RPO/RTO requirements for applications running in Azure and Azure VMware Solution. Choose a [Disaster Recovery and Business Continuity solution](./eslz-business-continuity-and-disaster-recovery.md) design to meet verifiable RPO/RTO requirements through orchestration.

* **Backup governance** - Inability to schedule regular backups can result in missed backups or reliance on old backups, leading to data loss.

   Use a backup solution that can take scheduled backups and can monitor the success of backups. Monitor and alert on backup events to ensure scheduled backups run successfully.

* **Logging governance** - Lack of log collection and querying capability can result in a poor debugging and troubleshooting experience leading to extended response times.

   Enable [VM insights](https://docs.microsoft.com/azure/azure-monitor/vm/vminsights-overview) on Azure VMware Solution guest VMs.
  
   Configure [log alerts](https://docs.microsoft.com/azure/azure-monitor/alerts/alerts-log) to capture boundary conditions for guest VMs.

* **Domain governance** - Inability to auto-join Azure VMware Solution VMs can result in manual and error-prone processes.

   Use Extensions such as [JsonADDomainExtension](https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-domain-join-existing/azuredeploy.json) or equivalent automation options to enable Azure VMware Solution guest VMs to auto-join an Active Directory domain.

* **Guest VM Governance** - Delayed or incomplete updates and/or patching is one of the top vectors for attack and not having a solution in place to manage the timely installation of updates can result in Azure VMware Solution guest VMs and applications being exposed or compromised. Lack of near real-time insights can lead to undetected or late detection of performance bottlenecks and operational issues, and not having diagnostics metrics and logging enabled on guest VMs can make it difficult to debug guest and application issues.

   Deploy the Microsoft Monitoring Agent (MMA) on VMware guest VMs before migration or when deploying new guest VM’s in the Azure VMware Solution environment.  Configure this agent with an Azure Log Analytics Workspace and [link](https://docs.microsoft.com/azure/automation/how-to/region-mappings) the Azure Log Analytics Workspace with Azure Automation. For any guest VM MMA agents deployed before migration, validate their status after migration in Azure Monitor.

   Use Azure Arc for Servers to enable the ability to manage Azure VMware Solution guest VM’s with tools that replicate the Azure native resource tooling. ([Azure Arc enabled servers Overview](https://docs.microsoft.com/azure/azure-arc/servers/overview) including:

  * Use Azure Policy to govern, report, and audit Guest configurations and settings.
  * Use Azure Automation State Configuration and supported extensions to simplify deployments.
  * Use Update Management to manage updates for Azure VMware Solution guest VM landscape.
  * Use Tags to manage and organize Azure VMware Solution guest VM inventory.

## Compliance

Consider and implement the following recommendations when planning for Azure VMware Solution environment and Guest VM compliance.

### Environment and Guest Compliance

* **Guest VM’s DR compliance** - Not having a working DR configuration compliance tracking for Azure VMware Solution guest VMs can result in the mission-critical applications and workloads running on those VMs remaining unavailable during a disaster.

   Use Azure Site Recovery or an Azure VMware Solution certified BCDR solution, which provides at-scale replication provisioning, non-compliance status monitoring, and automatic remediation functionality.

* **Guest VM’s backup compliance** - Lack of compliance tracking and monitoring for guest VM backups in a large Azure VMware Solution VM estate can result in Azure VMware Solution VMs not being backed up.

   Use an [Azure VMware Solution certified Partner solution](https://docs.microsoft.com/azure/azure-vmware/ecosystem-back-up-vms) which provides at-scale perspective, drill-down analysis and actionable interface for tracking/monitoring guest VM backup.

* **Country and/or industry-specific regulatory compliance** - Missing or incomplete compliance for of Azure VMware Solution guest workloads against country and/or industry-specific regulations can result in costly legal actions and fines.

   Understand the [shared responsibility](https://azure.microsoft.com/resources/shared-responsibility-for-cloud-computing/) model in the cloud for industry and/or region-based regulatory compliance. Use the [Service Trust Portal](https://servicetrust.microsoft.com/ViewPage/MSComplianceGuideV3) to view and/or download Azure VMware Solution and Azure Audit reports supporting the whole compliance story.

   Enable the [Azure Defender](https://docs.microsoft.com/azure/security-center/azure-defender) features of Azure Security Center for any consumed Azure services that support Defender and any applicable Azure VMware Solution guest VM workloads.  

   Use Azure Security Center’s regulatory compliance view to monitor compliance against security and regulatory benchmarks and configure Azure Security Center’s workflow automation for tracking any deviation against the expected compliance posture. For more information, see the [Azure Security Center documentation](https://docs.microsoft.com/azure/security-center/security-center-introduction).  

* **Corporate policy compliance** - Lack of compliance monitoring of Azure VMware Solution guest workloads against corporate policies can result in a breach of company rules and regulations.

   Use [Azure Arc for Servers](https://docs.microsoft.com/azure/azure-arc/servers/overview) and Azure Policy or an equivalent third-party solution to routinely assess and manage regulatory compliance for Azure VMware Solution guest VMs and applications against applicable internal and external regulations.

* **Data Retention/Residency requirements** - Azure VMware Solution does not currently support retention or extraction of data stored in clusters. Once cluster is deleted, the data cannot be recovered as it terminates all running workloads, components, and destroys all cluster data and configuration settings, including public IP addresses.

   Azure VMware Solution does not currently guarantee that all metadata and configuration data for running the service will exist only in the deployed geographical region. If this is required to meet your data residency requirements, please reach out to Azure VMware Solution support so that Microsoft can assist with your needs.

* **Data Processing** - Read and understand the legal terms at the time of sign-up. Pay attention to [VMware Data Processing Agreement for Microsoft Azure VMware Solution Customers Transferred for L3 Support](https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/privacy/vmware-data-processing-agreement.pdf). 

   Any support issue that may need VMware support, professional service data along with associated personal data will be shared with VMware. From that point onwards, Microsoft and VMware become two independent processors of data.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for Azure VMware Solution.

- [Enterprise-scale Design Principles](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/design-principles)
- [Enterprise-scale Design Guidelines](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/design-guidelines)

## Additional considerations

Refer to following guidance available for more critical design areas.

- [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
- [Enterprise-scale management and monitoring for Azure VMware Solution](./eslz-management-and-monitoring.md)
- [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-and-connectivity.md)
- [Enterprise-scale platform automation and DevOps for Azure VMware Solution](./eslz-platform-automation-and-devops.md)
- [Enterprise-scale business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md)
