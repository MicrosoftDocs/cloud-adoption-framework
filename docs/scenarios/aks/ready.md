---
title: Azure landing zones for modern application platforms
description: Describe the scenario's impact on Azure landing zone design
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Azure landing zones for modern application platforms

The [Ready methodology in the Cloud Adoption Framework](../../ready/index.md) guides the creation of all Azure environments using [Azure landing zones](../../ready/landing-zone/index.md). Azure landing zones provide many [implementation options](../../ready/landing-zone/implementation-options.md) built around a set of [common design areas](../../ready/landing-zone/design-areas.md).

With Azure landing zones, you can start with a small implementation and expand over time. For more sophisticated environments, you can start with enterprise-scale implementation options. You'll need to evaluate any landing zone that is to be used for modern application platform solutions no matter what implementation option you choose.

## Azure landing zone conceptual architecture

When preparing any environment for sustained cloud adoption, we use the [Azure landing zones](../../ready/landing-zone/index.md) conceptual architecture to represent what a target end state should look like in Azure, as pictured below.

[![Diagram that shows a conceptual architecture of an Azure landing zone](../../_images/ready/alz-arch-cust-inline.png)](../../_images/ready/alz-arch-cust-expanded.png#lightbox)

When developing a long-term vision for landing zones, consider the design above. Working within this scenario, we focus on the most appropriate starting point to meet your strategic and planning requirements related to modern application platforms. This article is about the starting point, not necessarily all of the details required to reach the longer term target.

## Strategic and planning considerations for application platforms landing zones

Prioritization decisions made during [strategy](./strategy.md) and [plan](./plan.md) conversations will have a direct impact on the most appropriate landing zone configuration to support your modern application platforms plan. The following are the most important considerations from those phases:

- Will central IT, CCoE, or other forms of centralized operations be responsible for operating the container hosts?
- Does your strategy and plan require shared containers supporting multiple workloads per cluster?
- Will the centralized teams also support segmented container solutions for hostile workloads?

The questions will influence landing zone design, since each suggests a need for a centralized operations team to manage containers. When operational responsibilities are shared across centralized teams and development teams, more considerations need to go into the design of the environment to allow for shared services and separation of duties, suggesting an enterprise-grade landing zone.

## Demonstrating actionable scope

To maximize output during initial implementations, the remainder of this guidance focuses on implementing Azure Kubernetes services (AKS) with the ability to add an overlay for Azure App Service on Kubernetes with Azure Arc. This approach narrows the scope of options by providing a reference architecture and implementation.

To establish a foundation for other [Azure products](./azure-products.md) for modern application platforms, see the [container architectures](/azure/architecture/guide/technology-choices/compute-decision-tree?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) tab in the left navigation for rich architecture and implementation references for each tool.

## Implementation option considerations

Selecting the best Azure landing zone implementation option will have a direct impact on how well a landing zone can support the implementation options above. For more information on Azure landing zone implementation options, review the [Azure landing zones](../../ready/landing-zone/index.md) article series. Which of the Azure landing zone implementation options best addresses the strategy and planning considerations governing your modern application platforms scenario?

- **Existing Azure landing zone strategy:** If your organization has already implemented an Azure landing zone strategy, it's likely that your modern application platforms scenario might need to adhere to the existing strategy. Otherwise, choose one of the following as your first step toward repeatable landing zone environments.
- **Start-small and expand with the AKS baseline:** The [baseline architecture for an Azure Kubernetes Service (AKS) cluster](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) provides a proven approach to deploying your first AKS environment.
  - This option is most commonly used when developer or DevOps teams are directly responsible for operations of the clusters, cloud environments, and the applications.
  - Processes and best practices in the Ready, Govern, and Manage methodologies of the Cloud Adoption Framework could be added later to prepare this deployment for central operations and shared hosts.
- **Enterprise-scale landing zones:** [Enterprise-scale for AKS](./enterprise-scale-landing-zone.md) includes a reference implementation to deploy an instance of the AKS baseline into an enterprise-scale landing zone to support your AKS platform, within the specific environmental configuration required by the broader enterprise-scale landing zone solutions.
  - This is the most common option when compliance, governance, or security requirements must be applied centrally to any container environment.
  - It's also the most common option for centralized teams who deliver container hosting operations, allowing developers to focus more on the application and less on developing for Kubernetes.

The primary difference between the two options above resides in how separation of duties is expressed and implemented in terms of Azure resources, subscription topology, and usage of Azure Policy for governance. Understand your organization's plan around centralized versus decentralized operations and which work best for your organization's workloads. Both models can be flexed to provide the exact experience your organization and workloads require, but you'll want to start with the one most closely aligned with your defined strategy. Ensure all workload teams understand the operating model and duties required of all IT groups and members.

## Application platform overlays

Once the core AKS landing zone is deployed and ready for further application deployment, more application platform configuration can be applied to the container hosts. With Azure App Service for Kubernetes with Azure Arc, this includes the installation of a specific application platform on top of each of your clusters.

Depending on your deployment pipeline and your container registry, you have two options for adding the application platform overlays:

- The overlay installation can be included in the container images in your Container Registry standardizing the application platform deployment with the container deployment.
- Alternatively, the overlay can be deployed during your DevOps pipeline adding the runtime to an existing instance of your container hosts.

The choice of these two options depends on host operations practices and the degree a variability in application runtimes across your portfolio of workloads.

## Azure landing zone design areas

All Azure landing zones are designed around a set of common design areas listed below. Each article includes a set of AKS-specific considerations and recommendations that can help the modern application platforms team prepare a landing zone for AKS containers:

- [Enterprise enrollment](eslz-enterprise-enrollment.md)
- [Identity and access management](eslz-identity-and-access-management.md)
- [Network topology and connectivity](eslz-network-topology-and-connectivity.md)
- [Resource organization](eslz-resource-organization.md)
- [Governance disciplines](eslz-security-governance-and-compliance.md)
- [Operations baseline](eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](eslz-business-continuity-and-disaster-recovery.md)
- [Deployment options](eslz-platform-automation-and-devops.md)

## Next step: Migrate workloads to modern application platforms

The following list of articles will take you to guidance found at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Migrate workloads to modern application platforms](./migrate.md)
- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
