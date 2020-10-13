---
title: Cluster design and operations
description: Learn about Kubernetes in the Cloud Adoption Framework for cluster design and operations.
author: sabbour
ms.author: asabbour
ms.date: 12/16/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

<!-- cSpell:ignore autoscaler PDBs -->

# Cluster design and operations

Identify for cluster configuration and network design. Future-proof scalability by automating infrastructure provisioning. Maintain high availability by planning for business continuity and disaster recovery.

## Plan, train, and proof

As you get started, the checklist and resources below will help you plan the cluster design. You should be able answer these questions:

> [!div class="checklist"]
>
> - Have you identified the networking design requirements for your cluster?
> - Do you have workloads with varying requirements? How many node pools are you going to use?

<!-- -->

> [!div class="tdCol2BreakAll"]
>
> | Checklist  | Resources |
> |------------------------------------------------------------------|-----------------------------------------------------------------|
> | **Identify network design considerations.** Understand cluster network design considerations, compare network models, and choose the Kubernetes networking plug-in that fits your needs. For the Azure container networking interface (CNI), consider the number of IP addresses required as a multiple of the maximum pods per node (default of 30) and number of nodes. Add one node required during upgrade. When choosing load balancer services, consider using an ingress controller when there are too many services to reduce the number of exposed endpoints. For Azure CNI, the service CIDR has to be unique across the virtual network and all connected virtual networks to ensure appropriate routing. | <li> [Kubenet&nbsp;and&nbsp;Azure&nbsp;Container&nbsp;Networking&nbsp;Interface&nbsp;(CNI)](/azure/aks/concepts-network#azure-virtual-networks) <li>  [Use kubenet networking with your own IP address ranges in Azure Kubernetes Service (AKS)](/azure/aks/configure-kubenet) <li> [Configure Azure CNI networking in Azure Kubernetes Service (AKS)](/azure/aks/configure-azure-cni) <li>  [Secure network design for an AKS cluster](https://github.com/Azure/sg-aks-workshop/blob/master/cluster-design/NetworkDesign.md)|
> | **Create multiple node pools.** To support applications that have different compute or storage demands, you can optionally configure your cluster with multiple node pools. For example, use additional node pools to provide GPUs for compute-intensive applications or access to high-performance SSD storage.   | <li> [Create&nbsp;and&nbsp;manage&nbsp;multiple&nbsp;node&nbsp;pools&nbsp;for a cluster in Azure Kubernetes Service](/azure/aks/use-multiple-node-pools) |
> | **Decide on availability requirements.** A minimum of two pods behind Azure Kubernetes Service ensures high availability of your application in case of pod failures or restarts. Use three or more pods to handle load during pod failures and restarts. For the cluster configuration, a minimum of 2 nodes in an availability set or virtual machine scale set is required to meet the service-level agreement of 99.95%. Use at least three pods to ensure pod scheduling during node failures and reboots. To provide a higher level of availability to your applications, clusters can be distributed across availability zones. These zones are physically separate datacenters within a given region. When the cluster components are distributed across multiple zones, your cluster is able to tolerate a failure in one of those zones. Your applications and management operations remain available even if an entire datacenter experiences an outage. | <li> [Create an Azure Kubernetes Service (AKS) cluster that uses availability zones](/azure/aks/availability-zones) |

## Go to production and apply best practices

As you prepare the application for production, you should implement a minimum set of best practices. Use the checklist below at this stage. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Are you able to confidently redeploy the cluster infrastructure?
> - Have you applied resource quotas?

<!-- -->

> [!div class="tdCol2BreakAll"]
>
> | Checklist  | Resources                                                                                                     |
> |------------------------------------------------------------------|-----------------------------------------------------------------|
> | **Automate cluster provisioning.** With infrastructure as code, you can automate infrastructure provisioning to provide more resiliency during disasters and gain agility to quickly redeploy the infrastructure as needed.  | <li> [Create a Kubernetes cluster with Azure Kubernetes Service using Terraform](/azure/terraform/terraform-create-k8s-cluster-with-tf-and-aks)|
> | **Plan for availability using pod disruption budgets.** To maintain the availability of applications, define pod disruption budgets (PDBs) to ensure that a minimum number of pods are available in the cluster during hardware failures or cluster upgrades. | <li> [Plan&nbsp;for&nbsp;availability&nbsp;using&nbsp;pod&nbsp;disruption&nbsp;budgets](/azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets)  |
> | **Enforce resource quotas on namespaces.** Plan and apply resource quotas at the namespace level. Quotas can be set on compute resources, storage resources, and object count.| <li> [Enforce resource quotas](/azure/aks/operator-best-practices-scheduler#enforce-resource-quotas)  |

## Optimize and scale

Now that the application is in production, how can you optimize your workflow and prepare your application and team to scale? Use the optimization and scaling checklist to prepare. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Do you have a plan for business continuity and disaster recovery?
> - Can your cluster scale to meet application demands?
> - Are you able to monitor your cluster and application health and receive alerts?

<!-- -->

> [!div class="tdCol2BreakAll"]
>
> | Checklist | Resources |
> |--|--|
> | **Automatically scale a cluster to meet application demands.** To keep up with application demands, you may need to adjust the number of nodes that run your workloads automatically using the cluster autoscaler. | <li> [Configure Kubernetes cluster autoscaler](/azure/aks/cluster-autoscaler) |
> | **Plan for business continuity and disaster recovery.** Plan for multiregion deployment, create a storage migration plan, and enable geo-replication for container images. | <li> [Best practices for region deployments](/azure/aks/operator-best-practices-multi-region) <li>  [Azure Container Registry geo-replication](/azure/container-registry/container-registry-geo-replication) |
> | **Configure monitoring and troubleshooting at scale.** Set up alerting and monitoring for applications in Kubernetes. Learn about the default configuration, how to integrate more advanced metrics, and how to add your own custom monitoring and alerting to reliably operate your application. | <li> [Get started with monitoring and alerting for Kubernetes (video)](https://www.youtube.com/watch?v=W7aN_z-cyUw&list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&index=16) <li> [Configure alerts using Azure Monitor for containers](/azure/azure-monitor/insights/container-insights-overview) <li> [Review&nbsp;diagnostic&nbsp;logs&nbsp;for&nbsp;master&nbsp;components](/azure/aks/view-master-logs) <li> [Azure Kubernetes Service (AKS) diagnostics](/azure/aks/concepts-diagnostics) |
