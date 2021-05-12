---
title: Enterprise-Scale identity and access management for Windows Virtual Desktop
description: Learn how to use Azure role-based access control for identity and access management in your enterprise-scale virtual desktop infrastructure.
author: wahidsaleemi
ms.author: wasaleem
ms.date: 11/05/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for Windows Virtual Desktop

Windows Virtual Desktop is a managed service that provides a Microsoft control plane for your virtual desktop infrastructure. Identity and access management for Windows Virtual Desktop uses Azure role-based access control (RBAC) with certain conditions outlined in this article.

## RBAC design

RBAC supports separation of duties for the various teams and individuals that manage the deployment of Windows Virtual Desktop. As part of your landing zone design you should decide who assumes the various roles. You then create a security group for each role to simplify adding and removing users to and from the roles.

Windows Virtual Desktop has custom Azure roles designed for each functional area. Configuration details are in [Built-in roles for Windows Virtual Desktop](/azure/virtual-desktop/rbac). Common roles include:

- **Desktop Virtualization Contributor:** The Desktop Virtualization Contributor role lets you manage all aspects of the deployment but doesn't grant access to compute resources.
- **Desktop Virtualization Reader:** The Desktop Virtualization Reader role lets you view everything in the deployment but doesn't let you make changes.
- **Host Pool Contributor:** The Host Pool Contributor role lets you manage all aspects of host pools, including access to resources. To create virtual machines you need another role, Virtual Machine Contributor.
- **Host Pool Reader:** The Host Pool Reader role lets you view everything in the host pool, but doesn't let you make changes.
- **Application Group Contributor:** The Application Group Contributor role lets you manage all aspects of app groups. To publish app groups to users, or to user groups, you need the User Access Administrator role.
- **Application Group Reader:** The Application Group Reader role lets you view everything in the app group, but doesn't let you make changes.
- **Workspace Contributor:** The Workspace Contributor role lets you manage all aspects of workspaces. To get information on applications added to the app groups, you need the Application Group Reader role.
- **Workspace Reader:** The Workspace Reader role lets you view everything in the workspace, but doesn't let you make changes.
- **User Session Operator:** The User Session Operator role lets you send messages, disconnect sessions, and use the logoff function to sign sessions out of the session host. However, it doesn't let you perform session host management like removing session host, changing drain mode, and so on.
- **Session Host Operator:** The Session Host Contributor role lets you view and remove session hosts, and change drain mode. You can't add session hosts using the Azure portal because you don't have write permission for host pool objects.

[Azure built-in roles](/azure/role-based-access-control/built-in-roles) can be created and defined as part of the Cloud Adoption Framework for Azure deployment. RBAC roles that are specific to Windows Virtual Desktop may need to be combined with other Azure RBAC roles to provide the complete set of permissions users need for Windows Virtual Desktop and for other Azure services like virtual machines and networking.

## Design considerations

- Windows Virtual Desktop users must be sourced from either the same instance of on-premises Active Directory Domain Services (AD DS) that is synchronized to Azure Active Directory (Azure AD), or an instance of Azure AD Domain Services (Azure AD DS) synchronized from Azure AD.
  > [!NOTE]
  > Windows Virtual Desktop does not support B2B or Microsoft Accounts.
- The account used for domain join can't have multi-factor authentication or other interactive prompts, and there are other requirements. See [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) for more information.
- Windows Virtual Desktop requires AD DS or Azure AD DS.
- Choose a hosting strategy for domain services, either Azure AD DS or AD DS.
- When joining to an Azure AD DS domain, the account must be part of the Azure AD DC Administrators group and the account password must work in Azure AD DS. See [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details) for more information.
- Azure AD DS is a supported option, but there are limitations:
  - You must have password hash synchronization enabled (uncommon when federating Azure AD).
  - You can only project Azure AD DS into a single virtual network (and single Azure region) that uses a non-Public IP address range. You can't add domain controllers to an Azure AD DS domain.
  - You can't fail over Azure AD DS to another region for disaster recovery.

   See [Frequently asked questions (FAQs) about Azure Active Directory (AD) Domain Services](/azure/active-directory-domain-services/faqs) for more information.
- When specifying an organizational unit, use the distinguished name without quotation marks.
- Follow the principle of least privilege—assign the minimum permissions needed for authorized tasks.
- The UserPrincipalName used to subscribe to Windows Virtual Desktop must exist in the Active Directory domain where the session host virtual machine is joined. For more information about user requirements, see [What is Active Directory?—Requirements](/azure/virtual-desktop/overview#requirements).
- When using Smartcards, a direct connection (line of sight) with an Active Directory domain controller for Kerberos authentication is required. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- Using Windows Hello for Business requires the hybrid certificate trust model to be compatible with Windows Virtual Desktop. For more information, see [Hybrid Azure AD joined Certificate Trust Deployment](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust).
- When using Windows Hello for Business or Smartcard authentication, the initiating client must be able to communicate with the domain controller because these authentication methods use Kerberos to sign in. For more information, see [Supported authentication methods](/azure/virtual-desktop/authentication).
- Single sign-on can improve user experience but it requires additional configuration and is only supported using Active Directory Federation Services.

## Design recommendations

- Use Azure AD Connect to synchronize all identities to a single Azure AD tenant. For more information, see [What is Azure AD Connect?](/azure/active-directory/hybrid/whatis-azure-ad-connect) .
- Ensure Windows Virtual Desktop Session Hosts can communicate with with Azure AD DS or AD DS.
- Use the KDC proxy solution to proxy Smartcard authentication traffic and to sign in remotely. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- Segregate Session Host virtual machines into Active Directory organization units for each host pool to more easily manage policies and orphaned objects. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- Use a solution like Local Administrator Password Solution (LAPS) to rotate local administrator passwords on Windows Virtual Desktop session hosts frequently. For more information, see [Security assessment: Microsoft LAPS usage](/defender-for-identity/cas-isp-laps).
- For users, assign the Desktop Virtualization User built-in role to security groups to grant access to Windows Virtual Desktop app groups. For more information, see [Delegated access in Windows Virtual Desktop](/azure/virtual-desktop/delegated-access-virtual-desktop).
- Create conditional access policies for Windows Virtual Desktop. Such policies can enforce multi-factor authentication based on conditions like risky sign-ins to increase an organization's security posture. For more information, see [Enable Azure multifactor authentication for Windows Virtual Desktop](/azure/virtual-desktop/set-up-mfa).
- Configure AD FS to enable single sign-on for users on the corporate network.
