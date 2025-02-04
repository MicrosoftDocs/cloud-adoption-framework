---
title: Design guidance for Azure Virtual Desktop
description: Learn about the resource organization design area and how to apply it to your Azure Virtual Desktop implementation.
author: martinekuan
ms.author: martinek
ms.date: 04/19/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Management group and subscription organization for Azure Virtual Desktop

Resource organization affects how you manage and govern your Azure Virtual Desktop (AVD) resources. This article provides key considerations and recommendations for designing an organization's structure.

Use this guidance to ensure resource organization and segmentation across:

- Management group hierarchies
- Subscriptions
- Resource groups
- Landing zones (LZs)

## Design considerations

These sections outline key considerations for organizing your AVD resources.

### Number of virtual machines

How many Azure Virtual Desktop virtual machines (VMs) does your organization require?

- Avoid deploying more than 5,000 VMs in a single region. You can accommodate extra user sessions by increasing individual session host VM resources.
- For [enterprise environments](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop) exceeding 5,000 VMs per subscription per region, create multiple Azure subscriptions using a [hub-spoke architecture](/azure/cloud-adoption-framework/ready/azure-best-practices/hub-spoke-network-topology) and connect them through [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). Alternatively, deploy VMs within the same subscription but across different regions to increase the number of VMs.

### Regions for host deployment

Which region do you choose for deploying hosts?

Deploy all resources to the same Azure region as your Azure Virtual Desktop deployment. The main resources involved are:
- **Metadata (Services Objects)**: Host Pools, Application Groups, and Workspaces.
- **Session Hosts (Virtual Desktops) compute**: Virtual machines, disks, and network interfaces.
- **VNets** (the VNet where the Session Hosts are directly connected)
- **Storage** (for FSLogix user profiles)
- **Other resources**: Azure Compute Galleries, Key Vaults, and images.

- Deploy session hosts in Azure regions closest to your users to reduce network latency and improve performance.
- Ensure compliance with regional regulations and data residency requirements when selecting a region
- Running applications in session hosts located far from services (for example, session hosts in Central India reaching services in Central US) often increase application latency. Placing session hosts closer to the required resources may reduce this risk (Central US in this example).
- Avoid mixing session hosts from different Azure regions (for example, Central India and Central US) in the same host pool as you can't assign users to a session host in a specific Azure Region. Create separate session hosts for each Azure Region instead.

## Design recommendations

These sections offer guidance on managing groups, naming, and tagging in Azure Virtual Desktop.

### Management settings scope

Azure provides four levels of management: management groups, subscriptions, resource groups, and resources. You can apply management settings like policies and role-based access control at any management level. 

The following is an example of the recommended structure and resource groups to create and use as administrative domains and for lifecycle management in each Azure region.

:::image type="content" source="../../../docs/scenarios/azure-virtual-desktop/media/avd-resource-management-1.png" alt-text="Screenshot that shows the AVD Shared Resources subscription." lightbox="../../../docs/scenarios/azure-virtual-desktop/media/avd-resource-management-1.png":::
- Components
    - Azure Virtual Desktop Service Objects: Create a resource group for Azure Virtual Desktop Service Objects from Host Pool VMs. Service objects like Workspaces, Host Pools, and Application Groups.
    - Networking: Typically created as part of your Azure landing zone.
    - Storage: Create a resource group for storage accounts, if not already created as part of your Azure landing zone.
    - Session hosts compute: Create a Resource Group for virtual machines, disks, and network interfaces. These resources have a different lifecycle from Azure Virtual Desktop Service Objects.
    - Shared Resources: Create a Resource Group for shared resources such as custom VM images. It encourages self-service so you could have a subscription for each business line, for instance.
- Basic Structure:
    - Subscription AVD-Shared-Resources
        - rg-avd-<_Azure-Region_>-shared-resources
    - Subscription AVD LZ
        - rg-avd-<_Azure-Region_>-<_Workload_>-service-objects
        - rg-avd-<_Azure-Region_>-<_Workload_>-pool-compute
        - rg-avd-<_Azure-Region_>-<_Workload_>-network
        - rg-avd-<_Azure-Region_>-<_Workload_>-storage


:::image type="content" source="../../../docs/scenarios/azure-virtual-desktop/media/avd-resource-management-2.png" alt-text="Screenshot that shows the AVD Service Objects and compute subscription." lightbox="../../../docs/scenarios/azure-virtual-desktop/media/avd-resource-management-2.png":::

### Naming standards

A consistent naming standard helps organize resources, streamline management, enable cost tracking, and ensure effective governance. Your naming strategy should include business and operational details in resource names.

- Business details should include the organizational information to identify teams. Use the resource's short name along with the names of the business owners who are responsible for the resource costs.
- Operational details should include the information helpful for IT teams to identify the workload, application, environment, criticality, and other information that's useful for managing resources.

A well-structured naming system allows for rapid resource identification for both management and accounting purposes. Consistency across resources helps identify any deviations from agreed-upon policies. Consider whether to align your cloud naming conventions with existing IT naming standards or to create separate, unique conventions for the cloud. [Prescriptive guidance for resource tagging](../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) outlines how patterns can support governance practices. 

### Resource tags

Resource tags can help evaluate regulatory compliance by logically organizing Azure resources into categories.

Each tag consists of a name and a value. You can use them to provide context about the associated workload, application, operational requirements, or ownership. For example, you can apply the tag name _environment_ with the value _production_ to categorize all production resources.

Common uses for tags include:

- **Metadata and documentation**: Tags like _ProjectOwner_ help administrators easily view resource details.
- **Automation**: Tags such as _ShutdownTime_ or _DeprovisionDate_ can trigger actions through scripts.
- **Cost optimization**: Tags can be used to allocate resources to specific teams who are responsible for the costs. In [Microsoft Cost Management](/azure/cost-management-billing/), you can filter reports by cost center tag to track charges by team or department.

## Next steps

Learn more about Azure Virtual Desktop organization and management, see:

- [Azure Virtual Desktop resource organization](/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop#azure-limitations)
- [Organize your Azure resources effectively](../../ready/azure-setup-guide/organize-resources.md)
- [Naming and tagging in Azure](../../ready/azure-best-practices/resource-naming-and-tagging-decision-guide.md)

Learn about management and monitoring for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Management and monitoring](./eslz-management-and-monitoring.md)
e
