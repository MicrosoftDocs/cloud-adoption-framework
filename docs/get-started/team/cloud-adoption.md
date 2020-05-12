---
title: "Get started: Build a cloud adoption team"
description: Establish a cloud adoption team's scope, deliverables, and the capabilities to prepare for successful cloud adoption.
author: JanetCThomas
ms.author: janet
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.topic: conceptual
ms.date: 04/04/2020
---

# Get started: Build a cloud adoption team

Cloud adoption teams are the modern-day equivalent of technical implementation teams or project teams. However, the nature of the cloud might require a more fluid team structure. Some cloud adoption teams focus exclusively on cloud migration, while others focus on innovations that take advantage of cloud technologies. Some include the broad technical expertise required to complete large adoption efforts, like a full datacenter migration, while others have a tighter technical focus and might move between projects to accomplish specific goals, for example, a team of data platform specialists who help convert SQL VMs to SQL PaaS instances.

![Get started building a cloud adoption team](../../_images/get-started/adoption-team-map.png)

## Step 1: Determine the type of adoption team you need

Cloud adoption teams tend to perform one or more of the following types of adoption:

    - Migration of existing workloads.
    - Modernization or existing workloads and assets.
    - Architectural change to existing workloads and assets
    - Development of new workloads.

Adoption of any IT portfolio will likely require a mixture of these skills. Unfortunately, those different efforts require different skills and mindsets. There more specialized an adoption team is across these efforts, the more effective and efficient that team will be when delivering that type of work. Conversely, mastery of all of the implementation options across cloud adoption can be an overwhelming effort.

When first building a cloud adoption team, aligning to one of the Adopt methodologies will help accelerate development of the team's collective skills.

**Deliverables:**

- Determine which methodology the team best aligns with: the Migrate methodology or the Innovate methodology.
- Each methodology has a four-step onboarding experience to help understand the tools and processes required to get really good at that effort. Invest time as a team going through the first few steps to understand which tools and scenarios you are most likely to need in early iterations.
- Update your companies [RACI template](../../organize/raci-alignment.md) to help others understand who is on the team and which methodology the team will focus on delivering.

**Guidance to support deliverable completion:**

- [Migrate methodology overview](../../migrate/index.md) describes the process, tools, and approaches for migrating and modernizing a portfolio of workloads.
- [Innovate methodology overview](../../innovate/index.md) describes the process, tools, and approaches for adding cloud-native workloads to the portfolio.
- [Understanding motivations](../../strategy/motivations.md) behind this effort to see if they are better aligned to migration or innovation efforts.

## Step 2: Align your team to other supporting teams

