---
title: Security, governance, and compliance for Azure Virtual Desktop infrastructure
description: Learn key design considerations and recommendations for a security and governance baseline in an Azure Virtual Desktop infrastructure.
author: nataliakon
ms.author: nataliak
ms.date: 02/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Introduction

This article covers key design considerations and recommendations for **security, governance, and compliance** for [Azure Virtual Desktop](/azure/virtual-desktop/overview) landing zone in accordance with the [Microsoft Cloud Adoption Framework](../../overview.md) for Azure.

## Security and Governance

The subsections below cover the recommended security controls and governance for the Azure Virtual Desktop landing zone.

### Identity

- Establish [Azure AD Conditional Access Policy](/azure/active-directory/conditional-access/overview) with [Azure AD Multi-factor Authentication](/azure/active-directory/authentication/concept-mfa-howitworks) or a partner multifactor authentication tool to secure user access to Azure Virtual Desktop. [Additional controls](/azure/active-directory/conditional-access/concept-conditional-access-grant) should be added depending on the users's devices and access patterns. Consider user sign in behavoir, locations and device they use.
For more information on how to enable Azure Multifactor authentication for Azure Virtual Desktop please see [here](/azure/virtual-desktop/set-up-mfa).

- Map defined administrative, operations, and engineering roles to [**Azure RBAC roles**](/azure/role-based-access-control/overview) to assign the *least privilege* required. Consider integration with Azure Privileged Identity Management (PIM) for limiting the access to high privilege roles within Azure Virtual Desktop landing zone. Knowing which team is responsible for what area will help determine Azure role-based access control (RBAC) roles and configuration.

- Use [**Azure Managed Identity**](/azure/active-directory/managed-identities-azure-resources/overview) or [service principal with certificate credentials](/azure/active-directory/develop/howto-authenticate-service-principal-powershell) for automation and services for Azure Virtual Desktop. Least privilege should be assigned to the automation account and scope limited to Azure Virtual Desktop landing zone(s).  Azure Key Vault can be used to in conjunction with Azure managed identities, so that the runtime environment (such as, an Azure Function) can retrieve the automation credential from the key vault.

- Ensure user and admin activity logging collection for Azure Active Directory and Azure Virtual Desktop landing zone(s)  is enabled and monitored by SIEM. For example:
  - [Azure Activity Log](/azure/azure-monitor/essentials/activity-log)
  - [Azure Active Directory Activity Log](/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor)
  - [Azure Active Directory](/azure/active-directory/fundamentals/active-directory-whatis)
  - [Session hosts](/azure/azure-monitor/agents/agent-windows)
  - [Key Vault logs](/azure/key-vault/general/logging)

- Use Azure AD groups versus individual users to assign access to Azure Virtual Desktop application groups. Consider using existing security groups that to business functions within the enterprise. Such approach would re-use existing user de/provisioning process as well.

- Azure Identity Protection

### Networking

- Re-use existing or provision dedicated virtual network for the Azure Virtual Desktop landing zone(s). Plan the IP address space to accommodate the scale of the session hosts. Establish the baseline subnet size based on the minimum and maximum number of the session hosts per host pool. Map business units requirements to host pools.

- Establish micro-segmentation using Network Security Groups and/or [Azure Firewall](/azure/firewall/protect-azure-virtual-desktop) (or third-party firewall appliance). Use Azure Virtual Network service tags to define network access controls on network security groups or an Azure Firewall configured for your Azure Virtual Desktop resources. Verify the session hosts outgoing access to the [required URLs.](/azure/virtual-desktop/safe-url-list) is bypassed by proxy (if used within the session hosts) and Azure Firewall (or 3rd party firewall appliance).

- Based on the applications and enterprise segmentation strategy, restrict or allow traffic between the sessions hosts and internal resources based on network security group rules or Azure Firewall (alternatively third-party firewall appliance) at scale.

- Enable [Azure DDoS standard protection.](/azure/virtual-network/manage-ddos-protection) for Azure Firewall or third-party firewall appliance used to secure Azure Virtual Desktop landing zone(s).

