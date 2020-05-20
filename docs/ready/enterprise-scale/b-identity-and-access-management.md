---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management

Identity provides the basis of large percentage of security assurance. Identity enable access based on identity authentication and authorization controls in cloud services to protect data and resources and to decide which requests should be permitted.

Identity and access management (IAM) is boundary security in the public cloud and must be treated as the foundation of any secure and fully compliant public cloud architecture. Azure offers a comprehensive set of services, tools and reference architectures to enable organizations to make highly secure, operationally efficient environments and those will be outlined below.

This section will examine design considerations and recommendations related to identity and access management in an enterprise environment.

### Why do we need identity and access management

Technological landscape in the enterprise is becoming complex and heterogenous. To manage compliance and security for such enviornment, identity and access management (IAM) enable right individuals to access the right resources at the right time and for right reasons.

## 1. Planning for identity and access management

Enterprise organizations will typically follow a least-privileged approach to operational access and this model should be expanded to consider Azure through Azure AD RBAC and custom role definitions. It is critical to plan how to govern control plane and data plane access to resources in Azure. Any design for IAM and RBAC must meet regulatory, security, and operational requirements before it can be accepted.

Identity and access management is multi step process which involve careful planning of identity integration,  and other security consideration such as blocking legacy authentication and planning for modern password. Planning staged also involve selection of B2B or B2C identity and access management. While these requirements varies, there are common design considerations and recommendation which can be taken into account for enterprise landing zone.

![Identity and Access Management](./media/iam.png)

_Figure 1: Identity and access management._

**Design considerations:**