If your company's cloud adoption effort is mature enough to have supporting teams, you might be able to find a list of the teams and subject matter experts in your company's version of the [RACI template](https://archcenter.blob.core.windows.net/cdn/fusion/management/raci-template.xlsx), including cloud governance, cloud operations, a cloud center of excellence, or other similar teams.

**Deliverables:**

- Review design guidance, operational baselines, policies, and processes from the various supporting teams to understand the guardrails that have been established to guide cloud adoption.
- Review guidance with other cloud adoption teams to understand any limitations you might encounter as a result of those guardrails.

**Guidance to support deliverable completion:**

- [Evaluate corporate policy](../../govern/corporate-policy.md) outlines the steps to define corporate policy, which might limit decisions which can safely be made in the company's cloud environment.
- [Governance disciplines](../../govern/corporate-policy.md) outlines the types of controls or disciplined processes which the governance team is likely to have implemented to allow for safe, compliant adoption of the cloud.
- The [Manage methodology](../../manage/index.md) outlines the considerations that goes into a cloud operations baseline to provide basic operations management.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> The cloud strategy team is accountable for maintaining a clear RACI structure across the cloud adoption lifecycle. | Review guidance and requirements from: <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or Central IT <li> Other cloud adoption teams or individuals listed in the RACI |

## Step 3: Begin your adoption journey

Depending on the type of adoption team you are a member of, you will get started with one of two journeys:

- Get started: Migrating workloads to the cloud.
- Get started: Building new products or services.

In each of those getting started guides, you will see guidance for different teams listed along with varying degrees of accountability and responsibility. Use those as reference to understand how your team fits into the rest of the journey. Also use those references to understand the levels of support you will be able to get from around the company.

In the end, the cloud adoption team will be accountable for delivery over assigned migration efforts or new product development. While supporting teams are accountable for ensuring steps get completed, it is the responsibility of each cloud adoption team to ensure they are getting the support they need to be successful. The adoption team is encouraged to partner with other teams to complete those steps, if the accountable team doesn't exist or needs more support to deliver on their accountable steps.

**Deliverables:**

- Become increasingly better at delivering on the methodology associated with your adoption approach.
- Support other teams in completion of accountable steps, when those steps are blockers to your adoption.

**Guidance to support deliverable completion:**

- In the getting started guide for migration, the adoption team is accountable for delivery of [step 10: migrate your first workload](../migrate.md#step-8-migrate-your-first-10-workloads).
- In the getting started guide for new products, the adoption team is accountable for delivery of [step 8: innovate in the cloud](../innovate.md#step-8-innovate-in-the-cloud).

All other steps on those checklists are designed to make the effort more manageable.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Ultimately, the cloud adoption team is accountable for success. | <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or Central IT <li> Cloud strategy team |

## Step 4: Expand your skills with scenarios and best practices

After one or two iterations of adoption, the team will understand the basics of their primary adoption methodology. From there, the team will likely be ready to take on additional scenarios and start implementing some additional best practices. Each of the following links provide landing pages exposing a section of the table of contents containing lists of both types of guidance for the team to review and expand their skills.

**Deliverables:**

- Increase skills and experience to address more complex adoption scenarios.

**Guidance to support deliverable completion:**

- Migrate new types of workloads or solve more complex migration challenges through [scenarios](../../migrate/azure-best-practices/contoso-migration-overview.md) and [best practices](../../migrate/azure-best-practices/index.md).
- Innovate using new cloud-native solutions or solve more complex innovation challenges through [scenarios](../../innovate/kubernetes/index.md) and [best practices](../../innovate/best-practices/index.md).

**Accountable team:**

The cloud adoption team is accountable for expanding their skills.

## Step 5: Build a cloud adoption factory

As the team becomes more familiar with various adoption scenarios, you will be able to do more faster. This section of guidance will take your ability for adoption to the next level. The cloud adoption factory approach looks at the processes behind adoption efforts. Most of the time burden related to migration and innovation comes from the high volume of meetings, due to lack of understanding and transparency. Clearly defining processes and interactions at various phases of the cloud adoption journey will remove cultural and political blockers.

**Deliverables:**

- Improve delivery processes to create a highly optimized adoption factory.

**Guidance to support deliverable completion:**

- Process guidance to support [migration efforts](../../migrate/migration-considerations/index.md) can be found in the process improvements section of the Migrate methodology.
- In the Innovate methodology, the guidance focuses on [innovation processes](../../innovate/considerations/index.md) that result in less technology and more impactful product development.

**Accountable team:**

The cloud adoption team is accountable for building the processes that take adoption to the next level.

## What's next

Adoption is great, but ungoverned adoption can produce unexpected results. Align cloud adoption with [cloud governance functions](../../organize/cloud-governance.md) to accelerates adoption and best practices, while reducing business and technical risks.

These two teams create balance across cloud adoption efforts, but this is considered an MVP because it might not be sustainable. Each team is wearing many hats, as outlined in the [_responsible, accountable, consulted, informed_ (RACI) charts](../../organize/raci-alignment.md).

Learn more about [organizational antipatterns: silos and fiefdoms](../../organize/fiefdoms-silos.md).
