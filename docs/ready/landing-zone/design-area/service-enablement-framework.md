---
title: Service enablement framework
description: Learn about adopting a service enablement framework. Achieving the right level of security and governance is an important part of your cloud adoption journey.
author: Zimmergren
ms.author: pnp
ms.reviewer: tozimmergren
ms.date: 02/27/2025
ms.topic: conceptual
ms.custom: internal, engagement-fy23, UpdateFrequency.5
---

# Service enablement framework

As business units request to deploy workloads to Azure, you need visibility into each workload to determine how to achieve the right governance, security, and compliance levels. When a new service is required, you need to allow it.

The following tables provide a framework to assess the enterprise security readiness of Azure services.

## Security

| Category | Criteria |
|--|--|
| Network endpoint | - Does the service have a public endpoint accessible outside of a virtual network? <br/> - Does it support virtual network service endpoints? <br/> - Can Azure services interact directly with the service endpoint? <br/> - Does it support Azure Private Link endpoints? <br/> - Can it be deployed within a virtual network? |
| Data exfiltration prevention | - Does the Platform-as-a-Service (PaaS) service have a separate Border Gateway Protocol (BGP) community in Azure ExpressRoute Microsoft peering? <br/> - Does ExpressRoute expose a route filter for the service? <br/> - Does the service support Private Link endpoints? |
| Enforce network traffic flow for management and data plane operations | - Is it possible to inspect traffic entering and exiting the service? <br/> - Can traffic be force-tunneled with user-defined routing? <br/> - Do management operations use Azure shared public IP ranges? <br/> - Is management traffic directed via a link-local endpoint exposed on the host? |
| Data encryption at-rest | - Is encryption applied by default? <br/> - Can encryption be disabled? <br/> - Is encryption done with Microsoft-managed keys or customer-managed keys? |
| Data encryption in-transit | - Is traffic to the service encrypted at a protocol level, like SSL/TLS? <br/> - Are there any HTTP endpoints, and can they be disabled? <br/> - Is the underlying service communication encrypted? <br/> - Is encryption done with Microsoft-managed keys or customer-managed keys? Is bringing your own encryption supported? |
| Software deployment | - Can application software or third-party products be deployed to the service? <br/> - How is software deployment done and managed? <br/> - Can policies be enforced to control source code integrity? <br/> - Can antimalware capability, vulnerability management, and security monitoring tools be used if the software is deployable? <br/> - Does the service provide such capabilities natively, such as with Azure Kubernetes Service (AKS)? |

## Identity and access management

| Category | Criteria |
|--|--|
| Authentication and access control | - Are all control plane operations governed by Microsoft Entra ID? Is there a nested control plane, such as with AKS? <br/> - What methods exist to provide access to the data plane? <br/> - Does the data plane integrate with Microsoft Entra ID? <br/> - Does authentication between Azure services use managed identities or service principals? <br/> - How are any applicable keys or shared access signatures managed? <br/> - How can access be revoked? |
| Segregation of duties | Does the service separate control plane and data plane operations within Microsoft Entra ID? |
| Multifactor authentication and Conditional Access | Is multifactor authentication enforced for user-to-service interactions? |

## Governance

| Category | Criteria |
|--|--|
| Data export and import | Can you import and export data securely and encrypted with the service? |
| Data privacy and usage | - Can Microsoft engineers access the data? <br/> - Is any Microsoft Support interaction with the service audited? |
| Data residency | Is data contained in the service deployment region? |

## Operations

| Category | Criteria |
|--|--|
| Monitoring | Does the service integrate with Azure Monitor? |
| Backup management | - Which workload data needs to be backed up? <br/> - How are backups captured? <br/> - How frequently can backups be taken? <br/> - How long can backups be kept for? <br/> - Are backups encrypted? <br/> - Is backup encryption done with Microsoft-managed keys or customer-managed keys? |
| Disaster recovery | - How can the service be used in a regionally redundant fashion? <br/> - What are the achievable recovery time and recovery point goals? |
| Business continuity management | - Which solution can be used  to manage  the business continuity operations across all subscriptions?  <br/> - Which workloads can be managed?  <br/> - How to identify protected and unprotected resources/items?  <br/> - How to configure protection for a workload and recover them?  <br/> - Can the security level be reviewed and modified for the protected items?  <br/> - How can the protection jobs, alerts, and metrics be monitored?  <br/> - Is there a way to generate summarized reports for workload protection across all subscriptions? |
| SKU | - What SKUs are available? How do they differ? <br/> - Are there any features related to security for the Premium SKU? |
| Capacity management | - How is capacity monitored? <br/> - What is the unit of horizontal scale? |
| Patch and update management | - Does the service require active updating, or do updates happen automatically? <br/> - How frequently are updates applied? Can they be automated? |
| Audit | - Are nested control plane operations captured? For example, AKS or Azure Databricks. <br/> - Are key data plane activities recorded? |
| Configuration management | Does it support tags and provide a `put` schema for all resources? |

## Azure service compliance

| Category | Criteria |
|--|--|
| Service attestation, certification, and external audits | Is the service PCI/ISO/SOC compliant? |
| Service availability | - Is the service generally available? <br/> - In what regions is the service available? <br/> - What is the deployment scope of the service? Is it a regional or global service? |
| Service-level agreements (SLAs) | - What is the SLA for service availability? <br/> - If applicable, what is the SLA for performance? |
