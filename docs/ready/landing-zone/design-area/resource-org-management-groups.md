---
title: Management groups
description: Learn about the resource organization and management group design considerations and recommendations.
author: DominicAllen
ms.author: doalle
ms.date: 12/07/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Management groups

[Management groups](/azure/governance/management-groups/overview) are a tool to help you structure your cloud environments for organization and governance at scale.

Considering how to use management groups as part of the environment design is an important foundational step. Use the following guidance to help make your cloud architecture decisions.

## Management group design considerations

Management group structures within an Azure Active Directory (Azure AD) tenant support organizational mapping. Consider your management group structure thoroughly as your organization plans its Azure adoption at scale.

- How will your organization separate out services owned or operated by specific teams?

- Are there specific functions that need to be kept separate for business or operational compliance reasons?

- You can use management groups to aggregate policy and initiative assignments via Azure Policy.

- A management group tree can support up to [six levels of depth](/azure/governance/management-groups/overview#hierarchy-of-management-groups-and-subscriptions). This limit doesn't include the tenant root level or the subscription level.

- Any principal, whether a user or service principal, within an Azure AD tenant can create new management groups. This permission is because Azure role-based access control (RBAC) authorization for management group operations isn't enabled by default. For more information, see [How to protect your resource hierarchy](/azure/governance/management-groups/how-to/protect-resource-hierarchy)

- All new subscriptions will be placed under the tenant root management group by default.

- See [management groups](/azure/governance/management-groups/overview) to explore their capabilities in more detail.

## Management group recommendations

- Keep the management group hierarchy reasonably flat, ideally with no more than three to four levels. This restriction reduces management overhead and complexity.

- Avoid duplicating your organizational structure into a deeply nested management group hierarchy. Use management groups for policy assignment versus billing purposes. This approach calls for using management groups for their intended purpose in Azure landing zone conceptual architecture. This architecture provides Azure policies for workloads that require the same type of security and compliance under the same management group level.

- Create management groups under your root-level management group to represent the types of workloads that you'll host. These groups are based on the security, compliance, connectivity, and feature needs of the workloads. With this grouping structure, you can have a set of Azure policies applied at the management group level. This grouping structure is for all workloads that require the same security, compliance, connectivity, and feature settings.

- Use resource tags to query and horizontally navigate across the management group hierarchy. Resource tags can be enforced or appended through Azure Policy. Then you can group resources for search needs without having to use a complex management group hierarchy.

- Create a top-level sandbox management group so that users can immediately experiment with Azure. They can then experiment with resources that might not yet be allowed in production environments. The sandbox provides isolation from your development, test, and production environments.

- Create a platform management group under the root management group to support common platform policy and Azure role assignment. This grouping structure ensures that different policies can be applied to the subscriptions used for your Azure foundation. It also ensures that the billing for common resources is centralized in one set of foundational subscriptions.

- Limit the number of Azure Policy assignments made at the root management group scope. This limitation minimizes debugging inherited policies in lower-level management groups.

- Use policies to enforce compliance requirements either at the management group or subscription scope to achieve policy-driven governance.

- Ensure that only privileged users can operate management groups in the tenant. Enable Azure RBAC authorization in the management group [hierarchy settings](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting-require-authorization) to refine user privileges. By default, all users are authorized to create their own management groups under the root management group.

- Configure a default, dedicated management group for new subscriptions. This group ensures that no subscriptions are placed under the root management group. This group is especially important if there are users eligible for Microsoft Developer Network (MSDN) or Visual Studio benefits and subscriptions. A good candidate for this type of management group is a sandbox management group. For more information, see [Setting - default management group](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---default-management-group).

- Don't create management groups for production, testing, and development environments. If necessary, separate these groups into different subscriptions in the same management group. To review further guidance on this topic, see:

  - [How do we handle "dev/test/production" workload landing zones in enterprise-scale architecture? - FAQ](../../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture)
  - [Testing approach for enterprise-scale](../../enterprise-scale/testing-approach.md)

## Management groups in the Azure landing zone accelerator

The following decisions have been made and included in the implementation for the management group structure. These decisions are part of the Azure landing zone accelerator.

![Diagram that shows the Azure landing zone accelerator management group structure.](./media/sub-org.png)

| Management group| Description |
|---|---|
|**Intermediate Root Management Group**| This management group is located directly under the tenant root group. Created with a prefix provided by the organization, which purposely avoids the usage of the root group so that organizations can move existing Azure subscriptions into the hierarchy. It also enables future scenarios. This management group is a parent to all the other management groups created by the Azure landing zone accelerator.|
|**Platform**| This management group contains all the platform child management groups, like management, connectivity, and identity. |
|**Management**| This management group contains a dedicated subscription for management, monitoring, and security. This subscription will host an Azure Log Analytics workspace, including associated solutions, and an Azure Automation account. |
|**Connectivity**| This management group contains a dedicated subscription for connectivity. This subscription will host the Azure networking resources required for the platform, like Azure Virtual WAN, Azure Firewall, and Azure DNS private zones. |
|**Identity**| This management group contains a dedicated subscription for identity. This subscription is a placeholder for Windows Server Active Directory Domain Services (AD DS) virtual machines (VMs) or Azure Active Directory Domain Services. The subscription also enables AuthN or AuthZ for workloads within the landing zones. Specific Azure policies are assigned to harden and manage the resources in the identity subscription. |
|**Landing Zones**| The parent management group for all the landing zone child management groups. It will have workload agnostic Azure policies assigned to ensure workloads are secure and compliant. |
|**Online**| The dedicated management group for online landing zones. This group is for workloads that might require direct internet inbound/outbound connectivity or for workloads that might not require a virtual network. |
|**Corp**| The dedicated management group for corporate landing zones. This group is for workloads that require connectivity or hybrid connectivity with the corporate network via the hub in the connectivity subscription. |
|**Sandboxes**| The dedicated management group for subscriptions that will only be used for testing and exploration by an organization. These subscriptions will be securely disconnected from the corporate and online landing zones. Sandboxes also have a less restrictive set of policies assigned to enable testing, exploration, and configuration of Azure services. |
|**Decommissioned**| The dedicated management group for landing zones that are being canceled. Canceled landing zones will be moved to this management group before deletion by Azure after 30-60 days. |

## Permissions for the Azure landing zone accelerator

- Requires a dedicated service principal name (SPN) to execute management group operations, subscription management operations, and role assignment. Using an SPN reduces the number of users who have elevated rights and follows least-privilege guidelines.

- Requires the User Access Administrator role at the root management group scope to grant the SPN access at the root level. After the SPN is granted permissions, the User Access Administrator role can be safely removed. In this way, only the SPN is part of the User Access Administrator role.

- Requires the Contributor role to the SPN previously mentioned at the root management group scope, which allows tenant-level operations. This permission level ensures that the SPN can be used to deploy and manage resources to any subscription within your organization.

## Next steps

Learn about the role subscriptions play when you're planning a large-scale Azure adoption.

> [!div class="nextstepaction"]
> [Subscriptions](resource-org-subscriptions.md)
