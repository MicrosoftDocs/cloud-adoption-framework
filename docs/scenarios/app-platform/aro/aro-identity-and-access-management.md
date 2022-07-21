---
title: Identity and access management considerations for ARO
description: Describes how to improve identity and access management for the Azure RedHat OpenShift Service.
author: jpocloud
ms.author: johnpoole
ms.date: 06/1/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aro
---

# Identity and access management considerations for ARO

Your organization or enterprise needs to design suitable security settings to meet their requirements. Identity and access management covers multiple aspects like cluster identities, workload identities, and operator access.

## Design considerations

- Decide on creating and managing your own Service Principal and assigning it required permission for the ARO cluster identity or allow the Service Principal to be automatically created and assigned necessary permission during ARO cluster creation.
- Decide how to authenticate cluster access client certificate-based or [Azure Active Directory](/azure/openshift/configure-azure-ad-ui).
- Decide on a multitenancy cluster and how to set up role-based access control (RBAC) in your ARO cluster.
  - Decide on a method for isolation (OpenShift projects, network policy, or cluster).
  - Decide on OpenShift projects, project roles, cluster roles, and compute allocation per application team for isolation.
  - Decide whether application teams can read other OpenShift projects in their cluster.
- Decide about custom Azure RBAC roles for your ARO landing zone.
  - Decide what permissions are needed for the site reliability engineering (SRE) role to administer/troubleshoot the whole cluster.
  - Decide what permissions are needed for SecOps.
  - Decide what permissions are needed for the landing zone owner.
  - Decide what permissions are needed for the application teams to deploy into the cluster.
- Decide how you want to store secrets and sensitive information in your cluster. This could be stored as base64 encoded Kubernetes secrets or using a Secret Store Provider such as [Azure Keyvault Provider for Secret Store CSI Driver](https://azure.github.io/secrets-store-csi-driver-provider-azure/).

## Design recommendations

- **Cluster identities**
  - Create a Service Principal and define custom Azure RBAC roles for your ARO landing zone to simplify the management of required permissions for the ARO Cluster Service Principal.
- **Cluster access**
  - Configure [Azure AD integration](https://docs.microsoft.com/en-us/azure/openshift/configure-azure-ad-cli) to use Azure AD for authentication of users to your ARO cluster.
  - Define OpenShift projects for restricting RBAC privilege and creating isolation between workloads in your cluster.
  - Define required RBAC roles in OpenShift that are scoped to either a local project scope or cluster scope.
  - Use Azure RedHat OpenShift to create role bindings that are tied to Azure AD groups for site reliability engineering (SRE), SecOps, and developer access.
  - Use Azure RedHat OpenShift with Azure AD to [limit privileges](/azure/aks/azure-ad-rbac) and minimize granting administrator privileges to protect configuration and secrets access.
  - Full access should be granted just in time as needed. Use [Privileged Identity Management in Azure AD](/azure/active-directory/privileged-identity-management/pim-configure) and [identity and access management in Azure landing zones](../../ready/landing-zone/design-area/identity-access.md).
- **Cluster workloads**
  - For applications requiring access to sensitive information, use a Service Principal and [Azure Keyvault Provider for Secret Store CSI Driver](https://azure.github.io/secrets-store-csi-driver-provider-azure/) to mount secrets stored in Azure Keyvault to your pods.