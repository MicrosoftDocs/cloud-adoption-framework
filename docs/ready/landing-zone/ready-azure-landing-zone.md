---
title: Prepare your landing zone for migration
description: Learn about the tasks that you need to complete after an Azure landing zone deployment to ensure that the technical environment supports migrations.
author: bstephenson
ms.author: bstephenson
ms.reviewer: tozimmergren
ms.date: 04/10/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Prepare your landing zone for migration

This article describes how to get your [Azure landing zone](../../ready/landing-zone/index.md) ready for a migration. It also lists the major tasks you must perform to ensure that configurations are in place for your migration project.

Regardless of which [Azure landing zone reference implementation](../../ready/enterprise-scale/implementation.md) you used, you must perform some tasks to prepare your landing zone for a successful migration project.

If you didn't use an Azure landing zone reference implementation, you still need to perform the steps in this article. However, you might have prerequisite tasks to perform first, or you might have to adapt specific recommendations to your design.

This article describes the tasks you must perform for your existing Azure landing zone after it's deployed. Some tasks focus on automated deployments. It's noted if a task isn't relevant for manually deployed and managed environments.

> [!NOTE]
> Prior to completing the tasks detailed on this page, please ensure you have implemented your Azure landing zone and reviewed both the [design areas](./design-areas.md) and also the [design principles](./design-principles.md) before continuing.

## Establish hybrid connectivity

During an Azure landing zone deployment, you can deploy a Connectivity subscription with a hub virtual network and network gateways, such as Azure VPN gateways, Azure ExpressRoute gateways, or both. After your Azure landing zone deployment, you must still configure hybrid connectivity from these gateways to connect to your existing datacenter appliances or your ExpressRoute circuit.

In the ready phase, you planned for your [connectivity to Azure](../../ready/azure-best-practices/connectivity-to-azure.md). Use this plan to determine the connections that you need to incorporate. For example, if you use ExpressRoute, you must work with your provider to establish your ExpressRoute circuit.

To get technical guidance for specific scenarios, see:

- [Create a VPN connection from your Azure VPN gateway](/azure/vpn-gateway/tutorial-site-to-site-portal).
- [Create an ExpressRoute circuit](/azure/expressroute/expressroute-howto-circuit-portal-resource-manager).
- [Create an ExpressRoute connection from your ExpressRoute gateway to your circuit](/azure/expressroute/expressroute-howto-linkvnet-portal-resource-manager).
- [Manage Azure Virtual WAN gateway settings](/azure/virtual-wan/gateway-settings).

> [!NOTE]
> For additional guidance, also refer to your provider's specific documentation.

If you establish your hybrid connectivity to Azure via a third-party network virtual appliance (NVA) that's deployed in your virtual network, review their specific guidance and our [general guidance for highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha).

## Prepare identity

During your Azure landing zone deployment, you should also deploy a supporting architecture for your identity platform. You might have a dedicated identity subscription or resource groups and a virtual network or subnets for the virtual machines (VMs) that you use for identity. However, you must deploy the identity resources after the Azure landing zone deployment.

The following sections provide guidance related to Active Directory. If you use a different identity provider for authentication and authorizations, you must follow their guidance on extending your identity to Azure.

Before you implement this guidance, review the [Active Directory and hybrid identity](../../ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity.md) decisions that you made when you planned for your landing zone.

You should also review your [identity baseline](../../govern/identity-baseline/index.md) from the governance phase to determine if you need to make changes in Microsoft Entra ID.

### Extend Active Directory domain controllers

In most migration scenarios, the workloads that you migrate to Azure are already joined to an existing Active Directory domain. Microsoft Entra ID offers solutions for modernizing identity management, even for VM workloads, but it can disrupt migration. Rearchitecting identity usage for workloads is often performed during modernization or innovation initiatives.

As a result, you need to deploy domain controllers to Azure inside the identity network area that you deployed. After you deploy VMs, you must follow your normal domain controller promotion process to add them to the domain. This process might include creating additional sites to support your replication topology.

For a common architecture pattern to deploy these resources, see [Deploy Active Directory Domain Services (AD DS) in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain).

If you implement the [enterprise-scale architecture for small enterprises](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md), the AD DS servers are often in a subnet in the hub. If you implement the [enterprise-scale hub-and-spoke architecture](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) or the [enterprise-scale Virtual WAN architecture](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md), the servers are often in their dedicated virtual network.

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

