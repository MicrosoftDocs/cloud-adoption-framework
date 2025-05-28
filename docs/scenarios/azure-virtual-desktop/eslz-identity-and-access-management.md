---
title: Identity and access management for Azure Virtual Desktop
description: Learn how to use Azure role-based access control for identity and access management in your virtual desktop infrastructure.
author: wahidsaleemi
ms.author: wasaleem
ms.date: 02/22/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Identity and access management considerations for Azure Virtual Desktop

Azure Virtual Desktop is a managed service that provides a Microsoft-managed control plane for your virtual desktop infrastructure. Identity and access management for Azure Virtual Desktop uses [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview), with specific considerations outlined in this article.

## Role-based access control (RBAC) design

RBAC enables separation of duties across the teams and individuals managing Azure Virtual Desktop deployment. As part of the landing zone design, determine role assignments and create corresponding security groups for each role to simplify user management.

Azure Virtual Desktop includes custom Azure roles tailored for specific functional areas. For information about how these roles are configured, see [Built-in roles for Azure Virtual Desktop](/azure/virtual-desktop/rbac).

[Azure built-in roles](/azure/role-based-access-control/built-in-roles) can be used alongside these custom roles and defined within the Cloud Adoption Framework for Azure. You may need to combine Azure Virtual Desktop-specific roles with other RBAC roles to grant users the necessary permissions across Azure services such as virtual machines and networking.

## Single sign-on
Single sign-on (SSO) for Azure Virtual Desktop with Microsoft Entra ID offers a seamless authentication experience for users connecting to session hosts. With SSO enabled, users sign-in to Windows using a Microsoft Entra ID token. This supports passwordless authentication and third-party identity providers federated with Microsoft Entra ID, streamlining connect to session hosts.

SSO using Microsoft Entra ID also provides a seamless experience for Microsoft Entra ID-based resources within the session. For more information about how to configure single sign-on for Azure Virtual Desktop, see [Configure single sign-on for Azure Virtual Desktop using Microsoft Entra ID] (/azure/virtual-desktop/configure-single-sign-on).

## Azure Virtual Desktop design considerations

- **Authentication requirement**: Users must authenticate to access desktops and applications from session hosts. [Microsoft Entra ID](/entra/fundamentals/whatis) is always used for user authentication in Azure Virtual Desktop, which is Microsoft's centralized cloud identity service that enables this capability.
- **Session host domain join options**: Hosts can be joined to:
  - The same Microsoft Entra tenant.
  - An Active Directory domain using [Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) or [Microsoft Entra Domain Services](/entra/identity/domain-services/overview), offering flexibility in configuration.
  > [!NOTE]
  > Azure Virtual Desktop does **not** support B2B or Microsoft accounts.
