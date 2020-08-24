---
title: Enterprise-scale security governance and compliance
description: Learn about enterprise-scale security governance and compliance in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise-scale security governance and compliance

This article covers defining encryption and key management, planning for governance, defining security monitoring and an audit policy, and planning for platform security. At the end of the article, you can refer to a table that describes a framework to assess enterprise security readiness of Azure services. 

## Define encryption and key management

Encryption is a vital step toward ensuring data privacy, compliance, and data residency in Microsoft Azure. It's also one of the most important security concerns of many enterprises. This section covers design considerations and recommendations as they pertain to encryption and key management.

### Design considerations

- Subscription and scale limits as they apply to Azure Key Vault: Key Vault has transaction limits for keys and secrets. To throttle transactions per vault in a certain period, see [Azure limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

- Key Vault serves a security boundary because access permissions for keys, secrets, and certificates are at the vault level. Key Vault access policy assignments grant permissions separately to keys, secrets, or certificates. They don't support granular, object-level permissions like a specific key, secret, or certificate [key management](/azure/security/fundamentals/data-encryption-best-practices).

- You can isolate application-specific and workload-specific secrets and shared secrets, as appropriate [control access](/azure/key-vault/general/best-practices).

<!-- cSpell:ignore FIPS -->

- You can optimize premium SKUs where hardware-security-module-protected keys are required. Underlying hardware security modules (HSMs) are FIPS 140-2 level 2 compliant. Manage Azure dedicated HSM for FIPS 140-2 level 3 compliance by considering the supported scenarios.

- Key rotation and secret expiration.

  - Certificate procurement and signing by using Key Vault [about certificates](/azure/key-vault/certificates/about-certificates).
  - Alerting/notifications and automated certificate renewals.

- Disaster recovery requirements for keys, certificates, and secrets.

  Key Vault service replication and failover capabilities: [availability and redundancy](/azure/key-vault/general/disaster-recovery-guidance).

- Monitoring key, certificate, and secret usage.

  Detecting unauthorized access by using a key vault or Azure Monitor Log Analytics workspace: [monitoring and alerting](/azure/key-vault/general/alert).

- Delegated Key Vault instantiation and privileged access: [secure access](/azure/key-vault/general/secure-your-key-vault).

- Requirements for using customer-managed keys for native encryption mechanisms such as Azure Storage encryption:
  - [Customer-managed keys](/azure/storage/common/storage-encryption-keys-portal).
  - Whole-disk encryption for virtual machines (VMs).
  - Data-in-transit encryption.
  - Data-at-rest encryption.

### Design recommendations

- Use a federated Azure Key Vault model to avoid transaction scale limits.

- Provision Azure Key Vault with the soft delete and purge policies enabled to allow retention protection for deleted objects.

- Follow a least privilege model by limiting authorization to permanently delete keys, secrets, and certificates to specialized custom Azure Active Directory (Azure AD) roles.

- Automate the certificate management and renewal process with public certificate authorities to ease administration.

- Establish an automated process for key and certificate rotation.

- Enable firewall and virtual network service endpoint on the vault to control access to the key vault.

- Use the platform-central Azure Monitor Log Analytics workspace to audit key, certificate, and secret usage within each instance of Key Vault.

- Delegate Key Vault instantiation and privileged access and use Azure Policy to enforce a consistent compliant configuration.

- Default to Microsoft-managed keys for principal encryption functionality and use customer-managed keys when required.

- Don't use centralized instances of Key Vault for application keys or secrets.

- Don't share Key Vault instances between applications to avoid secret sharing across environments.

## Plan for governance

Governance provides mechanisms and processes to maintain control over your applications and resources in Azure. Azure Policy is essential to ensuring security and compliance within enterprise technical estates. It can enforce vital management and security conventions across Azure platform services and supplement role-based access control (RBAC) that controls what actions authorized users can perform.

### Design considerations

- Determine what Azure policies are needed.

- Enforce management and security conventions, such as the use of private endpoints.

- Manage and create policy assignments by using policy definitions can be reused at multiple inherited assignment scopes. You can have centralized, baseline policy assignments at management group, subscription, and resource group scopes.

- Ensure continuous compliance with compliance reporting and auditing.

- Understand that Azure Policy has limits, such as the restriction of definitions at any particular scope: [policy limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

- Understand regulatory compliance policies. These might include the health insurance portability and accountability act, payment card industry, data security standards, service organization controls trust service principals, and criteria.

### Design recommendations

- Identify required Azure tags and use the append policy mode to enforce usage.

- Map regulatory and compliance requirements to Azure Policy definitions and Azure AD RBAC assignments.

- Establish Azure Policy definitions at the top-level root management group so that they can be assigned at inherited scopes.

- Manage policy assignments at the highest appropriate level with exclusions at bottom levels, if required.

- Use Azure Policy to control resource provider registrations at the subscription and/or management group levels.

- Use built-in policies where possible to minimize operational overhead.

- Assign the built-in policy contributor role at a particular scope to enable application-level governance.

- Limit the number of Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.

## Define security monitoring and an audit policy

An enterprise must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework.

### Design considerations

- Data retention periods for audit data. Azure AD Premium reports have a 30-day retention period.

- Long-term archiving of logs such as Azure activity logs, VM logs, and platform as a service (PaaS) logs.

- Baseline security configuration via Azure in-guest VM policy.

- Emergency patching for critical vulnerabilities.

- Patching for VMs that are offline for extended periods of time.

- Requirements for real-time monitoring and alerting.

- Security information and event management integration with Azure Security Center and Azure Sentinel.

- Vulnerability assessment of VMs.

### Design recommendations

- Use Azure AD reporting capabilities to generate access control audit reports.

- Export Azure activity logs to Azure Monitor logs for long-term data retention. Export to Azure Storage for long-term storage beyond two years, if necessary.

- Enable Security Center Standard for all subscriptions, and use Azure Policy to ensure compliance.

- Monitor base operating system patching drift via Azure Monitor logs and Azure Security Center.

- Use Azure policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration.

- Monitor VM security configuration drift via Azure Policy.

- Connect default resource configurations to a centralized Azure Monitor Log Analytics workspace.

- Use an Azure Event Grid-based solution for log-oriented, real-time alerting.

## Plan for platform security

You must maintain a healthy security posture as you adopt Azure. Besides visibility, you have to be able to control the initial settings and changes as the Azure services evolve. Therefore, planning for platform security is key.

### Design considerations

- Shared responsibility.

- High availability and disaster recovery.

- Consistent security across Azure services in terms of data management and control plane operations.

- Multitenancy for key platform components. This includes Hyper-V, the HSMs underpinning Key Vault, and database engines.

### Design recommendations

- In the context of your underlying requirements, conduct a joint examination of each required service. If you want to bring your own keys, this might not be supported across all considered services. Implement relevant mitigation so that inconsistencies don't hinder desired outcomes. Choose appropriate region pairs and disaster recovery regions that minimize latency.

- Develop a security allow-list plan to assess services security configuration, monitoring, alerts, and how to integrate these with existing systems.

- Determine the incident response plan for Azure services before allowing.

- Use Azure AD reporting capabilities to generate access control audit reports.

- Align your security requirements with Azure platform roadmaps to stay current with newly released security controls.

- Implement a zero-trust approach for access to the Azure platform, where appropriate.

<!-- docsTest:ignore "and conditional access" -->

## Service enablement framework

As business units request to deploy workloads to Azure, you need additional visibility into a workload to determine how to achieve appropriate levels of governance, security, and compliance. When a new service is required, you need to allow it. The following table provides a framework to assess enterprise security readiness of Azure services:

| Assessment                    | Category                                                              | Criteria                                                                                                                                     |
|------------------------------|-----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Security                     | Network endpoint                                                      | Does the service have a public endpoint that is accessible outside of a virtual network?                                                                |
|                              |                                                                       | Does it support virtual network service endpoints?                                                                                                      |
|                              |                                                                       | Can Azure services interact directly with the service endpoint?                                                                              |
|                              |                                                                       | Does it support Azure Private Link endpoints?                                                                                                           |
|                              |                                                                       | Can it be deployed within a virtual network?                                                                                                            |
|                              | Data exfiltration prevention                                          | Does the PaaS service have a separate border gateway protocol community in Azure ExpressRoute Microsoft peering? Does ExpressRoute expose a route filter for the service? |
|                              |                                                                       | Does the service support Private Link endpoints?                                                                                                       |
|                              | Enforce network traffic flow for management and data plane operations | Is it possible to inspect traffic entering/exiting the service? Can traffic be force-tunnelled with user-defined routing?                                    |
|                              |                                                                       | Do management operations use Azure shared public IP ranges?                                                                                 |
|                              |                                                                       | Is management traffic directed via a link-local endpoint exposed on the host?                                                                |
|                              | Data encryption at-rest                                               | Is encryption applied by default?                                                                                                            |
|                              |                                                                       | Can encryption be disabled?                                                                                                                  |
|                              |                                                                       | Is encryption performed with Microsoft-managed keys or customer-managed keys?                                                   |
|                              | Data encryption in-transit                                            | Is traffic to the service encrypted at a protocol level (secure sockets layer/transport layer security)?                                                                           |
|                              |                                                                       | Are there any HTTP endpoints, and can they be disabled?                                                                                        |
|                              |                                                                       | Is underlying service communication also encrypted?                                                                                          |
|                              |                                                                       | Is encryption performed with Microsoft-managed keys or customer-managed keys? (Is bring your own encryption supported?)                                                                               |
|                              | Software deployment                                                   | Can application software or third-party products be deployed to the service?                                                                 |
|                              |                                                                       | How is software deployment performed and managed?                                                                                            |
|                              |                                                                       | Can policies be enforced to control source or code integrity?                                                                                   |
|                              |                                                                       | If software is deployable, can antimalware capability, vulnerability management, and security monitoring tools be used?                                  |
|                              |                                                                       | Does the service provide such capabilities natively, such as with Azure Kubernetes Service?                                                                              |
| Identity and access management | Authentication and access control                                       | Are all control plane operations governed by Azure AD? Is there a nested control plane, such as with Azure Kubernetes Service?                             |
|                              |                                                                       | What methods exist to provide access to the data plane?                                                                                      |
|                              |                                                                       | Does the data plane integrate with Azure AD?                                                                                                      |
|                              |                                                                       | Does Azure-to-Azure (service-to-service) authentication use an MSI/service principal?                                                         |
|                              |                                                                       | Is Azure-to-IaaS (service-to-virtual-network) authentication via Azure AD?                                                                                   |
|                              |                                                                       | How are any applicable keys or shared access signatures managed?                                                                                                     |
|                              |                                                                       | How can access be revoked?                                                                                                                   |
|                              | Segregation of duties                                                 | Does the service separate control plane and data plane operations within Azure AD?                                                                |
|                              | Multi-factor authentication and conditional access                                            | Is multi-factor authentication enforced for user to service interactions?                                                                                            |
| Governance                   | Data export and import                                                  | Does service allow you to import and export data securely and encrypted?                                                                     |
|                              | Data privacy and usage                                                  | Can Microsoft engineers access the data?                                                                                                     |
|                              |                                                                       | Is any Microsoft Support interaction with the service audited?                                                                               |
|                              | Data residency                                                        | Is data contained to the service deployment region?                                                                                          |
| Operations                   | Monitoring                                                            | Does the service integrate with Azure Monitor?                                                                                               |
|                              | Backup management                                                     | Which workload data need to be backed up?                                                                                                       |
|                              |                                                                       | How are backups captured?                                                                                                                    |
|                              |                                                                       | How frequently can backups be taken?                                                                                                         |
|                              |                                                                       | How long can backups be retained for?                                                                                                        |
|                              |                                                                       | Are backups encrypted?                                                                                                                       |
|                              |                                                                       | Is backup encryption performed with Microsoft-managed keys or customer-managed keys?                                                                                             |
|                              | Disaster recovery                                                     | How can the service be used in a regional redundant fashion?                                                                                 |
|                              |                                                                       | What is the attainable recovery time objective and recovery point objective?                                                                                                          |
|                              | SKU                                                                   | What SKUs are available? And how do they differ?                                                                                             |
|                              |                                                                       | Are there any features related to security for Premium SKU?                                                                                  |
|                              | Capacity management                                                   | How is capacity monitored?                                                                                                                   |
|                              |                                                                       | What is the unit of horizontal scale?                                                                                                        |
|                              | Patch and update management                                             | Does the service require active updating or do updates happen automatically?                                                                        |
|                              |                                                                       | How frequently are updates applied? Can they be automated?                                                                                |
|                              | Audit                                                                 | Are nested control plane operations captured (for example, Azure Kubernetes Service or Azure Databricks)?                                                                      |
|                              |                                                                       | Are key data plane activities recorded?                                                                                                      |
|                              | Configuration management                                              | Does it support tags and provide a `put` schema for all resources?                                                                             |
| Azure service compliance     | Service attestation, certification, and external audits                | Is the service PCI/ISO/SOC compliant?                                                                                                        |
|                              | Service availability                                                  | Is the service a private preview, a public preview, or generally available?                                                                                            |
|                              |                                                                       | In what regions is the service available?                                                                                                    |
|                              |                                                                       | What is the deployment scope of the service? Is it a regional or global service?                                                      |
|                              | Service-level agreements (SLAs)                                              | What is the SLA for service availability?                                                                                                    |
|                              |                                                                       | If applicable, what is the SLA for performance?                                                                                              |
