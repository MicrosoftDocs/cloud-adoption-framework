---
title: Resource organization for Azure Arc-enabled kubernetes
description: Evaluate how resources will be organized when working with Azure Arc-enabled kubernetes
author: lanicolas
ms.author: matgri
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Resource organization for Azure Arc-enabled Kubernetes

Resource organization is all about preparing your environment and organizing your resources in the most efficient way so that it is easier to find, consume and act on a resource. Microsoft Cloud Adoption Framework [Ready methodology](/azure/cloud-adoption-framework/ready/) provides all necessary guidance in this respect before you deploy and operationalize your workloads. Broadly, such activities include consistent resource grouping, defined naming standards, relevant tagging, and fine-grained access control.

## Resource consistency and organization

Before onboarding any Kubernetes cluster onto Azure Arc, it is important to define a structure on how these resources will be projected to Azure management scopes (management groups, subscriptions, and resource groups). This mapping is key, as it will determine how you will be able to interact with these resources when applying [role-based access control (RBAC)](/azure/active-directory/roles/best-practices) roles and while assigning Azure policies as part of your governance model. Review the Cloud Adoption Framework recommendations on how to [organize resources](/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagementGroupsAndHierarchy).

When designing this structure, be aware of [Azure Resource Manager service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits), as they are also applicable to Azure Arc-enabled Kubernetes. It is important to plan for the number of clusters to be connected to a specific [resource group](/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits) or [subscription](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-kubernetes-service-limits).

After you have created a taxonomy structure and agreed on naming standards, it is recommended to apply necessary [tags](/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/arc-inventory-tagging) to the Azure Arc-enabled Kubernetes resources. Resource tags provide the ability to add metadata to a resource to quickly locate it and automate operational tasks, which is important to your day-to-day operations. 

Review [Cloud Adoption Framework tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) for detailed guidance on tagging. You can apply a tag either during the time of cluster onboarding or once a cluster is registered in Azure (it has a resource ID and becomes part of the resource group within a subscription). 

After clusters are onboarded to resource groups and tags have been added, you can use [Resource Graph](https://docs.microsoft.com/azure/governance/resource-graph/overview#:~:text=Azure%20Resource%20Graph%20is%20a,can%20effectively%20govern%20your%20environment.) queries, view grouping based on resource groups, or organize and inventory resources based on tags. Specifically for Arc-enabled Kubernetes, it is a good practice to include a tag that reflects the "hosting platform", or 
"infrastructure type" for Azure Arc-enabled resources as well as the physical location.

The following image shows a conceptual reference for resource tagging for Azure Arc-enabled Kubernetes:

![A diagram depicting resource tagging for Azure Arc-enabled kubernetes](./media/arc-enabled-kubernetes-resource-tagging.svg)

## Next steps

For more guidance for your hybrid cloud adoption journey, please review the following:

- [Manage hybrid and multicloud environments](/azure/cloud-adoption-framework/scenarios/hybrid/manage)
- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/day2/) scenarios
- Review the [prerequisites](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#prerequisites) for Azure Arc-enabled Kubernetes
- [Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli)