Many organizations already have Microsoft Entra Connect to populate Microsoft 365 services, like Exchange Online. If your organization doesn't have Microsoft Entra Connect, you might need to [install it](/entra/identity/hybrid/connect/how-to-connect-install-roadmap) and deploy it after your landing zone deployment so you can replicate identities.

## Enable hybrid DNS

Most organizations need to be able to resolve Domain Name System (DNS) requests for namespaces that are a part of existing environments. These namespaces often require integration with Active Directory servers. And resources in the existing environment must be able to resolve resources in Azure.

To enable these functions, you need to configure DNS services to support common flows. You can use Azure landing zones to deploy many of the resources you need. For additional tasks to review and prepare for, see [DNS resolution in Azure](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances).

### Custom DNS resolution

If you use Active Directory for your DNS resolver or if you deploy a third-party solution, you must deploy VMs. You can use these VMs as your DNS servers if your domain controllers are deployed to your Identity subscription and network spoke. Otherwise, you must deploy and configure the VMs to house these services.

After you deploy the VMs, you must integrate them into your existing DNS platform so they can perform lookups against your existing namespaces. For Active Directory DNS servers, this integration is automatic.

You can also use [Azure DNS Private Resolver](/azure/dns/dns-private-resolver-overview), but this service isn't deployed as part of your Azure landing zone deployment.

