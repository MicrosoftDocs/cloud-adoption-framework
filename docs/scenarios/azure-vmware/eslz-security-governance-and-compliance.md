---
title: Security, governance, and compliance disciplines for Azure VMware Solution
description: Understand security, governance, and compliance considerations for Azure VMware Solution, and design recommendations and best practices to mitigate risks.
author: Mahesh-MSFT
ms.author: janet
ms.date: 09/17/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avs
---

# Security, governance, and compliance disciplines for Azure VMware Solution

This article describes how to implement a secure Azure VMware Solution and holistically govern the solution throughout its life cycle. The article explores specific design elements and provides targeted recommendations for Azure VMware Solution security, governance, and compliance design.

## Security

Consider the following factors when deciding which systems, users, or devices can perform functions within Azure VMware Solution, and how to secure the overall platform.

### Identity security

- **Permanent access limits.** Azure VMware Solution uses the contributor role in the Azure resource group that hosts the Azure VMware Solution private cloud. Limit permanent access to prevent intentional or unintentional contributor rights abuse. Use a privileged account management solution to audit and limit the time usage of highly privileged accounts.

  Create an Azure Active Directory (Azure AD) privileged access group within Azure Privileged Identity Management (PIM). You can manage Azure AD user and service principal accounts with a PIM group. Use these accounts to create and manage the Azure VMware Solution cluster with time-bound, justification-based access. For more information, see [Assign eligible owners and members for privileged access groups](/azure/active-directory/privileged-identity-management/groups-assign-member-owner).

  Use Azure AD PIM audit history reports. These reports include Azure VMware Solution administrative activities, operations, and assignments. You can archive the reports in Azure Storage for long-term audit retention needs. For more information, see [View audit report for privileged access group assignments in Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/groups-audit).

- **Centralized identity management.** Azure VMware Solution-provided administrative accounts are visible to all contributors that have role-based access control (RBAC) access to Azure VMware Solution. To prevent overuse or abuse of the built-in *CloudAdmin* user when accessing the VMware control plane, create multiple targeted identity objects like users and groups. Use the RBAC capabilities within the VMware control plane to properly manage role and account access using least-privilege principles.

  Azure VMware Solution provides cloud administrator and network administrator credentials for configuring the VMware environment. Limit access to the Azure VMware Solution-provided CloudAdmin and network administrator accounts, and configure the accounts in a break-glass configuration. Use the built-in accounts only when all other administrative accounts are unusable.

  Use the provided CloudAdmin account to integrate Active Directory Domain Services (AD DS) or Azure AD Domain Services (Azure AD DS) with the VMware vCenter and NSX-T control applications and domain services source administrative identities. Use the domain services-sourced users and groups for Azure VMware Solution management and operations, and don't allow account sharing. Create vCenter custom roles and associate them with AD DS groups for fine-grained privileged access control to VMware control surfaces.

  Azure VMware Solution provides options to rotate and reset vCenter and NSX-T administrative account passwords. Configure a regular rotation of these accounts, and rotate the accounts anytime you use the break-glass configuration. For more information, see [Rotate the cloud admin credentials for Azure VMware Solution](/azure/azure-vmware/rotate-cloudadmin-credentials).

- **Guest virtual machine (VM) identity management.** Provide centralized authentication and authorization for Azure VMware Solution guests to prevent unauthorized access to business data and processes and inefficient application management. Manage Azure VMware Solution guests and applications as part of their life cycle. Configure guest VMs to use a centralized identity management solution when authenticating and authorizing for management and application use.

  Use a centralized AD DS or Lightweight Directory Access Protocol (LDAP) service for Azure VMware Solution guest VMs and application identity management. Be sure the domain services architecture accounts for any outage scenarios, to ensure continued functionality during outages. Connect the AD DS implementation with Azure AD for a seamless authentication and authorization experience and for advanced management.

### Environment and network security

- **Controlled vCenter access.** Uncontrolled access to the Azure VMware Solution vCenter can increase attack surface area. Use a dedicated Privileged Access Workstation (PAW) to securely access Azure VMware Solution vCenter and NSX Manager. Create a user group and add individual user account to that group. Provision access to this user group.

