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

# G. Security, Governance and Compliance

## 1. Define Encryption and Key Management

Encryption is a vital step towards ensuring data privacy, compliance, and sovereignty in Azure, and is ultimately one of the most important security concerns of many enterprise customers.

***Design Considerations***

-   Subscription and scale limits as they apply to Key Vault.

    -   Key Vault transaction limits for keys and secrets; throttling occurs over 2000 transactions per vault in a 10 second period.

-   Key Vault serves a security boundary since access permissions for keys, secrets and certificates are at the vault level.

    -   Key Vault Access Policy assignments grant permissions separately to keys, secrets or certificates, but do not support granular, object-level permissions like a specific key, secret, or certificate.

    -   Consideration should be given to isolate application/workload specific secrets and shared secrets as appropriate.

-   Premium SKU can be leveraged where HSM protected keys are required.

    -   Underlying HSMs are FIPS 140-2 Level 2.

    -   Managed Azure Dedicated HSM for FIPS 140-2 Level 3 compliance, considering the supported scenarios. 

-   Key rotation and secret expiry.

    -   Certificate procurement and signing using Key Vault.

    -   Alerting/notifications and automated certificate renewals.

-   DR requirements for keys, certificates, and secrets.

    -   Key Vault service replication and failover capabilities.

-   Monitoring key, certificate, and secret usage.

    -   Detection of unauthorized access using Key Vault - log analytics workspace.

-   Delegated Key Vault instantiation and privileged access.

-   Requirements surrounding the use customer managed keys for native encryption mechanisms such as Storage Service Encryption (SSE).

***Design Recommendations***

-   Use a federated Key Vault model to avoid transaction scale limits.

-   Provision Key Vault with the Soft Delete and Purge Policies enabled.

-   Limit authorization to permanently delete keys, secrets and certificates to specialized custom Azure AD roles.

-   Automate the certificate management and renewal process with public Certificate Authorities.

-   Establish an automated process for key and certificate rotation.

-   Enable firewall and VNET service endpoint on the vault.

-   Use the platform-central Log Analytics workspace to audit key, certificate, and secret usage within each Key Vault.

-   Delegate Key Vault instantiation and privileged access, using Azure Policy to enforce a consistent compliant configuration.

-   Default to Microsoft managed keys (MMK) for principal encryption functionality and when required use customer manged keys (CMK).

<!-- -->

-   Do not use centralized Key Vault instances for application keys or secrets.

-   Do not share Key Vault instances between applications unless associated threat models encompass all applications considered; Key Vault should be treated as a security boundary.

## 2. Planning for Governance

Azure Policy is essential to ensuring security and compliance within enterprise technical estates, enforcing vital management and security conventions across Azure platform services, as well as supplementing RBAC concerning what actions authorized users can perform.

***Design Considerations***

-   Compliance and assurance on Azure is achieved through Azure Policy; enforcing management and security conventions, such as encryption and the use of private endpoints.

-   Centralized and federated models for the management and creation of policy assignments.

    -   Policy definitions can be reused at multiple inherited assignment scopes.

    -   Centralized baseline policy assignments at management group, subscription and resource group scopes.

-   Compliance reporting and auditing to ensure continuous compliance.

-   Azure Policy limits, such as the restriction of 500 Definitions at any given scope.

***Design Recommendations***

-   Identify required Azure Tags and use the append policy mode to enforce their usage.

-   Map regulatory and compliance requirements to Azure Policy definitions and Azure AD RBAC assignments.

-   Establish Azure Policy definitions at the top-level root Management Group so that they can be assigned at inherited scopes.

-   Manage policy assignments at the highest appropriate level with exclusions at bottom levels if required.

-   Use Azure Policy to control resource provider registrations at the Subscription and/or Management Group levels.

-   Use built-in policies as a preference where possible.

-   Delegate the built-in policy contributor role at a given scope to allow application level governance.

-   Limit the number of Azure Policy assignments made at the root Management Group scope to avoid managing through exclusions at inherited scopes.

## 3. Define Security Monitoring and Audit policy

