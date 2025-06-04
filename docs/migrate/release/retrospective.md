---
title: Build a growth mindset with retrospectives
description: Learn how retrospectives help build a growth mindset and empower teams to create sustainable growth.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
---

# Build a growth mindset with retrospectives

Retrospectives reinforce the principles of a growth mindset: experimentation, testing, learning, sharing, growing, and empowering. They also provide a safe place for team members to share the challenges they faced in the current project and empower the team to create sustainable growth.

## Retrospective structure

During retrospective meetings for the migration project, each member of the team is expected to share their thoughts regarding three basic questions:

- What went well?
- What could have been better?
- What did we learn?

## Lessons learned

The retrospective marks the end of a release or iteration. As the team gains experience and learns lessons, they adjust the release and iteration backlog to reflect new processes and experiments to test. This begins the next iteration through the migration processes.

Teams that manage the next migration wave should apply the lessons they've learned to continually improve the migration.

## Conduct a retrospective

You need a few things to get started with your migration retrospective:

- **An organizer**: A team member to act as an organizer or coach throughout the process. This team member focuses on guiding the team through the retrospective process and ensures that all ideas are heard and captured.
- **A method to track and organize**: A method to track and organize ideas in a visual way. This can be a physical whiteboard with sticky notes, a virtual whiteboard, or a DevOps tool.
- **Scoped questions**: You want to organize your tracking system with three questions:
  - What went well?
  - What could have been better?
  - What did we learn?

After you complete the preceding steps, do the following steps with your team:

- **Individual answers**: Have each team member answer the question "_What went well?_" and document their answers.
  - If using a physical board, let each team member fill in their answers on the board.
  - If using a digital board, let each member fill in their answers via the tool.
- **Organizer read-out**: After each team member documents their thoughts, the organizer should review the feedback and then read it aloud to the team.
  - You should group together similar ideas as you discover them so that you recognize reoccurring trends.
  - Create labels or *parent* items as needed to help organize these thoughts.
  - If you find misplaced items that belong in another area, move them over at this time.

- Repeat this process for "_What could have been better?_"
  - During this process, encourage people to discuss their specific challenges with people, process, and technology. This should be an open space.
  - Try to determine what created delays with migrations, affected the release, or lead to workloads being pushed out of this sprint.
  - Think about how you can prevent these problems as you discuss the question "What did we learn?".

After you capture and group ideas from these questions, ask the team, "_What did we learn?_". Then brainstorm ideas for improvement that you can apply to the next sprint.

### Example retrospective output

Consider the following example retrospective output:

|What went well?|What could have been better?|What did we learn?|
|---|---|---|
|Communication with the business users for Application X and Application Y. (5 votes)|Involvement of developers to validate the network architecture for Application X and Application Z. (3 votes)|We need to review all firewall traffic from workloads before migration, even if we believe that they have no specialty rules. (4 votes)|
|Development teams for Application Y were highly involved. (2 votes)|Understanding the networking requirements for Application X. (2 votes)|We need to make sure development teams know what's expected from them as part of the migration process. (4 votes)|
|Enablement of Azure Backup as part of migration process.|Understanding the networking requirements for Application Y. (1 vote)|We need to plan extra time for large SQL databases. (3 votes)|

## Next step

You should continue to implement the Cloud Adoption Framework for Azure's Manage methodology to ensure that you can continuously maintain and optimize your workloads in Azure.

> [!div class="nextstepaction"]
> [Cloud Adoption Framework - Manage methodology](../../manage/index.md)
