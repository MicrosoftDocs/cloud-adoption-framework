---
title: Resource organization - design area
description: Overview for resource organization design area
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Resource organization

## Overview

As organizations start out on their cloud adoption journey, the scale of the starting point will vary.
Some require scale quickly in order to address business demands such as a data center migration, while others may start out with a smaller number of applications in the cloud and grow over time.

In either scenario, there should be an assumption that the environment will grow to accommodate further applications and services.

A key consideration, therefore, is how to organize resources to enable simplified management across the environment as the number of workloads increases.

In the resource organization design area, we will explore the considerations and recommendations associated with the techniques and technologies than can help maintain good structures to resource topologies within your cloud environments.

## Resource organization considerations


### Define a management group hierarchy design considerations

Management group structures within an Azure Active Directory (Azure AD) tenant support organizational mapping. Consider your management group structure thoroughly as your organization plans Azure adoption at scale.

- Management groups can be used to aggregate policy and initiative assignments via Azure Policy.

- A management group tree can support up to [six levels of depth](/azure/governance/management-groups/overview#hierarchy-of-management-groups-and-subscriptions). This limit doesn't include the tenant root level or the subscription level.

- Any principal (user or service principal) within an Azure AD tenant can create new management groups, since Azure role-based access control (RBAC) authorization for management group operations isn't enabled by default.

- All new subscriptions will be placed under the root management group by default.

### Subscription organization and governance design considerations

Subscriptions are a unit of management, billing, and scale within Azure. They play a critical role when you're designing for large-scale Azure adoption. This section helps you capture subscription requirements and design target subscriptions based on critical factors. These factors are environment type, ownership and governance model, organizational structure, and application portfolios.

- Subscriptions serve as boundaries for assigning Azure policies. For example, secure workloads such as Payment Card Industry (PCI) workloads typically require additional policies to achieve compliance. Instead of using a management group to group workloads that require PCI compliance, you can achieve the same isolation with a subscription. This way, you don't have too many management groups with a small number of subscriptions.

- Subscriptions serve as a scale unit so that component workloads can scale within the platform [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). Make sure to consider subscription resource limits during your workload design sessions.

- Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns.

- There's a manual process, planned future automation, that can be conducted to limit an Azure AD tenant to use only Enterprise Agreement enrollment subscriptions. This process prevents creation of Microsoft Developer Network subscriptions at the root management group scope.

### Configure subscription quota and capacity design considerations

Each Azure region contains a finite number of resources. When you consider an Azure adoption that involves large resource quantities, ensure that sufficient capacity and SKUs are available and that the attained capacity can be understood and monitored.

- Consider limits and quotas within the Azure platform for each service that your workloads require.

- Consider the availability of required SKUs within chosen Azure regions. For example, new features might be available only in certain regions. The availability of certain SKUs for given resources such as VMs might be different from one region to another.

- Consider that subscription quotas aren't capacity guarantees and are applied on a per-region basis.

### Configure subscription tenant transfer restrictions design considerations

Each Azure subscription is linked to a single Azure AD tenant, this acts as the identity provider (IdP) for the Azure subscription which it will trust to authenticate users, services and devices.

However, the Azure AD tenant that an Azure subscription is linked to can be changed by a user with the required permissions that also exists in more than one Azure AD tenant, again, with the required permissions. This process is detailed in the following articles:

- [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)
- [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription)

> [!NOTE]
> For Azure cloud solution provider (CSP) subscriptions, transferring to another Azure AD tenant is not supported.

When this is considered in the context of enterprise-scale, you may decide to restrict and prevent users from being able to either transfer Azure subscriptions out of your organization's Azure AD tenant or transfer Azure subscriptions into your organization's Azure AD tenant. This can be done by following the process detailed in  [Manage Azure subscription policies](/azure/cost-management-billing/manage/manage-azure-subscription-policy).

As part of the subscription policy you can configure, you can also provide a list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users) who are permitted to bypass what's set in the policy.

> [!IMPORTANT]
> This is not an [Azure Policy](/azure/governance/policy/overview).

