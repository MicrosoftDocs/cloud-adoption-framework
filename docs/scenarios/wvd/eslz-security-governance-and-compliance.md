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

This article covers key Design Considersations and Reccomendations for Security, Governance and Complaince in a Microsoft Azure [Enterprise Scale Landing Zone](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) (ESLZ) for [Windows virtual Desktop](https://docs.microsoft.com/en-us/azure/virtual-desktop/overview) (WVD). Like any IT service it is important to build the environment to scale, build in security, and be able to operate your environment simply amd effeciently. While the WVD Service does most of the front end work, you still need to have the right control mechanisims in place to keep your systems and data safe. You also need processes in place to continually review those controls and report changes to appropriate IT teams. At the end of this article you should understand the critical design areas for Security, Governance, and Compliance as well and have clear guidance on microsoft reccomendations in thes Areas.

  

In most cases Windows Virtual Desktop will be deployed into a landing zone as part of the [Microsoft Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/overview). Microsoft reccomends reviewing the Cloud Adoption Framework (CAF) to ensure your environment has the right foundation for security, compliance, governance, and cost management.

  

In addition to the CAF reference architectures and best practices you will need to consider the following in addition to Cloud Adoption Framework:

## **Design Considerations**



- Audit Logs are critical to troubleshooting when issues arise, but also serve as a security tool for a WVD environment. Consider where Audit logs be stored for WVD - in a central Log Anlaytics workspace or in an isolated Log Analytics workspace dedicated for WVD. Also consider if you will use a 3rd party tool to analyze the logs for security patterns or other reporting needs.  
- Enable MFA and Conditional Access for user Identities. Like most workloads in Azure, Identity becomes a security boundry. User identity becomes the central mechanism in how users access desktops, applications, and company data. Protecting user credentials at login with MFA and/or conditional access serves as a primary level of proactive protection in WVD.  
- Defined Administrative, Operations, and Engineering roles within you organization plays a large role in defining the day to day operations withing the WVD environment. Knowing which team will be responsible will help determin RBAC Roles and configuration. Be sure to review the Identiy and access management section for more information. Consider creating a RACI chart to help map who will own each responsibility, then build in controls to the WVD Landing zone 
- Compliance - nearly all corporations are required to comply with government or industry regulatory policies - It's important to review those policies with your compliance team and put in the correct controls for your landing zone. Many of those policies will be configured as part of Cloud Adoption Framework, but you may find that part of your WVD environment is controlled by very specific policies like PCI or HIPAA. 
- What tools or what methods will you use to continually scan, and evaluate your enviroment for security audits, and vulnerabilities? 
- VM Management - Define a strategy for continuous operations when it comes to OS Patching, compliance scanning, Application Security. A repeatable process to update, and document these are is necessary  to help maintain overall security in the environment and pass regulatory audits.  
- Governance - Resource Group organization - How you organize your resource groups can have an impact on simplified management, and prevent accidental deletions with your WVD environment. It can also serve as a security or operational boundry to define who can maange your environment.
- Service Tags - Part of a mature cloud adoption framework is to utilize tags for all resources. Sometimes it's necessary to have additional tags in a WVD environment for areas like chargeback, Security Audits, reporting, and alerts.  
- Azure Policies - Most Azure Policies will be defined in your Cloud Adoptions Framework decsions. Additional areas to consider include for a WVD Landing Zones, is policy to limit the type of VMs that can be used, or a policy to proactively install and configure logging for each VM in the WVD landing zone.
- Disk Encryption - Do you have regulatory or internal security requirements to manage and maintain your own keys for encryptioning VMs at rest? Are standard Auzre Keys acceptable for encryption. Do you need advanced HW assisted encryption or in guest encryptions like Bitlocker? 
- Information Protection - How will your Data, and VM be protected. What tools do you use to capture security or performance logs within your VM. What security tools, like Antivirus, Anti-malware, or data protection do you use in your environment to keep your systmes healthy, and data secure.



## **Design Recomendations**

- Review the WVD Security Guide [here](https://docs.microsoft.com/azure/virtual-desktop/security-guide) as a starting point to security your environment. 
- Enable WVD Service, Host Pool, and Workspace Logging for all WVD objects - [Windows Virtual Desktop Diagnostic Log](https://docs.microsoft.com/azure/virtual-desktop/diagnostics-log-analytics)
- Enable WVD Host logging and performance logging as outlined in the Management and Monitoring section of the WVD Landing Zones
- Enable [Conditional Access](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/overview). This lets you manage risks before you grant users access to your Windows Virtual Desktop environment. When deciding which users to grant access to, we recommend you also consider who the user is, how they sign in, and which device they're using. This [Common signals](https://docs.microsoft.com/azure/active-directory/conditional-access/overview#common-signals) article can help you decide best practice and how to deploy
- Enable Multi-factor Authentication for all users with Azure MFA or 3rd party MFA tools - This is a primary step and helping to secure access to desktops, and company data. 
- Control device redirection - Only enable devices that your end users need. Common devices to disable include local hard drive acces, USB or port restrictions, Camera redirection. Clipboard, and remote printing also service as security lockdowns that can help protect company data
- Endpoint Protection - Microsoft strongly advises enabling Next-generation antivirus like Microsoft Defender for Enpoint, to create a protection layer and response mechanism to threats. Microsoft Defender integrates with Azure Security center to provide a Data analytics and AI appraoch to proactivey maintaining security within your environment. Other areas like Network Protection, Web Content Filtering, Attack Surface Reduction, Security baselines for VM hosts, and Threat Vulnerability Management should be included in your WVD Design - see the section below for links to WVD Host secuirty best practices.
- Enable and configure Microsoft Information Protection - Discover, classify, and protect sensitive information wherever it lives or travels.
- If you are not using a Policy engine like Intune to manage your desktops we recommend a thorough group policy strategy to enable security and complaince policies for your desktops. Areas like “Set Time Limit For Active But Idle Remote Desktop Services Sessions” and “Set time limit for disconnected sessions” can help maintain security in your environment
- Patch management - This is a vital piece to the overall security strategy for your environment. A consitent practice and deployment policy is needed to maintain secure systems. Tools like Microsoft Endpoint Manager (MEM) or 3rd party applications can aid in deploying security patches and keeping your systems up to date.
- Enable Azure Security center and Microsoft Defender for Endpoints, combined to raise the bar in your security posture, and also helps maintain compliance within your environment. Areas include Providing threat and vulnerability management assessments, and Operationalizing your Secure Score. Secure Score provides recommendations and best practice advice for increasing your security posture, Following Azure best practices, and Securing surrounding infrastructure with documented best practices. 
- Always enable Azure disk encryption for your VMs.  By defult this option is configured with Azure provided keys. In many cases it is acceptable to Security teams, and auditors. However, if you have a security practice or regulatory requirement to maintain your own keys, you can implement that practice with WVD VMs.   
- Enable [screen capture protection feature](https://docs.microsoft.com/azure/virtual-desktop/security-guide#session-host-security-best-practices) - prevents sensitive information from being captured on the client endpoints. When you enable this feature, remote content will be automatically blocked or hidden in screenshots and screen shares. It will also be hidden from malicious software that may be continuously capturing your screen's content. We recommend you disable clipboard redirection to prevent copying of remote content to endpoints while using this feature.
- Enable Keyvault to protect security principal accounts and encryption keys
- WVD Metadata - A good resource group design for WVD can help protect against accidental deletion of Workspace and Host Pool objects. It can separate VM machine types, and can allow for delegation of administrator rights. Outside the CAF best practice for Landing zone design, here is a sample resource group structure for WVD.   **NOTE:  This structure should be duplicated for each region you deploy into.**
    - Networking:  Generally created as part of the Cloud Adoption Framework Landing zone
    - WVD Service Objects:  Separate WVD Service Objects from Host Pool VMs.  Service objects include Workspaces, Host Pools and RemoteApp/Desktops App groups. Create a resource group for these objects
    - Storage:  If not already created as part of CAF, create a resource group for storage accounts
    - Images:  Create a resource group for custom VM images
    - Host Pools:  Create a resource group for each host pool
    - Basic Structure
        - Subscription
            - rg-wu2-network-services
            - rg-wu2-wvd-storage
            - rg-wu2-wvd-service-objects
            - rg-wu2-wvd-images
            - rg-wu2-wvd-hostpool1
            - rg-wu2-wvd-hostpool2
            - rg-wu2-wvd-hostpool3

 
            
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
