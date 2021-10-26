---
title: Enterprise-Scale support for hybrid and multicloud
description: Learn how enterprise-scale can accelerate adoption of hybrid or multi-cloud architectures.
author: JefferyMitchell
ms.author: doalle
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid
---

# Introduction to Enterprise-scale Landing Zone for hybrid and multicloud

Enterprises are currently building and running applications across a variety of ecosystems that can be on-premises, in multiple public clouds and on the edge. On these distributed environments it is critical to ensure compliance and find an effective way to manage servers, applications and data at scale while maintaining agility.

Enterprise-scale landing zones provide a specific architectural approach, reference architecture, and reference implementations to prepare your landing zones for mission-critical technology platforms and any supported workloads.

[PLACEHOLDER DIAGRAM ESLZ]

Enterprise-scale was built with hybrid and multicloud in mind. Supporting hybrid and multicloud requires two simple additions to the reference architecture:

* Hybrid and multicloud connectivity: understand key network design considerations and recommendations when working with Azure Arc.
* Unified operations: include Azure Arc enabled resources to extend governance and operations support with consistent tooling.

## Why hybrid?

As organizations look to adopt modern cloud services and the benefits they bring, there will be an inevitable period of parallel-running alongside the legacy on-premises infrastructure.

Furthermore, as cloud services are evaluated, or as business requirements dictate, organizations may choose to run services in more than one public cloud service.

A distributed heterogeneous estate requires simplified consolidated management and governance in order to reduce the operational impact.

Landing Zone concepts introduced as part of the Cloud Adoption Framework guidance can be used to establish patterns for building out hybrid architectures and introducing standards for connectivity, governance, and monitoring.

This is helpful if the strategic intent is to simplify and consolidate the infrastructure and services following migration projects as setting standards for management processes and tools means workloads will not have to be retrofitted after moving into Azure.

## Prerequisite

This article assumes that you are familiar with enterprise-scale landing zone. For more information on this prerequisite, review the enterprise-scale [overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md).

## Azure Arc

As described in this article, Azure provides organizations with various management tools that enable infrastructure and applications to be monitored and governed at scale. When implementing a hybrid Landing Zone, these Azure tools should be extended to control infrastructure and applications running outside of Azure.

This provides a single management plane and a single view on the entire hybrid estate in order to make monitoring and management at scale as straightforward as possible.

![A diagram depicting the Enterprise-scale Unified Operations on Azure conceptual reference architecture.](./media/arc-enabled-servers-security-compliance-governance.png)

[Azure Arc](/azure/azure-arc/) simplifies governance and management by delivering a consistent multi-cloud and on-premises management platform. Azure Arc enables you to manage your entire environment, with a single pane of glass, by projecting your existing resources into [Azure Resource Manager](/azure/azure-resource-manager/management/overview).

You can now manage virtual machines, Kubernetes clusters, and databases as if they are running in Azure. Regardless of where they live, you can use familiar Azure services and management capabilities. Azure Arc enables you to continue using traditional ITOps, while introducing DevOps practices to support new cloud native patterns in your environment.

## Design guidelines

Guide to the critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone in a hybrid a multicloud environment. There are six critical design areas that need to be considered as part of your enterprise-scale landing zone implementation when working with Azure Arc:

* [Network topology and connectivity](PLACEHOLDER)
* [Identity and access management](PLACEHOLDER)
* [Security, governance and compliance](PLACEHOLDER)
* [Management and monitoring](PLACEHOLDER)
* [Platform automation](PLACEHOLDER)
* [Cost Management](PLACEHOLDER)

## Implementation additions

To extend enterprise-scale to address hybrid and multicloud needs, consider the following as part of your implementation:

## Landing Zone

Landing zones are a set of reference architectures that help organizations quickly build out cloud environments and accelerate their adoption of cloud technologies.

The Enterprise Scale Landing Zone includes Azure Arc to extend governance and operations as part of an unified operations strategy. The Cloud Adoption Framework also provides specific guidance for developing architectures in Azure for connecting to external environments that can be on-premises, multicloud and on the edge. Patterns such as Hub and Spoke can be used to create landing zones for ingress from and egress to external locations. For more information, see [Implement enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md).

For example, [Guidance can be found here](../../ready/azure-best-practices/connectivity-to-other-providers.md) to help building out Landing Zone architectures specifically for connectivity to other cloud environments.

## Network Connectivity

