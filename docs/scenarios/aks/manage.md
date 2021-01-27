---
title: "Manage Kubernetes and containers"
description: Describe the scenario's impact on operations management
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/15/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Manage containers and Kubernetes clusters

The [cloud adoption framework provides a core methodology to define operation management processes](../../manage/index.md) for the cloud in an agnostic sense, along with best practices for establishing an operations management baseline & other specialized layers of operations. That guidance will likely still apply for organizations that have a mixture of Iaas, PaaS, and containerized workloads. This article outlines what you need to integrate into you existing operations to prepare for the management of containers and more specifically the benefits of integrating Azure Kubernetes Service (AKS) into your container management strategy.

## Business alignment for operations management needs

Containers abstract away dependencies on several layers of infrastructure, leading improved operations management capabilities. To realize those operational improvements, you may have to make modifications to your overall cloud management strategy, starting with the business alignment.

To establish proper operations management practices, you must understand how containers will be used in your cloud adoption plans & what benefits you want to realize from this shift to containerized workloads.

- Will you manage multiple technology solutions (containers, IaaS, and PaaS) in your cloud platform?
- Will centralized teams support operations and management of the container or AKS platform? Does that  accountability shift to the individual workload teams?
- Will centralized teams support operations and management of the workloads running in each container or pod? Does that accountability shift to the individual workload teams?
- Are you using containers for mission-critical workloads?
- Are you only using containers for less-critical or utility workloads to reduce costs?
- How important is the performance and reliability of your individual workloads?
- Are the applications in your containers state-less? or do you need to persist state to protect and recover the workloads in the containers?

These basic questions will shape how to best integrate containers & AKS into you operations management strategy.

## Operations baseline

Implementation of a operations baseline will provide centralized access to the tools required to operate and manage all assets in your cloud environment. If you don't already have an operations baseline for your non-container assets, you can implement the [operations baseline defined in the Manage methodology](../../manage/azure-server-management/index.md) to get started with basic operations.

Your operations baseline should include tools and configurations to provide visibility, monitoring, operational compliance, optimization, and protection/recovery.

![Operations management baseline](../../_images/manage/management-baseline.png)

The operations baseline outlined in the articles above will not provide support for your containers or AKS platform. But it will provide the tooling foundation that can be extended to support containers, such as Azure Monitor, Azure Backup, and other tools.

If the majority of your portfolio in the cloud is hosted in containers, you may want to consider including the specialize platform operations in the next section into your operations baseline.

## Platform operations

Unless this is your organizations first or only deployment to the cloud, you should have some form of operations baseline. This section will identify a few additional tools you may want to include to better manage container or AKS deployment.

### Inventory and visibility

Monitoring containers and AKS clusters uses the tools, dashboards, and alerts included in your operations baseline. But you may need to add a bit of additional configuration to get the data from your containers into operations monitoring tools, like [Azure Monitor for Containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json). See the [overview of Azure Monitor for container operators](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json) to gather the data needed to add container and AKS platform operations to your operations baseline.

Once you've configured Azure monitor to collect data on your containers, you'll be able to monitor the following as part of your centralized management processes:

- Identify AKS containers that are running on the node and their average processor and memory utilization. This knowledge can help you identify resource bottlenecks.
- Identify processor and memory utilization of container groups and their containers hosted in Azure Container Instances.
- Identify where the container resides in a controller or a pod. This knowledge can help you view the controller's or pod's overall performance.
- Understand the behavior of the cluster under average and heaviest loads. This knowledge can help you identify capacity needs and determine the maximum load that the cluster can sustain.
- Configure alerts to proactively notify you or record it when CPU and memory utilization on nodes or containers exceed your thresholds, or when a health state change occurs in the cluster at the infrastructure or nodes health rollup.
- Use [queries](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-log-search) to create a common set of alerts, dashboards, and detailed perform detailed analysis

This data will also support workload operations teams by providing more detailed information on each workload running on the containerized platform:

