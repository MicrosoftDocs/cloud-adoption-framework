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

## Overview

Security is a core consideration for all customers, in every environment.
When designing and implementing an Azure landing zone, security should be a consideration throughout the process.

... add more here ....

The security design area focusses on the considerations and recommendations for design decisions as part of the landing zone. In addition to this, the [Secure methodology](/secure/index.md) in the Cloud Adoption Framework provides further in-depth guidance for holistic security processes and tools. 

## Azure Security Benchmark

The Azure Security Benchmark includes a collection of high-impact security recommendations to help you secure most of the services you use in Azure. You can think of these recommendations as "general" or "organizational" as they are applicable to most Azure services. The Azure Security Benchmark recommendations are then customized for each Azure service, and this customized guidance is contained in service recommendations articles.

The Azure Security Benchmark documentation specifies security controls and service recommendations.

- [Security controls](/azure/security/benchmarks/overview): The Azure Security Benchmark recommendations are categorized by security controls. Security controls represent high-level vendor-agnostic security requirements, such as network security and data protection. Each security control has a set of security recommendations and instructions that help you implement those recommendations.
- [Service recommendations](/azure/security/benchmarks/security-baselines-overview): When available, benchmark recommendations for Azure services will include Azure Security Benchmark recommendations that are tailored specifically for that service.

## Security design considerations

An enterprise must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework.

- Data retention periods for audit data. Azure AD Premium reports have a 30-day retention period.

- Long-term archiving of logs such as Azure activity logs, VM logs, and platform as a service (PaaS) logs.

- Baseline security configuration via Azure in-guest VM policy.

- Emergency patching for critical vulnerabilities.

- Patching for VMs that are offline for extended periods of time.

- Requirements for real-time monitoring and alerting.

- Security information and event management integration with Azure Security Center and Azure Sentinel.

- Vulnerability assessment of VMs.

### Platform security design considerations

- Shared responsibility.

- High availability and disaster recovery.

- Consistent security across Azure services for data management and analytics and control plane operations.

- Multitenancy for key platform components. The multitenancy includes Hyper-V, the HSMs underpinning Key Vault, and database engines.

## Security monitoring design recommendations

- Use Azure AD reporting capabilities to generate access control audit reports.

- Export Azure activity logs to Azure Monitor Logs for long-term data retention. Export to Azure Storage for long-term storage beyond two years, if necessary.

- Enable Security Center Standard for all subscriptions, and use Azure Policy to ensure compliance.

- Monitor base operating system patching drift via Azure Monitor Logs and Azure Security Center.

- Use Azure policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration.

- Monitor VM security configuration drift via Azure Policy.

- Connect default resource configurations to a centralized Azure Monitor Log Analytics workspace.

- Use an Azure Event Grid-based solution for log-oriented, real-time alerting.

### Platform security design recommendations

- In the context of your underlying requirements, conduct a joint examination of each required service. If you want to bring your own keys, it might not be supported across all considered services. Implement relevant mitigation so that inconsistencies don't hinder desired outcomes. Choose appropriate region pairs and disaster recovery regions that minimize latency.

- Develop a security allowlist plan to assess services security configuration, monitoring, alerts, and how to integrate them with existing systems.

- Determine the incident response plan for Azure services before allowing it into production.

- Use Azure AD reporting capabilities to generate access control audit reports.

- Align your security requirements with Azure platform roadmaps to stay current with newly released security controls.

- Implement a zero-trust approach for access to the Azure platform, where appropriate.

## Security in the Azure landing zone accelerator