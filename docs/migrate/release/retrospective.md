---
title: Build a growth mindset with retrospectives
description: Learn how retrospectives help build a growth mindset and empower teams to create sustainable growth.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/21/2024
ms.topic: conceptual
---

# How do retrospective help build a growth mindset?

Retrospectives reinforce the principles of a growth mindset: experimentation, testing, learning, sharing, growing, and empowering. They provide a safe place for team members to share the challenges faced in the current project. Retrospectives empower the team to create sustainable growth.

## Retrospective structure

During retrospective meetings for the migration project, each member of the team is expected to contribute a thought regarding three basic questions:

- What went well?
- What could have been better?
- What did we learn?

## Lessons learned

The retrospective marks the end of a release or iteration, as teams gain experience and learn lessons, and they adjust the release and iteration backlog to reflect new processes and experiments to be tested. This starts the next iteration through the migration processes.

Teams migrating the next migration wave should apply the lessons learned to continually improve the migration.

## How to conduct a retrospective

To get started with your migration retrospective, you'll need a few things:

- **An organizer**: A team member to act as an organizer or coach through the process. This team member is going to be focused on guiding through the process below and making sure that ideas are heard and captured.
- **Track and organize**: A way to track and organize ideas in a visual way. This can be a physical whiteboard with sticky notes, a virtual whiteboard, or a DevOps tool.
- **Scoped questions**: You'll want to organize your tracking mechanism with three questions:
  - What went well?
  - What could have been better?
  - What did we learn?

Once you have secured these, gather the team and perform the following:

- **Individual answers**: Have each team member answer the question "_What went well?_" and document the answers.
  - If using a physical board, let each member place their answers on the board.
  - If using a digital board, let each member place their answers via the tool.
- **Organizer read-out**: Once each team member has captured their thoughts, the organizer should go through and begin reading them through for the team.
  - As similar thoughts are found, they should be grouped together so that reoccurring trends are able to be noticed.
  - Create labels or "parent" items as needed to help organize these thoughts.
  - If you find items that belong in another area, move them over at this time.

- Repeat this process for "_What could have been better?_"
  - Through this process, encourage people to discuss specific challenges with people, process, and technology. This should be an open space.
  - Try to target things that created delays with migrations, things that impacted release, or anything that lead to workloads being pushed out of this sprint.
  - Think about how they could have been prevented as you discussed, as part of the "What did we learn?" topic.

Once you have ideas captured and grouped for all of these topics, have the team come up with targeting ideas for improvement in the "_What did we learn?_" container that can be applied to the next sprint.

### Example retrospective output

The following is an example retrospective output:

|What went well?|What could have been better?|What did we learn?|
|---|---|---|
|Communication with the business users for Application X and Application Y (5 votes)|Involvement of developers to validate network architecture for Application X and Application Z (3 votes)|We need to review all firewall traffic from workloads before migration, even if it's believed they have no specialty rules (4 votes)|
|Development teams for Application Y were highly involved (2 votes)|Understanding of the networking requirements for Application X (2 votes)|We need to make sure development teams know what is expected from them as part of the migration process (4 votes)|
|Enablement of Azure Backup as part of migration process.|Understanding of the networking requirements for Application Y (1 vote)|We need to plan extra time for SQL database that are large size (3 votes)|
| |Final SQL replication for Application Y took longer than expected (3 votes)| |

## Next steps

You should continue with the Cloud Adoption Framework's Manage methodology to ensure that you're able to maintain and optimize your workloads in Azure continuously.

> [!div class="nextstepaction"]
> [Cloud Adoption Framework - Manage methodology](../../manage/index.md)
