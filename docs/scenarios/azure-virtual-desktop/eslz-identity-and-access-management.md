---
title: Identity and access management recommendations for Azure Virtual Desktop
description: Learn how to use Azure role-based access control for identity and access management in your virtual desktop infrastructure.
author: wahidsaleemi
ms.author: wasaleem
ms.date: 06/12/2025
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Identity and access management recommendations for Azure Virtual Desktop

This article explains how to use Azure role-based access control (RBAC) for identity and access management in your virtual desktop infrastructure. Effective identity and access management ensures secure and efficient operations for Azure Virtual Desktop.

## Role-based access control (RBAC) design

RBAC enables separation of duties across the teams and individuals managing Azure Virtual Desktop deployment. It simplifies user management and enhances security by assigning roles based on responsibilities. To achieve this, follow these steps:

1. **Define role assignments.** Determine role assignments and create corresponding security groups for each role. This approach simplifies user management and ensures clear separation of duties. Use [Azure built-in roles](/azure/role-based-access-control/built-in-roles) alongside custom roles tailored for Azure Virtual Desktop.

1. **Combine roles for cross-service permissions.** Combine Azure Virtual Desktop-specific roles with other RBAC roles to grant users the necessary permissions across Azure services such as virtual machines and networking. For more information, see [Built-in roles for Azure Virtual Desktop](/azure/virtual-desktop/rbac).

## Single sign-on
Single sign-on (SSO) for Azure Virtual Desktop with Microsoft Entra ID offers a seamless authentication experience for users connecting to session hosts. SSO enhances user experience and security by enabling passwordless authentication and supporting third-party identity providers federated with Microsoft Entra ID. To implement SSO, follow these steps:

1. **Enable SSO for session hosts.** Configure SSO to allow users to sign in to Windows using a Microsoft Entra ID token. This setup streamlines authentication and supports Microsoft Entra ID-based resources within the session. For configuration details, see [Configure single sign-on for Azure Virtual Desktop using Microsoft Entra ID](/azure/virtual-desktop/configure-single-sign-on).

1. **Integrate third-party identity providers.** Use federated third-party identity providers with Microsoft Entra ID to extend authentication capabilities. This integration simplifies access for users and enhances security.

## Azure Virtual Desktop design considerations

This section outlines key design considerations for deploying Azure Virtual Desktop. These considerations help you select the right identity, authentication, and domain join strategies to ensure secure and reliable access for users. Follow these recommendations to achieve an optimal configuration:

- **Require user authentication with Microsoft Entra ID.** Users must authenticate with [Microsoft Entra ID](/entra/fundamentals/whatis) to access desktops and applications from session hosts. Microsoft Entra ID provides centralized cloud identity management for Azure Virtual Desktop.

- **Select a supported domain join option for session hosts.** Join session hosts to either the same Microsoft Entra tenant, [Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview), or [Microsoft Entra Domain Services](/entra/identity/domain-services/overview). Azure Virtual Desktop does not support B2B or Microsoft accounts for session host domain join.

- **Use a non-interactive account for domain join operations.** The domain join account must not require multifactor authentication or interactive prompts. For additional requirements, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).

- **Choose the appropriate hosting strategy.** Select [Active Directory Domain Services or Microsoft Entra Domain Services](/entra/identity/domain-services/compare-identity-solutions) based on your organizational requirements.

- **Understand Microsoft Entra Domain Services limitations.** [Microsoft Entra Domain Services](/entra/identity/domain-services/) is a supported option, but you must [enable password hash synchronization](/entra/identity/domain-services/tutorial-configure-password-hash-sync). Hybrid join for Azure Virtual Desktop VMs is not supported, which prevents seamless SSO for Microsoft 365 services. For more details, see [Microsoft Entra Domain Services FAQ](/entra/identity/domain-services/faqs).

- **Assign the correct permissions for domain join with Microsoft Entra Domain Services.** The domain join account must belong to the Microsoft Entra DC administrators group, and the password must be valid in Microsoft Entra Domain Services. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).

- **Specify organizational units using the distinguished name format.** When you define an organizational unit, use the distinguished name without quotation marks.

- **Apply the least privilege principle.** Assign only the minimum permissions required for users to perform authorized tasks.

