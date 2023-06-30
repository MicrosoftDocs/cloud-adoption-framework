---
title: Readying your Landing Zone for Migration
description: Review items that need to be completed after a ALZ deployment, in order to allow for the environment to support migrations.
author: bstephenson
ms.author: bstephenson
ms.date: 06/26/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom:
---

# Readying your Landing Zone for Migration

During the [Ready phase](../../ready/index.md), you deployed your [Azure Landing Zone](../../ready/landing-zone/index.md).  If you used one of the ALZ reference implementations (Cloud Adoption Framework enterprise-scale landing zones in Azure - Cloud Adoption Framework | Microsoft Learn), there are still tasks necessary in order to ready your landing zone for a VM migration project.  This article provides a list of the major tasks necessary to make sure you have the configurations in place to support a migration project, and where to find guidance for how to perform the activities necessary.  However, there are also items from other phases that you should consider, such as:

- [Ensure that you have your initial corporate policy defined and well understood](../../govern/guides/standard/initial-corporate-policy.md)
- [Ensure that you have adequate planning for Azure Billing](../../ready/landing-zone/design-area/azure-billing-ad-tenant.md)
- [Your organizational alignment](../../plan/initial-org-alignment.md) and how you intend to [continue to manage it](../../organize/index.md)
- [Ensuring consistency with your naming and tagging standards](../../ready/azure-best-practices/naming-and-tagging.md)

## Azure Landing Zone Post-Deployment Activities

Azure Landing Zone reference implementations often use Infrastructure as Code for automated deployment and for managing the resources over their life cycle.  You can refer to the article on [using infrastructure as code to update Azure landing zones](../../manage/infrastructure-as-code-updates.md) to understand the benefits of using Infrastructure as Code to manage the life cycle of your Landing Zone, as well the guidance to  [keep your Azure landing zone up to date](../../govern/resource-consistency/keep-azure-landing-zone-up-to-date.md) for guidance on how to keep your Landing Zone up to date.

This article is intended for use by organizations regardless of how they chose to deploy their Azure Landing Zones.  Some steps are focused on automated deployments, but it will be noted if they are not relevant for manually deployed and managed environments.

| Configuration | Needed Role(s) | Summary of Effort |
| --- | --- | --- |
| Establish Hybrid Connectivity | Networking | Establish connectivity from Azure to on-prem, via VPN or ExpressRoute
Prepare Identity|Identity|Deploy Domain Controllers to Azure, and enable Azure AD Connect if not already done. |
Enable Hybrid DNS|Networking|Deploy custom DNS servers and add conditional forwarders
Configure Hub Firewall|Networking|Apply baseline rules to your Hub Firewall
Enable Routing|Networking|Plan and enable for common routing scenarios.
Configure Monitoring Baseline|Operations|Deploy Azure Monitor Baseline or configure alerts
Enable Subscription Creation|Operations|Set up subscription vending to enable the creation of new subscriptions.

## Establishing hybrid connectivity

During ALZ deployment, most organizations deploy a Connectivity subscription with a hub virtual network and network gateways – VPN, ExpressRoute, or both.  After ALZ deployment, you still need to configure hybrid connectivity from these gateways, connecting to your existing data center appliances or to your ExpressRoute circuit.

In the Ready phase, you would have planned for your [connectivity to Azure](../../ready/azure-best-practices/connectivity-to-azure.md).  This plan should guide you on what connections you need to perform.  For example, if you are using ExpressRoute, you will need to work with your provider to establish your ExpressRoute circuit.
For technical guidance for specific scenarios, review the following:

- [Creating a VPN connection from your Azure VPN Gateway](/azure/vpn-gateway/tutorial-site-to-site-portal)
- [Creating an ExpressRoute circuit](/azure/expressroute/expressroute-howto-circuit-portal-resource-manager)
  - You should also refer to your provider’s specific documentation as well.
- [Creating an ExpressRoute connection from your Azure ExpressRoute Gateway to your circuit](/azure/expressroute/expressroute-howto-linkvnet-portal-resource-manager)
- [Managing Azure Virtual WAN gateway settings](/azure/virtual-wan/gateway-settings)

If you are establishing your hybrid connectivity to Azure via a third-party NVA deployed in your virtual network, review their specific guidance as well as our [general guidance for highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha).

## Prepare Identity