- There are limits around the number of custom roles and role assignments which must be considered when laying down a framework around IAM and governance. They can be found here: [Azure RBAC service limits](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#role-based-access-control-limits)
- There is a limit of 2000 custom RBAC role assignments per subscription.

- There is a limit of 500 custom RBAC role assignments per management group.

- Centralized versus federated resource ownership.

- Shared resources or any aspect of the environment that implements or enforces a security boundary, such as the network, must be managed centrally. This is both a requirement of many regulatory frameworks as well as standard practice for any organization which must grant or deny access to confidential or business critical resources.
  - The management of application resources can be delegated to application teams.

- The management of application resources which do not violate security boundaries or other aspects required to maintain security and compliance can be delegated to application teams. Allowing users to provision resources within a securely managed environment allows organizations to take advantage of the agile nature of cloud while preventing the violation of any critical security or governance boundary.

**Design recommendations:**

- Use Azure AD [RBAC](https://docs.microsoft.com/azure/role-based-access-control/overview) to manage data plane access to resources where possible (e.g. Key Vault, storage account, Azure SQL db).

- Deploy conditional access rules for any user with rights to the Azure environment(s). Doing so will provide another mechanism to help protect a controlled Azure environment from unauthorized access.

- Enforce multi-factor authentication for any user with rights to the Azure environment(s). This is a requirement of many compliance frameworks and greatly lowers the risk of credential theft and unauthorized access.

- Use Azure AD [PIM](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) to establish zero standing access and least privilege. We recommend that customers map the organization roles to the minimum level of access needed. Privilaged identity management in Azure can either be an extension of existing tools and processes, utilize Azure native as outlined above, or both as needed.

- Use "Azure AD only" groups for Azure control plane resources in PIM when granting access to resources.

  - Add on-premises groups to the "Azure AD only" group if there is an existing group management system already in place.

- Use Azure AD PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks so many organizations will already have a process in place to address this requirement.

- Integrate Azure AD logs with the platform-central Azure [monitor](https://docs.microsoft.com/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor). Azure Monitor allows for a single source of truth around log and monitoring data in Azure, giving organizations a cloud native options to meet requirements around log collection and retention.

- If any data sovereignty requirements exist, custom user policies can be deployed to enforce them.

- Use custom RBAC role definitions within the Azure AD tenant, considering the following key roles:

<!-- docsTest:disable TODO -->

| Role                             | Usage                                                                                                     | Actions:                                                                                                                                                                                                           | No actions:                                                                                                                                                                   |
|----------------------------------|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Azure Platform Owner             | Management Group and Subscription lifecycle management                                                    | *                                                                                                                                                                                                                  |                                                                                                                                                                               |
| Network Management (NetOps)      | Platform wide Global Connectivity management; virtual networks, UDRs, NSGs, NVAs, VPN, ER etc.                       | \*/read, Microsoft.Authorization/\*/write, Microsoft.Network/vpnGateways/\*, Microsoft.Network/expressRouteCircuits/\*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/\*                              |                                                                                                                                                                               |
| Security Operations (SecOps)     | Security Administrator role with a horizontal view across the entire Azure estate and the KV Purge Policy | \*/read, \*/register/action, Microsoft.KeyVault/locations/deletedVaults/purge/action, <br> Microsoft.Insights/alertRules/\*, Microsoft.Authorization/policyDefinitions/\*, Microsoft.Authorization/policyassignments/\*, Microsoft.Authorization/policysetdefinitions/\*, Microsoft.PolicyInsights/\*,Microsoft.Security/\* |                                                                                                                                                                               |
| Subscription Owner               | Delegated Role for Subscription Owner derived from subscription Owner role                                | *                                                                                                                                                                                                                  | Microsoft.Authorization/\*/write, Microsoft.Network/vpnGateways/\*, Microsoft.Network/expressRouteCircuits/\*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/\* |
| Application Owners DevOps/AppOps | Contributor role granted for application/operations team at resource group level                          |                                                                                                                                                                                                                    | Microsoft.Network/publicIPAddresses/write, Microsoft.Network/virtualNetworks/write, Microsoft.KeyVault/locations/deletedVaults/purge/action                                   |

<!-- docsTest:enable TODO -->

- Use Azure Security Center just-in-time (JIT) for all IaaS resources to enable network level protection for ephemeral user access to IaaS VMs.

- Use Azure AD managed identities (mi) for Azure resources, avoiding username and password-based authentication. As many security breaches of public cloud resources originated with the theft of credentials embedded in code or other text sources, enforcing managed identities for programmatic access greatly reduces the risk credential theft.

- Use privileged identities for automation runbooks that require elevated access permissions. Automated workflows that violate critical security boundaries should be governed by the same tools and policies users of equivalent privilege are.

- Do not add users directly to Azure resource scopes. This lack of centralized management greatly increases the management required to prevent unauthorized access to restricted data.

### Planning for authentication inside the landing zone

A critical design decision enterprise organization must make when adopting Azure is whether to extend and existing on-premises identity domain into Azure or create a brand new one. Requirements for authentication inside the "landing zone" should therefore be thoroughly assessed and incorporated into plans to deploy Windows Server ad, Azure AD-ds or both. Most Azure environments will use at least Azure AD for Azure fabric authentication and Windows Server ad local host authentication and group policy management.

**Design considerations:**

- Centralized and delegated responsibilities to manage resources deployed inside the "landing zone".

- Applications relying on domain services and using older protocol can uses [Azure AD Domain Services](https://docs.microsoft.com/azure/active-directory-domain-services/).

- There are priviledge operation such as creating service principal, registring application in Azure AD, procuring and handling certificate or wildcard certificate which will require special permissions.plan approrpriately for user who will be handling such requests.

- If organization have scenario where the application using integrated Windows authentication needed to be access remotely through Azure Active Directory then consider design for [Azure AD aplication proxy](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy)

- There is a different between Azure AD, Active Directory and Azure AD DS. Evaluate your application need and understand and document the authentication provider each one will be using. Plan accordingly for all applications.

**Design recommendations:**

- Use both centralized and delegated responsibilities to manage resources deployed inside the "landing zone" based on role and security requirements.

- There are privileged operation such as creating service principals, registering applications in Azure AD, procuring and handling certificates or wildcard certificates, which will require special permissions. Consider which users will be handling such requests and how to secure and monitor their accounts with the degree of diligence required.

- If an organization has a scenario where an application using integrated Windows authentication must be accessed remotely through Azure Active Directory, then consider using [Azure AD application proxy](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy).

- There is a different between Azure AD, Windows Server AD DS and Azure AD DS. Evaluate your application need and understand and document the authentication provider each one will be using. Plan accordingly for all applications.

- Evaluate the compatibility of workloads for Windows Server AD DS and Azure AD DS.

- Ensure your network design allows any resource that requires Windows Server AD DS for local authentication and management to access the appropriate domain controllers.

  - For Windows Server AD DS, consider shared services environment which can offer local authentication and host management larger enterprise wide network context.

- Deploy Azure AD DS within the primary region as this service can be projected into only one subscription.

- Use managed identities instead of service principles for authentication to Azure services. This reduces exposure to credential theft.
