---
title: Resource organization considerations for ARO
description: ARO guidelines for resource organization
author: rolandotorio
ms.author: rolandotorio
ms.date: 06/14/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-ARO
---

# Resource organization considerations for ARO (optional)

Resource organization consideration is mostly managed by the platform foundation, however here are some of the ways the platform foundation may affect ARO landing zone accelerator.

The overall subscription and resource group design determined by generic Azure landing zone recommendations, will play a fundamental role in how the ARO resource organization is managed. As described in [Management group and subscription organization](../../ready/landing-zone/design-area/resource-org.md), management groups and subscriptions are used to assign policies to the resources underneath them, and subscriptions are the management boundary for governance and isolation of resources.

For example, if you have public and private applications, separate them into different subscriptions, named `Corp` and `Online`, and assign different policies to each subscription. The `Corp` subscriptions have policies that prevent the creation of public IP addresses. The `Online` subscriptions allow internet connectivity. For more information about which policies are applied at which level in an Azure landing zone design, including ARO-specific policies, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).

## Design considerations

- Decide who will be managing the container hosts:

  - If the hosts are managed centrally, you can reduce the number of landing zone instances and require developers to follow defined processes for deploying the hosts and using shared dashboards and alerts for workload-level operations.

  - If workload teams manage the hosts, you'll need more landing zone instances to segment host environments and allow workload teams to control their deployments.

  - In both cases, you extend this consideration to adjacent and related resources such as web application firewalls, key vaults, pipeline build agents, and potentially jump boxes.

- Choose a tenancy model for clusters:

  - **Workload operated, single tenant:** Single cluster host supporting a single workload will likely require a dedicated landing zone to allow for workload team segmentation and control.

  - **Centrally operated, multitenant hosts:** When hosts are centrally managed, operational efficiency comes from consolidation of multiple hosts and multiple workloads in shared landing zone environments. This consolidation reduces the number of landing zones and hosts dedicated to the support of a single cluster or workload.

    Additional landing zones might be required if segmentation is required to separate based on region, business unit, environment, criticality, or other external constraints.

  - **Centrally operated, single tenant** for hostile or regulated workloads that are still centrally operated, it's common to have dedicated hosts for those workloads. You might still experience operational efficiency by consolidating supporting landing zones.

- Choose a management group hierarchy based on the general scale and alignment of environments and hosts required to support overall portfolio requirements:

  - Flat structure to support many dedicated hosts in dedicated environments for decentralized operations run be each workload team.
  - Segmented structure to create a management group for centrally managed hosts and a separate management group for decentralized operations.
  - Hierarchical structure further segmenting environments to reflect billing, governance, or operational requirements.

- Decide which Container Registry to use:

  - Implement Internal OpenShift Registry, taking into consideration the following:
    - Configuration of the built-in [OpenShift Container Registry](https://docs.microsoft.com/en-us/azure/openshift/built-in-container-registry).
    - Use of [Red Hat Quay Registry](https://access.redhat.com/documentation/en-us/red_hat_quay/3.7) for enterprise-quality container registry.
  - Implement [Azure Containter Registry](https://docs.microsoft.com/en-us/azure/openshift/howto-use-acr-with-aro), taking into consideration the following:  
    - [Container registry best practices](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-best-practices).
    - Use of [Quarantine pattern](https://github.com/AzureCR/QuarantinePattern-Spec) to assure the registry only contains images that have been vulnerability scanned.
  - or, Third Party Container Registry.

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
