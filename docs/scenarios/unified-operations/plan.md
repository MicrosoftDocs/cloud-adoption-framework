---
title: "Plan for unified operations"
description: Describe the scenario's impact on planning
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Executive summary
Most cloud adoption scenarios assume common rationalization of workload assets to be rehosted, rearchitected, or rebuilt to fit IaaS lift and shift scenarios, PaaS services configurations, or cloud-native workloads. Planning efforts that center on unified operations migration efforts greatly expand the availability of form factors across the digital estate with the benefits of Azure Arc and Azure Stack with unified cloud benefits.

Because Azure Stack brings you the benefits of cloud innovation to any platform, retaining assets on-prem is no longer a barrier to implementing cloud benefits to physical datacenters anywhere. In addition, a unified operations and management of your digital estate enables consistent management and governance, bringing cloud innovation across on-prem, multi-cloud, and edge environments, eliminating the need to resolve dependencies, being no longer locked to platform restrictive configurations or policies. Azure Arc remains a single control plane across environments that manages all your digital estate assets, wherever they reside.

Finally, a unified operations plan that onboards on-prem assets with Azure Arc facilitates Azure-consistent migrations. Azure Arc implements Azure management across on-premises, multi-cloud and edge and enables Azure services anywhere, so migration efforts can standardize the management and governance of your entire digital estate from Azure. Assuming a unified operations plan changes how you consider asset inventory and rationalizing, deploying your cloud adoption plan, and readiness plan with more platform options, specific DevOps plan to manage deployment pipelines, and specific skilling for a hybrid and multicloud migration effort.

# Plan for unified operations

In most cloud scenarios, we assume that you want to rehost (IaaS VMs), rearchitect (PaaS services), or Rebuild (Cloud native) workloads with Azure as a target platform. This changes in hybrid:
- **Retain** workloads or assets on-prem. 
- **Replatform** workloads to multiple cloud platforms. 
- **Custom locations (Rehost portability)** IaaS/PaaS workloads into on-premise hosting environments.

Most planning efforts focus on single direction migrations with an objective of getting things migrated to the cloud. In that model, Retain, Replatform, & Reverse Rehosting were viewed as anti-patterns that should be minimized.

The biggest change in planning for unified operations is that you no longer need to minimize dependencies on retained (hybrid/on-prem) workloads or replatform (multi-cloud) workloads. The biggest change in planning, is to evaluate these decisions alongside the primary 3 Rs of migration above. In many cases, we start by assuming that every asset fits a **Retain** pattern, by adding each asset to the enterprise control plane for unified operations and management.

## Unified operations digital estate

Assumption: You've assumed to adopt cloud. That could take days or years
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

### Inventory analysis guidance

If unified operations is a core part of your strategy, you should start by lighting up Azure Arc for all resources before starting you Azure Migrate integration.

Do you have to look at the existing estate differently? Or is a simple VM to VM migration sufficient?
https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/inventory


## unified operations adoption plan

Do you have a specific devops backlog the customer should use? Or is the standard adoption plan template still sufficient?
https://docs.microsoft.com/azure/cloud-adoption-framework/plan/template

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
