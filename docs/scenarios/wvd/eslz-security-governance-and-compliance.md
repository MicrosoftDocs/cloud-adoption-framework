---
title: Security, governance, and compliance for Azure Virtual Desktop infrastructure
description: Learn key design considerations and recommendations for a governance baseline in an Azure Virtual Desktop infrastructure.
author: AdamWhitlatch
ms.author: brblanch
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
--- 

<!-- cspell:ignore hostpool -->

# Governance baseline considerations for Azure Virtual Desktop

This article covers key design considerations and recommendations for security, governance, and compliance in a [Cloud Adoption Framework enterprise-scale landing zone architecture](../../ready/enterprise-scale/architecture.md) for [Azure Virtual Desktop](/azure/virtual-desktop/overview).

 As with any IT service, it's important to build the environment to scale, secure it, and be able to operate your environment simply and efficiently. While the Azure Virtual Desktop service does most of the front-end work, you still need to have the right control mechanisms to keep your systems and data safe. You also need processes to continually review those controls, report changes and, if necessary, remediate. At the end of this article, you'll understand the critical design areas for security, governance, and compliance, and you'll have clear guidance on Microsoft recommendations in each area.

In most cases, Azure Virtual Desktop is deployed into a landing zone as part of the [Microsoft Cloud Adoption Framework](../../overview.md) for Azure. Microsoft recommends reviewing the Cloud Adoption Framework to ensure that your environment has the right foundation for security, compliance, governance, and cost management.

## Design considerations

- **Identity:** Decide on a tool for multifactor authentication and conditional access for user identities. For Azure Virtual Desktop, as for most workloads in Azure, identity is a security boundary. User identity is the central mechanism of user access to desktops, applications, and company data. It's best to protect user credentials during sign-in with multifactor authentication and conditional access.
- **Audit logs:** Audit logs and Azure Virtual Machines are critical to troubleshooting when issues arise, but also serve as a security tool for an Azure Virtual Desktop environment. What tools do you use to capture security or performance logs within your virtual machine (VM)? Are audit logs for Azure Virtual Desktop stored in a central Azure Monitor Logs workspace, or in an isolated Azure Monitor Logs workspace dedicated for Azure Virtual Desktop? Also consider whether to use a partner tool to analyze the logs for security patterns or other reporting needs. What tools do you use to capture security or performance logs within your VM?
- **Compliance:** Nearly all corporations are required to comply with government or industry regulatory policies. It's important to review those policies with your compliance team and have the correct controls for your Azure Virtual Desktop landing zone. You may need controls for specific policies like the Payment Card Industry Data Security Standard (PCI DSS) or the Health Insurance Portability and Accountability Act of 1996 (HIPAA).
- **Defined roles:** Defined administrative, operations, and engineering roles within your organization plays a large part in defining the day-to-day operations in the Azure Virtual Desktop environment. Knowing which team is responsible for what area will help determine Azure role-based access control (RBAC) roles and configuration. Be sure to review the identity and access management section for more information. Consider creating a RACI matrix to map who owns each responsibility, then build controls into the Cloud Adoption Framework management group structure.
- **Security audit tools:** What tools and methods do you use to continually scan, and evaluate your environment for security audits, and vulnerabilities?
- **Software updates:** Define a strategy for continuous operations to keep Windows and applications current.
- **Disk encryption:** Do you have regulatory or internal security requirements to manage and maintain your own keys for encrypting VMs at rest? Are Azure Key Vault keys acceptable for encryption? Do you need advanced hardware encryption or in-guest OS encryption like BitLocker? How will data at rest or data in transit be encrypted?
- **Data protection:** How will data in the VMs be protected? You can use a tool like [Azure Information Protection](/azure/information-protection/what-is-information-protection) to protect data. Consider using antimalware tools for protection.
- **Service tags:** A service tag represents a group of IP address prefixes for an Azure service. Microsoft manages the address prefixes and automatically updates the tags as addresses change, simplifying frequent updates to network security rules. Sometimes it's necessary to have additional tags in an Azure Virtual Desktop environment for areas like chargeback, security audits, reporting, and alerts.
- **Policies:** Policies for managing your Azure Virtual Desktop environment should be defined in your Cloud Adoption Framework platform design. Include policies pertaining to security, RBAC controls, regulatory governance, and types of resources that can be deployed.
- **Resource group organization:** Organize your resource groups to facilitate good management and prevent accidental deletions, and define who can manage your environment.

## Design recommendations

