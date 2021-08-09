---
title: Resource organization considerations for AKS
description: AKS guidelines for resource organization
author: brianblanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Resource organization considerations for AKS

The following considerations and recommendations will help establish proper resource organization and segmentation across management group hierarchies, subscriptions, landing zones, and resource groups. It will also help establish proper tagging strategies to keep resources organized.

The overall subscription and resource group design determined by generic enterprise-scale landing zone recommendations, will play a fundamental role in how the AKS resource organization is managed. As described in [Management group and subscription organization](../../ready/enterprise-scale/management-group-and-subscription-organization.md), management groups and subscriptions are used to assign policies to the resources underneath them, and subscriptions are the management boundary for governance and isolation of resources.

For example, if you have public and private applications, it's recommended to separate them into different subscriptions, named "Corp" and "Online", which will be associated to different policies. The "Corp" subscriptions will have policies that prevent the creation of public IP addresses. The "Online" subscriptions will allow internet connectivity. The document [Policies included in enterprise-scale landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md), describes in the detail which policies you apply at which level in an enterprise-scale landing zone design, including AKS-specific policies.

## Design considerations

- Decide who will be managing the container hosts:
  - If the hosts are managed centrally, you can reduce the number of landing zone instances and require developers to follow defined processes for deploying the hosts and using shared dashboards and alerts for workload-level operations.
  - If workload teams manage the hosts, you'll need more landing zone instances to segment host environments and allow workload teams to control their deployments.
  - In both cases, you extend this consideration to adjacent and related resources such as web application firewalls, key vaults, pipeline build agents, and potentially jump boxes.
- Choose a tenancy model for clusters:
  - **Workload operated, single tenant:** Single cluster host supporting a single workload will likely require a dedicated landing zone to allow for workload team segmentation and control.
  - **Centrally operated, multitenant hosts:** When hosts are centrally managed, operational efficiency comes from consolidation of multiple hosts and multiple workloads in shared landing zone environments. This consolidation reduces the number of landing zones and hosts dedicated to the support of a single cluster or workload.
    Additional landing zones might be required if segmentation is required to separate based on region, business unit, environment, criticality, or other external constraints.
  - **Centrally operated, single tenant** For hostile or regulated workloads that are still centrally operated, it's common to have dedicated hosts for those workloads. You might still experience operational efficiency by consolidating supporting landing zones.
- Choose a management group hierarchy based on the general scale and alignment of environments and hosts required to support overall portfolio requirements:
  - Flat structure to support many dedicated hosts in dedicated environments for decentralized operations run be each workload team.
  - Segmented structure to create a management group for centrally managed hosts and a separate management group for decentralized operations.
  - Hierarchical structure further segmenting environments to reflect billing, governance, or operational requirements.
- Decide which container registry topology to use for OCI artifact distribution:
  - One registry per workload.
  - One registry per cluster with multiple workloads in the registry.
  - One registry per all clusters in the landing zone with multiple workloads and clusters in the same registry.
  - One registry per all clusters across multiple landing zones with multiple workloads and clusters in the same registry.
- Decide the scope for container registry policies in Azure Policy:
  - Set a policy at the subscription level requiring all hosts in the landing zone to use the defined registry.
  - Set a more granular policy at the resource group level.
  - Set a broader policy at the management group level.

## Design recommendations

- Define a [naming and tagging standard](../../ready/azure-best-practices/naming-and-tagging.md) to be applied to all container resources deployed to Azure. At a minimum, it should include:
  - **Workload names:** Identify the workload or workloads supported by each cluster.
    - **Cluster resources:** Identify the elevation of cluster resource alignment from the preceding considerations.
    - **Host operator:** Identify which team is responsible for operations of the host.
- Implement a policy to require a specific OCI artifact registry based on your organization's container registry topology.