---
title: Prepare your landing zone for migration
description: Review items that need to be completed after an Azure landing zone deployment to ensure the technical environment supports migrations.
author: bstephenson
ms.author: bstephenson
ms.reviewer: tozimmergren
ms.date: 04/15/2024
ms.topic: conceptual
---

# Prepare your landing zone for migration

If your organization already aligns to [Azure landing zones](../../ready/landing-zone/index.md), you'll find useful information in this article about getting your landing zone ready for migrations. This guide also lists the major tasks necessary to ensure configurations are in place to support a migration project.

Regardless of which Azure landing zone [reference implementation](../../ready/enterprise-scale/implementation.md) you have used, there are still tasks necessary to ready your landing zone for a successful migration project.

If you don't use an Azure landing zone reference implementation, you still need to perform the steps in this guide. However, you might have prerequisite tasks to perform first, or you might need to adapt specific recommendations to your design.

This guide is structured by post-deployment activities for your existing Azure landing zones. Some steps focus on automated deployments. It's noted if they aren't relevant for manually deployed and managed environments.

## Establish hybrid connectivity

During Azure landing zone deployment, most organizations deploy a Connectivity subscription with a hub virtual network and network gateways, such as Azure VPN gateways, Azure ExpressRoute gateways, or both. After Azure landing zone deployment, you must still configure hybrid connectivity from these gateways, connecting to your existing data center appliances or your ExpressRoute circuit.

In the ready phase, you planned for your [connectivity to Azure](../../ready/azure-best-practices/connectivity-to-azure.md). Use this plan to determine what connections you need to perform. For example, if you use ExpressRoute, you must work with your provider to establish your ExpressRoute circuit.

To get technical guidance for specific scenarios, see:

- [Create a VPN connection from your Azure VPN Gateway](/azure/vpn-gateway/tutorial-site-to-site-portal).
- [Create an ExpressRoute circuit](/azure/expressroute/expressroute-howto-circuit-portal-resource-manager).
- [Create an ExpressRoute connection from your Azure ExpressRoute gateway to your circuit](/azure/expressroute/expressroute-howto-linkvnet-portal-resource-manager).
- [Manage Azure Virtual WAN gateway settings](/azure/virtual-wan/gateway-settings).

> [!NOTE]
> Also refer to your provider's specific documentation.

If you're establishing your hybrid connectivity to Azure via a third-party network virtual appliances (NVA) deployed in your virtual network, review their specific guidance and our [general guidance for highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha).

## Prepare identity

During the Azure landing zone deployment, you should also deploy a supporting architecture for your identity platform. You might have a dedicated identity subscription or resource groups and a virtual network or subnets for the virtual machines (VMs) that you use for identity. However, you must deploy the identity resources after the Azure landing zone deployment.

This section has guidance for considerations related to Active Directory. If you use a different identity provider for authentication and authorizations, you must follow their guidance on extending your identity to Azure.

Before you implement this guidance, review your [Active Directory and hybrid identity](../../ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity.md) decisions when you planned for your landing zone.

You should also review your [identity baseline](../../govern/identity-baseline/index.md) from the governance phase to determine if you need to make changes in Microsoft Entra ID.

### Extend Active Directory domain controllers

In most migration scenarios, the workloads that you migrate to Azure are already joined to an existing Active Directory domain. Microsoft Entra ID can offer solutions for modernizing identity management, even for VM workloads, but it can disrupt migration. Rearchitecting identity usage for workloads is often performed during modernization or innovation initiatives.

As a result, you need to deploy domain controllers to Azure inside the identity network area that you deployed. After you deploy the VMs, you must follow your normal domain controller promotion process to add them to the domain. This process might include creating additional sites to support your replication topology.

For a common architecture pattern to deploy these resources, see [Deploy Active Directory Domain Services (AD DS) in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain).