- Review the resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.
- Integrate with [Prometheus](https://prometheus.io/docs/introduction/overview/) to view application and workload metrics it collects from nodes and Kubernetes.
- Monitor container workloads deployed to AKS Engine on-premises and AKS Engine on Azure Stack.
- Monitor container workloads deployed to Azure Red Hat OpenShift.
- Monitor container workloads deployed to Azure Arc enabled Kubernetes (preview).

### Operations compliance

Patching, tuning, and sizing happens at a few different levels in a containerized environment. The operators may sit a number of different teams, depending on your desired operations approach. To maintain operations compliance, an operator will monitor usage, resize assets to balance performance and cost, and patch the underlying systems to minimize risk & configuration drift. Each of these are tasks that central IT organizations tend to deliver as part of the operations baseline for IaaS and PaaS solutions.

In a cluster environment in Azure, these tasks are performed at multiple levels: AKS Cluster, Node Image, and Node OS. Some or all of the operations tasks may become more dependent on an understanding of the workloads running in the clusters or on individual nodes. The following statements will help evaluate what & if you want to do to operate your container environments:

- If the sizing & patching of the AKS Cluster, Node Image or Node OS is delivered as part of the deployment pipeline for the application or is dependent on application architecture/configuration, then it is best to shift operational compliance to the workload team for granular control. See below.
- For centralized clusters, supporting a portfolio of workloads and a variety of applications, the centralized operations team may still be responsible for operational compliance tasks, the following guides will help deliver those tasks across your clusters. Executing these tasks on a recurring basis instills platform specific operations:
    - [Upgrade the AKS Cluster](https://docs.microsoft.com/azure/aks/upgrade-cluster?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
    - [Upgrade the Node image](https://docs.microsoft.com/azure/aks/node-image-upgrade?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
    - [Process Node OS updates](https://docs.microsoft.com/azure/aks/node-updates-kured?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)

### Protect & Recover

To recover from an incident, you will need basic backup and recovery capabilities in your operations baseline. But the right option for recovery will depend on your storage decisions. The [operators best practice on storage](https://docs.microsoft.com/azure/aks/operator-best-practices-storage?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json) will help find the right storage approach. One critical decision in that article concerns the management of state for the applications in your container:

- If all of the applications in a container are state-less, the standard Azure Backup approach in the operations baseline may give you enough protection to backup your containers & recover in case of failure. But those backups should be tested regularly to ensure adequate protection. For higher SLAs, you may also want to consider [multi-region BCDR best practices](https://docs.microsoft.com/azure/aks/operator-best-practices-multi-region.md?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json) to provide additional protection.
- If you can't separate state from any of the applications, you will require additional configuration for backup and recovery. The [operators guide](https://docs.microsoft.com/azure/aks/operator-best-practices-storage#secure-and-back-up-your-data) also provides information on additional backup options. Use of tools like [Velero](https://github.com/heptio/velero) to support all containers or AKS clusters is an example of platform specific operations, that extend your operations baseline.
- If your portfolio of applications inconsistently applies state, it is advised that the central operations team not attempt to maintain both solutions. Instead, standardize on the desired-state toolchain for all containers, but shift the responsibility for alternative recovery solutions to workload operations teams. This approach allows design freedom for the developers, keeps central costs lower, & provides a cost reduction incentive for workload teams to conform to the standard.

## Workload operations

The platform operations section above illustrates a common conversation when managing containers and AKS. Are containers a technology platform to be managed centrally? Or are they a workload tool that should be managed by the teams who own each of the workloads? That question is different for different organizations. The constant seen across most organizations is that containers and AKS are designed to give the workload teams more flexibility in how they want to operate each workload.

Workload operations can build on your existing operations baseline & platform-specific operations. You can also safely operate an AKS cluster using completely decentralized workload operations. In either case, when you need to elevate operations to focus on specific outcomes for a specific workload, you can use the [Well-Architected Framework](https://docs.microsoft.com/azure/architecture/framework) and [Well-Architected Review](https://aka.ms/architecture/review) to get very specific on the types of operational processes and tools to use for your workload.

## Next step: Your next migration iteration

Once the Kubernetes and containers migration is complete, the cloud adoption team can begin your next scenario-specific migration. Alternatively, if there are addition platforms to be migrated, this article series can be used again to guide your next Kubernetes and containers migration or deployment.

- [Strategy for Kubernetes and containers](./strategy.md)
- [Plan for Kubernetes and containers](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate Kubernetes and containers](./migrate.md)
- [Innovate with Kubernetes and containers](./innovate.md)
- [Govern Kubernetes and containers](./govern.md)
- [Manage Kubernetes and containers](./manage.md)