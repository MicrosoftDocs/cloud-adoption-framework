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

Azure Virtual Desktop is a managed service that provides a Microsoft control plane for your virtual desktop infrastructure. Identity and access management for Azure Virtual Desktop uses [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview), with certain conditions that are described in this article.

## RBAC design

RBAC supports the separation of duties for the various teams and individuals that manage the deployment of Azure Virtual Desktop. As part of the landing zone design, you need to decide who assumes the various roles. You then need to create a security group for each role to simplify adding and removing users to and from roles.

Azure Virtual Desktop provides custom Azure roles that are designed for each functional area. For information about how these roles are configured, see [Built-in roles for Azure Virtual Desktop](/azure/virtual-desktop/rbac).

[Azure built-in roles](/azure/role-based-access-control/built-in-roles) can be created and defined as part of the Cloud Adoption Framework for Azure deployment. RBAC roles that are specific to Azure Virtual Desktop may need to be combined with other Azure RBAC roles to provide the complete set of permissions users need for Azure Virtual Desktop and for other Azure services like virtual machines and networking.

## Azure Virtual Desktop design considerations

- To access desktops and applications from your session hosts, your users need to be able to authenticate. [Microsoft Entra ID](/entra/fundamentals/whatis) is Microsoft's centralized cloud identity service that enables this capability. Microsoft Entra ID is always used to authenticate users for Azure Virtual Desktop. Session hosts can be joined to the same Microsoft Entra tenant, or to an Active Directory domain using [Active Directory Domain Services](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) (AD DS) or [Microsoft Entra Domain Services](/entra/identity/domain-services/overview), providing you with a choice of flexible configuration options.
  > [!NOTE]
  > Azure Virtual Desktop does not support B2B or Microsoft accounts.
- The account used for domain join can't have multifactor authentication or other interactive prompts, and there are other requirements. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- Azure Virtual Desktop requires a hosting strategy for domain services. Choose either [AD DS or Microsoft Entra Domain Services](/azure/active-directory-domain-services/compare-identity-solutions).
- [Microsoft Entra Domain Services](/azure/active-directory-domain-services/) is a supported option, but there are limitations:
  - You must [enable password hash synchronization](/azure/active-directory-domain-services/tutorial-configure-password-hash-sync).
  - You can't use hybrid join for Azure Virtual Desktop VMs to enable Microsoft Entra seamless single sign-on for Microsoft 365 services.  
  For more information, see [Frequently asked questions (FAQ) about Microsoft Entra Domain Services](/azure/active-directory-domain-services/faqs).
- When joining to a Microsoft Entra Domain Services domain, the account must be part of the Microsoft Entra DC administrators group and the account password must work in Microsoft Entra Domain Services. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- When specifying an organizational unit, use the distinguished name without quotation marks.
- Follow the principle of least privilege by assigning the minimum permissions needed for authorized tasks.
- The user principal name used to subscribe to Azure Virtual Desktop must exist in the Active Directory domain where the session host virtual machine is joined. For more information about user requirements, see [Azure Virtual Desktop requirements](/azure/virtual-desktop/overview#requirements).
- When using smart cards, a direct connection (line of sight) with an Active Directory domain controller for Kerberos authentication is required. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- Using Windows Hello for Business requires the hybrid certificate trust model to be compatible with Azure Virtual Desktop. For more information, see [Microsoft Entra hybrid joined certificate trust deployment](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust).
- When using Windows Hello for Business or smart-card authentication, the initiating client must be able to communicate with the domain controller because these authentication methods use Kerberos to sign in. For more information, see [Supported authentication methods](/azure/virtual-desktop/authentication).
- Single sign-on can improve user experience, but it requires additional configuration and is only supported using Active Directory Federation Services. For more information, see [Configure AD FS single sign-on for Azure Virtual Desktop](/azure/virtual-desktop/configure-adfs-sso).

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

- Use Microsoft Entra Connect to synchronize all identities to a single Microsoft Entra tenant. For more information, see [What is Microsoft Entra Connect?](/azure/active-directory/hybrid/whatis-azure-ad-connect).
- Ensure that Azure Virtual Desktop session hosts can communicate with Microsoft Entra Domain Services or AD DS.
- Use the Kerberos Key Distribution Center proxy solution to proxy smart-card authentication traffic and to enable remote sign-in. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).
- Segregate session host virtual machines into Active Directory organizational units for each host pool to make it easier to manage policies and orphaned objects. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).
- Use a solution like Local Administrator Password Solution (LAPS) to frequently rotate local administrator passwords on Azure Virtual Desktop session hosts. For more information, see [Security assessment: Microsoft LAPS usage](/defender-for-identity/cas-isp-laps).
- For users, assign the Desktop Virtualization User built-in role to security groups to grant access to Azure Virtual Desktop application groups. For more information, see [Delegated access in Azure Virtual Desktop](/azure/virtual-desktop/delegated-access-virtual-desktop).
- Create Conditional Access policies for Azure Virtual Desktop. These policies can enforce multifactor authentication based on conditions like risky sign-ins to increase your organization's security posture. For more information, see [Enable Microsoft Entra multifactor authentication for Azure Virtual Desktop](/azure/virtual-desktop/set-up-mfa).
- Configure AD FS to enable single sign-on for users on the corporate network.

## Next steps

Learn about network topology and connectivity for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
