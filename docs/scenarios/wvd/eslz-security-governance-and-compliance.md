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

This article covers key Design Considerations and Recommendations for Security, Governance, and Compliance in a Microsoft Azure [Enterprise Scale Landing Zone](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) (ESLZ) for [Windows virtual Desktop](https://docs.microsoft.com/en-us/azure/virtual-desktop/overview) (WVD). Like any IT service it is important to build the environment to scale, build in security, and be able to operate your environment simply and efficiently. While the WVD Service does most of the front-end work, you still need to have the right control mechanisms in place to keep your systems and data safe. You also need processes in place to continually review those controls, report changes and remediate, if necessary. At the end of this article, you will understand the critical design areas for Security, Governance, and Compliance as well as have clear guidance on Microsoft recommendations in each area.

  

In most cases Windows Virtual Desktop will be deployed into a landing zone as part of the [Microsoft Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/overview). Microsoft recommends reviewing the Cloud Adoption Framework (CAF) to ensure your environment has the right foundation for security, compliance, governance, and cost management.

  

In addition to the CAF reference architectures and best practices you will need to consider the following:

## **Design Considerations**




- What is your tool for Multi-factor Authentication and Conditional Access for user Identities? Like most workloads in Azure, Identity becomes a security boundary. User identity becomes the central mechanism in how users access desktops, applications, and company data. Protecting user credentials at login with MFA and/or conditional serves as a primary level of proactive protection in WVD.  
-Audit Logs and Virtual Machine are critical to troubleshooting when issues arise, but also serve as a security tool for a WVD environment. What tools do you use to capture security or performance logs within your VM? Consider where Audit logs will be stored for WVD - in a central Log Analytics workspace or in an isolated Log Analytics workspace dedicated for WVD. Also consider if you will use a 3rd party tool to analyze the logs for security patterns or other reporting needs.  What tools do you use to capture security or performance logs within your VM?
- Compliance - Nearly all corporations are required to comply with government or industry regulatory policies. It's important to review those policies with your compliance team and put in the correct controls for your WVD landing zone. Controls Very specific policies like PCI or HIPAA might be needed. 
- Defined Administrative, Operations, and Engineering roles within your organization plays a large role in defining the day-to-day operations withing the WVD environment. Knowing which team will be responsible for what area will help determine RBAC Roles and configuration. Be sure to review the Identity and access management section for more information. Consider creating a RACI chart to help map who will own each responsibility, then build in controls into the CAF Management Group Structure. 

- What tools or what methods will you use to continually scan, and evaluate your environment for security audits, and vulnerabilities? 
- VM Management - Define a strategy for continuous operations to keep the Windows OS and applications current  
- Disk Encryption - Do you have regulatory or internal security requirements to manage and maintain your own keys for encrypting VMs at rest? Are standard Azure Keys acceptable for encryption? Do you need advanced HW encryption or in guest OS encryptions like Bitlocker? How will data at rest or date in transit be encrypted?
- Information Protection - How will your Data in the VMs be protected. A tool like [AIP](https://docs.microsoft.com/azure/information-protection/what-is-information-protection) can be utilized to protect data. Other security tools like Antivirus, Anti-malware are likely used to keep your systems healthy.

- Service Tags - Part of a mature cloud adoption framework is to utilize tags for all resources. Sometimes it's necessary to have additional tags in a WVD environment for areas like chargeback, Security Audits, reporting, and alerts.  
- Azure Policies should be defined in your Cloud Adoptions Framework platform design decisions. Policies pertaining to security, RBAC controls, regulatory governance, and types of resources that can be deployed are all among common policies typically deployed in a WVD Environment. 
- Resource Group organization - How you organize your resource groups can have an impact on management and prevent accidental deletions with your WVD environment. It can also serve as a security or operational boundary which defines who can manage your environment.




## **Design Recommendations**

- Enable Multi-factor Authentication for all users with Azure MFA or 3rd party MFA tools - This is a primary step and helping to secure access to desktops, and company data. 
- Enable [Conditional Access](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/overview) to you manage risks before you grant users access to your Windows Virtual Desktop environment. When deciding which users to grant access to, we recommend you also consider who the user is, how they sign in, and which device they're using. This [Common signals](https://docs.microsoft.com/azure/active-directory/conditional-access/overview#common-signals) article can help you decide best practice
 
- Enable WVD Service, Host Pool, and Workspace Logging for all WVD objects - [Windows Virtual Desktop Diagnostic Log](https://docs.microsoft.com/azure/virtual-desktop/diagnostics-log-analytics)
- Enable WVD Host logging and performance logging as outlined in the Management and Monitoring section of the WVD Landing Zone Architecture

- Endpoint Protection - Microsoft strongly advises enabling Next-generation antivirus like [Microsoft Defender for Enpoint](https://docs.microsoft.com/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint?view=o365-worldwide), to create a protection layer and response mechanism to threats. Microsoft Defender an integration with Azure Security center to provide a Data analytics and AI approach to proactively maintain security within your environment. Other areas like Network Protection, Web Content Filtering, Attack Surface Reduction, Security baselines for VM hosts, and Threat Vulnerability Management should be included in your WVD Design - see the section below for links to WVD Host security best practices.
- Enable and configure Microsoft Information Protection - Discover, classify, and protect sensitive information wherever it lives or travels
- Control device redirection - Only enable what your end users need. Common devices to disable include local hard drive access and USB or port restrictions. Camera redirection, Clipboard, and remote printing also serve as security lockdowns that can help protect company data.
- Use group policy and/or a device management tool like Intune or Microsoft Endpoint Configuration Manager to maintain a thorough security and compliance practice for your desktops.
- Patch management - This is a vital piece to the overall security strategy for your environment. A consistent practice and deployment policy is needed to maintain secure systems. Tools like Microsoft Endpoint Configuration Manager or 3rd party application can aid in deploying security patches and keeping your systems up to date.
- Enable [screen capture protection feature](https://docs.microsoft.com/azure/virtual-desktop/security-guide#session-host-security-best-practices) - prevents sensitive information from being captured on the client endpoints. When you enable this feature, remote content will be automatically blocked or hidden in screenshots and screen shares. It will also be hidden from malicious software that may be continuously capturing your screen's content. We recommend you disable clipboard redirection to prevent copying of remote content to endpoints while using this feature.
- Utilize Windows Security Baseline as a starting point for security the Windows OS - [Windows Security Baselines](https://docs.microsoft.com/windows/security/threat-protection/windows-security-baselines) 
- Implement [Windows Defender Application Control and AppLocker Microsoft](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview) which allows organizations to control drivers and applications that can run on Windows 10 clients, thereby giving an enterprise security team a much richer security posture. 


- Enable Azure Security center help maintain security compliance and alerting within your environment. Secure Score provides recommendations and best practice advice for increasing your security posture and Securing surrounding infrastructure with documented best practices. 
- Enable Azure disk encryption for your VMs. This option is configured by default with Azure provided keys. In many cases it is acceptable to Security teams, and auditors. However, if you have a security practice or regulatory requirement that requires you to maintain your own keys, you can implement that practice for WVD VMs.    
- Enable Azure Key Vault to protect security principal accounts and encryption keys
- Review and implement the WVD Security Guide [here](https://docs.microsoft.com/azure/virtual-desktop/security-guide) as a starting point to security within your environment.
- WVD service and Internet traffic routing and inspection - By using reverse connect, built into the WVD platform, VMs do not need a public IP. VMs communicate outbound securely to WVD Service URLs over port 443. It is, however, good practice to enable an Azure Firewall or a 3rd party firewall appliance for traffic logging, routing, and/or inspection. A Web Proxy filter is also a good practice to monitor and log internet traffic.  


WVD Metadata - A good resource group design for WVD can help protect against accidental deletion of Workspace and Host Pool objects, can separate VM machine types, and can allow for administrators from different departments. Outside the CAF best practice for RBAC and Security Controls and Landing zone design, here is a sample resource group structure for WVD.   **NOTE:  This structure should be duplicated for each region you deploy into.**

    - Networking:  Generally created as part of the Cloud Adoption Framework Landing zone
    - WVD Service Objects:  Separate WVD Service Objects from Host Pool VMs.  Service objects include Workspaces, Host Pools and RemoteApp/Desktops App groups. Create a resource group for these objects.
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

- [Microsoft Defender for Endpoint](https://docs.microsoft.com/windows/security/threat-protection/microsoft-defender-antivirus/deployment-vdi-microsoft-defender-antivirus) - OS Level Anti-virus and Anti-malware
- [Threat Protection (Windows 10)](https://docs.microsoft.com/windows/security/threat-protection/) - Threat Protection overview and details
- [Azure Monitor  / Log Analytics Agent](https://docs.microsoft.com/azure/azure-monitor/deploy)   - [Deploy at scale with Azure Policy](https://docs.microsoft.com/en-us/azure/azure-monitor/deploy-scale) - Capture Guest Logs and Performance Metrics
- [Virtual Machine Guest Config Extension](https://docs.microsoft.com/azure/governance/policy/concepts/guest-configuration#enable-guest-configuration) - Monitor, alert, and track guest changes & audit reports
- [Microsoft Dependency Extension](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-dependency-windows) - Troubleshoot guest connections, logs traffic flows, and configuration
- [Enable Screen Capture Protection](https://docs.microsoft.com/azure/virtual-desktop/security-guide#:~:text=Azure%20security%20best%20practices.%20Windows%20Virtual%20Desktop%20is,Virtual%20Desktop%20fits%20into%20your%20larger%20Azure%20ecosystem) - Protects from remote capture of data
- [Azure Security Center](https://docs.microsoft.com/azure/security-center/security-center-services?tabs=features-windows) - Security Audits, Regulatory compliance scanning, Policy Compliance
- [Windows Security Baselines](https://docs.microsoft.com/windows/security/threat-protection/windows-security-baselines)

A more detailed list for Security Best Practices in WVD can be found can be found at [here](https://docs.microsoft.com/en-us/azure/virtual-desktop/security-guide#session-host-security-best-practices), and a detailed list of Azure Virtual Machine best practice can be found [here](https://docs.microsoft.com/en-us/azure/virtual-machines/security-recommendations)