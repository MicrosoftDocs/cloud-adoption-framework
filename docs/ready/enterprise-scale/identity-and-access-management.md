---
title: Identity and access management
description: Examine design considerations and recommendations related to identity and access management in an enterprise environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management

Identity provides the basis of large percentage of security assurance. Identity enable access based on identity authentication and authorization controls in cloud services to protect data and resources and to decide which requests should be permitted.

Identity and access management (IAM) is boundary security in the public cloud and must be treated as the foundation of any secure and fully compliant public cloud architecture. Microsoft Azure offers a comprehensive set of services, tools and reference architectures to enable organizations to make highly secure, operationally efficient environments and as outlined here.

This section examines design considerations and recommendations related to identity and access management in an enterprise environment.

## Why we need identity and access management

The technological landscape in the enterprise is becoming complex and heterogenous. To manage compliance and security for this environment, IAM enables the right individuals to access the right resources at the right time for right reasons.

### Planning for identity and access management

Enterprise organizations typically follow a least-privileged approach to operational access. This model should be expanded to consider Azure through Azure AD role-based access control (RBAC) and custom role definitions. It is critical to plan how to govern control and data plane access to resources in Azure. Any design for IAM and RBAC must meet regulatory, security, and operational requirements before it can be accepted.

Identity and access management is a multistep process involving careful planning for identity integration and other security considerations, such as blocking legacy authentication and planning for modern passwords. Staging planning also involves selection of business-to-business (B2B) or business-to-consumer (B2C) identity and access management. While these requirements vary, there are common design considerations and recommendations to consider for an enterprise landing zone.

![Identity and access management](./media/iam.png)

_Figure 1: Identity and access management._

**Design considerations:**

