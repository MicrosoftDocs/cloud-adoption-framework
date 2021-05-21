---
title: Securing Windows Virtual Desktop
description: Best Practices for securing Windows Virtual Desktop
author: NaomiOooo
ms.author: naomio
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Securing Windows Virtual Desktop
Windows Virtual Desktop (WVD) provides a scaleable, virtualized, and familiar Windows 10 desktop experience for users, while providing administrators a wide breadth of configuratble options to customize their security posture.


## Security Responsibilities

Securing Windows Virtual Desktop requires a combination of deployment-specific configuration as well as wider-reaching global settings. While configuring an item such as idle time before locking are specific to the Windows Virtual Desktop service, enabling multi-factor authentication (MFA) can have implications far outside of the service alone.

Depending on how your organization has divided its security responsibilities, implementing best practice guidelines for WVD may require the inclusion of mulitple teams or individuals. For example, in a Central IT configuration, ownership of role-based access control (RBAC), Client OS, and monitoring may require the input of three different teams, whereas in a workload owner-centric configuration, the workload owner alone may be responsible for determining the settings for some or all of the above items.


## Identity and Access Control for Windows Virtual Desktop

Determining your organization's [identity management and access control](/azure/security/fundamentals/identity-management-best-practices) policy is a major aspect of your overall cloud journey. Enforcing a secure login method by utilizing conditional access policies and requiring multi-factor authentication will help ensure that the person accessing the desktop resource has the permission to do so. WVD utilizes Azure Active Directory (AAD) as the default identity and access management provider. Careful planning and consideration should be taken when selecting roles and discovering the needed level of access - ideally utilizing roles which already exist in [RBAC](/azure/virtual-desktop/faq#what-are-the-minimum-admin-permissions-i-need-to-manage-objects).

### Conditional Access and Multi-Factor Authentication

Planning to enable MFA within an Azure enviornment is a [multi-step process](/azure/active-directory/authentication/howto-mfa-getstarted) with several prerequisites and deployment considerations. Used in conjunction with [conditional access policies](/azure/active-directory/authentication/howto-mfa-getstarted#enable-multi-factor-authentication-with-conditional-access), MFA and conditional access policies work together to give the administrator greater flexibility in determining when and how to challenge user login attempts. 

To further secure your WVDs, usage of elevated accounts and/or administrator accounts is discouraged for general access to desktops. Allowing installation of approved software packages can be provided through solutions such as Microsoft Endpoint Manager. Utilization of a software package manager also ensures that the application is being provided from a trusted source.


## Security Event Monitoring and Optimization
### Enable Azure Security Center
We recommend you enable Azure Security Center Standard for subscriptions, virtual machines, key vaults, and storage accounts.

With Azure Security Center Standard, you can:

- Manage vulnerabilities.
- Assess compliance with common frameworks like PCI.
- Strengthen the overall security of your environment.

To learn more, see [Onboard your Azure subscription to Security Center Standard.](/azure/security-center/security-center-get-started)

### Improve your Secure Score

Secure Score provides recommendations and best practice advice for improving your overall security. These recommendations are prioritized to help you pick which ones are most important, and the Quick Fix options help you address potential vulnerabilities quickly. These recommendations also update over time, keeping you up to date on the best ways to maintain your environment’s security. To learn more, see [Improve your Secure Score in Azure Security Center.](/azure/security-center/secure-score-security-controls)

### Azure Defender
To protect your deployment from known malicious software, we recommend enabling endpoint protection on all session hosts. You can use either Windows Defender Antivirus or a third-party program. To learn more, see Deployment guide for [Windows Defender Antivirus in a VDI environment.](/microsoft-365/security/defender-endpoint/deployment-vdi-microsoft-defender-antivirus) 



## Next Steps
Review the Windows Virtual Desktop documentation:
- [Windows Virtual Desktop Security Best Practices](/azure/virtual-desktop/security-guide)
- [Windows Virtual Desktop security baseline](/security/benchmark/azure/baselines/windows-virtual-desktop-security-baseline)
