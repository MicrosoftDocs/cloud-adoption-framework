---
title: Identity and access management considerations for AKS
description: This article provides design considerations and recommendations for identity and access management when you use Azure Kubernetes Service.
author: xuhongl
ms.author: xuhliu
ms.date: 11/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Identity and access management considerations for AKS

This article provides design considerations and recommendations for identity and access management when you use Azure Kubernetes Service (AKS). There are multiple aspects of identity and access management, including cluster identities, workload identities, and operator access.

## Design considerations

- Decide which cluster identity is being used ([managed identity](/azure/aks/use-managed-identity) or [service principal](/azure/aks/kubernetes-service-principal?tabs=azure-cli)).
- Decide how to authenticate cluster access (based on client certificates or via [Azure Active Directory](/azure/aks/managed-aad)).
- Decide on a [multitenancy cluster](/azure/aks/operator-best-practices-cluster-isolation) and how to set up role-based access control (RBAC) in Kubernetes.
  - Decide on a method for isolation. Methods include namespace, network policy, compute (node pool), or and cluster.
  - Determine the Kubernetes RBAC roles and compute allocation per application team, for isolation.
  - Decide whether application teams can read other workloads in their clusters or in other clusters.
- Determine the permissions for custom Azure RBAC roles for your [AKS landing zone](../../../ready/landing-zone/design-area/identity-access.md).
  - Decide what permissions are needed for the site reliability engineering (SRE) role so that role can administer and troubleshoot the whole cluster.
  - Decide what permissions are needed for SecOps.
  - Decide what permissions are needed for the landing zone owner.
  - Decide what permissions the application teams will need to deploy into the cluster.
- Decide whether you need workload identities ([Azure AD workload identities](/azure/aks/workload-identity-overview)). They might be needed for Azure services like Azure Key Vault integration, Azure Cosmos DB, and others.

## Design recommendations

- Cluster identities
  - Use your own [managed identity](/azure/aks/use-managed-identity) for your AKS cluster.
  - Define custom Azure RBAC roles for your AKS landing zone to simplify the management of required permissions for cluster-managed identity.
- Cluster access
  - Use Kubernetes RBAC with Azure AD to [limit privileges](/azure/aks/azure-ad-rbac) and minimize granting administrator privileges to protect configuration and secrets access.
  - Use [AKS-managed Azure AD integration](/azure/aks/managed-aad) to use Azure AD for authentication and operator and developer access.
- Define required RBAC roles and role bindings in Kubernetes.
  - Use [Kubernetes roles and role bindings](/azure/aks/concepts-identity#kubernetes-role-based-access-control-kubernetes-rbac) to Azure AD groups for site reliability engineering (SRE), SecOps, and developer access.
  - Consider using [Azure RBAC for Kubernetes](/azure/aks/manage-azure-rbac) that allows for the unified management and access control across Azure Resources, AKS, and Kubernetes resources. This feature frees you from having to separately manage user identities and credentials for Kubernetes. When enabled, Azure AD principals will be validated exclusively by Azure RBAC while regular Kubernetes users and service accounts are exclusively validated by Kubernetes RBAC.
- SRE full access should be granted just in time as needed.
  - Use [Privileged Identity Management in Azure AD](/azure/active-directory/privileged-identity-management/pim-configure) and [identity and access management in Azure landing zones](../../../ready/landing-zone/design-area/identity-access.md).
- Workload identities
  - [Azure AD workload identity for Kubernetes.](/azure/active-directory/develop/workload-identity-federation) With this federation, developers can use native Kubernetes concepts of service accounts and federation to access Azure AD protected resources, such as Azure and Microsoft Graph.