During the ALZ deployment, organizations will deploy supporting architecture for their identity platform.  This involves a dedicated identity subscription or resource groups, and a virtual network or subnets for the virtual machines that will be used for identity.  However, deploying the actual identity resources will need to be performed after the ALZ deployment.

This section has guidance for considerations related to Active Directory.  If you are using another identity provider, you will need to follow their guidance on extending your identity to Azure.

Prior to implementing this, you should review the decisions made for [Active Directory and Hybrid Identity](../../ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity.md) when you planned for your Landing Zone.

You should also review your [identity baseline](../../govern/identity-baseline/index.md) from Govern to determine if there are any Azure AD changes that you might need.

### Extending Active Directory Domain Controllers

In most migration scenarios, the workloads being migrated to Azure are already joined to an existing Active Directory domain.  While Azure AD can offer solutions for modernizing identity management even for VM workloads, doing so can be disruptive to migration.  Rearchitecting identity usage for workloads is often an effort saved for modernization or innovation initiatives.

As a result, you will need to deploy domain controllers to Azure, inside of the identity network area that you deployed.  After deploying the VMs, you would need to follow your normal DC promotion process to add them to the domain.  This can include additional sites created, to support your replication topology.

For a common architecture pattern for deploying these resources, review the article on [Deploy AD DS in an Azure virtual network](/azure/architecture/example-scenario/identity/adds-extend-domain) from the Azure Architecture Center.  Note that the AD DS servers could be in a subnet in the hub if you are implementing the [Enterprise-scale for small enterprises](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/treyresearch/README.md), or in their own dedicated virtual network for [Enterprise-scale hub and spoke](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) or [Enterprise-scale Virtual WAN](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md).

### Azure AD Connect

Most organizations already have Azure AD Connect running to populate M365 services like Exchange Online.  However, if you haven’t implemented this, then post LZ deployment you might need to deploy Azure AD Connect to replicate identities.

You can use [this guidance](/azure/active-directory/hybrid/connect/how-to-connect-install-roadmap) for installing Azure AD Connect.

## Enable Hybrid DNS

Most organizations need to be able to resolve DNS requests for namespaces that are a part of the existing environments.  These namespaces often require integration with Active Directory servers.  In addition, resources in the existing environment will need to be able to resolve resources in Azure.

As a result, configuration of DNS services is needed to support common flows.  Azure Landing Zones deploy many of the resources that you need, but there are some additional items to review.

To prepare for these activities, review [DNS resolution in Azure](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances).

### Custom DNS Resolution

If you are using Active Directory for your DNS resolver, or are deploying a third-party solution, VMs will need to be deployed.  If you already have your Domain Controllers deployed to your Identity subscription and network spoke, you can use these as your DNS servers.  Otherwise, you will need to deploy and configure the virtual machines to house these services.

Once deployed, it will need to be integrated into your existing DNS platform so that it is able to perform lookups against your existing namespaces.  For Active Directory DNS servers, this is provided automatically.

You can also use [Azure Private Resolver](/azure/dns/dns-private-resolver-overview), but this resource is not deployed as part of your Azure Landing Zone deployment.

