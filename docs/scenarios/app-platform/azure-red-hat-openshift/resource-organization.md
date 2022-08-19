---
title: Resource organization considerations for Azure Red Hat OpenShift
description: Review guidelines for resource organization in Azure Red Hat OpenShift
author: rotorr
ms.author: rolandotorio
ms.date: 08/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-ARO
---

# Resource organization considerations for Azure Red Hat OpenShift (optional)

Resource organization consideration is mostly managed by the platform foundation. Here are some ways the platform foundation might affect your Azure Red Hat OpenShift landing zone accelerator.

The overall subscription and resource group design determined by generic Azure landing zone recommendations plays a fundamental role in how you manage your Azure Red Hat OpenShift resource organization. As described in [Management group and subscription organization](../../../ready/landing-zone/design-area/resource-org.md), use management groups and subscriptions to assign policies to the resources underneath them. Subscriptions are the management boundary for resource governance and isolation.

For example, if you have public and private applications, separate them into different subscriptions named `Corp` and `Online`. Assign different policies to each subscription. The `Corp` subscription has policies that prevent users from creating public IP addresses. The `Online` subscription allows internet connectivity. For more information about which policies are applied at the different levels of an Azure landing zone design, including Azure Red Hat OpenShift-specific policies, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).

## Design considerations

- Decide who will be managing the container hosts:

  - If the hosts are centrally managed, you can reduce the number of landing zone instances and require developers to follow defined processes to deploy hosts and use shared dashboards and alerts for workload-level operations.

  - If workload teams manage the hosts, you'll need more landing zone instances to segment host environments and allow workload teams to control their deployments.

  - In both cases, you extend this consideration to adjacent and related resources like web application firewalls, key vaults, pipeline build agents, and potentially jump boxes.

- Choose a tenancy model for clusters:

  - **Workload-operated, single tenant:** A single cluster host that supports a single workload likely requires a dedicated landing zone for workload team segmentation and control.

  - **Centrally operated, multitenant hosts:** When hosts are centrally managed, operational efficiency comes from consolidating multiple hosts and multiple workloads in shared landing zone environments. This consolidation reduces the number of landing zones and hosts that are dedicated to the support of a single cluster or workload.

    Adding landing zones might be required if segmentation is required to separate based on region, business unit, environment, criticality, or other external constraints.

  - **Centrally operated, single tenant:** For hostile or regulated workloads that are still centrally operated, it's common to have dedicated hosts for the workloads. You might still experience operational efficiency by consolidating supporting landing zones.

- Choose a management group hierarchy that's based on the general scale and alignment of environments and hosts that are required to support overall portfolio requirements:

  - Flat structure to support many dedicated hosts in dedicated environments for decentralized operations run by each workload team.
  - Segmented structure to create a management group for centrally managed hosts and a separate management group for decentralized operations.
  - Hierarchical structure to further segment environments to reflect billing, governance, or operational requirements.

- Decide which container registry to use:

  - Implement Internal OpenShift Registry. Consider these factors:
    - Configuring the built-in [OpenShift Container Registry](/azure/openshift/built-in-container-registry)
    - Using [Red Hat Quay Registry](https://access.redhat.com/documentation/red_hat_quay/3.7) for an enterprise-quality container registry
  - Implement [Azure Container Registry](/azure/openshift/howto-use-acr-with-aro). Consider these factors:  
    - Using [container registry best practices](/azure/container-registry/container-registry-best-practices)
    - Using a [quarantine pattern](https://github.com/AzureCR/QuarantinePattern-Spec) to ensure that the registry contains only images that have been vulnerability-scanned
  - A third-party container registry

- Decide which container registry topology to use for OCI artifact distribution:

  - One registry per workload.
  - One registry per cluster with multiple workloads in the registry.
  - One registry per all clusters in the landing zone with multiple workloads and clusters in the same registry.
  - One registry per all clusters across multiple landing zones with multiple workloads and clusters in the same registry.

- Decide the scope for container registry policies in Azure Policy:

  - Set a policy at the subscription level to require all hosts in the landing zone to use the defined registry.
  - Set a more granular policy at the resource group level.
  - Set a broader policy at the management group level.

## Design recommendations

- Define a [naming and tagging standard](../../../ready/azure-best-practices/naming-and-tagging.md) to apply to all container resources deployed to Azure. At a minimum, the standard should include:
  - **Workload names:** The workload or workloads each cluster supports.
  - **Cluster resources:** The elevation of cluster resource alignment from the preceding considerations.
  - **Host operator:** Which team is responsible for host operations.
- Implement a policy to require a specific OCI artifact registry that's based on your organization's container registry topology.

## Next steps

- Review [security recommendations for Azure Red Hat OpenShift](security.md).
