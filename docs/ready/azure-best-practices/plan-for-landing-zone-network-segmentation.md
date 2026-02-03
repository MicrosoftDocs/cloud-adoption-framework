---
title: Plan for landing zone network segmentation
description: Examine key design considerations and recommendations surrounding network segmentation with Azure landing zones.
author: sebassem
ms.author: sebassem
ms.date: 07/31/2024
ms.topic: concept-article
ms.custom: think-tank
---

# Plan for landing zone network segmentation

This section explores key recommendations to deliver highly secure internal network segmentation within a landing zone to drive a network Zero Trust implementation.

## Design considerations

- The [Zero Trust model](/security/zero-trust/deploy/networks) assumes a breached state and verifies each request as though it originates from an uncontrolled network.

- An advanced Zero Trust network implementation employs fully distributed ingress and egress cloud micro-perimeters and deeper micro-segmentation.

- [Network security groups (NSGs)](/azure/virtual-network/network-security-groups-overview) can use Azure [service tags](/azure/virtual-network/service-tags-overview) to facilitate connectivity to Azure platform as a service (PaaS) solutions.

- [Application security groups (ASGs)](/azure/virtual-network/application-security-groups) don't span or provide protection across virtual networks.

- Use [virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) to inspect traffic that flows through virtual networks. Virtual network flow logs provide capabilities that are similar to [NSG flow logs](/azure/network-watcher/nsg-flow-logs-overview) but cover a wider range of use cases. They also simplify the scope of traffic monitoring because you can enable logging at the virtual network level.

> [!NOTE]
> On September 30, 2027, network security group (NSG) flow logs will be retired. As part of this retirement, you'll no longer be able to create new NSG flow logs starting June 30, 2025. We recommend [migrating to virtual network flow logs](/azure/network-watcher/nsg-flow-logs-migrate), which overcome the limitations of NSG flow logs. After the retirement date, traffic analytics enabled with NSG flow logs will no longer be supported, and existing NSG flow logs resources in your subscriptions will be deleted. However, NSG flow logs records won't be deleted and will continue to follow their respective retention policies. For more information, see the [retirement notice](https://azure.microsoft.com/updates?id=Azure-NSG-flow-logs-Retirement).

## Design recommendations

- Delegate subnet creation to the landing zone owner. This will enable them to define how to segment workloads across subnets (for example, a single large subnet, multitier application, or network-injected application). The platform team can use Azure Policy to ensure that an NSG with specific rules (such as deny inbound SSH or RDP from the internet, or allow/block traffic across landing zones) is always associated with subnets that have deny-only policies.

- Use NSGs to help protect traffic across subnets and east/west traffic across the platform (traffic between landing zones).

- The application team should use application security groups at the subnet-level NSGs to help protect multitier VMs within the landing zone.

    [![Diagram that shows how application security group works.](./media/azure-asg.png)](./media/azure-asg.png#lightbox)

- Use NSGs and application security groups to micro-segment traffic within the landing zone and avoid using a central NVA to filter traffic flows.

- Enable [virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) and use [traffic analytics](/azure/network-watcher/traffic-analytics) to gain insights into ingress and egress traffic flows. Enable flow logs on all critical virtual networks and subnets in your subscriptions, for example virtual networks and subnets that contain Windows Server Active Directory domain controllers or critical data stores. Additionally, you can use flow logs to detect and investigate potential security incidents, compliance and monitoring, and to optimize usage.

- Plan and migrate your current NSG flow logs configuration to virtual network flow logs. See [Migrate NSG flow logs](/azure/network-watcher/nsg-flow-logs-migrate).

- Use NSGs to selectively allow connectivity between landing zones.

- For Virtual WAN topologies, route traffic across landing zones via Azure Firewall if your organization requires filtering and logging capabilities for traffic flowing across landing zones.

- If your organization decides to implement forced tunneling (advertise default route) to on-premises, we recommend incorporating the following **outbound** NSG rules to deny egress traffic from VNets directly to the internet should the BGP session drop.

> [!NOTE]
> Rule priorities will need to be adjusted based on your existing NSG rule set.

  | Priority | Name | Source | Destination | Service | Action | Remark |
  | --- | --- | --- | --- | --- | --- | --- |
  | 100 | `AllowLocal` | `Any` | `VirtualNetwork` | `Any` | `Allow` | Allow traffic during normal operations. With forced tunneling enabled, `0.0.0.0/0` is considered part of the `VirtualNetwork` tag as long as BGP is advertising it to the ExpressRoute or VPN Gateway. |
  | 110 | `DenyInternet` | `Any` | `Internet` | `Any` | `Deny` | Deny traffic directly to the internet if the `0.0.0.0/0` route is withdrawn from the routes advertised (for example, due to an outage or misconfiguration). |

> [!CAUTION]
> Azure PaaS services that can be injected into a virtual network might not be compatible with forced tunneling. Control plane operations may still require direct connectivity to specific public IP addresses for the service to operate correctly. It's recommended to check the specific service documentation for networking requirements and eventually exempt the service subnet from the default route propagation. [Service Tags in UDR](/azure/virtual-network/virtual-networks-udr-overview#service-tags-for-user-defined-routes) can be used to bypass default route and redirect control plane traffic only, if the specific service tag is available.