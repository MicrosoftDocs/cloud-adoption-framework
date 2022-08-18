---
title: Identity and access management considerations for Azure RedHat OpenShift
description: Learn how to improve identity and access management for the Azure RedHat OpenShift Service.
author: jpocloud
ms.author: johnpoole
ms.date: 08/17/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aro
---

# Identity and access management considerations for Azure RedHat OpenShift

Your organization or enterprise must design suitable security settings to meet identity and access management requirements. Identity and access management spans multiple areas of implementation, such as cluster identities, workload identities, and operator access.

## Design considerations

- Decide how to create and manage your own Service Principal. Assign it the required permission for the Azure RedHat OpenShift cluster identity. Or allow the Service Principal to be automatically created and assigned necessary permission during Azure RedHat OpenShift cluster creation.
- Decide how to authenticate cluster access: client certificate-based or [Azure Active Directory](/azure/openshift/configure-azure-ad-ui).
- Decide on a multitenancy cluster and how to set up role-based access control (RBAC) in your Azure RedHat OpenShift cluster.
  - Decide on a method for isolation, OpenShift projects, network policy, or cluster.
  - Decide on the OpenShift projects, project roles, cluster roles, and compute allocation per application team for isolation.
  - Decide whether application teams can read other OpenShift projects in their cluster.
- Decide on custom Azure RBAC roles for your Azure RedHat OpenShift landing zone.
  - Decide what permissions are required for the site reliability engineering (SRE) role to administer and troubleshoot the whole cluster.
  - Decide what permissions are required for SecOps.
  - Decide what permissions are required for the landing zone owner.
  - Decide what permissions are required for the application teams to deploy into the cluster.
- Decide how you want to store secrets and sensitive information in your cluster. Store secrets and sensitive information as base64 encoded Kubernetes secrets. Or you can use a secret store provider such as [Azure Keyvault Provider for Secrets Store CSI Driver](https://azure.github.io/secrets-store-csi-driver-provider-azure/).

## Design recommendations

- *Cluster identities*
  - Create a service principal and define the custom Azure RBAC roles for your Azure RedHat OpenShift landing zone. Roles simplify how you manage the necessary permissions for your Azure RedHat OpenShift cluster service principal.
- *Cluster access*
  - Configure [Azure AD integration](/azure/openshift/configure-azure-ad-cli) to use Azure AD to authenticate users in your Azure RedHat OpenShift cluster.
  - Define OpenShift projects to restrict role-based access control privilege and create isolation between workloads in your cluster.
  - Define the required role-based access control roles in OpenShift that are scoped to either a local project scope or a cluster scope.
  - Use Azure RedHat OpenShift to create role bindings that are tied to Azure AD groups for site reliability engineering (SRE), SecOps, and developer access.
  - Use Azure RedHat OpenShift with Azure AD to [limit privileges](/azure/aks/azure-ad-rbac) and minimize granting administrator privileges. Privilege limits protect the configuration and secrets access.
  - Full access should be granted, just in time and as needed. Use [Privileged Identity Management in Azure AD](/azure/active-directory/privileged-identity-management/pim-configure) and [identity and access management in Azure landing zones](../../../ready/landing-zone/design-area/identity-access.md).
- *Cluster workloads*
  - For applications that require access to sensitive information, use a service principal and [Azure Keyvault Provider for Secret Store CSI Driver](https://azure.github.io/secrets-store-csi-driver-provider-azure/) to mount secrets stored in Azure Keyvault to your pods.
