---
title: Security, governance, and compliance for Azure Virtual Desktop infrastructure
description: Learn key design considerations and recommendations for a security and governance baseline in an Azure Virtual Desktop infrastructure.
author: NataliaKonokhova
ms.author: nataliak
ms.date: 02/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

## Introduction
This article covers key design considerations and recommendations for **security, governance, and compliance** for [Azure Virtual Desktop](/azure/virtual-desktop/overview) landing zone in accordance with the [Microsoft Cloud Adoption Framework](../../overview.md) for Azure. 
 
## Security and Governance
The subsections below cover the recommended security controls and governance for the Azure Virtual Desktop landing zone.

#### Identity

- Establish [Azure AD Conditional Access Policy]((/azure/active-directory/conditional-access/overview)) with [Azure AD Multi-factor Authentication](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-howitworks) or a partner multifactor authentication tool to secure user access to Azure Virtual Desktop. [Additional controls](/azure/active-directory/conditional-access/concept-conditional-access-grant) should be added depending on the users's devices and access patterns. Consider user sign in behavoir, locations and device they use. 
For more information on how to enable Azure Multifactor authentication for Azure Virtual Desktop please see [here](/azure/virtual-desktop/set-up-mfa).

- Map defined administrative, operations, and engineering roles to [**Azure RBAC roles**](/azure/role-based-access-control/overview) to assign the *least privilege* required. Consider integration with Azure Privileged Identity Management (PIM) for limiting the access to high privilege roles within Azure Virtual Desktop landing zone. Knowing which team is responsible for what area will help determine Azure role-based access control (RBAC) roles and configuration. 

- Use [**Azure Managed Identity**](/azure/active-directory/managed-identities-azure-resources/overview) or [service principal with certificate credentials](/azure/active-directory/develop/howto-authenticate-service-principal-powershell) for automation and services for Azure Virtual Desktop. Least priviledge should be assigned to the automation account and scope limited to Azure Virtual Desktop landing zone(s).  Azure Key Vault can be used to in conjunction with Azure managed identities, so that the runtime environment (such as, an Azure Function) can retrieve the automation credential from the key vault.