- There are limits around the number of custom roles and role assignments that must be considered when laying down a framework around IAM and governance. They can be found here: [Azure RBAC service limits](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#role-based-access-control-limits)
- There is a limit of 2000 custom RBAC role assignments per subscription.

- There is a limit of 500 custom RBAC role assignments per management group.

- Centralized versus federated resource ownership.

  - Shared resources or any aspect of the environment implementing or enforcing a security boundary such as the network must be managed centrally. This is both a requirement of many regulatory frameworks as well as standard practice for any organization that grants or denies access to confidential or critical business resources.

  - Managing application resources that don't violate security boundaries or other aspects required to maintain security and compliance can be delegated to application teams. Allowing users to provision resources within a securely managed environment allows organizations to take advantage of the agile nature of cloud while preventing the violation of any critical security or governance boundary.

<!-- docsTest:ignore Azure-AD-only Azure-AD-managed NetOps SecOps AppOps -->

**Design recommendations:**

- Use Azure AD [RBAC](https://docs.microsoft.com/azure/role-based-access-control/overview) to manage data-plane access to resources where possible (for example, Azure Key Vault, a storage account, or a SQL Database).

- Deploy Azure AD conditional-access policies for any user with rights to Azure environments. Doing so provides another mechanism to help protect a controlled Azure environment from unauthorized access.

- Enforce multi-factor authentication for any user with rights to the Azure environments. This is a requirement of many compliance frameworks and greatly lowers the risk of credential theft and unauthorized access.

- Use [Azure AD Privileged Identity Management (PIM)](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) to establish zero standing access and least privilege. Map your organization's roles to the minimum level of access needed. Azure AD PIM can either be an extension of existing tools and processes, use Azure native tools as outlined above, or use both as needed.

- Use Azure-AD-only groups for Azure control plane resources in Azure AD PIM when granting access to resources.

  - Add on-premises groups to the Azure-AD-only group if a group management system is already in place.

- Use Azure AD PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks, so many organizations will already have a process in place to address this requirement.

- Integrate Azure AD logs with the platform-central [Azure Monitor](https://docs.microsoft.com/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor). Azure Monitor allows for a single source of truth around log and monitoring data in Azure, giving organizations cloud-native options to meet requirements around log collection and retention.

- If any data sovereignty requirements exist, then custom user policies can be deployed to enforce them.

- Use custom RBAC role definitions within the Azure AD tenant while considering the following key roles:

| Role | Usage | Actions | No actions |
|---|---|---|---|
| Azure platform owner               | Management group and subscription lifecycle management                                                           | `*`                                                                                                                                                                                                                  |                                                                                                                                                                                         |
| Network management (NetOps)        | Platform-wide global connectivity management: VNets, UDRs, NSGs, NVAs, VPN, ExpressRoute, and others            | `*/read`, `Microsoft.Authorization/*/write`, `Microsoft.Network/vpnGateways/*`, `Microsoft.Network/expressRouteCircuits/*`, `Microsoft.Network/routeTables/write`, `Microsoft.Network/vpnSites/*`                              |                                                                                                                                                                               |
| Security operations (SecOps)       | Security administrator role with a horizontal view across the entire Azure estate and the Azure Key Vault purge policy | `*/read`, `*/register/action`, `Microsoft.KeyVault/locations/deletedVaults/purge/action`, `Microsoft.Insights/alertRules/*`, `Microsoft.Authorization/policyDefinitions/*`, `Microsoft.Authorization/policyAssignments/*`, `Microsoft.Authorization/policySetDefinitions/*`, `Microsoft.PolicyInsights/*`, `Microsoft.Security/*` |                                                                            |
| Subscription owner                 | Delegated role for subscription owner derived from subscription owner role                                       | `*`                                                                                                                                                                                                                  | `Microsoft.Authorization/*/write`, `Microsoft.Network/vpnGateways/*`, `Microsoft.Network/expressRouteCircuits/*`, `Microsoft.Network/routeTables/write`, `Microsoft.Network/vpnSites/*` |
| Application owners (DevOps/AppOps) | Contributor role granted for application/operations team at resource group level                                 |                                                                                                                                                                                                                    | `Microsoft.Network/publicIPAddresses/write`, `Microsoft.Network/virtualNetworks/write`, `Microsoft.KeyVault/locations/deletedVaults/purge/action`                                         |

- Use Azure Security Center just-in-time (JIT) access for all infrastructure as a service (IaaS) resources to enable network-level protection for ephemeral user access to IaaS virtual machines.

- Use Azure-AD-managed identities for Azure resources to avoid authentication based on user names and passwords. As many security breaches of public cloud resources originated with credential theft embedded in code or other text sources, enforcing managed identities for programmatic access greatly reduces the risk credential theft.

- Use privileged identities for automation runbooks that require elevated access permissions. Automated workflows that violate critical security boundaries should be governed by the same tools and policies users of equivalent privilege are.

- Do not add users directly to Azure resource scopes. This lack of centralized management greatly increases the management required to prevent unauthorized access to restricted data.

### Planning for authentication inside a landing zone

A critical design decision that an enterprise organization must make when adopting Azure is whether to extend an existing on-premises identity domain into Azure or to create a brand new one. Requirements for authentication inside the landing zone should be thoroughly assessed and incorporated into plans to deploy Active Directory Domain Services (AD DS) in Windows Server, Azure AD Domain Services, or both. Most Azure environments will use at least Azure AD for Azure fabric authentication and AD DS local host authentication and group policy management.

**Design considerations:**

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone.

- Applications relying on domain services and using older protocols can use [Azure AD Domain Services](https://docs.microsoft.com/azure/active-directory-domain-services).

**Design recommendations:**

- Use both centralized and delegated responsibilities to manage resources deployed inside the landing zone based on role and security requirements.

- Privileged operations such as creating service principal objects, registering applications in Azure AD, and procuring and handling certificates or wildcard certificates require special permissions. Consider which users will be handling such requests and how to secure and monitor their accounts with the degree of diligence required.

- If an organization has a scenario where an application using integrated Windows authentication must be accessed remotely through Azure AD, then consider using [Azure AD Application Proxy](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy).

- There is a difference between Azure AD, Azure AD Domain Services, and AD DS running on Windows Server. Evaluate your application needs, and understand and document the authentication provider that each one will be using. Plan accordingly for all applications.

- Evaluate the compatibility of workloads for AD DS on Windows Server and for Azure AD Domain Services.

- Ensure your network design allows resources that require AD DS on Windows Server for local authentication and management to access the appropriate domain controllers.

  - For AD DS on Windows Server, consider shared services environments that offer local authentication and host management in a larger enterprise-wide network context.

- Deploy Azure AD Domain Services within the primary region, as this service can only be projected into one subscription.

- Use managed identities instead of service principals for authentication to Azure services. This reduces exposure to credential theft.
