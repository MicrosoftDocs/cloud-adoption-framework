---
title: Resource organization for Azure Arc-enabled servers
description: Evaluate how resources will be organized when working with Azure Arc-enabled servers
author: lanicolas
ms.author: matgri
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Resource organization for Azure Arc-enabled servers

To align with the [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework, implement a resource consistency and tagging strategy. This strategy should include your hybrid and multicloud resources and add business and operational details as components of inventory management and metadata tags.

## Resource consistency and organization

Before onboarding any machine onto Azure Arc, it's important to define a structure on how these resources will be projected to Azure management scopes. These scopes include management groups, subscriptions, and resource groups. This mapping is key. It will determine how you can interact with these resources when applying [role-based access control (RBAC)](/azure/active-directory/roles/best-practices) roles and while assigning Azure policies as part of your governance model. Review the Cloud Adoption Framework recommendations on how to [organize resources](/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagementGroupsAndHierarchy).

When designing this structure, be aware of [Azure Resource Manager service limits](/azure/azure-arc/servers/agent-overview#azure-subscription-and-service-limits), as they're also applicable to Azure Arc-enabled servers. It's important to plan for the number of machines to be connected to a specific [resource group](/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits) or [subscription](/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits).

After you've created a taxonomy structure and agreed on naming standards, it's recommended to apply tags to the Azure Arc-enabled server resources. Once a server is registered in Azure, it can benefit from standard Azure constructs such as [resource tags](/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/arc-inventory-tagging). A server registered in Azure means it has a resource ID and becomes part of the resource group within a subscription.

Resource tags allow you to add metadata to a resource to quickly locate it and automate operational tasks. These actions are important to your day-to-day tasks as described in the [Cloud Adoption Framework tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging). Specifically for Azure Arc-enabled servers, it's a good practice to include a tag that reflects the "hosting platform" for Azure Arc-enabled resources and the physical "location".

The following image shows a conceptual reference for resource tagging for Azure Arc-enabled servers:

[ ![A diagram depicting resource tagging for Azure Arc-enabled servers.](./media/arc-enabled-servers-resource-tagging.png)](./media/arc-enabled-servers-resource-tagging.png#lightbox)

## Next steps

For more guidance for your hybrid cloud adoption journey, review the following articles:

- Understand how to manage [hybrid and multicloud](./manage.md) environments
- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers
- Learn how to apply [resource tags](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/arc_inventory_tagging/#apply-inventory-tagging-to-azure-arc-enabled-servers) for Azure Arc-enabled servers
- To learn more about Azure Arc, check out the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/)
