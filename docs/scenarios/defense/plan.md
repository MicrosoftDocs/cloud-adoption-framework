---
title: Plan for defense cloud adoption
description: Recommendations for planning a cloud adoption strategy in a defense organization
author: stephen-sumner
ms.author: wayneme
ms.reviewer: ssumner
ms.date: 10/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---
# Plan for defense cloud adoption

The plan methodology is the second step in the mission phase of cloud adoption.

:::image type="content" source="./images/mission.png" alt-text="Graphic showing the mission domain of cloud adoption." border="false":::

The plan methodology is where you prepare your organization for cloud adoption. You need to make decisions that help you meet your objectives and share your vision with the right stakeholders. The plans you set determine the personnel need and the management of your platform. You need to get buy-in from stakeholders and decide on a cloud broker strategy that meets your mission objectives.

An important decision mission owners need to make during planning is to use a cloud broker or not. We believe using a cloud brokers provides defense organizations distinct benefits. We'll focus on the cloud broker here.

## Use a cloud broker

Cloud brokers are third-party vendors that build and manage cloud platforms for mission owners. We recommend you work with a cloud broker to implement your cloud strategy. Cloud brokers make cloud adoption and ongoing operations much easier for mission owners. Here are some of the ways cloud brokers make it easier for defense organizations to adopt the cloud:

Compliant landing zone - Cloud brokers build and maintain a complaint landing zone for mission owners. The services, solutions, and workloads hosted in a defense environment need a secure and compliant architecture. We call this required architecture a landing zone. A landing zone includes all the foundational components defense workloads need to operation securely in the cloud. Below is a generalized landing zone architecture for defense scenarios.

:::image type="content" source="./images/cloud-broker-landing-zone.png" alt-text="Diagram of an Azure landing zone architecture. A red box around the landing zone subscription outlines mission owner responsibilities with a cloud broker. The cloud broker handles the rest of the architecture." lightbox=".image/cloud-broker-landing-zone-lightbox.png":::

*Diagram 2: Azure landing zone architecture*

Without a cloud broker, mission owners would be responsible for this entire architecture and its subservices. But with a cloud broker, mission owners only need to manage the resources inside the red box. Cloud brokers build and manage the rest.

Delivery of core services - Cloud brokers implement and manage core services. such as identity, networking, and compliance. In most instances, a cloud broker securely connects the new cloud environment to on premise networks, builds operational environments, and establishes an identity access management solution (IAM).
Achieve a platform-level authorization to operate (ATO) - Experienced cloud brokers can help achieve a platform-level ATO faster. A platform-level ATO This directly affects the speed at which a Mission can build their applications and workloads.

Improve efficiency - When mission owners try to build applications in a traditional environment, there is an intricate process flow and movement of information between departments. You must obtain and allocate funds, comply with oversight requirements, obtain approval from security teams, and hand-off to technical teams to perform the application build. These processes can take anything from a couple of weeks to months, even years. A cloud broker automates the flow of information. It eliminates the need to recapture information and enables routing to respective approvers and automating builds. It’s all done with a greater degree of traceability and accountability.

Cloud broker approach
There are a few different approaches you can take with cloud brokers. We want to focus on the two most common approaches: single cloud broker approach or multiple cloud broker approach. 

Single cloud broker
In a single cloud broker strategy, mission owners have a contract with a single managed-cloud-service provider. There may be various support models, but the cloud broker will be a single entity. A single cloud broker means you have one Azure tenant (one instance of Azure Active Directory) and a single cloud identity solution. A single identify solution simplifies identity and access management. It improves visibility and transparency across all cloud environments. It improves security while facilitating secure information sharing. It is easier to build a zero-trust environment and more efficient to get data to and from the warfighters in austere conditions. We recommend a single tenant where possible because of its benefits.

Multiple cloud brokers
A multiple-cloud-brokers approach uses two or more cloud brokers to provide managed cloud services. Multiple cloud brokers appeal to complex organizations, and defense environments often have enough complexity to warrant a multiple cloud broker strategy. 

Three factors drive a multiple-cloud-broker strategy. These three factors are ownership, isolation, and management. Your needs around these three factors will determine if you need multiple cloud brokers or not

- Ownership – You might need to align assign a cloud broker to each mission owner. Decision-making groups often need their own tenant to meet mission-objectives and avoid delays due to dependencies.
- Isolation – You might need to isolate environments for compliance, governance, or identity reasons. Each tenant (instance of Azure Active Directory) represents an isolated identity environment and can create a firm isolation barrier when needed. 
- Management – separating complex environments might be the best way to manage, optimize, and modernize your workloads in the cloud.
- Security – data security and compliance for different impact levels might require multiple tenants and multiple cloud brokers authorized and experience to manage at that impact level.

You can use the multi-cloud-broker strategy at different levels in your organization. You can divide military branches (naval, air, ground) or groups of applications.

## Next steps

Strategy alignment is the first step in cloud adoption for a defense organization.

> [!div class="nextstepaction"]
> [Organize](organize.md)