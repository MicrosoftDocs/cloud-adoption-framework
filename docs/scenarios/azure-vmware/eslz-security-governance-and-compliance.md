---
title: Security, governance, and compliance disciplines for Azure VMware Solution
description: Understand security, governance, and compliance considerations for Azure VMware Solution, and design recommendations and best practices to mitigate risks.
author: Mahesh-MSFT
ms.author: maksh
ms.date: 04/21/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Security, governance, and compliance for Azure VMware Solution

This article describes how to securely implement and holistically govern Azure VMware Solution throughout its lifecycle. The article explores specific design elements and provides targeted recommendations for Azure VMware Solution security, governance, and compliance.

## Security

Consider the following factors when deciding which systems, users, or devices can perform functions within Azure VMware Solution, and how to secure the overall platform.

### Identity security

- **Limits on permanent access:** Azure VMware Solution uses the Contributor role in the Azure resource group that hosts the Azure VMware Solution private cloud. Limit permanent access to prevent intentional or unintentional contributor rights abuse. Use a privileged account management solution to audit and limit the time usage of highly privileged accounts.

  Create a Microsoft Entra ID privileged access group within Azure Privileged Identity Management (PIM) to manage Microsoft Entra user and service principal accounts. Use this group to create and manage the Azure VMware Solution cluster with time-bound, justification-based access. For more information, see [Assign eligible owners and members for privileged access groups](/entra/id-governance/privileged-identity-management/groups-assign-member-owner).

  Use Microsoft Entra PIM audit history reports for Azure VMware Solution administrative activities, operations, and assignments. You can archive the reports in Azure Storage for long-term audit retention needs. For more information, see [View audit report for privileged access group assignments in Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/groups-audit).

- **Centralized identity management:** Azure VMware Solution provides cloud administrator and network administrator credentials for configuring the VMware private cloud environment. These administrative accounts are visible to all contributors that have role-based access control (RBAC) access to Azure VMware Solution.

  To prevent overuse or abuse of the built-in `cloudadmin` and network administrator users to access the VMware private cloud control plane, use the VMware private cloud control plane RBAC capabilities to properly manage role and account access. Create multiple targeted identity objects like users and groups using least-privilege principles. Limit access to administrator accounts provided by Azure VMware Solution, and configure the accounts in a break-glass configuration. Use the built-in accounts only when all other administrative accounts are unusable.

  Use the provided `cloudadmin` account to integrate Active Directory Domain Services (AD DS) or Microsoft Entra Domain Services with the VMware vCenter Server and NSX-T Data Center control applications and domain services administrative identities. Use the domain services-sourced users and groups for Azure VMware Solution management and operations, and don't allow account sharing. Create vCenter Server custom roles and associate them with AD DS groups for fine-grained privileged access control to VMware private cloud control surfaces.

  You can use Azure VMware Solution options to rotate and reset vCenter Server and NSX-T Data Center administrative account passwords. Configure a regular rotation of these accounts, and rotate the accounts anytime you use the break-glass configuration. For more information, see [Rotate the cloudadmin credentials for Azure VMware Solution](/azure/azure-vmware/rotate-cloudadmin-credentials).

- **Guest virtual machine (VM) identity management:** Provide centralized authentication and authorization for Azure VMware Solution guests to provide efficient application management and prevent unauthorized access to business data and processes. Manage Azure VMware Solution guests and applications as part of their lifecycle. Configure guest VMs to use a centralized identity management solution to authenticate and authorize for management and application use.

  Use a centralized AD DS or Lightweight Directory Access Protocol (LDAP) service for Azure VMware Solution guest VMs and application identity management. Be sure the domain services architecture accounts for any outage scenarios, to ensure continued functionality during outages. Connect the AD DS implementation with Microsoft Entra ID for advanced management and a seamless guest authentication and authorization experience.

### Environment and network security

