---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: anaishoekstra
ms.author: anaishoekstra
ms.date: 04/29/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure identity and access management design area

This critical design area establishes a foundation for the management of identity and access.

## Design area review

**Involved roles or functions:** This design area likely requires support from one or more of the following functions or roles. These roles can help make decisions and implement those decisions: 

- [Cloud platform](../../../organize/cloud-platform.md)
- [Cloud center of excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The goal of this exercise is to evaluate options for your identity and access foundation. At minimum, you should make decisions about your approach for synchronizing identities with Azure Active Directory:

- Authenticating users
- Assigning access to resources
- Any core requirements for separation of duties

**Out of scope:** This design area forms a foundation for proper access control. But, it doesn't fully address more advanced issues like:

- Zero trust
- Operational management of elevated privileges
- Automated guardrails to prevent common identity and access mistakes

That guidance is reviewed in the compliance design areas related to [security](./security.md) and [governance](./governance.md). Those areas usually require a broader audience to make and act on decisions.

## Design area overview

Identity provides the basis for a large percentage of security assurance. It grants access based on identity authentication and authorization controls in cloud services. Access control protects data and resources and helps decide which requests should be permitted.

Identity and access management (IAM) is boundary security in the public cloud. It must be treated as the foundation of any secure and fully compliant public cloud architecture. Azure offers a comprehensive set of services, tools, and reference architectures to help organizations make highly secure, operationally efficient environments as outlined here.

This section examines design considerations and recommendations related to IAM in a cloud environment.

The technological landscape in the enterprise is becoming complex and heterogenous. To manage compliance and security for this environment, IAM lets the right individuals access the right resources at the right time for the right reasons.

## Azure Active Directory Design

A critical design decision that an enterprise organization must make when adopting Azure is whether to extend a current on-premises identity domain into Azure or to create a brand new one. 

Requirements for authentication inside the landing zone should be thoroughly assessed and incorporated into plans to deploy Active Directory Domain Services (AD DS) in Windows Server, Azure AD Domain Services (Azure AD DS), or both.

Most Azure environments will use at least Azure AD for Azure fabric authentication and AD DS local host authentication and group policy management.

### Design Considerations

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone.

- Applications that rely on domain services and use older protocols might be able to use Azure AD DS.

- There's a difference between Azure AD, Azure AD DS, and AD DS running on Windows Server. Evaluate your application needs and understand and document the authentication provider that each one will be using. Then plan for all applications. Visit this link for more information [Compare Active Directory to Azure Active Directory | Microsoft Docs](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-compare-azure-ad-to-ad)

- Evaluate scenarios where you can provide external users, customers, or partners secure access to resources. Consider whether or not B2B or B2C is right for your scenario. For more information, consult this link External-identities in Azure  

### Design Recommendations

Use centralized and delegated responsibilities to manage resources deployed inside the landing zone based on role and security requirements.

These types of privileged operations require special permissions:

- Creating service principal objects

- Registering applications in Azure AD

- Procuring and handling certificates or wildcard certificates

Consent???

Consider which users will be handling such requests and how to secure and monitor their accounts with the necessary diligence.

If an organization has a scenario where an application that uses integrated Windows On-premises authentication must be accessed remotely through Azure AD, consider using [Azure AD Application Proxy](https://docs.microsoft.com/en-us/azure/active-directory/app-proxy/application-proxy).

Evaluate the compatibility of workloads for AD DS on Windows Server and for Azure AD DS.

Ensure your network design allows resources that require AD DS on Windows Server for local authentication and management to access the appropriate domain controllers.

For AD DS on Windows Server, consider shared services environments that offer local authentication and host management in a larger enterprise-wide network context.

Deploying Azure AD DS, consider redundancy adding location within the Availability zone.

Deploy Azure AD DS within the primary region because this service can only be projected into one subscription. Azure Active Directory Domain Service can be expanded to further regions with replica sets.

Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft.

## Identity for Azure platform resources

### Platform access - design considerations

Use Azure AD-only groups for Azure control-plane resources in Azure AD PIM when you grant access to resources.

Add on-premises groups to the Azure AD-only group if a group management system is already in place.

By using Azure AD-only groups, you can add both users and groups that are synchronized from on-premises, via Azure AD Connect. You can also add Azure AD-only (also known as cloud only) users and groups to a single Azure AD-only group, including guest users.

Also, groups that are synchronized from on-premises can only be managed and updated from the identity source of truth (on-premises Active Directory). These groups can only contain members from the same identity source, which doesn't provide flexibility like Azure AD-only groups do.

Integrate Azure AD logs with the platform-central Log Analytics workspace. It allows for a single source of truth around log and monitoring data in Azure, which gives organizations cloud-native options to meet requirements around log collection and retention.

If any data sovereignty requirements exist, custom user policies can be deployed to enforce them.

Identity Protection here  ???

Admin Consent workflow ?

## Prerequisites for a landing zone

### Role-based access control (RBAC) design considerations

Use Azure RBAC to manage data-plane access to resources, where possible. Examples are Azure Key Vault, a storage account, or an SQL database.

Deploy Azure AD conditional-access policies for any user with rights to Azure environments. Doing so provides another mechanism to help protect a controlled Azure environment from unauthorized access.

Enforce multifactor authentication for any user with rights to the Azure environments. Multifactor authentication enforcement is a requirement of many compliance frameworks. It greatly lowers the risk of credential theft and unauthorized access.

Don't add users directly to Azure resource scopes. Instead add users to defined roles, which are then assigned to resource scopes. Direct user assignments circumvent centralized management, greatly increasing the management required to prevent unauthorized access to restricted data.

Use custom role definitions within the Azure AD tenant while you consider the following key roles:

Azure platform owner (such as the built-in Owner role) 

- Management group and subscription lifecycle management 

Network management (NetOps)

- Platform-wide global connectivity management: virtual networks, UDRs, NSGs, NVAs, VPN, Azure ExpressRoute, and others:

- */read, Microsoft.Network/*, Microsoft.Resources/deployments/*, Microsoft.Support/*


Security operations (SecOps)

- Security Administrator role with a horizontal view across the entire Azure estate and the Azure Key Vault purge policy:

- */read, */register/action, Microsoft.KeyVault/locations/deletedVaults/purge/action, Microsoft.PolicyInsights/*, Microsoft.Authorization/policyAssignments/*, Microsoft.Authorization/policyDefinitions/*, Microsoft.Authorization/policyExemptions/*, Microsoft.Authorization/policySetDefinitions/*, Microsoft.Insights/alertRules/*, Microsoft.Resources/deployments/*, Microsoft.Security/*, Microsoft.Support/*

Subscription owner

- Delegated role for subscription owner generated from subscription Owner role:

Microsoft.Authorization/*/write, Microsoft.Network/vpnGateways/*, Microsoft.Network/expressRouteCircuits/*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnSites/*

Application owners (DevOps/AppOps)

- Contributor role granted for application/operations team at resource group level

- Microsoft.Authorization/*/write, Microsoft.Network/publicIPAddresses/write, Microsoft.Network/virtualNetworks/write, Microsoft.KeyVault/locations/deletedVaults/purge/action 

Use Azure AD-managed identities for Azure resources to avoid authentication based on usernames and passwords. Many security breaches of public cloud resources originate with credential theft embedded in code or other text sources. For this reason, enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

Use Microsoft Defender for Cloud just-in-time access for all infrastructure as a service (IaaS) resources. Doing so lets you enable network-level protection for ephemeral user access to IaaS virtual machines.

Use Azure AD Privileged Identity Management (PIM) to establish zero-standing access and least privilege. Map your organization's roles to the minimum level of access needed. Azure AD PIM can:

- Be an extension of current tools and processes

- Use Azure native tools as outlined

- Use both as needed

Use Azure AD PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks. As a result, many organizations will already have a process in place to address this requirement.

Use privileged identities for automation runbooks that require elevated access permissions. Automated workflows that violate critical security boundaries should be governed by the same tools and policies users of equivalent privilege are.

### Managed Identities design considerations

Examine which Azure resources/services (or workloads, if that sounds more ALZ term) don’t need to manage the credentials and you use Manage Identities, with system-assigned or user-assigned managed identities. More information you can find here is this link [Managed identities for Azure resources | Microsoft Docs](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview)

Verify which Azure resources are supported by this feature Azure Services with managed identities support - Azure AD | Microsoft Docs

Manage Identity could be used by applications that need to be authenticated against any Azure service that supports [Azure AD authentication Azure Active Directory authentication overview | Microsoft Docs]()

Consider reading this guidance: [Best practice recommendations for managed system identities | Microsoft Docs](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations) for choosing the right identities (user or system assigned managed identities) option based on your scenario.  

Which tasks and functions should the organization control with managed identities?

Which services or applications within your landing zone support Azure Active Directory authentication?

Service principal vs managed identity for CI/CD

### Hosting infrastructure as a service (IaaS) identity solution design considerations

For scenarios where it is needed to integrate on-premises AD with Azure, evaluate which options satisfy the org requirements by Integrating the On-premises domain with Azure or Extending the on-premises Active Directory in Azure by deploying an AD DS server in Azure. You can find further information here at this link Integrate on-premises AD with Azure - Azure Architecture Center | Microsoft Docs.  

The authentication process can occur in the Cloud, Cloud, and On-premises or only On-premises. Explore the authentication methods offered by Azure Active Directory as part of your identity planning. Authentication for Azure AD hybrid identity solutions - Active Directory | Microsoft Docs

In the case you have AD FS because you require sign-in across multiple IdP, you can set up PHS as backup. However, the scenario seamless SSO is not supported in Active Directory Federation Services.  

Validate the right Synchronization tool for your Identity on the cloud  Hybrid identity design - directory sync requirements Azure | Microsoft Docs

Does the organization need to extend the current on-premises Active Directory domain into Azure?  

Are there applications that are partly hosted on-premises and partly hosted in Azure?

### Hosting infrastructure as a service (IaaS) identity solution design recommendations

For applications that are hosted partly on-premises and partly in Azure, verify which integration on-premises base on your scenario.  

See the following guidance for deploying Active Directory Domain Services in Azure.  

In the case you have ADFS, it is recommended to move to the cloud since it could reduce costs.  

However, in the case the ADFS is still part of your Identity solution it is highly recommended having Connect Health.

## Identity and access management in the Azure landing zone accelerator

Identity and access management are core features of the Azure landing zone accelerator implementation. The deployment includes a subscription dedicated to identity, where customers can deploy the Active Directory domain controllers required for their environment.

The implementation also includes options to assign recommended policies to govern identity and domain controllers
