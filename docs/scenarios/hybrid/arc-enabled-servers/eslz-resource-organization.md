---
title: Resource organization for Azure Arc-enabled servers
description: Evaluate how resources will be organized when working with Azure Arc-enabled servers
author: lanicolas
ms.author: matgri
ms.date: 11/15/2021
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Resource organization for Azure Arc-enabled servers

To align with the [Ready methodology](../../../ready/index.md) of the Cloud Adoption Framework, implement a resource consistency and tagging strategy. This strategy should include your hybrid and multicloud resources and add business and operational details as components of inventory management and metadata tags.

## Resource consistency and organization

Before onboarding any machine onto Azure Arc, it's important to define a structure on how these resources will be projected to Azure management scopes. These scopes include management groups, subscriptions, and resource groups. This mapping is key. It will determine how you can interact with these resources when applying [role-based access control (RBAC)](/entra/identity/role-based-access-control/best-practices) roles and while assigning Azure policies as part of your governance model. Review the Cloud Adoption Framework recommendations on how to [organize resources](../../../ready/azure-setup-guide/organize-resources.md?tabs=AzureManagementGroupsAndHierarchy).

When designing this structure, be aware of [Azure Resource Manager service limits](/azure/azure-arc/servers/agent-overview#azure-subscription-and-service-limits) which may apply to some components of your end-to-end solution. There are no limits to the number of Arc-enabled servers you can add to a resource group or subscription.

After you've created a taxonomy structure and agreed on naming standards, it's recommended to apply tags to the Azure Arc-enabled server resources. Once a server is registered in Azure, it can benefit from standard Azure constructs such as resource tags. A server registered in Azure means it has a resource ID and becomes part of the resource group within a subscription.

Resource tags allow you to add metadata to a resource to quickly locate it and automate operational tasks. These actions are important to your day-to-day tasks as described in the [Cloud Adoption Framework tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging). Specifically for Azure Arc-enabled servers, it's a good practice to include a tag that reflects the "hosting platform" for Azure Arc-enabled resources and the physical "location".

The following image shows a conceptual reference for resource tagging for Azure Arc-enabled servers:

:::image type="content" source="./media/arc-enabled-servers-resource-tag.svg" alt-text="A diagram that shows resource tagging for Azure Arc-enabled servers." border="false" lightbox="./media/arc-enabled-servers-resource-tag.svg":::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/scenarios/hybrid/arc-enabled-servers/arc-enabled-servers-resource-tag-update.vsdx) of this architecture.*

## Next steps

For more guidance for your hybrid cloud adoption journey, review the following resources:

- Understand how to manage [hybrid and multicloud](../manage.md) environments.
- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios.
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers.
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers.
- Learn how to apply resource tags for Azure Arc-enabled servers.
- Learn more about Azure Arc via the [Azure Arc learning path](/training/paths/manage-hybrid-infrastructure-with-azure-arc/).