One of the primary concerns of enterprise customers when migrating to Azure is losing visibility into what is happening within their technical estate. Security monitoring and audit logging of Azure platform services is therefore a crucial security practice required to appropriately safeguard sensitive data.

***Design Considerations***

-   Data retention periods for regulatory audit data; Azure AD reports (premium) has a 30-day retention period.

-   Long term archiving of logs, such as Azure Activity Logs, VM logs, and PaaS service logs.

-   Baseline security configuration via Azure In-guest VM Policy.

-   Emergency patching for critical vulnerabilities.

-   Patching for VMs that are offline for extended periods of time.

-   Requirements for real-time monitoring and alerting.

-   SIEM integration with Azure Security Center and Azure Sentinel.

***Design Recommendations***

-   Use Azure AD reporting capabilities to generate access control audit reports.

-   Export Azure Activity logs to Log Analytics for long term data retention and if necessary, export to Azure Storage for long term storage beyond two years.

-   Enable Azure Security Center (Standard SKU) for all subscriptions, using Azure Policy to ensure compliance.

-   Monitor base OS patching drift via Log analytics and Azure Security Center.

-   Use Azure Policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration.

-   Monitor VM security configuration drift via Azure Policy.

-   Connect default resource configurations to a centralized Log Analytics workspace.

-   Use an Event Grid based solution for log orientated real-time alerting.

## 4. Planning for Platform Security

***Design Considerations***

-   Many customers, particularly those in security conscious industries such as FSI, demand a detailed understanding across the following two topic areas.

    -   Consistent security across Azure services in terms of data management and control plane operations

    -   "Multi-tenancy under the hood" for key platform components, from Hyper-V and the HSMs underpinning Key Vault to database engines.

***Design Recommendations***

-   It is recommended that a joint examination of each required service be conducted, within the context of underlying customer requirements.

    -   For instance, if the customer wishes to bring their own keys, this may or may not be supported across all considered services. Relevant mitigations will therefore need to be put forward, so that inconsistencies do not hinder desired outcomes.

-   Develop security framework to assess services with common security criteria for. 

-   Use Azure AD reporting capabilities to generate access control audit reports.

-   Align customer security requirements with Azure platform roadmaps.

## 5. Service Whitelisting Framework

The following table provides a framework to assess enterprise security readiness of Azure services. 

