---
title: Identity and access management considerations for AKS
description: This article provides design considerations and recommendations for identity and access management when you use Azure Kubernetes Service.
author: xuhongl
ms.author: xuhliu
ms.date: 11/21/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Identity and access management considerations for AKS

This article provides design considerations and recommendations for identity and access management when you use Azure Kubernetes Service (AKS). There are multiple aspects of identity and access management, including cluster identities, workload identities, and operator access.

## Design considerations

- Decide which cluster identity to use ([managed identity](/azure/aks/use-managed-identity) or [service principal](/azure/aks/kubernetes-service-principal?tabs=azure-cli)).
- Decide how to authenticate cluster access: based on client certificates or via [Microsoft Entra ID](/azure/aks/managed-aad).
- Decide on a [multitenancy cluster](/azure/aks/operator-best-practices-cluster-isolation) and how to set up role-based access control (RBAC) in Kubernetes.
  - Choose a method for isolation. Methods include namespace, [network policy](/azure/aks/use-network-policies) (Only allowed by [Azure CNI](/azure/aks/azure-cni-overlay)), compute (node pool), and cluster.
  - Determine the Kubernetes RBAC roles and compute allocation per application team, for isolation.
  - Decide whether application teams can read other workloads in their clusters or in other clusters.
- Determine the permissions for custom Azure RBAC roles for your [AKS landing zone](../../../ready/landing-zone/design-area/identity-access.md).
  - Decide what permissions are needed for the site reliability engineering (SRE) role to enable that role to administer and troubleshoot the whole cluster.
  - Decide what permissions are needed for SecOps.
  - Decide what permissions are needed for the landing zone owner.
  - Decide what permissions the application teams will need to deploy into the cluster.
- Decide whether you need workload identities ([Microsoft Entra Workload ID](/azure/aks/workload-identity-overview)). You might need them for services like Azure Key Vault integration and Azure Cosmos DB.

## Design recommendations

- Cluster identities.
  - Use your own [managed identity](/azure/aks/use-managed-identity) for your AKS cluster.
  - Define custom Azure RBAC roles for your AKS landing zone to simplify the management of required permissions for cluster-managed identity.
- Cluster access.
  - Use Kubernetes RBAC with Microsoft Entra ID to [limit privileges](/azure/aks/azure-ad-rbac) and minimize administrator privileges. Doing so helps to protect configuration and secrets access.
  - Use [AKS-managed Microsoft Entra integration](/azure/aks/managed-aad) so you can use Microsoft Entra ID for authentication and operator and developer access.
- Define required RBAC roles and role bindings in Kubernetes.
  - Use [Kubernetes roles and role bindings](/azure/aks/concepts-identity#kubernetes-role-based-access-control-kubernetes-rbac) to Microsoft Entra groups for site reliability engineering (SRE), SecOps, and developer access.
  - Consider using [Azure RBAC for Kubernetes](/azure/aks/manage-azure-rbac), which enables unified management and access control across Azure resources, AKS, and Kubernetes resources. When Azure RBAC for Kubernetes is enabled, you don't need to separately manage user identities and credentials for Kubernetes. Microsoft Entra principals will be exclusively validated by Azure RBAC, but regular Kubernetes users and service accounts will be exclusively validated by Kubernetes RBAC.
- Grant SRE full access just-in-time, as needed.
  - Use [Privileged Identity Management in Microsoft Entra ID](/entra/id-governance/privileged-identity-management/pim-configure) and [identity and access management in Azure landing zones](../../../ready/landing-zone/design-area/identity-access.md).
- Use [Microsoft Entra Workload ID for Kubernetes.](/entra/workload-id/workload-identity-federation) When you implement this federation, developers can use native Kubernetes service accounts and federation to access resources managed by Microsoft Entra ID, like Azure and Microsoft Graph.
