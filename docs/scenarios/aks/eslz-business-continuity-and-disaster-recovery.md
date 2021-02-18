---
title: Enterprise-scale business continuity and disaster recovery for Azure Kubernetes Service
description: Describe how this enterprise-scale scenario can improve business continuity and disaster recovery of Azure Kubernetes Service.
author: JeffMitchell
ms.author: jemitche
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise-scale business continuity and disaster recovery for Azure Kubernetes Service

Your organization needs to design suitable Azure Kubernetes Service (AKS) platform-level capabilities to meet its specific requirements. These application services have requirements related to recovery time objective (RTO) and recovery point objective (RPO). There are multiple considerations to address for AKS disaster recovery. Your first step is to define a service-level agreement (SLA) for infrastructure and your application. AKS has information about monthly uptime calculations. Learn about the [SLA for Azure Kubernetes Service (AKS)](https://azure.microsoft.com/support/legal/sla/kubernetes-service/v1_1/).

## Design considerations

Consider the following factors:

- AKS Cluster nodes should use multiple nodes in a node pool to provide the minimum level of availability for your application.

- [Set pod requests and limits.](/azure/aks/developer-best-practices-resource-management#define-pod-resource-requests-and-limits) Setting these limits lets Kubernetes efficiently give CPU and memory resources to the pods and have higher container density on a node. Limits can also increase reliability with reduced costs because of better use of hardware.

- AKS suitability for Availability Zones or availability sets.

  - Choose a Region that Support availability zones.

  - Availability zones can only be set when the node pool is created and can't be changed later. Multi-zone support only applies to node pools.

  - For complete zonal benefit, all service dependencies must also support zones. If a dependent service doesn't support zones, it's possible that a zone failure could cause that service to fail.
  
  - For higher availability beyond availability zones run multiple AKS clusters, in different paired regions. If an Azure resource supports geo-redundancy, provide the location where the redundant service will have its secondary.

- You should be aware of guidelines for disaster recovery in AKS. Then consider whether they apply to the AKS clusters that you use for Azure Dev Spaces.

- Consistent backups for applications and data.

  - A non-stateful service can be replicated efficiently. If you need to store state in the cluster (not recommended), make sure you back up the data frequently in the paired region.

- Cluster update and maintenance.

  - Always keep your cluster up to date. Be aware of the release and deprecation process, plan your updates and maintenance in advance.

- Network connectivity if a failover occurs.

  - Choose a traffic router that can distribute traffic across zones or regions, depending on your requirement. This architecture deploys Azure Load Balancer because it can distribute non-web traffic across zones. If you need to distribute traffic across regions, Azure Front Door should be considered. For other considerations, see Choose a load balancer.

- Planned and unplanned failovers.

  - When setting up each Azure service, choose features that support disaster recovery. For example, in this architecture, Azure Container Registry is enabled for geo-replication. If a region goes down, you can still pull images from the replicated region.

  - Maintained engineering DevOps capabilities for Service level goals.
- Consider if you need a [financially backed (SLA)](/azure/aks/uptime-sla) for Kubernetes API server.

## Design recommendations

The following are best practices for your design:

- Three nodes are recommended for the system node pool. For the user node pool, start with no less than two nodes. If you need higher availability, set up more nodes.

- Isolate your application from the system services by placing it in a separate node pool. This way, Kubernetes services run on dedicated nodes and don’t compete with your workload. Use of tags, labels, and taints is recommended to identify the node pool to schedule your workload.

- Regular upkeep of your cluster like timely updates is crucial for reliability. Be mindful of [supported window of Kubernetes versions on AKS](/azure/aks/supported-kubernetes-versions) and plan your updates in advance. Also, monitoring the health of the pods through probes is recommended.

- Where possible, don't [store service state inside the container.](/azure/aks/operator-best-practices-multi-region#remove-service-state-from-inside-containers) Instead, use an Azure platform as a service (PaaS) that supports multiregion replication.

- Ensure pod resources. It’s highly recommended that deployments specify pod resource requirements. The scheduler can then appropriately schedule the pod. Reliability significantly depreciates if pods cannot be scheduled.

- Set up multiple replicas in the deployment to handle disruptions like hardware failures. For planned events like updates and upgrades, a disruption budget can ensure the required number of pod replicas exist to handle expected application load.

- [Your applications might use Azure Storage for their data.](/azure/aks/operator-best-practices-multi-region#create-a-storage-migration-plan) Because your applications are spread across multiple AKS clusters in different regions, you need to keep the storage synced. Here are two common ways to replicate storage:

  - Infrastructure-based asynchronous replication
  - Application-based asynchronous replication

- Estimate Pod limits. Test and establish a baseline. Start with equal values for requests and limits. Then, gradually tune those values until you've established a threshold that can cause instability in the cluster. Pod Limits can be specified in your deployment manifests.

  The built-in features provide a solution to the complex task of handling failures and disruptions in service architecture. These configurations help simplifying both design and deployment automation. An organization that has defined a standard for the SLA, RTO, and RPO on an application can use built-in services to kubernetes and Azure to achieve these business goals.

- Set [pod disruption budgets.](/azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets) This setting checks how many replicas in a deployment can come down during an update or upgrade event.

- [Enforce resource quotas](/azure/aks/operator-best-practices-scheduler#enforce-resource-quotas) on the service namespaces. The resource quota on a namespace will ensure pod requests and limits are properly set on a deployment.

  - Setting resources quotas at the cluster level can cause problem when deploying third-party services that don't have proper requests and limits.
  
- Regularly run the latest version of [kube-advisor open source tool to detect issues in your cluster.](/azure/aks/operator-best-practices-scheduler#regularly-check-for-cluster-issues-with-kube-advisor)

- [Store your container images in Azure Container Registry](/azure/aks/operator-best-practices-multi-region#enable-geo-replication-for-container-images) and geo-replicate the registry to each AKS region.

  AKS can be used as a free service, but that tier doesn't offer a financially backed SLA. To get that SLA, you must choose to add an Uptime SLA to your what you buy. We recommend all production clusters use this option. Reserve clusters without this option for pre-production clusters. When combined with Azure Availability Zones, the Kubernetes API server SLA is increased to 99.95%. Your node pools, and other resources are covered under their own SLA.

- Use multiple regions and peering locations for ExpressRoute connectivity.

  A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity if an outage affecting an Azure region or peering provider location occurs.
  
- [Interconnect regions with global virtual network peering](/azure/aks/operator-best-practices-multi-region) clusters need to talk to each other, connecting both virtual networks to each other can be achieved through virtual network peering. This technology interconnects virtual networks to each other providing high bandwidth across Microsoft's backbone network, even across different geographic regions.

- [Using split TCP-based anycast protocol](/azure/aks/operator-best-practices-multi-region), Azure Front Door Service ensures that your end users promptly connect to the nearest Front Door POP (Point of Presence). Other features of Azure Front Door Service include TLS termination, custom domain, web application firewall, URL Rewrite, and session affinity. Review the needs of your application traffic to learn which solution is the most suitable.
