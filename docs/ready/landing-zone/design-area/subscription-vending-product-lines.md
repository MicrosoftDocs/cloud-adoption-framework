---
title: Establish common subscription vending product lines
description: Learn about the benefits of offering different subscription vending product lines to give application teams the flexibility to deliver their workloads and services effectively.
author: jtracey93
ms.author: jatracey
ms.date: 12/16/2024
ms.topic: conceptual
---

# Establish common subscription vending product lines

Subscription vending helps organizations achieve the [subscription democratization design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization) of Azure landing zones, which is critical to consistent scaling, security, and governance of Azure environments. Subscription vending also helps organizations align with [platform engineering principles](/platform-engineering/about/principles). For more information, see [Adopt a product mindset](/platform-engineering/about/product-mindset) and [Empower developers through self-service with guardrails](/platform-engineering/about/self-service).

Many organizations struggle to give their application teams the flexibility that they need to deliver their workloads and services effectively. One key obstacle is the lack of a standardized approach to [subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending), which can lead to confusion, delay, and inefficiency.

This article explores how platform teams can establish common subscription vending product lines that cater to the diverse needs of various application teams. The article discusses the benefits of offering various product lines and provides examples of common scenarios based on real customer deployments. You also learn why subscription vending doesn't have a "one size fits all" design and why you must provide various product lines to application teams.

The following diagram shows the organization of management groups and subscriptions within an Azure environment.

:::image type="complex" source="./media/subscription-vending-product-line-0.png" alt-text="A diagram that shows the organization of management groups and subscriptions within an Azure environment." lightbox="./media/subscription-vending-product-line-0.png" border="false":::
The diagram shows elements such as management groups, landing zones, and platforms named Connectivity and Identity. The diagram also depicts Connectivity subscriptions with components like a regional hub and subscription vending automation, which indicates the flow and relationships between different organizational components. This architecture aligns with Azure landing zones.
:::image-end:::

The following guidance describes why you might require various product lines and describes product line examples for customers that use Azure landing zones and subscription vending.

## Take advantage of various product lines

Subscriptions that application teams require to deliver their workloads and services come in many types and styles. Outside of application teams, your organization might have other requirements that necessitate the use of an Azure subscription, such as various compliance and data-handling rules or architecture patterns.

When you decide on your organization's approach to designing and implementing subscription vending, consider asking these questions:

- What other resources should the platform team vend as part of the subscription vending process?
  
- For each application team, do you deploy multiple subscriptions, such as one per environment, by default?
  
- For every application, do you peer or connect the spoke virtual network back to your connectivity hubs by default?
  
- How should you structure role-based access control (RBAC) within each subscription?
  
- How should you govern and control resources and styles of architecture, or archetypes, that you use within subscriptions?

You can't address every application and platform team's unique requirements with any single subscription type or subscription style that you vend. Platform teams must give application teams flexibility to choose from multiple types and styles of subscriptions that the team can vend to them through a self-service system. These types of subscriptions are referred to as *product lines*.

Organizations that only provide a "one size fits all" approach to subscription vending often limit their internal customers' flexibility. For example, lack of flexibility might limit an application team's architecture design choices and potentially lead to compromises because of what they were vended.

Therefore, platform teams need to provide various product lines to cater to their organization's needs. This flexibility ensures that consumers can choose the product line that best fits their requirements.

### Manage application environments

