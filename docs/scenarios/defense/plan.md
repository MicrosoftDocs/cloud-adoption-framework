---
title: Plan for defense cloud adoption
description: Recommendations for planning a cloud adoption strategy in a defense organization
author: stephen-sumner
ms.author: wayne.meyer, michael.mcKanna
ms.reviewer: ssumner
ms.date: 10/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---
# Plan for defense cloud adoption

The plan methodology falls within the mission domain of cloud adoption (*see image*).

:::image type="content" source="./images/mission.png" alt-text="Figure that shows a domain tracker. It shows mission, platform, and workload. Mission is highlighted to show we're in the mission domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - mission domain*

Any transformation requires a plan, and cloud adoption is no exception. The plan methodology is where mission owners prepare for cloud adoption. They need to make decisions that will help meet mission objectives and align the project with the right stakeholders. These plans will determine personnel and platform management needs. Proper planning helps ensure the project receives buy-in from stakeholders.

Mission owners have to determine the right cloud broker approach. Cloud brokers provide defense organizations with distinct benefits. Using a cloud broker a best practice in defense organizations. Some defense organizations mandate the use of a specific cloud broker in the chain of command. The planning phase of cloud adoption is where mission owners need to pick the right cloud broker approach.

Given the importance and benefits of cloud brokers, it’s worth exploring cloud broker benefits and approaches.

## Cloud broker benefits

Cloud brokers are centralized groups that build and manage cloud platforms. Cloud brokers perform many of the tasks required to govern a cloud environment and make cloud adoption much simpler for mission owners. Defense organizations sometimes have cloud broker requirements, and mission owners should factor these requirements into their plan. If mission owners can select from multiple cloud brokers, they'll need to determine which cloud broker offers the best services and price for this project.

Cloud brokers provided the following benefits:

- Govern landing zones
- Core services
- Platform authorization to operate (ATO)
- Improved efficiency

**Governed landing zone** - Cloud brokers build and maintain platforms that meet compliance requirements. The services, solutions, and workloads hosted in a Defense environment require governed architecture. These governed architectures are referred to as landing zones. Landing zones feature design decisions in the following disciplines:

- Cost Management
- Security Baseline Management
- Identity Baseline Management
- Resources Consistency
- Deployment Acceleration

It's important to note that the term landing zone can refer to the entire platform or the area that a mission owner will maintain. A landing zone includes all the foundational components defense workloads needed for secure, reliable, and cost-effective cloud operations. Below is a generalized landing zone architecture for defense scenarios.

:::image type="content" source="./images/cloud-broker-landing-zone.png" alt-text="Diagram of an Azure landing zone architecture. A red box around the landing zone subscription outlines mission owner responsibilities with a cloud broker. The cloud broker handles the rest of the architecture." lightbox=".image/cloud-broker-landing-zone-lightbox.png":::
*Diagram 2: Azure landing zone architecture with mission owner responsibilities outlined in red*

Without a cloud broker, mission owners are responsible for the entire landing zone architecture and associated services. But with a cloud broker, mission owners shift the compliance and management responsibilities to the broker and focus on meeting mission objectives.

**Core services** - Cloud brokers implement and manage core services. such as identity, networking, and compliance. In most instances, a cloud broker securely connects the new cloud environment to on-premises networks, builds operational environments, and establishes an identity access management (IAM) solution with policy enforcement based on mission requirements.

**Platform authorization to operate (ATO)** - Experienced cloud brokers can help achieve a platform-level ATO quicker. A platform-level ATO directly affects the speed at which mission owners can deploy critical applications and workloads.

**Improved efficiency** - A cloud broker can automate the flow of information, eliminating the need to manually generate data points or documents. This automation enables timely and accurate routing to approval authorities for workload deployment, providing traceability and accountability. Without a cloud broker, mission owners have a lot more do. They've to:

- Obtain and allocate funds
- Comply with oversight requirements
- Obtain approval from security teams
- hand-off to technical teams for application build

These activities can last weeks or months, and in some cases years. The cloud broker simplifies and expedites this process.

## Cloud broker approaches

There are different approaches for mission owners to consider when using cloud broker. Mission owners can use a single cloud broker or multiple cloud brokers. The right approach depends on mission needs.

**Single cloud broker approach:**

In a single cloud broker strategy, mission owners contract cloud services with a single entity. There might be various support models, but the cloud broker is the single point-of-contact. A single cloud broker would provide a single cloud identity solution referred to as a tenant. A single tenant offers the following benefits:

- Reduces identity and access management complexity by improving visibility and transparency across all cloud environments
- Improves security while facilitating compliant information sharing
- Simplifies building a zero-trust architecture
- Increases data transfer efficiency between war fighters in austere conditions

If these benefits meet the needs of mission owners, then a single broker might be the preferred approach.

**Multiple cloud broker approach:**

A multiple-cloud-brokers approach uses two or more cloud brokers to provide managed cloud services. Multiple cloud brokers appeal to complex organizations, and defense environments often have enough complexity to warrant a multiple cloud broker strategy. But this scenario can add more risk to the cloud adoption plan and add more communication lines for the organization to manage.

The factors listed below will help you determine if the multiple cloud broker approach is the right one:

- ***Ownership*** – Mission owners might need their own cloud brokers. Decision-making groups often need their own tenant to meet mission-objectives and avoid delays due to dependencies.
- ***Isolation*** – Mission owners might need isolated environments for compliance, governance, or identity reasons. Each tenant (instance of Azure Active Directory) represents an isolated identity environment and can create a firm isolation barrier when needed.
- ***Management*** – Separating complex environments might be ideal for managing and modernizing your cloud workloads. There's increased complexity higher up in the command chain as it is difficult to have a single view of all cloud assets.
- ***Security*** – Data compliance for varying impact levels might require multiple tenants and multiple cloud brokers authorized and with the experience to manage those impact levels.

The multi-cloud-broker strategy can be used at different levels in a defense organization. A broker can be assigned to individual military branches (naval, air, ground) or groups of applications. The choice depends on the needs of your defense organization around ownership, isolation, management, and security.

## Next steps

Planning prepares defense organizations for execution. The organize methodology uses this plan and starts completing the non-technical prerequisites.

> [!div class="nextstepaction"]
> [Organize](organize.md)
