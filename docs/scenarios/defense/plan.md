---
title: Plan for defense cloud adoption
description: Recommendations for planning a cloud adoption strategy in a defense organization
author: stephen-sumner
ms.author: wayneme
ms.reviewer: ssumner
ms.date: 12/6/2022
ms.topic: conceptual
---
# Plan for defense cloud adoption

The plan methodology falls within the command domain of cloud adoption.

:::image type="content" source="./images/command.png" alt-text="Figure that shows a domain tracker. It shows command, platform, and mission. Command is highlighted to show we're in the command domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - command domain*

The plan methodology is where mission owners prepare for cloud adoption. They need to define requirements, make decisions that help meet mission objectives, and engage the right stakeholders. These plans determine personnel and platform management needs. Proper planning helps ensure the project receives buy-in from stakeholders.

We recommend using a cloud broker, and planning is where mission owners select an approach to using cloud broker services. We assume mission owners have defined technical requirements to meet their objectives. If not, it's a prerequisite that must be in place before deciding the cloud broker strategy. Using a cloud broker is a best practice in defense organizations because of the many benefits the relationship provides. Some defense organizations mandate the use of a specific cloud broker in the chain of command. Given the importance and benefits of cloud brokers, it’s worth exploring cloud broker benefits and approaches.

## Cloud broker benefits

Cloud brokers are centralized groups that build and manage cloud platforms. Cloud brokers perform many of the tasks required to govern a cloud environment and make cloud adoption simpler for mission owners. Defense organizations sometimes have cloud broker requirements, and mission owners should factor these requirements into their plan. If mission owners can select from multiple cloud brokers, they need to determine which cloud broker offers the best services and price for this project.

Cloud brokers provided the following benefits:

**Governed platform landing zone** - The services, solutions, and applications hosted in a defense environment require governed environments. Cloud brokers build and maintain a governed platform environments (platform landing zones) that meets compliance requirements.

An Azure landing zone provides a target architecture that includes all the components defense applications need for secure, reliable, and cost-effective cloud operations (*see figure 2*). An Azure landing zone follows key principles across eight design areas. An Azure landing zone environment consists of platform landing zones and application landing zones.

- ***Platform landing zone***: A platform landing zone is a subscription that provides core services used by multiple applications. In the sample architecture (*see figure 2*), the components and subscriptions outlined in red are the platform landing zones. They provide shared services, such as identity, management, and connectivity, to the applications in this environment.

- ***Application landing zone***: An application landing zone is a subscription for hosting applications. In the sample architecture (*see figure 2*), the blue boxes outline the application landing zones. There are two application landing zones in the architecture: "Application landing zone A1 subscription" and "Application landing zone A2 subscription". The architecture only shows the "Application landing zone A2 subscription" in detail.

:::image type="content" source="./images/cloud-broker-landing-zone.png" alt-text="Diagram of an Azure landing zone architecture. A sample architecture showing the platform landing zone and application landing zones. It shows the Microsoft Entra tenant with management groups underneath. The management groups divide into platform, landing zones, decommissioned, and sandbox. Under these management groups and children management groups with subscriptions beneath them. The architecture shows the contents of these subscriptions. The platform landing zone management group contains identity, management, and connectivity subscriptions. There are black boxes around the platform landing zone subscriptions. The application landing zone management group contains two application landing zone subscriptions. The contents of one subscription is shown in detail. There are red boxes around the application landing zone subscriptions." lightbox="./images/cloud-broker-landing-zone.png" border="false":::
*Figure 2: Conceptual Azure landing zone architecture*

Without a cloud broker, mission owners are responsible for the application landing zones and platform landing zones. But with a cloud broker, mission owners only have to manage the application landing zones and can focus on modernizing applications to meet mission objectives. Cloud brokers bear the technical responsibility for the core services in the platform landing zones.

Platform landing zones feature design decisions that include the following disciplines:

- Cost Management
- Security Baseline Management
- Identity Baseline Management
- Resources Consistency
- Deployment Acceleration

For more information, see [platform vs. application landing zones](../../ready/landing-zone/index.md#platform-landing-zones-vs-application-landing-zones).

**Core services** - Cloud brokers implement and manage core services such as identity, networking, and management. In most instances, a cloud broker securely connects the new cloud environment to on-premises networks, builds operational environments, and establishes an identity access management (IAM) solution with policy enforcement based on mission requirements.

**Platform authorization to operate (ATO)** - Experienced cloud brokers can help achieve a platform-level ATO quicker than mission owners on their own. A platform-level ATO directly affects the speed at which mission owners can deploy critical applications. For more information, see [accelerating ATO](/azure/azure-government/compliance/documentation-accelerate-compliance).

**Improved efficiency** - A cloud broker can automate the flow of information, eliminating the need to manually generate data, and manage platform compliance requirements. This automation enables timely and accurate routing to approval authorities for application deployment, providing traceability and accountability. Without a cloud broker, mission owners have to navigate the following hurdles:

- Obtaining and allocating funds
- Managing oversight and compliance requirements
- Obtaining approval from security teams
- Handing off the project to technical teams for application build

These activities can last weeks or months, and in some cases years. The cloud broker simplifies and expedites the process for mission owners.

## Cloud broker approaches

There are different approaches for mission owners to consider when using a cloud broker. Mission owners can use a single cloud broker or multiple cloud brokers, and the right approach depends on mission needs.

**Single cloud broker approach** - In a single cloud broker approach, mission owners contract cloud services with a single entity. There might be various support models, but the cloud broker is the single point-of-contact. A single cloud broker provides a single cloud identity solution referred to as a tenant. There are some distinct advantages to single tenancy. A single tenant offers the following benefits:

- Reduces identity and access management complexity by improving visibility and transparency across all cloud environments
- Improves security while facilitating compliant information sharing
- Simplifies building a zero-trust architecture
- Increases data transfer efficiency between war fighters in austere conditions

If these benefits meet the needs of mission owners, then a single broker is likely the better approach.

**Multiple cloud broker approach** - A multiple-cloud-brokers approach uses two or more cloud brokers to provide managed cloud services. Multiple cloud brokers are better in complex organizations, and defense environments often have enough complexity to warrant a multiple cloud broker strategy. But there's a caveat. Multiple cloud brokers can add more risk to the cloud adoption plan and add more communication lines for the organization to manage.

The following factors can help you determine if the multiple cloud broker approach is the right one.

- ***Ownership***: Mission owners might need their own cloud brokers. Decision-making groups often need their own tenant to meet mission-objectives and avoid delays due to dependencies.

- ***Isolation***: Mission owners might need isolated environments for compliance, governance, or identity reasons. Each tenant (instance of Microsoft Entra ID) represents an isolated identity environment and can create a firm isolation barrier when needed.

- ***Management***: Separating complex environments might be ideal for managing and modernizing your cloud applications. But this management separation creates increased complexity higher in the command chain. It becomes more difficult to have a single view of all cloud assets.

- ***Security***: Data compliance for varying impact levels might require multiple tenants and multiple cloud brokers authorized and with the experience to manage those impact levels.

The multi-cloud-broker strategy can be used at different levels in a defense organization. A broker can be assigned to individual military branches (naval, air, ground) or groups of applications. The choice depends on the needs of your defense organization around ownership, isolation, management, and security.

For more information, see [Planning overview](../../plan/plan-intro.md) and [Migration assessment checklist](../../migrate/assess/index.md).

## Next step

Planning prepares defense organizations for execution. The organize methodology uses this plan and starts completing the nontechnical prerequisites.

> [!div class="nextstepaction"]
> [Organize](organize.md)
