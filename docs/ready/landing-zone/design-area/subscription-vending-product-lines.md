---
title: Establish common subscription vending product lines
description: Learn about establishing common subscription vending product lines.
author: jtracey93
ms.author: jatracey
ms.date: 06/04/2024
ms.topic: conceptual
---

# Establish common subscription vending product lines

Subscription vending helps organizations achieve the [subscription democratization design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization) of Azure landing zones, which is critical to consistent scaling, security, and governance of Azure environments. Subscription vending also helps organizations align with the [platform engineering principles](/platform-engineering/about/principles) of [Adopt a product mindset](/platform-engineering/about/product-mindset) and [Empower developers through self-service with guardrails.](/platform-engineering/about/self-service)

Many organizations struggle to give their application teams the flexibility they need to deliver their workloads and services effectively. One key obstacle is lack of a standardized approach to [subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending), which can lead to confusion, delay, and inefficiency.

This article explores how platform teams can establish common subscription vending product lines that cater to the diverse needs of various application teams. The article discusses the benefits of offering different product lines and provides examples of common scenarios based on real customer deployments. You also learn why there's no "one size fits all" design in subscription vending, and why you must provide different product lines to application teams.

The following example shows the organization of management groups and subscriptions within an Azure environment, aligning with Azure landing zones. The diagram includes elements such as management groups, landing zones, and platforms named **Connectivity** and **Identity**. The diagram also depicts connectivity subscriptions with components like **Regional hub** and **Subscription vending automation** that indicate the flow and relationships between different organizational components.

:::image type="content" source="./media/sub-vend-product-line0.png" alt-text="A diagram showing the organization of management groups and subscriptions within an Azure environment, aligning with Azure Landing Zones." lightbox="./media/sub-vend-product-line0.png" border="false":::

Continue reading to learn why different product lines are required and see examples used by customers with Azure landing zones and subscription vending.

## Why do you need different product lines?

Subscriptions that application teams require to deliver their workloads and services come in many types and styles. Outside of application teams, your organization might have other requirements that necessitate the use of an Azure subscription, such as different compliance and data-handling rules or architecture patterns.

When you decide on your organization's approach to designing and implementing subscription vending, consider asking these questions:

- What other resources should the platform team vend as part of the subscription vending process?
- Do you deploy multiple subscriptions, such as one per environment, by default for each application team?
- Do you peer or connect the spoke Azure Virtual Network for every application back to your connectivity hubs by default?
- How should you structure role-based access control (RBAC) within each subscription?
- How should you govern and control resources and styles of architecture (archetypes) used within subscriptions?

No single answer or subscription type or style can be vended to address every application and platform team's unique requirements. Platform teams must give application teams flexibility to choose from multiple types and styles of subscriptions that the team can vend to them through a self-service system. These types of subscriptions are referred to as *product lines*.

Organizations that only provide a "one size fits all" approach to subscription vending often limit their internal customers' flexibility. For example, lack of flexibility might limit an application team's architecture design choices and potentially lead to compromises because of  what they were vended.

Therefore, platform teams need to provide various product lines to cater to their organization's needs. This flexibility ensures that consumers can choose the product line that best fits their requirements.

### Manage different application environments (dev/test/prod)

