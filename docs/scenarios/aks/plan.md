---
title: Plan for modern application platforms
description: Develop a plan for cloud adoption with a focus on modern application platform data points and activities.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Plan for modern application platforms

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams, all based on what you are trying to do in the cloud.

Application of the Plan methodology focuses on the [five Rs of rationalizing your digital estate](../../digital-estate/5-rs-of-rationalization.md). The most common path to the cloud focuses on speed, efficiency, and repeatability of the migration and modernization processes. From the five Rs, planning usually prioritizes rehost options with limited parallel support for rearchitect and rebuild options.

## Digital estate

When planning for your digital estate, you'll want to [gather inventory data](../../digital-estate/inventory.md) and [rationalization your estate](../../digital-estate/rationalize.md). In a container adoption plan, it's vital all assets, for example VMs, data, and applications, are grouped by the workload they support. Once the grouping and basic rationalization is complete, you can evaluate these workloads to determine the package and rehost or rearchitect options.

The standard [cloud adoption plan template](../../plan/template.md) accounts for the types of work required in a typical cloud adoption effort. But you will need to add tasks to your plan for packaging the workload into containers and orchestration of the container provisioning.

> [!CAUTION]
> This article assumes the reader is already following the best practices outlined in the article series on [building a cloud adoption plan in Azure DevOps](../../plan/plan-intro.md). If you are tracking your cloud adoption plan in spreadsheet or other project tracking tools, the following sections are still applicable but the actionable steps of adding data to your plan would need to be adjusted.

<!-- -->

> [!WARNING]
> Incorporating a modern application platform strategy into standard migration processes (or a migration factory) will require mature implementation of tasks associated with [architecting workloads prior to migration](../../migrate/migration-considerations/assess/architect.md). Continuing with this strategy without those tasks will delay the migration effort and could lead to poor architecture decisions for the deployed container hosts and supporting workloads.

## Identify candidate workloads

In the modern application platform scenario, longer term returns, which require a greater upfront investment, are prioritized over more efficient migration processes. The longer term investments are represented in specific parts of the plan as an increased focus on enabling innovation and streamlining operations for specific groups of workloads.

To begin aligning the strategy and plan, identify any workloads that are likely to be affected by the addition of modern application platforms in your cloud adoption strategy. Those assumptions will be validated prior to implementing any technical changes. To aid in identifying potential candidates, look for the following criteria within your portfolio of workloads:

- **Active development or DevOps investments:** A percentage of production workloads will be under active development. Some may even be managed through ongoing DevOps practices.
- **Workload portability:** Some workloads are affected by compliance, data protection, or operational constraints which may require portability across private cloud, edge, or even multiple public cloud providers.
- **Workload consolidation:** Many workloads (especially low utilization workloads) may be candidates for consolidation on container hosts resulting in few servers/VMs and reduced operating costs.
- **Legacy workloads:** Legacy workloads can block updates to operating systems and even prevent migration to the cloud. Legacy workloads which aren't compatible with the Azure features might be a candidate for migration on a container host.

## Document candidate workloads

> [!NOTE]
> The following list of considerations should only be documented for migration candidates identified by the criteria above.

