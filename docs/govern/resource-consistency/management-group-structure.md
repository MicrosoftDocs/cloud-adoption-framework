---
title: Management group structure guidance in the Resource Consistency discipline
description: Guidance for managing access, policies and compliance at scale with management groups.
author: robbagby
ms.author: robbag
ms.date: 10/05/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Management group structure

Management groups are a key construct for managing resource consistency. Management groups are logical containers for subscriptions that are arranged hierarchically. You can apply policies and manage access at the management group level and all child management groups and subscriptions inherit the policies and role assignments.

:::image type="complex" source="../../ready/landing-zone/design-area/media/sub-organization.png" alt-text="Diagram of a sample management group hierarchy." border="false":::
Diagram of a root management group holding both management groups and subscriptions. Some child management groups hold management groups, some hold subscriptions, and some hold both.
:::image-end:::

*Diagram 1: Hierarchy of management groups and subscriptions from [management groups in Azure landing zones](../../ready/landing-zone/design-area/resource-org-management-groups.md).*

Management groups help ensure consistency. When you apply policies at the management group level, you ensure all subscriptions under that management group have those policies applied.

For more information, see [what are Azure management groups?](/azure/governance/management-groups/overview).

## Guidance

Establish a relatively flat management group structure based on the security and compliance needs for workloads running in the management groups. Apply the appropriate Azure Policy assignments and role assignments at the management group level to ensure consistency across subscriptions.

Use the following resources to see proven management groups structures and to understand important design considerations and recommendations when designing your structure.

- Understand the [management groups design considerations and recommendations in the Cloud Adoption Framework for Azure](../../ready/landing-zone/design-area/resource-org-management-groups.md)
- Consider the management group structure implemented in the [management groups module of the Azure landing zone bicep repo](https://github.com/Azure/ALZ-Bicep/tree/main/infra-as-code/bicep/modules/managementGroups)

## Audit

Use [Azure Resource Graph](/azure/governance/resource-graph/overview) queries to understand management group membership and policy compliance.

Queries

- [Query to list the subscriptions under a management group](/azure/governance/resource-graph/samples/samples-by-category?tabs=azure-cli#list-all-subscriptions-under-a-specified-management-group)
- [Query to return secure score per management group](/azure/governance/management-groups/resource-graph-samples?tabs=azure-cli#secure-score-per-management-group)

The following Azure Resource Graph query lists policy assignments at the management group level.

```bash
PolicyResources
| where type == 'microsoft.authorization/policyassignments' and properties.scope has '/providers/Microsoft.Management/managementGroups'
| project Policy=properties.displayName,AssignedBy=properties.metadata.assignedBy,Scope=properties.scope
| summarize make_list(Policy) by tostring(Scope)
| order by Scope
```
