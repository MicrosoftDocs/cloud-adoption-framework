---
title: Azure Virtual Network Manager in Azure landing zones
description: Learn about key considerations for designing network topologies in Azure with Azure Virtual Network Manager. Learn how to implement Azure landing zone design principles to accommodate application migrations, modernization, and innovation at scale.
author: sitarant
ms.author: sitarant

ms.date: 05/21/2024
ms.topic: concept-article
---

# Azure Virtual Network Manager in Azure landing zones

This article describes how to use Virtual Network Manager to implement Azure landing zone design principles to accommodate application migrations, modernization, and innovation at scale. The Azure landing zones conceptual architecture recommends one of two networking topologies: a network topology that's based on Azure Virtual WAN or a network topology that's based on a traditional hub-and-spoke architecture.

You can use Virtual Network Manager to expand and implement networking changes as your business requirements change over time, such as if you require hybrid connectivity to migrate on-premises applications to Azure. In many cases, you can expand and implement networking changes without disrupting your deployed resources in Azure.  

You can use Virtual Network Manager to create three types of [topologies](/azure/virtual-network-manager/concept-connectivity-configuration) across subscriptions for both existing and new virtual networks:

- Hub-and-spoke topology
- Mesh topology (preview)
- Hub-and-spoke topology with direct connectivity between spokes

:::image type="content" source="../../_images/azure-best-practices/azure-virtual-network-manager-network-topologies.png" alt-text="Diagram that shows Azure virtual network topologies." lightbox="../../_images/azure-best-practices/azure-virtual-network-manager-network-topologies.png" border="false":::

Virtual Network Manager supports Virtual WAN in Private Preview.

A hub-and-spoke topology with direct connectivity in Virtual Network Manager has spokes that connect to each other directly. The [connected group](/azure/virtual-network-manager/concept-connectivity-configuration#connected-group) feature automatically and bi-directionally enables direct connectivity between spoke virtual networks in the same [network group](/azure/virtual-network-manager/concept-network-groups). Two connected groups can have the same virtual network.

You can use Virtual Network Manager to statically or dynamically add virtual networks to specific [network groups](/azure/virtual-network-manager/concept-network-groups). Add virtual networks to specific network groups to define and create your desired topology based on your connectivity configuration in Virtual Network Manager.

You can create multiple network groups to isolate groups of virtual networks from direct connectivity. Each network group provides the same region and multi-region support for spoke-to-spoke connectivity. Stay within the Virtual Network Manager-defined limits. For more information, see [Virtual Network Manager FAQ](/azure/virtual-network-manager/faq#limits).

From a security perspective, Virtual Network Manager provides an efficient way to apply [security administrator rules](/azure/virtual-network-manager/concept-security-admins) that deny or allow traffic flows centrally, regardless of the defined rules in the network security groups (NSGs). This capability allows network security administrators to enforce access controls and enable application owners to manage their own lower-level rules in NSGs.

You can use Virtual Network Manager to group virtual networks. You can then apply configurations to the groups rather than to individual virtual networks. Use this functionality to simultaneously manage connectivity, configuration and topology, security rules, and deployment to one or more regions without loss of fine-grained control.

You can segment networks by environments, teams, locations, lines of business, or some other function that suits your needs. To define network groups statically or dynamically, create a set of conditions that govern group membership.

## Design considerations

- In a traditional hub-and-spoke deployment, you manually create and maintain virtual network peering connections. Virtual Network Manager introduces a layer of automation for virtual network peering, which makes large and complex network topologies like mesh easier to manage at scale. For more information, see [Network group overview](/azure/virtual-network-manager/concept-network-groups).

- The security requirements of various business functions determine the need for creating network groups. A network group is a set of virtual networks that you select manually or through conditional statements. When you create a network group, you need to specify a policy, or Virtual Network Manager can create a policy if you explicitly allow it to. This policy enables Virtual Network Manager to be notified about changes. To update existing Azure policy initiatives, you need to deploy changes to the network group within the Virtual Network Manager resource.

- To design appropriate network groups, you should evaluate which parts of your network share common security characteristics. For example, you can create network groups for Corporate and Online to manage their connectivity and security rules at scale.

- When multiple virtual networks across your organization's subscriptions share the same security attributes, you can use Virtual Network Manager to apply them efficiently. You should, for example, place all systems that a business unit like HR or finance uses in a separate network group because you need to apply different admin rules to them.

- Virtual Network Manager can centrally apply security administrator rules, which have higher priority than NSG rules that are applied at the subnet level. (This feature is in preview.) This feature enables network and security teams to effectively enforce company policies and create security guardrails at scale. It also enables product teams to simultaneously maintain control of NSGs within their landing zone subscriptions.

- You can use the Virtual Network Manager [security administrator rules](/azure/virtual-network-manager/concept-security-admins) feature to explicitly allow or deny specific network flows regardless of NSG configurations at the subnet or network interface levels. You can use this capability, for example, to always permit management services network flows. NSGs that application teams control can't override these rules.

## Design recommendations

- Define the [scope of Virtual Network Manager](/azure/virtual-network-manager/concept-network-manager-scope). Apply security administrator rules that enforce organization-level rules at the root management group or the tenant. This strategy hierarchically applies rules automatically to existing resources, new resources, and to all associated management groups.

- Create a Virtual Network Manager instance in the Connectivity subscription with a [scope](/azure/virtual-network-manager/concept-network-manager-scope) of the intermediate root management group, such as Contoso. Enable the security administrator feature on this instance. This configuration allows you to define security administrator rules that apply across all virtual networks and subnets in your Azure landing zone hierarchy and helps you democratize NSGs to application landing zone owners and teams.

- Segment networks by grouping virtual networks either statically, which is a manual process, or dynamically, which is a policy-based process.

- Enable direct connectivity between spokes when selected spokes need to communicate frequently, with low latency and high throughput, and with each other, and when spokes need to access common services or network virtual appliances (NVAs) in the hub.

- Enable global mesh when all virtual networks across regions need to communicate with each other.  

- Assign a priority value to each security administrator rule in your rule collections. The lower the value, the higher the priority of the rule.

- Use [security administrator rules](/azure/virtual-network-manager/concept-security-admins) to explicitly allow or deny network flows, regardless of NSG configurations that application teams control. Use security administrator rules to fully delegate the control of NSGs and their rules to application teams.

## Next step

> [!div class="nextstepaction"]
> [Automate management of user-defined routes (UDRs)](/azure/virtual-network-manager/concept-user-defined-route)
