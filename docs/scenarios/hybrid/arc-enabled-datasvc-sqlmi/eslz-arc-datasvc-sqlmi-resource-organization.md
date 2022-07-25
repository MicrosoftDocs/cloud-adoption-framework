---
title: Resource organization for Azure Arc-enabled SQL Managed Instance
description: Learn how to organize resources when working with Azure Arc-enabled SQL Managed Instance.
author: tibalabu
ms.author: tibalabu
ms.date: 07/25/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Resource organization for Azure Arc-enabled SQL Managed Instance

Resource organization decisions are a foundation for all compliance-related design areas and involves preparing your environment and setting up your resources so you can efficiently secure, manage, and track costs related to your workloads

The Cloud Adoption Framework [Ready methodology](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/) provides resource organization guidance you can review before deploying and implementing your workloads. This strategy should include your hybrid and multicloud resources and add business and operational details as components of inventory management and metadata tags.

It is important to know how to use consistent resource grouping, defined naming standards, relevant tagging, and fine-grained access control to optimize your resource organization when using Azure Arc-enabled Data Services SQL Managed Instance.

## Resource consistency and organization

It's important to define a structure on how resources will be projected to Azure management scopes  (management groups, subscriptions, and resource groups) and this should be done before onboarding any Azure Arc-enabled SQL Managed Instance onto Azure Arc. Review the Cloud Adoption Framework recommendations on how to [organize resources](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagementGroupsAndHierarchy).

Also you can review the [resource organization design](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org) area of the Azure landing zones to assess the impact of Azure Arc-enabled SQL Managed Instance on your overall resource organization model.

This mapping is the key to determine how you can interact with these resources whe applying [role-based access control (RBAC)](https://docs.microsoft.com/en-us/azure/active-directory/roles/best-practices) and assigning [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview) as part of your governance model.

When designing this structure, keep in mind the [Azure Resource Manager service limits](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits) as they might apply to Azure Arc-enabled SQL Managed Instance. While designing your structure, it's important to be aware of [resource group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits) or [subscription](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits) limits.

After you've created a taxonomy structure and agreed on naming standards, it's recommended to apply [tags](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) to the Azure Arc-enabled SQL Managed Instance resources.

You can apply a tag either during Azure Arc-enabled SQL Managed Instance onboarding or once it is registered in Azure (meaning your Azure Arc-enabled SQL Managed Instance has a resource ID and is part of a resource group within your subscription) and it can benefit from standard Azure constructs such as resource tags. Resource tags let you add metadata to a resource so you can quickly locate it and automate operational tasks, which is important for day-to-day operations. For detailed guidance on tagging, review the [Cloud Adoption Framework tagging strategy](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)

After onboarding the Azure Arc-enabled SQL Managed Instance to resource groups and added tags, you can use [Resource Graph](https://docs.microsoft.com/en-us/azure/governance/resource-graph/overview) queries, view groupings based on resource groups, or organize and inventory your resources using tags.

## Next steps

For more information about your hybrid and multicloud cloud journey, see the following articles:

- [Plan an Azure Arc-enable data services deployment](https://docs.microsoft.com/en-us/azure/azure-arc/data/plan-azure-arc-data-services)
- Review the [connectivity modes](https://docs.microsoft.com/en-us/azure/azure-arc/data/connectivity)
- Review the [prerequisites](https://docs.microsoft.com/en-us/azure/azure-arc/data/plan-azure-arc-data-services#prerequisites) for Arc-enable data services.
- Review the prerequisites for deploying Azure Arc data controller - [Indirect connectivity mode](https://docs.microsoft.com/en-us/azure/azure-arc/data/create-data-controller-indirect-azure-data-studio#prerequisites)
- Review the prerequisites for deploying Azure Arc data controller - [Direct connectivity mode](https://docs.microsoft.com/en-us/azure/azure-arc/data/create-data-controller-direct-prerequisites?tabs=azure-cli)
- Learn the fundamentals of [Azure Arc-enable data services](https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-arc/).
-Experience Azure Arc-enabled data services scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
