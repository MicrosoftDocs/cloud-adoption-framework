---
title: "Enterprise-Scale identity and access management for <Insert narrative Name>"
description: Describe how this enterprise-scale scenario can improve identity and access management of <Insert Scenario Name>
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for <Insert narrative Name> Enterprise-Scale scenario

## Design considerations
* Decide on multi-tenancy cluster and how to setup permissions in K8s	
  * Decide on method for isolation - namespace, network policy, compute (node pool), cluster
  * Decide on RBAC groups and compute allocation per app team for isolation.
* Decide on Azure RBAC role(s) for [AKS Lz](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management)
  * Decide on AAD Actions needed for SRE role to administer and/troubleshoot whole cluster – PIM
  * Decide on AAD Actions needed for Sec ops
  * Decide on AAD Actions needed for the LZ owner
  * Decide on AAD Actions needed for App teams to deploy in to cluster.
  * Decide on whether App teams can read other workloads in cluster or in other clusters
* Decide how to setup K8s RBAC. 	
* Decide on AKS-managed Azure AD Integration.	
* Decide what cluster identity is being used	
* Decide on workload identities.	

## Design recommendations
* Define Azure RBAC role(s) for AKS Lz	easily manage cluster identity permissions.
* Use K8s RBAC. Define required roles in K8s.	
* Use AKS-managed Azure AD Integration.	Operator access is secured by AAD.
* Use managed identity as cluster Identity.	
* Use PIM for SRE Just in time access.	SRE engineer need just in time access to troubleshoot the cluster
* Use AAD Pod Identity for workload identities.	Pods accessing serices outside of the cluster (e.g. KeyVault) use pod Identity.