- If using proxy for outbound Internet access from the session hosts consider the following:
  - Configure proxy servers in the same geography as Azure Virtual Desktop session hosts and clients if using cloud proxy providers.
  - [Avoid TLS inspection with Azure Virtual Desktop.](/azure/virtual-desktop/proxy-server-support#dont-use-ssl-termination-on-the-proxy-server) Azure Virtual Desktop traffic is [encrypted in transit](/azure/virtual-desktop/network-connectivity#connection-security) by default.
  - [Avoid proxy configuration that requires user authentication.](/azure/virtual-desktop/proxy-server-support#session-host-configuration-recommendations) Azure Virtual Desktop components on the session host run in the context of their operating system, so they don't support proxy servers that require authentication. To configure the host level proxy on the session host – system-wide proxy needs to be enabled.

- Verify the end-users have access to the [Azure Virtual Desktop client URLs](/azure/virtual-desktop/safe-url-list#remote-desktop-clients). If proxy agent/configuration is used on the users' devices - make sure to bypass the Azure Virtual Desktop client URLs as well.

- Use [Just-in-Time access](/azure/defender-for-cloud/just-in-time-access-usage?tabs=jit-config-asc%2Cjit-request-asc) for administration and troubleshooting the session hosts. Avoid granting direct RDP access to the session hosts. AVD session hosts are using the Reverse Connect transport for establishing remote sessions.

- Use [Adaptive Network Hardening features](/azure/defender-for-cloud/adaptive-network-hardening#:~:text=From%20Defender%20for%20Cloud's%20menu,adaptive%20network%20hardening%20(2).&text=The%20insights%20panel%20shows%20the,defended%20with%20adaptive%20network%20hardening.) in Microsoft Defender for Cloud to recommend network security group configurations which limit ports and source IPs with reference to external network traffic rules.

- Ensure the Azure Firewall or third-party vendor firewall appliance logs are collected by Azure Monitor or partner monitoring solution. Logs should also be monitored by SIEM such as Azure Sentinel or partner solution.

- Use private endpoint only for Azure Files used for [FSLogix Profile containers.](/fslogix/configure-profile-container-tutorial).

- [Configure RDP ShortPath](/azure/virtual-desktop/shortpath) to complement reverse connect transport.

### Session Hosts

- Create dedicated Organization Unit (OU) with Active Directory the Azure Virtual Desktop session hosts. Dedicated Group Policy for the session hosts should be applied to set controls such as:
  - [Enable screen capture protection](/azure/virtual-desktop/screen-capture-protection) to prevent sensitive screen information from being captured on the client endpoints
  - [Maximum inactive/disconnection time policies](/windows/security/threat-protection/security-policy-settings/microsoft-network-server-amount-of-idle-time-required-before-suspending-session) and [screen locks](/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit)
  - [Hide local and remote drive mappings in Windows Explorer](/troubleshoot/windows-client/group-policy/using-group-policy-objects-hide-specified-drives)
  - Optionally, configuration parameters for [FSLogix Profile Containers](/fslogix/profile-container-configuration-reference) and [FSLogix Cloud Cache](/fslogix/cloud-cache-configuration-reference)

- [Control device redirection](/azure/virtual-desktop/customize-rdp-properties) for the session hosts. Common devices to disable include local hard drive access and USB or port restrictions. Limiting camera redirection and remote printing can help protect company data. Disable clipboard redirection to prevent copying remote content to endpoints.

- Enable next-generation antivirus Endpoint Protection such as [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint?view=o365-worldwide&preserve-view=true) on the session hosts. If using partner endpoint solutions - ensure the Microsoft Defender for Cloud is [able to verify](/azure/defender-for-cloud/endpoint-protection-recommendations-technical) its state. It is recommended to include [antivirus exclusions FSLogix Profile Container.](/azure/architecture/example-scenario/wvd/windows-virtual-desktop-fslogix#antivirus-exclusions) Microsoft Defender for Endpoint directly integrates with various Microsoft Defender solutions including:
  - [Microsoft Defender for Cloud](/azure/defender-for-cloud/integration-defender-for-endpoint?tabs=windows)
  - [Microsoft Sentinel](/azure/sentinel/microsoft-365-defender-sentinel-integration)
  - [Intune](/mem/intune/protect/advanced-threat-protection-configure)

- Enable threat and vulnerability management assessments. [Integrate Microsoft Defender for Endpoint's threat and vulnerability management solution with Microsoft Defender for Cloud.](/azure/defender-for-cloud/deploy-vulnerability-assessment-tvm). Or use third-party solutions. Microsoft Defender for Cloud natively integrates with [Qualys vulnerability assessment solution](/azure/defender-for-cloud/deploy-vulnerability-assessment-vm) as well.

- Enable Application control using [Windows Defender Application Control(WDAC) or AppLocker](/windows/security/threat-protection/windows-defender-application-control/feature-availability) to ensure the applications are trustworthy before execution. Application control policies can also block unsigned scripts and MSIs, and restrict Windows PowerShell to run in [Constrained Language Mode.](/powershell/module/microsoft.powershell.core/about/about_language_modes?view=powershell-7.2&preserve-view=true)

- Enable [Trusted launch](/azure/virtual-machines/trusted-launch) for Gen2 Azure virtual machines to enable features such as Secure Boot,  vTPM and Virtualization-based security(VBS). Microsoft Defender for Cloud can monitor the session hosts configured with trusted launch.

- Verify the session hosts are [monitored by Azure Monitor](/azure/virtual-machines/monitor-vm) or partner monitoring solution [via Event Hub.](/azure/azure-monitor/agents/diagnostics-extension-stream-event-hubs)

- Establish patch management strategy the session hosts. [Microsoft Endpoint Configuration Manager](/azure/virtual-desktop/configure-automatic-updates) supports the Azure Virtual Desktop sesison hosts to receive the updates automatically. It is recommended to patch the base images at minimum on the monthly basis. Consider using [Azure Image Builder (AIB)](/azure/virtual-machines/image-builder-overview) service to establish own [imaging pipeline for Azure Virtual Desktop base image.](/azure/virtual-machines/windows/image-builder-virtual-desktop).

For more information on Azure Virtual Desktop session hosts' best practices, see [Session host security best practices](/azure/virtual-desktop/security-guide#session-host-security-best-practices). For a detailed list of best practices for Azure VMs, see [Security recommendations for virtual machines in Azure](/azure/virtual-machines/security-recommendations).

### Data Protection

- Azure Virtual Desktop encrypts data-at-rest to protect against ‘out of band’ attacks, such as accessing [underlying storage](/azure/security/fundamentals/encryption-atrest#encryption-at-rest-in-microsoft-cloud-services).  This helps ensure that attackers cannot easily read or modify the data. Microsoft’s approach to enabling two layers of encryption for data at rest is:
  - Disk encryption using customer-managed keys. You provide your own key for disk encryption. You can bring your own keys to your Key Vault (BYOK – Bring Your Own Key), or generate new keys in Azure Key Vault to encrypt the desired resources (including the session hosts disks).
  - Infrastructure encryption using platform-managed keys. By default, disks are automatically encrypted at rest using platform-managed encryption keys.

- Deploy Information Protection solution such as [Microsoft Information Protection](/microsoft-365/compliance/information-protection?view=o365-worldwide&preserve-view=true) or third party partner solution. This is to ensure sensitive information is stored, processed, and transmitted securely by the organization's technology systems.

- To improve the Office deployment security, we recommend you use the [Security Policy Advisor for Microsoft 365 Apps for enterprise.](/deployoffice/admincenter/overview-office-cloud-policy-service) This tool identifies policies that can you can apply to your deployment for more security. Security Policy Advisor also recommends policies based on their impact to your security and productivity.

- [Configure identity-based authentication for Azure Files used for FSLogix User Profiles through on-premises Active Directory Domain Services (AD DS) and Azure Active Directory Domain Services (Azure AD DS).](/azure/storage/files/storage-files-active-directory-overview) Configure [NTFS permissions](/fslogix/fslogix-storage-config-ht) for the authorized users to access the Azure Files.

### Cost Management

- [Use Azure Tags](/azure/azure-resource-manager/management/tag-resources?tabs=json) to organize costs for creating, managing, and deploying Azure Virtual Desktop resources. TO identify the compute cost associated with Azure Virtual Desktop -  tag all the hosts pools and virtual machines. Tag the Azure Files or Azure NetApp Files resources to track the storage cost associated with the FSLogix User Profile Containers, Custom OS images and MSIX app attach (if used).

- Define the [minimum suggested tags](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging) to be set across all the Azure Virtual Desktop resources. Azure tags can be set during the deployment time or applied post-provisioning. Consider implementing [Azure Policy buit-in definitions](/azure/azure-resource-manager/management/tag-policies#:~:text=You%20use%20Azure%20Policy%20to,expected%20tags%20for%20your%20organization.) to enforce tagging rules.

- [Set the budget(s) in Azure Cost Management](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) to proactively manage the Azure usage cost.  When the budget thresholds you've created are exceeded, only notifications are triggered.

- [Create Azure Cost Management alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending) to monitor the Azure usage and spending against Azure Virtual Desktop Landing zone.

- Configure [Start VM on Connect feature](/azure/virtual-desktop/start-virtual-machine-connect) to save costs by allowing end users to turn on their VMs only when they need them.

- Deploy scaling solution for the pooled session hosts using [Azure Automation](/virtual-desktop/start-virtual-machine-connect) or [Autoscale feature(preview)](/azure/virtual-desktop/autoscale-scaling-plan)

### Resource Consistency

- [Use Intune for Azure Virtual Desktop personal session hosts](/mem/intune/fundamentals/azure-virtual-desktop) to apply existing or create new configurations and secure the VMs with compliance policy and conditional access. Intune management doesn't depend on or interfere with Azure Virtual Desktop management of the same virtual machine.

- [Multi-session session hosts management with Intune is currently in Public Preview.](/mem/intune/fundamentals/azure-virtual-desktop-multi-session) At this time configuration policies defined in the OS scope and apps configured to install in the system context can be applied to Azure Virtual Desktop multi-session VMs. Additionally, all multi-session configurations must be targeted to devices or device groups. User scope policies are not supported at this time.

- [Use Azure Policy's guest configuration](/azure/governance/policy/concepts/guest-configuration) to audit and configure the hardening of the session hosts' operating system. Use Windows security baseline as a starting point for securing the Windows operating system. For more information, see [Windows security baselines](/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines).

- [Use Azure Policy built-in definitions to configure the diagnostics settings](/azure/azure-monitor/policy-reference) for the Azure Virtual Desktop resources such as workspaces, application groups and host pools.

Review [security best practices for Azure Virtual Desktop](/azure/virtual-desktop/security-guide) as a starting point to security within your environment, and implement as appropriate.

## Compliance

Nearly all corporations are required to comply with government or industry regulatory policies. It's important to review those policies with your compliance team and have the correct controls for your Azure Virtual Desktop landing zone. You may need controls for specific policies like the Payment Card Industry Data Security Standard (PCI DSS) or the Health Insurance Portability and Accountability Act of 1996 (HIPAA).

[Use Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to apply additional compliance standards to Azure Virtual Desktop Landing zone if required. Microsoft Defender for Cloud helps streamline the process for meeting regulatory compliance requirements, using the [regulatory compliance dashboard.](/azure/defender-for-cloud/regulatory-compliance-dashboard#:~:text=Defender%20for%20Cloud%20continuously%20assesses,your%20compliance%20with%20these%20standards.) Built-in or customized compliancy standards can be  added to regulatory dashboard. Available built-in regulatory standards that can be added:

- PCI-DSS v3.2.1:2018
- SOC TSP
- NIST SP 800-53 R4
- NIST SP 800 171 R2
- UK OFFICIAL and UK NHS
- Canada Federal PBMM
- Azure CIS 1.1.0
- HIPAA/HITRUST
- SWIFT CSP CSCF v2020
- ISO 27001:2013
- New Zealand ISM Restricted
- CMMC Level 3
- Azure CIS 1.3.0
- NIST SP 800-53 R5
- FedRAMP H
- FedRAMP M

 If the data residency requirements is present - consider limited deployment of Azure Virtual Desktop resources (workspaces, application groups and host pools) to the  selected geographies:

- United States
- Europe
- United Kingdom
- Canada

This would ensure the Azure Virtual Desktop metadata stored in the region of Azure Virtual Desktop resource geography as the session hosts can be deployed world-wide to accommodate the user base.

Use Group policy and a device management tools like Intune and Microsoft Endpoint Configuration Manager to maintain a thorough security and compliance practice for the session hosts.

Configure [alerting](/azure/defender-for-cloud/alerts-overview) and [automated response](/azure/defender-for-cloud/workflow-automation) in Microsoft Defender for Cloud to ensure the Azure Virtual Desktop Landing zones overall compliance.

Review the [Microsoft Secure Score](/microsoft-365/security/defender/microsoft-secure-score?view=o365-worldwide&preserve-view=true) to measure the overall organization security posture across the following products:

- Microsoft 365 (including Exchange Online)
- Azure Active Directory
- Microsoft Defender for Endpoint
- Microsoft Defender for Identity
- Defender for Cloud Apps
- Microsoft Teams

Review [Microsoft Defender for Cloud Secure Score](/azure/defender-for-cloud/secure-score-security-controls) to improve the overall security compliance of the Azure Virtual Landing Zones.
