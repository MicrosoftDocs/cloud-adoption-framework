---
title: Security, governance, and compliance for Azure Virtual Desktop infrastructure
description: Learn key design considerations and recommendations for security and governance in Azure Virtual Desktop.
author: nataliakon
ms.author: tozimmergren
ms.date: 05/02/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Security and governance

This article provides key design considerations and recommendations for **security, governance, and compliance** in [Azure Virtual Desktop](/azure/virtual-desktop/overview) landing zones in accordance with Microsoft's [Cloud Adoption Framework](../../overview.md).

Review the following sections to find recommended security controls and governance for your Azure Virtual Desktop landing zone.

## Identity

- Secure user access to Azure Virtual Desktop by establishing [Microsoft Entra Conditional Access Policy](/azure/active-directory/conditional-access/overview) with [Microsoft Entra multifactor authentication](/azure/active-directory/authentication/concept-mfa-howitworks) or a partner multifactor authentication tool. Consider your users' locations, devices, and sign in behaviors, and add [extra controls](/azure/active-directory/conditional-access/concept-conditional-access-grant) as needed based their access patterns. For more information on enabling Azure multifactor authentication for Azure Virtual Desktop, see [Enable Azure multifactor authentication for Azure Virtual Desktop](/azure/virtual-desktop/set-up-mfa).

- Assign the *least privilege* required by defining administrative, operations, and engineering roles to [**Azure RBAC roles**](/azure/role-based-access-control/overview). To limit access to high privilege roles within your Azure Virtual Desktop landing zone, consider integration with Azure Privileged Identity Management (PIM). Maintaining knowledge of which team is responsible for each particular administrative area helps you determine Azure role-based access control (RBAC) roles and configuration.

- Use [**Azure Managed Identity**](/azure/active-directory/managed-identities-azure-resources/overview) or [service principal with certificate credentials](/azure/active-directory/develop/howto-authenticate-service-principal-powershell) for automation and services for Azure Virtual Desktop. Assign least privilege to the automation account and scope limited to Azure Virtual Desktop landing zone(s). You can use Azure Key Vault with Azure managed identities so that runtime environments (like an Azure Function) can retrieve automation credentials from the key vault.

- Ensure that you collect user and administrator activity logging for Microsoft Entra ID and Azure Virtual Desktop landing zone(s). Monitor these logs with your Security Information and Event Management (SIEM) tool. You can collect logs from various sources, such as:
  - [Azure Activity Log](/azure/azure-monitor/essentials/activity-log)
  - [Microsoft Entra Activity Log](/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor)
  - [Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-whatis)
  - [Session hosts](/azure/azure-monitor/agents/agent-windows)
  - [Key Vault logs](/azure/key-vault/general/logging)

- Use Microsoft Entra groups rather than individual users when assigning access to Azure Virtual Desktop application groups. Consider using existing security groups that map to business functions within your organization, which lets you reuse existing user provisioning and de-provisioning processes.

## Networking

- Provision or reuse a dedicated virtual network for your Azure Virtual Desktop landing zone(s). Plan IP address space to accommodate the scale of your session hosts. Establish your baseline subnet size based on the minimum and maximum number of session hosts per host pool. Map your business unit requirements to your host pools.

- Use Network Security Groups (NSGs) and/or [Azure Firewall](/azure/firewall/protect-azure-virtual-desktop) (or third-party firewall appliance) to establish micro-segmentation. Use Azure Virtual Network service tags and application service groups (ASGs) to define network access controls on network security groups or an Azure Firewall configured for your Azure Virtual Desktop resources. Verify that the session host's outgoing access to [required URLs](/azure/virtual-desktop/safe-url-list) is bypassed by proxy (if used within session hosts) and Azure Firewall (or third-party firewall appliance).

- Based on your applications and enterprise segmentation strategy, restrict traffic between your session hosts and internal resources through security group rules or Azure Firewall (or a third-party firewall appliance) at scale.

- Enable [Azure DDoS standard protection](/azure/virtual-network/manage-ddos-protection) for Azure Firewall (or a third-party firewall appliance) to help secure your Azure Virtual Desktop landing zone(s).

