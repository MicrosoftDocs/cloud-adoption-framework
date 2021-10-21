---
title: Identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: dominicallen
ms.author: doalle
ms.date: 09/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Identity and access management design area

This critical design area establishes a foundation for the management of identity and access.

## Design Area review

**Involved roles or functions:** This design area will likely require support from one or more of the following functions or roles to make decisions and implement those decisions: [Cloud Platform](../../../organize/cloud-platform.md), and [Cloud Center of Excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The objective of this exercise is to evaluate options for your identity and access foundation. At minimum, you should make decisions regarding your approach for synchronizing identities with Azure Active Directory, authenticating users, assigning access to resources, and any core requirements for separation of duties.

**Out of scope:** This design area establishes a foundation for proper access control, but doesn't fully address more advanced topics like Zero Trust, operational management of elevated privileges, or automated guardrails to prevent common identity and access mistakes. That guidance will be reviewed in the compliance design areas related to [Security](./security.md) and [Governance](./governance.md), since they will likely require a broader audience to make and act on decisions.

## Design Area overview

Identity provides the basis of a large percentage of security assurance. It enables access based on identity authentication and authorization controls in cloud services to protect data and resources and to decide which requests should be permitted.

Identity and access management (IAM) is boundary security in the public cloud. It must be treated as the foundation of any secure and fully compliant public cloud architecture. Azure offers a comprehensive set of services, tools, and reference architectures to enable organizations to make highly secure, operationally efficient environments as outlined here.

This section examines design considerations and recommendations related to IAM in a cloud environment.

The technological landscape in the enterprise is becoming complex and heterogenous. To manage compliance and security for this environment, IAM enables the right individuals to access the right resources at the right time for the right reasons.

### Azure Active Directory design considerations

A critical design decision that an enterprise organization must make when adopting Azure is whether to extend an existing on-premises identity domain into Azure or to create a brand new one.

Requirements for authentication inside the landing zone should be thoroughly assessed and incorporated into plans to deploy Active Directory Domain Services (AD DS) in Windows Server, Azure AD Domain Services (Azure AD DS), or both.

Most Azure environments will use at least Azure AD for Azure fabric authentication and AD DS local host authentication and group policy management.

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone.
- Applications that rely on domain services and use older protocols can use [Azure AD DS](/azure/active-directory-domain-services).
- There is a difference between Azure AD, Azure AD DS, and AD DS running on Windows Server. Evaluate your application needs, and understand and document the authentication provider that each one will be using. Plan accordingly for all applications.

### Pre-requisites for a landing zone - design considerations

#### Role-based access control (RBAC) - design considerations

- There are limits around the number of custom roles and role assignments that must be considered when you lay down a framework around IAM and governance. For more information, see [Azure RBAC service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-role-based-access-control-limits).
- There's a limit of 2,000 role assignments per subscription.
- There's a limit of 500 role assignments per management group.

#### Managed identities - design considerations

- Which tasks and functions should the organization control with managed identities?
- Which services or applications within your landing zone support Azure Active Directory authentication?
- Explore [which Azure services cna use managed identities](/azure/active-directory/managed-identities-azure-resources/services-support-managed-identities)
- Explore [managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) capabilities in further detail

### Identity for Azure platform resources - design considerations

### Platform access - design considerations

- Centralized versus federated resource ownership:
  - Shared resources or any aspect of the environment that implements or enforces a security boundary, such as the network, must be managed centrally. This requirement is part of many regulatory frameworks. It's standard practice for any organization that grants or denies access to confidential or critical business resources.
  - Managing application resources that don't violate security boundaries or other aspects required to maintain security and compliance can be delegated to application teams. Allowing users to provision resources within a securely managed environment allows organizations to take advantage of the agile nature of the cloud while preventing the violation of any critical security or governance boundary.
  - Depending on the definition of the centralized or federated resource ownership, custom roles might differ. The custom roles for the centralized resource ownership are limited and might need additional rights depending on the responsibility model. For example, in some organizations a NetOps role might only need to manage and configure global connectivity. But in other organizations that need a more centralized approach, the NetOps role needs to be enriched with more allowed actions like creating peering between the hub and the spokes.

### Workload access - design considerations

- Based on your cloud operating model, which teams will require access to workloads within the landing zone?
- What roles or functions will those with access carry out?
- What is the minimum level of privilege they would require in order to carry out their responsibilities?

### Hosting Infrastructure-as-a-Service (IaaS) identity solutions - design considerations

- Does the organization need to extend an existing on-premises Active Directory domain into Azure?
- Are there applications that are partly-hosted on-premises and partly-hosted in Azure?

## Identity and access management design recommendations

### Azure Active Directory - design recommendations

- Use centralized and delegated responsibilities to manage resources deployed inside the landing zone based on role and security requirements.
- Privileged operations such as creating service principal objects, registering applications in Azure AD, and procuring and handling certificates or wildcard certificates require special permissions. Consider which users will be handling such requests and how to secure and monitor their accounts with the degree of diligence required.
- If an organization has a scenario where an application that uses integrated Windows authentication must be accessed remotely through Azure AD, consider using [Azure AD Application Proxy](/azure/active-directory/manage-apps/application-proxy).
- Evaluate the compatibility of workloads for AD DS on Windows Server and for Azure AD DS.
- Ensure your network design allows resources that require AD DS on Windows Server for local authentication and management to access the appropriate domain controllers.
  - For AD DS on Windows Server, consider shared services environments that offer local authentication and host management in a larger enterprise-wide network context.
- Deploy Azure AD DS within the primary region because this service can only be projected into one subscription. The Azure AD DS managed domain can be expanded to further regions with [replica sets](/azure/active-directory-domain-services/concepts-replica-sets).
- Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft.

### Pre-requisites for a landing zone - design recommendations

- Use [Azure RBAC](/azure/role-based-access-control/overview) to manage data-plane access to resources, where possible. Examples are Azure Key Vault, a storage account, or a SQL database.
- Deploy Azure AD conditional-access policies for any user with rights to Azure environments. Doing so provides another mechanism to help protect a controlled Azure environment from unauthorized access.
- Enforce multi-factor authentication for any user with rights to the Azure environments. Multi-factor authentication enforcement is a requirement of many compliance frameworks. It greatly lowers the risk of credential theft and unauthorized access.

- Don't add users directly to Azure resource scopes. Instead add users to defined roles, which are then assigned to resource scopes. Direct user assignments circumvent centralized management, greatly increasing the management required to prevent unauthorized access to restricted data.

- Use custom role definitions within the Azure AD tenant while you consider the following key roles:

| Role | Usage | Actions | No actions |
|---|---|---|---|
| Azure platform owner (such as the built-in Owner role)               | Management group and subscription lifecycle management                                                           | `*`                                                                                                                                                                                                                  |                                                                                                                                                                                         |
| Network management (NetOps)        | Platform-wide global connectivity management: Virtual networks, UDRs, NSGs, NVAs, VPN, Azure ExpressRoute, and others            | `*/read`, `Microsoft.Network/*`, `Microsoft.Resources/deployments/*`, `Microsoft.Support/*`                            |                                                                                                                                                                               |
| Security operations (SecOps)       | Security administrator role with a horizontal view across the entire Azure estate and the Azure Key Vault purge policy | `*/read`, `*/register/action`, `Microsoft.KeyVault/locations/deletedVaults/purge/action`, `Microsoft.PolicyInsights/*`, `Microsoft.Authorization/policyAssignments/*`, `Microsoft.Authorization/policyDefinitions/*`, `Microsoft.Authorization/policyExemptions/*`, `Microsoft.Authorization/policySetDefinitions/*`, `Microsoft.Insights/alertRules/*`, `Microsoft.Resources/deployments/*`, `Microsoft.Security/*`, `Microsoft.Support/*` |                                                                            |
| Subscription owner                 | Delegated role for subscription owner derived from subscription Owner role                                       | `*`                                                                                                                                                                                                                  | `Microsoft.Authorization/*/write`, `Microsoft.Network/vpnGateways/*`, `Microsoft.Network/expressRouteCircuits/*`, `Microsoft.Network/routeTables/write`, `Microsoft.Network/vpnSites/*` |
| Application owners (DevOps/AppOps) | Contributor role granted for application/operations team at resource group level                                 | `*`                                                                                                                                                                                                                   | `Microsoft.Authorization/*/write`, `Microsoft.Network/publicIPAddresses/write`, `Microsoft.Network/virtualNetworks/write`, `Microsoft.KeyVault/locations/deletedVaults/purge/action`                                         |

- Use Azure AD managed identities for Azure resources to avoid authentication based on user names and passwords. Because many security breaches of public cloud resources originate with credential theft embedded in code or other text sources, enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

- Use Azure Security Center just-in-time access for all infrastructure as a service (IaaS) resources to enable network-level protection for ephemeral user access to IaaS virtual machines.

- Use [Azure AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to establish zero standing access and least privilege. Map your organization's roles to the minimum level of access needed. Azure AD PIM can either be an extension of existing tools and processes, use Azure native tools as outlined, or use both as needed.

- Use Azure AD PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks. As a result, many organizations will already have a process in place to address this requirement.

- Use privileged identities for automation runbooks that require elevated access permissions. Automated workflows that violate critical security boundaries should be governed by the same tools and policies users of equivalent privilege are.

### Identity for Azure platform resources - design recommendations 

### Platform access - design recommendations

- Use Azure-AD-only groups for Azure control-plane resources in Azure AD PIM when you grant access to resources.
  - Add on-premises groups to the Azure-AD-only group if a group management system is already in place.

- Integrate Azure AD logs with the platform-central [Log Analytics workspace](/azure/azure-monitor/logs/data-platform-logs). It allows for a single source of truth around log and monitoring data in Azure, which gives organizations cloud-native options to meet requirements around log collection and retention.
- If any data sovereignty requirements exist, custom user policies can be deployed to enforce them.

### Hosting Infrastructure-as-a-Service (IaaS) identity solutions - design recommendations

- See the following guidance for [deploying Active Directory Domain Services](/azure/architecture/reference-architectures/identity/adds-extend-domain) in Azure

## Identity and access management in the Azure landing zone accelerator

![Diagram that shows identity and access management.](../../enterprise-scale/media/iam.png)

Identity and access management are core features of the Azure landing zone accelerator implementation.
The deployment includes a subscription dedicated to identity, where customers can deploy the Active Directory domain controllers required for their environment.

The implementation also includes options to assign recommended policies to govern identity and domain controllers.

