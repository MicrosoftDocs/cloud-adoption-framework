---
title: How to initiate a cloud relocation project.
description: Learn how to initiate a cloud relocation project so you can relocate workloads and applications to another region.
author: SomilGanguly
ms.author: ssumner
ms.date: 2/3/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Initiate a cloud relocation project

The Initiate phase is a single-step process to establish the relocation process. In this phase, you identify objectives, determine scope, prioritize workloads, and create a relocation plan to meet those objectives. The Initiate step relies on well-known project management best practices. The guidance here's succinct and focuses on four key aspects of this step.

:::image type="content" source="../_images/relocate/caf-relocate-initiate.png" alt-text="Image that shows the relocation process and highlights the Initiate step in the Move phase. In the relocation process, there are two phases and five steps. The first phase is the initiate phase, and it has one step called initiate. The second phase is the Move phase. It has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-initiate.png" border="false":::
*Figure 1. The Initiate step of relocation.*

## Identify objectives

The need to meet specific objectives drives relocation projects. You should capture these objectives so you can scope and prioritize your relocation efforts. The following table provides examples of relocation objectives.

*Table 1. Example relocation objectives.*

|Objective |Motivation |Priority|
| --- | --- | --- |
|1. Comply with data-residency laws. | Meet all legal and ethical standards. | High|
|2. Improve application performance for users in a different region. | Meet revenue targets. |Medium|
|3. Add new service to internal productivity tools. | Increase employee productivity. |Low|

## Determine scope

The objectives for relocation determine the scope of the project. With your objectives in place, you can identify the workloads you need to relocate to meet those objectives. As a reminder, a workload is a collection of services, applications, and data that support a defined process. The workload should be the smallest unit of relocation. Anything smaller becomes difficult to manage. For more information, see [What is a workload?](/azure/cloud-adoption-framework/plan/workloads#what-is-a-workload).

## Prioritize workloads

The order you relocate workloads should be intentional and should reflect the priority of your objectives (see *Table 1*). Any technical dependencies, such as platforms and landing zones, should go first. Outside of technical dependencies, the order is up to you. For more information, see [Platform vs application landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-vs-application-landing-zones).

## Create a relocation plan

You should create a relocation plan that addresses service capacity and high-level project planning. At the service level, you want to verify the target region meets the capacity needs for each workload service. The rest of your relocation plan should center on the relocation project and getting stakeholder approval to proceed. Most stakeholders want to know about the schedule, team, and cost. Rather than spending time trying to estimate the schedule, resources, and cost, start the relocation process and refine the estimates as you learn more. But here are recommendations for creating an initial plan with the elements you need.

**Build a soft schedule.** The schedule depends on the complexity of the workloads being relocated and the experience of the team involved. Instead of spending time figuring out how long it will take, start relocating the first workload. The experience allows you to better estimate a completion date, and it saves you time.

**Use a multi-disciplinary team.** The relocation team needs technical, business, and legal/compliance expertise. The business stakeholders own the workload and should guide the technical team to meet the objectives. You need the legal or compliance teams if the workload is being relocated due to regulatory requirements.

**Know cost factors.** Relocation has a cost. Moving data and using services isn't always free. To minimize cost, you should move data once and avoid duplicating services or environments for long periods of time.  A hidden cost you might not consider comes from suppliers, partners, or third-party technical support. You might need their help to relocate a workload, and they typically charge a fee.

## Next steps

With the relocation project initiated, you enter the Move phase of relocation. The Move phase has five stages: evaluate, select, migrate, cutover, and close. Each workload goes through the first four stages. You repeat these four stages until you've relocated every workload.

> [!div class="nextstepaction"]
> [Evaluate](evaluate.md)
