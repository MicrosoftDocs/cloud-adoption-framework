---
title: Identity and access management considerations for Azure Red Hat OpenShift
description: Learn how to improve identity and access management for the Azure Red Hat OpenShift landing zone accelerator.
author: Zimmergren
ms.author: pnp
ms.date: 08/18/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-aro, linux-related-content
---

# Identity and access management considerations for Azure Red Hat OpenShift

Identity and access management is a key part of an organization's security settings when it deploys the Azure Red Hat OpenShift landing zone accelerator. Identity and access management includes areas like cluster identities, workload identities, and operator access.

Use these design considerations and recommendations to create an identity and access management plan that meets your organization's requirements in your Azure Red Hat OpenShift deployment.

## Design considerations

- Decide how to create and manage your service principal and the permissions it must have for the Azure Red Hat OpenShift cluster identity:
  - Create the service principal and manually assign permissions.
  - Automatically create the service principal and assign permissions when you create the cluster.
- Decide how to authenticate cluster access:
  - Client certificates
  - [Microsoft Entra ID](/azure/openshift/configure-azure-ad-ui)
- Decide on a multitenancy cluster and how to set up role-based access control (RBAC) in your Azure Red Hat OpenShift cluster.
  - Decide on a method to use for isolation: Red Hat OpenShift projects, network policy, or cluster.
  - Decide on the OpenShift projects, project roles, cluster roles, and compute allocation per application team for isolation.
  - Decide whether application teams can read other OpenShift projects in their cluster.
- Decide on custom Azure RBAC roles for your Azure Red Hat OpenShift landing zone.
  - Decide what permissions are required for the site reliability engineering (SRE) role to administer and troubleshoot the entire cluster.
  - Decide what permissions are required for security operations (SecOps).
  - Decide what permissions are required for the landing zone owner.
  - Decide what permissions are required for the application teams to deploy to the cluster.
- Decide how to store secrets and sensitive information in your cluster. You can store secrets and sensitive information as Base64 encoded Kubernetes secrets or use a secret store provider such as [Azure Key Vault Provider for Secrets Store CSI Driver](https://azure.github.io/secrets-store-csi-driver-provider-azure/).

## Design recommendations

- **Cluster identities**
  - Create a service principal and define the custom Azure RBAC roles for your Azure Red Hat OpenShift landing zone. Roles simplify how you manage permissions for your Azure Red Hat OpenShift cluster service principal.
- **Cluster access**
  - Configure [Microsoft Entra integration](/azure/openshift/configure-azure-ad-cli) to use Microsoft Entra ID to authenticate users in your Azure Red Hat OpenShift cluster.
  - Define OpenShift projects to restrict RBAC privilege and isolate workloads in your cluster.
  - Define the required RBAC roles in OpenShift that are scoped to either a local project scope or a cluster scope.
  - Use Azure Red Hat OpenShift to create role bindings that are tied to Microsoft Entra groups for SRE, SecOps, and developer access.
  - Use Azure Red Hat OpenShift with Microsoft Entra ID to [limit user rights](/azure/aks/azure-ad-rbac) and minimize the number of users who have administrator rights. Limiting user rights protects the configuration and secrets access.
  - Give full access only as needed and just-in-time. Use [Privileged Identity Management in Microsoft Entra ID](/entra/id-governance/privileged-identity-management/pim-configure) and [identity and access management in Azure landing zones](../../../ready/landing-zone/design-area/identity-access.md).
- **Cluster workloads**
  - For applications that require access to sensitive information, use a service principal and the [Azure Key Vault Provider for Secret Store CSI Driver](https://azure.github.io/secrets-store-csi-driver-provider-azure/) to mount secrets stored in Azure Key Vault to your pods.

## Next steps

[Network topology and connectivity for Azure Red Hat OpenShift](network-topology-connectivity.md)
