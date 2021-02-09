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

Your organization or enterprise needs to design suitable security settings to meet their requirements. Identity and access management in AKS covers multiple aspects like cluster identities, workload identities, and operator access.

## Cluster identity

AKS is platform that manages its own Azure resources, imperatively, in your subscription. As such, it needs to interact with Azure Management API to manage infrastructure aspects such as networking, scale operations, load balancers, and node pool VMs. As those operations must be performed with authorization you have granted, your cluster is created with a number of functionality-based identities for you to assign permissions to. See [Integrate Azure Active Directory for the cluster](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks#integrate-azure-active-directory-for-the-cluster) in the AKS baseline architecture for more details.

**TODO: Is there an enterprise-scale tie in here? Otherwise, this isn't new material in any way. What makes THIS guidance special for enterprise-scale deployments?**

## Design considerations for cluster identity

- You'll need to choose between [system-managed identity](/azure/aks/use-managed-identity#create-an-aks-cluster-with-managed-identities) or [user-managed identity](/azure/aks/use-managed-identity#bring-your-own-control-plane-mi) for the control plane identity.
  - Do not use the legacy service principal mode.

### Design recommendations for cluster identity

- Use [user-managed identity](/azure/aks/use-managed-identity#bring-your-own-control-plane-mi) for your AKS cluster control plane to support the widest range of product functionality.
  - Apply least privileges to this identity over the resources it must manage.
  - Manage the life cycle of this identity as you would any other user-managed identity.
  - Create the identity in the region the cluster is in.
- Ensure the cluster's system-managed identities for add-ons (such as omsagent) are granted least privileges to just those services they need to interact with.
- To support [securely pulling from Azure Container Registry](/azure/aks/cluster-container-registry-integration) without needing to store secrets in the cluster, ensure the kubelet system-managed identity has been assigned pull Azure RBAC role scoped to your container registries.

## Operator Access

Kubernetes exposes its own management plane, served by an internal Kubernetes RBAC system. Those identities that have the ability to manage the AKS Azure resource have the ability to designate Kubernetes administrators for that cluster (in the form of Azure AD groups). Those Kubernetes administrators (Azure AD group members) then have the ability to further grant access throughout the cluster and its namespaces in addition to performing cluster configuration and deploying workloads. See [Associate Kubernetes RBAC to Azure Active Directory](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks#associate-kubernetes-rbac-to-azure-active-directory) in the AKS baseline architecture for more details.

**TODO: Is there an enterprise-scale tie in here? Otherwise, this isn't new material in any way. What makes THIS guidance special for enterprise-scale deployments?**

### Design considerations for operator access

- Map out required identities both for management at the Azure resource level and management within the cluster at both the cluster & workload level. There are multiple roles and access patterns to consider.
  - Decide on permissions needed for the landing zone owner
  - Decide on custom Azure RBAC role(s) for the [AKS landing zone](../../ready/enterprise-scale/identity-and-access-management.md)
  - Decide on permissions needed for SRE role to administer & troubleshoot both Azure resources and Kubernetes
  - Decide on permissions needed for SecOps for both Azure resources and Kubernetes
  - Decide on permissions needed for App teams to deploy into cluster and monitor their workload
- AKS provides the ability to have Kubernetes RBAC backed by an Azure AD tenant that is distinct from the Azure RBAC resource tenant, evaluate which tenant will be backing Kubernetes' RBAC for the above roles.
- Consider the impact of multitenancy on your cluster's IAM strategy, where disparate workload teams may be co-existing on the same cluster resource.
  - Decide on your workload isolation method. This can happen with at the namespace, network policy, and/or node pool level. Use multiple clusters to avoid multitenancy concerns.
  - Decide on Kubernetes RBAC roles and compute allocation per app team for isolation.

### Design recommendations for operator access

- Use Kubernetes RBAC, backed by Azure AD group membership for [least privilege](/azure/aks/azure-ad-rbac) and minimize granting administrator privileges to protect configuration and secrets access.
  - Use [AKS-managed Azure AD Integration](https://aka.ms/aks/managed-aad) to leverage Azure AD for authentication and operator & developer access.
  - Define required RBAC roles and role bindings in Kubernetes
    - Use [Kubernetes roles and role bindings](/azure/aks/concepts-identity#kubernetes-role-based-access-control-rbac) to Azure AD groups for SRE, SecOps, and developer access.
    - SRE full access should be granted just in time as needed. Use [Privileged Identity Management in Azure AD](/azure/active-directory/privileged-identity-management/pim-configure) and identity and access management in [enterprise-scale](../../ready/enterprise-scale/identity-and-access-management.md)
- Enable the "Role-Based Access Control (RBAC) should be used on Kubernetes Services" Azure Policy in Audit mode.

## Workload identities

The various workloads in your cluster may need to communicate with other Azure resources, such as Azure SQL Database, Azure Storage, Azure Key Vault, etc. Many services in Azure that typically host workloads that would need to perform similar actions offer managed identity support to those workloads. In AKS, that support is granted via an add-on that runs from within the cluster called [Azure AD Pod-Managed Identity](/azure/aks/use-azure-ad-pod-identity). Using pod-managed identities helps reduce the number of secrets needed to operate your workload, in the form of connection strings or SAS/access tokens or service principal secrets. See [Integrate Azure Active Directory for the workload](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks#integrate-azure-active-directory-for-the-workload)

**TODO: Is there an enterprise-scale tie in here? Otherwise, this isn't new material in any way. What makes THIS guidance special for enterprise-scale deployments?**

### Design considerations for workload identities

- Consider how application teams will request (or bring) identities into the cluster. Who owns those identities and their lifecycle? When do they get associated with the cluster? When do they become unassociated.

### Design recommendations for workload identities

- If your workloads do NOT access anything external to the cluster that can use Azure AD identities in place of connection strings, API tokens, or similar, do not enable Azure AD pod-managed identities in your cluster.
- If your workloads access anything external to the cluster that can use Azure AD identities in place of connection strings, API tokens, or similar, do configure and use Azure AD pod-managed identities to allow pods to retrieve access tokens for those services.
  - As these identities are user-managed identities, manage them with appropriate lifecycle care.
  - Making managed identities available to pods in a cluster requires coordination between the cluster operator, user-managed identity owner, and workload team. Ensure this process is documented and understood by all involved.
- Ensure workload secrets, including TLS certificates, are accessed out of Azure Key Vault via [Secret Store CSI driver for Key Vault](/azure/key-vault/general/key-vault-integrate-kubernetes), which should perform the authorization to Key Vault as the managed identity of the pod needing the secret.
- Create all pod managed identities in the region that the cluster is in.

## Next steps

Advance to considerations for [Network topology and connectivity for the AKS Enterprise-Scale scenario](./eslz-network-topology-and-connectivity.md).

If you're not yet ready to dive into the rest of this AKS construction set for landing zones, review the [AKS Baseline Architecture](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks) to acquaint yourself with the fundamentals involved in a enterprise deployment of AKS.