If you implement the [enterprise-scale architecture for small enterprises](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md), the AD DS servers are often in a subnet in the hub. If you implement the [enterprise-scale hub-and-spoke architecture](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) or the [enterprise-scale Virtual WAN architecture](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md), the servers are often in their dedicated virtual network.

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

Most organizations already have Microsoft Entra Connect to populate Microsoft 365 services, like Exchange Online. If your organization doesn't have Microsoft Entra Connect, you might need to [install it](/azure/active-directory/hybrid/connect/how-to-connect-install-roadmap) and deploy it after your landing zone deployment so you can replicate identities.

## Enable hybrid DNS

Most organizations need to be able to resolve DNS requests for namespaces that are a part of the existing environments. These namespaces often require integration with Active Directory servers. And resources in the existing environment must be able to resolve resources in Azure.

As a result, you need to configure DNS services to support common flows. You can use Azure landing zones to deploy many of the resources you need, but there are additional items to review.

To prepare for these activities, see [DNS resolution in Azure](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances).

### Custom DNS resolution

If you're using Active Directory for your DNS resolver or are deploying a third-party solution, VMs need to be deployed. You can use these as your DNS servers if you already have your Domain Controllers deployed to your Identity subscription and network spoke. Otherwise, you must deploy and configure the VMs to house these services.

Once deployed, it needs to be integrated into your existing DNS platform so that it's able to perform lookups against your existing namespaces. For Active Directory DNS servers, this is provided automatically.

You can also use [Azure Private Resolver](/azure/dns/dns-private-resolver-overview), but this resource isn't deployed as part of your Azure Landing Zone deployment.

