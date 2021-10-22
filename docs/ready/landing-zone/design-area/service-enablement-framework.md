---
title: Service Enablement Framework
description: Learn about adopting a service enablement framework as part of your cloud adoption journey
author: DominicAllen
ms.author: doalle
ms.date: 10/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Service enablement framework

As business units request to deploy workloads to Azure, you need visibility into each workload to determine how to achieve appropriate levels of governance, security, and compliance. When a new service is required, you need to allow it.

The following tables provide a framework to assess enterprise security readiness of Azure services for each assessment:

## Security

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

## Identity and access management

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

## Governance

| Category | Criteria |
|--|--|
| Data export and import | Does service allow you to import and export data securely and encrypted? |
| Data privacy and usage | Can Microsoft engineers access the data? |
|  | Is any Microsoft Support interaction with the service audited? |
| Data residency | Is data contained to the service deployment region? |

## Operations

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

## Azure service compliance

| Category | Criteria |
|--|--|
| Service attestation, certification, and external audits | Is the service PCI/ISO/SOC compliant? |
| Service availability | Is the service generally available? |
|  | In what regions is the service available? |
|  | What is the deployment scope of the service? Is it a regional or global service? |
| Service-level agreements (SLAs) | What is the SLA for service availability? |
|  | If applicable, what is the SLA for performance? |
