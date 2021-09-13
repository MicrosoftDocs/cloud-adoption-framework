---
title: Manage modern application platform solutions
description: Describe the scenario's impact on operations management
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Manage modern application platform clusters

The [Cloud Adoption Framework provides a core methodology to define operation management processes](../../manage/index.md) for the cloud in an agnostic sense. Its guidance helps establish an operations management baseline and other specialized layers of operations. This guidance might still apply for organizations that have a mixture of infrastructure as a service (IaaS), platform as a service (PaaS), and containerized workloads. This article outlines what you need to integrate into your existing operations to prepare for container management. It also highlights the benefits of integrating Azure Kubernetes Service (AKS) into your container management strategy.

## Business alignment for operations management needs

Containers remove dependencies on several layers of infrastructure, leading to improved operations management capabilities. To realize these operational improvements, you might have to revise your overall cloud management strategy, starting with the business alignment.

To establish proper operations management practices, you must understand how containers will be used in your cloud adoption plans and what benefits you want to realize from this shift to containerized workloads.

- Will you manage multiple technology solutions, such as containers, IaaS, and PaaS, in your cloud platform?
- Will centralized teams support operations and management of the container or AKS platform? Does this accountability shift to the individual workload teams?
- Will centralized teams support operations and management of the workloads running in each container or pod? Does this accountability shift to the individual workload teams?
- Are you using containers for mission-critical workloads?
- Are you only using containers for less-critical or utility workloads to reduce costs?
- How important is the performance and reliability of your individual workloads?
- Are the applications in your containers state-less? Do you need to persist state to protect and recover the workloads in the containers?

These basic questions will shape how to best integrate containers and AKS into your operations management strategy.

## Operations baseline

Implementing an operations baseline provides centralized access to the tools required to operate and manage all assets in your cloud environment. If you don't have an operations baseline for your non-containerized assets, you can implement the [operations baseline defined in the Manage methodology](../../manage/azure-server-management/index.md).

Your operations baseline should include tools and configurations to provide visibility, monitoring, operational compliance, optimization, and protection/recovery.

![Operations management baseline](../../_images/manage/management-baseline.png)

The operations baseline outlined in the articles above won't provide support for your containers or AKS platform. However, it will provide the tooling foundation that can be extended to support containers, such as Azure Monitor, Azure Backup, and other tools.

If most of your portfolio in the cloud is hosted in containers, consider including the specialized platform operations in the next section into your operations baseline.

## Platform operations

Unless this implementation is your organization's first or only deployment to the cloud, you should have an operations baseline. This section identifies a few tools you might want to include to help manage container or AKS deployment.

### Inventory and visibility

Monitoring containers and AKS clusters use the tools, dashboards, and alerts included in your operations baseline. However, you might need to do more configuration to get the data from your containers into operations monitoring tools, like [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json). See the [overview of Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json) to gather the data needed to add container and AKS platform operations to your operations baseline.

Once you've configured Azure Monitor to collect data on your containers, you can monitor the following areas as part of your centralized management processes:

- Identify clusters running in various regions, ideally tied to a service tree entry and identify key facts on those clusters
  - Identify cluster node pool, networking, and storage topologies of those clusters
  - Identify AKS version and node image version stratification.
- Identify cluster node resource utilization (process, memory, and storage)
- Identify containers that are running on the nodes and their contribution to node utilization
- Understand the behavior of clusters under average and heaviest loads. This knowledge can help you identify capacity needs and determine the maximum load that the cluster can sustain.
- Configure alerts to proactively notify you or record when CPU and memory utilization on nodes or containers exceed your thresholds, or when a health state change occurs in the cluster at the infrastructure or nodes health rollup.
- Use [queries](/azure/azure-monitor/containers/container-insights-log-search) to create a common set of alerts, dashboards, and detailed perform detailed analysis

This data will also support workload operations teams by providing detailed information about the workloads running on the containerized platform:

- Review the resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.
- Integrate with [Prometheus](/azure/azure-monitor/containers/container-insights-prometheus-integration) to view application metrics.
- Monitor container workloads deployed to AKS engine on-premises and AKS engine on Azure Stack.
- Monitor container workloads deployed to Azure Red Hat OpenShift.
- Monitor container workloads deployed to Azure Arc enabled Kubernetes (preview).

### Operations compliance

