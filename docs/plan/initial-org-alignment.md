---
title: Initial organization alignment
description: Use the Cloud Adoption Framework for Azure to learn how to complete your initial organization alignment and get your teams ready for cloud adoption.
author: Zimmergren
ms.author: pnp
ms.date: 03/08/2023
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2, engagement-fy23
---

# Initial organization alignment

The most important aspect of any cloud adoption plan is the alignment of people who make the plan a reality. No plan is complete until you understand its people-related aspects.

Proper organizational alignment takes time. It becomes essential to establish long-term organizational alignment, especially as cloud adoption scales across the business and IT culture. Alignment is so important that there's an entire section dedicated to it in the [Organize methodology](../organize/index.md) of the Cloud Adoption Framework.

Full organization alignment isn't a required component of the cloud adoption plan. However, some initial organizational alignment is needed. This article outlines a best-practice starting point for organizational alignment. The guidance here can help complete your plan and prepare your teams for cloud adoption. When ready, you can use the [organization alignment](../organize/index.md) section to customize this guidance to fit your organization.

## Initial best-practice structure

To create a balance between speed and control, we recommend that during cloud adoption, at a minimum, you have people accountable for *cloud adoption* and *cloud governance*. This might be a team of people sharing responsibilities for these areas or *capabilities*. It might also be individual people who are both accountable for the outcomes and responsible for the work. In either scenario, cloud adoption and cloud governance are two capabilities that involve natural friction between moving quickly and reducing risks. Here's how the two teams fit together:

![Cloud adoption with a cloud center of excellence](../_images/ready/org-ready-best-practice.png)

Cloud adoption requires people to execute the cloud adoption tasks, and therefore few people are surprised that a cloud adoption team is needed. However, those new to the cloud may not fully appreciate the importance of a cloud governance team. This challenge often occurs early in adoption cycles. The cloud governance team provides the necessary checks and balances to ensure that cloud adoption doesn't expose the business to new risks. When risks must be taken, this team ensures that proper processes and controls are implemented to mitigate or govern those risks.

One of the capabilities many newcomers to the cloud tend to overlook is the ability to drive greater velocity through *automation*. As you start your adoption projects, start building your automation muscle. Building automation frees up time, drive greater consistency, and demonstrate the model of the cloud that all parts of the business can benefit from.

Imagine a business user being able to self-serve and create cloud resources for a specific task without prior knowledge. Automation doesn't need to be overly complex at the beginning. It could be simple tasks, such as building VMs, storage accounts, or WebApps. Over time, these can evolve into more complex tasks. The Automation Function can enable this velocity by automating many repeatable tasks. See the [automation function](../organize/cloud-automation.md) in the Organize section.

For more information about cloud adoption, cloud governance, and other such capabilities, see the brief section on [understanding required cloud capabilities](../organize/index.md#understand-required-cloud-functions).

## Map people to capabilities

Assuming the suggested structure aligns with your cloud adoption plan, the next step is to map specific people to the necessary capabilities. To do so, answer the following questions:

- What person (or group of people) will be responsible for completing technical tasks in the cloud adoption plan?
- Who will be accountable for the team's ability to deliver technical changes?
- What person (or group of people) will be responsible for implementing protective governance mechanisms?
- What person is accountable for defining those governance controls?
- What person (or group of people) will be responsible for planning the sustainability and cloud efficiency?
- Are there other capabilities or people with accountability or responsibility within the cloud adoption plan?

After documenting the answers to these questions, you can establish [plans for skills readiness](./adapt-roles-skills-processes.md) to define plans to prepare these people for future work.

## Evolving your organization structure

Your cloud adoption evolves, and your organization needs to keep up. Many critical functions need to be addressed, and while they don't need to be handled by dedicated teams, you need to cover these functions and the tasks.

Thinking through your organization, you want to ensure that you have functions that are dedicated to *Strategy*. This group is responsible for driving direction and business alignment.

- *Cloud Center of Excellence* will ensure that you're addressing the cultural change, skills, and systems needed to help build your cloud competency
- *Governance* defining controls to manage risk
- *Automation* to deliver consistency through code
- *Platform* ensuring that the environment is well-maintained and secure
- *Adoption* building of workloads and applications in a well-architected manner
- *Operations* ensuring that day-to-day issues are dealt with swiftly.

Depending on the organization's size, there might be dedicated *Security* and *Data* functions. These groups handle all aspects of security across the business and define rules for managing and governing organizational data.

In the [Organize](../organize/index.md) section, we outline the functions, the cadence of meetings, the deliverables, and typical sources of skills and traditional roles that can fit the function.

### Introduce sustainability

Many organizations are evolving their organizational structure by introducing sustainability practices within the company. For example, modern Cloud Center of Excellence teams can encompass the directions for setting up the sustainability practice. Meanwhile, the governance team might define the accountabilities to ensure sustainability targets are being tracked and measured in alignment with the [organizational objectives and key results](/azure/cloud-adoption-framework/strategy/business-outcomes/okr#examples-of-okrs).

For additional considerations in defining roles, responsibilities, and standards, see [Plan for sustainability - Roles and responsibilities](plan-sustainability.md#roles-and-responsibilities).

## Next steps

Learn how to plan for cloud adoption.

> [!div class="nextstepaction"]
> [Plan for cloud adoption](./plan-intro.md)
