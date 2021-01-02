---
title: "Enterprise-Scale identity and access management for Windows Virtual Desktop"
description: Describe how this enterprise-scale scenario can improve identity and access management of <Insert Scenario Name>
author: wahidsaleemi
ms.author: wasaleem
ms.date: 11/05/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for Windows Virtual Desktop (WVD) Enterprise-Scale scenario

Windows Virtual Desktop (WVD) is a managed service aiming to provide a Microsoft control plane for your VDI environment. Identity and access management for Windows Virtual Desktop control plane uses Azure role-based access controls with certain conditions outlined in this article.

## Design considerations

- Windows Virtual Desktop users must be sourced form the same Active Directory Domain Services that is synchronized to Azure AD.
  > [!NOTE]
  > Windows Virtual Desktop does not support B2B or Microsoft Accounts.
- The account used for domain join [can not have multi-factor authentication](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) or other interactive prompts.
- Windows Virtual Desktop requires Active Directory Domain Services (AD DS) or Azure Active Directory Domain Services (Azure AD DS).
- Choose a hosting strategy for Active Directory Domain Services, either Azure Active Directory Domain Services (Azure AD DS) or Active Directory Domain Services (AD DS) hosted on a Windows Server.
  - When joining to an Azure Active Directory Domain Services (Azure AD DS) domain, the [account must be part of the Azure AD DC Administrators group](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) and the account password must work in Azure AD DS.
- When specifying an OU (Organizational Unit), make sure to use the full path (Distinguished Name) without quotation marks.
- Follow the principle of least privilege.
- The UPN (User Principal Name) used to subscribe to Windows Virtual Desktop [must exist](https://docs.microsoft.com/azure/virtual-desktop/overview#requirements) in the Active Directory domain where the Session Host virtual machine is joined.
- Using Windows Hello for Business requires the [hybrid certificate trust model](https://docs.microsoft.com/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust) to be compatible with Windows Virtual Desktop.
- When using Windows Hello for Business or Smart Card authentication, the initiating client must be able to communicate with the domain controller because these [authentication methods](https://docs.microsoft.com/azure/virtual-desktop/authentication) use Kerberos to sign in.
- Single sign-on can improve user experience but adds some complexity to the solution and is only support using Active Directory Federation Services (AD FS).

## Design recommendations

- Synchronize all identities to a single Azure Active Directory tenant using [Azure AD Connect](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-azure-ad-connect).
- Ensure Windows Virtual Desktop Session Hosts can communicate with with Azure Active Directory Domain Services (Azure AD DS) or Active Directory Domain Services (AD DS).
- [Segregate Session Host virtual machines](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) into Active Directory OUs (Organization Units) for each host pool to more easily manage policies and orphaned objects.
- Use a solution like [LAPS (Local Administrator Password Solution)](https://docs.microsoft.com/windows-server/identity/securing-privileged-access/securing-privileged-access#phase-1-quick-wins-with-minimal-operational-complexity) to rotate local administrator passwords on Windows Virtual Desktop Session Hosts frequently.
- For users, assign the [Desktop Virtualization User](https://docs.microsoft.com/azure/virtual-desktop/delegated-access-virtual-desktop) built-in role to Security Groups to grant access to Windows Virtual Desktop app groups.
- Create [Conditional Access Policies for Windows Virtual Desktop](https://docs.microsoft.com/azure/virtual-desktop/set-up-mfa). Conditional Access Polices can enforce multi-factor authentication based on conditions such as risky sign-ins to increase an organizations security posture.
- Configure Active Directory Federation Services (AD FS) to enable single sign-on for users on the corporate network.