- Ensure user and admin activity logging collection for Azure Active Directory and Azure Virtual Desktop landing zone(s)  is enabled and monitored by SIEM. For example: 
  - [Azure Activity Log](https://docs.microsoft.com/azure/azure-monitor/essentials/activity-log)
  - [Azure Active Directory Activity Log](https://docs.microsoft.com/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor)
  - [Azure Active Directory](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-whatis)
  - [Session hosts](https://docs.microsoft.com/azure/azure-monitor/agents/agent-windows)
  - [Key Vault logs](https://docs.microsoft.com/azure/key-vault/general/logging)

- Use Azure AD groups versus individual users to assign access to Azure Virtual Desktop application groups. Consider leveraging existing security groups that to business functions within the enterprise. Such approach would re-use existing user de/provisioning process as well. 

- Azure Identity Protection

#### Networking

- Re-use existing or provision dedicated virtual network for the Azure Virtual Desktop landing zone(s). Plan the IP address space to accomondate the scale of the session hosts. Establish the baseline subnet size based on the minumum and maximum number of the session hosts per host pool. Map business units requirements to host pools. 

- Establish micro-segmentation using Network Security Groups and/or Azure Firewall (or 3rd party firewall appliance). Use Azure Virtual Network service tags to define network access controls on network security groups or an Azure Firewall configured for your Azure Virtual Desktop resources. Verify the session hosts outgoing access to the [required URLs.](https://docs.microsoft.com/azure/virtual-desktop/safe-url-list) is bypassed by proxy (if used within the session hosts) and Azure Firewall (or 3rd party firewall appliance).

- Based on the applications and enterprise segmentation strategy, restrict or allow traffic between the sessions hosts and internal resources based on network security group rules or Azure Firewall (alternatively 3rd party firewall appliance) at scale. 

- Enable [Azure DDoS standard protection.](https://docs.microsoft.com/azure/virtual-network/manage-ddos-protection) for Azure Firewall or 3rd party firewall apppliance used to secure Azure Virtual Desktop landing zone(s).

- If using proxy for outbound Internet access from the session hosts consider the following: 
  - Configure proxy servers in the same geography as Azure Virtual Desktop session hosts and clients if using cloud proxy providers.
  - [Avoid TLS inspection with Azure Virtual Desktop.](https://docs.microsoft.com/en-us/azure/virtual-desktop/proxy-server-support#dont-use-ssl-termination-on-the-proxy-server) Azure Virtual Desktop traffic is [encrypted in transit](https://docs.microsoft.com/azure/virtual-desktop/network-connectivity#connection-security) by default.
  - [Avoid proxy configuration that requires user authentication.](https://docs.microsoft.com/azure/virtual-desktop/proxy-server-support#session-host-configuration-recommendations) Azure Virtual Desktop components on the session host run in the context of their operating system, so they don't support proxy servers that require authentication. To configure the host level proxy on the session host – systemwide proxy needs to be enabled.

-  Use [Just-in-Time access](https://docs.microsoft.com/azure/defender-for-cloud/just-in-time-access-usage?tabs=jit-config-asc%2Cjit-request-asc) for administration and troubleshooting the session hosts. Avoid granting direct RDP access to the session hosts. AVD session hosts are leveraging the Reverse Connect transport for establishing remote sessions.

- Use [Adaptive Network Hardening features](https://docs.microsoft.com/azure/defender-for-cloud/adaptive-network-hardening#:~:text=From%20Defender%20for%20Cloud's%20menu,adaptive%20network%20hardening%20(2).&text=The%20insights%20panel%20shows%20the,defended%20with%20adaptive%20network%20hardening.) in Microsoft Defender for Cloud to recommend network security group configurations which limit ports and source IPs with reference to external network traffic rules.

- Ensure the Azure Firewall or 3rd party vendor firewall appliance logs are collected by Azure Monitor or partner monitoring solution. Logs should also be monitored by SIEM such as Azure Sentinel or partner solution. 

- Use private endpoint only for Azure Files used for [FSLogix Profile containers.](https://docs.microsoft.com/fslogix/configure-profile-container-tutorial).

#### Session Hosts

- Create dedicated Organization Unit (OU) with Active Directory the Azure Virtual Desktop session hosts. Dedicated Group Policy for the session hosts should be applied to set controls such as: 
  - [Enable screen capture protection](https://docs.microsoft.com/azure/virtual-desktop/screen-capture-protection) to prevent sensitive screen information from being captured on the client endpoints
  - [Maximum inactive/disconnection time policies](https://docs.microsoft.com/windows/security/threat-protection/security-policy-settings/microsoft-network-server-amount-of-idle-time-required-before-suspending-session) and [screen locks](https://docs.microsoft.com/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit)
  - [Hide local and remote drive mappings in Windows Explorer](https://docs.microsoft.com/troubleshoot/windows-client/group-policy/using-group-policy-objects-hide-specified-drives)
  - Optionally, configuration parameters for [FSLogix Profile Containers](https://docs.microsoft.com/fslogix/profile-container-configuration-reference) and [FSLogix Cloud Cache](https://docs.microsoft.com/fslogix/cloud-cache-configuration-reference) 

- [Control device redirection](https://docs.microsoft.com/azure/virtual-desktop/customize-rdp-properties) for the session hosts. Common devices to disable include local hard drive access and USB or port restrictions. Limiting camera redirection and remote printing can help protect company data. Disable clipboard redirection to prevent copying remote content to endpoints.

- Enable next-generation antivirus Endpoint Protection such as [Microsoft Defender for Endpoint](https://docs.microsoft.com/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint?view=o365-worldwide) on the session hosts. If using partner endpoint solutions - ensure the Microsoft Defender for Cloud is [able to verify](https://docs.microsoft.com/azure/defender-for-cloud/endpoint-protection-recommendations-technical) its state. Microsoft Defender for Endpoint directly integrates with various Microsoft Defender solutions including: 
  - [Microsoft Defender for Cloud](https://docs.microsoft.com/azure/defender-for-cloud/integration-defender-for-endpoint?tabs=windows)
  - [Microsoft Sentinel](https://docs.microsoft.com/azure/sentinel/microsoft-365-defender-sentinel-integration)
  - [Intune](https://docs.microsoft.com/mem/intune/protect/advanced-threat-protection-configure)

- Enable threat and vulnerability management assessments. [Integrate Microsoft Defender for Endpoint's threat and vulnerability management solution with Microsoft Defender for Cloud.](https://docs.microsoft.com/azure/defender-for-cloud/deploy-vulnerability-assessment-tvm). Or use third-party solutions. Microsoft Defender for Cloud natively integrates with [Qualys vulnerability assessment solution](https://docs.microsoft.com/azure/defender-for-cloud/deploy-vulnerability-assessment-vm) as well.

- Enable Application control using [Windows Defender Application Control(WDAC) or AppLocker](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/feature-availability) to ensure the applications are trustworthy before execution. Application control policies can also block unsigned scripts and MSIs, and restrict Windows PowerShell to run in [Constrained Language Mode.](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_language_modes?view=powershell-7.2)

- Enable [Trusted launch](https://docs.microsoft.com/azure/virtual-machines/trusted-launch) for Gen2 Azure virtual machines to enable features such as Secure Boot,  vTPM and Virtualization-based security(VBS). Microsoft Defender for Cloud can monitor the session hosts configured with trusted launch. 

- Verify the session hosts are [monitored by Azure Monitor](https://docs.microsoft.com/azure/virtual-machines/monitor-vm) or partner monitoring solution [via Event Hub.](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-stream-event-hubs) 

- Establish patch management strategy the session hosts. [Microsoft Endpoint Configuration Manager](https://docs.microsoft.com/azure/virtual-desktop/configure-automatic-updates) supports the Azure Virtual Desktop sesison hosts to receive the updates automatically. It is recommended to patch the base images at minimum on the monthly basis. Consider using [Azure Image Builder (AIB)](https://docs.microsoft.com/azure/virtual-machines/image-builder-overview) service to establish own [imaging pipeline for Azure Virtual Desktop base image.](https://docs.microsoft.com/azure/virtual-machines/windows/image-builder-virtual-desktop).

####  Data Protection

- Azure Virtual Desktop encrypts data-at-rest to protect against ‘out of band’ attacks, such as accessing [underlying storage].(https://docs.microsoft.com/azure/security/fundamentals/encryption-atrest#encryption-at-rest-in-microsoft-cloud-services).  This helps ensure that attackers cannot easily read or modify the data. Microsoft’s approach to enabling two layers of encryption for data at rest is:
  - Disk encryption using customer-managed keys. You provide your own key for disk encryption. You can bring your own keys to your Key Vault (BYOK – Bring Your Own Key), or generate new keys in Azure Key Vault to encrypt the desired resources (including the session hosts disks).
  - Infrastructure encryption using platform-managed keys. By default, disks are automatically encrypted at rest using platform-managed encryption keys.

- Deploy Information Protection solution such as Microsoft Information Protection(https://docs.microsoft.com/microsoft-365/compliance/information-protection?view=o365-worldwide) or third party partner solution. This is to ensure sensitive information is stored, processed, and transmitted securely by the organization's technology systems.

- To improve the Office deployment security, we recommend you use the Security Policy Advisor for Microsoft 365 Apps for enterprise. This tool identifies policies that can you can apply to your deployment for more security. Security Policy Advisor also recommends policies based on their impact to your security and productivity.

- AAD integration for Azure FIles 

#### Cost Management

Tags and budgets

#### Resource Consistency

Intune 
DSC 

---------------------------------------------------------
## Governance

Sections below cover the recommended practices for Azure Virtual Desktop across the five disciplines for cloud governance. 
![image](https://user-images.githubusercontent.com/26681656/161323479-e5672478-b859-409a-8145-1fc64acadc46.png)
-------------------------------------------------------------------------



## Compliance

 Nearly all corporations are required to comply with government or industry regulatory policies. It's important to review those policies with your compliance team and have the correct controls for your Azure Virtual Desktop landing zone. You may need controls for specific policies like the Payment Card Industry Data Security Standard (PCI DSS) or the Health Insurance Portability and Accountability Act of 1996 (HIPAA).


- and a device management tools like Intune and Microsoft Endpoint Configuration Manager to maintain a thorough security and compliance practice for your desktops.
https://docs.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop

- [Windows security baselines](/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines)


https://docs.microsoft.com/en-us/azure/virtual-desktop/diagnostics-log-analytics

- **Security audit tools:** What tools and methods do you use to continually scan, and evaluate your environment for security audits, and vulnerabilities?
- **Software updates:** Define a strategy for continuous operations to keep Windows and applications current.
- **Disk encryption:** Do you have regulatory or internal security requirements to manage and maintain your own keys for encrypting VMs at rest? Are Azure Key Vault keys acceptable for encryption? Do you need advanced hardware encryption or in-guest OS encryption like BitLocker? How will data at rest or data in transit be encrypted?
- **Data protection:** How will data in the VMs be protected? You can use a tool like [Azure Information Protection](/azure/information-protection/what-is-information-protection) to protect data. Consider using antimalware tools for protection.

- **Policies:** Policies for managing your Azure Virtual Desktop environment should be defined in your Cloud Adoption Framework platform design. Include policies pertaining to security, RBAC controls, regulatory governance, and types of resources that can be deployed.
- **Resource group organization:** Organize your resource groups to facilitate good management and prevent accidental deletions, and define who can manage your environment.

## Design recommendations


- **Enable logging:** Enable Azure Virtual Desktop service logging, host pool logging, and workspace logging for all Azure Virtual Desktop objects. For more information, see [Use Log Analytics for the diagnostics feature](/azure/virtual-desktop/diagnostics-log-analytics). Enable Azure Virtual Desktop host logging and performance logging as outlined in the management and monitoring section of the Azure Virtual Desktop landing zone architecture.

- **Microsoft Information Protection:** Enable and configure Microsoft Information Protection to discover, classify, and protect sensitive information wherever it is.

- **Policy tools:** Use group policy and a device management tools like Intune and Microsoft Endpoint Configuration Manager to maintain a thorough security and compliance practice for your desktops.
- **Patch management:** Patch management is a vital part of the overall security strategy for your environment. You need a consistent practice and deployment policy to maintain secure systems. Tools like Microsoft Endpoint Configuration Manager and partner applications can help manage patches and keep your systems up to date.

- **Security baseline:** Use a security baseline as a starting point for securing the Windows operating system. For more information, see [Windows security baselines](/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines).

- **Microsoft Defender for Cloud:** Enable Defender for Cloud to help maintain security compliance and alerting within your environment.
- **Microsoft Secure Score:** [Microsoft Secure Score](/microsoft-365/security/defender/microsoft-secure-score) provides recommendations and best practice advice for increasing your security posture and securing surrounding infrastructure with documented best practices.
- **Disk encryption:** Enable Azure Disk Encryption for your VMs. This option is configured by default with Azure-provided keys. In many cases, this configuration is acceptable to security teams and auditors. However, if you have a security practice or regulatory requirement that requires you to maintain your own keys, you can implement that practice for Azure Virtual Desktop VMs.
- **Key Vault:** Enable Key Vault to protect security principal accounts and encryption keys.
- **Security best practices:** Review [security best practices for Azure Virtual Desktop](/azure/virtual-desktop/security-guide) as a starting point to security within your environment, and implement as appropriate.

- **Azure Virtual Desktop metadata:** A good resource group design for Azure Virtual Desktop can help protect against accidental deletion of workspace and host pool objects, can separate VM machine types, and can allow for administrators from different departments. Outside the Cloud Adoption Framework best practice for RBAC, security controls and landing zone design, here is a sample resource group structure for Azure Virtual Desktop.



## Azure Virtual Desktop host operating system security

In addition to service level logging for Azure Virtual Desktop, administrators need to have a security strategy inside the guest operating system. Microsoft recommends security tools such as:

- [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint/deployment-vdi-microsoft-defender-antivirus): OS-level antivirus and antimalware
- [Threat protection (Windows 10)](/windows/security/threat-protection/): Threat protection overview and details
- [Azure Monitor agents](/azure/azure-monitor/deploy) and [Azure Monitor deployment at scale with Azure Policy](/azure/azure-monitor/deploy-scale): Capture guest logs and performance metrics
- [Guest configuration extension for local machines](/azure/governance/policy/concepts/guest-configuration#enable-guest-configuration): Monitor, alert, and track guest changes and audit reports
- [Azure Monitor dependency extension](/azure/virtual-machines/extensions/agent-dependency-windows): Troubleshoot guest connections, logs traffic flows, and configuration
- [Enable screen capture protection](/azure/virtual-desktop/security-guide#enable-screen-capture-protection-preview): Protects from remote capture of data
- [Microsoft Defender for Cloud](/azure/security-center/security-center-services?tabs=features-windows): Security audits, regulatory compliance scanning, policy compliance

For more information on Azure Virtual Desktop best practices, see [Session host security best practices](/azure/virtual-desktop/security-guide#session-host-security-best-practices). For a detailed list of best practices for Azure VMs, see [Security recommendations for virtual machines in Azure](/azure/virtual-machines/security-recommendations).
