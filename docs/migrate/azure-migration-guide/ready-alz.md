---
title: Readying your landing zone for migration
description: Review items that need to be completed after an Azure landing zone (ALZ) deployment to ensure the technical environment supports migrations.
author: bstephenson
ms.author: bstephenson
ms.reviewer: tozimmergren
ms.date: 07/07/2023
ms.topic: conceptual
ms.subservice: migrate
---

# Readying your landing zone for migration

If your organization relies on [Azure landing zones](../../ready/landing-zone/index.md) (ALZ), you find useful information in this article about getting your landing zone ready for migrations. This guide also lists the major tasks necessary to ensure configurations are in place to support a migration project.

Regardless of which ALZ [reference implementation](../../ready/enterprise-scale/implementation.md) you have used, there are still tasks necessary to ready your landing zone for a migration project.

If you aren't using one of the ALZ reference implementations, the steps in this guide will still need to be performed. However, you might have prerequisite tasks that you need to do beforehand, or you might need to adapt specific recommendations to your design.

This guide is structured by post-deployment activities for your existing Azure landing zones. Some steps focus on automated deployments but will note if they aren't relevant for manually deployed and managed environments.

## Establishing hybrid connectivity

During ALZ deployment, most organizations deploy a Connectivity subscription with a hub virtual network and network gateways – VPN, ExpressRoute, or both. After ALZ deployment, you must still configure hybrid connectivity from these gateways, connecting to your existing data center appliances or your ExpressRoute circuit.

In the Ready phase, you would have planned for your [connectivity to Azure](../../ready/azure-best-practices/connectivity-to-azure.md). This plan should guide you on what connections you need to perform. For example, if you're using ExpressRoute, you need to work with your provider to establish your ExpressRoute circuit.

See technical guidance for specific scenarios by reviewing the following links:

- [Creating a VPN connection from your Azure VPN Gateway](/azure/vpn-gateway/tutorial-site-to-site-portal)
- [Creating an ExpressRoute circuit](/azure/expressroute/expressroute-howto-circuit-portal-resource-manager)
  - You should refer to your provider's specific documentation as well.
- [Creating an ExpressRoute connection from your Azure ExpressRoute Gateway to your circuit](/azure/expressroute/expressroute-howto-linkvnet-portal-resource-manager)
- [Managing Azure Virtual WAN gateway settings](/azure/virtual-wan/gateway-settings)

If you're establishing your hybrid connectivity to Azure via a third-party Network Virtual Appliances (NVA) deployed in your virtual network, review their specific guidance and our [general guidance for highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha).

## Prepare identity

During the ALZ deployment, organizations deploy supporting architecture for their identity platform. This involves a dedicated identity subscription or resource groups and a virtual network or subnets for the virtual machines used for identity. However, the actual identity resources must be deployed after the ALZ deployment.

This section has guidance for considerations related to Active Directory. If you're using another identity provider, you must follow their guidance on extending your identity to Azure.

Before implementing this, you should review the decisions made for [Active Directory and Hybrid Identity](../../ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity.md) when you planned for your Landing Zone.

You should also review your [identity baseline](../../govern/identity-baseline/index.md) from Govern to determine if you need any Azure AD changes.

### Extending Active Directory domain controllers

In most migration scenarios, the workloads being migrated to Azure are already joined to an existing Active Directory domain. While Azure AD can offer solutions for modernizing identity management even for VM workloads, doing so can disrupt migration. Rearchitecting identity usage for workloads is often an effort saved for modernization or innovation initiatives.

As a result, you need to deploy domain controllers to Azure inside the identity network area you deployed. After deploying the VMs, you must follow your normal DC promotion process to add them to the domain. This can include additional sites created to support your replication topology.

For a common architecture pattern for deploying these resources, review the article on [Deploy AD DS in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain) from the Azure Architecture Center. The AD DS servers could be in a subnet in the hub if you're implementing the [Enterprise-scale for small enterprises](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md) or in their dedicated virtual network for [Enterprise-scale hub and spoke](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) or [Enterprise-scale Virtual WAN](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md).

### Azure AD Connect

Most organizations already have Azure AD Connect to populate Microsoft 365 services like Exchange Online. However, if you haven't implemented this, you might need to deploy Azure AD Connect after your landing zone deployment to replicate identities.

You can use [this guidance](/azure/active-directory/hybrid/connect/how-to-connect-install-roadmap) for installing Azure AD Connect.

## Enable hybrid DNS

Most organizations need to be able to resolve DNS requests for namespaces that are a part of the existing environments. These namespaces often require integration with Active Directory servers. In addition, resources in the existing environment must be able to resolve resources in Azure.

As a result, the configuration of DNS services is needed to support common flows. Azure Landing Zones deploy many of the resources you need, but there are additional items to review.

Review [DNS resolution in Azure](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances) to prepare for these activities.

### Custom DNS resolution

If you're using Active Directory for your DNS resolver or are deploying a third-party solution, VMs need to be deployed. You can use these as your DNS servers if you already have your Domain Controllers deployed to your Identity subscription and network spoke. Otherwise, you must deploy and configure the virtual machines to house these services.

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

For more information on spoke-to-spoke networking, see [Patterns and topologies for inter-spoke communication](/azure/architecture/networking/spoke-to-spoke-networking#patterns-and-topologies-for-inter-spoke-communication)

### Routing From Gateway Subnet

If you're using Virtual Networks for your hub, you need to plan for how your organization handles inspection of traffic coming from your gateways.

If you intend to inspect traffic, there are two configurations needed:

- In your Connectivity Subscription, you need a route table created and linked to the GatewaySubnet. It will need a route for every spoke network you intend to attach, with a next hop of your firewall's IP address.
- In each of your Landing Zone Subscriptions, you need a route table created and linked to each subnet. It needs BGP propagation disabled on it.

You can review the article on [Azure virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) for more information about custom and Azure-defined routes.

In addition, if you intend to inspect traffic to Private Endpoints, you want to ensure that the appropriate routing network policy is enabled on the subnet where the Private Endpoints are hosted. Refer to [manage network policies for private endpoints](/azure/private-link/disable-private-endpoint-network-policy?tabs=network-policy-portal) to learn how these operate.

If you don't intend to inspect traffic, no changes are needed. However, if you add route tables to your spoke network subnets, you want to ensure that BGP propagation is enabled so that it can route back to your gateway.

## Configure Monitoring and Management

As part of deploying your landing zone, you'll have provisioned policies that enroll your resources in Log Analytics. However, you have additional steps necessary to create alerts for your landing zone resources.

A quick way to implement this is to deploy the [Azure Monitor Baseline for Landing Zones](https://aka.ms/alz/monitor/repo). Using this deployment, you gain alerts based on common scenarios for landing zone management, such as connectivity resources and service health.

You can also deploy your own custom alerting for resources if your needs deviate from what is in the baseline.

## Enable Subscription Vending

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
