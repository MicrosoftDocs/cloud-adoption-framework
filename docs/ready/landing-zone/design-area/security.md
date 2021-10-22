---
title: Security
description: Design area guidance for security in Azure
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Security

This critical design area establishes a foundation for security across your Azure, hybrid, &/or multicloud environments. This foundation can later be enhanced with additional security guidance outlined in the [Cloud Adoption Framework's Secure methodology](../../../secure/index.md).

## Design Area review

**Involved roles or functions:** This design area is led by [Cloud Security](../../../organize/cloud-security.md), specifically the [security architects within that team](../../../organize/cloud-security-architecture.md). The [Cloud Platform](../../../organize/cloud-platform.md) and [Cloud Center of Excellence](../../../organize/cloud-center-of-excellence.md) will be required to review networking and identity decisions. The collective roles will likely be required to define and implement the technical requirements coming from this exercise. More advanced security guardrails may also require support from [Cloud Governance](../../../organize/cloud-governance.md)

**Scope:** The objective of this exercise is to understand security requirements and implement those requirements consistently across all workloads in your cloud platform. The primary scope of this exercise focus on security operations tooling and access control (including zero trust and advanced network security).

**Out of scope:** This exercise focuses on the foundation for a modern security operations center in the cloud. To streamline the conversation, this exercise does not address some of the disciplines in the [CAF Secure methodology](../../../secure/index.md). Specifically, security operations, asset protection, and innovation security will build on your Azure Landing Zone deployment, but are out of scope for this design area discussion.

## Design Area overview

Security is a core consideration for all customers, in every environment.
When designing and implementing an Azure landing zone, security should be a consideration throughout the process.

The security design area focusses on the considerations and recommendations for design decisions as part of the landing zone. In addition to this, the [Secure methodology](/secure/index.md) in the Cloud Adoption Framework provides further in-depth guidance for holistic security processes and tools. 

### Azure Security Benchmark

The Azure Security Benchmark includes a collection of high-impact security recommendations to help you secure most of the services you use in Azure. You can think of these recommendations as "general" or "organizational" as they are applicable to most Azure services. The Azure Security Benchmark recommendations are then customized for each Azure service, and this customized guidance is contained in service recommendations articles.

The Azure Security Benchmark documentation specifies security controls and service recommendations.

- [Security controls](/azure/security/benchmarks/overview): The Azure Security Benchmark recommendations are categorized by security controls. Security controls represent high-level vendor-agnostic security requirements, such as network security and data protection. Each security control has a set of security recommendations and instructions that help you implement those recommendations.
- [Service recommendations](/azure/security/benchmarks/security-baselines-overview): When available, benchmark recommendations for Azure services will include Azure Security Benchmark recommendations that are tailored specifically for that service.

## Security design considerations

An organization must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework.

### Security operations design considerations

|Scope|Context|
|-|-|
| Security alerting| - Which teams require notifications for security alerts? <br> - are there groups of services that alerts require routing to different teams? <br> - business requirements for real-time monitoring and alerting. <br> - Security information and event management integration with Azure Security Center and Azure Sentinel.|
| Security logging|- Data retention periods for audit data. Azure AD Premium reports have a 30-day retention period. <br> - Long-term archiving of logs such as Azure activity logs, VM logs, and platform as a service (PaaS) logs.|
| Security controls| - Baseline security configuration via Azure in-guest VM policy. <br> - consider how your security controls will align with governance guardrails|
| Vulnerability management|- Emergency patching for critical vulnerabilities. <br>- Patching for VMs that are offline for extended periods of time. <br> - Vulnerability assessment of VMs.
|Shared responsibility| - Where are the hand-offs between team responsibilities that need to be considered when monitoring or responding to security events? <br> Consider the guidance in the Secure methodology for [security operations](/azure/cloud-adoption-framework/secure/security-operations) |
| Encryption and keys | - who requires access to keys in the environment? <br> - who will be responsible for managing the keys? <br> - Explore [encryption and keys further](./encryption-and-keys.md)

## Security operations design recommendations

- Use [Azure AD reporting capabilities](/azure/active-directory/reports-monitoring/concept-audit-logs) to generate access control audit reports.

- Export Azure activity logs to Azure Monitor Logs for long-term data retention. Export to Azure Storage for long-term storage beyond two years, if necessary.

- [Enable Security Center Standard](/azure/security-center/security-center-get-started) for all subscriptions, and use Azure Policy to ensure compliance.

- Monitor base operating system patching drift via Azure Monitor Logs and Azure Security Center.

- Use Azure policies to automatically deploy software configurations through virtual machine (VM) extensions and enforce a compliant baseline VM configuration.

- Monitor virtual machine security configuration drift via Azure Policy.

- Connect default resource configurations to a centralized Azure Monitor Log Analytics workspace.

- Use an Azure Event Grid-based solution for log-oriented, real-time alerting.

### Access Control design considerations

Modern security boundaries are slightly more complex than those in a traditional data center. The four walls of the data center no longer contain your assets. Keeping users out of the protected network is no longer sufficient to control access. In the cloud, your perimeter is no comprised of two parts: Network security controls and Zero Trust Access Controls.

#### Advanced Network Security

|Scope|Context|
|-|-|
| Plan for inbound and outbound internet connectivity | [This section describes recommended connectivity models for inbound and outbound connectivity to and from the public internet.](../../azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md)|
| Plan for landing zone network segmentation | [This section explores key recommendations to deliver highly secure internal network segmentation within a landing zone to drive a network zero-trust implementation.](../../azure-best-practices/plan-for-landing-zone-network-segmentation.md)|
| Define network encryption requirements | [This section explores key recommendations to achieve network encryption between on-premises and Azure as well as across Azure regions.](../../azure-best-practices/define-network-encryption-requirements.md)|
|Plan for traffic inspection |In many industries, organizations require that traffic in Azure is mirrored to a network packet collector for deep inspection and analysis. This requirement typically focuses on inbound and outbound internet traffic. [This section explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network](../../azure-best-practices/plan-for-traffic-inspection.md).|

#### Zero Trust

- Which teams or individuals require access to services within the landing zone? What roles are they performing?
- Who should authorize the access requests?
- Who should receive the notifications when privileged roles are activated?
- Who should have access to the audit history?
- Explore the capabilities further [here](/azure/active-directory/privileged-identity-management/pim-configure)

### Access Control design recommendations

- In the context of your underlying requirements, conduct a joint examination of each required service. If you want to bring your own keys, it might not be supported across all considered services. Implement relevant mitigation so that inconsistencies don't hinder desired outcomes. Choose appropriate region pairs and disaster recovery regions that minimize latency.

- Develop a security allowlist plan to assess services security configuration, monitoring, alerts, and how to integrate them with existing systems.

- Determine the incident response plan for Azure services before allowing it into production.

- Align your security requirements with Azure platform roadmaps to stay current with newly released security controls.

- Implement a [zero-trust approach for access](/azure/cloud-adoption-framework/secure/access-control) to the Azure platform, where appropriate.

## Security in the Azure landing zone accelerator

Security is at the core of the Azure landing zone accelerator. As part of the implementation a number of tools and controls are deployed to help organizations achieve a security baseline, quickly.
For example, the following are included:

Tools:

- Azure Security Center (Standard or Free tier)
- Azure Sentinel
- Azure DDoS Standard Protection plan (optional)
- Azure Firewall
- Web Application Firewall (WAF)
- Privileged identity management (PIM)

Policies for on-line and corp-connected landing zones:

- Enforce secure access (HTTPS) to storage accounts
- Enforce auditing for Azure SQL
- Enforce encryption for Azure SQL
- Prevent IP forwarding
- Prevent inbound RDP from internet
- Ensure subnets are associated with NSG