| Assesment                    | Category                                                              | Crtieria                                                                                                                                     |
|------------------------------|-----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Security                     | Network endpoint                                                      | Does the service have a public endpoint that is accessible outside of a VNet?                                                                |
|                              |                                                                       | Does it support VNet Service Endpoints?                                                                                                      |
|                              |                                                                       | Can Azure services interact directly with the service endpoint?                                                                              |
|                              |                                                                       | Does it support Private Link Endpoints?                                                                                                           |
|                              |                                                                       | Can it be deployed within a VNet?                                                                                                            |
|                              | Data Exfiltration Prevention                                          | Does the PaaS service have a separate BGP community in ExpressRoute Microsoft Peering? (i.e. does ER expose a Route Filter for the service?) |
|                              |                                                                       | Does the service support Private Link Endpoints?                                                                                                       |
|                              | Enforce Network Traffic Flow for management and data plane operations | Is it possible to inspect traffic entering/exiting the service? Can traffic be force tunnelled with UDRs?                                    |
|                              |                                                                       | Do management operations use Azure shared public ip ranges?                                                                                 |
|                              |                                                                       | Is management traffic directed via a link-local endpoint exposed on the host?                                                                |
|                              | Data Encryption at-rest                                               | Is encryption applied by default?                                                                                                            |
|                              |                                                                       | Can encryption be disabled?                                                                                                                  |
|                              |                                                                       | Is encryption performed using Microsoft Managed Keys (MMK) or Customer Managed Keys (CMK)?                                                   |
|                              | Data Encryption in-transit                                            | Is traffic to the service encrypted at a protocol level (SSL/TLS)?                                                                           |
|                              |                                                                       | Are there any HTTP endpoints and can the be disabled?                                                                                        |
|                              |                                                                       | Is underlying service communication also encrypted?                                                                                          |
|                              |                                                                       | Is encryption performed using MMK or CMK? (is BYoK supported?)                                                                               |
|                              | Software Deployment                                                   | Can application software or third party products be deployed to the service?                                                                 |
|                              |                                                                       | How is software deployment performed and managed?                                                                                            |
|                              |                                                                       | Can policies enforced to control source or code integrity?                                                                                   |
|                              |                                                                       | If software is deployable, can antimalware, vulnerability management and security monitoring tools be used?                                  |
|                              |                                                                       | Does the service provide such capabilities natively? (e.g. AKS)                                                                              |
| Identity & Access Management | Authentication & Access Control                                       | Are all Control plane operations governed by Azure AD? (i.e. is there a nested control plane, such as for Kubernetes)                             |
|                              |                                                                       | What methods exist to provide access to the Data plane?                                                                                      |
|                              |                                                                       | Does the Data plane integrate with Azure AD?                                                                                                      |
|                              |                                                                       | Does Azure to Azure (service to service) authentication use a MSI/Service Principal?                                                         |
|                              |                                                                       | Is Azure to IaaS (Service to VNet) authentication via Azure AD?                                                                                   |
|                              |                                                                       | How are any applicable keys/SAS managed?                                                                                                     |
|                              |                                                                       | How can access be revoked?                                                                                                                   |
|                              | Segregation of Duties                                                 | Does the service separate Control plane and Data plane operations within Azure AD?                                                                |
|                              | MFA and conditional access                                            | Is MFA enforced for user to service interactions?                                                                                            |
| Governance                   | Data Export & Import                                                  | Does service allow you to import and export data securely and encrypted?                                                                     |
|                              | Data Privacy & Usage                                                  | Can Microsoft engineers access the data?                                                                                                     |
|                              |                                                                       | Is any Microsoft support interaction with the service audited?                                                                               |
|                              | Data Residency                                                        | Is data contained to the service deployment region?                                                                                          |
| Operations                   | Monitoring                                                            | Does the service integrate with Azure Monitor?                                                                                               |
|                              | Backup Management                                                     | Which workload data need to be backed?                                                                                                       |
|                              |                                                                       | How are backups captured?                                                                                                                    |
|                              |                                                                       | How frequently can backups be taken?                                                                                                         |
|                              |                                                                       | How long can backups be retained for?                                                                                                        |
|                              |                                                                       | Are backups encrypted?                                                                                                                       |
|                              |                                                                       | Is backup encryption performed using MMK or CMK?                                                                                             |
|                              | Disaster Recovery                                                     | How can the service be used in a regional redundant fashion?                                                                                 |
|                              |                                                                       | What is the attainable RTO and RPO?                                                                                                          |
|                              | SKU                                                                   | What SKUs are available? and how do they differ?                                                                                             |
|                              |                                                                       | Are there any features related to security for premium SKU?                                                                                  |
|                              | Capacity Management                                                   | How is capacity monitored?                                                                                                                   |
|                              |                                                                       | What is the unit of horizontal scale?                                                                                                        |
|                              | Patch & Update Management                                             | Does the service require patching or is it abstracted by the service?                                                                        |
|                              |                                                                       | How frequently are patches applied and can they be automated?                                                                                |
|                              | Audit                                                                 | Are nested Control plane operations captured? (e.g. AKS or Databricks)                                                                       |
|                              |                                                                       | Are key Data plane activities recorded?                                                                                                      |
|                              | Configuration Management                                              | Does it support Tags and provide a PUT schema for all resources?                                                                             |
| Azure Service Compliance     | Service Attestation, Certification and External Audits                | Is the service PCI/ISO/SOC compliant?                                                                                                        |
|                              | Service Availability                                                  | Is the service Private Preview/Public Preview/GA?                                                                                            |
|                              |                                                                       | In what regions is the service available?                                                                                                    |
|                              |                                                                       | What is the deployment scope of the service? (i.e. is it a regional or global service?)                                                      |
|                              | Service Level Agreements                                              | What is the SLA for service availability?                                                                                                    |
|                              |                                                                       | If applicable, what is the SLA for performance?                                                                                              |