- **Native network security capabilities:** Implement network security controls like traffic filtering, Open Web Application Security Project (OWASP) rule compliance, unified firewall management, and distributed denial of service (DDoS) protection.

  - **Traffic filtering** controls traffic between segments. Implement guest network traffic filtering devices by using [NSX-T Data Center](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.1/administration/GUID-6AB240DB-949C-4E95-A9A7-4AC6EF5E3036.html) or network virtual appliance (NVA) capabilities to limit access between guest network segments.

  - **OWASP Core Rule Set compliance** protects Azure VMware Solution guest web application workloads from generic web attacks. Use the OWASP capabilities of Azure Application Gateway Web Application Firewall (WAF) to protect web applications hosted on Azure VMware Solution guests. Enable prevention mode using the latest policy, and make sure to integrate WAF logs into your logging strategy. For more information, see [Introduction to Azure Web Application Firewall](/azure/web-application-firewall/overview).

  - **Unified firewall rule management** prevents duplicate or missing firewall rules from increasing the risk of unauthorized access. Firewall architecture contributes to the larger network management and environment security posture for Azure VMware Solution. Use a stateful managed firewall architecture that allows for traffic flow, inspection, centralized rule management, and event collection.

  - **DDoS protection** protects Azure VMware Solution workloads from attacks that cause financial loss or poor user experience. Apply DDoS protection on the Azure virtual network that hosts the ExpressRoute termination gateway for the Azure VMware Solution connection. Consider using Azure Policy for automatic enforcement of DDoS protection.

- **VSAN Encryption with Customer Managed Keys(CMK)** allows Azure VMware Solution VSAN datastores to be encrypted with a customer provided encryption key stored in Azure Key Vault. You can use this feature to meet compliance requirements, such as adhering to key rotation policies or managing key lifecycle events. For detailed implementation guidance and limits, see [Configure customer-managed key encryption at rest in Azure VMware Solution](/azure/azure-vmware/configure-customer-managed-keys)

- **Controlled vCenter Server access:** Uncontrolled access to the Azure VMware Solution vCenter Server can increase attack surface area. Use a dedicated privileged access workstation (PAW) to securely access Azure VMware Solution vCenter Server and NSX-T Manager. Create a user group and add individual user account to this user group.

- **Inbound internet request logging for guest workloads:** Use Azure Firewall or an approved NVA that maintains audit logs for incoming requests to guest VMs. Import those logs into your security incident and event management (SIEM) solution for appropriate monitoring and alerting. Use Microsoft Sentinel to process Azure event information and logging before integration into existing SIEM solutions. For more information, see [Integrate Microsoft Defender for Cloud with Azure VMware Solution](/azure/azure-vmware/azure-security-integration).

- **Session monitoring for outbound internet connection security:** Use rule control or session auditing of outbound internet connectivity from Azure VMware Solution to identify unexpected or suspicious outbound internet activity. Decide when and where to position outbound network inspection to ensure maximum security. For more information, see [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md).

  Use specialized firewall, NVA, and virtual wide-area network (Virtual WAN) services for outbound internet connectivity instead of relying on Azure VMware Solution's default internet connectivity. For more information and design recommendations, see [Inspecting Azure VMware Solution traffic with a network virtual appliance in Azure Virtual Network](https://avs.ms/nva/).

  Use service tags like `Virtual Network` and fully qualified domain name (FQDN) tags for identification when filtering egress traffic with Azure Firewall. Use a similar capability for other NVAs.

- **Centrally managed secure backups:** Use RBAC and delayed delete capabilities to help prevent intentional or accidental deletion of backup data needed to recover the environment. Use Azure Key Vault for managing encryption keys, and restrict access to the backup data storage location to minimize risk of deletion.

  Use Azure Backup or another backup technology validated for Azure VMware Solution that provides encryption in transit and at rest. When using Azure Recovery Services vaults, use resource locks and the soft-delete features to protect against accidental or intentional backup deletion. For more information, see [Enterprise-scale business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md).

### Guest application and VM security

