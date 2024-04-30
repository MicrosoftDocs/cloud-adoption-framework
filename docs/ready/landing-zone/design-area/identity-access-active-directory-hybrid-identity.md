---
title: Hybrid identity with Active Directory and Microsoft Entra ID in Azure landing zones
description: Learn about considerations and recommendations for designing and implementing Microsoft Entra ID and hybrid identity for Azure landing zones.
author: soderholmd
ms.author: dsoderholm
ms.topic: conceptual
ms.date: 03/25/2024
---

# Hybrid identity with Active Directory and Microsoft Entra ID in Azure landing zones

This article provides guidance on how to design and implement Microsoft Entra ID and hybrid identity for Azure landing zones.

Organizations that operate in the cloud require a directory service to manage user identities and access to resources. Microsoft Entra ID is a cloud-based identity and access management service that provides robust capabilities to manage users and groups. You can use it as a standalone identity solution, or integrate it with a Microsoft Entra Domain Services infrastructure or an on-premises Active Directory Domain Services (AD DS) infrastructure.

Microsoft Entra ID provides modern, secure identity and access management that's suitable for many organizations and workloads, and is at the core of Azure and Microsoft 365 services. If your organization has an on-premises AD DS infrastructure, your cloud-based workloads might require directory synchronization with Microsoft Entra ID for a consistent set of identities, groups, and roles between your on-premises and cloud environments. Or if you have applications that depend on legacy authentication mechanisms, you might have to deploy managed Domain Services in the cloud.

Cloud-based identity management is an iterative process. You could start with a cloud-native solution with a small set of users and corresponding roles for an initial deployment, and as your migration matures, you might need to integrate your identity solution by using directory synchronization or add cloud-hosted domain services as part of your cloud deployments.

Over time, revisit your identity solution depending on your workload authentication requirements and other needs, such as changes to your organizational identity strategy and security requirements, or integration with other directory services. When you evaluate Active Directory solutions, understand the differences between Microsoft Entra ID, Domain Services, and AD DS on Windows Server.

For help with your identity strategy, see [Identity decision guide](../../../decision-guides/identity/index.md).

## Identity and access management services in Azure landing zones

The platform team is responsible for the administration of identity and access management. Identity and access management services are fundamental to organizational security. Organizations can use Microsoft Entra ID to protect platform resources by controlling administrative access. This approach prevents users outside the platform team from making changes to the configuration or to the security principals contained within Microsoft Entra ID.

Organizations that use AD DS or Domain Services must also protect the domain controllers from unauthorized access. Domain controllers are particularly attractive targets for attackers and should have strict security controls and segregation from application workloads.

Domain controllers and associated components, such as Microsoft Entra ID Connect servers, are deployed in the Identity subscription, which is in the platform management group. Domain controllers aren't delegated to application teams. By providing this isolation, application owners can consume the identity services without having to manage them, and the risk of identity and access management services being compromised is reduced. The resources in the Identity platform subscription are a critical point of security for your cloud and on-premises environments.

Landing zones should be provisioned so application owners can use either Microsoft Entra ID or AD DS and Domain Services, as required by their workloads. Depending on which identity solution you use, you might need to configure other services as necessary. For example, you might need to enable and secure network connectivity to the Identity virtual network. If you use a subscription-vending process, include this configuration information in your subscription request.

## Azure and on-premises domains (hybrid identity)

User objects that are created entirely in Microsoft Entra ID are known as *cloud-only accounts*. They support modern authentication and access to Azure and Microsoft 365 resources, and access for local devices that use Windows 10 or Windows 11.

However, many organizations already have longstanding AD DS directories that might be integrated with other systems, such as line-of-business or enterprise resource planning (ERP) via Lightweight Directory Access Protocol (LDAP). These domains might have many domain-joined computers and applications that use Kerberos or older NTLMv2 protocols for authentication. In these environments, you can synchronize user objects to Microsoft Entra ID so that users can sign in to both on-premises systems and cloud resources with a single identity. Uniting on-premises and cloud directory services is known as *hybrid identity*. You can extend on-premises domains into Azure landing zones:

