---
title: Hybrid identity with Active Directory and Microsoft Entra ID in Azure Landing Zones
description: Understand Microsoft Entra ID and hybrid identity considerations and recommendations for Azure landing zones.
author: soderholmd
ms.author: dsoderholm
ms.topic: conceptual
ms.date: 12/05/2023
---

# Hybrid identity with Active Directory and Microsoft Entra ID

Organizations operating in the cloud require a directory service to manage user identities and access to resources. Microsoft Entra ID is a cloud-based identity and access management service that provides a robust set of capabilities to manage users and groups. It can be used as a standalone identity solution or integrated with an on-premises Active Directory Domain Services (AD DS) infrastructure. This article provides guidance on how to design and implement Microsoft Entra ID and hybrid identity for Azure Landing Zones.

Microsoft Entra ID provides modern, secure identity and access management suitable for many organizations and workloads, and is at the core of Microsoft Azure and Microsoft 365 services. If your organization has an on-premises Active Directory Domain Services (AD DS) infrastructure, your cloud-based workloads might require directory synchronization with Microsoft Entra ID for a consistent set of identities, groups, and roles between your on-premises and cloud environments. Additionally, support for applications that depend on legacy authentication mechanisms might require the deployment of managed Microsoft Entra Domain Services in the cloud.

Cloud-based identity management is an iterative process. You could start with a cloud-native solution with a small set of users and corresponding roles for an initial deployment and as your migration matures, you might need to integrate your identity solution using directory synchronization and/or add cloud hosted domains services as part of your cloud deployments. Revisit your identity solution depending on your workload authentication requirements and other needs, such as changes to your organizational identity strategy and security requirements, or integration with other directory services. When evaluating which type of Active Directory solution to adopt, understand the capabilities and differences of Microsoft Entra ID, Microsoft Entra Domain Services, and Active Directory Domain Services on Windows Server.

Refer the [Identity decision guide](../../../decision-guides/identity/index.md) for help with your identity strategy.

## Identity and access management services in Azure Landing Zones

The administration of identity and access management is a responsibility of the platform team, and identity and access management services are fundamental to organizational security. Those organizations using only Microsoft Entra ID can protect the service by controlling administrative access, and avoiding scenarios in which users outside the platform team can make changes to the configuration or to the security principals contained within.

Organizations that use Active Directory Domain Services (AD DS) or Microsoft Entra Domain Services must also protect the domain controllers from unauthorized access. They are particularly attractive targets for attackers, and should have strict security controls and segregation from application workloads. Domain controllers, and associated components such as Microsoft Entra ID Connect servers, are contained within the Identity subscription within the Platform management group, and are not delegated to application teams. By providing this isolation, application owners can consume the identity services without having to manage them, and the risk of identity and access management services being compromised is reduced. The resources in the Identity subscription are a critical point of security for your cloud and on-premises environments, and must be secured accordingly.

Landing zone provisioning should allow for both Microsoft Entra ID and Active Directory Domain Services (AD DS) or Microsoft Entra Domain Services to be used by application owners, as required by their workloads. Depending on which identity solution is used, supporting configuration such as network connectivity to the Identity VNet should be enabled or disabled. If you use a subscription vending process, this should form part of the subscription request.

## Microsoft Entra ID, Microsoft Entra Domain Services, and Active Directory Domain Services

Administrators should familiarize themselves with the different options available for implementing Microsoft Directory Services:

- Active Directory Domain Services (AD DS) domain controllers can be deployed into Azure as Windows virtual machines (IaaS) that administrators have full control of. They can be joined to an existing Active Directory domain, or create a new one with a trust relationship with existing on-premises domains. See [Deploy AD DS in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain).

