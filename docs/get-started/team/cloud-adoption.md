---
title: "Get started: Build a cloud adoption team"
description: Establish a cloud adoption team's scope, deliverables, and the capabilities to prepare for successful cloud adoption.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Get started: Build a cloud adoption team

Cloud adoption teams are the modern-day equivalent of technical implementation teams or project teams. The nature of the cloud might require more fluid team structures.

Some cloud adoption teams focus exclusively on cloud migration, and others focus on innovations that take advantage of cloud technologies. Some teams include the broad technical expertise that's required to complete large adoption efforts, such as a full datacenter migration, and others have a tighter technical focus.

A smaller team might move between projects to accomplish specific goals. For example, a team of data platform specialists might focus on helping convert SQL Database virtual machines (VMs) to SQL PaaS instances.

As cloud adoption expands, customers benefit from a team that's dedicated to the [cloud platform function](../../organize/cloud-platform.md). That team uses automated deployment and code reuse to accelerate successful adoption. People focused on a cloud platform function can implement infrastructure, application patterns, governance, and other supporting assets to drive further efficiencies and consistency, and to instill cloud principles in your organization. Small organizations and small adoption teams don't have the luxury of a dedicated cloud platform team. We recommend that you establish an automation capability in your adoption team to begin building this important cloud muscle.

![Get started building a cloud adoption team](../../_images/get-started/adoption-team-map.png)

## Step 1: Determine the type of adoption team you need

Cloud adoption teams tend to perform one or more of the following types of adoption:

- Migration of existing workloads
- Modernization of existing workloads and assets
- Architectural change to existing workloads and assets
- Development of new workloads

The adoption of any IT portfolio will likely require a mixture of these types of efforts. Unfortunately, each type requires different skills and mindsets. The more specialized an adoption team, the more effective and efficient the team will be when it delivers that type of work. Conversely, mastery of all the implementation options across cloud adoption can be overwhelming for these more specialized teams.

When you're first building a cloud adoption team, aligning with one of the Adopt methodologies will help accelerate the development of the team's collective skills.

**Deliverables:**

- Determine whether the team aligns better with the Migrate methodology or the Innovate methodology.
- Each methodology has a four-step onboarding experience to help the team understand the tools and processes required to get really good at that effort. Invest time as a team going through the first few steps to understand which tools and scenarios you're most likely to need in early iterations.
- Align responsibilities across teams by developing a cross-team matrix that identifies *responsible, accountable, consulted, and informed (RACI)* parties. Update your company's [RACI template](../../organize/raci-alignment.md) to help others understand who's on the team and which methodology the team will focus on delivering.

**Guidance to support deliverable completion:**

- [Migrate methodology overview](../../migrate/index.md) describes the process, tools, and approaches for migrating and modernizing a portfolio of workloads.
- [Innovate methodology overview](../../innovate/index.md) describes the process, tools, and approaches for adding cloud-native workloads to the portfolio.
- [Understand motivations](../../strategy/motivations.md) behind this effort to see whether they're better aligned with migration or innovation efforts.

## Step 2: Align your team with other supporting teams

If your company's cloud adoption effort is mature enough to have supporting teams, you might be able to find a list of the teams and subject matter experts in your company's version of the [RACI template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/organize/raci-template.xlsx), including cloud governance, cloud operations, a cloud center of excellence, or other similar teams.

**Deliverables:**

- Review design guidance, operational baselines, policies, and processes from the various supporting teams to understand the guardrails that have been established for guiding cloud adoption.
- Review the guidance with other cloud adoption teams to understand any limitations you might encounter as a result of those guardrails.

**Guidance to support deliverable completion:**

- [Evaluate corporate policy](../../govern/corporate-policy.md) outlines the steps to define corporate policy, which might limit decisions that the team can safely make in the company's cloud environment.
- [Governance disciplines](../../govern/corporate-policy.md) outlines the types of controls or disciplined processes that the governance team has likely implemented to allow for safe, compliant adoption of the cloud.
- The [Manage methodology](../../manage/index.md) outlines the considerations that go into a cloud operations baseline for providing basic operations management.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> The cloud strategy team is accountable for maintaining a clear RACI structure across the cloud adoption lifecycle. | Review guidance and requirements from: <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or central IT team <li> Other cloud adoption teams or individuals listed in the RACI |