Your organization must manage application environments for application teams as part of your subscription vending processes and implementations. However, you should also provide flexibility so that application teams can manage their application environments, such as dev/test/prod, how they want to when they deliver applications. For more information, see [Environments, subscriptions, and management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments#environments-subscriptions-and-management-groups).

Some Azure services provide native features to help isolate an environment within a single resource instance in a single Azure subscription, such as Azure App Service with its deployment slots feature. This example forces application teams to use separate subscriptions, so teams can't take advantage of the full feature set of services that Azure provides. Separate subscriptions can also increase application delivery costs including operational and maintenance overhead.

## Design common product lines for subscription vending

Now that you understand that platform teams must provide multiple Azure subscription types and styles, or product lines, to consumers of their Azure platform, this section describes several common product lines that you can use across industries and countries or regions.

Your platform team should use these common subscription vending product lines as a baseline. Your team can provide multiple options to its consumers out of the box, which aligns with the *prioritize customers* platform engineering principle. This approach gives internal customers the freedom to use Azure landing zone [design principles](https://aka.ms/alz/design/principles) and [design area recommendations](https://aka.ms/alz/design/areas) to deliver their workloads and service and also provides Azure platform governance.

> [!NOTE]
> Use these examples as a starting point. You can customize and expand these product lines to cater to the needs of your organization.

Common product lines for subscription vending include:

- [Corp connected](#the-corp-connected-product-line): Workloads that require traditional Layer-3 IP routing connectivity to other applications and on-premises environments via the Connectivity subscription.
  
- [Online](#the-online-product-line): Workloads that connect with other applications through modern connectivity services and architectures, such as Azure Private Link or interaction via exposed APIs or endpoints from each application.
  
- [Tech platform](#the-tech-platform-product-line): Workloads that build a platform on which you can build other applications. For example, an Azure Kubernetes Service (AKS) fleet of clusters that an AKS platform team manages can host other applications within its AKS clusters on behalf of other application teams.
  
- [Shared application portfolio](#shared-application-portfolio): Shared workloads among the same application teams for a common set of closely coupled applications. You don't want to host the applications on their own or with any specific workload.
  
- [Sandbox](#sandbox): An area where application teams can build a proof of concept (PoC) or minimum viable product (MVP) and impose fewer controls, so the team can promote development, invention, and freedom to build the best possible application from the catalog of available Azure services.

### The corp connected product line

The *corp connected product line*, also referred to as an internal or private product line, for application landing zone subscription vending provides connectivity via traditional Layer-3 IP methods. You can use this product line to provide connectivity between resources that are: 

- In the same application landing zone.

- In different corp-connected application landing zones via an Azure firewall or network virtual appliance (NVA).

- On-premises or in different clouds via Azure ExpressRoute or VPN connections.

Organizations that use subscription vending often incorporate this product line because it aligns closely with how most on-premises environments work today. However, you should only use the corp connected product line when you need to. We recommend that you prefer more modern cloud-native approaches, such as the Online product line, when you can.

> [!TIP]
>  For information about differences between corp and online workloads, see [What is the purpose of Connectivity, Corp, and Online management groups?](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups).

The following diagram shows an example of the corp connected subscription vending product line. You can use this setup for a hub-and-spoke network model to help effectively manage network traffic and policies.

:::image type="complex" source="./media/subscription-vending-product-line-1.svg" alt-text="Diagram that shows an example of the corp connected subscription vending product line." lightbox="./media/subscription-vending-product-line-1.svg" border="false":::
The diagram shows an example of the corp connected subscription vending product line with a network architecture that features a central Routable hub with an IP address of 10.1.0.0/24. The routable hub connects to two spokes: Landing zone A and Landing zone B, with IP addresses 10.1.1.0/24 and 10.1.2.0/24 respectively. The diagram also shows Virtual network peering connections between the hub and the landing zones, and other unspecified landing zones. This setup is typical for a hub-and-spoke network model and helps to manage network traffic and policies efficiently.
:::image-end:::

#### When to use the corp connected product line

Use the corp connected product line when:

- You want to perform Rehost and Refactor migrations and application builds based on [the five Rs of rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).

- You want to start your journey in Azure and are familiar with a similar on-premises architecture.

- You want to "lift and shift" applications into Azure.

- You want to enhance security between workloads by isolating applications into their own landing zone subscriptions and moving toward micro-segmentation principles from zero-trust without yet rearchitecting the application to be fully cloud-native.

Take note of these other considerations for the corp connected product line:

- Your platform team can vend the virtual network into the application landing zone subscription and peer the virtual network to the regional hub virtual network or the Azure Virtual WAN hub. Your team can then use an IP address management (IPAM) tool to control the IP address allocation.
  
- Platform teams don't usually vend subnets or any other resources into the virtual network. Instead, platform teams assign these activities to the application teams so that they can design their application networking how they want.

-  Platform teams use an Azure policy that's assigned to the management groups above the subscription to enforce desired behavior, such as standardized network security groups (NSGs) attached to every subnet. The application team inherits this Azure policy and can't edit it. This approach follows the Azure landing zone design principle of subscription democratization.

### The online product line

The *online product line*, also referred to as an *external or public product line*, for application landing zone subscription vending doesn't provide connectivity via traditional Layer-3 IP methods between resources in other application landing zones or on-premises through ExpressRoute or VPN connections. Resources in the same online application landing zone subscription can use virtual networks to communicate with each other via Layer-3 IP methods. But the virtual networks typically aren't peered back to regional connectivity hubs or other application landing zones.

Instead, you can provide connectivity via public interfaces between resources that are:

- In different application landing zones.
  
- On-premises.
  
- In workloads that are in different clouds.

You can secure the connections with network controls, authentication features, and authorization features that are exposed by the various platform as a service (PaaS) solutions that you use to construct the application.

You can use the [Private Link service](/azure/private-link/private-link-service-overview) and [Azure private endpoints](/azure/private-link/private-endpoint-overview) inside and between online application landing zone subscriptions to enable and expose private, Layer 3-based connectivity between applications. You can also use this approach between the PaaS services that you use within application landing zones to prevent the use of these PaaS services' public interfaces for security or regulatory control.

You can also use the [Private Link service](/azure/private-link/private-link-service-overview) with [private endpoints](/azure/private-link/private-endpoint-overview) to expose and publish applications that you host within online application landing zones to corp connected application landing zones, on-premises locations, or other clouds. You can place private endpoints in either corp-connected application landing zones or directly in connectivity hubs, which then grant access to these private endpoints via traditional Layer-3 connectivity methods such as virtual network peering, ExpressRoute connections, or VPN connections.

Think of the online application landing zone product line as isolated islands. By default, the only resources that can access resources within the subscription are the resources that you deploy within the same online application landing zone subscription. As mentioned previously, you can then use the techniques in this article to expand connectivity to other application landing zones, on-premises locations, or other clouds.

> [!TIP]
> For more information about the differences between corp and online workloads, see [What is the purpose of Connectivity, Corp, and Online management groups?](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups).

The following diagram shows an example of an online subscription vending product line.

:::image type="complex" source="./media/subscription-vending-product-line-2.svg" alt-text="Diagram that shows an example of the online subscription vending product line." lightbox="./media/subscription-vending-product-line-2.svg" border="false":::
This diagram shows an example of an online subscription vending product line that has a network architecture diagram with sections labeled Landing zone A, Landing zone B, Landing zone C, and Landing zone D. Each section includes icons for network elements like databases and cloud services, interconnected with arrows to show data flow. A central Routable hub 10.0.0/24 with a security lock icon connects to other landing zones depicted by cloud icons. Importantly, none of the virtual networks are peered together and all use modern services and approaches like private links to interact with each other.
:::image-end:::

#### When to use the online product line

Use the online product line when you want to:

- Refactor, rearchitect, rebuild, and perform migrations and application builds, based on [the five Rs of rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).

- Provide application teams with a fully democratized application landing zone to use, even regarding networking configuration.

- Take advantage of cloud-native services and architectures.

- Considerably enhance alignment with zero-trust principles.

- Use the corp connected product line, but private IP address space is unavailable or limited.

  - In this scenario, you should review the guidance in [Prevent IPv4 exhaustion in Azure](/azure/architecture/networking/guide/ipv4-exhaustion).

### The Tech platform product line

Teams that use technology platforms, such as Azure VMware Solution or Azure Virtual Desktop, should implement the *tech platform product line*. The tech platform product line is essentially a subscription vending product line that better suits highly technical requirements. You can use the tech platform product line to host and manage large and complex workloads that typically host multiple applications for several other application teams across your organization. Use this product line if your application team manages only the application parts and not the underlying technology platform pieces.

> [!TIP]
> To better understand this product line, consider the following example. A technology platform team, like an AKS team, aims to offer AKS as a managed service to other application teams that need to run their applications on the AKS platform. The AKS tech platform team provides the management, maintenance, security, and configuration of AKS. So the application team only maintains their application and deploys it on the platform.

You might include the following products in a tech platform product line:

- An **App Service Environment**, typically via separate App Service plans.
  
- **AKS**, typically via namespaces within one or more clusters.
  
- **Azure Virtual Machines** on Azure VMware Solution clusters or hosts.
  
- **Azure Virtual Desktop** to provide virtual desktops or applications to your entire organization.

You can include these products in either [corp connected](#the-corp-connected-product-line) or [online](#the-online-product-line) product lines, depending on the requirements for the technology platform that your team wants to provide as a service to other application teams in your organization.

### Shared application portfolio

The *shared application portfolio product line* for application landing zone subscription vending is for workloads that don't need several separate application landing zone subscriptions for simple applications that might be constructed from only a small number of Azure resources.

Your application teams and departments can use this product line to host several small applications or shared components, such as storage accounts or SQL servers. The teams share these components between several of their own applications in a single subscription or a small number of subscriptions.

> [!IMPORTANT]
> A common team owns subscriptions that you vend under this product line. This team manages the related portfolio of applications that you deploy in this subscription for this product line. Don't use this product line for general deployments of unrelated application workloads that have distinct application portfolio owners.
>
> Plan carefully to ensure ongoing flexibility, access control, governance, and maintainability if your organization changes to a single subscription and uses resource groups to delegate access.

If you consider resource group delegation in a single subscription between multiple teams, factor in the following considerations before you make a final decision:

| Area | Considerations |
| :--- | -------------- |
| Common ownership of related application portfolio | - Have a common owner, such as a business unit of a department, manage applications to simplify change management so that it remains within the approval scope of the same entity. <br><br> - Ensure that workloads follow consistent policy assignment across the subscription, including logging, monitoring, and security. |
| Regulatory compliance | - Use IAM and Azure policies to create subscriptions for workloads that have regulatory compliance requirements, including National Institute of Standards and Technology (NIST), Center for Internet Security (CIS), Payment Card Industry Security Standards Council (PCI SSC), industry requirements, and regional requirements. For more information, see [Tailor Azure landing zones](https://aka.ms/alz/tailoring). <br><br> - Create subscriptions for workloads that use privacy and data-handling requirements for governance. Individual subscriptions reduce access. |
| Azure Policy | Scope Azure policies to management groups, subscriptions, resource groups, and resources. Assign Azure policies at a high scope level for efficient governance when you deploy resources in resource groups. <br><br> Consider the following constraints when you manage Azure Policy at the resource group scope level: <br> - Increases management overhead to create Azure Policy assignments when you add new resource groups to subscriptions <br><br> - Increases workload when you manage changes to policy assignments <br><br> - Increases security and governance gaps when you don't immediately assign policies to resource groups <br><br>- Reduces the ability to roll up compliance status at high scopes, such as management groups and subscriptions |
| Subscription limits | - Check limits to ensure that applications don't hit hard limits that prevent growth. Each subscription has [soft and hard limits for Azure services](/azure/azure-resource-manager/management/azure-subscription-service-limits). <br><br> - Create separate subscriptions for applications that anticipate large growth patterns that meet subscription limits. <br><br> - Don't share subscriptions with application teams from different business units or departments to prevent [noisy neighbor](/azure/architecture/antipatterns/noisy-neighbor/noisy-neighbor) problems. |
| Azure services and feature alignment | You can deploy services that provide basic Azure service primitives, such as Virtual Machines, virtual networks, and simple PaaS services, within a single resource group. But the complexity of modern composite offerings can require that you deploy these more complex services outside the boundaries of a single resource group. Use other democratized subscription approaches that are described earlier in this article for these deployment scenarios. |
| Only platform teams can create resource groups | When you share a subscription among various application teams across business units or departments, you might restrict any team's ability to create new resource groups in the shared subscription. <br><br> This restriction limits resource group sprawl. Only the platform team can create and govern new resource groups. <br><br> This approach increases the complexity of RBAC assignments and places an increased dependency on platform teams to manage application deployments, which can impede application teams' agility and empowerment. |

You can place the subscriptions that you vend in the shared application portfolio product line under either Corp or Online management groups. This method aligns with the Azure landing zones default recommended hierarchy. Alternatively, you might place the subscriptions beneath new management groups if your organization's management group hierarchy follows the guidance in [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).

The following diagram shows an example of the shared application portfolio subscription vending product line.

:::image type="complex" source="./media/subscription-vending-product-line-3.svg" alt-text="Diagram that shows an example of the shared application portfolio subscription vending product line." lightbox="./media/subscription-vending-product-line-3.svg" border="false":::
This diagram shows an example of the shared application portfolio subscription vending product line that includes a network architecture diagram with a Routable hub labeled 10.0.0.0/24 at the center. This hub connects to various smaller elements, like a single virtual machine or storage account, for many applications that the same team controls. This includes a Routable spoke labeled 10.1.1.0/24, all in a single subscription carved into resource groups. The diagram also shows Additional landing zones that contain icons for different network components such as databases, storage services, and virtual machines that the share application portfolio subscription can connect to via virtual network peering through the hub.
:::image-end:::


Use the shared application portfolio product line if:

- Your application team needs to deliver several small resources or components that their applications share, but the components don't directly fit in any of the dedicated application landing zones.

- You have resources or components that you need to share between applications in the same department, but the components don't directly fit in any of the dedicated application landing zones.
  
- Technology platform teams want to host large, shared services that are managed, such as AKS, Azure Virtual Desktop, and Azure VMware Solution, so that other application teams can use or host their applications on the services.

### Sandbox

Use the *sandbox product line* for application landing zone subscription vending to help provide safe, lightly governed, and visible testing areas to build PoCs or MVPs in Azure.

For more information, see [Landing zone sandbox environments](https://aka.ms/alz/sandbox) and [Manage application development environments in Azure landing zones](https://aka.ms/alz/dtp).

Sandboxes are often time-boxed or budget-constrained, which means that they have a time limit or budget limit. In these cases, you must either extend or remove and decommission the sandbox.

If your organization doesn't provide a sandbox product line for application teams or others to test and experiment with services in Azure, teams might resort to *shadow IT* setups. If so, your organization might struggle to provide reporting and visibility and apply governance to subscriptions that business users create outside of your platform team's control and oversight.

Your platform team must provide easily accessible, preferably self-service, and automatically approved access to sandbox subscriptions for your organization's users and teams. Provide users and teams access to an environment that your platform team can view and govern to prevent *shadow IT* environments that the platform team can't access or control, which creates risk.

Sandboxes often follow the networking configuration approach of online product line subscriptions because you don't peer them to other virtual networks outside of the sandbox's subscription boundary. Sandboxes also often have extra controls to prevent hybrid connectivity to on-premises locations or other locations. Use these controls so that unknown sources can't exfiltrate data from sandboxes to unapproved locations. You can use an Azure policy to enforce these controls.

Just like the shared application portfolio and tech platform product lines, you can also share the sandbox product line among teams in the same department with the same considerations. Don't create a single sandbox subscription and share it among teams via resource groups. Instead, create additional sandbox subscriptions.

Use the sandbox product line if you need to provide a safe, secure, and governed Azure subscription to anyone across your organization who wants to experiment, create PoCs, or create MVPs in Azure. You must lightly govern these users and grant them access to all services to prevent *shadow IT* practices.





## Summary and takeaways

This article outlines prescriptive guidance to help you navigate complex subscription vending processes and move toward implementation.

Determine the requirements of your future application teams to choose the subscription vending product line that best suits them. Identify requirements for the initial set of workloads that you build or migrate to help prioritize the subscription vending product lines that you want to enable and expose via a self-service interface.

Each product line has an implementation cost and a maintenance cost. Evaluate the long-term cost versus long-term benefits and usage.

Customers typically enable the following subscription vending product lines initially:

- [Sandbox](#sandbox)
- [Corp connected](#the-corp-connected-product-line)
- [Online](#the-online-product-line)

### Additional resources

To further support your platform-engineering approach, review the following resources when you design and implement your organization's subscription vending product lines and offerings:

- [Video: How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)
- [Platform landing zones vs. application landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-landing-zones-vs-application-landing-zones)
- [Policies included in Azure landing zones reference implementations](https://aka.ms/alz/policies)
- [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
- [What is the purpose of Connectivity, Corp, and Online management groups?](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups)
- [Manage application development environments in Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments)
- [Platform engineering principles](/platform-engineering/about/principles)

## Next step

For the best results, you should automate as much of the subscription vending process as possible. Use the companion guidance about implementing subscription vending automation.

> [!div class="nextstepaction"]
> [Subscription vending implementation guidance](/azure/architecture/landing-zones/subscription-vending)