- Microsoft Entra Domain Services is an Azure managed service that creates a new managed AD DS domain hosted in Azure. The domain can be part of a trust relationship with existing domains and can synchronize identities from Microsoft Entra ID. Administrators do not have direct access to the domain controllers and are not responsible for patching and other maintenance operations. For more information, see [Overview of Microsoft Entra Domain Services](/entra/identity/domain-services/overview).
- When you deploy Microsoft Entra Domain Services or integrate on-premises environments into Azure, use locations with [Availability Zones](/azure/availability-zones/az-overview) for increased availability.

Once AD DS or Microsoft Entra DS is configured, Azure virtual machines and file shares can be domain-joined in the same way as on-premises computers. For more information on the different options, see [Compare Microsoft Directory-based services](/entra/identity/domain-services/compare-identity-solutions).

### Microsoft Entra ID and Active Directory Domain Services recommendations

- To access applications that use on-premises authentication remotely through Microsoft Entra ID, use [Microsoft Entra Application Proxy](/entra/identity/app-proxy/application-proxy).

- Evaluate the compatibility of workloads for Microsoft Entra DS and for AD DS on Windows Server. See [Common use-cases and scenarios](/entra/identity/domain-services/scenarios).

- Deploy domain controller virtual machines, or Microsoft Entra Domain Services replica sets, into the Identity subscription within the Platform management group.