If your design uses Private DNS Zones, plan actions accordingly such as those commonly used with Private Endpoints, review [Azure Private Endpoint DNS configuration](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances?tabs=redhat#specify-dns-servers).  The Private DNS zones will be deployed as part of your Landing Zone, but when you are performing modernization efforts using Private Endpoints, you will have additional configuration for them.

### Azure Firewall DNS Proxy

The Azure Firewall can act as a [DNS proxy](/azure/firewall/dns-details), receiving traffic and either forwarding it to the Azure resolver or to your DNS servers.  This can be used to allow for lookups from on-prem to Azure, but cannot conditionally forward back to on-prem DNS servers.

As a result, if hybrid DNS resolution is needed, the Azure Firewall DNS Proxy can be set to forward to your custom DNS servers (such as your domain controllers).

This is an optional step, but using this has several benefits.  It reduces configuration changes later if you change DNS services and enables FQDN rules in the Azure firewall itself.

### Setting Custom DNS servers on Virtual Network

Once the previous activities are completed, you can set the DNS servers for your Azure virtual networks to the custom servers you will use.  This process is defined [here].

## Configure Hub Firewall

If you have deployed a firewall in your hub network, there are a few considerations that you should address to be ready to migrate workloads.  Organizations can run into routing and network access issues by not addressing these earlier in their deployments.

As part of performing these activities, review the [networking design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity), especially for [Network Security guidance](../../ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md).

If you are deploy out a third-party NVA to act as your firewall, use the vendor's guidance and our [general guidance for highly available NVAs](/azure/architecture/reference-architectures/dmz/nva-ha) to guide your deployment.

### Deploy Standard Rulesets

If you use an Azure Firewall, then all traffic through the firewall will be blocked until explicit allow rules are added.  Many other NVA firewalls work in the same way, where traffic is denied until rules for what traffic is allowed are defined.

While you should add individual rules and rule collections based on workload needs, you should plan to have your standard rules that apply to all workloads enabled, such as access to Active Directory or to other identity and management solutions.

## Routing

Azure itself provides routing for the following scenarios, with no additional configuration:

- Routing between resources in the same virtual network.
- Routing between resources in peered virtual networks.
- Routing between resources and a virtual network gateway, either in its own virtual network or a peered one set to use the gateway.

Two common routing scenarios need additional actions taken, both of which involve route tables assigned to subnets to shape routing.  [This article](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) provides more information about Azure routing and custom routes.

### Interspoke Routing

As part of the [network design area](../../ready/azure-best-practices/traditional-azure-networking-topology.md), most organizations opt to use a  [hub and spoke network topology](/azure/architecture/networking/spoke-to-spoke-networking).

In order to allow routing between spokes, you will need to have routes that take traffic from one spoke to another.  A default route (0.0.0.0/0) to your firewall will be sufficient, and works best to simplify routing.  With this route in place, traffic to any unknown location will head to the firewall, which enables inspection and the application of your firewall rules.

If you want to allow for internet egress you can also assign another route for your private IP space to the firewall, such as 10.0.0.0/8.  This won’t overrule more specific routes, but can be used as a simple route to let interspoke traffic route correctly.

### Routing From Gateway Subnet

If you are using Virtual Networks for your hub, you need to plan for how your organization will handle inspection of traffic coming from your gateways.

If you intend to inspect traffic, there are two configurations needed:

- In your Connectivity Subscription, you will need a route table created and linked to the GatewaySubnet.  It will need a route for every spoke network you intend to attach, with a next hop of your firewall’s IP address.
- In each of your Landing Zone Subscriptions, you will need a route table created and linked to each subnet.  It will need BGP propagation disabled on it.

You can review the article on [Azure virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) for more information about custom routes and Azure defined routes.

In addition, if you intend to inspect traffic to Private Endpoints, you will want to make sure that the appropriate routing network policy is enabled on the subnet where the Private Endpoints are hosted.  Refer to [manage network policies for private endpoints](/azure/private-link/disable-private-endpoint-network-policy?tabs=network-policy-portal) to learn how these operate.

If you do not intend to inspect traffic, no changes are needed.  However, if you add route tables to your spoke network subnets, you will want to make sure that BGP propagation is enabled on it, so that it can route back to your gateway.

## Configure Monitoring and Management

As part of deploying your landing zone, you will have provisioned policies that enroll your resources in Log Analytics.  However, you will have additional steps necessary to create alerts for your landing zone resources.

A quick way to implement this is to deploy the [Azure Monitor Baseline for Landing Zones](https://aka.ms/alz/monitor/repo). By using this deployment, you will gain alerts based on common scenarios for landing zone management, such as connectivity resources, and service health.

You can also deploy your own custom alerting for resources, if your needs deviate from what is in the baseline.

## Enable Subscription Vending

This section applies to organizations that want to automate their subscription provisioning process.  If you are manually managing your landing zone and subscription creation, you would instead need to establish your own process for creating subscriptions.

Once you begin migrating, you will need to create subscriptions for your workloads.  To automate and accelerate this step, enable [Subscription vending](../../ready/landing-zone/design-area/subscription-vending.md).  Once established, you should be able to quickly create subscriptions.

## Prepare for Defender for Cloud

When you deployed your Landing Zone, you also set policies to enable [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) for your Azure subscriptions.  Defender for Cloud will provide security posture recommendations through [Secure Score](/azure/defender-for-cloud/secure-score-security-controls), which evaluates deployed resources against Microsoft's security baseline.

While no additional technical configuration is needed, you should review the recommendations and put together a plan to [improve your security posture](/azure/defender-for-cloud/review-security-recommendations) as you migrate resources.  Once you begin migrating resources in to Azure, you should be ready to [implement security improvements](/azure/defender-for-cloud/implement-security-recommendations) as part of your migration optimization.
