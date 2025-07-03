---
title: Resource organization considerations for Azure Virtual Desktop
description: Learn about the resource organization design area and how to apply it to your Azure Virtual Desktop implementation effectively.
author: Zimmergren
ms.author: pnp
ms.date: 02/07/2025
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Resource organization considerations for Azure Virtual Desktop

Resource organization affects how you manage and govern your Azure Virtual Desktop resources. This article provides key considerations and recommendations for designing an organization's structure.

Use this guidance to ensure resource organization and segmentation across:

- Management group hierarchies.
- Subscriptions.
- Resource groups.
- Landing zones.

## Design considerations

The following sections describe key considerations for organizing your Azure Virtual Desktop resources.

### Number of virtual machines

When you plan the number of Azure Virtual Desktop virtual machines (VMs) that your organization needs, consider the following factors:

- Avoid deploying more than 5,000 VMs in a single region because it can create performance bottlenecks, exceed subscription limits, and decrease resiliency. You can accommodate extra user sessions by increasing individual session host VM resources.

- For [enterprise environments](/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop) that exceed 5,000 VMs per subscription in each region, create multiple Azure subscriptions by using a [hub-and-spoke architecture](/azure/architecture/networking/architecture/hub-spoke) and connect them through [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). Alternatively, VMs can be deployed within the same subscription but across different regions to increase the number of VMs.

### Regions for host deployment

Deploy all resources to the same Azure region as your Azure Virtual Desktop deployment. The main resources include:

- Metadata or service objects like host pools, application groups, and workspaces.

- Session host or virtual desktop compute resources like VMs, disks, and network interfaces.

- Virtual networks that directly connect to session hosts.

- Storage for FSLogix user profiles.

- Other resources like Azure compute galleries, key vaults, and images.

To manage regions for host deployment:

- Deploy session hosts in Azure regions that are closest to users and necessary resources. This approach minimizes network and application latency, which enhances overall performance. For example, session hosts in central India that reach services in the central US often increase application latency. Placing them closer to the required resources helps mitigate this risk.

- Ensure compliance with regional regulations and data residency requirements when you choose a region.

- Avoid mixing session hosts from different Azure regions. For example, don't mix central India and central US in the same host pool because you can't assign users to a session host in a specific Azure region. Instead, create separate session hosts for each Azure region.

## Design recommendations

The following sections provide guidance on how to manage groups, naming, and tagging in Azure Virtual Desktop.

### Management settings scope

The four levels of management that Azure provides are management groups, subscriptions, resource groups, and resources. You can apply management settings like policies and role-based access control at any management level.

The following image shows an example of the recommended structure and resource groups to create and use as administrative domains and for lifecycle management in each Azure region.

:::image type="content" source="../../../docs/scenarios/azure-virtual-desktop/media/azure-virtual-desktop-resource-management-1.png" alt-text="Screenshot that shows the Azure Virtual Desktop shared resources subscription." lightbox="../../../docs/scenarios/azure-virtual-desktop/media/azure-virtual-desktop-resource-management-1.png":::

#### Components

- **Azure Virtual Desktop service objects:** Create a resource group for Azure Virtual Desktop service objects from the host pool VMs. Service objects include workspaces, host pools, and application groups.

- **Networking:** Networking is typically created as part of your Azure landing zone.

- **Storage:** Create a resource group for storage accounts, if it's not already created as part of your Azure landing zone.

- **Session hosts compute:** Create a resource group for VMs, disks, and network interfaces. These resources have a different lifecycle from Azure Virtual Desktop service objects.

- **Shared resources:** Create a resource group for shared resources such as custom VM images. This approach promotes self-service. For example, you can have a subscription for each business line.

  - Basic structure:
    - Subscription Azure Virtual Desktop-shared-resources
      - rg-avd-<_Azure-Region_>-shared-resources
    - Subscription Azure Virtual Desktop landing zone
      - rg-avd-<_Azure-Region_>-<_Workload_>-service-objects
      - rg-avd-<_Azure-Region_>-<_Workload_>-pool-compute
      - rg-avd-<_Azure-Region_>-<_Workload_>-network
      - rg-avd-<_Azure-Region_>-<_Workload_>-storage

  :::image type="content" source="../../../docs/scenarios/azure-virtual-desktop/media/azure-virtual-desktop-resource-management-2.png" alt-text="Screenshot that shows the AVD service objects and compute subscription." lightbox="../../../docs/scenarios/azure-virtual-desktop/media/azure-virtual-desktop-resource-management-2.png":::

### Naming standards

A consistent naming standard helps organize resources, streamline management, enable cost tracking, and ensure effective governance. Your naming strategy should include business and operational details in resource names.

- Business details should include the organizational information to identify teams. Use the resource's short name and the names of the business owners who are responsible for the resource costs.

- Operational details should include information that helps IT teams identify the workload, application, environment, criticality, and other relevant aspects necessary for managing resources.

A well-structured naming system enables rapid resource identification for both management and accounting. Consistent naming across resources helps identify any deviations from agreed-upon policies. Consider whether to align your cloud naming conventions with existing IT standards or to establish unique conventions for the cloud. For more information, see [Develop a naming strategy for Azure resources](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging).

### Resource tags

Resource tags help evaluate regulatory compliance by logically categorizing Azure resources. For more information about how patterns can support governance practices, see [Govern overview](../../govern/guides/complex/prescriptive-guidance.md#resource-tagging).

Each tag consists of a name and a value. You can use tags to provide context about the associated workload, application, operational requirements, or ownership. For example, you can apply the tag name _environment_ with the value _production_ to categorize all production resources.

Common uses for tags include:

- **Metadata and documentation:** Tags like _ProjectOwner_ help administrators easily view resource details.

- **Automation:** Tags like _ShutdownTime_ or _DeprovisionDate_ can trigger actions through scripts.

- **Cost optimization:** You can use tags to allocate resources to specific teams who are responsible for the costs. In [Microsoft Cost Management](/azure/cost-management-billing/), you can filter reports by the cost center tag to track charges by team or department.

## Related resources

For more information about Azure Virtual Desktop organization and management, see:

- [Azure Virtual Desktop for the enterprise](/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop#azure-limitations)
- [Organize your Azure resources effectively](../../ready/azure-setup-guide/organize-resources.md)
- [Resource naming and tagging decision guide](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)

## Next step

Learn more about management and monitoring for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Management baseline considerations for an Azure Virtual Desktop](./eslz-management-and-monitoring.md)
