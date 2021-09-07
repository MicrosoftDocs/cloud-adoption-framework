---
title: Resource organization recommendations
description: Recommendations for resource organization
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Recommendations: Resource organization

## Management groups

Keep the management group hierarchy reasonably flat, with no more than three to four levels ideally. This restriction reduces management overhead and complexity.

Avoid duplicating your organizational structure into a deeply nested management group hierarchy. Management groups should be used for policy assignment versus billing purposes. This approach necessitates using management groups for their intended purpose in enterprise-scale architecture, which is providing Azure policies for workloads that require the same type of security and compliance under the same management group level.

- Create management groups under your root-level management group to represent the types of workloads (archetypes) that you'll host and ones based on their security, compliance, connectivity, and feature needs. This grouping structure allows you to have a set of Azure policies applied at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

- Use resource tags, which can be enforced or appended through Azure Policy, to query and horizontally navigate across the management group hierarchy. Then you can group resources for search needs without having to use a complex management group hierarchy.

- Create a top-level sandbox management group to allow users to immediately experiment with Azure. Users can then experiment with resources that might not yet be allowed in production environments. The sandbox provides isolation from your development, test, and production environments.

- Use a dedicated service principal name (SPN) to execute management group management operations, subscription management operations, and role assignment. Using an SPN reduces the number of users who have elevated rights and follows least-privilege guidelines.

- Assign the User Access Administrator role at the root management group scope (/) to grant the SPN just mentioned access at the root level. After the SPN is granted permissions, the User Access Administrator role can be safely removed. In this way, only the SPN is part of the User Access Administrator role.

- Assign the Contributor role to the SPN previously mentioned at the root management group scope (/), which allows tenant-level operations. This permission level ensures that the SPN can be used to deploy and manage resources to any subscription within your organization.

- Create a Platform management group under the root management group to support common platform policy and Azure role assignment. This grouping structure ensures that different policies can be applied to the subscriptions used for your Azure foundation. It also ensures that the billing for common resources is centralized in one set of foundational subscriptions.

- Limit the number of Azure Policy assignments made at the root management group scope (/). This limitation minimizes debugging inherited policies in lower-level management groups.

- Use the policies available for enterprise-scale landing zones to enforce compliance requirements either at management group or subscription scope. Refer to guidance in the Policy-driven governance section to learn more about the governance requirements that can be addressed.

- Ensure that only privileged users can operate management groups in the tenant by enabling Azure RBAC authorization in the management group hierarchy settings (by default, all users are authorized to create their own management groups under the root management group).

- Configure a default, dedicated management group for new subscriptions to ensure that no subscriptions are placed under the root management group. This is especially important if there are users eligible for MSDN or Visual Studio benefits and subscriptions. A good candidate for this type of management group is a Sandbox management group.

## Subscription organization and governance

Keep the management group hierarchy reasonably flat, with no more than three to four levels ideally. This restriction reduces management overhead and complexity.

- Avoid duplicating your organizational structure into a deeply nested management group hierarchy. Management groups should be used for policy assignment versus billing purposes. This approach necessitates using management groups for their intended purpose in enterprise-scale architecture, which is providing Azure policies for workloads that require the same type of security and compliance under the same management group level.

- Create management groups under your root-level management group to represent the types of workloads (archetypes) that you'll host and ones based on their security, compliance, connectivity, and feature needs. This grouping structure allows you to have a set of Azure policies applied at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

- Use resource tags, which can be enforced or appended through Azure Policy, to query and horizontally navigate across the management group hierarchy. Then you can group resources for search needs without having to use a complex management group hierarchy.

- Create a top-level sandbox management group to allow users to immediately experiment with Azure. Users can then experiment with resources that might not yet be allowed in production environments. The sandbox provides isolation from your development, test, and production environments.

- Use a dedicated service principal name (SPN) to execute management group management operations, subscription management operations, and role assignment. Using an SPN reduces the number of users who have elevated rights and follows least-privilege guidelines.

- Assign the User Access Administrator role at the root management group scope (/) to grant the SPN just mentioned access at the root level. After the SPN is granted permissions, the User Access Administrator role can be safely removed. In this way, only the SPN is part of the User Access Administrator role.

- Assign the Contributor role to the SPN previously mentioned at the root management group scope (/), which allows tenant-level operations. This permission level ensures that the SPN can be used to deploy and manage resources to any subscription within your organization.

- Create a Platform management group under the root management group to support common platform policy and Azure role assignment. This grouping structure ensures that different policies can be applied to the subscriptions used for your Azure foundation. It also ensures that the billing for common resources is centralized in one set of foundational subscriptions.

- Limit the number of Azure Policy assignments made at the root management group scope (/). This limitation minimizes debugging inherited policies in lower-level management groups.

- Use the policies available for enterprise-scale landing zones to enforce compliance requirements either at management group or subscription scope. Refer to guidance in the Policy-driven governance section to learn more about the governance requirements that can be addressed.

- Ensure that only privileged users can operate management groups in the tenant by enabling Azure RBAC authorization in the management group hierarchy settings (by default, all users are authorized to create their own management groups under the root management group).

- Configure a default, dedicated management group for new subscriptions to ensure that no subscriptions are placed under the root management group. This is especially important if there are users eligible for MSDN or Visual Studio benefits and subscriptions. A good candidate for this type of management group is a Sandbox management group.

## Subscription quota and capacity

- Use subscriptions as scale units, and scale out resources and subscriptions as required. Your workload can then use the required resources for scaling out, when needed, without hitting subscription limits in the Azure platform.

- Use reserved instances to prioritize reserved capacity in required regions. Then your workload will have the required capacity even when there's a high demand for that resource in a specific region.

- Establish a dashboard with custom views to monitor used capacity levels. Set up alerts if capacity utilization is reaching critical levels (for example, CPU utilization pf 90 percent).

- Raise support requests for quota increase as a part of subscription provisioning (for example, total available VM cores within a subscription). This approach ensures your quota limits are set before your workloads require going over the default limits.

- Ensure required services and features are available within the chosen deployment regions.

## Subscription tenant transfer restrictions

- Prevent all users, by default, from being able to transfer Azure subscriptions to or from the Azure AD tenant by configuring the following settings:

  - **Subscription leaving Azure AD directory** set to `Permit no one`.

  - **Subscription entering Azure AD directory** set to `Permit no one`.

- Configure a limited set of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - This would ideally be members of an Azure PlatformOps (platform operations) team.

  - Include break-glass accounts in the list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

