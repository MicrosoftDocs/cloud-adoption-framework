---
title: Resource organization - management groups - design area
description: Overview for the resource organization and management groups design area
author: DominicAllen
ms.author: doalle
ms.date: 10/11/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---
# Management groups

## Management groups overview

Management groups are a key tool to help organizations structure their cloud environments for organization and governance at scale. 
Considering how to use management groups as part of the environment design is an important foundational step. Use the following guidance to help inform cloud architecture decisions. 

##  Management group  design considerations

Management group structures within an Azure Active Directory (Azure AD) tenant support organizational mapping. Consider your management group structure thoroughly as your organization plans Azure adoption at scale.

- How will your organization separate out services owned or operated by specific teams? Are there specific functions that need to be kept separate for business or operational compliance reasons? Reflect these considerations in your management group structure in order to design in, from the beginning, a structure that reflects how your organization intends to operate

- Management groups can be used to aggregate policy and initiative assignments via Azure Policy.

- A management group tree can support up to [six levels of depth](/azure/governance/management-groups/overview#hierarchy-of-management-groups-and-subscriptions). This limit doesn't include the tenant root level or the subscription level.

- Any principal (user or service principal) within an Azure AD tenant can create new management groups, since Azure role-based access control (RBAC) authorization for management group operations isn't enabled by default.

- All new subscriptions will be placed under the root management group by default.

## Management group recommendations

Keep the management group hierarchy reasonably flat, with no more than three to four levels, ideally. This restriction reduces management overhead and complexity.

Avoid duplicating your organizational structure into a deeply nested management group hierarchy. Management groups should be used for policy assignment versus billing purposes. This approach necessitates using management groups for their intended purpose in Azure landing zone conceptual architecture, which is providing Azure policies for workloads that require the same type of security and compliance under the same management group level.

- Create management groups under your root-level management group to represent the types of workloads (archetypes) that you'll host and ones based on their security, compliance, connectivity, and feature needs. This grouping structure allows you to have a set of Azure policies applied at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

- Use resource tags, which can be enforced or appended through Azure Policy, to query and horizontally navigate across the management group hierarchy. Then you can group resources for search needs without having to use a complex management group hierarchy.

- Create a top-level sandbox management group to allow users to immediately experiment with Azure. Users can then experiment with resources that might not yet be allowed in production environments. The sandbox provides isolation from your development, test, and production environments.

- Use a dedicated service principal name (SPN) to execute management group management operations, subscription management operations, and role assignment. Using an SPN reduces the number of users who have elevated rights and follows least-privilege guidelines.

- Assign the User Access Administrator role at the root management group scope (/) to grant the SPN just mentioned access at the root level. After the SPN is granted permissions, the User Access Administrator role can be safely removed. In this way, only the SPN is part of the User Access Administrator role.

- Assign the Contributor role to the SPN previously mentioned at the root management group scope (/), which allows tenant-level operations. This permission level ensures that the SPN can be used to deploy and manage resources to any subscription within your organization.

- Create a Platform management group under the root management group to support common platform policy and Azure role assignment. This grouping structure ensures that different policies can be applied to the subscriptions used for your Azure foundation. It also ensures that the billing for common resources is centralized in one set of foundational subscriptions.

- Limit the number of Azure Policy assignments made at the root management group scope (/). This limitation minimizes debugging inherited policies in lower-level management groups.

- Use policies to enforce compliance requirements either at management group or subscription scope. 

- Ensure that only privileged users can operate management groups in the tenant by enabling Azure RBAC authorization in the management group hierarchy settings (by default, all users are authorized to create their own management groups under the root management group).

- Configure a default, dedicated management group for new subscriptions to ensure that no subscriptions are placed under the root management group. This is especially important if there are users eligible for MSDN or Visual Studio benefits and subscriptions. A good candidate for this type of management group is a Sandbox management group.
