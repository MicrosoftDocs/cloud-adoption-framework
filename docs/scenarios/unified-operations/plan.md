---
title: "Plan for unified operations"
description: Describe the scenario's impact on planning
author: mpvenables
ms.author: brblanch
ms.date: 11/30/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Executive summary

Most cloud adoption scenarios assume common rationalization of workload assets that are rehosted, rearchitected, or rebuilt to fit IaaS lift and shift scenarios, PaaS services configurations, or cloud-native workloads. Planning efforts that center on unified operations includes assets beyond VMs and PaaS services in migration efforts, widening the availability of form factors to bring innovation benefits beyond private cloud to anywhere . Azure Arc and Azure Stack can bring transformation efforts under unified operations and management across private cloud, public cloud and the edge.

Because Azure Stack brings the benefits of cloud innovation to any platform, retaining assets on-premises is no longer a barrier to implementing cloud benefits to physical datacenters anywhere. In addition, a unified operations and management of your digital estate enables consistent management and governance, bringing cloud innovation across on-premises, multi-cloud, and edge environments, eliminating the need to resolve dependencies, being no longer locked to platform restrictive configurations or policies. Azure Arc remains a single control plane across environments that manages all your digital estate assets, wherever they reside.

Finally, a unified operations plan that integrates on-premises assets with Azure Arc facilitates Azure-consistent migrations. Azure Arc implements Azure management across on-premises, multi-cloud and edge and enables Azure services anywhere, so migration efforts can standardize the management and governance of your entire digital estate from Azure. Assuming a unified operations plan changes how you consider asset inventory and rationalizing, deploying your cloud adoption plan, and readiness plan with more platform options, specific DevOps plan to manage deployment pipelines, and specific skilling for a hybrid and multicloud migration effort.

## Plan for unified operations

In most cloud adoption scenarios, we assume an intention to Rehost (IaaS VMs), Rearchitect (PaaS services), or Rebuild (Cloud-native) workloads with Azure as a target platform, with a uni-directional migration to Azure, using these standard rationalizations to identify assets for possible migration.  

When considering a hybrid and multi-cloud migration, the rationalization criteria change, and migration goals that were uni-directional now fit into a more distributed service model for cloud environments. With a hybrid and multi-cloud effort, cloud rationalization no longer assumes a one-way migration effort that assumed "migrate everything to the cloud."

In a hybrid and multi-cloud migration scenario, we assume a distributed, multi-platform cloud service model that is no longer limited to one on-premises environment and a single public cloud to an expansive on-premises, multi-cloud, and edge model of cloud computing. Rationalization decisions now become—**Retain** workloads or assets on-premises, **Replatform** workloads to multiple cloud platforms, and **Custom locations (Rehost portability)** reverse rehosting IaaS/PaaS workloads into on-premise hosting environments.

Most migration planning efforts focus on single direction migrations with an objective of getting things migrated to the cloud. In that model, Retain, Replatform, and Reverse rehosting were viewed as anti-patterns that should be minimized. Because the migration effort was focused on a one-way migration effort, these options did not fit the approach that assumed the migration of assets from on-premises environments to a single public cloud solution like Azure.

 The expansion of available deployment options remains the biggest change in planning for unified operations. In planning for a truly hybrid, multi-cloudm and edge model, you open up agile options for deploying workloads to on-premises and public cloud environments, and the risk for dependencies is eliminated for your workloads across planned deployments. In an expanded (on-premises, multi-cloud, and edge) deployment model, you no longer need to minimize dependencies on retained (hybrid/on-premises) workloads or replatformed (multi-cloud) workloads. And, since custom locations are now viable with a single control plane (given rehost portability), IaaS/PasS workloads can be re-provisioned on-premises.

Because Azure Arc extends a single control plane of Azure services and management to existing on-premises infrastructure, it provides platform flexibility for customers who want to continue to use existing systems and toolsets. You have the freedom to bring innovative cloud technologies to *any* location across your hybrid environment. And, because your workload deployments are not limited to one hosting environment, they can be reverse rehosted on-premises, leveraging the same cloud benefits.

Opening deployment options across on-premises and public cloud enables organizations to bring the consistency and innovation of uniform cloud practices to on-premises workloads (for example, to maintain highly sensitive data on-premises to meet client needs or regulatory requirements) and still prepare other workloads for migration with the same cloud practices and technology benefits.