- **Ensure user principal name alignment.** The user principal name used to subscribe to Azure Virtual Desktop must exist in the Active Directory domain joined to the session host virtual machine. For user requirements, see [Azure Virtual Desktop requirements](/azure/virtual-desktop/overview#requirements).

- **Enable smart card authentication with direct domain controller connectivity.** Smart card authentication requires a direct connection to an Active Directory domain controller for Kerberos authentication. For configuration guidance, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).

- **Deploy Windows Hello for Business with hybrid certificate trust.** Use the hybrid certificate trust model to support Windows Hello for Business with Azure Virtual Desktop. For deployment steps, see [Microsoft Entra hybrid joined certificate trust deployment](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust).

- **Support Kerberos-based sign-in for advanced authentication.** For Windows Hello for Business or smart card authentication, ensure the client can communicate with the domain controller. For supported methods, see [Supported authentication methods](/azure/virtual-desktop/authentication).

- **Configure single sign-on with Active Directory Federation Services.** Enable SSO using Active Directory Federation Services (AD FS) to improve user experience. This configuration is only supported with AD FS. For setup instructions, see [Configure Active Directory Federation Service single sign-on for Azure Virtual Desktop](/azure/virtual-desktop/configure-adfs-sso).

### Supported identity scenarios

The following table summarizes identity scenarios supported by Azure Virtual Desktop:

| Identity scenario | Session hosts | User accounts |
|--|--|--|
| Microsoft Entra ID + AD DS | Joined to AD DS | In Microsoft Entra ID and AD DS, synchronized |
| Microsoft Entra ID + AD DS | Joined to Microsoft Entra ID | In Microsoft Entra ID and AD DS, synchronized |
| Microsoft Entra ID + Microsoft Entra Domain Services | Joined to Microsoft Entra Domain Services | In Microsoft Entra ID and Microsoft Entra Domain Services, synchronized |
| Microsoft Entra ID + Microsoft Entra Domain Services + AD DS | Joined to Microsoft Entra Domain Services | In Microsoft Entra ID and AD DS, synchronized |
| Microsoft Entra ID + Microsoft Entra Domain Services | Joined to Microsoft Entra ID | In Microsoft Entra ID and Microsoft Entra Domain Services, synchronized|
| Microsoft Entra-only | Joined to Microsoft Entra ID | In Microsoft Entra ID |


## Design recommendations

Follow these design recommendations to optimize identity and access management for Azure Virtual Desktop:

1. **Synchronize identities.** Use Microsoft Entra Connect to synchronize all identities to a single Microsoft Entra tenant. For more information, see [What is Microsoft Entra Connect?](/entra/identity/hybrid/connect/whatis-azure-ad-connect).

2. **Ensure directory connectivity.** Ensure Azure Virtual Desktop session hosts can communicate with either Microsoft Entra Domain Services or Active Directory Domain Services.

3. **Enable smart card support.** Use the Kerberos Key Distribution Center proxy solution to proxy smart-card authentication traffic and enable remote sign-in. For more information, see [Configure a Kerberos Key Distribution Center proxy](/azure/virtual-desktop/key-distribution-center-proxy).

4. **Organize session hosts.** Segregate session host virtual machines into Active Directory organizational units for each host pool to simplify policy management and orphaned objects. For more information, see [Virtual machine details](/azure/virtual-desktop/create-host-pools-azure-marketplace#virtual-machine-details).

5. **Secure local admin accounts.** Use a solution like Local Administrator Password Solution (LAPS) to frequently rotate local administrator passwords on Azure Virtual Desktop session hosts. For more information, see [Security assessment: Microsoft LAPS usage](/defender-for-identity/cas-isp-laps).

6. **Assign access with RBAC.** Grant user access to Azure Virtual Desktop application groups by assigning the Desktop Virtualization User built-in role to appropriate security groups. For more information, see [Delegated access in Azure Virtual Desktop](/azure/virtual-desktop/delegated-access-virtual-desktop).

7. **Implement conditional access.** Create Conditional Access policies for Azure Virtual Desktop to enforce multifactor authentication based on conditions like risky sign-ins. For more information, see [Enable Microsoft Entra multifactor authentication for Azure Virtual Desktop](/azure/virtual-desktop/set-up-mfa).

8. **Enable single sign-on with AD FS.** Configure Active Directory Federation Service (AD FS) to enable single sign-on for users on the corporate network.

## Next steps

Learn about network topology and connectivity for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