If your design uses private DNS zones, plan accordingly. For example, if you use private DNS zones with private endpoints, see [Specify DNS servers](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#specify-dns-servers). Private DNS zones are deployed as part of your landing zone. If you also use private endpoints to perform modernization efforts, you should have an additional configuration for them.

### Azure Firewall DNS proxy

You can configure Azure Firewall as a [DNS proxy](/azure/firewall/dns-details). Azure Firewall can receive traffic and forward it to an Azure resolver or your DNS servers. This configuration can allow lookups to be performed from on-premises to Azure, but they can't be conditionally forwarded back to on-premises DNS servers.

If you need hybrid DNS resolution, you can configure the Azure Firewall DNS proxy to forward traffic to your custom DNS servers, such as your domain controllers.

This step is optional, but it has several benefits. It reduces configuration changes later if you change DNS services and enables fully qualified domain name (FQDN) rules in Azure Firewall.

### Configure custom virtual network DNS servers

After you complete the preceding activities, you can configure the DNS servers for your Azure virtual networks to the custom servers that you use.

For more information, see [Azure Firewall DNS settings](/azure/firewall/dns-settings).

## Configure hub firewall

If you deployed a firewall in your hub network, there are a few considerations that you should address so you're ready to migrate workloads. If you don't address these considerations early in your deployment, you might run into routing and network access problems.

As part of performing these activities, review the [networking design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity), especially the [network security guidance](../../ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md).

If you deploy a third-party NVA as your firewall, review the vendor's guidance and our [general guidance for highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha).

### Deploy standard rule sets

If you use an Azure firewall, all firewall traffic is blocked until you add explicit allow rules. Many other NVA firewalls work similarly. Traffic is denied until you define rules that specify the traffic that's permitted.

You should add individual rules and rule collections based on workload needs. But you should also plan to have standard rules, such as access to Active Directory or other identity and management solutions, that apply to all enabled workloads.

## Routing

Azure provides routing for the following scenarios with no additional configuration:

- Routing between resources in the same virtual network
- Routing between resources in peered virtual networks
- Routing between resources and a virtual network gateway, either in its own virtual network or in a peered virtual network that's configured to use the gateway

Two common routing scenarios need additional configuration. Both scenarios have route tables assigned to subnets to shape routing. For more information about Azure routing and custom routes, see [Virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview#custom-routes).

### Inter-spoke routing

For the [network design area](../../ready/azure-best-practices/traditional-azure-networking-topology.md), many organizations use a [hub-spoke network topology](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke).

You need routes that transfer traffic from one spoke to another. For efficiency and simplicity, use the default route (`0.0.0.0/0`) to your firewall. With this route in place, traffic to any unknown location goes to the firewall, which inspects the traffic and applies your firewall rules.

If you want to allow for internet egress, you can also assign another route for your private IP space to the firewall, such as `10.0.0.0/8`. This configuration doesn't override more specific routes. But you can use it as a simple route so inter-spoke traffic can properly route.

For more information on spoke-to-spoke networking, see [Patterns and topologies for inter-spoke communication.](/azure/architecture/networking/spoke-to-spoke-networking#patterns-and-topologies-for-inter-spoke-communication)

### Routing from the gateway subnet

If you use virtual networks for your hub, you need to plan how to handle the inspection of traffic that comes from your gateways.

If you intend to inspect traffic, you need two configurations:

- In your Connectivity subscription, you need to create a route table and link it to the gateway subnet. The gateway subnet needs a route for every spoke network you intend to attach, with a next hop of your firewall's IP address.

- In each of your landing zone subscriptions, you need to create a route table and link it to each subnet. Disable Border Gateway Protocol (BGP) propagation on the route tables.

For more information about custom and Azure-defined routes, see [Azure virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview#custom-routes).

If you intend to inspect traffic to private endpoints, enable the appropriate routing network policy on the subnet where the private endpoints are hosted. For more information, see [Manage network policies for private endpoints](/azure/private-link/disable-private-endpoint-network-policy).

If you don't intend to inspect traffic, no changes are needed. However, if you add route tables to your spoke network subnets, enable BGP propagation so traffic can route back to your gateway.

## Configure monitoring and management

As part of deploying your landing zone, you have provisioned policies that enroll your resources in Azure Monitor Logs. But you must also create alerts for your landing zone resources.

To implement alerts, you can deploy the [Azure Monitor baseline for landing zones](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz). Use this deployment to get alerts based on common scenarios for landing zone management, such as connectivity resources and service health.

You can also deploy your own custom alerting for resources if your needs deviate from what's in the baseline.

## Prepare your landing zone for sovereign workload migrations

If you need to address sovereignty requirements, you can evaluate if [Microsoft Cloud for Sovereignty](https://aka.ms/MicrosoftCloudForSovereignty) fits your requirements. Microsoft Cloud for Sovereignty provides an additional layer of policy and auditing capabilities that address individual public sector and government customer needs.

You can enable these capabilities by deploying the [sovereign landing zone](/industry/sovereignty/slz-overview). The architecture of the sovereign landing zone aligns with the recommended [Azure landing zone](../../ready/landing-zone/index.md) designs.

### Microsoft Cloud for Sovereignty policy portfolio

By using Azure policy, you can enable centralized control across Azure resources to enforce specific configurations. You can assign the [Microsoft Cloud for Sovereignty policy initiatives](/industry/sovereignty/policy-portfolio-baseline) to your landing zones to make sure you adhere to local policies and regulatory requirements in your country/region.

If those policy initiatives are not yet assigned to your sovereign landing zone deployment, consider assigning the initiatives that correspond to your regulatory requirements.

## Enable subscription vending

This section applies to organizations that want to automate their subscription provisioning process. If you manually manage your landing zone and subscription creation, you should establish your own process for creating subscriptions.

When you begin migrating, you must create subscriptions for your workloads. Enable [subscription vending](../../ready/landing-zone/design-area/subscription-vending.md) to automate and accelerate this process. When subscription vending is established, you should be able to create subscriptions quickly.

## Prepare for Microsoft Defender for Cloud

When you deploy your landing zone, you also set policies to enable [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) for your Azure subscriptions. Defender for Cloud provides security posture recommendations in its [secure score](/azure/defender-for-cloud/secure-score-security-controls), which evaluates deployed resources against the Microsoft security baseline.

You don't need to implement additional technical configurations, but you should review the recommendations and design a plan to [improve your security posture](/azure/defender-for-cloud/review-security-recommendations) as you migrate resources. When you begin migrating resources into Azure, you should be ready to [implement security improvements](/azure/defender-for-cloud/implement-security-recommendations) as part of your migration optimization.

## Related resources

Consider these additional resources to prepare for migration:

- [Prepare an initial corporate policy that's defined and well understood](../../govern/guides/standard/initial-corporate-policy.md)
- [Create an adequate plan for Azure billing](../../ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant.md)
- [Ensure that you have proper organizational alignment](../../plan/initial-org-alignment.md) and [a plan to manage it](../../organize/index.md)
- [Define a naming convention](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) and [tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging)