The biggest change in planning unified operations with expanded deployment options is the process of evaluating deployment decisions against **Retain**, **Replatform,** and **Rehost portability,** the primary 3 Rs of migration. Because we can now have a truly distributed cloud ecosystem with expanded deployment options, cloud practices and technologies can be brought to any location, allowing reverse re-hosting of IaaS/PasS workloads on-premises, reversing the uni-directional migration model that assumed "migrate everything to the cloud."

In many cases, we start by assuming that every asset fits a **Retain** pattern, by adding each asset to the enterprise control plane for unified operations and management. One enterprise control plane not only **speeds up cloud adoption and migration efforts** with consistent cloud practices and technologies across on-premises and migration-candidate workloads, but also **controls sprawling IT assets** with unified management and operations across on-premises and public cloud—**maintains regulatory and data sovereignty compliance** with consistent data governance, security, and cost management—and **ensures uniform deployments and configuration** with consistent workload deployments, configured at scale.

## Unified operations digital estate

The current assumption in today's enterprise landscape is that most organizations will adopt the cloud. A complete enterprise migration could take days or even years, depending on what assets are included as migration candidates in the digital estate. Consider an enterprise environment with thousands of VMs and hundreds of applications, where the human effort required can easily exceed 1,500 FTE hours and nine months of planning. With standard (uni-directional) migration efforts, the assumption is that you will look for standard opportunities for Rehost/Rearchitect (assets that surface as standard migration candidates when rationalizing your digital estate).

In moving to a hybrid and multi-cloud scenario, where we assume unified operations for all resources in the digital estate, certain rationalization decisions will surface.

Because on-premises assets are added to the enterprise control plane for unified operations and management, we commonly see the following rationalizations: workloads recommended to remain on-premises (for example, limited by regulatory or compliance reasons); new application development for the enterprise that needs to be supported by workloads that haven't been migrated, or can't be migrated; the business requirement to build new on-premises applications that have speed of light, connectivity, or regulatory requirements.

Standard migration assumes that every asset in the workload is a VM or PaaS service in terms of either Rehost or Rearchitect. As mentioned, *standard migration efforts* assume a uni-directional, "migrate everything to the cloud" approach—lifting and shifting (IaaS VMs) and rearchitecting (PaaS services).

## A unified operations approach across Azure Stack and Azure Arc

A unified operations approach that considers hybrid and multi-cloud environments opens up more form factors for distributing cloud innovation by using Azure services and server management practices across other multi-cloud environments and the edge.

The Azure Stack product family opens up standard cloud form factors and extends Azure services and capabilities across datacenters, cloud, and edge locations.

**Azure Stack Hub** extends full stack Azure services to on-premises, enabling you to run apps in on-premises environments and deliver Azure services in your datacenter. It unlocks new hybrid cloud use cases for both customer-facing and internal line-of-business apps: edge and disconnected solutions, cloud apps with varied regulatory requirements, and cloud app models on-premises using Azure services, containers, serverless, and microservice architectures.

**Azure Stack HCI** is a hyperconverged cluster that uses validated hardware to run virtualized Windows and Linux workloads on-premises and easily connect to Azure for cloud-based backup, recovery, and monitoring. Its software-defined infrastructure enables high-performance hyperconverged compute, storage, and networking, based on Hyper-V and storage Spaces Direct. Delivered as an Azure service with built-in hybrid capabilities, the Azure Stack HCI (virtualization host) is backed by Microsoft-validated hardware components.

**Azure Stack Edge** is purpose-built (enterprise datacenter or rugged environment) hardware-as-a-service. It is optimized for edge compute, machine learning, and IoT scenarios to run your workloads at the edge for faster data insights, and manages your hardware appliance and workloads through the Azure portal. It allows you to run machine learning models with hardware-accelerated machine learning capabilities (with on-board FPGAs and GPUs)—leverages edge computing to process data close to the source (with VMs, Azure services, Kubernetes clusters, and containers)—and acts as a cloud storage gateway, transferring data to Azure over the network, retaining local access to blobs and files.

## Azure Arc's single pane of glass 

Azure Arc opens up more traditional form factors because its unified operations approach offers you a **consistent Azure framework across hybrid, multi-cloud, and edge environments, reaching outside Azure and projecting your existing resources into Azure Resource Manager as first-class citizens.** Azure Arc is a multi-cloud and on-premises management platform that with a unified operations approach, a single control plane to manage all of these form factors across all on premises, multi-cloud, and edge facilities.