- **Domain join account requirements**: The account used for domain join can not have multifactor authentication or other interactive prompts. Additional requirements apply, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- **Hosting strategy**: Choose either [AD DS or Microsoft Entra Domain Services](/entra/identity/domain-services/compare-identity-solutions) based on your needs.
- [**Microsoft Entra Domain Services**](/entra/identity/domain-services//): This is a supported option, but with limitations:
  - You must [enable password hash synchronization](/entra/identity/domain-services/tutorial-configure-password-hash-sync).
  - Hybrid join for Azure Virtual Desktop VMs isn't supported, which means you can't enable seamless SSO for Microsoft 365 services.
  - For more information, see [Frequently asked questions (FAQ) about Microsoft Entra Domain Services](/entra/identity/domain-services//faqs).
- **Permissions for domain join with Microsoft Entra Domain Services**: The account must be part of the Microsoft Entra DC administrators group, and the account password must work in Microsoft Entra Domain Services. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- **Organizational unit format**: When specifying an organizational unit, use the distinguished name without quotation marks.
- **Least privilege principle**: Assign only the minimum permissions necessary for authorized tasks.
- **User principal name requirement**: The user principal name used to subscribe to Azure Virtual Desktop must exist in the Active Directory domain that the session host virtual machine is joined. For more information about user requirements, see [Azure Virtual Desktop requirements](/azure/virtual-desktop/overview#requirements).
- **Smart card authentication**: Requires a direct connection (line of sight) with an Active Directory domain controller for Kerberos authentication. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- **Windows Hello for Business**: Requires the hybrid certificate trust model to be compatible with Azure Virtual Desktop. For more information, see [Microsoft Entra hybrid joined certificate trust deployment](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust).
- **Kerberos-based sign-in**: For Windows Hello for Business or smart cards authentication, the initiating client must be able to communicate with the domain controller. For more information, see [Supported authentication methods](/azure/virtual-desktop/authentication).
- **Single sign-o with Active Directory Federation Services**: SSO can improve user experience, but it requires additional configuration and is only supported using Active Directory Federation Services (AD FS). For more information, see [Configure AD FS single sign-on for Azure Virtual Desktop](/azure/virtual-desktop/configure-adfs-sso).

### Supported identity scenarios

The following table summarizes identity scenarios that Azure Virtual Desktop currently supports:

| Identity scenario | Session hosts | User accounts |
|--|--|--|
| Microsoft Entra ID + AD DS | Joined to AD DS | In Microsoft Entra ID and AD DS, synchronized |
| Microsoft Entra ID + AD DS | Joined to Microsoft Entra ID | In Microsoft Entra ID and AD DS, synchronized |
| Microsoft Entra ID + Microsoft Entra Domain Services | Joined to Microsoft Entra Domain Services | In Microsoft Entra ID and Microsoft Entra Domain Services, synchronized |
| Microsoft Entra ID + Microsoft Entra Domain Services + AD DS | Joined to Microsoft Entra Domain Services | In Microsoft Entra ID and AD DS, synchronized |
| Microsoft Entra ID + Microsoft Entra Domain Services | Joined to Microsoft Entra ID | In Microsoft Entra ID and Microsoft Entra Domain Services, synchronized|
| Microsoft Entra-only | Joined to Microsoft Entra ID | In Microsoft Entra ID |


## Design recommendations

- **Synchronize identities**: Use Microsoft Entra Connect to synchronize all identities to a single Microsoft Entra tenant. For more information, see [What is Microsoft Entra Connect?](/entra/identity/hybrid/connect/whatis-azure-ad-connect).
- **Ensure directory connectivity**: Ensure Azure Virtual Desktop session hosts can communicate with either Microsoft Entra Domain Services or Active Directory Domain Services.
- **Enable smart card support**: Use the Kerberos Key Distribution Center proxy solution to proxy smart-card authentication traffic and to enable remote sign-in. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- **Organize session hosts**: Segregate session host virtual machines into Active Directory organizational units for each host pool to simplify manage policies and orphaned objects. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- **Secure local admin accounts**: Use a solution like Local Administrator Password Solution (LAPS) to frequently rotate local administrator passwords on Azure Virtual Desktop session hosts. For more information, see [Security assessment: Microsoft LAPS usage](/defender-for-identity/cas-isp-laps).
- **Assign access with role-based access control**: Grant user access to Azure Virtual Desktop application groups by assigning the Desktop Virtualization User built-in role to appropriate security groups. For more information, see [Delegated access in Azure Virtual Desktop](/azure/virtual-desktop/delegated-access-virtual-desktop).
- **Implement conditional access**: Create Conditional Access policies for Azure Virtual Desktop to enforce multifactor authentication based on conditions like risky sign-ins to increase your organization's security posture. For more information, see [Enable Microsoft Entra multifactor authentication for Azure Virtual Desktop](/azure/virtual-desktop/set-up-mfa).
- **Enable single sign-on with Active Directory Federation Services**: Configure AD FS to enable single sign-on for users on the corporate network.

## Next steps

Learn about network topology and connectivity for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
