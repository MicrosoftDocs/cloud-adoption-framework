## Navigation Menu

* [Overview](../README.md)
* [North Star Architecture](./NorthStar-Architecture.md)
  * [Design Principles](./Design-Principles.md)
  * [Design Guidelines](./Design-Guidelines.md)
    * [A - Enterprise Enrollment and Azure AD Tenants](./A-Enterprise-Enrollment-and-Azure-AD-Tenants.md)
    * [B - Identity and Access Management](./B-Identity-and-Access-Management.md)
    * [C - Management Group and Subscription Organization](./C-Management-Group-and-Subscription-Organization.md)
    * [D - Network Topology and Connectivity](./D-Network-Topology-and-Connectivity.md)
    * [E - Management and Monitoring](./E-Management-and-Monitoring.md)
    * [F - Business Continuity and Disaster Recovery](./F-Business-Continuity-and-Disaster-Recovery.md)
    * [G - Security, Governance and Compliance](./G-Security-Governance-and-Compliance.md)
    * [H - Platform Automation and DevOps](./H-Platform-Automation-and-DevOps.md)
  * [Implementation Guide](./Implementation-Guide.md)
* [Contoso Reference](./Contoso/Readme.md)
  * [Scope and Design](./Contoso/Scope.md)
  * [Implementation](./Contoso/Design.md)
* [Using reference implementation in your own environment](./Deploy/Readme.md)
  * [Getting started](./Deploy/Getting-Started.md)
    * [Prerequisites](./Deploy/Prerequisites.md)
    * [Validate prerequisites](./Deploy/Validate-prereqs.md)
  * [Configure your own environment](./Deploy/Using-Reference-Implementation.md)
    * [Configure GitHub](./Deploy/Configure-run-initialization.md)
    * [Provision Platform](./Deploy/Deploy-platform-infra.md)
    * [Create Landing Zones](./Deploy/Deploy-lz.md)
    * [Trigger deployments locally](./Deploy/Trigger-local-deployment.md)
  * [North Star template schema](./Deploy/NorthStar-schema.md)
    * [Generic North Star ARM template](./Deploy/NorthStar-template-schema.md)
    * [North Star ARM parameters file](./Deploy/NorthStar-parameters-schema.md)
  * [Known Issues](./Deploy/Known-Issues.md)    
* [How Do I Contribute?](./Northstar-Contribution.md)
* [FAQ](./Northstar-FAQ.md)
* [Roadmap](./Northstar-roadmap.md)

---

# B. Identity and Access Management
Identity provides the basis of large percentage of security assurance.  Identity enable access based on identity authentication and authorization controls in cloud services to protect data and resources and to decide which requests should be permitted. 

This section will examine design considerations and recommendations related to  identity and access management in an enterprise environment.

