---
title: Resource organization for Azure Arc-enabled servers
description: Learn how to organize resources when working with Azure Arc-enabled servers
author: lanicolas
ms.author: matgri
ms.date: 11/15/2021
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Resource organization for Azure Arc-enabled servers

Align with the [Ready methodology](../../../ready/index.md) of the Cloud Adoption Framework by implementing a resource consistency and tagging strategy. This strategy should include your hybrid and multicloud resources and incorporate business and operational details through inventory management and metadata tags.

## Resource consistency and organization

Before onboarding any machine to Azure Arc, define a structure for projecting these resources to Azure management scopes, such as management groups, subscriptions, and resource groups. This mapping is critical because it determines how you interact with resources when applying [role-based access control (RBAC)](/entra/identity/role-based-access-control/best-practices) and assigning Azure policies in your governance model. For detailed guidance, see the Cloud Adoption Framework recommendations on how to [organize resources](../../../ready/azure-setup-guide/organize-resources.md?tabs=AzureManagementGroupsAndHierarchy).

When designing this structure, consider the [Azure Resource Manager service limits](/azure/azure-arc/servers/agent-overview#azure-subscription-and-service-limits) that may affect components of your overall deployment. Although there are no specific limits on the number of Arc-enabled servers per resource group or subscription, ensure compliance with the current Azure Resource Manager limits for other resource types.

After creating a taxonomy and agreeing on naming standards, apply tags to Azure Arc-enabled server resources. Registering a server in Azure assigns it a resource ID and includes it in a resource group and subscription, enabling the use of standard Azure features such as resource tags.

Resource tags add metadata to help you quickly locate resources and automate operational tasks. These capabilities support daily management activities, as detailed in the [Cloud Adoption Framework tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging). For Azure Arc-enabled servers, include tags indicating the hosting platform and physical location.

The following diagram shows resource tagging for Azure Arc-enabled servers:

:::image type="content" source="./media/arc-enabled-servers-resource-tag.svg" alt-text="A diagram that shows resource tagging for Azure Arc-enabled servers." border="false" lightbox="./media/arc-enabled-servers-resource-tag.svg":::

*Download the [Visio file](/azure/azure-arc/servers/media/arc-enabled-servers-resource-tag-update.vsdx) of this architecture.*

## Azure Service Groups

Azure Service Groups, currently in preview, allow dynamic grouping of resources across subscriptions and resource groups. This feature enables flexible inventory views and aggregated monitoring without changing the underlying resource organization. For more information, see the [Azure Service Groups overview](/azure/governance/service-groups/overview).

## Note on Azure Arc-enabled PostgreSQL server

The Azure Arc-enabled PostgreSQL server was retired in July 2025. For PostgreSQL workloads, use [Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/overview).

## Next steps

For more guidance on your hybrid cloud adoption journey, see the following resources:

- Learn how to manage [hybrid and multicloud](../manage.md) environments.
- Explore [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios.
- See the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers.
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enabled servers.
- Learn how to apply resource tags to Azure Arc-enabled servers.
- Explore [Azure Service Groups](/azure/governance/service-groups/overview) for dynamic resource grouping.
- Learn about [Azure Change Tracking and Inventory](/azure/automation/change-tracking/overview-monitoring-agent) for continuous monitoring of changes in Arc-enabled servers.
- Explore the [Azure Arc learning path](/training/paths/manage-hybrid-infrastructure-with-azure-arc/).