Organizations need to handle different application environments for application teams as part of their subscription vending processes and implementations. However, you should provide flexibility so that application teams can manage their different application environments (dev/test/prod) in the way they want when delivering applications. To learn more, see [Environments, subscriptions, and management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments#environments-subscriptions-and-management-groups).

Some Azure services provide native features to aid in isolating an environment within a single resource instance in a single Azure subscription, such as Azure App Services with its deployment slots feature. In this example, forcing application teams to use separate subscriptions doesn't allow the teams to take advantage of the full feature set of services provided by Azure. Using separate subscriptions can also increase application delivery costs including operational and maintenance overhead.

## Design common product lines for subscription vending

Now that you understand that platform teams must provide multiple Azure subscription types and styles (product lines) to consumers of their Azure platform, this section describes several common product lines that you can use across industries and countries or regions.

Platform teams should use these common subscription vending product lines as a baseline. The team can provide multiple options to its consumers out of the box, meeting the "prioritize customers" platform engineering principle. This approach gives internal customers the freedom they require to deliver their workloads and services by using Azure landing zone [design principles](https://aka.ms/alz/design/principles) and [design area recommendations](https://aka.ms/alz/design/areas), while being governed by the Azure platform.

> [!NOTE]
> These are only examples and should only be used as a starting point for organizations. You can customize and expand these product lines to cater to the needs of each organization.

Common product lines for subscription vending include:

- [**Corp connected**](#corp-connected): Workloads that require traditional layer 3 IP routing connectivity to other applications and on premises via the connectivity subscription.
- [**Online**](#online): Workloads that connect with other applications through modern connectivity services and architectures, such as Azure Private Links or interaction via exposed APIs or endpoints from each application
- [**Tech platform**](#tech-platform): Workloads that build a platform on which you can build other applications. For example, an Azure Kubernetes Service (AKS) fleet of clusters managed by an AKS platform team can host other applications within its AKS clusters on behalf of other application teams.
- [**Shared application portfolio**](#shared-application-portfolio): Workloads shared among the same application teams for a common set of closely coupled applications that don't make sense to be hosted in their own bubble, or with any specific workload.
- [**Sandbox**](#sandbox): An area where application teams can build a Proof of Concept (PoC) or MVP with fewer controls imposed, so the team can promote development, invention, and freedom to build the best possible application from the catalog of available Azure services.

### Corp connected

The **corp connected product line** for application landing zone subscription vending (also referred to as an internal/private product line) provides connectivity via traditional layer 3 (IP) methods. This product line connects resources in the same application landing zone, other corp-connected application landing zones (normally via an Azure Firewall or Network Virtual Appliance (NVA)), on premises, or in other clouds via ExpressRoute or virtual private network (VPN) connections.

This is a core product line for subscription vending because it aligns closely with how most on-premises environments work today. However, you should only use the corp connected product line when appropriate, and when taking advantage of more modern cloud-native approaches such as the online product line is advised.

> [!TIP]
> Review the [**What is the purpose of Connectivity, Corp, and Online Management Groups?**](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups) section in the networking design area to gain further understanding of the differences between corp and online workloads.

The following diagram shows an example of the corp connected subscription vending product line with a network architecture featuring a central **Routable Hub** with an IP address of 10.1.0.0/24 connected to two spokes: **Landing Zone A** and **Landing Zone B**, with IP addresses 10.1.1.0/24 and 10.1.2.0/24, respectively. The diagram also shows **VNet Peering** connections between the hub and the landing zones, and other unspecified landing zones. This setup is typical for a hub-and-spoke network model and helps in managing network traffic and policies efficiently.

:::image type="content" source="./media/sub-vend-product-line1.svg" alt-text="Diagram showing an example of the corp connected subscription vending product line with a network architecture featuring a central Routable Hub connected to two spokes. The diagram also shows VNet Peering connections between the hub and the landing zones, and other unspecified landing zones." lightbox="./media/sub-vend-product-line1.svg" border="false":::

#### When to use the corp connected product line

Use the corp connected product line when:

- You want to perform Rehost and Refactor migrations and application builds based on [the five Rs of rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).
- You want to start your journey in Azure and are familiar with a similar on-premises architecture.
- You want to "lift and shift" applications into Azure.
- You want to enhance security between workloads by isolating applications into their own landing zone subscriptions and moving toward micro-segmentation principles from zero-trust without yet rearchitecting the application to be fully cloud-native.

#### Other important notes about the corp connected product line

Take note of these other considerations for the corp connected product line:

- Platform teams commonly vend the Virtual Network into the application landing zone subscription and peer to the regional hub Virtual Network or Azure Virtual WAN hub. In this way the team can control the IP address allocation, usually by using an IP Address Management (IPAM) tool.
- Platform teams don't usually vend subnets or any other resources into the Virtual Network. Instead, platform teams democratize these activities to the application teams so that they can design their application networking as they want.

  Platform teams then enforce desired behavior, such as standardized Network Security Groups (NSGs) attached to every subnet, by using an Azure Policy assigned to the Management Groups above the subscription. This Azure Policy is inherited and can't be edited by the application team. This approach follows the Azure landing zone design principle of subscription democratization

### Online

The **online product line** (also referred to as an external/public product line) for application landing zone subscription vending provides no connectivity via traditional layer 3 (IP) methods between resources in other application landing zones or on premises through ExpressRoute or VPN connections. Although resources in the same online application landing zone subscription can communicate with each other via layer 3 (IP) methods by using Virtual Networks, they're commonly not peered back to regional connectivity hubs or other application landing zones.

Instead, communication between resources in other application landing zones, on premises or in workloads in other clouds, communicate via their public interfaces and are secured with the network controls, authentication, and authorization exposed by the various Platform as a Service (PaaS) services used to construct the application.

You can use the [Private Link service](/azure/private-link/private-link-service-overview) and [Azure Private Endpoints](/azure/private-link/private-endpoint-overview) in and between online application landing zone subscriptions to enable and expose private, layer 3–based connectivity between applications. You can also use this approach between the PaaS services used within application landing zones to prevent use of these PaaS services' public interfaces if necessary for security or regulatory control.

You can also use the [Private Link Services](/azure/private-link/private-link-service-overview) with [Private Endpoints](/azure/private-link/private-endpoint-overview) to expose and publish applications hosted within online application landing zones to corp connected application landing zones, an on-premises location, or other clouds. This approach involves placing private endpoints in either corp-connected application landing zones or directly in connectivity hubs that then grant access to these private endpoints via traditional layer 3 connectivity methods such as Virtual Network peerings, ExpressRoutes, or VPNs.

A great way to think about the online application landing zone product line is as isolated islands. This means that by default the only resources that can access resources within the subscription are those resources that are deployed within the same online application landing zone subscription. As mentioned previously, you can then expand connectivity to other application landing zones, an on-premises location, or other clouds by using the techniques described and linked above.

> [!TIP]
> Review the [**What is the purpose of Connectivity, Corp, and Online Management Groups?**](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups) section in the networking design area to gain further understanding of the differences between corp and online workloads.

The following diagram shows an example of an online subscription vending product line that has a network architecture diagram with sections labeled **Landing Zone A**, **Landing Zone B**, **Landing Zone C**, and **Landing Zone D**. Each section includes icons for network elements like databases and cloud services, interconnected with arrows to show data flow. A central **Routable Hub 10.0.0/24** with a security lock icon connects to other landing zones depicted by cloud icons. Importantly, none of the vNets is peered together, and all use modern services and approaches like Private Links to interact with each other.

:::image type="content" source="./media/sub-vend-product-line2.svg" alt-text="Diagram showing an example of the online subscription vending product line that includes a network architecture diagram with labeled landing zone sections. Each section includes network elements interconnected with arrows to show data flow." lightbox="./media/sub-vend-product-line2.svg" border="false":::

#### When to use the online product line

Use the online product line when you want to:

- Refactor, rearchitect, rebuild, and perform migrations and application builds, based on [the five Rs of rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).
- Provide application teams with a fully democratized application landing zone to use, even regarding networking configuration.
- Take advantage of cloud-native services and architectures.
- Considerably enhance alignment with zero-trust principles.
- Use the corp connected product line, but private IP address space is unavailable or limited.
  - In this scenario, you should review the guidance in [Prevent IPv4 exhaustion in Azure](/azure/architecture/networking/guide/ipv4-exhaustion).

### Tech platform

The **tech platform product line** provides teams focused on technology platforms such as the Azure VMware Solution or Azure Virtual Desktop with a subscription vending product line that better suits their requirements. Teams can use this product line to host and manage these typically larger and more complex workloads that in turn host multiple applications for several other application teams across the organization. Use this product line in cases where the application team only managed the application parts, not the underlying technology platform pieces.

> [!TIP]
> One way to understand this product line is when a technology platform team like AKS aims to offer "AKS-as-a-service" (or product, according to platform engineering terms) to other application teams that need to run their applications on the AKS platform but leave the management, maintenance, security, and configuration of AKS itself to the AKS tech platform team. In this case, the application team only has to care about their application and deploying it on the platform.

Examples of tech platform product line use cases include:

- **App Service Environments (ASEs)**, typically via separate App Service plans.
- **AKS**, typically via namespaces within one or more clusters.
- **Virtual Machines** on Azure VMware Solution clusters or hosts.
- **Azure Virtual Desktop** when providing virtual desktops or applications to an entire organization.

These use cases can also employ either [corp connected](#corp-connected) or [online](#online) product lines in relation to networking, depending on the requirements for the technology platform the team wants to provide as a service to other application teams in the organization.

### Shared application portfolio

The **shared application portfolio product line** for application landing zone subscription vending helps answer the question that your organization's platform and application teams might be wondering; "*Do we need a separate application landing zone subscription for simple applications that might only be constructed from a small number of Azure resources?*"

This product line gives application teams and departments the option to host several smaller applications or components (such as storage accounts or SQL Servers) shared between several of their own applications in a single subscription or fewer subscriptions.

> [!IMPORTANT]
> It's important to highlight that subscriptions vended under this product line are owned by a common team responsible for the related portfolio of applications deployed in this subscription for this product line. This product line is not intended for general deployments of unrelated application workloads owned by distinct application portfolio owners.
>
> Plan carefully to ensure ongoing flexibility, access control, governance, and maintainability when organizations decide to carve up a single subscription by using resource groups to delegate access.

If you consider resource group delegation in a single subscription between multiple teams, factor in the following extra considerations before making a final decision:

| Area | Considerations |
| :--- | -------------- |
| Common ownership of related application portfolio | - Applications managed by a common owner (such as a business unit of a department) simplify change management so that it's all within the approval scope of the same entity. <br> - Workloads follow consistent policy assignment across the subscription, including logging, monitoring, and security. |
| Regulatory compliance | - Workloads governed by different regulatory compliance requirements including National Institute of Standards and Technology (NIST), Center for Internet Security (CIS), PCI Security Standards Council, industry, and regional requirements might require their own subscriptions for governance using IAM and Azure Policies, per [ALZ tailoring guidance](https://aka.ms/alz/tailoring). <br> - Workloads governed by privacy and data-handling requirements might require their own subscriptions to reduce access. |
| Azure Policy | You can scope Azure Policies to management groups, subscriptions, resource groups, and resources. Use Azure Policy assignment at a high scope level (management groups and subscriptions) for efficient governance when you deploy resources in resource groups. <br><br> It's important to consider the following constraints when managing Azure Policy at the resource group scope level: <br> - Management overhead to create Azure Policy assignments when adding new resource groups to subscriptions, and increased effort when managing changes to policy assignments. <br> - Increased security and governance gaps when resource groups aren't immediately assigned policies. <br> - Reduced ability to roll up compliance status at high scopes (management group and subscription). |
| Subscription limits | - Each subscription has [soft and hard limits for Azure services](/azure/azure-resource-manager/management/azure-subscription-service-limits). It's important to check limits to ensure that applications don't hit hard limits that prevent growth. <br> - Separate subscriptions are required when applications anticipate large growth patterns that would hit subscription limits. <br> - Sharing subscriptions with application teams from different business units or departments could lead to [noisy neighbor](/azure/architecture/antipatterns/noisy-neighbor/noisy-neighbor)  issues. |
| Azure services and feature alignment | Although you can deploy services that provide basic Azure service primitives (such as Virtual Machines, Virtual Networks, and simple PaaS services) within a single resource group, the complexity of modern composite offerings can require that you deploy these more complex services outside the boundaries of a single resource group. These deployment scenarios are better suited for the other democratized subscription  approaches outlined previously. |
| Restricting resource group creation to platform teams only | When sharing a subscription between different application teams across different business units or departments, it's common to restrict any team's ability to create new resource groups in the shared subscription. <br><br> This restriction is intended to limit resource group sprawl. Only the platform team can create and govern new resource groups. <br><br> This approach increases the complexity of RBAC assignments and places an increased dependency on platform teams to manage application deployments, which can impede application teams' agility and empowerment. |

Even though this is a different product line, the subscriptions vended using the shared application portfolio product line would still be placed under either the Corp or Online Management Groups from the Azure landing zones default recommended hierarchy. Alternatively, you might place the subscriptions beneath new Management Groups in an organization's Management Group hierarchy that follows the guidance in [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).

The following diagram shows an example of the shared application portfolio subscription vending product line that includes a network architecture diagram with a **Routable Hub** labeled 10.0.0.0/24 at the center. This hub connects to various smaller elements, like a single virtual machine or storage account, for many applications that the same team controls. This includes a **Routable Spoke** labeled 10.1.1.0/24, all in a single subscription carved into resource groups. The diagram also shows **Additional Landing Zones** that contain icons for different network components such as databases, storage services, and Virtual Machines that the share application portfolio subscription can connect to via vNet peering through the hub.

:::image type="content" source="./media/sub-vend-product-line3.svg" alt-text="Diagram showing an example of the shared application portfolio subscription vending product line that includes a network architecture diagram with a Routable Hub at the center, connected to various smaller elements like a single Virtual Machine or storage account." lightbox="./media/sub-vend-product-line3.svg" border="false":::

#### When to use the shared application portfolio product line

Use the shared application portfolio product line when:

- An application team needs to deliver several smaller resources or components shared between applications that they're responsible for, but they don't directly fit in any of these dedicated application landing zones. The same is true for resources or components that the team might need to share between applications in the same department.
- Technology platform teams want to host larger shared platforms as a service (such as AKS, Azure Virtual Desktop, and Azure VMware Solution) that they want to allow other application teams to use or host their applications upon.

### Sandbox

The **sandbox product line** for application landing zone subscription vending is critical to help organizations provide safe, lightly governed, and visible testing areas for anyone within the organization who wants to test, PoC, or MVP something in Azure.

For more detailed guidance on using the sandbox product line with Azure landing zones, review [Landing zone sandbox environments](https://aka.ms/alz/sandbox) and [Manage application development environments in Azure landing zones](https://aka.ms/alz/dtp) along with the guidance in this section.

Sandboxes are commonly ephemeral, meaning they're either time-boxed or budget-constrained and nearing a time or budget limit. In these cases, the sandbox either needs to be extended or removed and decommissioned.

Organizations that don't provide a sandbox product line for application teams or others within their organization to test and experiment with services in Azure might see lots of "shadow IT" setups. The organization might struggle to provide reporting and visibility and apply any form of governance to subscriptions that business users create outside of the platform team's control and oversight.

Therefore, it's critically important that platform teams provide easily accessible, preferably self-service, and automatically approved access to sandbox subscriptions for their organization's users and teams. It's better to give users and teams access to something that can be seen and governed by a platform team than to create it in a "shadow IT" style where the platform team can't access or control it, which creates risk.

Sandboxes often follow the networking configuration approach of online product line subscriptions because they aren't peered to other Virtual Networks outside of their own subscription boundary and often have further controls to prevent any form of hybrid connectivity to on-premises or other locations. This helps ensure that data can't be exfiltrated from sandboxes to unknown and unapproved locations. These controls are enforced by using an Azure Policy.

#### When to use the sandbox product line

Use the sandbox product line to provide a safe, secure, and governed Azure subscription to anyone across the organization who wants to experiment, PoC, or MVP in Azure. The organization must lightly govern these users and grant them access to all services so that they aren't forced to consider "shadow IT" practices.

#### Other important notes about the sandbox product line

Note the following when considering using the sandbox product line:

- Just like the shared application portfolio and tech platform product lines, you can also share the sandbox product line among teams in the same department with the same considerations. 
- Avoid using a single or just a few sandbox subscriptions to give users access to resource groups.

## Summary and takeaways

Although navigating subscription vending can be complex, this article outlines prescriptive guidance to help you move toward implementation.

Consider the importance of predicting or learning what your future application teams' requirements are and which subscription vending product line best suits them. Identifying this for the initial set of workloads you're building or migrating helps you prioritize which subscription vending product lines to enable and expose via a self-service interface first.

Consider that each product line comes with an implementation and a maintenance cost. It's crucial to evaluate the long-term cost versus long-term benefits and usage.

Customers typically enable the following subscription vending product lines initially:

- [Sandbox](#sandbox)
- [Corp connected](#corp-connected)
- [Online](#online)

### Additional resources

To further support your platform-engineering approach, review the following resources when designing and implementing your organization's subscription vending product lines and offerings:

- [Azure Landing Zones - How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)
- [Platform landing zones vs. application landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-landing-zones-vs-application-landing-zones)
- [Policies included in Azure landing zones reference implementations](https://aka.ms/alz/policies)
- [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
- [What is the purpose of Connectivity, Corp, and Online Management Groups?](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups)
- [Manage application development environments in Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments)
- [Platform engineering principles](/platform-engineering/about/principles)

## Next steps

For the best results, you should automate as much of the subscription vending process as possible. Use the companion guidance on implementing subscription vending automation.

> [!div class="nextstepaction"]
> [Subscription vending implementation guidance](/azure/architecture/landing-zones/subscription-vending)