- Secure the virtual network containing the domain controllers. Prevent direct Internet connectivity by placing the AD DS servers in a separate subnet with an NSG as a firewall. Resources using the domain controllers for authentication must have a network route to the domain controller subnet. Refer to [Deploy AD DS in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain#recommendations) for recommendations when deploying AD DS domain controllers in Azure.

- In a multi-regional organization, deploy the Microsoft Entra Directory Services into the region hosting the core platform components. Microsoft Entra Domain Services can only be deployed into a single subscription. You can expand Microsoft Entra Domain Services to further regions with up to four additional [replica sets](/entra/identity/domain-services/concepts-replica-sets) in additional virtual networks, peered to the primary virtual network. To minimize latency, keep your core applications close to, or in the same region as, the virtual network for your replica sets.

- When you deploy Active Directory Domain Services (AD DS) domain controllers in Azure, deploy those across [availability zones](/azure/reliability/availability-zones-overview) for increased resiliency. Refer to [Create VMs in availability zones](/azure/virtual-machines/create-portal-availability-zone?tabs=standard) and [Migrate VMs to availability zones](/azure/reliability/migrate-vm) for more information.

- Authentication can occur in the cloud and on-premises, or on-premises only. As part of your identity planning, explore the authentication methods Microsoft Entra ID offers. For more information, see [Authentication for Microsoft Entra hybrid identity solutions](/entra/identity/hybrid/connect/choose-ad-authn).

- If you have Active Directory Federation Services (AD FS) federation with Microsoft Entra ID, you can use password hash synchronization as a backup. AD FS does not support seamless single sign-on (SSO).

- If Kerberos is required for Azure Files file shares for Windows users, consider using [Microsoft Entra Kerberos](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal#enable-azure-ad-kerberos-authentication-for-hybrid-user-accounts) rather than deploying domain controllers into the cloud.

## Azure and on-premises (hybrid identity)

User objects that are wholly created in Microsoft Entra ID are known as 'cloud-only' accounts. They support modern authentication and access to Azure and Microsoft 365 resources, as well as for local sign-in on devices using Windows 10 or Windows 11.

However, many organizations are already using Active Directory Domain Services (AD DS) directories that they have been operating for a long time, and which may be integrated with other systems such as line-of-business or Enterprise Resource Planning (ERP) using LDAP. These domains may have many domain-joined computers and applications that use Kerberos or the older NTLMv2 protocols for authentication. In these environments, user objects can be synchronized to Microsoft Entra ID so that users can sign into both on-premises systems and cloud resources with a single identity. Uniting on-premises and cloud directory services is known as 'hybrid identity.' On-premises domains can be extended into Azure Landing Zones:

- Active Directory Domain Services (AD DS) domain users can be synchronized with Entra ID using Microsoft Entra Connect or Microsoft Entra Connect Cloud Sync, to maintain a single user object in both cloud and on-premises environments. Review the [supported topologies](/entra/identity/hybrid/connect/plan-connect-topologies) to determine the recommended configuration for your environment.

- Active Directory Domain Services (AD DS) domain controllers or Microsoft Entra Domain Services can be deployed in Azure to allow Windows virtual machines and other services to be domain-joined. This allows Active Directory Domain Services (AD DS) users to log into Windows servers, Azure Files shares, and other resources that use Active Directory as an authentication source. It also facilitates the use of other AD DS technologies such as Group Policy. See [Common deployment scenarios for Microsoft Entra Domain Services](/entra/identity/domain-services/scenarios).

With hybrid identity, authentication can occur in the cloud and on-premises, or on-premises only. As part of your identity planning, explore the authentication methods Microsoft Entra ID offers. For more information, see [Authentication for Microsoft Entra hybrid identity solutions](/entra/identity/hybrid/connect/choose-ad-authn).

### Hybrid Identity recommendations

- Applications that rely on domain services and use older protocols might be able to use [Microsoft Entra Domain Services](/entra/identity/domain-services/overview). In some cases, existing Active Directory Domain Services domains still allow legacy protocols to support backward compatibility, which can affect security. Rather than extending an on-premises domain, consider using Microsoft Entra Domain Services to start a new domain that doesn't allow legacy protocols, use it as the directory service for cloud-hosted applications.

- Evaluate your identity solution requirements by understanding and documenting the authentication provider that each application uses. Use the reviews to help plan the type of Active Directory your organization should use. For more information, see [Compare Active Directory to Microsoft Entra ID](/entra/fundamentals/compare) and [Identity decision guide](../../../decision-guides/identity/index.md).

- Evaluate scenarios that involve setting up external users, customers, or partners to secure access to resources. Determine whether these scenarios involve [Microsoft Entra B2B](/entra/external-id/what-is-b2b), [Microsoft Entra ID for customers](/entra/external-id/customers/overview-customers-ciam), or [Azure AD B2C](/azure/active-directory-b2c/overview) configurations. For more information, see [Microsoft Entra External ID](/entra/external-id/external-identities-overview).

- Do not use [Microsoft Entra application proxy](/entra/identity/app-proxy/application-proxy) for intranet access, because it will add latency to the user experience. For more information about Microsoft Entra application proxy, see [Microsoft Entra application proxy planning](/entra/identity/app-proxy/application-proxy-deployment-plan#plan-your-implementation) and [Microsoft Entra application proxy security considerations](/entra/identity/app-proxy/application-proxy-security).

- For options to meet organizational requirements when integrating on-premises Active Directory with Azure, see [Integrate on-premises AD with Azure](/azure/architecture/reference-architectures/identity/).

- If you have Active Directory Federation Services (AD FS) federation with Microsoft Entra ID, you can use password hash synchronization as a backup. AD FS doesn't support seamless single sign-on (SSO).

- Determine the right synchronization tool for your cloud identity. For more information, see [Tools for synchronization](/entra/identity/hybrid/sync-tools#selecting-the-right-tool).

- If you have requirement for using Active Directory Federation Services(AD FS), refer to [Deploy Active Directory Federation Services in Azure](/windows-server/identity/ad-fs/deployment/how-to-connect-fed-azure-adfs) for more information.

> [!IMPORTANT]
>
> Microsoft highly recommends migrating to Microsoft Entra ID unless there is a specific requirement for using AD FS. For more information, see [**Resources for decommissioning AD FS**](/windows-server/identity/ad-fs/ad-fs-decommission) and [**Migrating from AD FS to Microsoft Entra ID**](/entra/identity/enterprise-apps/migrate-adfs-apps-stages).
>

## Next Steps

>
> [!div class="nextstepaction"]
> [Landing zone identity and access management](identity-access-landing-zones.md)
