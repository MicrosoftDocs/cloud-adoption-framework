---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: soderholmd
ms.author: dsoderholm 
ms.service: cloud-adoption-framework
ms.topic: conceptual
ms.date: 09/19/2023
---

# Identity Solution and Authentication options

Microsoft Entra ID provides a base level of access control and identity management for Azure resources. If your organization has an on-premises Active Directory infrastructure, your cloud-based workloads might require directory synchronization with Microsoft Entra ID for a consistent set of identities, groups, and roles between your on-premises and cloud environments. Additionally, support for applications that depend on legacy authentication mechanisms might require the deployment of Active Directory Domain Services (AD DS) in the cloud.

Cloud-based identity management is an iterative process. You could start with a cloud-native solution with a small set of users and corresponding roles for an initial deployment. As your migration matures, you might need to integrate your identity solution using directory synchronization or add domains services as part of your cloud deployments. Revisit your identity strategy in every iteration of your migration process.

Refer to these links to decide on the solution:
Identity decision guide - Cloud Adoption Framework | Microsoft Learn

## Azure and on-premises (Hybrid Identity)

User objects that are wholly created in Microsoft Entra ID are known as ‘cloud-only’ accounts. They support modern authentication and access to Azure and Microsoft 365 resources, as well as for local login on devices using Windows 10 or Windows 11.

However, many organizations are already using AD DS directories that they have been operating for a long time, and which may be integrated with other systems such as HR or ERP using LDAP. These domains may have many domain-joined computers and applications that use Kerberos or the older NTLMv2 protocols for authentication. In these environments, user objects can be synchronized to Microsoft Entra ID so that users can log on to both on-premises systems and cloud resources with a single identity. Uniting on-premises and cloud directory services is known as ‘hybrid identity.’  These domains can be extended into Azure Landing Zones:

- Active Directory domain users can be synchronized with Entra ID using AAD Connect or AAD Cloud Sync, to maintain a single user object in both cloud and on-premises environments. Review the supported topologies to determine the recommended configuration for your environment.

- Active Directory domain controllers or Microsoft Entra ID Domain Services (AAD DS) can be deployed in Azure to allow Windows virtual machines and other services to be domain-joined. This allows Active Directory users to log into Windows servers, Azure Files shares, and other resources that use Active Directory as an authentication source. It also facilitates the use of other AD DS technologies such as Group Policy. See  Common deployment scenarios for Microsoft Entra Domain Services.

With hybrid identity, authentication can occur in the cloud and on-premises, or on-premises only. As part of your identity planning, explore the authentication methods Microsoft Entra ID offers. For more information, see Authentication for Microsoft Entra ID hybrid identity solutions.

### Design recommendations

- For options to meet organizational requirements when integrating on-premises Active Directory with Azure, see Integrate on-premises AD with Azure.

- If you have Active Directory Federation Services (AD FS) federation with Microsoft Entra ID, you can use password hash synchronization as a backup. AD FS doesn't support seamless single sign-on (SSO).

- Determine the right synchronization tool for your cloud identity. For more information, see Determine directory synchronization requirements.

- If you have AD FS, move to the cloud to centralize identity and reduce operational effort. If AD FS is still part of your identity solution, install and use Microsoft Entra Connect.

- Identify applications using legacy authentication protocols and migrate them to more modern services.

## Microsoft Entra ID, Microsoft Entra DS, and Windows Server AD DS

Administrators should familiarize themselves with the different options available for implementing Active Directory Domain Services:

- AD DS domain controllers can be deployed into Azure as Windows virtual machines that administrators have full control of. They can be joined to an existing Active Directory domain, or create a new one with a trust relationship with existing on-premises domains. See Deploy AD DS in an Azure virtual network.

- Microsoft Entra DS is an Azure managed service that creates a new AD DS domain hosted in Azure. The domain can be part of a trust relationship with existing domains and can synchronize identities from Microsoft Entra ID. Administrators do not have direct access to the domain controllers and are not responsible for patching and other maintenance operations. For more information, see Overview of Microsoft Entra ID Domain Services | Microsoft Learn.

Once AD DS or AAD DS is configured, Azure virtual machines and file shares can be domain-joined in the same way as on-premises computers. For more information on the different options, see Compare Active Directory-based services in Azure | Microsoft Learn.

### Design recommendations

- To access applications that use on-premises authentication remotely through Microsoft Entra ID, use Microsoft Entra Application Proxy.

- Evaluate the compatibility of workloads for Microsoft Entra ID DS and for AD DS on Windows Server.

- Deploy domain controllers into the Identity subscription within the Platform management group. Domain controllers and other identity services are particularly attractive targets for attackers, and should have strict security controls and segregation from application workloads.

- Make sure to design your network so resources that require AD DS on Windows Server for local authentication and management can access their domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.

- When you deploy Microsoft Entra ID DS or integrate on-premises environments into Azure, use locations with Availability Zones for increased availability.

- Deploy Microsoft Entra ID DS within the primary region, because you can only project this service into one subscription. You can expand Microsoft Entra ID DS to further regions with replica sets.

- If Kerberos is required for Azure Files file shares for Windows users, consider using Microsoft Entra Kerberos rather than deploying domain controllers into the cloud.