- To maintain a single user object in both cloud and on-premises environments, you can sync AD DS domain users with Microsoft Entra ID via Microsoft Entra Connect or Microsoft Entra Connect Sync. To determine the recommended configuration for your environment, see [Topologies for Microsoft Entra Connect](/entra/identity/hybrid/connect/plan-connect-topologies).

- To domain join Windows VMs and other services, you can deploy AD DS domain controllers or Domain Services in Azure. With this approach, AD DS users can sign in to Windows servers, Azure Files shares, and other resources that use Active Directory as an authentication source. You can also use other Active Directory technologies, such as group policy. For more information, see [Common deployment scenarios for Microsoft Entra Domain Services](/entra/identity/domain-services/scenarios).

### Hybrid identity recommendations

- You might use [Domain Services](/entra/identity/domain-services/overview) for applications that rely on domain services and use older protocols. Sometimes, existing AD DS domains support backward compatibility and allow legacy protocols, which can negatively affect security. Rather than extending an on-premises domain, consider using Domain Services to create a new domain that doesn't allow legacy protocols, and use it as the directory service for cloud-hosted applications.

- Evaluate your identity solution requirements by understanding and documenting the authentication provider that each application uses. Consider the reviews to help plan the type of service that your organization should use. For more information, see [Compare Active Directory to Microsoft Entra ID](/entra/fundamentals/compare) and [Identity decision guide](../../../decision-guides/identity/index.md).

- Evaluate scenarios that involve setting up external users, customers, or partners so they can access resources. Determine whether these scenarios involve [Microsoft Entra B2B](/entra/external-id/what-is-b2b) or [Microsoft Entra External ID for customers](/entra/external-id/customers/overview-customers-ciam). For more information, see [Microsoft Entra External ID](/entra/external-id/external-identities-overview).

- Don't use [Microsoft Entra application proxy](/entra/identity/app-proxy/application-proxy) for intranet access because it adds latency to the user experience. For more information, see [Microsoft Entra application proxy planning](/entra/identity/app-proxy/application-proxy-deployment-plan#plan-your-implementation) and [Microsoft Entra application proxy security considerations](/entra/identity/app-proxy/application-proxy-security).

- Consider various methods that you can use to [integrate on-premises Active Directory with Azure](/azure/architecture/reference-architectures/identity) to meet your organizational requirements.

- If you have Active Directory Federation Services (AD FS) federation with Microsoft Entra ID, you can use password hash synchronization as a backup. AD FS doesn't support Microsoft Entra seamless single sign-on (SSO).