If your design uses Private DNS Zones, plan actions accordingly, such as those commonly used with Private Endpoints, review [Azure Private Endpoint DNS configuration](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances?tabs=redhat#specify-dns-servers). The Private DNS zones are deployed as part of your Landing Zone. Still, when you're performing modernization efforts using Private Endpoints, you have an additional configuration for them.

### Azure Firewall DNS Proxy

The Azure Firewall can act as a [DNS proxy](/azure/firewall/dns-details), receiving traffic and forwarding it to the Azure resolver or your DNS servers. This can be used to allow for lookups from on-premises to Azure but can't conditionally forward back to on-premises DNS servers.

As a result, if hybrid DNS resolution is needed, the Azure Firewall DNS Proxy can be set to forward to your custom DNS servers (such as your domain controllers).

This is an optional step, but using this has several benefits. It reduces configuration changes later if you change DNS services and enables FQDN rules in the Azure firewall.

### Setting custom virtual network DNS servers

Once you've completed the previous activities, you can set the DNS servers for your Azure virtual networks to the custom servers you use.

To learn more, see [Azure Firewall DNS settings](/azure/firewall/dns-settings).

## Configure hub firewall

If you have deployed a firewall in your hub network, there are a few considerations that you should address to be ready to migrate workloads. Organizations can run into routing and network access issues by not addressing these earlier in their deployments.

As part of performing these activities, review the [networking design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity), especially for [Network Security guidance](../../ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md).

If you deploy a third-party NVA as your firewall, use the vendor's guidance and our [general guidance for highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha) to guide your deployment.

### Deploy standard rule sets

If you use an Azure Firewall, all firewall traffic is blocked until explicit allow rules are added. Many other NVA firewalls work similarly, where traffic is denied until rules for what traffic is permitted are defined.

While you should add individual rules and rule collections based on workload needs, you should plan to have your standard rules that apply to all workloads enabled, such as access to Active Directory or other identity and management solutions.

## Routing

Azure itself provides routing for the following scenarios with no additional configuration:

- Routing between resources in the same virtual network.
- Routing between resources in peered virtual networks.
- Routing between resources and a virtual network gateway, either in its own virtual network or a peered one set to use the gateway.

Two common routing scenarios need additional actions, both involving route tables assigned to subnets to shape routing. [This article](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) provides more information about Azure routing and custom routes.

### Inter-spoke routing

As part of the [network design area](../../ready/azure-best-practices/traditional-azure-networking-topology.md), many organizations opt to use a [hub-spoke network topology](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli).

You need routes that take traffic from one spoke to another to allow routing between spokes. A default route (`0.0.0.0/0`) to your firewall will be sufficient and works best to simplify routing. With this route in place, traffic to any unknown location heads to the firewall, enabling inspection and applying your firewall rules.

If you want to allow for internet egress, you can also assign another route for your private IP space to the firewall, such as `10.0.0.0/8`. This won't overrule more specific routes but can be used as a simple route to let inter-spoke traffic route correctly.

For more information on spoke-to-spoke networking, see [Patterns and topologies for inter-spoke communication.](/azure/architecture/networking/spoke-to-spoke-networking#patterns-and-topologies-for-inter-spoke-communication)

### Routing From Gateway Subnet

If you're using Virtual Networks for your hub, you need to plan for how your organization handles inspection of traffic coming from your gateways.

If you intend to inspect traffic, there are two configurations needed:

- In your Connectivity Subscription, you need a route table created and linked to the GatewaySubnet. It will need a route for every spoke network you intend to attach, with a next hop of your firewall's IP address.
- In each of your Landing Zone Subscriptions, you need a route table created and linked to each subnet. It needs BGP propagation disabled on it.

You can review the article on [Azure virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) for more information about custom and Azure-defined routes.

In addition, if you intend to inspect traffic to Private Endpoints, you want to ensure that the appropriate routing network policy is enabled on the subnet where the Private Endpoints are hosted. Refer to [manage network policies for private endpoints](/azure/private-link/disable-private-endpoint-network-policy) to learn how these operate.

If you don't intend to inspect traffic, no changes are needed. However, if you add route tables to your spoke network subnets, you want to ensure that BGP propagation is enabled so that it can route back to your gateway.

## Configure monitoring and management

As part of deploying your landing zone, you'll have provisioned policies that enroll your resources in Log Analytics. However, you have additional steps necessary to create alerts for your landing zone resources.

A quick way to implement this is to deploy the [Azure Monitor Baseline for Landing Zones](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz). Using this deployment, you gain alerts based on common scenarios for landing zone management, such as connectivity resources and service health.

You can also deploy your own custom alerting for resources if your needs deviate from what is in the baseline.

## Enable subscription vending

This section applies to organizations that want to automate their subscription provisioning process. If you manually manage your landing zone and subscription creation, you should establish your own process for creating subscriptions.

Once you begin migrating, you must create subscriptions for your workloads. Enable [Subscription vending](../../ready/landing-zone/design-area/subscription-vending.md) to automate and accelerate this step. Once established, you should be able to create subscriptions quickly.

## Prepare for Defender for Cloud

When you deploy your landing zone, you also set policies to enable [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) for your Azure subscriptions. Defender for Cloud provides security posture recommendations through [Secure Score](/azure/defender-for-cloud/secure-score-security-controls), which evaluates deployed resources against Microsoft's security baseline.

While no additional technical configuration is needed, you should review the recommendations and design a plan to [improve your security posture](/azure/defender-for-cloud/review-security-recommendations) as you migrate resources. Once you begin migrating resources into Azure, you should be ready to [implement security improvements](/azure/defender-for-cloud/implement-security-recommendations) as part of your migration optimization.

## Learn more

Consider these additional resources to prepare:

- [Ensure that you have your initial corporate policy defined and well understood](../../govern/guides/standard/initial-corporate-policy.md)
- [Ensure that you have adequate planning for Azure Billing](../../ready/landing-zone/design-area/azure-billing-ad-tenant.md)
- [Your organizational alignment](../../plan/initial-org-alignment.md) and how you intend to [continue to manage it](../../organize/index.md)
- [Ensuring consistency with your naming and tagging standards](../../ready/azure-best-practices/naming-and-tagging.md)

## Next steps

> [!div class="nextstepaction"]
> [Prepare tools and an initial migration backlog](./tools-backlog.md)