When building a cloud adoption plan, each workload is documented following the guidance in [Define and prioritize workloads](../../plan/workloads.md). Any workload which are candidates for the modern application platform scenario will require additional information to guide execution of the plan. That article highlights the importance of [documenting business and technical inputs to define the workload](../../plan/workloads.md?#define-workloads). For modern application platform candidates, the following data points should be added to the definition of the workload.

### Business inputs

The following are business related data points which may influence the decision to include a workload in the modern application platform strategy.

- **Compliance drivers:** What specific compliance criteria are driving considerations to host this workload in a private cloud?
- **Data protection drivers:** What data protection measures are driving considerations to host this workload in a private cloud?
- **Operational constraints:** What operational constraints are driving considerations to host this workload in a private cloud?
- **Modern container outcomes:** Which of the following is the driver behind evaluating this workload as a container candidate? DevOps, portability, consolidation, legacy, or multiple of these drivers.
- **Operating model:** Will this workload be managed centrally (by central IT/CCoE), de-centrally (by workload team), or with enterprise operations (central support and workload specific operations)?

### Technical inputs

The following are data points from the technology teams which may influence the decision to include a workload in the modern application platform strategy.

**Location considerations:**

Considerations related to where the workload will be hosted.

- **Public cloud hosting requirement:** Is there a specific technical constraint associated with the public cloud requirement?
- **Private cloud hosting requirement:** Is there a specific technical constraint associated with the private cloud requirement?
- **Edge hosting requirement:** Is there a specific technical constraint associated with the edge requirement?
- **Portability requirement:** Is there a specific technical constraint associated with the cloud portability requirement?

**Operations considerations:**

Considerations related to the operations of the platform, hosts, and workloads.

- **Primary cloud platform:** Organizations should define a primary cloud platform to provide operations management tooling. Some organizations might have more than one primary cloud platform to manage various types of operations. What is the primary cloud platform to operate this workload?
- **Additional operations platforms:** Will this workload also be managed by any additional operations platforms?
- **Cloud hosting requirements:** Does this workload require a specific cloud hosting strategy? Public cloud, private cloud, or cloud portability
- **Standardized orchestration platform:** If the company has a standard solution for container orchestration, include the name of the standardized platform to be considered. Examples: Azure Kubernetes Service (AKS), AKS engine, or Kubernetes.
- **Custom orchestration considerations:** Is there a requirement for a non-standard container orchestration platform? If so, explain that requirement.
- **Standardized host operations:** It's assumed that workloads are non-hostile and can be hosted on shared containers supported by standardized host operations. Is this workload compatible with this approach?
- **Customized host operations considerations:** If the workload is not compatible with standardized operations, what specific requirements should be considered when establishing host operations practices for this workload?

**Application considerations:**

Considerations specific to how the application is developed and will be developed going forward.

- **Platform as a service (PaaS) runtime:** Public cloud providers produce consistent application runtimes, often referred to as platform as a service (PaaS) offerings. In Azure, the PaaS runtimes provided by Azure App Service. Could this application operate on a PaaS runtime? Which runtime is most compatible?
- **Standardized runtime:** If the application isn't compatible with a PaaS runtime, is there a standardized runtime provided by the organization? Which runtime will this workload be built on?
- **Custom runtime considerations:** What specific considerations would require a customized runtime for this workload?
- **Runtime constraints:** Are there any constraints imposed on the application by the chosen runtime?
- **Application dependencies:** Is this workload dependent on any existing systems that reside in a specific location (like public or private)? Examples would include an ERP system like SAP running in a specific solution.
- **Data gravity:** Is this workload dependent on a data source which resides in a specific location (like public or private)? Examples can include a dependency on the data in SAP or other centralized data sources.
- **Approved-list considerations:** Are the custom operations considerations approved for use within your cloud platform? Which approved services must be included in the deployment?

## Considerations for initial containers

Packaging your workloads in containers is the first body of work that needs to be scheduled and worked on. The second is planning the hosting of those containers.

### PaaS solutions for standardized runtimes, orchestration, and operations

Some workloads are highly self-contained, and don't necessarily benefit from the advanced controls and infrastructure requirements that come with a large platform like Kubernetes. Just because your workload is containerized doesn't mean it must be deployed to Kubernetes. Azure provides a variety of solutions to run workloads within your portfolio that don't require the level of management and infrastructure that AKS requires. The following solutions would each follow this approach to planning:

- [Azure App Service](/azure/app-service/)
- [Azure Functions](/azure/azure-functions/functions-overview)
- [Azure Container Instances](/azure/container-instances/container-instances-overview)
- [Azure Batch](/azure/batch/batch-technical-overview)

Consider using a more lightweight solution for your containers with workloads that you don't expect to grow in complexity and that align with the purposes and limits of these solutions.

### Standardized orchestration with custom runtimes and operations in the public cloud

For those workloads that cannot run in a fully managed PaaS platform and must relay on infrastructure-level controls, desire to use advanced deployment features such as those offered by container orchestrators, or expect to grow in modular complexity, turn to Azure Kubernetes Service (AKS). AKS solves for both container hosting, but also provides extensive architectural, SRE, security, deployment, monitoring, and infrastructure options.

The platform's feature set comes with a requirement to learn the platform both at the cluster operator level and at the workload level. Factor the education of your operations teams, architecture teams, and workload engineering teams into migration timelines. Also, because AKS is a platform, ensure workloads teams understand the separation of responsibilities within this platform versus their current hosting arrangement. It might be similar in some ways, but likely will be novel in others.

### Customized orchestration, runtimes and operations in the public cloud

For very specialized workloads or specific organizational requirements, Azure offers two other major platforms in the container orchestration space.

- Azure Red Hat OpenShift
- Azure Service Fabric

If there is reason to explore alternatives, ensure time is allocated to understand the benefits and tradeoffs of all platform options. Azure's default solution is AKS, and this documentation assumes AKS is the chosen technology.

### Standardize operations across cloud platforms

Often customers will deploy different container orchestrators in private cloud, edge, and public cloud environments. To standardize operations across those disparate cloud platforms, customers can incorporate a unified operations approach by extending their cloud operations tools to multiple cloud platforms.

In Azure, organizations can standardize operations across various orchestrators by onboarding disparate container hosts into Azure Arc for Kubernetes. This tool ensures consistent monitoring, operations, and governance across each of those container hosts.

### Application runtimes in private cloud and edge environments

When workloads must be run in a private cloud or edge environment, but the workload is best supported by a PaaS runtime, there are a few tools that can enable developers to build on top of consistent PaaS runtimes using Azure App Service:

- **Azure Stack HCI:** Allows for hosting Azure App Service natively on Azure Stack, managed by the Azure Stack operator.
- **Azure Stack HCI for AKS:** Allows for hosting of custom runtimes running on AKS within Azure Stack, managed by Azure Stack and AKS operators to allow for portability to other Kubernetes solutions.
- **Azure App Service on Kubernetes with Azure Arc:** Allows any Kubernetes host to provide application services in Azure. All hosts become a small instance of Azure App Service. Since each host is also onboarded into Azure Arc, those hosts can also be managed through consistent cloud-based host operations.

## Modern container readiness plan

In addition to the cloud-adoption skilling plan, the cloud adoption teams might need to develop skills related to container and Kubernetes before executing your plan:

- [Learn the basics of Kubernetes](/azure/aks/concepts-clusters-workloads)
- [Learn about containers](https://azure.microsoft.com/product-categories/containers/)
- [Review Kubernetes best practices](/azure/aks/best-practices)

Ensure time is allocated for workload teams to document and dry-run migration plans. The existing application or external system (both dependencies and systems that depend on this workload) may need to be modified with added flexibility to support the migration effort. This is true for both pre-production and production environments.

## Next step: Review your environment or Azure landing zone

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Review your environment or Azure landing zones](./ready.md)
- [Migrate workloads to modern application platforms](./migrate.md)
- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
- [See container and compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree)