Networking topology and security is a key consideration when integrating between Azure and external environments and should be factored into any planning exercises and design work in order to ensure a smooth implementation. The following links provide specific and actionable guidance on specific topics:

* [Connectivity to Azure](../../ready/azure-best-practices/connectivity-to-azure.md)
* [IP Addressing](../../ready/azure-best-practices/plan-for-ip-addressing.md)
* [Hub and Spoke network topologies](../../ready/azure-best-practices/hub-spoke-network-topology.md)
* [PrivateLink and DNS integration](../../ready/azure-best-practices/private-link-and-dns-integration-at-scale.md)
* [Landing Zone network segmentation](../../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md)

Within Enterprise Scale especific guidance is provided to help you understand key network design considerations when working with Azure Arc-enabled servers and how to [securely connect them to your Enterprise Scale Landing Zone](PLACEHOLDER).

## Identity and Access Management

As organizations build out cloud environments alongside existing on-premises datacenters, identity becomes an area for consideration to ensure issues are not introduced. With applications spread between on-premises and the cloud, management of access for users can become a challenge. Azure has technologies that help organizations manage identities across on-premises and cloud environments in order to simplify the experience for users.

To achieve hybrid identity, organizations should consider the following three Azure Active Directory approaches:

* [Password hash synchronization (PHS)](/azure/active-directory/hybrid/whatis-phs)
* [Pass-through authentication (PTA)](/azure/active-directory/hybrid/how-to-connect-pta)
* [Federation (AD FS)](/azure/active-directory/hybrid/whatis-fed)

[Further information can be found here](/azure/active-directory/hybrid/whatis-hybrid-identity) for planning identity models in a hybrid environment.

Moreover as an organization you need to design right access controls to secure hybrid resources as they are centrally managed from Azure using Azure Arc. On-premises and cloud identity management systems should be considered when [implementing right access management controls in securing Azure Arc-enabled server infrastructure](PLACEHOLDER).

## Security, governance and compliance

Expanding infrastructure and applications across multiple locations potentially introduces additional complexity to maintaining governance standards. As part of the planning for hybrid, centralized governance tools and processes should be implemented in order to establish good patterns as workloads scale out.

The [Cloud Adoption Framework's Enterprise Scale Landing Zone architecture](../../ready/enterprise-scale/architecture.md) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [Role-based Access Controls (RBAC)](../../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc, which is detailed [here](PLACEHOLDER).

## Management and Monitoring

Similar to the considerations needed for governance in a hybrid environment, managing distributed workloads at scale requires planning in order to ensure issues are not introduced as the span of deployments scales. Using technologies such as [Log Analytics](/azure/azure-monitor/logs/log-analytics-overview), [Application Insights](/azure/azure-monitor/app/app-insights-overview), [Azure Monitor](https://azure.microsoft.com/services/monitor/#features), and [Azure Security Center](/azure/security-center/) to [aggregate telemetry and work from a single pane of glass](../../manage/azure-management-guide/inventory.md?tabs=AzureServiceHealth%2CLog-Analytics%2CAzure-Monitor%2CConfigure-solutions) enables infrastructure and application teams to manage by exception and focus on fixing identified issues from a consolidated view.

Also similar to governance techniques, the management technologies described above can also be extended out to other environments, such as on-premises and other cloud platforms through Azure Arc. Enterprise Scale provides guidance on how operationally maintain Azure Arc-enabled servers on Azure enterprise estate, [with centralized management and monitoring at the platform level]((PLACEHOLDER)).

## Platform Automation

Automation is critical desing area of Enterprise Scale, it is critical to ensure a safe, repeatable, and consistent delivery of your operations. This becomes even more significant when working in highly distributed environments such as hybrid and multicloud.

Azure Arc enables organizations to manage their digital state hosted outside of Azure with the same level of experience and automation as a native Azure resource. As part of your Enterprise Scale Landing Zone implementation you should plan for agent onboarding, lifecycle management, and expansion of the Azure control plane capabilities via [Azure Arc with as much automation as posible](PLACEHOLDER).

## Cost Management

Cost Management is one of the disciplines of Cloud Governance within the Cloud Adoption Framework and is especially relevant when working on distributed environments as you need to track different several growing platforms and their cloud spend. Ungoverned and unmonitored resources can prevent organizations to increase accountability with budgets, cost allocation, and chargebacks.

Learn more about the [how to use Azure Arc in cost management](PLACEHOLDER)