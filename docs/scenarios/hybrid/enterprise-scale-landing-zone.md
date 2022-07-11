---
title: Introduction to Azure Arc landing zone accelerator for hybrid and multicloud
description: Learn how Azure Arc can accelerate your adoption of a hybrid or multicloud architecture.
author: likamrat
ms.author: doalle
ms.date: 5/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid, event-tier1-build-2022
---

# Azure Arc landing zone accelerator for hybrid and multicloud

Enterprises are currently building and running applications across various ecosystems on-premises, in multiple public clouds, and on the edge. When you're working in these distributed environments, it's critical that you find a way to ensure compliance and manage servers, applications, and data at scale while you still maintain agility.

[Enterprise-scale landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) provides a specific architectural approach, reference architecture, and set of reference implementations that help you prepare your landing zones for mission-critical technology platforms and supported workloads.

[![Diagram that shows a landing zone design.](./media/landing-zone-design-revised.png)](./media/landing-zone-design-revised.png#lightbox)

Enterprise-scale was designed with hybrid and multicloud in mind. To support hybrid and multicloud, the reference architecture requires two simple additions:

- **Hybrid and multicloud connectivity:** Understand key network design considerations and recommendations for working with Azure Arc.
- **Unified operations:** Include Azure Arc-enabled resources to extend your governance and operations support with consistent tooling.

## Why hybrid?

As organizations adopt modern cloud services and their associated benefits, periods of parallel-running alongside the legacy on-premises infrastructure are inevitable. As your organization further evaluates cloud services, or as business requirements dictate, your organization might choose to run more than one public cloud service. Operating a distributed heterogeneous estate requires simplified, consolidated management and governance in order to reduce operational impact.

You can use landing zone concepts introduced as part of the Cloud Adoption Framework guidance to establish patterns for building out hybrid architectures and introducing standards for connectivity, governance, and monitoring. This helps when your strategic intent is to simplify and combine the infrastructure and services following migration projects. Setting standards for management processes and tools removes the need to retrofit workloads after you move them into Azure.

## Prerequisites

It's beneficial to have familiarity with the enterprise-scale landing zone. For more information, see the enterprise-scale [overview](../../ready/enterprise-scale/index.md) and enterprise-scale [implementation guidance](../../ready/enterprise-scale/implementation.md).

[![Diagram that shows Azure Arc high level architecture.](./media/single-control-plane.png)](./media/single-control-plane.png#lightbox)

Azure provides various management tools to help you monitor and govern infrastructure and applications at scale. When you implement a hybrid landing zone, you should also extend these Azure tools to control infrastructure and applications running outside of Azure. This creates a single management plane and single view of your entire hybrid estate, which makes monitoring and management at scale as straightforward as possible.

## Azure Arc-enabled servers design guidelines

[Azure Arc](/azure/azure-arc/) simplifies governance and management by providing a consistent multicloud and on-premises management platform. Azure Arc lets you to manage your entire environment with a single pane of glass by projecting your existing resources into [Azure Resource Manager](/azure/azure-resource-manager/management/overview).

| CDA | Description |
|--|--|
| [Identity and access management](./arc-enabled-servers/eslz-identity-and-access-management.md) | Best practices for access control design to secure your hybrid resources as you use Azure Arc to centrally manage them. |
| [Network topology and connectivity](./arc-enabled-servers/eslz-arc-servers-connectivity.md) | Design considerations for working with Azure Arc-enabled servers, and information explaining how you can securely connect them to your enterprise-scale landing zone. |
| [Resource organization](./arc-enabled-servers/eslz-resource-organization.md) | Best practices for resource consistency and tagging strategy, including for your hybrid and multicloud resources. |
| [Governance and security disciplines](./arc-enabled-servers/eslz-security-governance-and-compliance.md) | The [Cloud Adoption Framework's enterprise-scale landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/) includes patterns for standardizing your deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access control (RBAC)](../../ready/azure-setup-guide/manage-access.md) through structured use of management groups that segment resources into logical groupings. You can extend these patterns with technologies like Azure Arc. |
| [Management disciplines](./arc-enabled-servers/eslz-management-and-monitoring-arc-server.md) |You can use Azure Arc to extend Azure management services out to other environments like on-premises and other cloud platforms. Enterprise-scale provides guidance for operationally maintaining Azure Arc-enabled servers on Azure enterprise estate with centralized management and monitoring at the platform level. |
| [Automation disciplines](./arc-enabled-servers/eslz-automation-arc-server.md) | Azure Arc helps you manage your digital state hosted outside of Azure using the same level of experience and automation you'd have for a native Azure resource.  Plan for using automation as much as possible for agent onboarding, lifecycle management, and expansion of your Azure control plane capabilities through Azure Arc. |
| [Cost governance](./arc-enabled-servers/eslz-cost-governance.md) | You can use budgets, cost allocation, and chargebacks to keep track of ungoverned and unmonitored resources preventing you from increasing financial accountability. |

## Azure Arc-enabled Kubernetes design guidelines

The design guidelines provide recommendations to the critical decisions that drive the design of the Cloud Adoption Framework for Azure landing zone, in a hybrid multicloud environment. There are seven critical design areas that need to be considered, as part of your Azure landing zone implementation, when working with Azure Arc-enabled Kubernetes:

| CDA | Description |
|--|--|
| [Identity and access management](./arc-enabled-kubernetes/eslz-arc-kubernetes-identity-access-management.md) | Best practices for right access controls design to secure hybrid Kubernetes cluster resources as they are centrally managed from Azure using Azure Arc-enabled Kubernetes. |
| [Network topology and connectivity](./arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity.md) | Design considerations when working with Azure Arc-enabled Kubernetes and how to securely connect them to your Azure landing zone. |
| [Resource organization](./arc-enabled-kubernetes/eslz-arc-kubernetes-resource-organization.md) | Best practices for resource consistency and tagging strategy, that includes your hybrid and multicloud Azure Arc-enabled Kubernetes cluster resources. |
| [Governance and security disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-governance-disciplines.md) | The [Cloud Adoption Framework's Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access control (RBAC)](../../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc-enabled Kubernetes. |
| [Management disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-management-disciplines.md) | Similar to governance techniques, Azure management services can also be extended out to other environments, such as on-premises and other cloud platforms through Azure Arc. Azure landing zone provides guidance on how operationally maintain and operate Azure Arc-enabled Kubernetes cluster resources on Azure enterprise estate, with centralized management and monitoring at the platform level. |
| [Automation disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-automation-disciplines.md) | Azure Arc enables organizations to manage their digital state hosted outside of Azure with the same level of experience and automation as a native Azure resource. As part of your Azure landing zone implementation you should plan cluster onboarding, agent and extensions lifecycle automation, and expansion of the Azure control plane capabilities for Azure Arc-enabled Kubernetes cluster resources with as much automation as possible. |
| [Extensions management](./arc-enabled-kubernetes/eslz-arc-kubernetes-extensions-management.md) | Best practices for managing Azure Arc-enabled Kubernetes cluster extensions, which enables the expansion of the Azure control plane capabilities for Azure Arc-enabled Kubernetes resources. |
| [CI/CD and GitOps disciplines disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-cicd-gitops-disciplines.md) | As a cloud-native construct, Kubernetes requires a cloud-native approach to deployment and operations. Learn key CI/CD and GitOps disciplines in your hybrid and multicloud environment by using it with Azure Arc-enabled Kubernetes cluster resources. |
| [Services observability](./arc-enabled-kubernetes/eslz-arc-kubernetes-services-observability.md) | Service observability is important as it allows you to understand performance and issues that are occurring with distributed and cloud systems that are based on dynamic architectures. Learn how design services observability patterns in an hybrid and multicloud environment with conjunction to Azure Arc-enabled Kubernetes cluster resources. |
| [Cost governance](./arc-enabled-kubernetes/eslz-arc-kubernetes-cost-governance.md) | Keep track of ungoverned and unmonitored resources that prevent you from to increase accountability with budgets, cost allocation, and chargebacks for Azure Arc-enabled Kubernetes cluster resources. |