Patching, tuning, and sizing happens at a few different levels in a containerized environment. The operators may sit in a number of different teams, depending on your desired operations approach. To maintain operations compliance, an operator will monitor usage, resize assets to balance performance and cost, and patch the underlying systems to minimize risk and configuration drift. Each of these are tasks that central IT organizations tend to deliver as part of the operations baseline for IaaS and PaaS solutions.

In a cluster environment in Azure, these tasks are performed at multiple levels: AKS cluster, node image, and node OS. All of these operations tasks become more dependent on an understanding and working relationship of the workloads running in the clusters or on individual node pools. The following statements will help evaluate what and if you want to do to operate your container environments.

- If the sizing and patching of the AKS cluster, node image or node OS is delivered as part of the deployment pipeline for the application or is dependent on application architecture or configuration, then it's best to shift operational compliance to the workload team for granular control. Because workloads often take a dependency on orchestration features, this is the most common pattern as an unexpected AKS version change or node image change could be catastrophic to the workload or its runtime tooling.
- For the less common centralized clusters, supporting a portfolio of workloads and a variety of applications, the centralized operations team may still be responsible for operational compliance tasks, the following guides will help deliver those tasks across your clusters. Executing these tasks on a recurring basis instills platform specific operations. There is notable risk in a central operations approach, and careful testing of upgrades in pre-production environments, clear and adhered to scheduled maintenance, and contingency plans for noncompliant workloads all need to be in place. One bad upgrade can be a single point of failure and likewise, one workload not able to upgrade can cause a cluster to fall out of support. Plan and manage multitenant clusters with due diligence.

For both cluster types, follow the guidance on upgrades, node images, and node OS updates found below:

- [Upgrade the AKS cluster](/azure/aks/upgrade-cluster?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Upgrade the node image](/azure/aks/node-image-upgrade?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Process node OS updates](/azure/aks/node-updates-kured?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Patching and upgrade guidance](/azure/architecture/operator-guides/aks/aks-upgrade-practices?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)

### Protect and recover

AKS nodes are ephemeral in nature, and as such are not backed up in a way that can be individually restored. Recovering from an incident may involve redeploying workloads to a new node pool or a whole new cluster depending on the scope of the incident.

- Choose to add an [uptime SLA to your cluster](/azure/aks/uptime-sla).
- For higher SLAs, you may also want to consider [multiregion BCDR best practices](/azure/aks/operator-best-practices-multi-region?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json) to provide additional protection.
- Since clusters should not contain state, external state restoration is handled using existing operations baseline guidance. If you brought state into your clusters ensure your following the [operators best practice on storage](/azure/aks/operator-best-practices-storage?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json), and have a strategy to [back and up restore this data](/azure/aks/operator-best-practices-storage#secure-and-back-up-your-data) for a given workload. Use of tools like [Velero](https://github.com/vmware-tanzu/velero) is an example of platform specific operations, that extend your operations baseline.
  - If your portfolio of applications inconsistently applies state, the central operations team shouldn't try to maintain both solutions. Instead, standardize on the desired-state toolchain for all containers, but shift the responsibility for alternative recovery solutions to workload operations teams. This approach allows design freedom for the developers, keeps central costs lower, and provides a cost-reduction incentive for workload teams to conform to the standard.

## Workload operations

The platform operations section above illustrates a common conversation when managing AKS clusters. Are Kubernetes clusters a technology platform to be managed centrally? Or are they a workload tool that should be managed by the teams who own each of the workloads? That question is different for different organizations. The constant seen across most organizations is that containers and AKS are designed to give the workload teams more flexibility in how they want to operate each workload, and provide specific features for those workloads to use in their architecture to benefit the application's owners and customers.

Workload operations can build on your existing operations baseline and platform-specific operations. You can also safely operate an AKS cluster using completely decentralized workload operations. In either case, when you need to elevate operations to focus on specific outcomes for a specific workload, you can use the [Azure Well-Architected Framework](/azure/architecture/framework/) and [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) to get very specific on the types of operational processes and tools to use for your workload.

## Next step: Your next migration iteration

Once the modern application platform migration is complete, the cloud adoption team can begin your next scenario-specific migration. Alternatively, if there are addition platforms to be migrated, this article series can be used again to guide your next modern application platform migration or deployment.

- [Strategy for modern application platforms](./strategy.md)
- [Plan for modern application platforms](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate workloads to modern application platforms](./migrate.md)
- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
