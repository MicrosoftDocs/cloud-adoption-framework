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

Windows Virtual Desktop (WVD) is a managed service aiming to provide a Microsoft control plane for your VDI environment. Identity and access management for Windows Virtual Desktop uses Azure role-based access controls with certain conditions outlined in this article.

## RBAC Design

Role Based Access Controls (RBAC) can help you provide separation of duties among the various teams and individuals responsible for ongoing management of the deployment. As part of your landing zone design you should who will be added to each role and create security groups for each to simplify adding and removing users from each role.  

Windows virtual desktop has custom Azure roles designed for each functional area. Configuration details can be found inside the Microsoft [Windows Virtual Desktop Doc Site](https://docs.microsoft.com/azure/virtual-desktop/rbac)
Common Roles include:

- **Desktop Virtualization Contributor:** The Desktop Virtualization Contributor role lets you manage all aspects of the deployment. However, it doesn't grant you access to compute resources.
- **Desktop Virtualization Reader:** The Desktop Virtualization Reader role lets you view everything in the deployment but doesn't let you make any changes.
- **Host Pool Contributor:** The Host Pool Contributor role lets you manage all aspects of host pools, including access to resources. You'll need an extra contributor role, Virtual Machine Contributor, to create virtual machines.
- **Host Pool Reader:** The Host Pool Reader role lets you view everything in the host pool, but won't allow you to make any changes.
- **Application Group Contributor:** The Application Group Contributor role lets you manage all aspects of app groups. If you want to publish app groups to users or user groups, you'll need the User Access Administrator role.
- **Application Group Reader:** The Application Group Reader role lets you view everything in the app group and will not allow you to make any changes.
- **Workspace Contributor:** The Workspace Contributor role lets you manage all aspects of workspaces. To get information on applications added to the app groups, you'll also need to be assigned the Application Group Reader role.
- **Workspace Reader:** The Workspace Reader role lets you view everything in the workspace, but won't allow you to make any changes.
- **User Session Operator:** The User Session Operator role lets you send messages, disconnect sessions, and use the "logoff" function to sign sessions out of the session host. However, this role doesn't let you perform session host management like removing session host, changing drain mode, and so on.
- **Session Host Operator:** The Session Host Contributor role lets you view and remove session hosts, as well as change drain mode. They can't add session hosts using the Azure portal because they don't have write permission for host pool objects.

Other Azure [RBAC Roles](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles) can also be created and defined as part of the CAF Deployment. These Windows Virtual Desktop specific RBAC roles might need to be combined with other Azure RBAC roles to provide the complete set of permissions required for staff to be able to acheive their dutys across both Windows Virtual Desktop and other Azure services, such as VMs, networking etc.

## Design considerations

- Windows Virtual Desktop users must be sourced form either the same Active Directory Domain Services that is synchronized to Azure AD, or an instance of Azure Active Directory Domain Services synchronized from Azure AD.
  > [!NOTE]
  > Windows Virtual Desktop does not support B2B or Microsoft Accounts.
- The account used for domain join [can not have multi-factor authentication](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) or other interactive prompts.
- Windows Virtual Desktop requires Active Directory Domain Services (AD DS) or Azure Active Directory Domain Services (Azure AD DS).
- Choose a hosting strategy for Active Directory Domain Services, either Azure Active Directory Domain Services (Azure AD DS) or Active Directory Domain Services (AD DS) hosted on a Windows Server.
  - When joining to an Azure Active Directory Domain Services (Azure AD DS) domain, the [account must be part of the Azure AD DC Administrators group](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) and the account password must work in Azure AD DS.
- While using Azure AD DS is a supported option, consider the following [limitations](https://docs.microsoft.com/azure/active-directory-domain-services/faqs):
  - You must have password hash synchronization enabled which is uncommon when federating Azure AD.
  - You can only project Azure AD DS into a single virtual network (and single Azure region) which uses non-Public IP address range. You can not add domain controllers to an Azure AD DS domain.
  - You cannot fail over Azure AD DS to another region for a DR event.
- When specifying an OU (Organizational Unit), make sure to use the full path (Distinguished Name) without quotation marks.
- Follow the principle of least privilege.
- The UPN (User Principal Name) used to subscribe to Windows Virtual Desktop [must exist](https://docs.microsoft.com/azure/virtual-desktop/overview#requirements) in the Active Directory domain where the Session Host virtual machine is joined.
- When using Smartcards, a direct connection or "line of sight" with an Active Directory domain controller for Kerberos authentication is required.
- Using Windows Hello for Business requires the [hybrid certificate trust model](https://docs.microsoft.com/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust) to be compatible with Windows Virtual Desktop.
- When using Windows Hello for Business or Smart Card authentication, the initiating client must be able to communicate with the domain controller because these [authentication methods](https://docs.microsoft.com/azure/virtual-desktop/authentication) use Kerberos to sign in.
- Single sign-on can improve user experience but requires additional configuration to the solution and is only support using Active Directory Federation Services (AD FS).

## Design recommendations

- Synchronize all identities to a single Azure Active Directory tenant using [Azure AD Connect](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-azure-ad-connect).
- Ensure Windows Virtual Desktop Session Hosts can communicate with with Azure Active Directory Domain Services (Azure AD DS) or Active Directory Domain Services (AD DS).
- Use a solution like [KDC proxy service](https://docs.microsoft.com/en-us/azure/virtual-desktop/key-distribution-center-proxy) to proxy Smartcard authentication traffic and sign in remotely.
- [Segregate Session Host virtual machines](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) into Active Directory OUs (Organization Units) for each host pool to more easily manage policies and orphaned objects.
- Use a solution like [LAPS (Local Administrator Password Solution)](https://docs.microsoft.com/windows-server/identity/securing-privileged-access/securing-privileged-access#phase-1-quick-wins-with-minimal-operational-complexity) to rotate local administrator passwords on Windows Virtual Desktop Session Hosts frequently.
- For users, assign the [Desktop Virtualization User](https://docs.microsoft.com/azure/virtual-desktop/delegated-access-virtual-desktop) built-in role to Security Groups to grant access to Windows Virtual Desktop app groups.
- Create [Conditional Access Policies for Windows Virtual Desktop](https://docs.microsoft.com/azure/virtual-desktop/set-up-mfa). Conditional Access Polices can enforce multi-factor authentication based on conditions such as risky sign-ins to increase an organizations security posture.
- Configure Active Directory Federation Services (AD FS) to enable single sign-on for users on the corporate network.
