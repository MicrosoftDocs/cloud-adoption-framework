---
title: Design guidance for Azure Virtual Desktop
description: Learn about the resource organization design area and how to apply it to your Azure Virtual Desktop implementation.
author: martinekuan
ms.author: martinek
ms.date: 04/19/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Resource organization considerations for Azure Virtual Desktop

The structure of your resource storage directly determines your options for implementing resource management and governance. This article contains considerations and recommendations to help you design an organization's structure.

Use the guidance this section provides to ensure resource organization and segmentation across:

- management group hierarchies
- subscriptions
- resource groups
- landing zones

Consider using tagging strategies to help organize your resources.

## Design considerations

The following sections list things you should consider when planning your organization's Azure Virtual Desktop structure.

### Number of virtual machines

How many Azure Virtual Desktop virtual machines (VMs) does your organization require?

Don't deploy more than 5,000 VMs in a single region. You can accommodate extra user sessions by increasing individual session host VM resources.

If you instead manage an enterprise environment with over 5,000 VMs per subscription in a single region, you should create multiple Azure subscriptions. Place these subscriptions in a hub-spoke architecture, and connect them through virtual network peering. You can increase the number of VMs by deploying VMs in a different region of the same subscription.

### Regions for host deployment

When you deploy hosts, which regions should you choose?

We generally recommend that you store all resources in the same Azure Region as your deployment of Azure Virtual Desktop. The main resources involved are:

- Metadata (Services Objects), such as Host Pools, Application Groups, and Workspaces
- Session Hosts (Virtual Desktops) compute, such as virtual machines, disks, and network interfaces.
- VNets (the VNet where the Session Hosts are directly connected)
- Storage (for FSLogix user profiles)
- Other resources, such as Azure Compute Galleries, Key Vaults, or images.

### Other considerations

- Deploying session hosts to the Azure regions closest to your users reduces network connectivity and latency issues and can improve performance.
- Always consider regional compliance and data residency requirements before you choose a specific region.
- If you run applications in session hosts in one Azure Region (like Central India) and they need to reach services in another Azure Region (like Central US), application latency often increases. If your session hosts are instead closer to the Azure Region with needed resources (in our current example, Central US), application latency is much less likely to increase.
- Since you can't assign users to a session host in a specific Azure Region, don't mix session hosts located in different Azure Regions (for example, Central India and Central US) in the same host pool. Create separate session hosts for each Azure Region instead.

## Design recommendations

The following sections offer recommendations for labeling and organizing resources in Azure Virtual Desktop.

### Naming and tagging

Naming and tagging standards help you organize resources and simplify resource management, cost tracking, and governance.

Maintain consistency across resources to help you identify any deviation from agreed-upon policies. [Prescriptive guidance for resource tagging](../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) describes how one of the following patterns is helpful for deploying governance practices. Similar patterns are available for using tags to evaluate regulatory compliance.

A standardized naming convention is your starting point for organizing cloud-hosted resources. Properly structured naming systems allow rapid resource identification for both management and accounting purposes. If you follow existing IT naming conventions in other parts of your organization, consider whether to align your cloud naming conventions with them or make your cloud naming conventions unique and separate.

### Management groups and subscriptions

Group resources logically in management groups so you can target policy and initiative assignments with Azure Policy.

Create management groups under your root-level management group to represent the types of workloads (archetypes) you host, and management groups based on their security, compliance, connectivity, and feature needs. If you use this grouping structure, you can apply a set of Azure policies at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

Subscriptions serve as a scale unit so component workloads can scale within your platform [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). Remember to consider subscription resource limits during your workload design sessions.

Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns. The following diagrams show the structure and Resource Groups we recommend you create and use as administrative domains and lifecycle purposes for each Azure Region you deploy.

```text
    - Azure Virtual Desktop Service Objects:  Create a Resource Group for Azure Virtual Desktop Service Objects from Host Pool VMs.  Service objects like Workspaces, Host Pools and Application Groups.  
    - Networking:  Generally created as part of the Cloud Adoption Framework Landing zone
    - Storage:  If not already created as part of Cloud Adoption Framework, create a resource group for storage accounts
    - Session hosts compute: Create a Resource Group for Virtual Machines, Disks and Network Interfaces. These have a different life cycle than the Azure Virtual Desktop Service Objects. 
    - Shared Resources:  Create a Resource Group for shared resources like custom VM images, this encourages self-service so you could have a subscription for each business line, for instance.
    
    - Basic Structure:
        - Subscription (AVD-Shared-Resources)
            - rg-<Azure-Region>-avd-shared-resources
        - Subscription (AVD)
            - rg-<Azure-Region>-avd-<Workload>-service-objects
            - rg-<Azure-Region>-avd-<Workload>-network
            - rg-<Azure-Region>-avd-<Workload>-pool-compute
            - rg-<Azure-Region>-avd-<Workload>-storage
```

Below is an example from the recommended structure above for the Azure Virtual Desktop resources already deployed.

:::image type="content" source="../../../docs/scenarios/azure-virtual-desktop/media/avd-resource-management-1.png" alt-text="Screenshot that shows the AVD Shared Resources subscription." lightbox="../../../docs/scenarios/azure-virtual-desktop/media/avd-resource-management-1.png":::

:::image type="content" source="../../../docs/scenarios/azure-virtual-desktop/media/avd-resource-management-2.png" alt-text="Screenshot that shows the AVD Service Objects and compute subscription.":::

## Additional guidance and examples 

- [Azure Virtual Desktop resource organization](/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop#azure-limitations)
- [Naming and tagging in Azure](../../ready/azure-best-practices/resource-naming-and-tagging-decision-guide.md)

## Next steps

Learn about management and monitoring for an Azure Virtual Desktop enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Management and monitoring](./eslz-management-and-monitoring.md)
