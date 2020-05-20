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

# A. Enterprise Enrollment and Azure AD Tenants
## 1. Planning for Enterprise Enrollment 

An Enterprise Enrollment, often referred to as the Enterprise Agreement, represents the commercial relationship between Microsoft and the customer regarding their use of Azure. It provides the basis for billing across all customer subscriptions and therefore has an impact on administration of the customer estate. Enterprise enrollment is managed via Azure enterprise (also referred to as EA) portal. Azure enterprise enrollment often represent organisational hierarchy such as Departments, Accounts and subscription. These hierarchy represent cost enrollment groups within an organisation.

 [![Azure EA hierarchies.](./media/ea-hierarchies.png "Azure EA hierarchies.")](#)
 Figure 1   – EA Enrollment Hierarchy

Departments help you segment costs into logical groupings. Departments enable you to set a budget or quota at the department level(Note: quota is not hard enforcement but rather used for reporting purpose)

Accounts are organizational units in the Azure Enterprise portal. You can use accounts to manage subscriptions and access reports.

Subscriptions are the smallest unit in the Azure Enterprise portal. They're containers for Azure services managed by the service administrator. Subscription is where organisation deploy Azure servies.

Enterprise enrollment roles links users with their functional role and consists of 
- Enterprise administrator
- Department administrator
- Account owner
- Service administrator
- Notification contact
 

***Design Considerations***

- The Enrollment provides a hierarchical organizational structure to govern the management of customers subscriptions.

-   Multiple customers environments can be separated at an EA account level to support holistic isolation.

-   There can be multiple administrators appointed to a single Enrollment.

-   Each Subscription must have an associated Account owner.

-   Each Account owner will be made a subscription owner for any subscriptions provisioned under that account.

-   A subscription can only belong to one Account at any given time.

-   A subscription can be suspended based on a specified set of criteria.

***Design Recommendations***

-   Setup the notification contact email address to ensure notifications are sent to an appropriate group mailbox.

-   Assign a budget for each account and establish an alert associated with the budget.

-   Organisation can have a variety of structures such as functional, divisional, geographic, matrix or team structure. Leverage organizational structure to map organization structure to enterprise enrollment. 

-   Create a new department for IT if business domains have independent IT capabilities.

-   Restrict and minimize the number of Account owners within the Enrollment to avoid the proliferation of admin access to Subscriptions and associated Azure resources.

-   If multiple Azure AD tenants are used, ensure the Account owner is associated with the same tenant as where subscriptions for the account are provisioned.

-   Setup enterprise Dev/Test/Prod environments at an EA account level to support holistic isolation.

-   Do not ignore notification emails sent to the notification account email address. Microsoft sends important EA wide communications to this account.

-   Do not move or rename an EA Account in Azure AD.

-   Periodically audit EA portal to review who has access and avoid using MSA account where possible.

## 2. Define Azure AD Tenants

Azure AD Tenant provide identity and access management which is an important part of security posture ensuring that only authenticated and authorized user have access to resources to which they have permission to access.  Azure AD not only provide these services to applications and services deployed in Azure but to services and applications also deployed outside Azure(such as on-premesis or third party cloud providers). Azure AD service is also utlized by SaaS application such as office 365 and azure marketplace applications. Organization already using on-premesis active directory can leverage their existing infrastructure and can extend authentication to the cloud by integrating AD with Azure AD.  Each Azure AD has one or more domains. A directory can have many subscriptions associated with it, but only one tenant. 

It is very important that we asked basic security question in design phase of Azure AD such how organization is managing credential, control of human and application access and how to control programatic access. 

 

***Design Considerations***

-   Multiple tenants can be leveraged under the same enterprise enrollment.

***Design Recommendations***

-   Leverage Azure AD SSO based on the selected [planning topology](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/plan-connect-topologies).

-   Enforce [MFA](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-mfa-howitworks) and  [conditional access policies](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/overview)  for all privileged accounts.

-   Plan for [emergency access](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.

-   Use Azure AD [priviledged identity management](https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-configure) for Identity and access management.

-   If Dev/Test/Prod are going to be completely isolated environments from an identity perspective, separate them at a tenant level (i.e. use multiple tenants).

<!-- -->

-   Avoid creating a new Azure AD tenant unless there is a strong IAM justification and processes are already in-place.

