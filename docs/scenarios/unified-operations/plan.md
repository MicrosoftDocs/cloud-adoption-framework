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

Because Azure Stack brings the benefits of cloud innovation to any platform, retaining assets on-prem is no longer a barrier to implementing cloud benefits to physical datacenters anywhere. In addition, a unified operations and management of your digital estate enables consistent management and governance, bringing cloud innovation across on-prem, multi-cloud, and edge environments, eliminating the need to resolve dependencies, being no longer locked to platform restrictive configurations or policies. Azure Arc remains a single control plane across environments that manages all your digital estate assets, wherever they reside.

Finally, a unified operations plan that integrates on-prem assets with Azure Arc facilitates Azure-consistent migrations. Azure Arc implements Azure management across on-premises, multi-cloud and edge and enables Azure services anywhere, so migration efforts can standardize the management and governance of your entire digital estate from Azure. Assuming a unified operations plan changes how you consider asset inventory and rationalizing, deploying your cloud adoption plan, and readiness plan with more platform options, specific DevOps plan to manage deployment pipelines, and specific skilling for a hybrid and multicloud migration effort.

## Plan for unified operations

In most cloud adoption scenarios, we assume an intention to Rehost (IaaS VMs), Rearchitect (PaaS services), or Rebuild (Cloud-native) workloads with Azure as a target platform, with a uni-directional migration to Azure, using these standard rationalizations to identify assets for possible migration.  

When considering a hybrid and multi-cloud migration, the rationalization criteria change, and migration goals that were uni-directional now fit into a more distributed service model for cloud environments. With a hybrid and multi-cloud effort, cloud rationalization no longer assumes a one-way migration effort that assumed "migrate everything to the cloud."

In a hybrid and multi-cloud migration scenario, we assume a distributed, multi-platform cloud service model that is no longer limited to one on-premises environment and a single public cloud to an expansive on-prem, multi-cloud, and edge model of cloud computing. Rationalization decisions now become—**Retain** workloads or assets on-premises, **Replatform** workloads to multiple cloud platforms, and **Custom locations (Rehost portability)** reverse rehosting IaaS/PaaS workloads into on-premise hosting environments.

Most migration planning efforts focus on single direction migrations with an objective of getting things migrated to the cloud. In that model, Retain, Replatform, and Reverse rehosting were viewed as anti-patterns that should be minimized. Because the migration effort was focused on a one-way migration effort, these options did not fit the approach that assumed the migration of assets from on-premises environments to a single public cloud solution like Azure.

 The expansion of available deployment options remains the biggest change in planning for unified operations. In planning for a truly hybrid, multi-cloudm and edge model, you open up agile options for deploying workloads to on-premises and public cloud environments, and the risk for dependencies is eliminated for your workloads across planned deployments. In an expanded (on-premises, multi-cloud, and edge) deployment model, you no longer need to minimize dependencies on retained (hybrid/on-premises) workloads or replatformed (multi-cloud) workloads. And, since custom locations are now viable with a single control plane (given rehost portability), IaaS/PasS workloads can be re-provisioned on-premises.

Because Azure Arc extends a single control plane of Azure services and management to existing on-premises infrastructure, it provides platform flexibility for customers who want to continue to use existing systems and toolsets. You have the freedom to bring innovative cloud technologies to *any* location across your hybrid environment. And, because your workload deployments are not limited to one hosting environment, they can be reverse rehosted on-premises, leveraging the same cloud benefits.

Opening deployment options across on-premises and public cloud enables organizations to bring the consistency and innovation of uniform cloud practices to on-prem workloads (for example, to maintain highly sensitive data on-premises to meet client needs or regulatory requirements) and still prepare other workloads for migration with the same cloud practices and technology benefits.

The biggest change in planning unified operations with expanded deployment options is the process of evaluating deployment decisions against **Retain**, **Replatform,** and **Rehost portability,** the primary 3 Rs of migration. Because we can now have a truly distributed cloud ecosystem with expanded deployment options, cloud practices and technologies can be brought to any location, allowing reverse re-hosting of IaaS/PasS workloads on-premises, reversing the uni-directional migration model that assumed "migrate everything to the cloud."

In many cases, we start by assuming that every asset fits a **Retain** pattern, by adding each asset to the enterprise control plane for unified operations and management. One enterprise control plane not only **speeds up cloud adoption and migration efforts** with consistent cloud practices and technologies across on-prem and migration-candidate workloads, but also **controls sprawling IT assets** with unified management and operations across on-premises and public cloud—**maintains regulatory and data sovereignty compliance** with consistent data governance, security, and cost management—and **ensures uniform deployments and configuration** with consistent workload deployments, configured at scale.

## Unified operations digital estate

The current assumption is that many in the current enterprise landscape will adopt the cloud. A complete enterprise migration could take days or even years.

Evaluate your entire estate looking for standard opportunities: Rehost/Rearchitect

In hybrid we commonly see the following:

- Workloads that should live on-prem going forward
- New App Dev needs to be supported by workloads that haven't been migrated or can't be migrated
- Build new on-prem app that has speed of light, connectivity, or regulatory requirements

Standard migration assumes everything is a VM or PaaS service.
Hybrid/Unified operations opens up more form factors for distributing cloud innovation using Azure technology outside of our facilities:

- Azure Stack: Standard cloud form factor using Azure services
- Azure Arc: More traditional form factors adding governance, management, etc... to the technologies you use today

Unified operations is a single control to manage all of these form factors across all facilities

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
