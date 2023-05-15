---
title: Introduction to Azure Arc landing zone accelerator for hybrid and multicloud
description: Learn how Azure Arc can accelerate your adoption of a hybrid or multicloud architecture.
author: likamrat
ms.author: martinek
ms.reviewer: tozimmergren
ms.date: 02/17/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid, event-tier1-build-2022, ignite-2022, engagement-fy23
---

# Introduction to Azure Arc landing zone accelerator for hybrid and multicloud

Enterprises are currently building and running applications across various ecosystems on-premises, in multiple public clouds, and on the edge. When you're working in these distributed environments, it's critical that you find a way to ensure compliance and manage servers, applications, and data at scale while still maintaining agility.

[Azure landing zones](../../ready/landing-zone/index.md) provides:
A specific architectural approach.
Reference architecture.
Set of reference implementations that help you prepare your landing zones for mission-critical technology platforms and supported workloads.

:::image type="content" source="../../ready/enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../../ready/enterprise-scale/media/ns-arch-cust-expanded.svg":::

_For more information on the design areas labeled A-I in the visual, see [environment design areas](../../ready/landing-zone/design-areas.md#environment-design-areas)._

Azure landing zones were designed with hybrid and multicloud in mind. To support hybrid and multicloud, the reference architecture requires two additions:

- **Hybrid and multicloud connectivity:** Understand key network design considerations and recommendations for working with Azure Arc.
- **Unified operations:** Include Azure Arc-enabled resources to extend your governance and operations support with consistent tooling.

## Why hybrid?

As organizations adopt modern cloud services and the associated benefits, periods of running services parallel alongside the legacy on-premises infrastructure are inevitable. As your organization further evaluates cloud services or as business requirements dictate, your team might choose to run more than one public cloud service. Operating a distributed heterogeneous estate requires simplified, consolidated management and governance to reduce operational impact.

Use landing zone concepts introduced as part of the Cloud Adoption Framework guidance to establish patterns for building hybrid architectures and introducing standards for connectivity, governance, and monitoring. This work helps when your strategic intent is to simplify and combine the infrastructure and services following migration projects. Setting standards for management processes and tools removes the need to retrofit workloads after you move them into Azure.

## Prerequisites

It's beneficial to have familiarity with the Azure landing zones. For more information, see the Azure landing zones [overview](../../ready/landing-zone/index.md) and Azure landing zones [implementation guidance](../../ready/landing-zone/implementation-options.md).

:::image type="content" source="./media/single-control-plane.png" alt-text="Diagram that shows Azure Arc high-level architecture." lightbox="./media/single-control-plane.png":::

Azure provides various management tools to help you monitor and govern infrastructure and applications at scale. When implementing a hybrid landing zone, be sure to extend the Azure tools to control infrastructure and applications outside of Azure. This approach creates a single management plane and a single view of your entire hybrid estate, which makes monitoring and management at scale as straightforward as possible.

## Azure Arc-enabled servers design guidelines

[Azure Arc](/azure/azure-arc/) simplifies governance and management by providing a consistent multicloud and on-premises management platform. Azure Arc lets you manage your entire environment with a single pane of glass by projecting your existing resources into [Azure Resource Manager](/azure/azure-resource-manager/management/overview).

| CDA | Description |
|--|--|
| [Identity and access management](./arc-enabled-servers/eslz-identity-and-access-management.md) | Best practices for access control design to secure your hybrid resources as you use Azure Arc to centrally manage them. |
| [Network topology and connectivity](./arc-enabled-servers/eslz-arc-servers-connectivity.md) | Design considerations for working with Azure Arc-enabled servers and information explaining how you can securely connect them to your enterprise-scale landing zone. |
| [Resource organization](./arc-enabled-servers/eslz-resource-organization.md) | Best practices for resource consistency and tagging strategy, including for your hybrid and multicloud resources. |
| [Governance and security disciplines](./arc-enabled-servers/eslz-security-governance-and-compliance.md) | The [Cloud Adoption Framework's enterprise-scale landing zone architecture](../../ready/landing-zone/index.md) includes patterns for standardizing your deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access control (RBAC)](../../ready/azure-setup-guide/manage-access.md) through the structured use of management groups that segment resources into logical groupings. You can extend these patterns with technologies like Azure Arc. |
| [Management disciplines](./arc-enabled-servers/eslz-management-and-monitoring-arc-server.md) | Use Azure Arc to extend Azure management services to other environments like on-premises and other cloud platforms. Enterprise-scale provides guidance for operationally maintaining Azure Arc-enabled servers on Azure enterprise estate with centralized management and monitoring at the platform level. |
| [Automation disciplines](./arc-enabled-servers/eslz-automation-arc-server.md) | Azure Arc helps you manage your digital state hosted outside of Azure using the same level of experience and automation you'd have for a native Azure resource. Plan to use automation as much as possible for agent onboarding, lifecycle management, and expanding your Azure control plane capabilities through Azure Arc. |
| [Cost governance](./arc-enabled-servers/eslz-cost-governance.md) | Use budgets, cost allocation, and chargebacks to keep track of ungoverned and unmonitored resources preventing you from increasing financial accountability. |

## Azure Arc-enabled Kubernetes design guidelines

The design guidelines provide recommendations for the critical decisions that drive the design of the Cloud Adoption Framework for Azure landing zone in a hybrid multicloud environment. Consider the following critical design areas for your Azure landing zone implementation when working with Azure Arc-enabled Kubernetes:

| CDA | Description |
|--|--|
| [Identity and access management](./arc-enabled-kubernetes/eslz-arc-kubernetes-identity-access-management.md) | Best practices for right access controls design to secure hybrid Kubernetes cluster resources as they're centrally managed from Azure using Azure Arc-enabled Kubernetes. |
| [Network topology and connectivity](./arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity.md) | Design considerations when working with Azure Arc-enabled Kubernetes and how to securely connect them to your Azure landing zone. |
| [Resource organization](./arc-enabled-kubernetes/eslz-arc-kubernetes-resource-organization.md) | Best practices for resource consistency and tagging strategy that includes your hybrid and multicloud Azure Arc-enabled Kubernetes cluster resources. |
| [Governance and security disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-governance-disciplines.md) | The [Cloud Adoption Framework's Azure landing zone architecture](../../ready/landing-zone/index.md) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access control (RBAC)](../../ready/azure-setup-guide/manage-access.md). You standardize deployment through the structured use of management groups to segment resources into logical groupings. Extend these patterns by using technologies such as Azure Arc-enabled Kubernetes. |
| [Management disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-management-disciplines.md) | Similar to governance techniques, you can extend Azure management services to other environments, such as on-premises and other cloud platforms through Azure Arc. Azure landing zone provides guidance on operationally maintaining and operating Azure Arc-enabled Kubernetes cluster resources on Azure enterprise estate, with centralized management and monitoring at the platform level. |
| [Automation disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-automation-disciplines.md) | Azure Arc lets organizations manage their digital state hosted outside of Azure with the same level of experience and automation as a native Azure resource. As part of your Azure landing zone implementation, plan to use automation as much as possible. Opportunities for automation include cluster onboarding, agent and extensions lifecycle, and expanding Azure control plane capabilities for Azure Arc-enabled Kubernetes cluster resources. |
| [Extensions management](./arc-enabled-kubernetes/eslz-arc-kubernetes-extensions-management.md) | Best practices for managing Azure Arc-enabled Kubernetes cluster extensions that support expanding Azure control plane capabilities for Azure Arc-enabled Kubernetes resources. |
| [CI/CD and GitOps disciplines disciplines](./arc-enabled-kubernetes/eslz-arc-kubernetes-cicd-gitops-disciplines.md) | As a cloud-native construct, Kubernetes requires a cloud-native approach to deployment and operations. Learn key CI/CD and GitOps disciplines in your hybrid and multicloud environment using Azure Arc-enabled Kubernetes cluster resources. |
| [Services observability](./arc-enabled-kubernetes/eslz-arc-kubernetes-services-observability.md) | Service observability is important. It helps you understand performance issues that occur with distributed and cloud systems that are based on dynamic architectures. Learn about design services observability patterns in a hybrid and multicloud environment with Azure Arc-enabled Kubernetes cluster resources. |
| [Cost governance](./arc-enabled-kubernetes/eslz-arc-kubernetes-cost-governance.md) | Keep track of ungoverned and unmonitored resources that prevent you from increasing accountability with budgets, cost allocation, and chargebacks for Azure Arc-enabled Kubernetes cluster resources. |

## Azure Arc-enabled SQL Managed Instance design guidelines

The design guidelines provide recommendations for critical decisions that drive the design of the Cloud Adoption Framework for Azure landing zone in a hybrid multicloud environment. Consider the following critical design areas for your Azure landing zone implementation, when working with Azure Arc-enabled SQL Managed Instance:

| CDA | Description |
|--|--|
| [Identity and access management](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-identity-access-management.md) | Design considerations and best practices for right access controls design to secure Azure Arc-enabled SQL Managed Instance and Data Controller resources. |
| [Network topology and connectivity](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-network-connectivity.md) | Design considerations and best practices when working with Azure Arc-enabled SQL Managed Instance and how to securely connect them to your Azure landing zone. |
| [Storage disciplines](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-storage-disciplines.md) | Design considerations and best practices for choosing the right storage architecture when working with Azure Arc-enabled SQL Managed Instance. |
| [Resource organization](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-resource-organization.md) | Design considerations and best practices for resource consistency and tagging strategy that includes your hybrid and multicloud Azure Arc-enabled data services resources. |
| [Governance and security disciplines](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-governance-disciplines.md) | The [Cloud Adoption Framework's Azure landing zone architecture](../../ready/landing-zone/index.md) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access control (RBAC)](../../ready/azure-setup-guide/manage-access.md). Standardize deployment through the structured use of management groups to segment resources into logical groupings. Extend the patterns by using technologies such as Azure Arc-enabled SQL Managed Instance. |
| [Management disciplines](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-management-disciplines.md) | Similar to governance techniques, you can extend Azure management services out to other environments, such as on-premises and other cloud platforms through Azure Arc. Azure landing zone provides guidance on operationally maintaining and operating Azure Arc-enabled data services resources. Manage Azure Arc-enabled data services resources on Azure enterprise estate, with centralized management and monitoring at the platform level. |
| [Business continuity and disaster recovery](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-business-continuity-disaster-recovery.md) | Design considerations and best practices on designing a highly available, disaster recovery-ready architecture to support Azure Arc-enabled SQL Managed Instance business continuity in the enterprise. |
| [Upgradeability disciplines](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-upgradeability-disciplines.md) | Design considerations and best practices for configuring and managing the upgrade process on your Azure Arc-enabled SQL Managed Instance. |
| [Cost governance](./arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-cost-governance.md) | Keep track of ungoverned and unmonitored resources that prevent you from increasing accountability with budgets, cost allocation, and chargebacks for Azure Arc-enabled SQL Managed Instance resources. |

## Next steps

For more information about your hybrid and multicloud cloud journey, review the following resources:

- Understand how to design the [right access controls to secure hybrid environments](./arc-enabled-servers/eslz-identity-and-access-management.md).
- Review the [Network topology and connectivity for Azure Arc-enabled servers](./arc-enabled-servers/eslz-arc-servers-connectivity.md) requirements.
- Understand how to [manage hybrid and multicloud environments](./manage.md).
