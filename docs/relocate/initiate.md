---
title: How to initiate a cloud relocation project.
description: Learn how to initiate a cloud relocation project so you can relocate workloads and applications to another region.
author: SomilGanguly
ms.author: ssumner
ms.date: 02/03/2023
ms.reviewer: ssumner
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Initiate a cloud relocation project

The Initiate phase is a single step to establish the relocation project. The guidance in the Initiate phase is more important for large relocation efforts with multiple workloads in scope. For small relocation with a single workload in scope, you can skip to [create a relocation plan](#create-a-relocation-plan). A single relocation project can include multiple source and target regions. There's no need to plan them separately. The goal of the Initiate phase is to provide stakeholders with the information they want and get the relocation the resources it needs. Here's a framework for initiating a relocation.

:::image type="content" source="../_images/relocate/caf-relocate-initiate.png" alt-text="Image that shows the relocation process and highlights the Initiate step in the Move phase. In the relocation process, there are two phases and five steps. The first phase is the initiate phase, and it has one step called initiate. The second phase is the Move phase. It has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-initiate.png" border="false":::

## Identify objectives

The need to meet specific objectives drives relocation projects. You should capture these objectives so you can scope and prioritize your relocation efforts. The following table provides examples of relocation objectives.

|Objective |Motivation |Priority|
| --- | --- | --- |
|1. Comply with data-residency laws. | Meet all legal and ethical standards. | High|
|2. Improve application performance for users in a different region. | Meet revenue targets. |Medium|
|3. Add new services to internal productivity tools. | Increase employee productivity. |Low|

## Determine scope

With objectives in place, you can identify the workloads you need to relocate to meet those objectives. For planning and scoping, the workload should be the smallest unit of relocation. Anything smaller makes planning difficult to manage. In execution, you relocate workloads by migrating workload services and components, but for planning, focus on the workload as a whole. For more information, see [What is a workload?](/azure/cloud-adoption-framework/plan/workloads#what-is-a-workload).

## Prioritize workloads

The order you relocate workloads should reflect the priority of your objectives. Any technical dependencies, such as platforms and landing zones, should go first. Outside of technical dependencies, the order is up to you. For more information, see [Platform vs application landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-vs-application-landing-zones).

## Create a relocation plan

You should create a relocation plan that addresses service capacity and high-level project planning. At the service level, you want to verify the target region meets the capacity needs for each workload service. The rest of your relocation plan should center on the relocation project and getting stakeholder approval to proceed. Most stakeholders want to know about the schedule, team, and cost. Rather than spending time trying to estimate the schedule, resources, and cost, start the relocation process and refine the estimates as you learn more. But here are recommendations for creating an initial plan with the elements you need.

**Build a soft schedule.** The schedule depends on the complexity of the workloads being relocated and the experience of the team involved. Instead of spending time figuring out how long it will take, start relocating the first workload. The experience allows you to better estimate a completion date, and it saves you time.

**Use a multi-disciplinary team.** The relocation team needs technical, business, and legal/compliance expertise. The business stakeholders own the workload and should guide the technical team to meet the objectives. You need the legal or compliance teams if the workload is being relocated due to regulatory requirements.

**Know cost factors.** Relocation has a cost. Moving data and using services isn't free. To minimize cost, you should move data once and avoid duplicating services or environments for extended periods of time. A hidden cost you might not consider comes from suppliers, partners, or third-party technical support. You might need their help to relocate a workload, and they typically charge a fee.

## Next step

The next step is the Move phase of relocation. The Move phase has four steps: evaluate, select, migrate, and cutover. You might have one or more workloads to relocate. Regardless of number, you should work through these four steps for any workload you want to relocate.

> [!div class="nextstepaction"]
> [Evaluate](evaluate.md)
