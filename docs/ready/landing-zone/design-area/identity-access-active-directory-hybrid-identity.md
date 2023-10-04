---
title: Azure identity and access management for Active Directory and hybrid identity
description: Understand Microsoft Entra ID and hybrid identity considerations and recommendations.
author: soderholmd
ms.author: dsoderholm 
ms.topic: conceptual
ms.date: 09/19/2023
---

# Active Directory and Hybrid Identity

Microsoft Entra ID provides a base level of access control and identity management for Azure resources. If your organization has an on-premises Active Directory infrastructure (Active Directory Domain Services), your cloud-based workloads might require directory synchronization with Microsoft Entra ID for a consistent set of identities, groups, and roles between your on-premises and cloud environments. Additionally, support for applications that depend on legacy authentication mechanisms might require the deployment of managed Microsoft Entra Domain Services in the cloud.

Cloud-based identity management is an iterative process. You could start with a cloud-native solution with a small set of users and corresponding roles for an initial deployment and as your migration matures, you might need to integrate your identity solution using directory synchronization and/or add cloud hosted domains services as part of your cloud deployments. Revisit your identity strategy in every iteration of your migration process.

Refer the [Identity decision guide](/azure/cloud-adoption-framework/decision-guides/identity/) for help with your identity strategy.

## Azure and on-premises (hybrid identity)

User objects that are wholly created in Microsoft Entra ID are known as ‘cloud-only’ accounts. They support modern authentication and access to Azure and Microsoft 365 resources, as well as for local sign-in on devices using Windows 10 or Windows 11.

However, many organizations are already using Active Directory Domain Services (AD DS) directories that they have been operating for a long time, and which may be integrated with other systems such as line-of-business or Enterprise Resource Planning (ERP) using LDAP. These domains may have many domain-joined computers and applications that use Kerberos or the older NTLMv2 protocols for authentication. In these environments, user objects can be synchronized to Microsoft Entra ID so that users can sign in to both on-premises systems and cloud resources with a single identity. Uniting on-premises and cloud directory services is known as ‘hybrid identity.’  On-premises domains can be extended into Azure Landing Zones:

- Active Directory Domain Services (AD DS) domain users can be synchronized with Entra ID using Microsoft Entra Connect or Microsoft Entra Connect Cloud Sync, to maintain a single user object in both cloud and on-premises environments. Review the [supported topologies](/azure/active-directory/hybrid/connect/plan-connect-topologies) to determine the recommended configuration for your environment.

- Active Directory Domain Services (AD DS) domain controllers or Microsoft Entra Domain Services can be deployed in Azure to allow Windows virtual machines and other services to be domain-joined. This allows Active Directory Domain Services (AD DS) users to log into Windows servers, Azure Files shares, and other resources that use Active Directory as an authentication source. It also facilitates the use of other AD DS technologies such as Group Policy. See [Common deployment scenarios for Microsoft Entra Domain Services](/azure/active-directory-domain-services/scenarios).

With hybrid identity, authentication can occur in the cloud and on-premises, or on-premises only. As part of your identity planning, explore the authentication methods Microsoft Entra ID offers. For more information, see [Authentication for Microsoft Entra hybrid identity solutions](/azure/active-directory/hybrid/connect/choose-ad-authn).

### Hybrid identity recommendations

- For options to meet organizational requirements when integrating on-premises Active Directory with Azure, see [Integrate on-premises AD with Azure](/azure/architecture/reference-architectures/identity/).

- If you have Active Directory Federation Services (AD FS) federation with Microsoft Entra ID, you can use password hash synchronization as a backup. AD FS doesn't support seamless single sign-on (SSO).

- Determine the right synchronization tool for your cloud identity. For more information, see [Tools for synchronization](/azure/active-directory/hybrid/sync-tools#selecting-the-right-tool).

- If you are using Active Directory Federation Services (AD FS), move to the cloud to centralize identity and reduce operational effort. If AD FS is still part of your identity solution, install and use Microsoft Entra Connect.

> [!IMPORTANT]
>
> Instead of upgrading to the latest version of AD FS, Microsoft highly recommends migrating to Azure AD. For more information, see [**Resources for decommissioning AD FS**](/windows-server/identity/ad-fs/ad-fs-decommission).
>

## Microsoft Entra ID, Microsoft Entra Domain Services, and Active Directory Domain Services

Administrators should familiarize themselves with the different options available for implementing Microsoft Directory Services:

- Active Directory Domain Services (AD DS) domain controllers can be deployed into Azure as Windows virtual machines (IaaS) that administrators have full control of. They can be joined to an existing Active Directory domain, or create a new one with a trust relationship with existing on-premises domains. See [Deploy AD DS in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain).

- Microsoft Entra Domain Services is an Azure managed service that creates a new managed AD DS domain hosted in Azure. The domain can be part of a trust relationship with existing domains and can synchronize identities from Microsoft Entra ID. Administrators do not have direct access to the domain controllers and are not responsible for patching and other maintenance operations. For more information, see [Overview of Microsoft Entra Domain Services](/azure/active-directory-domain-services/overview).

Once AD DS or Microsoft Entra DS is configured, Azure virtual machines and file shares can be domain-joined in the same way as on-premises computers. For more information on the different options, see [Compare Microsoft Directory-based services](/azure/active-directory-domain-services/compare-identity-solutions).

### Microsoft Entra ID and Active Directory Domain Services recommendations

- To access applications that use on-premises authentication remotely through Microsoft Entra ID, use [Microsoft Entra Application Proxy](/azure/active-directory/app-proxy/application-proxy).

- Evaluate the compatibility of workloads for Microsoft Entra DS and for AD DS on Windows Server. See [Common use-cases and scenarios](/azure/active-directory-domain-services/scenarios).

- Deploy domain controllers into the Identity subscription within the Platform management group. Domain controllers and other identity services are particularly attractive targets for attackers, and should have strict security controls and segregation from application workloads. Resources using the domain controllers for authentication must have a network route to the domain controller subnet.

- For self-hosted Active Directory Domain Services, create domain controller virtual machines in Availability Sets or Availability Zones to maintain high availability.

- When you deploy Microsoft Entra DS or integrate on-premises environments into Azure, use regions with Availability Zones where available.

- Deploy Microsoft Entra DS within the primary region, because you can only project this service into one subscription. You can expand Microsoft Entra DS to further regions with [replica sets](/azure/active-directory-domain-services/tutorial-create-replica-set).

- If Kerberos is required for Azure Files file shares for Windows users, consider using [Microsoft Entra Kerberos](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal#enable-azure-ad-kerberos-authentication-for-hybrid-user-accounts) rather than deploying domain controllers into the cloud.

### Next Steps
>
> [!div class="nextstepaction"]
> [Active Directory and Hybrid Identity](identity-access-active-directory-hybrid-identity.md)
>
