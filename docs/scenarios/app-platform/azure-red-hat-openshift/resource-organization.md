---
title: Resource organization considerations for Azure Red Hat OpenShift
description: Review guidelines for resource organization in Azure Red Hat OpenShift
author: rotorr
ms.author: rolandotorio
ms.date: 08/19/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-ARO, linux-related-content
---

# Resource organization considerations for Azure Red Hat OpenShift (optional)

Resource organization is mostly managed by the platform foundation. Here are some ways the platform foundation might affect your Azure Red Hat OpenShift landing zone accelerator.

Subscription and resource group design are key considerations in generic Azure landing zone recommendations. They play a fundamental role in how you manage your Azure Red Hat OpenShift resource organization. Subscriptions are the management boundary for resource governance and isolation. As described in [Management group and subscription organization](../../../ready/landing-zone/design-area/resource-org.md), use subscriptions and management groups to assign policies to the resources within the boundaries.

For example, if you have public and private applications, separate them into different subscriptions, and place them into the appropriate Management Groups named `Corp` and `Online`, or other Management Groups beneath Landing Zones. The subscriptions that live within the `Corp` Management Group have policies that prevent the creation of public IP addresses. The subscriptions that live beneath the `Online` Management Groups allow internet connectivity and public access directly. For more information about which policies are applied at the different levels of an Azure landing zone design, including ARO-specific policies, see [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).

## Design considerations

- Decide who will manage container hosts:

  - If the hosts are centrally managed, you can reduce the number of landing zone instances. Require developers to follow defined processes to deploy hosts and use shared dashboards and alerts for workload-level operations.

  - If workload teams manage the hosts, you need more landing zone instances to segment host environments. Workload teams can control their deployments.

  - Whether hosts are managed centrally by workload teams, extend this consideration to adjacent and related resources like web application firewalls, key vaults, pipeline build agents, and potentially to jump boxes.

- Choose a tenancy model for clusters:

  - **Workload team-operated, single tenant:** A single cluster host that supports a single workload likely requires a dedicated landing zone for workload team segmentation and control.

  - **Technology platforms, multitenant hosts:** When hosts are centrally managed, operational efficiency comes from consolidating multiple hosts and multiple workloads in shared landing zone subscriptions. Consolidation reduces the number of landing zones and hosts that are dedicated to supporting a single cluster or workload.

    You might need to add landing zone subscriptions if segmentation is required to separate workloads based on region, business unit, environment, criticality, or other external constraints.

      > [!TIP]
      > Review the [Tailor the Azure landing zone architecture to meet requirements](../../../ready/landing-zone/tailoring-alz.md) before creating any additional Management Groups.

  - **Centrally operated, single tenant:** For hostile or regulated workloads that are still centrally operated, it's common to have dedicated hosts for the workloads. You might still experience operational efficiency by consolidating supporting landing zones.

- Choose a management group hierarchy based on the general scale and alignment of environments and hosts required to support overall portfolio requirements:

  - Use a flat structure to support many dedicated hosts in dedicated environments for decentralized operations run by each workload team.
  - Use a segmented structure to create a management group for centrally managed hosts and a separate management group for decentralized operations.
  - Use a hierarchical structure to further segment environments to reflect billing, governance, or operational requirements.

- Decide which container registry to use:

  - Use the integrated Red Hat OpenShift Container Platform registry. Consider these factors:
    - You must configure the [built-in container registry](/azure/openshift/built-in-container-registry).
    - For an enterprise-quality container registry, use the [Red Hat Quay registry](https://access.redhat.com/documentation/en-us/red_hat_quay/3.7).
  - Use [Azure Container Registry](/azure/openshift/howto-use-acr-with-aro). Consider these factors:
    - Implement [Azure Container Registry best practices](/azure/container-registry/container-registry-best-practices).
    - Use a [quarantine pattern](https://github.com/AzureCR/QuarantinePattern-Spec) to ensure that the registry contains only images that have been vulnerability-scanned.
  - Use a third-party container registry.

- Decide which container registry topology to use for Open Container Initiative (OCI) artifact distribution:

  - One registry per workload.
  - One registry per cluster, with multiple workloads in the registry.
  - One registry for all clusters in the landing zone, with multiple workloads and clusters in the same registry.
  - One registry for all clusters across multiple landing zones, with multiple workloads and clusters in the same registry.

- Decide the scope for container registry policies in Azure Policy:

  - Set a policy at the subscription level to require all hosts in the landing zone to use the defined registry.
  - Set a more granular policy at the resource group level.
  - Set a broader policy at the management group level.

## Design recommendations

- Define a [naming and tagging standard](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) to apply to all container resources deployed to Azure. At a minimum, the standard should include:
  - **Workload names:** The workload or workloads each cluster supports.
  - **Cluster resources:** The elevation of cluster resource alignment from the preceding considerations.
  - **Host operator:** Which team is responsible for host operations.
- Implement a policy to require a specific OCI artifact registry that's based on your organization's container registry topology.

## Next steps

- Review [security recommendations for Azure Red Hat OpenShift](security.md).