- Consider whether users with [Visual Studio/MSDN Azure subscriptions](https://azure.microsoft.com/pricing/member-offers/credit-for-visual-studio-subscribers/) should be allowed to transfer their subscription to or from the Azure AD tenant.

- These settings are only configurable by users with the Azure AD [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) role assigned and they must have [elevated their access](/azure/role-based-access-control/elevate-access-global-admin) to be able to change the policy.

  - Only individual user accounts can be specified as [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users). Azure AD groups are not supported at this time.

- All users with access to Azure will be able to view the policy defined for the Azure AD tenant.

  - They will not be able to view the [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - They will be able to view the global administrators within the Azure AD tenant.

- Azure subscriptions transferred into an Azure AD tenant will be placed into the [default management group](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---default-management-group) for that tenant.

- Define a process to allow Azure subscriptions to be transferred to or from an Azure AD tenant, if it's deemed necessary by the application team and approved by the organization.

### Establish cost management design considerations

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. This section explores key aspects associated with how cost transparency can be achieved across large Azure environments.

- There could be a need for chargeback models where shared platform as a service (PaaS) resources are concerned, such as Azure App Service Environment and Azure Kubernetes Service, which might need to be shared to achieve higher density.

- Use a shutdown schedule for nonproduction workloads to optimize costs.

- Use Azure Advisor to check recommendations for optimizing costs.

## Resource organization recommendations

### Management group recommendations

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

### Subscription organization and governance recommendations

- Treat subscriptions as a unit of management aligned with business needs and priorities.

- Make subscription owners aware of their roles and responsibilities:
  - Perform an access review in Azure AD Privileged Identity Management quarterly or twice a year to ensure that privileges don't proliferate as users move within the customer organization.
  - Take full ownership of budget spending and resource utilization.
  - Ensure policy compliance and remediate when necessary.

- Use the following principles when identifying requirements for new subscriptions:
  - **Scale limits:** Subscriptions serve as a scale unit for component workloads to scale within platform subscription limits. For example, large, specialized workloads such as high-performance computing, IoT, and SAP are all better suited to use separate subscriptions to avoid limits (such as a limit of 50 Azure Data Factory integrations).
  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, which allows for a clear separation of concerns. For example, different environments such as development, test, and production are often isolated from a management perspective.
  - **Policy boundary:** Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance. This additional overhead doesn't need to be considered holistically if a separate subscription is used. Similarly, development environments might have more relaxed policy requirements relative to production environments.
  - **Target network topology:** Virtual networks can't be shared across subscriptions, but they can connect with different technologies such as virtual network peering or Azure ExpressRoute. Consider which workloads must communicate with each other when you decide whether a new subscription is required.

- Group subscriptions together under management groups aligned within the management group structure and policy requirements at scale. Grouping ensures that subscriptions with the same set of policies and Azure role assignments can inherit them from a management group, which avoids duplicate assignments.

- Establish a dedicated management subscription in the `Platform` management group to support global management capabilities such as Azure Monitor Log Analytics workspaces and Azure Automation runbooks.

- Establish a dedicated identity subscription in the `Platform` management group to host Windows Server Active Directory domain controllers, when necessary.

- Establish a dedicated connectivity subscription in the `Platform` management group to host an Azure Virtual WAN hub, private Domain Name System (DNS), ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all foundation network resources are billed together and isolated from other workloads.

- Avoid a rigid subscription model, and opt instead for a set of flexible criteria to group subscriptions across the organization. This flexibility ensures that as your organization's structure and workload composition changes, you can create new subscription groups instead of using a fixed set of existing subscriptions. One size doesn't fit all for subscriptions. What works for one business unit might not work for another. Some applications might coexist within the same landing zone subscription while others might require their own subscription.

### Subscription quota and capacity recommendations

- Use subscriptions as scale units, and scale out resources and subscriptions as required. Your workload can then use the required resources for scaling out, when needed, without hitting subscription limits in the Azure platform.

- Use reserved instances to prioritize reserved capacity in required regions. Then your workload will have the required capacity even when there's a high demand for that resource in a specific region.

- Establish a dashboard with custom views to monitor used capacity levels. Set up alerts if capacity utilization is reaching critical levels (for example, CPU utilization pf 90 percent).

- Raise support requests for quota increase as a part of subscription provisioning (for example, total available VM cores within a subscription). This approach ensures your quota limits are set before your workloads require going over the default limits.

- Ensure required services and features are available within the chosen deployment regions.

### Subscription tenant transfer restriction recommendations

- Prevent all users, by default, from being able to transfer Azure subscriptions to or from the Azure AD tenant by configuring the following settings:

  - **Subscription leaving Azure AD directory** set to `Permit no one`.

  - **Subscription entering Azure AD directory** set to `Permit no one`.

- Configure a limited set of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - This would ideally be members of an Azure PlatformOps (platform operations) team.

  - Include break-glass accounts in the list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

## Azure Landing Zone accelerator configuration for resource organization

### Azure landing zone accelerator resource organization implementation

As part of the Azure landing zone accelerator the following decisions have been made and included in the implementation for management group structure

![Azure landing zone accelerator management group structure](./media/management-groups.png)

| Management Group| Description |
|---|---|
|**Top-level Management Group**| (directly under the tenant root group) is created with a prefix provided by the organization, which purposely will avoid the usage of the root group to allow organizations to move existing Azure subscriptions into the hierarchy, and also enables future scenarios. This Management Group is parent to all the other Management Groups created by the Azure Landing Zone accelerator.|
|**Platform**| This Management Group contains all the platform child Management Groups, such as Management, Connectivity, and Identity. Common Azure Policies for the entire platform is assigned at this level|
|**Management**| This Management Group contains the dedicated subscription for management, monitoring, and security, which will host Azure Log Analytics, Azure Automation, and Azure Sentinel. Specific Azure policies are assigned to harden and manage the resources in the management subscription.|
|**Connectivity**| This Management Group contains the dedicated subscription for connectivity, which will host the Azure networking resources required for the platform, such as Azure Virtual WAN/Virtual Network for the hub, Azure Firewall, DNS Private Zones, Express Route circuits, ExpressRoute/VPN Gateways etc among others. Specific Azure policies are assigned to harden and manage the resources in the connectivity subscription.|
|**Identity**| This Management Group contains the dedicated subscription for identity, which is a placeholder for Windows Server Active Directory Domain Services (AD DS) VMs, or Azure Active Directory Domain Services to enable AuthN/AuthZ for workloads within the landing zones. Specific Azure policies are assigned to harden and manage the resources in the identity subscription.|
|**Landing Zones**| This is the parent Management Group for all the landing zone subscriptions and will have workload agnostic Azure Policies assigned to ensure workloads are secure and compliant.|
|**Online**| This is the dedicated Management Group for Online landing zones, meaning workloads that may require direct internet inbound/outbound connectivity or also for workloads that may not require a VNet..|
|**Corp**| This is the dedicated Management Group for Corp landing zones, meaning workloads that requires connectivity/hybrid connectivity with the corporate network thru the hub in the connectivity subscription.|
|**Sandboxes**| This is the dedicated Management Group for subscriptions that will solely be used for testing and exploration by an organization’s application teams. These subscriptions will be securely disconnected from the Corp and Online landing zones.|
|**Decommissioned**| This is the dedicated Management Group for landing zones that are being cancelled, which then will be moved to this Management Group before deleted by Azure after 30-60 days.|