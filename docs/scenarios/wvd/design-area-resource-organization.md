---
title: Implementation design area guidance for Azure Virtual Desktop
description: Explore the resource organization design area and how to apply it to an Azure Virtual Desktop implementation.
author: DominicAllen
ms.author: doalle
ms.date: 06/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Resource organization considerations for Azure Virtual Desktop

As with all cloud environments, the structure within which resources are deployed will have a direct bearing on how they are managed and governed.

The following considerations and recommendations will help establish proper resource organization and segmentation across management group hierarchies, subscriptions, landing zones, and resource groups. It will also help establish proper tagging strategies to keep resources organized.

## Design considerations

### How many Azure Virtual Desktop virtual machines will you require?

You shouldn't deploy more than 5,000 virtual machines per region (for both personal and host pools based on Windows 10 Enterprise single and multi-session). Increasing the resources of an individual session host virtual machine can help to accommodate more user sessions.

To manage enterprise environments with more than 5,000 VMs per Azure subscription in the same region, you can create multiple Azure subscriptions in a hub-spoke architecture and connect them via virtual network peering, as in the preceding example architecture. You could also deploy VMs in a different region in the same subscription to increase the number of VMs.

### Which regions will the hosts be deployed in?

Consider deploying your hosts to Azure regions that are closest to your users in order to help with performance related to network connectivity and latency. Also consider compliance and data residency requirements when choosing a specific region.

## Design recommendations

### Naming and tagging

Use naming and tagging standards to organize resources and help simplify resource management, cost tracking and governance.

Maintaining consistency across resources helps identify deviation from agreed-upon policies. [Prescriptive guidance for resource tagging](../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) demonstrates how one of the following patterns can help when deploying governance practices. Similar patterns are available to evaluate regulatory compliance using tags.

A standardized naming convention is the starting point for organizing your cloud-hosted resources. A properly structured naming system allows you to quickly identify resources for both management and accounting purposes. If you have existing IT naming conventions in other parts of your organization, consider whether your cloud naming conventions should align with them or if you should establish separate cloud-based standards.

### Management groups and subscriptions

As part of the Azure landing zone best practices, resources should be grouped logically in management groups in order to target policy and initiative assignments using Azure Policy.

Create management groups under your root-level management group to represent the types of workloads (archetypes) that you'll host and ones based on their security, compliance, connectivity, and feature needs. This grouping structure allows you to have a set of Azure policies applied at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

Subscriptions serve as a scale unit so that component workloads can scale within the platform [subscription limits](/azure/azure-subscription-service-limits). Make sure to consider subscription resource limits during your workload design sessions.

Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns.

## Next steps

[Further reading on recommendations for Azure Virtual Desktop resource organization](/azure/architecture/example-scenario/wvd/windows-virtual-desktop#azure-limitations)

[Further reading on recommendations for naming and tagging in Azure](../../decision-guides/resource-tagging/index.md)