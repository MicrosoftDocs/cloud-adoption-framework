---
title: Resource organization considerations for AKS
description: AKS guidelines for Resource organization
author: brianblanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank, e2e-aks
---

# Resource organization considerations for AKS

The following considerations and recommendations will help establish proper resource organization and segmentation across management group hierarchies, subscriptions, landing zones, and resource groups. It will also help establish proper tagging strategies to keep resources organized.

## Design considerations

- Decide who will be managing the container hosts:
    - If the hosts are managed centrally, you could reduce the number of landing zone instances and require developers to follow defined processes for deploying the the hosts & using shared dashboards/alerts for workload-level operations
    - If the hosts are managed by the workload teams, you would need more landing zone instances to segment host environments & allow workload teams to control their deployments.
- Decide on a tenancy model for clusters:
    - Workload operated, single tenant: Single cluster host supporting a single workload will likely require a dedicated landing zone to allow for workload team segmentation and control
    - Centrally operated, single tenant: For hostile or regulated workloads which can not be hosted in a multi-tenant host but which are still managed centrally, a dedicated landing zone may not be required
    - Multi-tenant hosts: When hosts are centrally managed, dedicated landing zones are less common. Hosts and workloads are more likely to be sub-divided by resource group. Additionally landing zones may be required if segmentation is required to separate based on region, business unit, environment, criticality, or other external constraints
- Decide on a management group hierarchy based on the general scale and alignment of environments and hosts required to support overall portfolio requirements
    - Flat structure to support a number of dedicated hosts in dedicated environments for decentralized operations run be each workload team
    - Segmented structure to create a management group for centrally managed hosts and a seperate management group for decentralized operations
    - Hierarchial structure further segmenting environments to reflect billing, governance, or operational requirements 
- Decide which container registry topology to use for OCI artifact distribution:
    - One registry per workload
    - One registry per cluster with multiple workloads in the registry
    - One registry per all clusters in the landing zone with multiple workloads and clusters in the same registry
    - One registry per all clusters across multiple landing zones with multiple workloads and clusters in the same registry
- Decide the scope for container registry policies in Azure policy:
    - Set a policy at the subscription level requiring all hosts in the landing zone to use the defined registry
    - Set a more granular policy at the resource group level
    - Set a broader policy at the management group level

## Design recommendations

- Define a [naming and tagging standard](../../ready/azure-best-practices/naming-and-tagging.md) to be applied to all container resources deployed to Azure. At minimum, it should include the following: 
    - Workload name(s): identify the workload or workloads supported by each cluster
    - Cluster resources: identify the elevation of cluster resource alignment from considerations above
    - Host operator: identify which team is responsible for operations of the host
- Implement an Azure Policy to require a specific OCI artifact registry based on your organization's container registry topology
