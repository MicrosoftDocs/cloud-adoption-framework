---
title: Resource organization for Azure Arc-enabled SQL Managed Instance
description: Learn how to organize resources when working with Azure Arc-enabled SQL Managed Instance.
author: tiagobalabuch
ms.author: tibalabu
ms.date: 09/07/2022
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Resource organization for Azure Arc-enabled SQL Managed Instance

Decisions about resource organization are a foundation for all compliance-related design areas. They involve preparing your environment and setting up your resources so that you can efficiently secure, manage, and track costs that are related to your workloads.

The Ready methodology of the Cloud Adoption Framework provides guidance for resource organization. Before deploying and implementing your workloads, review this guidance in [Prepare for cloud adoption](../../../ready/index.md). Your organizational strategy should include your hybrid and multicloud resources and add business and operational details as components of inventory management and metadata tags.

To optimize your resource organization when using Azure Arc-enabled data services, it's important to know how to use consistent resource grouping, defined naming standards, relevant tagging, and fine-grained access control.

## Resource consistency and organization

Before deploying Azure Arc-enabled SQL Managed Instance, it's important to define a structure for how resources will be projected to Azure management scopes: management groups, resource groups, and subscriptions. Review the recommendations on how to organize resources in [Organize your Azure resources effectively](../../../ready/azure-setup-guide/organize-resources.md?tabs=AzureManagementGroupsAndHierarchy).

In addition, to assess the effects of Azure Arc-enabled SQL Managed Instance on your overall resource organization model, review the [resource organization](../../../ready/landing-zone/design-area/resource-org.md) design area of the Azure landing zones.

In the Directly connected mode, the Kubernetes cluster where the Azure Arc-enabled data services are deployed must be an Azure Arc-enabled Kubernetes resource. This connects your Kubernetes cluster to Azure, so that you can deploy and manage Azure Arc-enabled data services directly from the Azure portal. Because the Kubernetes cluster is a resource to Azure Resource Manager when it's Arc-enabled, you should review the best practices in [Resource organization for Azure Arc-enabled Kubernetes](../arc-enabled-kubernetes/eslz-arc-kubernetes-resource-organization.md).

Mapping is the key to determining how you can interact with these resources when applying role-based access control (RBAC) and assigning [Azure Policy](/azure/governance/policy/overview) as part of your governance model. For more information, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

When designing this structure, keep in mind the service limits of Azure Resource Manager, because they might apply to Azure Arc-enabled SQL Managed Instance. While designing your structure, it's important to be aware of the limits for resource groups and subscriptions. For more information about limits, see [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits).

After you've created a taxonomy structure and agreed on naming standards, we recommend applying tags to the resources of Azure Arc-enabled SQL Managed Instance. You can apply a tag either during onboarding of the instance or after it's registered in Azure—meaning that your instance has a resource ID and is part of a resource group within your subscription. After you've registered your instance, it can benefit from standard Azure constructs, such as resource tags. Resource tags let you add metadata to a resource so that you can quickly locate the resource and automate operational tasks, which is important for day-to-day operations. For detailed guidance on tagging, see [Develop your naming and tagging strategy for Azure resources](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).

Before deploying your instance, be sure to review the following articles for recommendations about identity, access, network connectivity, and storage:
  - [Identity and access management for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-identity-access-management.md)
  - [Network connectivity for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-network-connectivity.md)
  - [Storage disciplines for Azure Arc-enabled SQL Managed Instance](./eslz-arc-data-service-sql-managed-instance-storage-disciplines.md)

After you deploy Azure Arc-enabled SQL Managed Instance to a resource group and add tags, you can use [Azure Resource Graph](/azure/governance/resource-graph/overview) queries, view groupings that are based on resource groups, and organize and inventory your resources by using tags.

## Custom location

When planning for the deployment of Azure Arc-enabled data services in [Directly connected mode](/azure/azure-arc/data/connectivity), consider that [Custom locations](/azure/azure-arc/platform/conceptual-custom-locations) will be provisioned and be projected in your Azure subscription.

:::image type="content" alt-text="Diagram that shows mapping of custom locations to namespaces of Azure Arc-enabled data service." source="./media/arc-enabled-data-svc-sql-mi-custom-location-namespace-mapping.png" lightbox="./media/arc-enabled-data-svc-sql-mi-custom-location-namespace-mapping.png":::

We recommend including these resources as part of your resource organization methodology (that is, tags and naming). It's especially important to consider that a custom location configures your Azure Arc-enabled Kubernetes clusters as target locations for deploying instances of Azure offerings. As such, their naming and tagging should be relevant to your business and operations, and also align with a physical location, a data center name, and a cloud environment. Resource naming convention for Azure Arc-enabled SQL Managed Instance should align with your line of business apps that use data services.

:::image type="content" alt-text="Diagram that shows Azure Arc-enabled SQL Managed Instance custom location and Azure tags." source="./media/arc-enabled-data-svc-sql-mi-custom-location-azure-tags.png" lightbox="./media/arc-enabled-data-svc-sql-mi-custom-location-azure-tags.png":::

## Next steps

For more information about your hybrid and multicloud cloud journey, see the following articles:

- [Plan an Azure Arc-enabled data services deployment](/azure/azure-arc/data/plan-azure-arc-data-services)
- [Connectivity modes and requirements](/azure/azure-arc/data/connectivity)
- [Create data controller in Azure Data Studio](/azure/azure-arc/data/create-data-controller-indirect-azure-data-studio), Indirectly connected mode
- [Prerequisites to deploy the data controller in direct connectivity mode](/azure/azure-arc/data/create-data-controller-direct-prerequisites?tabs=azure-cli)
- [Introduction to Azure Arc](/learn/modules/intro-to-azure-arc/), a Learn module 
- [Azure Arc-enabled data services](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/) for automated scenarios with Azure Arc Jumpstart
