---
title: Establish common subscription vending product lines
description: Learn about establishing common subscription vending product lines.
author: jtracey93
ms.author: jatracey
ms.date: 03/27/2024
ms.topic: conceptual
---

# Establish common subscription vending product lines

As outlined in the [Subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending) guidance, most customers aspire to be able to allow application teams to be able to request and gain access to newly provisioned Azure Subscriptions to use as their application landing zones to host their workloads and services within, via a self-service process and supporting tooling and automation.

Subscription vending helps organizations achieve the [subscription democratization design principle](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization) of Azure Landing Zones, which is critical to consistent scale, security and governance of Azure environments. It also helps organizations align to the [platform engineering principles](/platform-engineering/about/principles) of ["Adopt a product mindset"](/platform-engineering/about/product-mindset) and ["Empower developers through self-service with guardrails"](/platform-engineering/about/self-service).

> [!TIP]
> The Azure Landing Zones team have published a YouTube video that is also useful to review when looking at this topic [Azure Landing Zones - How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

:::image type="content" source="./media/sub-vend-product-line0.png" alt-text="Diagram showing the subscription vending process in the context of Azure Landing Zones." lightbox="./media/sub-vend-product-line0.png" border="false":::

Some questions you may have when deciding on the approach to implement subscription vending in your organization are:

- "What other resources should the platform team vend as part of the subscription vending process?"
- "Do we deploy multiple subscriptions, such as one per environment, by default for each application team?"
- "Do we peer or connect the spoke Virtual Network for every application back to our connectivity hubs, by default?"
- "How should we structure role-based access control (RBAC) within each subscription?"
- "How should we govern and control resources and styles of architecture (archetypes) used within subscriptions?"

There's no single answer and no single type nor style of subscription that can be vended to address the unique requirements of every application and platform team. Therefore, platform teams must provide application teams with flexibility through choice of multiple types and styles of subscriptions that can be vended to them via a self-service system. These types of subscriptions are referred to as product lines.

Continue reading to learn why different product lines are required and examples of common product lines used through Azure landing zones and subscription vending.

> [!NOTE]
> Review [Platform landing zones vs. application landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-landing-zones-vs-application-landing-zones) to gain further understanding as to their differences and also the different management approaches for application landing zones.

> [!TIP]
> Azure policy is a key service used in Azure Landing Zones to help govern and secure application landing zone subscriptions at scale.
>  
> Azure Landing Zones provides a baseline of policy definitions, initiatives, and assignments to help customers get started in the cloud adoption journey; these are documented here [Policies included in Azure landing zones reference implementations](https://aka.ms/alz/policies)

## Why do we need different product lines?

There's no "one size fits all" for the types and styles of subscriptions that application teams require to deliver their workloads and services. And outside of application teams there will be other requirements, such as different compliance and data handling rules or architecture patterns, from your organization that requires the use of an Azure Subscription.

Organizations that only provide a "one size fits all" approach to subscription vending often have their internal customers (for example, application teams) be limited by the lack of flexibility that might affect their architecture design choices and potentially lead to compromises, due to what they have had vended to them.

Therefore, platform teams need to provide various product lines (for example, types/styles of subscriptions to be vended) to their organization to ensure that the consumers can choose the best fit product line based upon their requirements.

> [!TIP]
> Review the [Prioritize Customers Platform Engineering principle](/platform-engineering/about/customers) to further understand why this topic is important for platform teams to provide flexibility.

### Manage different application environments (dev/test/prod)

Organizations need to handle different application environments for application teams as part of their subscription vending processes and implementations. There is existing guidance covering this topic in the [Environments, subscriptions, and management groups section of Manage application development environments in Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-application-environments#environments-subscriptions-and-management-groups). However, you should provide flexibility to allow application teams to manage their differing application environments (dev/test/prod) when delivering their application in the way the desire.

Some Azure services provide native features to aid with environment isolation within a single instance of a resource, which lives in a single Azure subscription, such as Azure App Services with its Deployment Slots feature. In this example, forcing application teams to use separate subscriptions doesn't allow the application teams to take advantage of the full feature set of the services provided by Azure. It can also increase costs to deliver their application, including operational and maintenance overhead.

## Common Product Lines for Subscription Vending

Now that you understand that platform teams must provide multiple types and styles of Azure Subscriptions (product lines) to the consumers of their Azure platform. What follows are several common product lines that can be used across industries and countries/regions.

These common subscription vending product lines should be used by platform teams as a baseline. They can provide multiple options out of the box to their consumers, meeting the "prioritize customers" platform engineering principle. This provides their internal customers the freedom they require to deliver their workloads and services, while being governed by the Azure platform, via the use of Azure landing zones [design principles](https://aka.ms/alz/design/principles) and [design area recommendations](https://aka.ms/alz/design/areas).

> [!NOTE]
> These are only examples and should be used as a starting point for organizations. They can of course be customized and expanded to cater to the needs of each organization.

> [!TIP]
> Platform teams should review [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz) and implement any changes to their architecture to support any product lines they decide to implement based on their organization's needs.

Common product lines for subscription vending are:

- [Corp connected](#corp-connected)
- [Online](#online)
- [Tech platform](#tech-platform)
- [Shared application portfolio](#shared-application-portfolio)
- [Sandbox](#sandbox)

### Corp connected

The Corp connected, also referred to as "internal/private", product line for application landing zone subscription vending provides connectivity, via traditional layer 3 (IP) methods, between resources in the same application landing zone, other corp connected application landing zones (normally via an Azure Firewall or Network Virtual Appliance (NVA)) and on-premises or other clouds via ExpressRoute or VPN connections.

This is a core product line for subscription vending as it aligns closely with how most on-premises environments work today. However, it should only be used when appropriate and taking advantage of more modern cloud-native approaches, such as the Online product line, is advised.

> [!TIP]
> Review the [What is the purpose of Connectivity, Corp, and Online Management Groups?](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups) section in the networking design area to gain further understanding of the differences between corp and online workloads.

:::image type="content" source="./media/sub-vend-product-line1.png" alt-text="Diagram showing an example of the corp connected subscription vending product line" lightbox="./media/sub-vend-product-line1.png" border="false":::

#### Use the corp connected product line when

- You want to perform Rehost & refactor migrations and application builds; based on [the five Rs of rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization)
- You want to start your journey in Azure and are familiar with a similar on-premises architecture
- You want to "lift and shift" applications into Azure
- You want to also enhance the security between workloads by isolating applications into their own landing zone subscriptions and moving towards micro-segmentation principles from zero-trust without rearchitecting the application to be fully cloud native, yet.

#### Other important notes about the corp connected product line

- Commonly platform teams vend the Virtual Network into the application landing zone subscription and peer to the regional hub Virtual Network or Virtual WAN Hub
  - This is so they can control the IP address allocation, usually via an IPAM tool.
- Platform teams don't commonly vend subnets nor any other resources into the Virtual Network. Instead, they democratize these activities to the application teams, as they're then able to design their application networking as they desire.
  - Platform teams then enforce the desired behavior, such as standardized Network Security Groups attached to every subnet, by using Azure Policy that is assigned to the Management Groups above the Subscription and therefore inherited and not editable by the application team. This approach follows the ALZ design principle of Subscription Democratization

### Online

The Online, also referred to as "external/public", product line for application landing zone subscription vending provides no connectivity via traditional layer 3 (IP) methods, between resources in other application landing zones or on-premises via ExpressRoute or VPN connections. Resources in the same online application landing zone subscription can communicate with each other via layer 3 (IP) methods using Virtual Networks, but they're commonly not peered back to regional connectivity hubs or other application landing zones.

Instead, communication between resources in other application landing zones and on-premises or workloads in other clouds communicate via their public interfaces and are secured with the network controls, authentication, and authorization exposed via the various PaaS services used to construct the application.

[Private Link Services](/azure/private-link/private-link-service-overview) and [Private Endpoints](/azure/private-link/private-endpoint-overview) are used in and between Online application landing zone subscriptions to enable and expose private, layer 3 (IP) based, connectivity between applications and between the PaaS services used within application landing zones to prevent the public interfaces of these PaaS services being used, if necessary for security or regulatory control reasons.

[Private Link Services](/azure/private-link/private-link-service-overview) together with [Private Endpoints](/azure/private-link/private-endpoint-overview) can also be used to expose and publish applications hosted within online application landing zones to corp connected application landing zones, on-premises or other clouds by placing private endpoints in either corp connected application landing zones or directly in connectivity hubs that then allow these private endpoints to be accessed via traditional layer 3 (IP) connectivity methods; such as Virtual Network Peerings, ExpressRoutes, or VPNs.

A great way to think about the online application landing zone product line is isolated islands. Meaning that by default the only resources that can access resources within the subscription are resources that are deployed within the same online application landing zone subscription. Then as above connectivity can be expanded to other application landing zones, on-premises location or other clouds by the techniques mentioned and linked above.

> [!TIP]
> Review the [What is the purpose of Connectivity, Corp, and Online Management Groups?](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity#what-is-the-purpose-of-connectivity-corp-and-online-management-groups) section in the networking design area to gain further understanding of the differences between corp and online workloads.

:::image type="content" source="./media/sub-vend-product-line2.png" alt-text="Diagram showing an example of the online subscription vending product line" lightbox="./media/sub-vend-product-line2.png" border="false":::

#### Use the online product line when

- Refactor, rearchitect, rebuild, migrations, and application builds; based on [the five Rs of rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization).
- Providing a fully democratized application landing zone to application teams to use, even regarding networking configuration.
- Wanting to tale advantage of cloud-native services and architectures.
- There's a desire to considerably enhance alignment to zero-trust principles.
- Private IP address space isn't available or constrained to be able to use the Corp connected product line.
  - In this scenario you should review the guidance in [Prevent IPv4 exhaustion in Azure](/azure/architecture/networking/guide/ipv4-exhaustion)

### Tech platform

The tech platform product line provides technology platform focused teams, such as ASE, AKS, AVS, AVD, a subscription vending product line that better suits their requirements. It allows these teams to host and manage complex workloads that, in turn, commonly host multiple related applications for other application teams across an organization.

> [!TIP]
> One way to understand this product line is that the technology platform team, for example AKS, aim to offer "AKS-as-a-Service" (or product according to platform engineering terms) to other applications teams who need to run their applications on the AKS platform but leave the management, maintenance, security and configuration of AKS itself to the tech platform team for AKS; while the app team only has to care about their application and deploying it on the platform.

Examples include ASE (typically via separate App Services Plans), AKS (typically via namespaces), VMs on AVS clusters and AVD providing virtual desktops or applications to an entire organization.

These can also use either [Corp Connected](#corp-connected) or [Online](#online) product lines in relation to networking etc. depending upon the requirements for the technology platform that the team wishes to provide as a service to other application teams in the organization.

### Shared application portfolio

The shared application portfolio product line for application landing zone subscription vending helps answer the question that platform and application teams within organizations might now be wondering; *"do we really need a separate application landing zone subscription for simple applications that might only be constructed from a small number of Azure resources?"*

This product line provides the option for application teams and departments that need to host several smaller applications or shared components such as storage accounts or SQL servers that are shared between several of their own applications, in a single, or lesser number of subscriptions.

> [!IMPORTANT]
> It's important to highlight that subscriptions vended under this product line are owned by a common team responsible for the related portfolio of applications deployed in this subscription for this product line. This product line is not intended for general deployments of unrelated application workloads owned by distinct application portfolio owners.
>
> It will require careful planning to ensure ongoing flexibility, access control, governance, and maintainability when organizations decide to carve up a single Subscription using Resource Groups to delegate access.

If Resource group delegation in a single Subscription between multiple teams is considered, it should be approached factoring in the extra considerations below before making a final decision:

| Area | Considerations |
| :--- | -------------- |
| Common ownership of related portfolio of applications | - Applications managed by a common owner (such as Business Unit of Department) simplify change management as all within the approval scope of the same entity. <br> - Workloads follow consistent policy assignment across the subscription, including Logging, Monitoring, Security. |
| Regulatory Compliance | - Workloads governed by different regulatory compliance such as NIST, CIS, PCI, industry, and regional requirements might require own subscriptions for governance using IAM and Azure Policies, as per [ALZ tailoring guidance](https://aka.ms/alz/tailoring). <br> - Workloads governed by privacy and data handling requirements might require their own subscriptions to reduce access. |
| Azure Policy | Azure Policies can be scoped to management groups, subscriptions, resources groups, and resources. Policy assignment at high scopes (management groups and subscriptions), allows for efficient governance when resources are deployed in resource groups. <br> It's important to consider following constraints when managing Azure Policy at resource group scope. These constraints are: <br> - Management overhead to create Azure Policy assignments when new resource groups are added to subscriptions and increased toil when managing changes to policy assignments. <br> - Increased security and governance gaps when resource groups aren't immediately assigned policies. <br> - Reduced the ability to roll up compliance status at high scopes (management group and subscription) |
| Subscription Limits | - Each subscription has [soft and hard limits for Azure services](/azure/azure-resource-manager/management/azure-subscription-service-limits). It's important to check limits to ensure applications doesn't hit hard limits that prevent growth. <br> - Separate subscriptions are required when applications anticipate large growth patterns that would hit subscription limits. <br> - Sharing subscriptions with application teams from different business units/departments could lead to [noisy neighbor](/azure/architecture/antipatterns/noisy-neighbor/noisy-neighbor) style issues. |
| Azure Services & Feature Alignment | While services that provide basic Azure service primitives, such as Virtual Machines, Virtual Networks, and simple PaaS services, can be deployed within a single Resource Group, the complexity of modern composite offerings can require that these more complex services be deployed outside the boundaries of a single Resource Group. These deployment scenarios are better suited for the other subscription democratized approaches outlined above. |
| Restricting Resource Group Creation to Platform Teams Only | When sharing a subscription between different application teams across different business units/departments, it's common to restrict any team from being able to create new Resource Groups in the shared subscription. <br><br> This restriction is intended to limit resource group sprawl and new resource groups are created and governed solely by the platform team. <br><br> This approach increases the complexity of RBAC assignments and places an increased dependency on platform teams to manage application deployments, which can impede the agility and empowerment of application teams. |

> [!NOTE]
> Even though this is a different product line, the subscriptions vended using this product line would still be placed under the either the Corp or Online Management Groups from the Azure Landing Zones default recommended hierarchy.
>
> Alternatively, they might be placed beneath new Management Groups in an organizations Management Group hierarchy that is following the guidance in [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).

:::image type="content" source="./media/sub-vend-product-line3.png" alt-text="Diagram showing an example of the tech platform/shared application portfolio subscription vending product line" lightbox="./media/sub-vend-product-line3.png" border="false":::

#### Use the shared application portfolio product line when

- An application team that has several smaller resources/components to deliver that are shared between their applications that they're responsible for, but they don't fit in any of these dedicated application landing zones directly
  - The same is also true for resources/components that might need to be shared between applications in the same department.
- Technology platforms teams want to host larger shared platforms as a service, such as AKS, AVD, AVS, that they wish to allow other applications teams to use or host their applications upon.

### Sandbox

The sandbox product line for application landing zone subscription vending is critical to help organizations provide safe, lightly governed and visible testing areas for anyone within an organization wishing to test, PoC, or MVP something in Azure.

> [!TIP]
> Checkout the existing sandbox guidance in [Landing zone sandbox environments](https://aka.ms/alz/sandbox) & [Manage application development environments in Azure landing zones](https://aka.ms/alz/dtp)

Sandboxes are commonly ephemeral, meaning they're either time boxed or budget constrained and at the point of hitting the time or budget limit they either need to be extended or they're removed and decommissioned.

Organizations that don't provide a sandbox product line for application teams, or anyone else within their organization to have access to test and experiment with services in Azure might see lots of "shadow IT" setups and might struggle to provide any reporting, visibility, and apply any form of governance to the subscriptions that users within the business create outside of the control and oversight of the platform team.

Therefore, it's critically important that platform teams provide easily accessible, preferably self-service, and auto approved, access to sandbox subscriptions for users and teams in their organizations. As it's better to give them access to something that can be seen and governed by a platform team than for it to be created in a "shadow IT" style and somewhere where the platform has no access or control over, which therefore creates a risk for the organization.

:::image type="content" source="./media/sub-vend-product-line3.png" alt-text="Diagram showing an example of the tech platform/shared application portfolio subscription vending product line" lightbox="./media/sub-vend-product-line3.png" border="false":::

Sandboxes often follow the networking configuration approach of the online product line subscriptions, in that they aren't peered to other Virtual Networks outside of their own subscription boundary and they often have further controls to prevent any form of hybrid connectivity being established to other locations, such as on-premises etc.; this is to help ensure that data can't be exfiltrated from sandboxes to unknown and unapproved locations. These controls are enforced via Azure Policy.

#### Use the sandbox product line when

- To provide a safe, secure, governed Azure subscription to anyone across the organization when they're looking to experiment, PoC, MVP in Azure.
  - These must be lightly governed and allow access to all services so that it doesn't force them to consider "shadow IT" practices.

### Other important notes about the sandbox product line

- Just like the Shared Application/Department Workload/Tech Platform product line, the sandbox product line can also be shared among teams in the same department with the same considerations.
  - E.g., , there shouldn't be a single or a few sandbox subscriptions that people are given access to resource groups in.

## Next steps

For the best results, you should automate as much of the subscription vending process as possible. Use the companion guidance on implementing subscription vending automation.

> [!div class="nextstepaction"]
> [Subscription vending implementation guidance](/azure/architecture/landing-zones/subscription-vending)
