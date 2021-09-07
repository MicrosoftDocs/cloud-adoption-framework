---
title: Enterprise-Scale support for hybrid and multicloud
description: Describe how enterprise-scale can accelerate adoption of hybrid or multi-cloud architectures.
author: JefferyMitchell
ms.author: doalle
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid
---

# Enterprise-scale support for hybrid and multicloud

Enterprise-scale landing zones provide a specific architectural approach, reference architecture, and reference implementations to prepare your landing zones for mission-critical technology platforms and any supported workloads.

Enterprise-scale was built with hybrid and multicloud in mind. Supporting hybrid and multicloud requires three simple additions to the reference architecture:

- **Hybrid:** Add hybrid network connectivity
- **Multicloud:** Add multicloud network connectivity
- **Unified operations:** Add Azure Arc to extend governance and operations support

## Why hybrid?

As organizations look to adopt modern cloud services and the benefits they bring, there will be an inevitable period of parallel-running alongside the legacy on-premises infrastructure.

Furthermore, as cloud services are evaluated, or as business requirements dictate, organizations may choose to run services in more than one public cloud service.

A distributed heterogeneous estate requires simplified consolidated management and governance in order to reduce the operational impact.

Landing Zone concepts introduced as part of the Cloud Adoption Framework guidance can be used to establish patterns for building out hybrid architectures and introducing standards for connectivity, governance, and monitoring.

This is helpful if the strategic intent is to simplify and consolidate the infrastructure and services following migration projects as setting standards for management processes and tools means workloads will not have to be retrofitted after moving into Azure.

## Prerequisite

This article assumes that enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review the enterprise-scale [overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md).

## Design guidelines

Guide to the critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. There are six critical design areas that can be used to review and modify your enterprise-scale landing zone or any other Azure landing zone implementation:

- [Identity and access management](../../ready/enterprise-scale/identity-and-access-management.md)
- [Network topology and connectivity](../../ready/enterprise-scale/network-topology-and-connectivity.md)
- [Management and monitoring](../../ready/enterprise-scale/management-and-monitoring.md)
- [Business continuity and disaster recovery](../../ready/enterprise-scale/business-continuity-and-disaster-recovery.md)
- [Security, governance and compliance](../../ready/enterprise-scale/security-governance-and-compliance.md)
- [Platform automation and DevOps](../../ready/enterprise-scale/platform-automation-and-devops.md)

## Implementation additions

To extend enterprise-scale to address hybrid and multicloud needs, consider the following as part of your implementation:

## Landing Zone

Landing zones are a set of reference architectures that help organizations quickly build out cloud environments and accelerate their adoption of cloud technologies.

The Cloud Adoption Framework includes specific guidance for developing architectures in Azure for connecting to external environments. [Patterns such as Hub and Spoke can be used to create landing zones for ingress from and egress to external locations.](../../ready/enterprise-scale/implementation.md)

For example, [Guidance can be found here](../../ready/azure-best-practices/connectivity-to-other-providers.md) to help building out Landing Zone architectures specifically for connectivity to other cloud environments.

## Network

Networking topology is a key consideration when integrating between Azure and external environments and should be factored into any planning exercises and design work in order to ensure a smooth implementation. The following links provide specific and actionable guidance on specific topics:

- [Connectivity to Azure](../../ready/azure-best-practices/connectivity-to-azure.md)
- [IP Addressing](../../ready/azure-best-practices/plan-for-ip-addressing.md)
- [Hub and Spoke network topologies](../../ready/azure-best-practices/hub-spoke-network-topology.md)
- [PrivateLink and DNS integration](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md)
- [Landing Zone network segmentation](../../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md)

## Identity

As organizations build out cloud environments alongside existing on-premises datacenters, identity becomes an area for consideration to ensure issues are not introduced. With applications spread between on-premises and the cloud, management of access for users can become a challenge. Azure has technologies that help organizations manage identities across on-premises and cloud environments in order to simplify the experience for users.

To achieve hybrid identity, organizations should consider the following three Azure Active Directory approaches:

- [Password hash synchronization (PHS)](/azure/active-directory/hybrid/whatis-phs)
- [Pass-through authentication (PTA)](/azure/active-directory/hybrid/how-to-connect-pta)
- [Federation (AD FS)](/azure/active-directory/hybrid/whatis-fed)

[Further information can be found here](/azure/active-directory/hybrid/whatis-hybrid-identity) for planning identity models in a hybrid environment.

## Governance

Expanding infrastructure and applications across multiple locations potentially introduces additional complexity to maintaining governance standards. As part of the planning for hybrid, centralized governance tools and processes should be implemented in order to establish good patterns as workloads scale out.

The [Cloud Adoption Framework's Enterprise Scale Landing Zone architecture](../../ready/enterprise-scale/architecture.md) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [Role-based Access Controls (RBAC)](../../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc, which is detailed further below.

## Management

Similar to the considerations needed for governance in a hybrid environment, managing distributed workloads at scale requires planning in order to ensure issues are not introduced as the span of deployments scales. Using technologies such as [Log Analytics](/azure/azure-monitor/logs/log-analytics-overview), [Application Insights](/azure/azure-monitor/app/app-insights-overview), [Azure Monitor](https://azure.microsoft.com/services/monitor/#features), and [Azure Security Center](/azure/security-center/) to [aggregate telemetry and work from a single pane of glass](../../manage/azure-management-guide/inventory.md?tabs=AzureServiceHealth%2CLog-Analytics%2CAzure-Monitor%2CConfigure-solutions) enables infrastructure and application teams to manage by exception and focus on fixing identified issues from a consolidated view.

Also similar to governance techniques, the management technologies described above can also be extended out to other environments, such as on-premises and other cloud platforms for certain use cases.

## Azure Arc

As described in this article, Azure provides organizations with various management tools that enable infrastructure and applications to be monitored and governed at scale. When implementing a hybrid Landing Zone, these Azure tools should be extended to control infrastructure and applications running outside of Azure.

This provides a single management plane and a single view on the entire hybrid estate in order to make monitoring and management at scale as straightforward as possible.

[Azure Arc](/azure/azure-arc/) simplifies governance and management by delivering a consistent multi-cloud and on-premises management platform. Azure Arc enables you to manage your entire environment, with a single pane of glass, by projecting your existing resources into [Azure Resource Manager](/azure/azure-resource-manager/management/overview).

You can now manage virtual machines, Kubernetes clusters, and databases as if they are running in Azure. Regardless of where they live, you can use familiar Azure services and management capabilities. Azure Arc enables you to continue using traditional ITOps, while introducing DevOps practices to support new cloud native patterns in your environment.