## 1. Planning for identity and access management
- Plan for [Zero Trust](https://www.microsoft.com/en-us/itshowcase/implementing-a-zero-trust-security-model-at-microsoft). 

- Plan for the principal of  [least priviledge]() 

 - Plan for [conditional access](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/overview) based on various criteria such as geoggraphic location.

- Plan for blocking [legacy authentication](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/concept-fundamentals-block-legacy-authentication). 

- Plan for [modern password](https://www.microsoft.com/research/publication/password-guidance/)  authentication or [passwordless authentication](https://docs.microsoft.com/en-us/azure/architecture/framework/security/critical-impact-accounts#passwordless-or-multi-factor-authentication-for-admins). 

 - Plan for [Identity protection](https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/overview-identity-protection).

- Plan for simulated attack 


***Design Considerations***

-   There is a limit of 2000 custom RBAC role assignments per subscription.

-   There is a limit of 500 custom RBAC role assignments per management group.

-   Centralized versus federated resource ownership.

    -   Shared resources such as the network will need managed centrally.

    -   The management of application resources can be delegated to application teams.

-   Custom role definitions can be used to map responsibility boundaries between central and application teams.

***Design Recommendations***

-   Use Azure AD [RBAC](https://docs.microsoft.com/en-us/azure/role-based-access-control/overview) to manage data plane access to resources where possible (e.g. Key Vault, Storage Account, Azure SQL DB).

-   Use Azure AD [PIM](https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-configure) to establish zero standing access and least privilege. And recommend customers to map the organization roles to the minimal role needed.

-   Use "Azure AD only" groups for Azure control plane resources in PIM when granting access to resources.

    -   Add on-premises groups to the "Azure AD only" group if there is an existing group management system already in place.

-   Use Azure AD PIM access reviews to periodically validate resource entitlements.

-   Integrate Azure AD logs with the platform-central Azure [Monitor](https://docs.microsoft.com/en-us/azure/active-directory/reports-monitoring/concept-activity-logs-azure-monitor).

-   Use Custom RBAC role definitions within the Azure AD tenant, considering the following key roles

| Role                             | Usage                                                                                                     | Actions:                                                                                                                                                                                                           | No Actions:                                                                                                                                                                   |
|----------------------------------|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Azure Platform Owner             | Management Group and Subscription lifecycle management                                                    | *                                                                                                                                                                                                                  |                                                                                                                                                                               |
| Network Management (NetOps)      | Platform wide Global Connectivity management; VNets, UDRs, NSGs, NVAs, VPN, ER etc.                       | \*/read, Microsoft.Authorization/\*/write, Microsoft.Network/vpnGateways/\*, Microsoft.Network/expressRouteCircuits/\*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/\*                              |                                                                                                                                                                               |
| Security Operations (SecOps)     | Security Administrator role with a horizontal view across the entire Azure estate and the KV Purge Policy | \*/read, \*/register/action, Microsoft.KeyVault/locations/deletedVaults/purge/action, <br> Microsoft.Insights/alertRules/\*, Microsoft.Authorization/policyDefinitions/\*, Microsoft.Authorization/policyassignments/\*, Microsoft.Authorization/policysetdefinitions/\*, Microsoft.PolicyInsights/\*,Microsoft.Security/\* |                                                                                                                                                                               |
| Subscription Owner               | Delegated Role for Subscription Owner derived from subscription Owner role                                | *                                                                                                                                                                                                                  | Microsoft.Authorization/\*/write, Microsoft.Network/vpnGateways/\*, Microsoft.Network/expressRouteCircuits/\*, Microsoft.Network/routeTables/write, Microsoft.Network/vpnsites/\* |
| Application Owners DevOps/AppOps | Contributor role granted for application/operations team at resource group level                          |                                                                                                                                                                                                                    | Microsoft.Network/publicIPAddresses/write, Microsoft.Network/virtualNetworks/write, Microsoft.KeyVault/locations/deletedVaults/purge/action                                   |

-   Use Azure Security Center just-in-time (JIT) for all IaaS Resources to enable network level protection.

-   Use Azure AD Managed Identities (MI) for Azure resources, avoiding username and password-based authentication.
       
-   Use privileged identities for automation runbooks that require elevated access permissions.

<!-- -->

-   Do not add users directly to Azure resource scopes.

## 2. Planning for Authentication Inside the Landing Zone

A critical design decision enterprise organization must make when adopting Azure is whether to extend and existing on-premises identity domain into Azure or create a brand new one. Requirements for authentication inside the "Landing Zone" should therefore be thoroughly assessed and incorporated into plans to deploy AD, Azure AD-DS or both.

***Design Considerations***

-   Centralized and delegated responsibilities to manage resources deployed inside the "Landing Zone".

-   Applications relying on domain services and using older protocol can leverages [Azure AD domain services](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/). 

-   There are priviledge operation such as creating service principal, registring application in azure AD, procuring and handling certificate or wildcard certificate which will require special permissions.Plan approrpriately for user who will be handling such requests.  

- If organization have scenario where the application using integrated windows authentication needed to be access remotely through azure active directory then consider design for [Azure AD Aplication proxy](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/application-proxy)

- There is a different between Azure AD, Active directory and Azure AD DS. Evaluate your application need and understand and document the authentication provider each one will be using. Plan accordingly for all applications.

***Design Recommendations***

-   Evaluate the compatibility of workloads for Windows Server AD and Azure AD DS.

-   Deploy Azure AD DS within the primary region as this service can be projected into only one subscription.

    -   Use Virtual Network Peering to support its usage as an authentication service.

-   Use Managed Identities instead of Service Principles for authentication to Azure services.

-   Use Just-In-Time access for both VM access and Azure control plane administration.

<!--
[![Identity and Access Management](./media/iam.png "Identity and Access Management")](#)

Figure 4 – Identity and Access Management
 -->
                           
