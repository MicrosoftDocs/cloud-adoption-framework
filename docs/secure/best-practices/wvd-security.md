---
title: Securing Windows Virtual Desktop
description: Learn best practices for securing your Windows Virtual Desktop environment.
author: NaomiOooo
ms.author: naomio
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Best practices for securing a Windows Virtual Desktop environment

Windows Virtual Desktop (WVD) provides a scalable, virtualized, and familiar Windows 10 desktop experience for users, while providing administrators a wide breadth of configurable options to customize their security posture.

## Security responsibilities

Securing Windows Virtual Desktop requires a combination of deployment-specific configuration as well as wider-reaching global settings. While configuring an item such as idle time before locking are specific to the Windows Virtual Desktop service, enabling multifactor authentication can have implications far outside of the service alone.

Depending on how your organization has divided its security responsibilities, implementing best practice guidelines for WVD may require the inclusion of multiple teams or individuals. For example, in a central IT configuration, ownership of role-based access control (RBAC), client OS, and monitoring may require the input of three different teams, whereas in a workload owner-centric configuration, the workload owner alone may be responsible for determining the settings for some or all of the above items.

## Identity and access control for Windows Virtual Desktop

Determining your organization's [identity management and access control](/azure/security/fundamentals/identity-management-best-practices) policy is a major aspect of your overall cloud journey. Enforcing a secure login method by using conditional access policies and requiring multifactor authentication will help ensure that the person accessing the desktop resource has the permission to do so. WVD uses Azure Active Directory (Azure AD) as the default identity and access management provider. Careful planning and consideration should be taken when selecting roles and discovering the needed level of access, ideally using roles that already exist in [RBAC](/azure/virtual-desktop/faq#what-are-the-minimum-admin-permissions-i-need-to-manage-objects).

### Conditional access and multifactor authentication

Planning to enable multifactor authentication within an Azure environment is a [multistep process](/azure/active-directory/authentication/howto-mfa-getstarted) with several prerequisites and deployment considerations. Used in conjunction with [conditional access policies](/azure/active-directory/authentication/howto-mfa-getstarted#enable-multi-factor-authentication-with-conditional-access), multifactor authentication and conditional access policies work together to give the administrator greater flexibility in determining when and how to challenge user login attempts.

To further secure your WVD environment, avoid using elevated accounts or administrator accounts for general access to desktops. Allowing installation of approved software packages can be provided through solutions such as Microsoft Endpoint Manager. Utilization of a software package manager also ensures that the application is being provided from a trusted source.

## Security event monitoring and optimization

### Enable Azure Security Center

We recommend you enable Azure Security Center Standard for subscriptions, virtual machines, key vaults, and storage accounts.

With Azure Security Center Standard, you can:

- Manage vulnerabilities.
- Assess compliance with common frameworks like PCI.
- Strengthen the overall security of your environment.

To learn more, see [Onboard your Azure subscription to Security Center Standard](/azure/security-center/security-center-get-started).

### Improve your secure score

Microsoft Secure Score provides recommendations and best practice advice for improving your overall security. These recommendations are prioritized to help you pick which ones are most important, and the quick fix options help you address potential vulnerabilities quickly. These recommendations also update over time, keeping you up to date on the best ways to maintain your environment's security. To learn more, see [Improve your secure score in Azure Security Center](/azure/security-center/secure-score-security-controls).

### Azure Defender

To protect your deployment from known malicious software, we recommend enabling endpoint protection on all session hosts. You can use either Windows defender antivirus or a third-party program. For more information, see the deployment guide for [Microsoft Defender Antivirus in a virtual desktop infrastructure environment](/microsoft-365/security/defender-endpoint/deployment-vdi-microsoft-defender-antivirus).

## Next steps

Review the Windows Virtual Desktop documentation:

- [Windows Virtual Desktop security best practices](/azure/virtual-desktop/security-guide)
- [Windows Virtual Desktop security baseline](/security/benchmark/azure/baselines/windows-virtual-desktop-security-baseline)
