---
title: "Enterprise-scale identity and access management for Azure Kubernetes Service"
description: Describe how this enterprise-scale scenario can improve identity and access management of Azure Kubernetes Service
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

* Decide what cluster identity is being used (Managed Identity or service principal).
* Decide on how-to authenticate cluster access (cert-based or Azure AD).
* Decide on multitenancy cluster and how-to setup RBAC in Kubernetes
  * Decide on method for isolation - namespace, network policy, compute (node pool), cluster.
  * Decide on K8s RBAC roles and compute allocation per app team for isolation.
  * Decide on whether App teams can read other workloads in cluster or in other clusters.
* Decide on custom Azure RBAC role(s) for [AKS landing zone](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management)
  * Decide on permissions needed for SRE role to administer and/troubleshoot whole cluster.
  * Decide on permissions needed for SecOps.
  * Decide on permissions needed for the landing zone owner.
  * Decide on permissions needed for App teams to deploy into cluster.
* Decide if you need workload identities (Azure AD Pod Identity). Possibly needed for other Azure services like Azure Key Vault integration, Cosmos DB, and others.

## Design recommendations

* Cluster identities
  * Use bring your own [managed identity](https://aka.ms/aks/mi) for your AKS cluster.
  * Define custom Azure RBAC role for AKS landing zone to simplify management of required permissions for cluster-managed identity.
* Cluster access
  * Use Kubernetes RBAC with AAD for [least privilege](https://docs.microsoft.com/azure/aks/azure-ad-rbac) and minimize granting administrator privileges to protect configuration and secrets access.
  * Use [AKS-managed Azure AD Integration](https://aka.ms/aks/managed-aad) to leverage Azure AD for authentication and operator & developer access.
  *	Define required RBAC roles and role bindings in Kubernetes
    * Use [k8s roles and role bindings](https://docs.microsoft.com/azure/aks/concepts-identity#kubernetes-role-based-access-control-rbac) to Azure AD groups for SRE, SecOps, and developer access.
    * SRE full access should be granted just in time as needed. Use [Privileged Identity Management in Azure AD](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) and identity and access management in [enterprise-scale](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management)
