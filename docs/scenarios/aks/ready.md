---
title: Azure landing zones for modern app platforms
description: Describe the scenario's impact on Azure landing zone design
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-aks
---

# Azure landing zones for modern app platforms

The [Ready methodology in the Cloud Adoption Framework](../../ready/index.md) guides the creation of all Azure environments using [Azure landing zones](../../ready/landing-zone/index.md). Azure landing zones provide many [implementation options](../../ready/landing-zone/implementation-options.md) built around a set of [common design areas](../../ready/landing-zone/design-areas.md).

With Azure landing zones, you can start with a small implementation and expand over time. For more sophisticated environments, you can start with enterprise-scale implementation options. You'll need to evaluate any landing zone that is to be used for modern app platform solutions no matter what implementation option you choose.

## Azure Landing Zone conceptual architecture

When preparing any environment for sustained cloud adoption, we use the [Azure Landing Zones](../../ready/landing-zone/index.md) conceptual architecture to represent what a target end state should look like in Azure, as pictured below.

[![Diagram that shows a conceptual architecture of an Azure Landing Zone](../../_images/ready/alz-arch-cust-inline.png)](../../_images/ready/alz-arch-cust-expanded.png#lightbox)

When developing a long-term vision for landing zones, consider the design above. Working within this scenario, we focus on the most appropriate starting point to meet your strategic and planning requirements related to modern application platforms. This article is about the starting point, not necessarily all of the details required to reach the longer term target.

## Strategic & planning considerations for app platforms landing zones

Prioritization decisions made during [strategy](./strategy.md) and [plan](./plan.md) conversations will have a direct impact on the most appropriate landing zone configuration to support your modern app platforms plan. The following are the most important considerations from those phases:

- Will Central IT, CCoE, or other forms of centralize operations be responsible for operating the container hosts?
- Does your strategy and plan require shared containers supporting multiple workloads per cluster?
- Will the centralized teams also support segmented container solutions for hostile workloads?

The questions will influence landing zone design, since each suggests a need for a centralized operations team to manage containers. When operational responsibilities are shared across centralized teams and development teams, more considerations need to go into the design of the environment to allow for shared services & separation of duty, suggesting an enterprise-grade landing zone.

## Demonstrating actionable scope

To maximize output during initial implementations, the remainder of this guidance focuses on implementing Azure Kubernetes Services (AKS) with the ability to add an overlay for Azure Application Services on Kubernetes with Arc (AKA Project Lima). This approach narrows the scope of options by providing a reference architecture and implementation.

To establish a foundation for other [Azure products](./azure-products.md) for modern app platforms, see the [Container Architectures](/azure/architecture/guide/technology-choices/compute-decision-tree?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) tab in the left navigation for rich architecture and implementation references for each tool.

## Implementation option considerations

Selecting the best Azure Landing Zone implementation option will have a direct impact on how well the landing zone(s) can support the implementation options above. For more information on Azure Landing Zone implementation options, review the [Azure landing zones](../../ready/landing-zone/index.md) article series. Which of the Azure Landing Zone implementation options best addresses the strategy & planning considerations governing your modern app platforms scenario?

- **Existing Azure Landing Zone strategy:** If your organization has already implemented an Azure Landing Zone strategy, it is likely that your modern app platforms scenario will likely need to adhere to the existing strategy. Otherwise, please choose one of the following as your first step towards repeatable landing zone environments.
- **Start-small and expand with the AKS baseline:** The [baseline architecture for an Azure Kubernetes Service (AKS) cluster](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) provides a proven approach to deploying your first AKS environment.
    - This option is most commonly used when developer or DevOps teams are directly responsible for operations of the cluster(s), cloud environment, and the application(s).
    - Processes and best practices in the Ready, Govern, and Operate methodologies of the cloud adoption framework could be added later to prepare this deployment for central operations and shared hosts.
- **Enterprise-scale landing zones:** [Enterprise-scale for AKS](./enterprise-scale-landing-zone.md) includes a reference implementation to deploy an enterprise-scale landing zone to support your AKS platform. The enterprise-scale landing zone deploys the same AKS baseline, but within the specific environmental configuration required by the broader enterprise-scale landing zone solutions.
    - This is the most common option when compliance, governance, or security requirements must be applied centrally to any container environment.
    - It is also the most common option for centralized teams who deliver container hosting operations, allowing developers to focus more on the application & less on developing for Kubernetes.

The primary difference between the two options above resides in how separation of duties is expressed and implemented in terms of Azure resources, subscription topology, and usage of Azure Policy for governance. Understand your organization's plan around centralized versus decentralized operations and which work best for your organization's workloads. Both models can be flexed to provide the exact experience your organization and workloads require, but you'll want to start with the one most closely aligned with your defined strategy. Ensure all workload teams understand the operating model and duties required of all IT groups and members.

## Application platform overlay(s)

Once the core AKS landing zone is deployed and ready for further application deployment, any additional application platform configuration could be applied to the container hosts. In the case of Azure Application Services for Kubernetes with Arc, this would include installation of a specific application platform on top of each of your clusters.

Depending on your deployment pipeline and container registry, you have two options for adding the application platform overlays:

- The overlay installation could be included in the container images in your container registry standardizing the application platform deployment with the container deployment.
- Alternatively, the overlay could be deployed during your devops pipeline adding the runtime to an existing instance of your container hosts.

The choice of these two options depends on host operations practices and the degree a variability in application runtimes across your portfolio of workloads.

## Azure Landing Zone design areas

All Azure Landing Zones are designed around a set of common design areas listed below. The articles below each include a set of AKS specific considerations and recommendations that can help the modern app platforms team prepare a landing zone for AKS containers:

- [Enterprise enrollment](eslz-enterprise-enrollment.md)
- [Identity and access management](eslz-identity-and-access-management.md)
- [Network topology and connectivity](eslz-network-topology-and-connectivity.md)
- [Resource Organization](eslz-resource-organization.md)
- [Governance disciplines](eslz-security-governance-and-compliance.md)
- [Operations baseline](eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](eslz-business-continuity-and-disaster-recovery.md)
- [Deployment options](eslz-platform-automation-and-devops.md)

## Next step: Migrate workload to modern app platforms

The following list of articles will take you to guidance found at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Migrate workloads to modern app platforms](./migrate.md)
- [Innovate using modern app platform solutions](/azure/architecture/reference-architectures/containers/aks-start-here?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
- [Govern modern app platform solutions](./govern.md)
- [Manage modern app platform solutions](./manage.md)
