---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# G. Security, Governance and Compliance

## 1. Define Encryption and Key Management

Encryption is a vital step towards ensuring data privacy, compliance, and data residency in Azure. It is also one of the most important security concerns of many enterprise customers. This section will go over the design considerations and recommendations as it pertains to encryption and key management.

***Design Considerations***

- Subscription and scale limits as they apply to Key Vault

  - Key Vault has transaction limits for keys and secrets; For throttling transactions per vault in a certain period see ([Azure Limits](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits))

- Key Vault serves a security boundary since access permissions for keys, secrets and certificates are at the vault level

  - Key Vault Access Policy assignments grant permissions separately to keys, secrets or certificates, but does not support granular, object-level permissions like a specific key, secret, or certificate ([Key Management](https://docs.microsoft.com/en-us/azure/security/fundamentals/data-encryption-best-practices))

  - Isolate application/workload specific secrets and shared secrets as appropriate ([Control Access](https://docs.microsoft.com/en-us/azure/key-vault/general/best-practices))

- Premium SKU can be leveraged where HSM protected keys are required

  - Underlying HSMs are FIPS 140-2 Level 2

  - Managed Azure Dedicated HSM for FIPS 140-2 Level 3 compliance, considering the supported scenarios

- Key rotation and secret expiration

  - Certificate procurement and signing using Key Vault. ([About Certs](https://docs.microsoft.com/en-us/azure/key-vault/certificates/about-certificates))

  - Alerting/notifications and automated certificate renewals

- DR requirements for keys, certificates, and secrets

  - Key Vault service replication and failover capabilities. ([Availability &amp; Redundancy](https://docs.microsoft.com/en-us/azure/key-vault/general/disaster-recovery-guidance))

- Monitoring key, certificate, and secret usage

  - Detection of unauthorized access using Key Vault - log analytics workspace. ([Monitoring &amp; Alerting](https://docs.microsoft.com/en-us/azure/key-vault/general/alert))

- Delegated Key Vault instantiation and privileged access. ([Secure Access](https://docs.microsoft.com/en-us/azure/key-vault/general/secure-your-key-vault))

- Requirements surrounding the use customer managed keys for native encryption mechanisms such as Storage Service Encryption (SSE). ([CMK](https://docs.microsoft.com/en-us/azure/storage/common/storage-encryption-keys-portal))

- Whole disk encryption for Virtual Machines

- Data in transit encryption

- Data at rest encryption

***Design Recommendations***

- Use a federated Key Vault model to avoid transaction scale limits

- Provision Key Vault with the Soft Delete and Purge Policies enabled to allow retention protection for deleted objects

- Follow a least privilege model by limiting authorization to permanently delete keys, secrets, and certificates to specialized custom Azure AD roles 

- Automate the certificate management and renewal process with public Certificate Authorities to ease administration

- Establish an automated process for key and certificate rotation

- Enable firewall and VNET service endpoint on the vault to control access to the Key Vault

- Use the platform-central Log Analytics workspace to audit key, certificate, and secret usage within each Key Vault

- Delegate Key Vault instantiation and privileged access, using Azure Policy to enforce a consistent compliant configuration

- Default to Microsoft managed keys (MMK) for principal encryption functionality and when required to use customer managed keys (CMK)

- Do not use centralized Key Vault instances for application keys or secrets

- Do not share Key Vault instances between applications to avoid secret sharing across environments

## 2. Planning for Governance

Governance provides mechanisms and processes to maintain control over your applications and resources in Azure. Azure Policy is essential to ensuring security and compliance within enterprise technical estates. It can enforce vital management and security conventions across Azure platform services, as well as supplement Role Based Access Controls that control what actions authorized users can perform.

***Design Considerations***

- Determine what Azure Policies are needed

- Enforcing management and security conventions, such the use of private endpoints

- Management and creation of policy assignments

  - Policy definitions can be reused at multiple inherited assignment scopes.

  - Centralized baseline policy assignments at management group, subscription, and resource group scopes

- Compliance reporting and auditing to ensure continuous compliance

- Azure Policy has limits, such as the restriction of definitions at any given scope. ([Policy Limits](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits))

- Regulatory compliance policies such as HIPPA, PCI DSS, SOC TSP

***Design Recommendations***

- Identify required Azure Tags and use the append policy mode to enforce usage

- Map regulatory and compliance requirements to Azure Policy definitions and Azure AD RBAC assignments

- Establish Azure Policy definitions at the top-level root Management Group so that they can be assigned at inherited scopes

- Manage policy assignments at the highest appropriate level with exclusions at bottom levels if required

- Use Azure Policy to control resource provider registrations at the Subscription and/or Management Group levels

- Use built-in policies where possible to minimize operational overhead

- Assign the built-in policy contributor role at a given scope to enable application level governance

- Limit the number of Azure Policy assignments made at the root Management Group scope to avoid managing through exclusions at inherited scopes


## 3. Define Security Monitoring and Audit policy

It is crucial for enterprise customers to have visibility into what is happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is therefore a key component of a scalable framework.

***Design Considerations***

- Data retention periods for audit data; Azure AD reports (premium) has a 30-day retention period

- Long term archiving of logs, such as Azure Activity Logs, VM logs, and PaaS service logs

- Baseline security configuration via Azure In-guest VM Policy

- Emergency patching for critical vulnerabilities

- Patching for VMs that are offline for extended periods of time

- Requirements for real-time monitoring and alerting

- SIEM integration with Azure Security Center and Azure Sentinel

- Vulnerability Assessment of Virtual Machines

***Design Recommendations***

- Use Azure AD reporting capabilities to generate access control audit reports

- Export Azure Activity logs to Log Analytics for long term data retention and if necessary, export to Azure Storage for long term storage beyond two years

- Enable Azure Security Center (Standard SKU) for all subscriptions, using Azure Policy to ensure compliance

- Monitor base OS patching drift via Log analytics and Azure Security Center

- Use Azure Policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration

- Monitor VM security configuration drift via Azure Policy

- Connect default resource configurations to a centralized Log Analytics workspace

- Use an Event Grid based solution for log orientated real-time alerting

## 4. Planning for Platform Security

It is essential to maintain a healthy security posture as enterprise customers adopt Azure. Besides visibility, you have to be able to control the initial settings and changes as the Azure Services evolve. Therefore, planning for platform security is extremely important.

***Design Considerations***

- Shared responsibility

- High availability and Disaster recovery

- Consistent security across Azure services in terms of data management and control plane operations

- &quot;Multi-tenancy under the hood&quot; for key platform components, from Hyper-V and the HSMs underpinning Key Vault to database engines


***Design Recommendations***

- It is recommended that a joint examination of each required service be conducted, within the context of underlying customer requirements

  - If the customer wishes to bring their own keys, this may or may not be supported across all considered services. Relevant mitigations will therefore need to be put forward, so that inconsistencies do not hinder desired outcomes
  
  - Choose appropriate region pairs and disaster recovery regions that minimize latency

- Develop security whitelisting plan to assess services security configuration, monitoring, alerts, and how to integrate those with existing systems

- Determine incident response plan for Azure services before whitelisting

- Use Azure AD reporting capabilities to generate access control audit reports

- Align customer security requirements with Azure platform roadmaps to stay up-to-date with newley relased security controls

- Implement a Zero Trust approach for access to the Azure platform where appropriate

## 5. Service Whitelisting Framework

As business units request to put workloads into Azure, it requires additional visibility into a workload to determine how to achieve appropriate levels of Governance, Security, and Compliance. When a new service is required that has not been onboarded, whitelisting the service needs to occur. The following table provides a framework to assess enterprise security readiness of Azure services.

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
