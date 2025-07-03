---
title: Hybrid identity with Active Directory and Microsoft Entra ID in Azure landing zones
description: Learn about considerations and recommendations to design and implement Microsoft Entra ID and hybrid identity for Azure landing zones.
author: soderholmd
ms.author: dsoderholm
ms.topic: conceptual
ms.date: 11/28/2024
---

# Hybrid identity with Active Directory and Microsoft Entra ID in Azure landing zones

This article provides guidance about how to design and implement Microsoft Entra ID and hybrid identity for Azure landing zones.

Organizations that operate in the cloud require a directory service to manage user identities and access to resources. Microsoft Entra ID is a cloud-based identity and access management service that provides robust capabilities to manage users and groups. You can use Microsoft Entra ID as a standalone identity solution, or integrate it with a Microsoft Entra Domain Services infrastructure or an on-premises Active Directory Domain Services (AD DS) infrastructure.

Microsoft Entra ID provides modern secure identity and access management for Azure and Microsoft 365 services. You can use Microsoft Entra ID for various organizations and workloads. For example, organizations with an on-premises AD DS infrastructure and cloud-based workloads can use directory synchronization with Microsoft Entra ID. Directory synchronization ensures that on-premises and cloud environments share a consistent set of identities, groups, and roles. Applications that require legacy authentication mechanisms might need Domain Services for managed domain services in the cloud and to extend the on-premises AD DS infrastructure into Azure.

Cloud-based identity management is an iterative process. You might start with a cloud-native solution that has a small set of users and corresponding roles for an initial deployment. As your migration matures, you might need to integrate your identity solution by using directory synchronization or add cloud-hosted domain services as part of your cloud deployments.

Adjust your identity solution over time depending on your workload authentication requirements and other needs, such as changes to your organizational identity strategy and security requirements or integration with other directory services. When you evaluate Windows Server Active Directory solutions, understand the differences between Microsoft Entra ID, Domain Services, and AD DS on Windows Server.

## Identity and access management services in Azure landing zones

The platform team is responsible for the administration of identity and access management. Identity and access management services are fundamental to organizational security. Your organization can use Microsoft Entra ID to control administrative access and protect platform resources. This approach prevents users outside of the platform team from making changes to the configuration or to the security principals contained within Microsoft Entra ID.

If you use AD DS or Domain Services, you must protect the domain controllers from unauthorized access. Domain controllers are highly vulnerable to attacks and should have strict security controls and segregation from application workloads.

Deploy domain controllers and associated components, such as Microsoft Entra Connect servers, in the Identity subscription that's located in the platform management group. Domain controllers aren't delegated to application teams. This isolation allows application owners to use identity services without having to maintain them, which reduces the risk of compromise to identity and access management services. The resources in the Identity platform subscription are a critical point of security for your cloud and on-premises environments.

Provision landing zones so that application owners can choose either Microsoft Entra ID or AD DS and Domain Services to suit their workload needs. You might need to configure other services, depending on your identity solution. For example, you might need to enable and secure network connectivity to the Identity virtual network. If you use a subscription-vending process, include this configuration information in your subscription request.

## Azure and on-premises domains (hybrid identity)

User objects that you create entirely in Microsoft Entra ID are known as *cloud-only accounts*. Cloud-only accounts support modern authentication and access to Azure and Microsoft 365 resources and support access for local devices that use Windows 10 or Windows 11.

Your organization might already have longstanding AD DS directories that you integrate with other systems, such as line of business or enterprise resource planning (ERP) through the Lightweight Directory Access Protocol (LDAP). These domains can have many domain-joined computers and applications that use Kerberos or older NTLMv2 protocols for authentication. In these environments, you can synchronize user objects to Microsoft Entra ID so that users can sign in to both on-premises systems and cloud resources with a single identity. Unifying on-premises and cloud directory services is known as *hybrid identity*. You can extend on-premises domains into Azure landing zones:

- To maintain a single user object in both cloud and on-premises environments, you can sync AD DS domain users with Microsoft Entra ID through Microsoft Entra Connect or Microsoft Entra Cloud Sync. To determine the recommended configuration for your environment, see [Topologies for Microsoft Entra Connect](/entra/identity/hybrid/connect/plan-connect-topologies) and [Topologies for Microsoft Entra Cloud Sync](/entra/identity/hybrid/cloud-sync/plan-cloud-sync-topologies).

