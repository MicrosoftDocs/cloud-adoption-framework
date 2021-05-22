---
title: Plan methodology for hybrid and multicloud strategy
description: Describe the scenario's impact on planning
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: e2e-hybrid
---

# Plan for hybrid and multicloud

Most cloud adoption scenarios assume common rationalization of workload assets that are rehosted, rearchitected, or rebuilt to fit IaaS lift-and-shift scenarios, modernization to PaaS services, or new innovation using cloud-native workloads. When planning for hybrid and multicloud, additional rationalization options should be considered to address the management of assets across all hybrid and multicloud platforms.

Most notably, hybrid and multicloud adoption efforts must develop a plan for the following expanded rationalization options:

- Work with assets that will **remain** unchanged in the on-premises datacenter.
- Modernize to PaaS services that will **remain** in the datacenter.
- **Replatform** assets to other cloud platforms.
- **Rehost portability** allowing workloads to move smoothly between hybrid and multicloud platforms.

These minor changes will affect the work required to reach your hybrid and multicloud strategy. This article outlines a number of impacts to the plans currently defined in the [Cloud Adoption Framework's Plan methodology](../../plan/index.md).

## Azure tools to consider in your plan

Hybrid and multicloud planning efforts include assets beyond VMs and PaaS services in migration efforts, widening the availability of form factors to stretch innovation benefits beyond the private cloud to any location. [Azure Arc](/azure/azure-arc/overview) and [Azure Stack](https://azure.microsoft.com/overview/azure-stack/) drive digital transformation efforts under unified operations and management across private cloud, public cloud and the edge.

Azure Stack is a hardware solution that enables you to run an Azure environment on-premises, and on the edge. Because Azure Stack uses an integrated system with cloud service on-premises via [Azure Stack Hub](https://azure.microsoft.com/products/azure-stack/hub/), or runs edge-computing workloads with a cloud-managed appliance via [Azure Stack Edge](https://azure.microsoft.com/products/azure-stack/edge/), retaining assets on-premises is no longer a barrier to extending cloud benefits on-premises, or the edge. Such unified operations and management enables consistent operations management and governance across environments. This eliminates the need to resolve dependencies, that are no longer locked to platform-restrictive configurations or policies.

Azure Arc is a software solution providing one enterprise control plane that manages all your digital assets across environments by projecting your on-premises and other cloud resources into Azure, extending simplified management, faster application development, and consistent Azure services to any infrastructure, anywhere.

A hybrid and multicloud strategy that follows a unified operations approach, integrates uniform visibility of on-premises assets with Azure Arc, and can facilitate Azure-consistent migration efforts, extending to and projecting resources into Azure as first-class citizens. Azure Arc implements unified cloud operations management across on-premises, multicloud and edge, and enables Azure services anywhere, so migration efforts can standardize management and governance for your entire digital estate, right from Azure. Implementing a unified operations approach changes how you might consider asset inventory and rationalizing your estate, deploying your cloud adoption plan, your readiness plan (with expanded platform options), your specific DevOps plan to manage deployment pipelines, and specific skilling for a hybrid and multicloud strategy.

Hybrid, multicloud, and edge deployment strategies with a unified operations approach in mind can **accelerate cloud adoption and migration efforts for your organization**, deploying a consistent operational and management framework for organizations to move forward and adopt modern cloud technologies. This optimizes cloud operations management and governance processes across on-premises-designated as well as migration-candidate workloads.

Developing necessary cloud skilling, and building cloud processes that support the overall migration readiness effort across the organization helps to accelerate the overall cloud adoption and migration effort. Planning for unified operations accelerates innovation across resources with an operational framework for simplified management, faster application development, and consistent Azure services across sprawling on-premises, multicloud, and edge environments, and can strengthen your organization's overall cloud adoption and migration effort.

## Planning for hybrid and multicloud strategy

In most cloud adoption scenarios, we assume an intention to rehost (IaaS VMs), rearchitect (PaaS services), or rebuild (cloud-native) workloads with Azure as a target platform, with a uni-directional migration to Azure, using these standard rationalizations to identify assets for possible migration.

When considering a hybrid and multicloud migration, the rationalization criteria change, and migration goals that were uni-directional now fit into a more distributed services model for cloud environments. With a hybrid and multicloud effort, cloud rationalization no longer assumes a one-way migration effort that maintains "migrate everything to the cloud."

In a hybrid and multicloud migration scenario, we assume a distributed, multiplatform cloud services model that is no longer limited to one on-premises environment and a single public cloud to an expansive on-premises, multicloud, and edge model of cloud computing. Rationalization decisions now consider whether to **retain** workloads or assets on-premises, **replatform** workloads to multiple cloud platforms, and have **rehost portability** allowing workloads to move smoothly into any hosting environments.

Most migration planning efforts focus on single-direction migrations with an objective of simply getting things migrated to the cloud. In that model, retain, replatform, and reverse rehosting were viewed as antipatterns that should be minimized. Because the migration effort was focused on a one-way migration effort, these options did not fit the approach that assumed the migration of assets from on-premises environments to a single public cloud solution like Azure.

The expansion of available deployment options remains the biggest change in planning for unified operations. In planning for a truly hybrid, multicloud and edge model, you open up options for deploying workloads to on-premises and public cloud environments, and the risk of dependencies is eliminated for workloads across your planned deployments. In an expanded (on-premises, multicloud, and edge) deployment model, you no longer need to minimize dependencies on retained (hybrid/on-premises) workloads or replatformed (multicloud) workloads. And, since custom locations are now viable with a single enterprise control plane (given rehost portability), IaaS/PaaS workloads can be reverse rehosted on-premises.

### One control plane, expanded deployment options

Because Azure Arc extends a single enterprise control plane of Azure services and management to existing on-premises infrastructure, it provides platform flexibility for customers who want to continue to use existing systems and toolsets. You have the freedom to bring innovative cloud technologies to *any* location across your distributed environment. And, because your workload deployments are not limited to one hosting environment, they can be reverse rehosted on-premises, with the same cloud benefits.

Opening deployment options across on-premises and public cloud enables organizations to bring the consistency and innovation of uniform cloud practices to on-premises workloads (for example, keeping highly sensitive data on-premises to meet client needs or regulatory requirements) and still prepare other workloads for migration with the same benefits of cloud practices and technologies.

The biggest change in planning unified operations with expanded deployment options is the process of evaluating deployment decisions against **Retain**, **Replatform**, and **Rehost** portability, the primary 3 Rs of migration. With expanded deployment options across truly distributed cloud environments, cloud practices and technologies can be brought to any location, allowing reverse rehosting of IaaS/PaaS workloads on-premises, reversing the uni-directional migration model that operated under the assumption of *migrate everything to the cloud*.

In many cases, we start by assuming that every asset fits a **Retain** pattern, proactively adding each asset to the enterprise control plane for unified cloud operations and management efforts. Adopting a consistent cloud dashboard **can speed up cloud adoption and migration efforts for your organization** by deploying consistent cloud practices and technologies across assets designated for on-premises workloads, and cloud-ready skills and processes to support workloads with migration-designated assets.

## Hybrid and multicloud digital estate

The current assumption in today's enterprise landscape is that most organizations will adopt the cloud. A complete enterprise migration could take days or even years, depending on what assets are included as migration candidates in the digital estate. Consider an enterprise environment with thousands of VMs and hundreds of applications, where the human effort required can easily exceed 1,500 FTE hours and nine months of planning. With standard (uni-directional) migration efforts, the assumption is that you will look for standard opportunities for rehost/rearchitect (assets that surface as standard migration candidates when rationalizing your digital estate).

In moving to a hybrid and multicloud scenario, where we assume unified operations for all resources in the digital estate, certain rationalization decisions will surface.

Because on-premises assets are added to the enterprise control plane for unified operations and management, we commonly see the following rationalizations:

- Workloads recommended to remain on-premises (for example, limited by regulatory or compliance reasons)
- New application development for the enterprise that needs to be supported by workloads that haven't been migrated, or can't be migrated
- The business requirement to build new on-premises applications that have speed of light, connectivity, or regulatory requirements

Standard migration assumes that every asset in the workload is a VM or PaaS service in terms of either rehost or rearchitect. As mentioned, *standard migration efforts* assume a unidirectional *migrate everything to the cloud* approach, lifting and shifting (IaaS VMs) and rearchitecting (PaaS services).

## Using Azure Stack and Azure Arc in hybrid and multicloud strategy

A unified operations approach that considers hybrid and multicloud environments opens up more form factors for distributing cloud innovation by using Azure services and server management practices across other multicloud environments and the edge.

The [Azure Stack family portfolio](https://azure.microsoft.com/blog/expanding-the-azure-stack-portfolio-to-run-hybrid-applications-across-the-cloud-datacenter-and-the-edge/), integrated systems, and hyperconverged solutions open up standard cloud form factors, extending Azure services and management across datacenters, cloud, and edge locations.

[Azure Stack Hub](https://azure.microsoft.com/products/azure-stack/hub/) extends full stack Azure services to on-premises, enabling you to run applications in on-premises environments and deliver Azure services in your datacenter. It unlocks new hybrid cloud use cases for both customer-facing and internal line-of-business applications: edge and disconnected solutions, cloud applications with varied regulatory requirements, and cloud application models on-premises using Azure services, containers, serverless, and microservice architectures.

[Azure Stack HCI](https://azure.microsoft.com/products/azure-stack/hci/) is a hyperconverged cluster that uses validated hardware to run virtualized Windows and Linux workloads on-premises and easily connect to Azure for cloud-based backup, recovery, and monitoring. Its software-defined infrastructure enables high-performance hyperconverged compute, storage, and networking, based on Hyper-V and Storage Spaces Direct. Delivered as an Azure service with built-in hybrid capabilities, the Azure Stack HCI (virtualization host) is backed by Microsoft-validated hardware components.

[Azure Stack Edge](https://azure.microsoft.com/products/azure-stack/edge/) is a purpose-built enterprise datacenter or rugged environment hardware-as-a-service. It's optimized for edge compute, machine learning, and IoT scenarios to run your workloads at the edge for faster data insights, and manages your hardware appliance and workloads through the Azure portal. It allows you to run machine learning models with hardware-accelerated machine learning capabilities (with onboard FPGAs and GPUs), uses edge computing to process data close to the source (with VMs, Azure services, Kubernetes clusters, and containers), and acts as a cloud storage gateway, transferring data to Azure over the network, while retaining local access to blobs and files.

## The Azure Arc dashboard for hybrid and multicloud strategy

Azure Arc is a multicloud and on-premises management platform at the core of unified operations that enables standardized visibility, operations, and compliance across scattered resources in on-premises, multicloud, and edge environments. Adopting a single enterprise control plane **accelerates cloud adoption and migration** and enables a consistent framework for organizations to adopt modern cloud technologies and processes for on-premises-designated and migration-candidate workloads. Supporting the development of necessary cloud skilling, and building cloud processes to support overall migration readiness initiatives across the organization increases the consistency and speed of cloud adoption and migration efforts. Deploying a single enterprise dashboard with visibility across sprawling resources across on-premises, multicloud, and edge environments accelerates cloud innovation for organizations, with simplified management, faster application development, and consistent Azure services.

## What can you do with Azure Arc?

![Azure Arc can manage and operate all your resources as native Azure resources with a single pane of glass.](../../_images/hybrid/what-can-azure-arc-do.png)

**Manage and operate all your resources as native Azure resources with a single pane of glass, consistently and at scale across disparate infrastructure, placing you in control** of resources across on-premises, multicloud, and edge environments, providing a single dashboard for your management, data services, governance, security, and identity. Azure Arc's unified operations approach offers you a **consistent visibility framework across distributed environments, reaching outside Azure and projecting your existing resources into Azure Resource Manager as first-class citizens.**

- **Connect to and operate hybrid resources as native Azure resources with Azure Arc enabled infrastructure.**

- **Deploy Azure Arc enabled services: run Azure services outside Azure, while operating from Azure.**

## What are the use cases for Azure Arc?

Azure Arc simplifies complex and distributed environments across on-premises, edge and multicloud, enables deployment of Azure services anywhere, and extends Azure management to any infrastructure.

**Organize and govern across environments:** Get databases, Kubernetes clusters, and servers sprawling across on-premises, edge and multicloud environments under control by centrally organizing and governing from a single place.

**Manage Kubernetes applications at scale:** Deploy and manage Kubernetes applications across environments using DevOps techniques. Ensure that applications are deployed and configured consistently from source control.

**Run data services anywhere:** Get automated patching, upgrades, security and scale on-demand across on-premises, edge and multicloud environments for your data estate.

## What are the benefits of Azure Arc for customers?

Planning efforts for unified operations and management assume that most assets fit a **Retain** pattern, adding each to the enterprise control plane, and expanding available form factors. Integral, cross-platform visibility across environments:

- **Speeds up cloud adoption and migration efforts**, extending consistent cloud practices and technologies across on-premises and migration-candidate workloads
- **Controls sprawling IT assets** with unified operations and management across on-premises and public cloud
- **Maintains regulatory and data sovereignty compliance** with standardized data governance, security, and Cost Management policies
- **Ensures uniform deployments and configuration** with consistent workload deployments, configured at scale

### Azure Arc enabled infrastructure

- **Reach out, and onboard, and manage any server, anywhere, from Azure** (Windows, Linux, VM, bare-metal) with Azure Arc enabled servers.
- **Use your existing SQL servers with Azure Arc with no migration necessary**, with inventory, governance, security, and proactive SQL Database assessments.
- **Connect, manage, and operate Kubernetes clusters and applications running anywhere**, and deploy applications with GitOps.
- **Ensure compliance with your organization's security baseline with Azure Policy**, and enable cluster health monitoring with Azure Monitor for containers.
- **Organize, inventory and unify server management experience** with simplified management of hybrid machines with Azure VM extensions for non-Azure Windows, and Linux VMs.
- **Apply unified governance and security baselines across disparate environments**, cross-platform compliance, and centralized agent management.
- **Apply [RBAC (role-based access control)](/azure/role-based-access-control/) at-scale**, with central IT and at workload-level owner level.
- **Deploy familiar Azure governance, security, inventory tracking and patch management tools** on auto-enrolled Azure Arc enabled servers.
- **Monitor your full telemetry** across your cloud-native and on-premises resources in a single place with Azure Monitor.

### Azure Arc enabled data services

- **Bring Azure data services to any infrastructure**, across on-premises, edge and multicloud using Kubernetes on any hardware.
- **Remain current with fully automated updates, upgrades and policy-controlled deployments** like evergreen SQL and hyperscale deployment option of [Azure Database for PostgreSQL](/azure/postgresql/).
- **Optimize performance of data workloads, and dynamically scale up/scale out, without application downtime with cloud elasticity on-premises.**
- **Gain unified management and consistent visibility over on-premises and native Azure data workloads** using familiar tools (Azure portal, Azure data studio, and Azure CLI).
- **Protect your on-premises data workloads using Azure security and governance toolsets** including [Azure Security Center](/azure/security-center/security-center-introduction), [Azure Policy](/azure/governance/policy/overview), and [Azure RBAC](/azure/role-based-access-control/).
- **Increase cost-efficiencies across your hybrid infrastructure** with a modern cloud billing model.

## Inventory analysis guidance

If unified operations is a core part of your strategy, you should start by lighting up Azure Arc for all resources before starting your Azure Migrate integration.

Do you have to look at the existing estate differently? Or is a simple VM to VM migration sufficient? For more information, see [LINKTEXT](../../digital-estate/inventory.md).

## Hybrid and multicloud adoption plan

Do you have a specific DevOps backlog the customer should use? Or is the standard adoption plan template still sufficient? For more information, see [LINKTEXT](../../plan/template.md).

## Hybrid and multicloud readiness plan

Are there specific skills or extra training this team should take before getting started? To prepare for the readiness phase of your hybrid and multicloud migration journey, consider a [skills readiness path](../../ready/suggested-skills.md) to add skills in organizational and technical readiness.

## Next step: Review your environment or Azure landing zone

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Review your environment or Azure landing zones](./ready.md)
- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
