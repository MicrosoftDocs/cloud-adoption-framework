---
title: Identity and access management for Azure Arc-enabled Kubernetes
description: Describes how to improve identity and access management for the Azure Arc-enabled Kubernetes.
author: chintalavr
ms.author: vchintala
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Identity and access management for Azure Arc-enabled Kubernetes

## Overview

Azure Arc-enabled Kubernetes service supports different Kubernetes environments on-premises and other cloud environments that are integrated with different identity and access management systems. In addition to existing Kubernetes cluster RBAC, Azure Arc-enabled Kubernetes supports Azure RBAC to provide unified access management across Kubernetes clusters to minimize operational overhead. Combination of these RBAC models are used depending on the activity that is being performed at various phases of the service such as onboarding Kubernetes cluster to Azure Arc, managing Arc-enabled Kubernetes cluster, installing Azure Arc extensions, applications running on Arc-enabled Kubernetes cluster, and accessing Azure resources using Azure RBAC. It is critical for organizations to understand the scenarios and design Arc-enabled Kubernetes clusters to use appropriate RBAC models to fit into their infrastructure and meet organizations security and governance requirements.

This document explains Arc-enabled Kubernetes service IAM architecture, design considerations, recommendations, and role based access controls for different scenarios.

## Architecture

It is important to understand the [Arc-enabled Kubernetes connectivity modes](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes) to make right architectural decision to make use of Azure RBAC supported in these connectivity modes as Azure RBAC is supported only in fully connected mode and not supported in semi-connected mode.

### Azure RBAC on Azure Arc-enabled Kubernetes

The following diagram shows different Arc-enabled Kubernetes components and how they interact when using [Azure RBAC](/azure/azure-arc/kubernetes/conceptual-azure-rbac#architecture---azure-rbac-on-azure-arc-enabled-kubernetes) to manage Kubernetes cluster.

![Azure RBAC on Azure Arc-enabled Kubernetes](./media/conceptual-azure-rbac.png).

### Manage Azure Arc-enabled Kubernetes cluster anywhere

The following diagram shows [Arc-enabled Kubernetes cluster access from anywhere](/azure/azure-arc/kubernetes/conceptual-cluster-connect) and how the components interact with each other to manage cluster using Azure RBAC.

![Access Arc-enabled Kubernetes anywhere](./media/conceptual-cluster-connect.png)

## Design considerations

- **Kubernetes cluster onboarding**
  - Decide between Azure AD user vs service principal to onboard Kubernetes cluster to Azure Arc individually or at scale. Please refer [Platform Automation CDA](./platform-automation.md) for implementation details.
  - As Kubernetes cluster onboarding to Azure Arc requires Cluster Admin role on the Kubernetes cluster, decide between using a user from on-premises or other cloud identity provider or Kubernetes service account with Cluster Admin role.

- **Kubernetes cluster management**
  - As Azure Arc-enabled Kubernetes brings Azure AD authentication and Azure RBAC into on-premises or other cloud Kubernetes environments, decide between existing Kubernetes access management versus [Azure RBAC](/azure/azure-arc/kubernetes/conceptual-azure-rbac) depending on the organization security and governance requirements.
  - Decide if Azure Arc-enabled Kubernetes Cluster Connect gives you flexibility to [manage Kubernetes cluster](/azure/azure-arc/kubernetes/conceptual-cluster-connect) without the inbound firewall ports opened to the on-premises or other cloud networks.
  - Decide if Azure RBAC is the right choice when there are many Kubernetes clusters running on-premises and other cloud environments and simplifies cluster administration across all Kubernetes clusters.

## Design recommendations

- **Kubernetes cluster onboarding**
  - Use [Azure AD security groups](/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal) to grant Azure Arc-enabled Kubernetes cluster Management and Governance roles to onboard and manage Azure Arc-enabled Kubernetes resources in Azure.
  - Use least privilege and separation of duties principles and create security groups,  assign users or principals to the security groups to perform various roles on the Kubernetes clusters.
  
- **Kubernetes cluster management**
  - If on-premises identities are synchronized with Azure Active Directory, use the same identities when using Azure RBAC for cluster management.
  - Create [security groups](/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal) and map them to the Azure RBAC roles supported by Azure Arc-enabled Kubernetes to simplify access management. Assign permissions to these security groups at the resource group or subscription level depending on the resource organization and governance requirements. Please refer [Resource Organization CDA](./resource-organization.md) for guidance.
  - Avoid direct user assignment to Azure RBAC roles as it is difficult to govern access management.
  - Assign security group owners to decentralize and delegate access management responsibility and audit assignments.
  - Enable periodic [access reviews](/azure/active-directory/privileged-identity-management/pim-create-azure-ad-roles-and-resource-roles-review) in Azure Active Directory to remove users that are no longer need access to the Kubernetes clusters.
  - Create [conditional access policies](/azure/active-directory/conditional-access/howto-conditional-access-policy-azure-management) when using Azure RBAC for cluster management to enforce various conditions to meet security and governance policies.
  
## Role based access controls (RBAC)

Azure Arc-enabled Kubernetes supports following Roles to onboard Kubernetes clusters to Azure Arc and manage Kubernetes clusters using Azure RBAC.

|Role|Description|
|-----------|------------|
|Azure Arc Enabled Kubernetes Cluster User Role|List cluster user credentials action.|
|Azure Arc Kubernetes Admin|Lets you manage all resources under cluster/namespace, except update or delete resource quotas and namespaces.|
|Azure Arc Kubernetes Cluster Admin|Lets you manage all resources in the cluster.|
|Azure Arc Kubernetes Viewer|Lets you view all resources in cluster/namespace, except secrets.|
|Azure Arc Kubernetes Writer|Lets you update everything in cluster/namespace, except (cluster)roles and (cluster)role bindings.|
|Kubernetes Cluster - Azure Arc Onboarding|Role definition to authorize any user/service to create connectedClusters resource|
|Microsoft.Kubernetes connected cluster role|Microsoft.Kubernetes connected cluster role.|

## Next steps

- Review [common conditional access policies](/azure/active-directory/conditional-access/plan-conditional-access) to apply when using Azure RBAC for Arc-enabled Kubernetes cluster.
- [Resource organization](./resource-organization.md) to plan and apply governance and security using Azure RBAC.
- [Integrate Azure Active Directory with Azure Arc-enabled Kubernetes clusters](/azure/azure-arc/kubernetes/azure-rbac).
- [Access your cluster securely](/azure/azure-arc/kubernetes/conceptual-cluster-connect) from anywhere using Cluster connect.
- Azure Landing Zones - [Azure identity and access management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).
- Cloud Adoption Framework - [Access Control](/azure/cloud-adoption-framework/secure/access-control) methodology.