- **Azure native network security capabilities.** Provide traffic filtering to control traffic between segments. Comply with the Open Web Application Security Project (OWASP) core rule set to protect Azure VMware Solution guest web application workloads from generic web attacks. Implement unified firewall rule management to prevent duplicate or missing firewall rules from increasing the risk of unauthorized access. Implement distributed denial of service (DDoS) protection to protect Azure VMware Solution workloads from attacks that cause financial loss or poor user experience.

  Use a stateful managed firewall architecture that allows for traffic flow, inspection, centralized rule management, and event collection. The firewall architecture contributes to the larger network management and environment security posture for Azure VMware Solution.

  Implement guest network traffic filtering devices by using [NSX](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.1/administration/GUID-6AB240DB-949C-4E95-A9A7-4AC6EF5E3036.html) or network virtual appliance (NVA) capabilities to limit access between guest network segments.

  Use the Web Application Firewall (WAF) OWASP capabilities of Azure Application Gateway to protect web applications hosted on Azure VMware Solution guests. Enable prevention mode using the latest policy, and make sure to integrate WAF logs into your logging strategy. For more information, see [Introduction to Azure Web Application Firewall](/azure/web-application-firewall/overview).

  Apply DDoS protection on the Azure virtual network that hosts the ExpressRoute termination gateway for the Azure VMware Solution connection. Consider using Azure Policy for automatic enforcement of DDoS protection.

- **Inbound internet requests for guest workloads.** Implement firewall audit reporting on HTTP(s) and non-HTTP(s) endpoints to comply with regulatory requirements like Sarbanes-Oxley (SOX) and Payment Card Industry (PCI) standards.

  Use Azure Firewall or an approved NVA that maintains audit logs for incoming requests to guest VMs. Import those logs into your Security Incident and Event Management (SIEM) solution for appropriate monitoring and alerting. Use Azure Sentinel to process Azure event information and logging before integration into existing SIEM solutions. For more information, see [Integrate Azure Security Center with Azure VMware Solution](/azure/azure-vmware/azure-security-integration).

- **Session monitoring for outbound internet connection security.** Use rule control or session auditing of outbound internet connectivity from Azure VMware Solution to identify unexpected or suspicious outbound internet activity. Decide when and where to position outbound network inspection to ensure maximum security. For more information, see [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md).

  Use specialized firewall, NVA, and virtual wide-area network (vWAN) services for outbound internet connectivity instead of relying on Azure VMware Solution's default internet connectivity. For more information and design recommendations, see [Inspecting Azure VMware Solution traffic with Network Virtual Appliance in Azure vNet](https://avs.ms/nva/).

  Use Service Tags like `Virtual Network` and fully qualified domain name (FQDN) tags for identification when filtering egress traffic with Azure Firewall. Use a similar capability for other NVAs.

- **Centrally managed and secure backups.** Use RBAC and delayed delete capabilities to help prevent intentional or accidental deletion of backup data needed to recover the environment. Use Azure Key Vault for managing encryption keys, and restrict access to the backup data storage location to minimize risk of deletion.

  Use Azure Backup or an Azure VMware Solution-validated backup solution that provides encryption in transit and at rest. When using Azure Recovery Services vaults, use resource locks and the soft-delete features to protect against accidental or intentional backup deletion. For more information, see [Enterprise-scale business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md).

### Guest application and VM security

- **Extended Security Update (ESU) keys.** Provide and configure ESU keys to push and install security updates on Azure VMware Solution VMs. Use the Volume Activation Management Tool for configuring ESU keys for the Azure VMware Solution cluster. For more information, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091).

