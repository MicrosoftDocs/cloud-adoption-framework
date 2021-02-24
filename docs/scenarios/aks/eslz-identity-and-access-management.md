---
title: "Enterprise-scale identity and access management for AKS"
description: Describes how this enterprise-scale scenario can improve identity and access management for the Azure Kubernetes Service.
author: TomGeske
ms.author: thomasge
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for Azure Kubernetes Service (AKS) enterprise-scale scenario

Your organization or enterprise needs to design suitable security settings to meet their requirements. Identity and access management covers multiple aspects like cluster identities, workload identities, and operator access.

## Design considerations

- Decide what cluster identity is being used (Managed Identity or service principal).
- Decide how to authenticate cluster access (cert-based or Azure Active Directory (Azure AD)).
- Decide on a multitenancy cluster and a how-to setup for role-based access controls (RBAC) in Kubernetes.
  - Decide on a method for isolation - namespace, network policy, compute (node pool), or cluster.
  - Decide on K8s RBAC roles and compute allocation per app team for isolation.
  - Decide on whether app teams can read other workloads in their cluster or in other clusters.
- Decide on a custom Azure RBAC role(s) for your [AKS landing zone](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management).
  - Decide what permissions are needed for the site reliability engineering (SRE) role to administer/troubleshoot the whole cluster.
  - Decide what permissions are needed for SecOps.
  - Decide what permissions are needed for the landing zone owner.
  - Decide what permissions are needed for the app teams to deploy into the cluster.
- Decide if you need workload identities (Azure AD Pod identities). They might be needed for Azure services like Azure Key Vault integration, Cosmos DB, and others.

## Design recommendations

- **Cluster identities**
  - Use your own [managed identity](https://aka.ms/aks/mi) for your AKS cluster.
  - Define custom Azure RBAC roles for your AKS landing zone to simplify the management of required permissions for cluster-managed identity.
- **Cluster access**
  - Use Kubernetes RBAC with Azure AD to [limit privileges](https://docs.microsoft.com/azure/aks/azure-ad-rbac) and minimize granting administrator privileges to protect configuration and secrets access.
  - Use [AKS-managed Azure AD Integration](https://aka.ms/aks/managed-aad) to leverage Azure AD for authentication and operator and developer access.
  -	Define required RBAC roles and role bindings in Kubernetes.
    - Use [K8s roles and role bindings](https://docs.microsoft.com/azure/aks/concepts-identity#kubernetes-role-based-access-control-kubernetes-rbac) to Azure AD groups for site reliability engineering (SRE), SecOps, and developer access.
    - SRE full access should be granted just-in-time as needed. Use [Privileged Identity Management in Azure AD](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) and identity and access management in [enterprise-scale](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management).