- **Multifactor authentication:** Multifactor authentication for all users is essential to securing desktops and company data. Use multifactor authentication in Azure Active Directory or a partner multifactor authentication tool.
- **Conditional access:** Conditional access helps you to manage risks when granting access to users in your Azure Virtual Desktop environment. Before deciding to grant access to a user, consider who the user is, how they sign in, and which device they use. See [What is Azure AD Conditional Access?](/azure/active-directory/conditional-access/overview) for an overview of conditional access and advice on best practices.
- **Enable logging:** Enable Azure Virtual Desktop service logging, host pool logging, and workspace logging for all Azure Virtual Desktop objects. For more information, see [Use Log Analytics for the diagnostics feature](/azure/virtual-desktop/diagnostics-log-analytics). Enable Azure Virtual Desktop host logging and performance logging as outlined in the management and monitoring section of the Azure Virtual Desktop landing zone architecture.
- **Endpoint protection:** Microsoft strongly advises enabling a next-generation antivirus to create a protection layer and response mechanism to threats. An example is [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint). It's integrated with Azure Security Center to provide a data analytics and AI approach to proactively maintain security. Other security needs like network protection, web content filtering, attack surface reduction, security baselines for VM hosts, and threat vulnerability management should be part of your Azure Virtual Desktop design. See the following section for links to Azure Virtual Desktop host security best practices.
- **Microsoft Information Protection:** Enable and configure Microsoft Information Protection to discover, classify, and protect sensitive information wherever it is.
- **Control device redirection:** Only enable what your end users need. Common devices to disable include local hard drive access and USB or port restrictions. Limiting camera redirection and remote printing can help protect company data. Disable clipboard redirection to prevent copying remote content to endpoints.
- **Policy tools:** Use group policy and a device management tools like Intune and Microsoft Endpoint Configuration Manager to maintain a thorough security and compliance practice for your desktops.
- **Patch management:** Patch management is a vital part of the overall security strategy for your environment. You need a consistent practice and deployment policy to maintain secure systems. Tools like Microsoft Endpoint Configuration Manager and partner applications can help manage patches and keep your systems up to date.
- **Screen capture:** The screen capture feature, when enabled, prevents screen information from capture on the client endpoints. Remote content is blocked or hidden in screenshots and screen shares, and from software that captures screen content. For more information, see [Enable screen capture protection](/azure/virtual-desktop/security-guide#session-host-security-best-practices).
- **Security baseline:** Use a security baseline as a starting point for securing the Windows operating system. For more information, see [Windows security baselines](/windows/security/threat-protection/windows-security-baselines).
- **Application control:** Implement [Windows Defender Application Control and AppLocker](/windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview), which allows organizations to control drivers and applications that can run on Windows 10 clients.
- **Azure Security Center:** Enable Security Center to help maintain security compliance and alerting within your environment.
- **Microsoft Secure Score:** [Microsoft Secure Score](/microsoft-365/security/defender/microsoft-secure-score) provides recommendations and best practice advice for increasing your security posture and securing surrounding infrastructure with documented best practices.
- **Disk encryption:** Enable Azure Disk Encryption for your VMs. This option is configured by default with Azure-provided keys. In many cases, this configuration is acceptable to security teams and auditors. However, if you have a security practice or regulatory requirement that requires you to maintain your own keys, you can implement that practice for Azure Virtual Desktop VMs.
- **Key Vault:** Enable Key Vault to protect security principal accounts and encryption keys.
- **Security best practices:** Review [security best practices for Azure Virtual Desktop](/azure/virtual-desktop/security-guide) as a starting point to security within your environment, and implement as appropriate.
- **Azure Virtual Desktop service and internet traffic routing and inspection:** By using reverse connect, built into the Azure Virtual Desktop platform, VMs do not need a public IP. VMs communicate outbound securely to Azure Virtual Desktop service URLs over port 443. It's good practice to enable Azure Firewall or a partner firewall appliance for traffic logging, routing, or inspection. Having a web proxy filter to monitor and log internet traffic is also recommended.
- **Azure Virtual Desktop metadata:** A good resource group design for Azure Virtual Desktop can help protect against accidental deletion of workspace and host pool objects, can separate VM machine types, and can allow for administrators from different departments. Outside the Cloud Adoption Framework best practice for RBAC, security controls and landing zone design, here is a sample resource group structure for Azure Virtual Desktop.

> [!NOTE]
> This structure should be duplicated for each region you deploy into.

```text
    - Networking:  Generally created as part of the Cloud Adoption Framework Landing zone
    - Azure Virtual Desktop Service Objects:  Separate Azure Virtual Desktop Service Objects from Host Pool VMs.  Service objects include Workspaces, Host Pools and RemoteApp/Desktops App groups. Create a resource group for these objects.
    - Storage:  If not already created as part of Cloud Adoption Framework, create a resource group for storage accounts
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
```

## Azure Virtual Desktop host operating system security

In addition to service level logging for Azure Virtual Desktop, administrators need to have a security strategy inside the guest operating system. Microsoft recommends security tools such as:

- [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint/deployment-vdi-microsoft-defender-antivirus): OS-level antivirus and antimalware
- [Threat protection (Windows 10)](/windows/security/threat-protection/): Threat protection overview and details
- [Azure Monitor agents](/azure/azure-monitor/deploy) and [Azure Monitor deployment at scale with Azure Policy](/azure/azure-monitor/deploy-scale): Capture guest logs and performance metrics
- [Guest configuration extension for local machines](/azure/governance/policy/concepts/guest-configuration#enable-guest-configuration): Monitor, alert, and track guest changes and audit reports
- [Azure Monitor dependency extension](/azure/virtual-machines/extensions/agent-dependency-windows): Troubleshoot guest connections, logs traffic flows, and configuration
- [Enable screen capture protection](/azure/virtual-desktop/security-guide#enable-screen-capture-protection-preview): Protects from remote capture of data
- [Azure Security Center](/azure/security-center/security-center-services?tabs=features-windows): Security audits, regulatory compliance scanning, policy compliance
- [Windows security baselines](/windows/security/threat-protection/windows-security-baselines)

For more information on Azure Virtual Desktop best practices, see [Session host security best practices](/azure/virtual-desktop/security-guide#session-host-security-best-practices). For a detailed list of best practices for Azure VMs, see [Security recommendations for virtual machines in Azure](/azure/virtual-machines/security-recommendations).