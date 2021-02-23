---
title: Understand cloud adoption functions
description: Understand how cloud adoption functions enable technical solutions so that you can staff your teams appropriately.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

# Cloud adoption functions

Cloud adoption functions enable the implementation of technical solutions in the cloud. Like any IT project, the people delivering the actual work will determine success. The teams providing the necessary cloud adoption functions can be staffed from multiple subject matter experts or implementation partners.

Cloud adoption teams are the modern-day equivalent of technical implementation teams or project teams. But the nature of the cloud may require a more fluid team structure. Some teams focus exclusively on cloud migration, while other teams focus on innovations that take advantage of cloud technologies. Some teams include the broad technical expertise required to complete large adoption efforts, like a full datacenter migration. Other teams have a tighter technical focus and may move between projects to accomplish specific goals. One example would be a team of data platform specialists who help convert SQL VMs to SQL PaaS instances.

Regardless of the type or number of cloud adoption teams, the functionality required for cloud adoption is provided by subject matter experts found in IT, business analysis, or implementation partners.

Depending on the desired business outcomes, the skills needed to provide full cloud adoption functions could include:

- Infrastructure implementers
- DevOps engineers
- Application developers
- Data scientists
- Data or application platform specialists

For optimal collaboration and efficiency, we recommend that cloud adoption teams have an average team size of six people. These teams should be self-organizing from a technical execution perspective. We highly recommend that these teams also include project management expertise, with deep experience in agile, Scrum, or other iterative models. This team is most effective when managed using a flat structure.

## Preparation

- [Create an Azure account](/learn/modules/create-an-azure-account/): The first step to using Azure is to create an account.
- [Azure portal](/learn/modules/tour-azure-portal/): Tour the Azure portal features and services, and customize the portal.
- [Introduction to Azure](/learn/modules/intro-to-azure-fundamentals/): Get started with Azure. Create and configure your first virtual machine in the cloud.
- [Azure fundamentals](/learn/paths/azure-for-the-data-engineer/): Learn cloud concepts, understand the benefits, compare and contrast basic strategies, and explore the breadth of services available in Azure.
- Review the [Migrate methodology](../migrate/index.md).

## Minimum scope

The nucleus of all cloud adoption efforts is the cloud migration team. This team drives the technical changes that enable adoption. Depending on the objectives of the adoption effort, this team may include a diverse range of team members who handle a broad set of technical and business tasks.

At a minimum, the team scope includes:

- [Rationalization of the digital estate](../digital-estate/index.md)
- Review, validation, and advancement of the [prioritized migration backlog](../migrate/migration-considerations/assess/release-iteration-backlog.md)
- The execution of the [first workload](../digital-estate/rationalize.md#select-the-first-workload) as a learning opportunity.

## Deliverable

The primary need from any cloud adoption function is the timely, high-quality implementation of the technical solutions outlined in the adoption plan. These solutions should align with governance requirements and business outcomes, and should take advantage of technology, tools, and automation solutions that are available to the team.

**Early planning tasks:**

- Execute the [rationalization of the digital estate](../digital-estate/index.md).
- Review, validate, and advance the [prioritized migration backlog](../migrate/migration-considerations/assess/release-iteration-backlog.md).
- Begin execution of the [first workload](../digital-estate/rationalize.md#select-the-first-workload) as a learning opportunity.

**Ongoing monthly tasks:**

- Oversee [change management processes](../migrate/migration-considerations/prerequisites/technical-complexity.md).
- Manage the [release and sprint backlogs](../migrate/migration-considerations/assess/release-iteration-backlog.md).
- Build and maintain the adoption landing zone in conjunction with governance requirements.
- Execute the technical tasks outlined in the [sprint backlogs](../migrate/migration-considerations/assess/release-iteration-backlog.md).

**Meeting cadence:**

We recommend that teams providing cloud adoption functions be dedicated to the effort full-time.

It's best if these teams meet daily in a self-organizing way. The goal of daily meetings is to quickly update the backlog, and to communicate what has been completed, what is to be done today, and what things are blocked, requiring additional external support.

Release schedules and iteration durations are unique to each company. But a range of one to four weeks per iteration seems to be the average duration. Regardless of iteration or release cadence, we recommend that the team meets all supporting teams at the end of each release to communicate the outcome of the release, and to reprioritize upcoming efforts. Likewise, it's valuable to meet as a team at the end of each sprint, with the cloud center of excellence or cloud governance team to stay aligned on common efforts and any needs for support.

Some of the technical tasks associated with cloud adoption can become repetitive. Team members should rotate every 3&ndash;6 months to avoid employee satisfaction issues and maintain relevant skills. A rotating seat on a cloud center of excellence or cloud governance team can provide an excellent opportunity to keep employees fresh and harness new innovations.

Learn more about the function of a [cloud center of excellence](./cloud-center-of-excellence.md) or [cloud governance team](./cloud-governance.md).

## Next steps

- [Build a cloud adoption team](../get-started/team/cloud-adoption.md)
- Align cloud adoption efforts with [cloud governance functions](./cloud-governance.md) to accelerate adoption and implement best practices, while reducing business and technical risks.