- **Advanced threat detection:** To prevent various security risks and data breaches, use endpoint security protection, security alert configuration, change control processes, and vulnerability assessments. You can use Microsoft Defender for Cloud for threat management, endpoint protection, security alerting, OS patching, and a centralized view into regulatory compliance enforcement. For more information, see [Integrate Microsoft Defender for Cloud with Azure VMware Solution](/azure/azure-vmware/azure-security-integration).

  Use Azure Arc for servers to onboard your guest VMs. Once onboarded, use Azure Log Analytics, Azure Monitor, and Microsoft Defender for Cloud to collect logs and metrics and create dashboards and alerts. Use Microsoft Defender Security Center to protect and alert on threats associated with VM guests. For more information, see [Integrate and deploy Azure native services in Azure VMware Solution](/azure/azure-vmware/integrate-azure-native-services#onboard-vms-to-azure-arc-enabled-servers).

  Deploy the Azure Monitor Agent on VMware vSphere VMs before starting a migration, or when deploying new guest VMs. Configure Data Collection Rules to send metrics and logs to an Azure Log Analytics workspace. After the migration, verify that the Azure VMware Solution VM reports alerts in Azure Monitor and Microsoft Defender for Cloud.

  Alternatively, use a solution from an Azure VMware Solution certified partner to assess VM security postures and provide regulatory compliance against Center for Internet Security (CIS) requirements.

- **Security analytics:** Use cohesive security event collection, correlation, and analytics from Azure VMware Solution VMs and other sources to detect cyberattacks. Use Microsoft Defender for Cloud as a data source for Microsoft Sentinel. Configure Microsoft Defender for Storage, Azure Resource Manager, Domain Name System (DNS), and other Azure services related to Azure VMware Solution deployment. Consider using an Azure VMware Solution data connector from a certified partner.

- **Guest VM encryption:** Azure VMware Solution provides data-at-rest encryption for the underlying vSAN storage platform. Some workloads and environments with file system access might require more encryption to protect data. In these situations, consider enabling encryption of the guest VM operating system (OS) and data. Use the [native guest OS encryption](/azure/virtual-machines/windows/disk-encryption-overview) tools to encrypt guest VMs. Use Azure Key Vault to store and protect the encryption keys.

- **Database encryption and activity monitoring:** Encrypt SQL and other databases in Azure VMware Solution to prevent easy data access in case of a data breach. For database workloads, use encryption-at-rest methods such as transparent data encryption (TDE) or an equivalent native database feature. Ensure workloads are using encrypted disks, and that sensitive secrets are stored in a key vault dedicated to the resource group.

  Use Azure Key Vault for customer-managed keys in bring-your-own-key (BYOK) scenarios, such as [BYOK for Azure SQL Database transparent data encryption (TDE)](/azure/azure-sql/database/transparent-data-encryption-byok-overview). Separate key management and data management duties where possible. For an example of how SQL Server 2019 uses Key Vault, see [Use Azure Key Vault with Always Encrypted with secure enclaves](/sql/connect/ado-net/sql/azure-key-vault-enclave-example).

  Monitor for unusual database activities to reduce the risk of an insider attack. Use native database monitoring like Activity Monitor or an Azure VMware Solution certified partner solution. Consider using Azure database services for enhanced auditing controls.

- **Extended Security Update (ESU) keys:** Provide and configure ESU keys to push and install security updates on Azure VMware Solution VMs. Use the Volume Activation Management Tool for configuring ESU keys for the Azure VMware Solution cluster. For more information, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091).

- **Code security:** Implement security measure in DevOps workflows to prevent security vulnerabilities in Azure VMware Solution workloads. Use modern authentication and authorization workflows such as Open Authorization (OAuth) and OpenID Connect.

  Use [GitHub Enterprise Server on Azure VMware Solution](/azure/azure-vmware/configure-github-enterprise-server) for a versioned repository that ensures the integrity of the code base. Deploy build and run agents either in Azure VMware Solution or in a secure Azure environment.

## Governance

Consider implementing the following recommendations when planning for environment and guest VM governance.

### Environment governance

- **vSAN storage space:** Insufficient vSAN storage space can impact SLA guarantees. Review and understand customer and partner responsibilities in the [SLA for Azure VMware Solution](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/). Assign appropriate priorities and owners for alerts on the Percentage Datastore Disk Used metric. For more information and guidance, see [Configure alerts and work with metrics in Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution).

- **VM template storage policy:** A default thick-provisioned storage policy can result in reserving too much vSAN storage. Create VM templates that use a thin-provisioned storage policy where space reservations aren't required. VMs that don't reserve the full amount of storage up front allow more efficient storage resources.

- **Host quota governance:** Insufficient host quotas can lead to 5-7 day delays in getting more host capacity for growth or disaster recovery (DR) needs. Factor growth and DR requirements into solution design when requesting the host quota, and periodically review environment growth and maximums to ensure proper lead time for expansion requests. For example, if a three-node Azure VMware Solution cluster needs another three nodes for DR, request a host quota of six nodes. Host quota requests don't incur extra costs.

