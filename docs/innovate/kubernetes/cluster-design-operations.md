---
title: Cluster design and operations
description: Learn about Kubernetes in the Cloud Adoption Framework for cluster design, network design, and operations.
author: sabbour
ms.author: brblanch
ms.date: 04/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank, seo-caf-innovate
keywords: Network design, cluster design, infrastructure provisioning, kubernetes
---

<!-- cSpell:ignore autoscaler PDBs -->

# Cluster design and operations

This article covers cluster configuration and network design. Learn how to future-proof scalability by automating infrastructure provisioning. Provisioning is the process of setting up the IT infrastructure that you want. Automated infrastructure provisioning supports a remote installation and sets up virtual environments. It also helps you maintain high availability by planning for business continuity and disaster recovery.

## Plan, train, and proof

As you get started, the checklist and Kubernetes resources below will help you plan the cluster design. By the end of this section, you'll be able to answer these questions:

> [!div class="checklist"]
>
> - Have you identified the networking design requirements for your cluster?
> - Do you have services with varying requirements? How many node pools are you going to use?

**Checklist:**

- **Identify network design considerations.** Understand cluster network design considerations, compare network models, and choose the Kubernetes networking plug-in that fits your needs. For Azure container networking interface (CNI) networking, consider the number of IP addresses required as a multiple of the maximum pods per node (default of 30) and number of nodes. Add one node required during upgrade. When choosing load balancer services, consider using an ingress controller when there are too many services to reduce the number of exposed endpoints. For Azure CNI, the service CIDR has to be unique across the virtual network and all connected virtual networks to ensure appropriate routing.

  To learn more, see:
  - [Kubenet and Azure CNI networking](/azure/aks/concepts-network#azure-virtual-networks)
  - [Use kubenet networking with your own IP address ranges in Azure Kubernetes Service (AKS)](/azure/aks/configure-kubenet)
  - [Configure Azure CNI networking in Azure Kubernetes Service (AKS)](/azure/aks/configure-azure-cni)
  - [Secure network design for an AKS cluster](https://github.com/Azure/sg-aks-workshop/blob/master/cluster-design/NetworkDesign.md)

- **Create multiple node pools.** To support applications that have different compute or storage demands, you can optionally configure your cluster with multiple node pools. For example, use more node pools to provide GPUs for compute-intensive applications or access to high-performance SSD storage. For more information, see [Create and manage multiple node pools for a cluster in Azure Kubernetes Service](/azure/aks/use-multiple-node-pools).

- **Decide on availability requirements.** A minimum of two pods behind Azure Kubernetes Service ensures high availability of your application if there is pod failures or restarts. Use three or more pods to handle load during pod failures and restarts. For the cluster configuration, a minimum of two nodes in an availability set or virtual machine scale set is required to meet the service-level agreement of 99.95%. Use at least three pods to ensure pod scheduling during node failures and reboots.

  To provide a higher level of availability to your applications, clusters can be distributed across Availability Zones. These zones are physically separate datacenters within a given region. When the cluster components are distributed across multiple zones, your cluster can tolerate a failure in one of the zones. Your applications and management operations remain available even if an entire datacenter experiences an outage. For more information, see [Create an Azure Kubernetes Service (AKS) cluster that uses Availability Zones](/azure/aks/availability-zones).

## Go to production and apply infrastructure best practices

As you prepare the application for production, implement a minimum set of best practices. Use this checklist at this stage. By the end of this section, you'll be able to answer these questions:

> [!div class="checklist"]
>
> - Are you able to confidently redeploy the cluster infrastructure?
> - Have you applied resource quotas?

**Checklist:**

- **Automate cluster provisioning.** With infrastructure as code, you can automate infrastructure provisioning to provide more resiliency during disasters and gain agility to quickly redeploy the infrastructure as needed. For more information, see [Create a Kubernetes cluster with Azure Kubernetes Service using Terraform](/azure/developer/terraform/create-k8s-cluster-with-tf-and-aks).

- **Plan for availability using pod disruption budgets.** To maintain the availability of applications, define pod disruption budgets (PDB) to ensure that a minimum number of pods are available in the cluster during hardware failures or cluster upgrades. To learn more, see [Plan for availability using pod disruption budgets](/azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets).

- **Enforce resource quotas on namespaces.** Plan and apply resource quotas at the namespace level. Quotas can be set on compute resources, storage resources, and object count. For more information, see [Enforce resource quotas](/azure/aks/operator-best-practices-scheduler#enforce-resource-quotas).

## Optimize and scale

Once the application is in production, how can you optimize your workflow and prepare your application and team to scale? Use the optimization and scaling checklist to prepare. By the end of this section, you'll be able to answer these questions:

> [!div class="checklist"]
>
> - Do you have a plan for business continuity and disaster recovery?
> - Can your cluster scale to meet application demands?
> - Are you able to monitor your cluster and application health and receive alerts?

**Checklist:**

- **Automatically scale a cluster to meet application demands.** To keep up with application demands, you may need to adjust the number of nodes that run your workloads automatically using the cluster autoscaler. For more information, see [Configure Kubernetes cluster autoscaler](/azure/aks/cluster-autoscaler).

- **Plan for business continuity and disaster recovery.** Plan for multiregion deployment, create a storage migration plan, and enable geo-replication for container images. To learn more, see [Best practices for region deployments](/azure/aks/operator-best-practices-multi-region) - [Azure Container Registry geo-replication](/azure/container-registry/container-registry-geo-replication).

- **Configure monitoring and troubleshooting at scale.** Set up alerting and monitoring for applications in Kubernetes. Learn about the default configuration, how to integrate more advanced metrics, and how to add custom monitoring and alerting to operate your application.

  - [Get started with monitoring and alerting for Kubernetes (video)](https://www.youtube.com/watch?v=W7aN_z-cyUw&list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&index=16)
  - [Configure alerts using Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview)
  - [Review diagnostic logs for master components](/azure/aks/view-control-plane-logs)
  - [Azure Kubernetes Service (AKS) diagnostics](/azure/aks/concepts-diagnostics)