- Determine the right [synchronization tool](/entra/identity/hybrid/sync-tools#selecting-the-right-tool) for your cloud identity.

- If you have requirements for using AD FS, see [Deploy AD FS in Azure](/windows-server/identity/ad-fs/deployment/how-to-connect-fed-azure-adfs).

> [!IMPORTANT]
>
> We highly recommend migrating to Microsoft Entra ID unless there's a specific requirement for using AD FS. For more information, see [Resources for decommissioning AD FS](/windows-server/identity/ad-fs/ad-fs-decommission) and [Migrating from AD FS to Microsoft Entra ID](/entra/identity/enterprise-apps/migrate-adfs-apps-stages).
>

## Microsoft Entra ID, Domain Services, and AD DS

Administrators should familiarize themselves with the options for implementing Microsoft directory services:

- You can [deploy AD DS domain controllers into Azure as Windows virtual machines (VMs)](/azure/architecture/example-scenario/identity/adds-extend-domain) that platform or identity administrators have full control of. This approach is an infrastructure as a service (IaaS) solution. You can join the domain controllers to an existing Active Directory domain, or you can host a new domain that has an optional trust relationship with existing on-premises domains. For more information, see [Azure Virtual Machines baseline architecture in an Azure landing zone](/azure/architecture/virtual-machines/baseline-landing-zone).

- [Domain Services](/entra/identity/domain-services/overview) is an Azure-managed service that you can use to create a new managed Active Directory domain that's hosted in Azure. The domain can have a trust relationship with existing domains and can synchronize identities from Microsoft Entra ID. Administrators don't have direct access to the domain controllers and aren't responsible for patching and other maintenance operations.
- When you deploy Domain Services or integrate on-premises environments into Azure, use locations with [availability zones](/azure/availability-zones/az-overview) for increased availability.

After AD DS or Domain Services is configured, you can domain join Azure VMs and file shares by using the same method as on-premises computers. For more information, see [Compare Microsoft directory-based services](/entra/identity/domain-services/compare-identity-solutions).

### Microsoft Entra ID and AD DS recommendations

- To access applications that use on-premises authentication remotely via Microsoft Entra ID, use [Microsoft Entra application proxy](/entra/identity/app-proxy/application-proxy). This feature provides secure remote access to on-premises web applications. It doesn't require a VPN or any changes to the network infrastructure. However, it's deployed as a single instance into Microsoft Entra ID, so application owners and the platform or identity teams must collaborate to ensure that the application is configured correctly.

- Evaluate the compatibility of workloads for AD DS on Windows Server and Domain Services. For more information, see [Common use cases and scenarios](/entra/identity/domain-services/scenarios).

- Deploy domain controller VMs or Domain Services replica sets into the Identity platform subscription within the platform management group.

- Secure the virtual network that contains the domain controllers. Prevent direct internet connectivity to and from those systems by placing the AD DS servers in an isolated subnet with a network security group (NSG), providing firewall functionality. Resources that use domain controllers for authentication must have a network route to the domain controller subnet. Only enable a network route for applications that require access to services in the Identity subscription. For more information, see [Deploy AD DS in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain#recommendations).
  - Use [Azure Virtual Network Manager](/azure/virtual-network-manager/concept-use-cases) to enforce standard rules that apply to virtual networks. For example, Azure Policy or virtual network resource tags can be used to add landing zone virtual networks to a network group if they require Active Directory identity services. The network group can then be used that allows access to the domain controller subnet only from applications that require it and block the access from other applications.

- Secure the RBAC permissions applying to the domain controller virtual machines and other identity resources. Administrators with RBAC role assignments at the Azure control plane, such as Contributor, Owner, or Virtual Machine Contributor, can run commands on the virtual machines. Ensure that only authorized administrators can access the virtual machines in the Identity subscription, and that overly permissive role assignments are not inherited from higher management groups.

- In a multiregional organization, deploy Domain Services into the region that hosts the core platform components. You can only deploy Domain Services into a single subscription. You can expand Domain Services to further regions by adding up to four more [replica sets](/entra/identity/domain-services/concepts-replica-sets) in separate virtual networks that are peered to the primary virtual network. To minimize latency, keep your core applications close to, or in the same region as, the virtual network for your replica sets.

- When you deploy AD DS domain controllers in Azure, deploy them across [availability zones](/azure/reliability/availability-zones-overview) for increased resiliency. For more information, see [Create VMs in availability zones](/azure/virtual-machines/create-portal-availability-zone) and [Migrate VMs to availability zones](/azure/reliability/migrate-vm).

- Authentication can occur in the cloud and on-premises, or on-premises only. As part of your identity planning, explore the [authentication methods for Microsoft Entra ID](/entra/identity/hybrid/connect/choose-ad-authn).

- If a Windows user requires Kerberos for Azure Files file shares, consider using [Kerberos authentication for Microsoft Entra ID](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable#enable-azure-ad-kerberos-authentication-for-hybrid-user-accounts) rather than deploying domain controllers in the cloud.

## Next steps
>
> [!div class="nextstepaction"]
> [Landing zone identity and access management](identity-access-landing-zones.md)