- **Advanced threat detection.** To prevent various security risks and data breaches, use endpoint security protection, security alert configuration, change control processes, and vulnerability assessments.

  Use Azure Security Center for threat management, endpoint protection, security alerting, OS patching, and a centralized view into regulatory compliance enforcement.

  Deploy the Microsoft Monitoring Agent (MMA) on VMware VMs before starting a migration. Configure the MMA agent to send metrics and logs to an Azure Log Analytics workspace. After the migration, verify that the Azure VMware Solution VM reports alerts in Azure Monitor and Azure Security Center. For more information, see [see Integrate Azure Security Center with Azure VMware Solution](/azure/azure-vmware/azure-security-integration).

  Use Azure Arc for servers to onboard your guest VMs.  Once onboarded, use Azure Log Analytics, Azure Monitor, and Azure Security Center to collect logs and metrics and create dashboards and alerts. Use Security Center Defender to protect and alert on threats associated with VM guests. For more information, see [Integrate and deploy Azure native services in Azure VMware Solution](/azure/azure-vmware/integrate-azure-native-services#onboard-vms-to-azure-arc-enabled-servers).

  Alternatively, use a solution from an Azure VMware Solution certified partner to assess VM security postures and provide regulatory compliance against Center for Internet Security (CIS) requirements.

- **Security analytics.** Use cohesive security event collection, correlation, and analytics from Azure VMware Solution VMs and other sources to detect cyberattacks.

  Use Azure Security Center as a data source for Azure Sentinel. Configure Azure Defender for Storage, Azure Resource Manager, Domain Name System (DNS), and other Azure services applicable to Azure VMware Solution deployment. Consider using an Azure VMware Solution data connector from an Azure VMware Solution certified partner.

- **Guest VM encryption.** Azure VMware Solution provides data-at-rest encryption for the underlying vSAN storage platform. Some workloads and environments with file system access might require more encryption to protect data. In these situations, consider enabling encryption of the guest VM operating system (OS) and data.

  Use the [native guest OS encryption](/azure/virtual-machines/windows/disk-encryption-overview) tools to encrypt guest VMs. Use Azure Key Vault to store and protect the encryption keys.

- **Database encryption and activity monitoring.** Implement encryption for SQL and other databases in Azure VMware Solution to prevent easy data access in case of a data breach. Monitor for unusual database activities to reduce the risk of an insider attack.

  For database workloads, use encryption-at-rest methods such as Transparent Data Encryption (TDE) or an equivalent native database feature. Ensure workloads are using encrypted disks, and that sensitive secrets are stored in a key vault dedicated to the resource group.

  Use native database monitoring like Activity Monitor or an Azure VMware Solution certified partner solution. Consider using Azure database services for enhanced auditing controls.

  Use Azure Key Vault for customer-managed keys in Bring Your Own Key (BYOK) scenarios, such as [BYOK for Azure SQL TDE](/azure/azure-sql/database/transparent-dataencryption-byok-overview). For an example of how SQL Server 2019 uses Key Vault, see [Use Azure Key Vault with Always Encrypted with secure enclaves](/sql/connect/ado-net/sql/azure-key-vault-enclave-example). Separate key management and data management duties where possible. 

- **Code security.** Implement security measure in DevOps workflows to prevent security vulnerabilities in Azure VMware Solution workloads. Use [GitHub Enterprise Server on Azure VMware Solution](/azure/azure-vmware/configure-github-enterprise-server) for a versioned repository that ensures the integrity of the code base. Deploy build and run agents either in Azure VMware Solution or in a secure Azure environment. Use modern authentication and authorization workflows such as Open Authorization (OAuth) and OpenID Connect (OIDC) for Azure VMware Solution workloads.

## Governance

Consider and implement the following recommendations when planning for environment and guest VM governance.

### Environment governance

- **Failure to Tolerate (FTT) governance.** Establish FTT settings commensurate to the cluster size to maintain the [SLA for Azure VMware Solution](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/). Adjust the vSAN [storage policy](/azure/azure-vmware/concepts-storage#storage-policies-and-fault-tolerance) to the appropriate FTT setting when changing the cluster size to ensure SLA compliance.

- **Network governance.** Monitor internal network traffic for malicious or unknown traffic or compromised networks. Implement vRealize Network Insights (VRNI) and VRealize Operations Manager for detailed insights into Azure VMware Solution networking operations.

- **vSAN slack storage space governance.** Insufficient vSAN storage space can impact SLA guarantees. Review and understand customer and partner responsibilities in the [SLA for Azure VMware Solution documentation](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/). Assign appropriate priorities and owners for alerts on the Percentage Datastore Disk Used metric. For more information and guidance, see [Configure alerts and work with metrics in Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution).

- **VM templates Storage policy governance.** A default thick-provisioned storage policy can result in reserving too much vSAN storage. Create VM templates that use a thin-provisioned storage policy where space reservations aren't required. VMs that don't reserve the full amount of storage upfront can allow for more efficient storage resources.

- **ESXI config governance.** Access to Azure VMware Solution ESXi hosts is limited. Third-party software that requires ESXi host access might not work. Identify any Azure VMware Solution-supported third-party software in the source environment that needs access to the ESXi host. Become familiar with and use Azure VMware Solution [support request process](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) in the Azure portal for situations that require ESXi host access.

- **Security, planned maintenance, and service health governance alerts.** Understand and view service health to plan and respond to outages and issues appropriately. Configure [Service Health Alerts](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/serviceIssues) for Azure VMware Solution service issues, planned maintenance, health advisories, and security advisories. Schedule and plan Azure VMware Solution workload activities outside of Microsoft-suggested maintenance windows.

- **Host quota governance.** Insufficient host quotas can lead to 5-7 day delays in getting more host capacity for growth or disaster recovery (DR) needs. Factor growth and DR requirements into solution design when requesting the host quota, and periodically review environment growth and maximums to ensure proper lead time for expansion requests. For example, if a three-node Azure VMware Solution cluster needs another three nodes for DR, request a host quota of six nodes. Host quota doesn't incur extra costs.

- **Cost governance.** Monitor costs for good financial accountability and budget allocation. Use a cost management solution for cost tracking, cost allocation, budget creation, cost alerts, and good financial governance. For Azure billed charges, use [Azure Cost Management](/azure/cost-management-billing/cost-management-billing-overview) tools to create budgets, generate alerts, allocate costs, and produce reports for financial stakeholders.

- **ESXi hosts density/efficiency.** For a good Return on Investment (ROI), understand ESXi host utilization. Define a healthy density of guest VMs to maximize Azure VMware Solution investments, and monitor overall node utilization against that threshold. Resize the Azure VMware Solution environment when monitoring indicates, and allow sufficient lead time for node additions.

- **Azure services integration governance** Avoid using the public endpoint of the Azure PaaS service, which can lead to traffic leaving the desired network boundaries. To ensure that traffic remains within a defined virtual network boundary, use a private endpoint to access Azure services like Azure SQL Database and Azure Blob Storage.

### Guest application and VM governance

- **Guest VM security posture governance**. Security compliance awareness for Azure VMware Solution guest VMs helps you understand cybersecurity readiness and response and provide complete security coverage for Azure VMware Solution guest VMs and applications. Enable [Azure Defender](/azure/security-center/azure-defender) in Azure Security Center for running Azure services and Azure VMware Solution guest VM workloads. Use Security Center's regulatory compliance view to monitor compliance against security and regulatory benchmarks. Use Azure Security Center workflow automation for tracking any deviation against the expected compliance posture. For more information, see [Azure Arc enabled servers overview](/azure/azure-arc/servers/overview).

- **DR governance**. Implement DR orchestration to prevent delays in business continuity during DR events. Undocumented Recovery Point Objective (RPO) and Recovery Time Objective (RTO) requirements can cause poor customer experiences and unmet operational goals during Business Continuity and Disaster Recovery (BCDR) events. 

  Use a DR solution for Azure VMware Solution that provides DR orchestration, and detects and reports on any failure or issues with successful continuous replication to a DR site. Document RPO and RTO requirements for applications running in Azure and Azure VMware Solution. Choose a [Disaster Recovery and Business Continuity solution](./eslz-business-continuity-and-disaster-recovery.md) design to meet verifiable RPO and RTO requirements through orchestration.

- **Backup governance**. Schedule regular backups to prevent missed backups or reliance on old backups that can lead to data loss. Use a backup solution that can take scheduled backups and monitor backup success. Monitor and alert on backup events to ensure scheduled backups run successfully.

- **Logging governance**. Implement log collection and querying capabilities that provide a debugging and troubleshooting experience with a quick response times. Enable [VM insights](/azure/azure-monitor/vm/vminsights-overview) on Azure VMware Solution guest VMs. Configure [log alerts](/azure/azure-monitor/alerts/alerts-log) to capture boundary conditions for guest VMs.

- **Domain governance**. Autojoin Azure VMware Solution VMs to avoid error-prone manual processes. Use extensions like the [JsonADDomainExtension](https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-domain-join-existing/azuredeploy.json) or equivalent automation options to enable Azure VMware Solution guest VMs to autojoin an Active Directory domain.

- **Guest VM governance**. Have a solution in place to manage the timely update installation. Delayed or incomplete updates or patching are top attack vectors, and can result in Azure VMware Solution guest VMs and applications being exposed or compromised. Implement near real-time insights for prompt detection of performance bottlenecks and operational issues. Enable diagnostics metrics and logging on guest VMs to more easily debug guest and application issues.

  Deploy the Microsoft Monitoring Agent (MMA) on VMware guest VMs before migration, or when deploying new guest VMs in the Azure VMware Solution environment. Configure the MMA with an Azure Log Analytics Workspace, and [link the Azure Log Analytics Workspace with Azure Automation](/azure/automation/how-to/region-mappings). Validate the status of any guest VM MMA agents deployed before migration with Azure Monitor after migration.

  Use [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) to manage Azure VMware Solution guest VMs with tools that replicate Azure native resource tooling, including:

  - Azure Policy to govern, report, and audit guest configurations and settings.
  - Azure Automation state configuration and supported extensions to simplify deployments.
  - Update Management to manage updates for the Azure VMware Solution guest VM landscape.
  - Tags to manage and organize Azure VMware Solution guest VM inventory.

## Compliance

Consider and implement the following recommendations when planning for Azure VMware Solution environment and guest VM compliance.

- **Guest VM DR compliance**. DR configuration compliance tracking for Azure VMware Solution guest VMs ensures that mission-critical applications and workloads running on those VMs remain available during a disaster. Use Azure Site Recovery or an Azure VMware Solution certified BCDR solution, which provides at-scale replication provisioning, non-compliance status monitoring, and automatic remediation functionality.

- **Guest VM backup compliance**. Compliance tracking and monitoring for guest VM backups in a large Azure VMware Solution VM estate ensures that Azure VMware Solution VMs are being backed up. Use an [Azure VMware Solution certified Partner solution](/azure/azure-vmware/ecosystem-back-up-vms) that provides at-scale perspective, drill-down analysis, and an actionable interface for tracking and monitoring guest VM backup.

- **Country or industry-specific regulatory compliance**. Ensure Azure VMware Solution guest workload compliance with country and industry-specific regulations to avoid costly legal actions and fines.

   Understand the cloud [shared responsibility](https://azure.microsoft.com/resources/shared-responsibility-for-cloud-computing/) model for industry or region-based regulatory compliance. Use the [Service Trust Portal](https://servicetrust.microsoft.com/ViewPage/MSComplianceGuideV3) to view or download Azure VMware Solution and Azure Audit reports that support the whole compliance story.

   Enable the [Azure Defender](/azure/security-center/azure-defender) features of Azure Security Center for Azure services that support Defender and any applicable Azure VMware Solution guest VM workloads.

   Use Azure Security Center's regulatory compliance view to monitor compliance against security and regulatory benchmarks. Configure Azure Security Center workflow automation for tracking any deviation from the expected compliance posture. For more information, see the [Azure Security Center documentation](/azure/security-center/security-center-introduction).

- **Corporate policy compliance**. Monitor Azure VMware Solution guest workload compliance with corporate policies to prevent breaches of company rules and regulations. Use [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) and Azure Policy or an equivalent third-party solution. Routinely assess and manage Azure VMware Solution guest VMs and applications for regulatory compliance with applicable internal and external regulations.

- **Data retention and residency requirements**. Azure VMware Solution doesn't support retention or extraction of data stored in clusters. Deleting a cluster terminates all running workloads and components, and destroys all cluster data and configuration settings, including public IP addresses. The data can't be recovered.

   Azure VMware Solution doesn't guarantee that all metadata and configuration data for running the service exists only in the deployed geographical region. If your data residency requirements require all data to exist in the deployed region, contact Azure VMware Solution support for assistance.

- **Data processing**. Read and understand the legal terms when you sign up. Pay attention to the [VMware Data Processing Agreement for Microsoft Azure VMware Solution Customers Transferred for L3 Support](https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/privacy/vmware-data-processing-agreement.pdf). For any support issue that needs VMware support, professional service data along with associated personal data will be shared with VMware. From that point on, Microsoft and VMware act as two independent data processors.

## Next steps

This article is based on the Cloud Adoption Framework Enterprise Scale Landing Zone (ESLZ) architectural design principles and guidelines. For more information, see:

- [Enterprise-scale Design Principles](../../ready/enterprise-scale/design-principles.md)
- [Enterprise-scale Design Guidelines](../../ready/enterprise-scale/design-guidelines.md)

The article is part of a series that applies ESLZ principles and recommendations to Azure VMware Solution deployments. Other articles in the series include:

- [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
- [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md)
- [Enterprise-scale platform automation and DevOps for Azure VMware Solution](./eslz-platform-automation-and-devops.md)
- [Enterprise-scale business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md)

Read the next article in the series:

> [!div class="nextstepaction"]
> [Enterprise-scale management and monitoring for Azure VMware Solution](./eslz-management-and-monitoring.md)

