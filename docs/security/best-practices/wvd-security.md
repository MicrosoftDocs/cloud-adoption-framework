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

# Intro
WVD intro here. Securing WVD. 

[This is a test](../innovation-security.md)


## Security Responsibilities

As a Software as a Service (SaaS) offering within Azure, Windows Virtual Desktop hands control of specific configuration aspects to the individuals deploying the service. Items such as deployment configuration, host OS options, or application security, will require additional configuration consideration before deployment. However other aspects, such as the virtualization control plane or the physical aspects of the hardware are already secured by Azure. While settings such as various host OS configurations are specific to the Windows Virtual Desktop service, considerations for things such as enabling multi-factor authentication (MFA) may have a wider impact.

Depending on how your organization has organized its security responsibilities, following best practice guidelines for WVD may require the inclusion of mulitple teams or individuals. For example, in a Central IT configuration, ownership of role-based access control (RBAC), Client OS, and monitoring may require the input of three different teams. In a workload owner-centric configuration, the workload owner alone may be responsible for determining the settings for some or all of the above items.


## Conditional Access and Multi-Factor Authentication

Determining your organization's [identity management and access control](https://docs.microsoft.com/azure/security/fundamentals/identity-management-best-practices) policy is a major aspect of your overall cloud journey. Enforcing a secure login method by utilizing conditional access policies and requiring multi-factor authentication will help ensure that the person accessing the desktop resource has the permission to do so. 

To further secure your WVDs, usage of elevated accounts and/or administrator accounts is discouraged for general access to desktops. Installation of software packages can be provided through solutions such as Microsoft Endpoint Manager. 

## Microsoft Defender for Endpoint for Windows Virtual Desktop







### Azure Defender

## Next Steps
[Windows Virtual Desktop Security Best Practices](https://docs.microsoft.com/azure/virtual-desktop/security-guide)
[Windows Virtual Desktop security baseline](https://docs.microsoft.com/security/benchmark/azure/baselines/windows-virtual-desktop-security-baseline)