- To domain join Windows virtual machines (VMs) and other services, you can deploy AD DS domain controllers or Domain Services in Azure. Use this approach so that AD DS users can sign in to Windows servers, Azure file shares, and other resources that use Active Directory as an authentication source. You can also use other Active Directory technologies, like group policy, as an authentication source. For more information, see [Common deployment scenarios for Microsoft Entra Domain Services](/entra/identity/domain-services/scenarios).

### Hybrid identity recommendations

- To determine your identity solution requirements, document the authentication provider that each application uses. Use the [identity architecture design](/azure/architecture/identity/identity-start-here) to select the right services for your organization. For more information, see [Compare Active Directory to Microsoft Entra ID](/entra/fundamentals/compare).

- You might use [Domain Services](/entra/identity/domain-services/overview) for applications that rely on domain services and use older protocols. Existing AD DS domains sometimes support backward compatibility and allow legacy protocols, which can negatively affect security. Instead of extending an on-premises domain, consider using Domain Services to create a new domain that doesn't allow legacy protocols. Use the new domain as the directory service for cloud-hosted applications.

- Factor in resiliency as a critical design requirement for your hybrid identity strategy in Azure. Microsoft Entra ID is a [globally redundant, cloud-based system](/entra/architecture/architecture) but Domain Services and AD DS aren't. Carefully plan for resiliency when you implement Domain Services and AD DS. When you design either service, consider using multiregion deployments to ensure continued service operation in the event of a regional incident.

- To extend an on-premises AD DS instance into Azure and optimize deployment, incorporate your Azure regions into your Active Directory [site design](/windows-server/identity/ad-ds/plan/creating-a-site-design). Create a site in AD DS sites and services for each Azure region where you plan to deploy workloads. Then create a new subnet object in AD DS sites and services for each IP address range that you plan to deploy in the region. Associate the new subnet object with the AD DS site that you created. This configuration ensures that the domain controller locator service directs authorization and authentication requests to the nearest AD DS domain controllers within the same Azure region.

- Evaluate scenarios that set up guests, customers, or partners so that they can access resources. Determine whether these scenarios involve [Microsoft Entra B2B](/entra/external-id/what-is-b2b) or [Microsoft Entra External ID for customers](/entra/external-id/customers/overview-customers-ciam). For more information, see [Microsoft Entra External ID](/entra/external-id/external-identities-overview).

- Don't use [Microsoft Entra application proxy](/entra/identity/app-proxy/overview-what-is-app-proxy) for intranet access because it adds latency to the user experience. For more information, see [Microsoft Entra application proxy planning](/entra/identity/app-proxy/conceptual-deployment-plan) and [Microsoft Entra application proxy security considerations](/entra/identity/app-proxy/application-proxy-security).

- Consider various methods that you can use to [integrate on-premises Active Directory with Azure](/azure/architecture/reference-architectures/identity) to meet your organizational requirements.

- If you have Active Directory Federation Services (AD FS) federation with Microsoft Entra ID, you can use password hash synchronization as a backup. AD FS doesn't support Microsoft Entra seamless single sign-on (SSO).

