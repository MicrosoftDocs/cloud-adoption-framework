---
title: Security design in Azure
description: Learn about design area guidance to establish a foundation for security in Azure, hybrid, or multicloud environments.
author: DominicAllen
ms.author: doalle
ms.date: 12/7/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Security

This design area creates a base for security across your Azure, hybrid, and multicloud environments. You can enhance this foundation later with security guidance outlined in the [Cloud Adoption Framework's Secure methodology](../../../secure/index.md).

## Design area review

**Involved roles or functions:** This design area is led by [cloud security](../../../organize/cloud-security.md), specifically the [security architects within that team](../../../organize/cloud-security-architecture.md). The [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) are required to review networking and identity decisions. The collective roles might be required to define and implement the technical requirements coming from this exercise. More advanced security guardrails might also need support from [cloud governance](../../../organize/cloud-governance.md).

**Scope:** The goal of this exercise is to understand security requirements and implement them consistently across all workloads in your cloud platform. The primary scope of this exercise focuses on security operations tooling and access control. This scope includes zero trust and advanced network security.

**Out of scope:** This exercise focuses on the foundation for a modern security operations center in the cloud. To streamline the conversation, this exercise doesn't address some of the disciplines in the [CAF Secure methodology](../../../secure/index.md). Security operations, asset protection, and innovation security will build on your Azure landing zone deployment. However, they're out of scope for this design area discussion.

## Design area overview

Security is a core consideration for all customers, in every environment. When designing and implementing an Azure landing zone, security should be a consideration throughout the process.

The security design area focuses on considerations and recommendations for landing zone decisions. The [Secure methodology](/secure/index.md) in the Cloud Adoption Framework also provides further in-depth guidance for holistic security processes and tools.

### Azure Security Benchmark

The Azure Security Benchmark includes high-impact security recommendations to help you secure most of the services you use in Azure. You can think of these recommendations as *general* or *organizational*, as they're applicable to most Azure services. The Azure Security Benchmark recommendations are then customized for each Azure service. This customized guidance is contained in service recommendations articles.

The Azure Security Benchmark documentation specifies security controls and service recommendations.

- [Security controls](/azure/security/benchmarks/overview): The Azure Security Benchmark recommendations are categorized by security controls. Security controls represent high-level vendor-agnostic security requirements, like network security and data protection. Each security control has a set of security recommendations and instructions that help you implement those recommendations.
- [Service recommendations](/azure/security/benchmarks/security-baselines-overview): When available, benchmark recommendations for Azure services will include Azure Security Benchmark recommendations that are tailored specifically for that service.

## Security design considerations

An organization must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework.

### Security operations design considerations

|Scope|Context|
|-|-|
| Security alerting | - Which teams require notifications for security alerts? <br> - Are there groups of services that alerts require routing to different teams? <br> - Business requirements for real-time monitoring and alerting. <br> - Security information and event management integration with Microsoft Defender for Cloud and Microsoft Sentinel. |
| Security logging |- Data retention periods for audit data. Azure Active Directory (Azure AD) Premium reports have a 30-day retention period. <br> - Long-term archiving of logs like Azure activity logs, virtual machine (VM) logs, and platform as a service (PaaS) logs.|
| Security controls| - Baseline security configuration via Azure in-guest VM policy. <br> - Consider how your security controls will align with governance guardrails. |
| Vulnerability management | - Emergency patching for critical vulnerabilities. <br> - Patching for VMs that are offline for extended periods of time. <br> - Vulnerability assessment of VMs.
| Shared responsibility | - Where are the handoffs for team responsibilities? These responsibilities need consideration when monitoring or responding to security events. <br> -  Consider the guidance in the Secure methodology for [security operations](/azure/cloud-adoption-framework/secure/security-operations). |
| Encryption and keys | - Who requires access to keys in the environment? <br> - Who will be responsible for managing the keys? <br> - Explore [encryption and keys further](./encryption-and-keys.md). |

## Security operations design recommendations

- Use [Azure AD reporting capabilities](/azure/active-directory/reports-monitoring/concept-audit-logs) to generate access control audit reports.

- Export Azure activity logs to Azure Monitor Logs for long-term data retention. Export to Azure Storage for long-term storage beyond two years, if necessary.

- [Enable Defender for Cloud standard](/azure/security-center/security-center-get-started) for all subscriptions, and use Azure Policy to ensure compliance.

- Monitor base operating system patching drift via Azure Monitor Logs and Microsoft Defender for Cloud.

- Use Azure policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration.

- Monitor VM security configuration drift via Azure Policy.

- Connect default resource configurations to a centralized Azure Monitor Log Analytics workspace.

- Use an Azure Event Grid-based solution for log-oriented, real-time alerts.

### Access control design considerations

Modern security boundaries are more complex than boundaries in a traditional datacenter. The four walls of the datacenter no longer contain your assets. Keeping users out of the protected network is no longer sufficient to control access. In the cloud, your perimeter is composed of two parts: network security controls and zero trust access controls.

#### Advanced network security

|Scope|Context|
|-|-|
| Plan for inbound and outbound internet connectivity | [Describes recommended connectivity models for inbound and outbound connectivity to and from the public internet](../../azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md). |
| Plan for landing zone network segmentation | [Explores key recommendations to deliver highly secure internal network segmentation within a landing zone. These recommendations drive network zero-trust implementation](../../azure-best-practices/plan-for-landing-zone-network-segmentation.md). |
| Define network encryption requirements | [Explores key recommendations to achieve network encryption between on-premises and Azure and across Azure regions](../../azure-best-practices/define-network-encryption-requirements.md). |
|Plan for traffic inspection | [Explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network](../../azure-best-practices/plan-for-traffic-inspection.md). |

#### Zero trust

- Which teams or individuals require access to services within the landing zone? What roles are they doing?
- Who should authorize the access requests?
- Who should receive the notifications when privileged roles are activated?
- Who should have access to the audit history?

For more information, see [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure).

### Access control design recommendations

- In the context of your underlying requirements, conduct a joint examination of each required service. If you want to bring your own keys, it might not be supported across all considered services. Implement relevant mitigation so that inconsistencies don't hinder wanted outcomes. Choose appropriate region pairs and disaster recovery regions that minimize latency.

- Develop a security allowlist plan to assess services like security configuration, monitoring, and alerts. Then create a plan to integrate them with existing systems.

- Determine the incident response plan for Azure services before moving it into production.

- Align your security requirements with Azure platform roadmaps to stay current with newly released security controls.

- Implement a [zero-trust approach for access](/azure/cloud-adoption-framework/secure/access-control) to the Azure platform where appropriate.

## Security in the Azure landing zone accelerator

Security is at the core of the Azure landing zone accelerator. As part of the implementation, many tools and controls are deployed to help organizations quickly achieve a security baseline.

For example, the following are included:

Tools:

- Microsoft Defender for Cloud, standard or free tier
- Microsoft Sentinel
- Azure DDoS standard protection plan (optional)
- Azure Firewall
- Web Application Firewall (WAF)
- Privileged Identity Management (PIM)

Policies for online and corporate-connected landing zones:

- Enforce secure access, like HTTPS, to storage accounts
- Enforce auditing for Azure SQL Database
- Enforce encryption for Azure SQL Database
- Prevent IP forwarding
- Prevent inbound RDP from internet
- Ensure subnets are associated with NSG

## Next steps

Learn how to secure privileged access for hybrid and cloud deployments in Azure AD.

> [!div class="nextstepaction"]
> [Secure privileged access](/azure/active-directory/roles/security-planning)