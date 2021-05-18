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

  - If the hosts are managed centrally, you could reduce the number of landing zone instances and require developers to follow defined processes for deploying the hosts & using shared dashboards/alerts for workload-level operations
  - If the hosts are managed by the workload teams, you would need more landing zone instances to segment host environments & allow workload teams to control their deployments.
  - In both cases, you'll need to extend this consideration to adjacent and related resources such as web application firewalls, key vaults, pipeline build agents, and potentially jump boxes.

- Choose a tenancy model for clusters:

  - Workload operated, single tenant: Single cluster host supporting a single workload will likely require a dedicated landing zone to allow for workload team segmentation and control.
  - Centrally operated, multi-tenant hosts: When hosts are centrally managed, operational efficiency comes from consolidation of multiple hosts and multiple workloads in shared landing zone environments. This reduces the number of landing zones and hosts dedicated to the support of a single cluster &/or workload.

    Additional landing zones may be required if segmentation is required to separate based on region, business unit, environment, criticality, or other external constraints.

  - Centrally operated, single tenant: For hostile or regulated workloads which are still centrally operated, it's common to have dedicated hosts for those workloads. But you may still experience operational efficiency by consolidating the number of supporting landing zones.

- Choose a management group hierarchy based on the general scale and alignment of environments and hosts required to support overall portfolio requirements:

  - Flat structure to support a number of dedicated hosts in dedicated environments for decentralized operations run be each workload team
  - Segmented structure to create a management group for centrally managed hosts and a separate management group for decentralized operations
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

- Define a [naming and tagging standard](../../ready/azure-best-practices/naming-and-tagging.md) to be applied to all container resources deployed to Azure. At a minimum, it should include:

  - **Workload names:** Identify the workload or workloads supported by each cluster.
    - **Cluster resources:** Identify the elevation of cluster resource alignment from the preceding considerations.
    - **Host operator:** Identify which team is responsible for operations of the host.

- Implement a policy to require a specific OCI artifact registry based on your organization's container registry topology.