## What can you do with Azure Arc?

**Manage and operate all your resources as native Azure resources with a single pane of glass, consistently and at scale across disparate infrastructure , placing you in control** of resources across on-premises, multi-cloud, and edge environments, providing one reference for your management, data services, governance, security, and identity. 

- **Azure Arc-enabled infrastructure connects to and operates hybrid resources as native Azure resources**—giving you greater visibility, compliance, and consistency across distributed resources, unified governance (reduced risk and cost across workloads), consistent tooling, and cloud-native practices.

- **Operating from Azure, deploy Azure Arc-enabled services and run Azure services outside Azure**—providing flexibility, less latency, and always-current datacenter environments—risk-reduced, compliant cloud services deployed on-premises—data services deployed on-premises, supporting connected and disconnected workloads—a cloud billing model, and always-current evergreen SQL and PostgreSQL Hyperscale on-premises,.

## What are the use cases for Azure Arc?

Azure Arc simplifies complex and distributed environments across on-premises, edge and multi-cloud, enables deployment of Azure services anywhere, and extends Azure management to any infrastructure.

**Organize and govern across environments—** 
Get databases, Kubernetes clusters, and servers sprawling across on-premises, edge and multi-cloud environments under control by centrally organizing and governing from a single place.

**Manage Kubernetes apps at scale—** 
Deploy and manage Kubernetes applications across environments using DevOps techniques. Ensure that applications are deployed and configured from source control consistently.

**Run data services anywhere—** 
Get automated patching, upgrades, security and scale on-demand across on-premises, edge and multi-cloud environments for your data estate.

## What are the benefits of Azure Arc for customers?

### Azure Arc-enabled infrastructure

**Reach out, and onboard, and manage any server, anywhere, from Azure** (Windows, Linux, VM, Bare-Metal) with Azure-Arc enabled servers.

**Use your existing SQL servers with Azure Arc with no migration necesary**—with inventory, governance, security, and proactive SQL database assessments.

**Connect, manage, and operate any Kubernetes cluster(s) and applications running anywhere,** and deploy applications with GitOps.

**Ensure compliance with your organization's security baseline with Azure Policy** and enable cluster health monitoring with Azure Monitor for Containers.

**Organize, inventory and unify server management experience** with simplified management of hybrid machines with Azure VM extensions for non-Azure Windows and Linux VMs.

**Apply unified governance and security baselines across disparate environments**, cross-platform compliance, and centralized agent management.

**Apply RBAC (role-based access control) at-scale** with Central IT and at workload level owner level.

**Deploy familiar Azure governance, security, inventory tracking and patch management tools** on auto-enrolled Azure Arc-enabled servers.

### Azure Arc-enabled data services

**Bring Azure data services to any infrastructure—** across on-premises, edge and multi-cloud using Kubernetes on any hardware.

**Remain current with fully automated updates, upgrades and policy-controlled deployments,** evergreen SQL and hyperscale deployment option of Azure Database for PostgreSQL.

**Optimize performance of data workloads, and dynamically scale up/scale out, without application downtime with cloud elasticicy on-premises.**

**Gain unified management and consistent visibility over on-premises and native Azure data workloads** using familiar tools (Azure Portal, Azure Data Studio and Azure CLI).

**Protect your on-premises data workloads using Azure security and governance toolsets** (Azure Security Center, Azure Policy, and Azure RBAC)

**Increase cost-efficiencies across your hybrid infrastructure** with a modern cloud billing model.

## inventory analysis guidance

If unified operations is a core part of your strategy, you should start by lighting up Azure Arc for all resources before starting you Azure Migrate integration.

Do you have to look at the existing estate differently? Or is a simple VM to VM migration sufficient?
<https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/inventory>

## unified operations adoption plan

Do you have a specific devops backlog the customer should use? Or is the standard adoption plan template still sufficient?
<https://docs.microsoft.com/azure/cloud-adoption-framework/plan/template>

## unified operations readiness plan

Are there specific skills or extra training this team should take before getting started?

## Next step: Review your environment or Azure Landing Zone

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for unified operations](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Assess for unified operations migration](./migrate-assess.md)
- [Migrate unified operations](./migrate-deploy.md)
- [Release unified operations to production](./migrate-release.md)
- [Innovate with unified operations](./innovate.md)
- [Govern unified operations](./govern.md)
- [Manage unified operations](./manage.md)