- Determine the right [synchronization tool](/entra/identity/hybrid/sync-tools#selecting-the-right-tool) for your cloud identity.

- If you have requirements for using AD FS, see [Deploy AD FS in Azure](/windows-server/identity/ad-fs/deployment/how-to-connect-fed-azure-adfs).

- If you use [Microsoft Entra Connect](/entra/identity/hybrid/connect/whatis-azure-ad-connect-v2) as your synchronization tool, consider deploying a [staging server](/entra/identity/hybrid/connect/how-to-connect-sync-staging-server) in a region that's different from your primary Microsoft Entra Connect server for disaster recovery. Alternatively, if you don't use multiple regions, implement availability zones for high availability.

- If you use [Microsoft Entra Cloud Sync](/entra/identity/hybrid/cloud-sync/what-is-cloud-sync) as your synchronization tool, consider installing at least [three agents](/entra/identity/hybrid/cloud-sync/how-to-prerequisites) across different servers in multiple regions for disaster recovery. Alternatively, you can install the agents across servers in different availability zones for high availability.

> [!IMPORTANT]
>
> We highly recommend that you migrate to Microsoft Entra ID unless you specifically require AD FS. For more information, see [Resources for decommissioning AD FS](/windows-server/identity/ad-fs/ad-fs-decommission) and [Migrate from AD FS to Microsoft Entra ID](/entra/identity/enterprise-apps/migrate-adfs-apps-stages).
>

## Microsoft Entra ID, Domain Services, and AD DS

To implement Microsoft directory services, familiarize administrators with the following options:

- You can [deploy AD DS domain controllers into Azure as Windows VMs](/azure/architecture/example-scenario/identity/adds-extend-domain) that platform or identity administrators fully control. This approach is an infrastructure as a service (IaaS) solution. You can join the domain controllers to an existing Active Directory domain or host a new domain that has an optional trust relationship with existing on-premises domains. For more information, see [Azure Virtual Machines baseline architecture in an Azure landing zone](/azure/architecture/virtual-machines/baseline-landing-zone).

- [Domain Services](/entra/identity/domain-services/overview) is an Azure-managed service that you can use to create a new managed Active Directory domain that's hosted in Azure. The domain can have a trust relationship with existing domains and can synchronize identities from Microsoft Entra ID. Administrators don't have direct access to the domain controllers and aren't responsible for patching and other maintenance operations.

- When you deploy Domain Services or integrate on-premises environments into Azure, use [regions with availability zones](/azure/reliability/availability-zones-region-support) for increased availability when possible. Also consider deploying across multiple Azure regions for increased resiliency.

After you configure AD DS or Domain Services, you can use the same method as on-premises computers to domain join Azure VMs and file shares. For more information, see [Compare Microsoft directory-based services](/entra/identity/domain-services/compare-identity-solutions).

### Microsoft Entra ID and AD DS recommendations

- Use [Microsoft Entra application proxy](/entra/identity/app-proxy/overview-what-is-app-proxy) to access applications that use on-premises authentication remotely through Microsoft Entra ID. This feature provides secure remote access to on-premises web applications. Microsoft Entra application proxy doesn't require a VPN or any changes to the network infrastructure. However, it's deployed as a single instance into Microsoft Entra ID, so application owners and the platform or identity teams must collaborate to ensure that the application is configured correctly.

- Evaluate the compatibility of workloads for AD DS on Windows Server and Domain Services. For more information, see [Common use cases and scenarios](/entra/identity/domain-services/scenarios).

- Deploy domain controller VMs or Domain Services replica sets into the Identity platform subscription within the platform management group.

- Secure the virtual network that contains the domain controllers. To prevent direct internet connectivity to and from the virtual network and domain controller, place the AD DS servers in an isolated subnet with a network security group (NSG). The NSG provides firewall functionality. Resources that use domain controllers for authentication must have a network route to the domain controller subnet. Enable a network route only for applications that require access to services in the Identity subscription. For more information, see [Deploy AD DS in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain#recommendations).

- Use [Azure Virtual Network Manager](/azure/virtual-network-manager/concept-use-cases) to enforce standard rules that apply to virtual networks. For example, you can use Azure Policy or virtual network resource tags to add landing zone virtual networks to a network group if they require Active Directory identity services. The network group can then be used that allows access to the domain controller subnet only from applications that require it and block the access from other applications.

- Secure the role-based access control (RBAC) permissions that apply to the domain controller VMs and other identity resources. Administrators with RBAC role assignments at the Azure control plane, such as Contributor, Owner, or Virtual Machine Contributor, can run commands on the VMs. Ensure that only authorized administrators can access the VMs in the Identity subscription and that overly permissive role assignments aren't inherited from higher management groups.

- Keep your core applications close to, or in the same region as, the virtual network for your replica sets to minimize latency. In a multiregional organization, deploy Domain Services into the region that hosts the core platform components. You can only deploy Domain Services into a single subscription. To expand Domain Services to further regions, you can add up to four more [replica sets](/entra/identity/domain-services/concepts-replica-sets) in separate virtual networks that are peered to the primary virtual network.

- Consider deploying AD DS domain controllers into multiple Azure regions and across [availability zones](/azure/reliability/availability-zones-overview) to increase resiliency and availability. For more information, see [Create VMs in availability zones](/azure/virtual-machines/create-portal-availability-zone) and [Migrate VMs to availability zones](/azure/reliability/migrate-vm).

- Explore the [authentication methods for Microsoft Entra ID](/entra/identity/hybrid/connect/choose-ad-authn) as part of your identity planning. Authentication can occur in the cloud and on-premises, or on-premises only.

- Consider using [Kerberos authentication for Microsoft Entra ID](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable#enable-azure-ad-kerberos-authentication-for-hybrid-user-accounts) instead of deploying domain controllers in the cloud if a Windows user requires Kerberos for Azure Files file shares.

## Next step
>
> [!div class="nextstepaction"]
> [Landing zone identity and access management](identity-access-landing-zones.md)
