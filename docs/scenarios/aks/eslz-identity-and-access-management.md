---
title: "Enterprise-scale identity and access management for Azure Kubernetes Service"
description: Describe how this enterprise-scale scenario can improve identity and access management of Azure Kubernetes Service
author: TomGeske
ms.author: thomasge
ms.date: 10/02/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for Azure Kubernetes Service (AKS) enterprise-scale scenario
Your organization or enterprise needs to design suitable security settings to meet their requirements. Identity and access management is a central and covers multiple aspects like cluster identities, workload identities and operator access. 

## Design considerations
* Decide what cluster identity is being used.
* Decide on how-to authenticate cluster access.	
* Decide on multitenancy cluster and how-to setup permissions in K8s	
  * Decide on method for isolation - namespace, network policy, compute (node pool), cluster.
  * Decide on K8s RBAC roles and compute allocation per app team for isolation.
* Decide on Azure RBAC role(s) for [AKS landing zone](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management)
  * Decide on Azure AD actions needed for SRE role to administer and/troubleshoot whole cluster.
  * Decide on Azure AD actions needed for SecOps.
  * Decide on Azure AD actions needed for the landing zone owner.
  * Decide on Azure AD actions needed for App teams to deploy into cluster.
  * Decide on whether App teams can read other workloads in cluster or in other clusters.
* Decide if you need workload identities.

## Design recommendations
* Cluster identities
  * Use a [managed identity](https://aka.ms/aks/mi) enabled cluster.
  * Define custom Azure RBAC role for AKS landing zone to simplify management of required permissions for cluster managed identity.
* Cluster access
  * Use RBAC enabled clusters.
  * Use [AKS-managed Azure AD Integration](https://aka.ms/aks/managed-aad).	Authentication for operator access is secured by Azure AD.
  *	Define required K8s RBAC roles and role bindings in K8s
    * Use [k8s roles and role bindings](https://docs.microsoft.com/azure/aks/concepts-identity#kubernetes-role-based-access-control-rbac) to Azure AD groups for developer access.
    * SRE full access should be granted just in time as needed. Consider [Privileged Identity Management in Azure AD](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure).
* Use [Azure AD Pod Identity](https://github.com/Azure/aad-pod-identity) for workload identities.