- If you use proxy for outbound internet access from your session hosts:
  - Configure proxy servers in the same geography as Azure Virtual Desktop session hosts and clients (if using cloud proxy providers).
  - [Don't use TLS inspection](/azure/virtual-desktop/proxy-server-support#dont-use-ssl-termination-on-the-proxy-server). In Azure Virtual Desktop, traffic is [encrypted in transit](/azure/virtual-desktop/network-connectivity#connection-security) by default.
  - [Avoid proxy configuration that requires user authentication](/azure/virtual-desktop/proxy-server-support#session-host-configuration-recommendations). Azure Virtual Desktop components on the session host run in the context of their operating system, so they don't support proxy servers that require authentication. System-wide proxy must be enabled for you to configure the host level proxy on your session host.

- Verify your end-users have access to [Azure Virtual Desktop client URLs](/azure/virtual-desktop/safe-url-list#remote-desktop-clients). If proxy agent/configuration is used on your users' devices, make sure you bypass the Azure Virtual Desktop client URLs as well.

- Use [Just-in-Time access](/azure/defender-for-cloud/just-in-time-access-usage?tabs=jit-config-asc%2Cjit-request-asc) for administration and troubleshooting your session hosts. Avoid granting direct RDP access to session hosts. AVD session hosts use Reverse Connect transport to establish remote sessions.

- Use [Adaptive Network Hardening features](/azure/defender-for-cloud/adaptive-network-hardening) in Microsoft Defender for Cloud to find network security group configurations that limit ports and source IPs with reference to external network traffic rules.

- Collect your Azure Firewall (or third-party firewall appliance) logs with Azure Monitor or a partner monitoring solution. You should also monitor logs by SIEM, using Microsoft Sentinel or a similar service.

- Only use a private endpoint for Azure files that are used for [FSLogix Profile containers](/fslogix/configure-profile-container-tutorial).

- [Configure the RDP Shortpath](/azure/virtual-desktop/shortpath) to complement reverse connect transport.

## Session hosts

- Create a dedicated Organization Unit(s) (OU) in the Active Directory for the Azure Virtual Desktop session hosts. Apply dedicated Group Policy to your session hosts to manage controls such as:
  - [Enable screen capture protection](/azure/virtual-desktop/screen-capture-protection) to you prevent sensitive screen information from being captured on the client endpoints.
  - Set [maximum inactive/disconnection time policies](/windows/security/threat-protection/security-policy-settings/microsoft-network-server-amount-of-idle-time-required-before-suspending-session) and [screen locks](/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit).
  - [Hide local and remote drive mappings](/troubleshoot/windows-client/group-policy/using-group-policy-objects-hide-specified-drives) in Windows Explorer.
  - Optionally, configuration parameters for [FSLogix Profile Containers](/fslogix/profile-container-configuration-reference) and [FSLogix Cloud Cache](/fslogix/cloud-cache-configuration-reference).

- [Control device redirection](/azure/virtual-desktop/customize-rdp-properties) for your session hosts. Commonly disabled devices include local hard drive access and USB or port restrictions. Limiting camera redirection and remote printing can help protect your organization's data. Disable clipboard redirection to prevent remote content from being copied to endpoints.

- Enable next-generation antivirus Endpoint Protection like [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint?view=o365-worldwide&preserve-view=true) on your session hosts. If you use a partner endpoint solution, ensure that Microsoft Defender for Cloud is [able to verify](/azure/defender-for-cloud/endpoint-protection-recommendations-technical) its state. You should also include [antivirus exclusions FSLogix Profile Container.](/fslogix/overview-prerequisites#configure-antivirus-file-and-folder-exclusions) Microsoft Defender for Endpoint directly integrates with multiple Microsoft Defender solutions, including:
  - [Microsoft Defender for Cloud](/azure/defender-for-cloud/integration-defender-for-endpoint?tabs=windows)
  - [Microsoft Sentinel](/azure/sentinel/microsoft-365-defender-sentinel-integration)
  - [Intune](/mem/intune/protect/advanced-threat-protection-configure)

- Enable threat and vulnerability management assessments. Integrate Microsoft Defender for Endpoint's [threat and vulnerability management solution with Microsoft Defender for Cloud](/azure/defender-for-cloud/deploy-vulnerability-assessment-tvm) or a third-party vulnerability management solution). Microsoft Defender for Cloud natively integrates with [Qualys vulnerability assessment solution](/azure/defender-for-cloud/deploy-vulnerability-assessment-vm).

- Use application control through [Windows Defender Application Control (WDAC) or AppLocker](/windows/security/threat-protection/windows-defender-application-control/feature-availability) to ensure applications are trustworthy before execution. Application control policies can also block unsigned scripts and MSIs and restrict Windows PowerShell to run in [Constrained Language Mode](/powershell/module/microsoft.powershell.core/about/about_language_modes?view=powershell-7.2&preserve-view=true).

- Enable [Trusted launch](/azure/virtual-machines/trusted-launch) for Gen2 Azure virtual machines to enable features such as Secure Boot, vTPM and Virtualization-based security (VBS). Microsoft Defender for Cloud can monitor session hosts configured with trusted launch.

- Randomize local administrator passwords using [Windows LAPS](/windows-server/identity/laps/laps-overview) to protect against pass-the-hash and lateral traversal attacks.


- Verify that your session hosts are monitored by [Azure Monitor](/azure/virtual-machines/monitor-vm) or a partner monitoring solution [via Event Hubs](/azure/azure-monitor/agents/diagnostics-extension-stream-event-hubs).

- Establish a patch management strategy for your session hosts. [Microsoft Endpoint Configuration Manager](/azure/virtual-desktop/configure-automatic-updates) enables Azure Virtual Desktop session hosts to receive updates automatically. You should patch base images at minimum at least once every 30 days. Consider using [Azure Image Builder (AIB)](/azure/virtual-machines/image-builder-overview) to establish your own [imaging pipeline for Azure Virtual Desktop base image](/azure/virtual-machines/windows/image-builder-virtual-desktop).

For more information on best practices for Azure Virtual Desktop session host security, see [Session host security best practices](/azure/virtual-desktop/security-guide#session-host-security-best-practices).

For a detailed list of best practices for Azure VM security, see [Security recommendations for virtual machines in Azure](/azure/virtual-machines/security-recommendations).

## Data protection

- Microsoft Azure encrypts data-at-rest to protect it from ‘out of band’ attacks, such as attempts to access [underlying storage](/azure/security/fundamentals/encryption-atrest#encryption-at-rest-in-microsoft-cloud-services).  This encryption helps ensure that attackers can't easily read or modify your data. Microsoft’s approach to enabling two layers of encryption for data at rest involves:
  - Disk encryption using customer-managed keys. Users provide their own key for disk encryption. They can bring their own keys to their Key Vault (a practice known as BYOK – Bring Your Own Key), or generate new keys in Azure Key Vault to encrypt the desired resources (including session host disks).
  - Infrastructure encryption using platform-managed keys. By default, disks are automatically encrypted at rest through platform-managed encryption keys.
  - [Encryption at the VM host](/azure/virtual-machines/disk-encryption#encryption-at-host---end-to-end-encryption-for-your-vm-data) (Azure server that your VM is allocated to). Each virtual machine's temporary disk and OS/data disk cache data are stored on the VM host. When encryption at the VM host is enabled, that data is encrypted at rest and flows encrypted to the Storage service to be persisted.  

- Deploy an information protection solution like [Microsoft Purview Information Protection](/microsoft-365/compliance/information-protection?view=o365-worldwide&preserve-view=true) or a third party solution, which makes sure sensitive information is stored, processed, and transmitted securely by your organization's technology systems.

- Use the [Security Policy Advisor for Microsoft 365 Apps for enterprise](/deployoffice/admincenter/overview-office-cloud-policy-service) to improve Office deployment security. This tool identifies policies you can apply to your deployment for more security, and also recommends policies based on their effects on your security and productivity.

- [Configure identity-based authentication for Azure Files](/azure/storage/files/storage-files-active-directory-overview) used for FSLogix User Profiles through on-premises Active Directory Domain Services (AD DS) and Microsoft Entra Domain Services. Configure [NTFS permissions](/fslogix/fslogix-storage-config-ht) so authorized users can access your Azure Files.

## Cost management

- [Use Azure Tags](/azure/azure-resource-manager/management/tag-resources?tabs=json) to organize costs for creating, managing, and deploying Azure Virtual Desktop resources. To identify Azure Virtual Desktop's associated compute cost, tag all your host pools and virtual machines. Tag Azure Files or Azure NetApp Files resources to track the storage cost associated with FSLogix User Profile Containers, custom OS images, and MSIX app attach (if used).

- Define the [minimum suggested tags](../../ready/azure-best-practices/resource-tagging.md) to be set across all your Azure Virtual Desktop resources. You can set Azure tags during deployment or after provisioning. Consider using [Azure Policy built-in definitions](/azure/azure-resource-manager/management/tag-policies) to enforce tagging rules.

- [Set budget(s) in Microsoft Cost Management](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) to proactively manage Azure usage costs. When budget thresholds you've created are exceeded, notifications are triggered.

- [Create Cost Management alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending) to monitor Azure usage and spending against Azure Virtual Desktop Landing zone.

- Configure the [Start VM on Connect feature](/azure/virtual-desktop/start-virtual-machine-connect) to save costs by allowing end users to turn on their VMs only when they need them.

- Deploy scaling solutions for pooled session hosts through [Azure Automation](/azure/virtual-desktop/start-virtual-machine-connect) or [Autoscale feature(preview)](/azure/virtual-desktop/autoscale-scaling-plan)

## Resource consistency

- [Use Intune for Azure Virtual Desktop personal session hosts](/mem/intune/fundamentals/azure-virtual-desktop) to apply existing or create new configurations and secure your VMs with compliance policy and conditional access. Intune management doesn't depend on or interfere with Azure Virtual Desktop management of the same virtual machine.

- [Multi-session session hosts management with Intune](/mem/intune/fundamentals/azure-virtual-desktop-multi-session) allows you to manage Windows 10 or Windows 11 Enterprise multi-session remote desktops in the Intune admin center, just as you can manage a shared Windows 10 or Windows 11 client device. When managing such virtual machines (VMs), can use both device-based configuration targeted to devices or user-based configuration targeted to users.

- Audit and configure the hardening of your session hosts' operating system by using [Azure Policy machine configuration](/azure/governance/machine-configuration/overview). Use the [Windows security baselines](/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines) as a starting point for securing your Windows operating system.

- [Use Azure Policy built-in definitions](/azure/azure-monitor/policy-reference)  to configure the diagnostics settings for Azure Virtual Desktop resources like workspaces, application groups, and host pools.

Review the [security best practices for Azure Virtual Desktop](/azure/virtual-desktop/security-guide) as a starting point for security within your environment.

## Compliance

Nearly all organizations must comply with various government or industry regulatory policies. Review any such policies with your compliance team and implement the correct controls for your particular Azure Virtual Desktop landing zone. For example, you should consider controls for specific policies like the Payment Card Industry Data Security Standard (PCI DSS) or the Health Insurance Portability and Accountability Act of 1996 (HIPAA) if your organization follows their frameworks.

- [Use Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to apply extra compliance standards to Azure Virtual Desktop Landing zones if necessary. Microsoft Defender for Cloud helps streamline your process for meeting regulatory compliance requirements through its [regulatory compliance dashboard](/azure/defender-for-cloud/regulatory-compliance-dashboard). You can add built-in or customized compliancy standards to the dashboard. Already-built-in regulatory standards that you can add include:

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

- If your organization is bound by data residency requirements, consider limiting deployment of Azure Virtual Desktop resources (workspaces, application groups and host pools) to the following geographies:

  - United States
  - Europe
  - United Kingdom
  - Canada

  Limiting deployment to these geographies can help you ensure that Azure Virtual Desktop metadata is stored in the region of Azure Virtual Desktop resource geography, since your session hosts can be deployed worldwide to accommodate your user base.

- Use group policy and device management tools like Intune and Microsoft Endpoint Configuration Manager to maintain a thorough security and compliance practice for your session hosts.

- Configure [alerts](/azure/defender-for-cloud/alerts-overview) and [automated responses](/azure/defender-for-cloud/workflow-automation) in Microsoft Defender for Cloud to ensure the overall compliance of Azure Virtual Desktop landing zones.

- Review the [Microsoft Secure Score](/microsoft-365/security/defender/microsoft-secure-score?view=o365-worldwide&preserve-view=true) to measure overall organization security posture across the following products:

  - Microsoft 365 (including Exchange Online)
  - Microsoft Entra ID
  - Microsoft Defender for Endpoint
  - Microsoft Defender for Identity
  - Defender for Cloud Apps
  - Microsoft Teams

- Review [Microsoft Defender for Cloud Secure Score](/azure/defender-for-cloud/secure-score-security-controls) to improve the overall security compliance of your Azure Virtual Landing Zones.

## Recommended security best practices and baselines

- [Azure Virtual Desktop recommended security practices](/azure/virtual-desktop/security-guide)
- [Security baseline for Azure Virtual Desktop based on Azure Security Benchmark](/security/benchmark/azure/baselines/virtual-desktop-security-baseline)
- [Apply Zero Trust principles to an Azure Virtual Desktop deployment](/security/zero-trust/azure-infrastructure-avd)

## Next steps

Learn about platform automation and DevOps for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)
