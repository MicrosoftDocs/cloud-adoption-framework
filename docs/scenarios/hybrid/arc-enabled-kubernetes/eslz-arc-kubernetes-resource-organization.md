---
title: Resource organization for Azure Arc-enabled Kubernetes
description: Learn how to organize resources when working with Azure Arc-enabled Kubernetes.
author: lanicolas
ms.author: lanicola
ms.date: 04/28/2022
ms.topic: concept-article
ms.custom: e2e-hybrid
---

# Resource organization for Azure Arc-enabled Kubernetes

Resource organization means preparing your environment so you can efficiently find, consume, and manage resources. The Cloud Adoption Framework's [Ready methodology](../../../ready/index.md) provides resource organization guidance you can review before deploying and implementing your workloads.

This article explains how to use consistent resource grouping, defined naming standards, relevant tagging, and fine-grained access control to optimize resource organization for Azure Arc-enabled Kubernetes.

## Resource consistency and organization

Review the [resource organization design area](../../../ready/landing-zone/design-area/resource-org.md) of the Azure landing zones to assess how Azure Arc-enabled Kubernetes impacts your overall resource organization model.

Before onboarding any Kubernetes cluster onto Azure Arc, define a structure for projecting your resources to Azure management scopes (management groups, subscriptions, and resource groups). This mapping determines how you can interact with these resources when applying [role-based access control (RBAC)](./eslz-arc-kubernetes-identity-access-management.md) roles and assigning Azure policies based on your governance model. Review the Cloud Adoption Framework recommendations for [organizing resources](../../../ready/landing-zone/design-area/resource-org.md).

Keep [Azure Resource Manager service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) in mind, as they apply to Azure Arc-enabled Kubernetes. While designing your structure, determine how many clusters should connect to a specific [resource group](/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits) or [subscription](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-kubernetes-service-limits).

After creating a taxonomy and agreeing on naming standards, apply necessary tags to your Azure Arc-enabled Kubernetes resources. Resource tags let you add metadata to a resource so you can quickly locate it and automate operational tasks.

For detailed guidance on tagging, review the [Cloud Adoption Framework tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging). You can apply tags during cluster onboarding or after registration in Azure (when your cluster has a resource ID and belongs to a resource group).

After onboarding clusters and adding tags, use [Resource Graph](/azure/governance/resource-graph/overview) queries, view resource group groupings, or organize and inventory resources using tags. For Arc-enabled Kubernetes, include a tag reflecting the

The following diagram provides a visual overview of resource tagging for Azure Arc-enabled Kubernetes:

[![A diagram depicting resource tagging for Azure Arc-enabled Kubernetes.](./media/arc-enabled-kubernetes-resource-tagging.png)](./media/arc-enabled-kubernetes-resource-tagging.png#lightbox)

## Next steps

For more information about your hybrid and multicloud journey, see the following articles:

- Review the [prerequisites](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#prerequisites) for Azure Arc-enabled Kubernetes.
- Review the [validated Kubernetes distributions](/azure/azure-arc/kubernetes/validation-program#validated-distributions) for Azure Arc-enabled Kubernetes.
- Learn how to [Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli).
- Experience Azure Arc-enabled Kubernetes automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/).
- Learn more about Azure Arc via the [Azure Arc learning path](/training/paths/manage-hybrid-infrastructure-with-azure-arc/).
- See the [Frequently Asked Questions - Azure Arc-enabled](/azure/azure-arc/kubernetes/faq) for answers to most common questions.