- **Failure-to-tolerate (FTT) governance:** Establish FTT settings commensurate to the cluster size to maintain the SLA for Azure VMware Solution. Adjust the vSAN [storage policy](/azure/azure-vmware/concepts-storage#storage-policies-and-fault-tolerance) to the appropriate FTT setting when changing the cluster size to ensure SLA compliance.

- **ESXi access:** Access to Azure VMware Solution ESXi hosts is limited. Third-party software that requires ESXi host access might not work. Identify any Azure VMware Solution-supported third-party software in the source environment that needs access to the ESXi host. Become familiar with and use the Azure VMware Solution [support request process](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) in the Azure portal for situations that need ESXi host access.

- **ESXi host density and efficiency:** For a good return on investment (ROI), understand ESXi host utilization. Define a healthy density of guest VMs to maximize Azure VMware Solution investments, and monitor overall node utilization against that threshold. Resize the Azure VMware Solution environment when monitoring indicates, and allow sufficient lead time for node additions.

- **Network monitoring:** Monitor internal network traffic for malicious or unknown traffic or compromised networks. Implement vRealize Network Insight (vRNI) and vRealize Operations (vROps) for detailed insights into Azure VMware Solution networking operations.

- **Security, planned maintenance, and Service Health alerts:** Understand and view service health to plan and respond to outages and issues appropriately. Configure [Service Health alerts](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/serviceIssues) for Azure VMware Solution service issues, planned maintenance, health advisories, and security advisories. Schedule and plan Azure VMware Solution workload activities outside of Microsoft-suggested maintenance windows.

- **Cost governance:** Monitor costs for good financial accountability and budget allocation. Use a cost management solution for cost tracking, cost allocation, budget creation, cost alerts, and good financial governance. For Azure billed charges, use [Microsoft Cost Management](/azure/cost-management-billing/cost-management-billing-overview) tools to create budgets, generate alerts, allocate costs, and produce reports for financial stakeholders.

- **Azure services integration:** Avoid using the public endpoint of the Azure platform as a service (PaaS), which can lead to traffic leaving the desired network boundaries. To ensure that traffic stays within a defined virtual network boundary, use a private endpoint to access Azure services like Azure SQL Database and Azure Blob Storage.

### Workload application and VM governance

Security posture awareness for Azure VMware Solution workload VMs helps you understand cybersecurity readiness and response and provide complete security coverage for guest VMs and applications.

- **Enable [Microsoft Defender for Cloud](/azure/security-center/azure-defender)** for running Azure services and Azure VMware Solution application VM workloads.

- **Use [Azure Arc enabled servers](/azure/azure-arc/servers/overview)** to manage Azure VMware Solution guest VMs with tools that replicate Azure native resource tooling, including:

  - Azure Policy to govern, report, and audit machine configurations and settings
  - Azure Automation State Configuration and supported extensions to simplify deployments
  - Update Management to manage updates for the Azure VMware Solution application VM landscape
  - Tags to manage and organize Azure VMware Solution application VM inventory

  For more information, see [Azure Arc enabled servers overview](/azure/azure-arc/servers/overview).

- **Workload VM domain governance:** To avoid error-prone manual processes, use extensions like the [`JsonADDomainExtension`](https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.compute/vm-domain-join-existing/azuredeploy.json) or equivalent automation options to enable Azure VMware Solution guest VMs to auto join an Active Directory domain.

- **Workload VM logging and monitoring:** Enable diagnostics metrics and logging on workload VMs to more easily debug OS and application issues. Implement log collection and querying capabilities that provide quick response times for debugging and troubleshooting. Enable near-real time [VM insights](/azure/azure-monitor/vm/vminsights-overview) on workload VMs for prompt detection of performance bottlenecks and operational issues. Configure [log alerts](/azure/azure-monitor/alerts/alerts-log) to capture boundary conditions for workload VMs.

  Deploy the Azure Monitor Agent on VMware vSphere workload VMs before migration, or when deploying new workload VMs in the Azure VMware Solution environment. Configure Data Collection Rules to send metrics and logs to an Azure Log Analytics workspace, and [link the Azure Log Analytics workspace with Azure Automation](/azure/automation/how-to/region-mappings). Validate the status of any workload VM monitoring agents deployed before migration with Azure Monitor.

- **Workload VM update governance:** Delayed or incomplete updates or patching are top attack vectors that can result in exposing or compromising Azure VMware Solution workload VMs and applications. Ensure timely update installations on guest VMs.

- **Workload VM backup governance:** Schedule regular backups to prevent missed backups or reliance on old backups that can lead to data loss. Use a backup solution that can take scheduled backups and monitor backup success. Monitor and alert on backup events to ensure scheduled backups run successfully.

- **Workload VM DR governance:** Undocumented recovery point objective (RPO) and recovery time objective (RTO) requirements can cause poor customer experiences and unmet operational goals during business continuity and disaster recovery (BCDR) events. Implement DR orchestration to prevent delays in business continuity.

  Use a DR solution for Azure VMware Solution that provides DR orchestration, and detects and reports on any failure or issues with successful continuous replication to a DR site. Document RPO and RTO requirements for applications running in Azure and Azure VMware Solution. Choose a [disaster recovery and business continuity solution](./eslz-business-continuity-and-disaster-recovery.md) design that meets verifiable RPO and RTO requirements through orchestration.

## Compliance

Consider and implement the following recommendations when planning for Azure VMware Solution environment and workload VM compliance.

- **Microsoft Defender for Cloud monitoring:** Use regulatory compliance view in Defender for Cloud to monitor compliance with security and regulatory benchmarks. Configure Defender for Cloud workflow automation to track any deviation from the expected compliance posture. For more information, see [Microsoft Defender for Cloud overview](/azure/security-center/security-center-introduction).

- **Workload VM DR compliance:** Track DR configuration compliance for Azure VMware Solution workload VMs to ensure that their mission-critical applications remain available during a disaster. Use Azure Site Recovery or an Azure VMware Solution certified BCDR solution, which provides at-scale replication provisioning, noncompliance status monitoring, and automatic remediation.

- **Workload VM backup compliance:** Track and monitor Azure VMware Solution workload VM backup compliance to ensure that the VMs are being backed up. Use an [Azure VMware Solution certified partner solution](/azure/azure-vmware/ecosystem-back-up-vms) that provides at-scale perspective, drill-down analysis, and an actionable interface for tracking and monitoring workload VM backup.

- **Compliance that's specific to country/region or industry:** To avoid costly legal actions and fines, ensure compliance of Azure VMware Solution workloads with regulations that are specific to the country/region and industry. Understand the cloud [shared responsibility](https://azure.microsoft.com/resources/shared-responsibility-for-cloud-computing/) model for industry or region-based regulatory compliance. Use the [Service Trust Portal](https://servicetrust.microsoft.com/ViewPage/MSComplianceGuideV3) to view or download Azure VMware Solution and Azure Audit reports that support the whole compliance story.

  Implement firewall audit reporting on HTTP/S and non-HTTP/S endpoints to comply with regulatory requirements.

- **Corporate policy compliance:** Monitor Azure VMware Solution workload VM compliance with corporate policies to prevent breaches of company rules and regulations. Use [Azure Arc enabled servers](/azure/azure-arc/servers/overview) and Azure Policy or an equivalent third-party solution. Routinely assess and manage Azure VMware Solution workload VMs and applications for regulatory compliance with applicable internal and external regulations.

- **Data retention and residency requirements:** Azure VMware Solution doesn't support retention or extraction of data stored in clusters. Deleting a cluster terminates all running workloads and components, and destroys all cluster data and configuration settings, including public IP addresses. This data can't be recovered.

- **Data processing:** Read and understand the legal terms when you sign up. Pay attention to the [VMware data processing agreement for Microsoft Azure VMware Solution customers transferred for L3 support](https://www.vmware.com/docs/vmware-product-guide-july-v1-2021). If a support issue needs VMware support, Microsoft shares professional service data and associated personal data with VMware. From that point on, Microsoft and VMware act as two independent data processors.

## Next steps

This article is based on the Cloud Adoption Framework enterprise-scale landing zone architectural design principles and guidelines. For more information, see:

- [Azure landing zone design principles](../../ready/landing-zone/design-principles.md)
- [Azure landing zone design guidelines](../../ready/landing-zone/design-areas.md)

The article is part of a series that applies enterprise-scale landing zone principles and recommendations to Azure VMware Solution deployments. Other articles in the series include:

- [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
- [Enterprise-scale network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md)
- [Enterprise-scale platform automation and DevOps for Azure VMware Solution](./eslz-platform-automation-and-devops.md)
- [Enterprise-scale business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md)

Read the next article in the series:

> [!div class="nextstepaction"]
> [Enterprise-scale management and monitoring for Azure VMware Solution](./eslz-management-and-monitoring.md)
