---
title: Identity and access management considerations for AKS
description: Describes how to improve identity and access management for the Azure Kubernetes Service.
author: TomGeske
ms.author: thomasge
ms.date: 04/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Identity and access management considerations for AKS

Your organization or enterprise needs to design suitable security settings to meet their requirements. Identity and access management covers multiple aspects like cluster identities, workload identities, and operator access.

## Design considerations

- Decide what cluster identity is being used ([managed identity](/azure/aks/use-managed-identity) and [service principal](/azure/aks/kubernetes-service-principal?tabs=azure-cli)).
- Decide how to authenticate cluster access (client certificate-based or [Azure Active Directory](/azure/aks/managed-aad)).
- Decide on a [multitenancy cluster](/azure/aks/operator-best-practices-cluster-isolation) and how to set up role-based access control (RBAC) in Kubernetes.
  - Decide on a method for isolation (namespace, network policy, compute (node pool), or cluster).
  - Decide about Kubernetes RBAC roles and compute allocation per application team for isolation.
  - Decide whether application teams can read other workloads in their cluster or in other clusters.
- Decide about custom Azure RBAC roles for your [AKS landing zone](../../ready/enterprise-scale/identity-and-access-management.md).
  - Decide what permissions are needed for the site reliability engineering (SRE) role to administer/troubleshoot the whole cluster.
  - Decide what permissions are needed for SecOps.
  - Decide what permissions are needed for the landing zone owner.
  - Decide what permissions are needed for the application teams to deploy into the cluster.
- Decide whether you need workload identities ([Azure AD pod identities](/azure/aks/use-azure-ad-pod-identity)). They might be needed for Azure services like Azure Key Vault integration, Azure Cosmos DB, and others.

## Design recommendations

- **Cluster identities**
  - Use your own [managed identity](/azure/aks/use-managed-identity) for your AKS cluster.
  - Define custom Azure RBAC roles for your AKS landing zone to simplify the management of required permissions for cluster-managed identity.
- **Cluster access**
  - Use Kubernetes RBAC with Azure AD to [limit privileges](/azure/aks/azure-ad-rbac) and minimize granting administrator privileges to protect configuration and secrets access.
  - Use [AKS-managed Azure AD integration](/azure/aks/managed-aad) to use Azure AD for authentication and operator and developer access.
- Define required RBAC roles and role bindings in Kubernetes.
  - Use [Kubernetes roles and role bindings](/azure/aks/concepts-identity#kubernetes-role-based-access-control-kubernetes-rbac) to Azure AD groups for site reliability engineering (SRE), SecOps, and developer access.
  - SRE full access should be granted just in time as needed. Use [Privileged Identity Management in Azure AD](/azure/active-directory/privileged-identity-management/pim-configure) and [identity and access management in enterprise-scale](../../ready/enterprise-scale/identity-and-access-management.md).