## Step 3: Begin your adoption journey

Depending on the type of adoption team you're a member of, you'll get started with one of these guides:

- [Get started: Migrate workloads to the cloud](../migrate.md)
- [Get started: Build new products or services](../innovate.md)

These guides provide guidance for various teams listed alongside their varying degrees of accountability and responsibility. Use the guides to understand how your team fits into the rest of the journey. Also use them to understand the levels of support you can expect to get from around the company.

In the end, the cloud adoption team is accountable for delivery across their assigned migration efforts or new product development. Although supporting teams are accountable for ensuring that each step is completed, it's the responsibility of each cloud adoption team to ensure that the supporting team is getting the support it needs to be successful. If the accountable team doesn't yet exist or needs more support to deliver on its accountable steps, the adoption team is encouraged to partner with other teams to complete its deliverables.

**Deliverables:**

- Become increasingly better at delivering on the methodology associated with your adoption approach.
- Support other teams in the completion of their accountable steps, even if those steps are blockers to your adoption efforts.

**Guidance to support deliverable completion:**

- In the getting started guide for migration, the adoption team is accountable for delivery of [step 10: Migrate your first workload](../migrate.md#step-8-migrate-your-first-10-workloads).
- In the getting started guide for new products, the adoption team is accountable for delivery of [step 8: Innovate in the cloud](../innovate.md#step-8-innovate-in-the-cloud).

All other steps on those checklists are designed to make the effort more manageable.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or central IT team <li> Cloud strategy team |

## Step 4: Expand your skills with scenarios and best practices

After one or two iterations, the cloud adoption team will understand the basics of their primary methodology. From there, the team will likely be ready to take on additional scenarios and start implementing some additional best practices.

**Deliverables:**

- Increase skills and experience to address more complex adoption scenarios.

**Guidance to support deliverable completion:**

The team can review and expand their skills by reviewing the following guidance:

- Migrate new types of workloads or solve more complex migration challenges through [scenarios](../../migrate/azure-best-practices/contoso-migration-overview.md) and [best practices](../../migrate/azure-best-practices/index.md).
- Innovate by using new cloud-native solutions, or solve more complex innovation challenges through [scenarios](../../innovate/kubernetes/index.md) and [best practices](../../innovate/best-practices/index.md).

**Accountable team:**

- The cloud adoption team is accountable for expanding its skills.

## Step 5: Build a cloud adoption factory

As the team becomes more familiar with various adoption scenarios, it will be able to do more and do it faster. This section of guidance will take the team's adoption abilities to the next level.

The cloud adoption factory approach looks at the processes behind adoption efforts. Because of a lack of understanding and clear communication, most of the time burden that's related to migration and innovation comes from a high volume of meetings. Clearly defining processes and interactions at various phases of the cloud adoption journey will remove cultural and political blockers.

**Deliverables:**

- Improve delivery processes to create a highly optimized adoption factory.

**Guidance to support deliverable completion:**

- Process guidance that supports [migration efforts](../../migrate/migration-considerations/index.md) can be found in the process improvements section of the Migrate methodology.
- In the Innovate methodology, the guidance focuses on [innovation processes](../../innovate/considerations/index.md) that result in less technology and more effective product development.

**Accountable team:**

- The cloud adoption team is accountable for building the processes that take adoption to the next level.

## What's next

Cloud adoption is a great goal, but ungoverned adoption can produce unexpected results. To accelerate adoption and best practices, as you're reducing business and technical risks, align cloud adoption with [cloud governance functions](../../organize/cloud-governance.md).

Aligning with the cloud governance team creates balance across cloud adoption efforts, but this is considered a minimum viable product (MVP), because it might not be sustainable. Each team is wearing many hats, as outlined in the [RACI charts](../../organize/raci-alignment.md).

Learn more about overcoming [organizational antipatterns: silos and fiefdoms](../../organize/fiefdoms-silos.md).
