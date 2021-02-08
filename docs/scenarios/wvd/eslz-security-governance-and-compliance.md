---
title: "Enterprise-Scale security, governance, and compliance for Windows Virtual Desktop"
description: Describe how this enterprise-scale scenario can improve security, governance, and compliance of <Insert Scenario Name>
author: AdamWhitlatch
ms.author: dawhitla
ms.date: 12/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---
 


# Security, governance, and compliance for Windows Virtual Desktop (WVD) Enterprise-Scale scenario

  

Enterprise-Scale in this instance refers to organizations with approximately 500-2000 WVD hosts per subscription.

  

Windows Virtual Desktop (WVD) is a cloud Platform as a Service (PaaS) control plane running on Azure for your desktop virtualization environment. The WVD Service provides secure connection brokering from anywhere for your end users. It also provides central management, and operational control for your IT staff, without having to stand up on premises hardware or services.

  

Like any IT service it is important to build the environment to scale, build in security, and be able to operate your environment simply. While the WVD Service does most of the front end work, you still need to have the right controls in place to keep your systems and data safe. You also need mechanisms in place to continually review those controls and report changes to appropriate IT teams.

  

In this cases Windows Virtual Desktop will be deployed into a landing zone as part of the [Microsoft Cloud Adoption Framework Enterprise Scale landing zone](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/overview). Microsoft reccomends reviewing the Cloud Adoption Framework (CAF) to ensure your environment has the right foundation for security, compliance, governance, and cost management.

  

In addition to the CAF reference architectures and best practices you will need to consider additional design decisions:

  

- [Collect Audit Logs](#collect-audit-logs) - WVD Service, Host Pool, and Workspace Logging
- [Enable Conditional Access](#enable-conditional-access) - Connection Policy for end users
- [WVD Host OS Security](#wvd-host-os-security) - Security Data, Identity, and other resources inside the VM Host
- [Resource Group Design](#resource-group-design) - Keeping your WVD Service Configs safe during create and remove operations
- [RBAC Design](#rbac-design) - Enabling RBAC Controls for Engineering and Operations
- [Enable Screenshot protection](#enable-screenshot-protection) - Security Date inside the VM Host



## **Collect Audit Logs**

  

Enabling audit log collection lets you view user and admin activity related to Windows Virtual Desktop. These setting can help track errors, user logins, audit requirements, and security events. As part of CAF Azure Logs, Session Host logs, and Key Vault logs would be turned on. It's important to create an Azure policy, or manually configure diagnostic settings for Windwos Virtual Desktop Service

  

Some examples of key audit logs are:

  

-  [Azure Activity Log](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log)
-  [Azure Active Directory Activity Log](https://docs.microsoft.com/en-us/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor)
-  [Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-whatis)
-  [Session hosts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/agent-windows)
-  [Windows Virtual Desktop Diagnostic Log](https://docs.microsoft.com/en-us/azure/virtual-desktop/diagnostics-log-analytics)
-  [Key Vault logs](https://docs.microsoft.com/en-us/azure/key-vault/general/logging)

  
  
  

## **Enable Conditional Access**

  

Enabling [Conditional Access](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/overview) lets you manage risks before you grant users access to your Windows Virtual Desktop environment. When deciding which users to grant access to, we recommend you also consider who the user is, how they sign in, and which device they're using. [Common signals](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/overview#common-signals) that Conditional Access can take in to account when making a policy decision include the following signals:

  

- User or group membership
- IP Location information
- Device
- Real-time and calculated risk detection
- Microsoft Cloud App Security (MCAS)

  

## **WVD Host OS Security**

In addition to service level logging for WVD, administrators need to have a security strategy inside the guest OS. Microsoft recommends security tools such as.  

- [Microsoft Defender for Endpoint](https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-antivirus/deployment-vdi-microsoft-defender-antivirus) - OS Level Anti-virus and Anti-malware
- [Threat Protection (Windows 10)](https://docs.microsoft.com/en-us/windows/security/threat-protection/) - Threat Protection overview and details
- [Azure Monitor  / Log Analytics Agent](https://docs.microsoft.com/en-us/azure/azure-monitor/deploy)   - [Deploy at scale with Azure Policy](https://docs.microsoft.com/en-us/azure/azure-monitor/deploy-scale) - Capture Guest Logs and Performance Metrics
- [Virtual Machine Guest Config Extension](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/guest-configuration#enable-guest-configuration) - Monitor, alert, and track guest changes & audit reports
- [Microsoft Dependency Extension](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/agent-dependency-windows) - Troubleshoot guest connections, logs trtaffic flows, and configuration
- [Enable Screen Capture Protection](https://docs.microsoft.com/en-us/azure/virtual-desktop/security-guide#:~:text=Azure%20security%20best%20practices.%20Windows%20Virtual%20Desktop%20is,Virtual%20Desktop%20fits%20into%20your%20larger%20Azure%20ecosystem) - Protects from remote capture of data
- [Azure Security Center](https://docs.microsoft.com/en-us/azure/security-center/security-center-services?tabs=features-windows) - Security Audits, Regulatory compliance scanning, Policy Compliance
- [Windows Security Baselines](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-baselines)


A more detailed list for Security Best Practices in WVD can be found can be found at [here](https://docs.microsoft.com/en-us/azure/virtual-desktop/security-guide#session-host-security-best-practices), and a detailed list of Azure Virtual Machine best practice can be found [here](https://docs.microsoft.com/en-us/azure/virtual-machines/security-recommendations)



## **Resource Group Design**

A good resource group design for WVD can help protect against accidental deletion of Workspace and Host Pool objects, can separate VM machine types, and can allow for delegation of administrator rights. Outside the CAF best practice for Landing zone design, here is a sample resource group structure for WVD.   **NOTE:  This structure should be duplicated for each region you deploy into.**

- Networking:  Generally created as part of the Cloud Adoption Framework Landing zone
- WVD Service Objects:  Separate WVD Service Objects from Host Pool VMs.  Service objects include Workspaces, Host Pools and RemoteApp/Desktops App groups. Create a resource group for these objects
- Storage:  If not already created as part of CAF, create a resource group for storage accounts
- Images:  Create a resource group for custom VM images
- Host Pools:  Create a resource group for each host pool

Basic Structure
- Subscription
--- rg-wu2-network-services
--- rg-wu2-wvd-storage
--- rg-wu2-wvd-service-objects
--- rg-wu2-wvd-images
--- rg-wu2-wvd-hostpool1
--- rg-wu2-wvd-hostpool2
--- rg-wu2-wvd-hostpool3
 

## **Enable Screenshot protection**


Enable screen capture protection (preview)

The [screen capture protection feature](https://docs.microsoft.com/en-us/azure/virtual-desktop/security-guide#session-host-security-best-practices) prevents sensitive information from being captured on the client endpoints. When you enable this feature, remote content will be automatically blocked or hidden in screenshots and screen shares. It will also be hidden from malicious software that may be continuously capturing your screen's content. We recommend you disable clipboard redirection to prevent copying of remote content to endpoints while using this feature.

  

This policy is enforced at the host level by configuring a registry key. To enable this policy, open PowerShell and set the fEnableScreenCaptureProtection registry key by running this cmdlet:

  

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fEnableScreenCaptureProtection /t REG_DWORD /d 1

