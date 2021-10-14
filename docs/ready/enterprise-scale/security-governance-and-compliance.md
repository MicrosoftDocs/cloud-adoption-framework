---
title: Enterprise-scale security governance and compliance
description: Learn about enterprise-scale security governance and compliance in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Enterprise-scale security governance and compliance

This article defines encryption and key management, helps you plan for governance, defines security monitoring and an audit policy, and enables you to plan for platform security. At the end of this guidance, refer to tables that describes a framework to assess enterprise security readiness of Azure services.

## Define encryption and key management

Encryption is a vital step toward ensuring data privacy, compliance, and data residency in Microsoft Azure. It's also one of the most important security concerns of many enterprises. This section covers design considerations and recommendations for encryption and key management.

**Design considerations:**

- Set subscription and scale limits as they apply to Azure Key Vault.

   Key Vault has transaction limits for keys and secrets. To throttle transactions per vault in a certain period, see [Azure limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

   Key Vault serves a security boundary because access permissions for keys, secrets, and certificates are at the vault level. Key Vault access policy assignments grant permissions separately to keys, secrets, or certificates. They don't support granular, object-level permissions like a specific key, secret, or certificate [key management](/azure/security/fundamentals/data-encryption-best-practices).

- Isolate application-specific and workload-specific secrets and shared secrets, as appropriate to [control access](/azure/key-vault/general/best-practices).

- Optimize premium SKUs where hardware-security-module-protected keys are required.

   Underlying hardware security modules (HSMs) are FIPS 140-2 Level 2 compliant. Manage Azure dedicated HSM for FIPS 140-2 Level 3 compliance by considering the supported scenarios.

- Manage key rotation and secret expiration.

- Use [Key Vault certificates](/azure/key-vault/certificates/about-certificates) to manage certificate procurement and signing. Set alerting, notifications, and automated certificate renewals.

- Set disaster recovery requirements for keys, certificates, and secrets.

- Set Key Vault service replication and failover capabilities. Set [availability and redundancy](/azure/key-vault/general/disaster-recovery-guidance).

- Monitor key, certificate, and secret usage.

  Detect unauthorized access by using a key vault or Azure Monitor Log Analytics workspace. For more information, see [Monitoring and alerting for Azure Key Vault](/azure/key-vault/general/alert).

- Delegate Key Vault instantiation and privileged access. For more information, see [Azure Key Vault security](/azure/key-vault/general/security-features).

- Set requirements for using customer-managed keys for native encryption mechanisms, such as Azure Storage encryption:

  - [Customer-managed keys](/azure/storage/common/customer-managed-keys-configure-key-vault).
  - Whole-disk encryption for virtual machines (VMs).
  - Data-in-transit encryption.
  - Data-at-rest encryption.

**Design recommendations:**

- Use a federated Azure Key Vault model to avoid transaction scale limits.

- Provision Azure Key Vault with the soft delete and purge policies enabled to allow retention protection for deleted objects.

- Follow a least privilege model by limiting authorization to permanently delete keys, secrets, and certificates to specialized custom Azure Active Directory (Azure AD) roles.

- Automate the certificate management and renewal process with public certificate authorities to ease administration.

- Establish an automated process for key and certificate rotation.

- Enable firewall and virtual network service endpoints on the vault to control access to the key vault.

- Use the platform-central Azure Monitor Log Analytics workspace to audit key, certificate, and secret usage within each instance of Key Vault.

- Delegate Key Vault instantiation and privileged access and use Azure Policy to enforce a consistent compliant configuration.

- Default to Microsoft-managed keys for principal encryption functionality and use customer-managed keys when required.

- Don't use centralized instances of Key Vault for application keys or secrets.

- Don't share Key Vault instances between applications to avoid secret sharing across environments.

## Plan for governance

Governance provides mechanisms and processes to maintain control over your applications and resources in Azure. Azure Policy is essential to ensure security and compliance within enterprise technical estates. It can enforce vital management and security conventions across Azure platform services. Azure Policy can also supplement Azure role-based access control, which determines what actions authorized users can do.

**Design considerations:**

- Determine what Azure policies are needed.

- Enforce management and security conventions, such as the use of private endpoints.

- Manage and create policy assignments by using policy definitions that can be reused at multiple inherited assignment scopes.

   You can have centralized, baseline policy assignments at management group, subscription, and resource group scopes.

- Ensure continuous compliance with compliance reporting and auditing.

- Understand that Azure Policy has limits, such as the restriction of definitions at any particular scope. For more information, see [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits).

- Understand regulatory compliance policies. These policies might include HIPAA, PCI DSS, or SOC 2 Trust Services Criteria.

**Design recommendations:**

- Identify required Azure tags and use the append policy mode to enforce usage.

- Map regulatory and compliance requirements to Azure Policy definitions and Azure role assignments.

- Establish Azure Policy definitions at the top-level root management group so that they can be assigned at inherited scopes.

- Manage policy assignments at the highest appropriate level with exclusions at bottom levels, if necessary.

- Use Azure Policy to control resource provider registrations at the subscription or management group levels.

- Use built-in policies where possible to minimize operational overhead.

- Assign the built-in Resource Policy Contributor role at a particular scope to enable application-level governance.

- Limit the number of Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.

## Define security monitoring and an audit policy

An enterprise must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework.

**Design considerations:**

- Set data retention periods for audit data. Azure AD Premium reports have a 30-day retention period.

- Set long-term archiving of logs such as Azure activity logs, VM logs, and platform as a service (PaaS) logs.

- Configure baseline security via Azure in-guest VM policy.

- Do emergency patching for critical vulnerabilities.

- Patch VMs that are offline for extended periods of time.

- Set requirements for real-time monitoring and alerting.

- Integrate security information and event management with Azure Security Center and Azure Sentinel.

- Do a vulnerability assessment of VMs.

**Design recommendations:**

- Use Azure AD reporting capabilities to generate access control audit reports.

- Export Azure activity logs to Azure Monitor Logs for long-term data retention. Export to Azure Storage for long-term storage beyond two years, if necessary.

- Enable Security Center Standard for all subscriptions, and use Azure Policy to ensure compliance.

- Monitor base operating system patching drift via Azure Monitor Logs and Azure Security Center.

- Use Azure policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration.

- Monitor VM security configuration drift via Azure Policy.

- Connect default resource configurations to a centralized Azure Monitor Log Analytics workspace.

- Use an Azure Event Grid-based solution for log-oriented, real-time alerting.

## Plan for platform security

Maintain a healthy security posture as you adopt Azure. Besides visibility, you can control the initial settings and changes as the Azure services evolve.

**Design considerations:**

- Use shared responsibility.

- Use high availability and disaster recovery.

- Use consistent security across Azure services for data management and analytics, and control plane operations.

- Use multitenancy for key platform components. This multitenancy includes Hyper-V, the HSMs underpinning Azure Key Vault, and database engines.

**Design recommendations:**

- In the context of your underlying requirements, conduct a joint examination of each required service.

- If you want to bring your own keys, consider the possibility that your keys might not be supported across all considered services.

- Implement relevant mitigation so that inconsistencies don't cause unwanted outcomes.

- Choose appropriate region pairs and disaster recovery regions that minimize latency.

- Develop a security allowlist plan to assess services security configuration, monitoring, alerts, and how to integrate them with existing systems.

- Determine the incident response plan for Azure services before allowing it into production.

- Use Azure AD reporting capabilities to generate access control audit reports.

- Align your security requirements with Azure platform roadmaps to stay current with newly released security controls.

- Implement a zero-trust approach for access to the Azure platform, where appropriate.

<!-- docutune:ignore "and conditional access" "patch and update management" -->

## Azure Security Benchmark

The Azure Security Benchmark includes a collection of high-impact security recommendations to help you secure most of the services you use in Azure. You can think of these recommendations as either *general* or *organizational* as they are applicable to most Azure services. The Azure Security Benchmark recommendations are then customized for each Azure service. This customized guidance is contained in service recommendations articles.

The Azure Security Benchmark documentation specifies security controls and service recommendations:

- [Security controls](/security/benchmark/azure/overview)

  The Azure Security Benchmark recommendations are categorized by security controls. Security controls represent high-level vendor-agnostic security requirements, such as network security and data protection. Each security control has a set of security recommendations and instructions that help you implement those recommendations.

- [Service recommendations](/security/benchmark/azure/security-baselines-overview)

  When available, benchmark recommendations for Azure services include Azure Security Benchmark recommendations that are tailored specifically for that service.

## Service enablement framework

As business units request to deploy workloads to Azure, you need visibility into each workload to determine how to achieve appropriate levels of governance, security, and compliance. When a new service is required, you need to allow it.

The following tables provide a framework to assess enterprise security readiness of Azure services for each assessment:

### Security

| Category | Criteria |
|--|--|
| Network endpoint | Does the service have a public endpoint that's accessible outside of a virtual network? |
|  | Does it support virtual network service endpoints? |
|  | Can Azure services interact directly with the service endpoint? |
|  | Does it support Azure Private Link endpoints? |
|  | Can it be deployed within a virtual network? |
| Data exfiltration prevention | Does the PaaS service have a separate Border Gateway Protocol (BGP) community in Azure ExpressRoute Microsoft peering? Does ExpressRoute expose a route filter for the service? |
|  | Does the service support Private Link endpoints? |
| Enforce network traffic flow for management and data plane operations | Is it possible to inspect traffic entering/exiting the service? Can traffic be force-tunnelled with user-defined routing? |
|  | Do management operations use Azure shared public IP ranges? |
|  | Is management traffic directed via a link-local endpoint exposed on the host? |
| Data encryption at-rest | Is encryption applied by default? |
|  | Can encryption be disabled? |
|  | Is encryption done with Microsoft-managed keys or customer-managed keys? |
| Data encryption in-transit | Is traffic to the service encrypted at a protocol level (SSL/TLS)? |
|  | Are there any HTTP endpoints, and can they be disabled? |
|  | Is the underlying service communication encrypted? |
|  | Is encryption done with Microsoft-managed keys or customer-managed keys? Is bringing your own encryption supported? |
| Software deployment | Can application software or third-party products be deployed to the service? |
|  | How is software deployment done and managed? |
|  | Can policies be enforced to control source or code integrity? |
|  | If software is deployable, can antimalware capability, vulnerability management, and security monitoring tools be used? |
|  | Does the service provide such capabilities natively, such as with Azure Kubernetes Service? |

### Identity and access management

| Category | Criteria |
|--|--|
| Authentication and access control | Are all control plane operations governed by Azure AD? Is there a nested control plane, such as with Azure Kubernetes Service? |
|  | What methods exist to provide access to the data plane? |
|  | Does the data plane integrate with Azure AD? |
|  | Does authentication between Azure services use managed identities or service principals? |
|  | Is Azure-to-IaaS (service-to-virtual-network) authentication via Azure AD? |
|  | How are any applicable keys or shared access signatures managed? |
|  | How can access be revoked? |
| Segregation of duties | Does the service separate control plane and data plane operations within Azure AD? |
| Multifactor authentication and conditional access | Is multifactor authentication enforced for user to service interactions? |

### Governance

| Category | Criteria |
|--|--|
| Data export and import | Does service allow you to import and export data securely and encrypted? |
| Data privacy and usage | Can Microsoft engineers access the data? |
|  | Is any Microsoft Support interaction with the service audited? |
| Data residency | Is data contained to the service deployment region? |

### Operations

| Category | Criteria |
|--|--|
| Monitoring | Does the service integrate with Azure Monitor? |
| Backup management | Which workload data need to be backed up? |
|  | How are backups captured? |
|  | How frequently can backups be taken? |
|  | How long can backups be kept for? |
|  | Are backups encrypted? |
|  | Is backup encryption performed with Microsoft-managed keys or customer-managed keys? |
| Disaster recovery | How can the service be used in a regional redundant fashion? |
|  | What is the attainable recovery time objective and recovery point objective? |
| SKU | What SKUs are available? How do they differ? |
|  | Are there any features related to security for Premium SKU? |
| Capacity management | How is capacity monitored? |
|  | What is the unit of horizontal scale? |
| Patch and update management | Does the service require active updating or do updates happen automatically? |
|  | How frequently are updates applied? Can they be automated? |
| Audit | Are nested control plane operations captured? For example, Azure Kubernetes Service or Azure Databricks. |
|  | Are key data plane activities recorded? |
| Configuration management | Does it support tags and provide a `put` schema for all resources? |

### Azure service compliance

| Category | Criteria |
|--|--|
| Service attestation, certification, and external audits | Is the service PCI/ISO/SOC compliant? |
| Service availability | Is the service generally available? |
|  | In what regions is the service available? |
|  | What is the deployment scope of the service? Is it a regional or global service? |
| Service-level agreements (SLAs) | What is the SLA for service availability? |
|  | If applicable, what is the SLA for performance? |
