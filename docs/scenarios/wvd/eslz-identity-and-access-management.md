---
title: Identity and access management for Azure Virtual Desktop
description: Learn how to use Azure role-based access control for identity and access management in your virtual desktop infrastructure.
author: wahidsaleemi
ms.author: wasaleem
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Identity and access management considerations for Azure Virtual Desktop

Azure Virtual Desktop is a managed service that provides a Microsoft control plane for your virtual desktop infrastructure. Identity and access management for Azure Virtual Desktop uses Azure role-based access control (RBAC) with certain conditions outlined in this article.

## RBAC design

RBAC supports separation of duties for the various teams and individuals that manage the deployment of Azure Virtual Desktop. As part of your landing zone design you should decide who assumes the various roles. You then create a security group for each role to simplify adding and removing users to and from the roles.

Azure Virtual Desktop has custom Azure roles designed for each functional area. Configuration details are in [Built-in roles for Azure Virtual Desktop](/azure/virtual-desktop/rbac). Common roles include:

- **Desktop Virtualization Contributor:** This role lets you manage all aspects of the deployment but doesn't grant access to compute resources.
- **Desktop Virtualization Reader:** This role lets you view everything in the deployment but doesn't let you make changes.
- **Desktop Virtualization Host Pool Contributor:** This role lets you manage all aspects of host pools, including access to resources. To create virtual machines you need another role, Virtual Machine Contributor. You will also need Application Group Contributor and Workspace Contributor roles to create host pools using the portal, or you can use the Desktop Virtualization Contributor role.
- **Desktop Virtualization Host Pool Reader:** This role lets you view everything in the host pool, but doesn't let you make changes.
- **Desktop Virtualization Application Group Contributor:** This role lets you manage all aspects of application groups. To publish application groups to users, or to user groups, you need the User Access Administrator role.
- **Desktop Virtualization Application Group Reader:** This role lets you view everything in the application group, but doesn't let you make changes.
- **Desktop Virtualization Workspace Contributor:** This role lets you manage all aspects of workspaces. To get information on applications added to the application groups, you need the Desktop Virtualization Application Group Reader role.
- **Desktop Virtualization Workspace Reader:** This role lets you view everything in the workspace, but doesn't let you make changes.
- **Desktop Virtualization User Session Operator:** This role lets you send messages, disconnect sessions, and use the logoff function to sign sessions out of the session host. However, it doesn't let you perform session host management like removing session host, changing drain mode, and so on.
- **Desktop Virtualization Session Host Operator:** This role lets you view and remove session hosts, and change drain mode. You can't add session hosts using the Azure portal because you don't have write permission for host pool objects.

[Azure built-in roles](/azure/role-based-access-control/built-in-roles) can be created and defined as part of the Cloud Adoption Framework for Azure deployment. RBAC roles that are specific to Azure Virtual Desktop may need to be combined with other Azure RBAC roles to provide the complete set of permissions users need for Azure Virtual Desktop and for other Azure services like virtual machines and networking.

## Design considerations

- Azure Virtual Desktop users must be sourced from either the same instance of on-premises Active Directory Domain Services (AD DS) that is synchronized to Azure Active Directory (Azure AD), or an instance of Azure AD Domain Services (Azure AD DS) synchronized from Azure AD.
  > [!NOTE]
  > Azure Virtual Desktop does not support B2B or Microsoft accounts.
- The account used for domain join can't have multifactor authentication or other interactive prompts, and there are other requirements. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- Azure Virtual Desktop requires a hosting strategy for domain services. Choose either [AD DS or Azure AD DS](/azure/active-directory-domain-services/compare-identity-solutions).
- When joining to an Azure AD DS domain, the account must be part of the Azure AD DC administrators group and the account password must work in Azure AD DS. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- Azure AD DS is a supported option, but there are limitations:
  - You must have password hash synchronization enabled (uncommon when federating Azure AD).
  - You can only project Azure AD DS into a single virtual network (and single Azure region) that uses a non-public IP address range. You can't add domain controllers to an Azure AD DS domain.
  - You cannot use hybrid join for Azure Virtual Desktop VMs to enable Azure Active Directory Seamless Single Sign-On for Microsoft 365 services.

   For more information, see [Frequently asked questions (FAQ) about Azure Active Directory Domain Services (Azure AD DS)](/azure/active-directory-domain-services/faqs).
- When specifying an organizational unit, use the distinguished name without quotation marks.
- Follow the principle of least privilege by assigning the minimum permissions needed for authorized tasks.
- The user principal name used to subscribe to Azure Virtual Desktop must exist in the Active Directory domain where the session host virtual machine is joined. For more information about user requirements, see [Azure Virtual Desktop requirements](/azure/virtual-desktop/overview#requirements).
- When using smart cards, a direct connection (line of sight) with an Active Directory domain controller for Kerberos authentication is required. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- Using Windows Hello for Business requires the hybrid certificate trust model to be compatible with Azure Virtual Desktop. For more information, see [Hybrid Azure AD joined certificate trust deployment](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust).
- When using Windows Hello for Business or smart-card authentication, the initiating client must be able to communicate with the domain controller because these authentication methods use Kerberos to sign in. For more information, see [Supported authentication methods](/azure/virtual-desktop/authentication).
- Single sign-on can improve user experience, but it requires additional configuration and is only supported using Active Directory Federation Services. For more information, see [Configure AD FS single sign-on for Azure Virtual Desktop](/azure/virtual-desktop/configure-adfs-sso).

## Design recommendations

- Use Azure AD Connect to synchronize all identities to a single Azure AD tenant. For more information, see [What is Azure AD Connect?](/azure/active-directory/hybrid/whatis-azure-ad-connect) .
- Ensure Azure Virtual Desktop session hosts can communicate with Azure AD DS or AD DS.
- Use the Kerberos Key Distribution Center proxy solution to proxy smart-card authentication traffic and to sign in remotely. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- Segregate session host virtual machines into Active Directory organization units for each host pool to more easily manage policies and orphaned objects. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- Use a solution like Local Administrator Password Solution (LAPS) to rotate local administrator passwords on Azure Virtual Desktop session hosts frequently. For more information, see [Security assessment: Microsoft LAPS usage](/defender-for-identity/cas-isp-laps).
- For users, assign the Desktop Virtualization User built-in role to security groups to grant access to Azure Virtual Desktop application groups. For more information, see [Delegated access in Azure Virtual Desktop](/azure/virtual-desktop/delegated-access-virtual-desktop).
- Create conditional access policies for Azure Virtual Desktop. Such policies can enforce multifactor authentication based on conditions like risky sign-ins to increase an organization's security posture. For more information, see [Enable Azure Active Directory multifactor authentication for Azure Virtual Desktop](/azure/virtual-desktop/set-up-mfa).
- Configure AD FS to enable single sign-on for users on the corporate network.
