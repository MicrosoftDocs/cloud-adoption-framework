---
title: "Build consensus on the business value of cloud innovation"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn to build consensus on the business value of cloud innovation.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/07/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Building consensus on the business value of innovation

The first step to developing any new innovation is identifying how that innovation will drive business value. This exercise asks a series of questions that highlight the importance of investing more time defining business value.

## Qualifying questions

Before developing any solution (in the cloud or on-premises), validate your business value criteria:

1. What defined customer need are we seeking to address with this solution?
2. What opportunities would this solution create for the business?
3. Which business outcomes would be achieved with this solution?
4. Which of the company's motivations would be served with this solution?

If the answers to all four questions are well documented, you may not need the rest of this exercise. Fortunately, that documentation can be easily tested. To test both the documentation and your general alignment, host a short meeting with committed business stakeholders, and a separate short meeting with the engaged development team. In both meetings, ask the four questions above and compare the results.

> [!NOTE]
> The existing documentation **should not** be shared with either team prior to the meeting. If true alignment exists, the guiding hypotheses should be referenced (or better yet, recited) by members of each group.

> [!WARNING]
> Don't facilitate the meeting. This is a test of alignment, not an alignment creation exercise. When starting the meeting, ensure the attendees are aware of the objective to test directional alignment with existing agreements within the team. Establish only a time limit. Commit to five minutes per question and set a timer for each. Close that question in five minutes, even if the answer isn't agreed upon.

If the answers are directionally aligned, but represent the different languages and interests of each group, then consider this exercise a victory. You are ready to proceed to solution development.

If one or two of the answers are directionally aligned, recognize that your hard work is paying off. You are already better aligned than most organizations. Future success is very likely, with minor continuing investment in alignment. Review each of the following sections for ideas that may help you build further alignment.

If either team fails to answer all four questions in thirty minutes, then alignment and the following efforts are likely to have a big impact on this effort and others. Pay careful attention to each of the following sections.

## Address the big picture first

The Cloud Adoption Framework follows a prescribed path through strategy, plan, ready, and adopt. Cloud innovation fits within the adopt phase of this process. When the answers to questions 3 and 4 above (outcomes and motivations) are misaligned, it indicates that something was missed during the strategy phase of the cloud adoption lifecycle. Several of the following scenarios are likely to be at play.

- **Alignment opportunity:** When business stakeholders can't agree on motivations and business outcomes related to a cloud innovation effort, it is a symptom of a larger challenge. The exercises in the [cloud strategy phase](../strategy/index.md) can be useful in developing alignment among business stakeholders. Additionally, it is highly recommended that the same stakeholders form a [cloud strategy team](../organize/cloud-strategy.md) that meets regularly.

- **Communication opportunity:** When the development team can't agree on motivations and business outcomes, it might be a symptom of strategic communication gaps. Reviewing the cloud strategy with the cloud adoption team can quickly resolve this blocker. Several weeks after the review, the team should repeat the qualifying questions exercise.

- **Prioritization opportunity:** A cloud strategy is essentially an executive-level hypothesis. The best cloud strategies are open to iteration and feedback. If both teams understand the strategy but still can't quite align answers to these questions, then priorities might be misaligned. A session with the cloud adoption team and the cloud strategy team could help the efforts of both groups. During this session, the cloud adoption team shares their aligned answers to the big picture questions. From there, a conversation between the cloud adoption team and cloud strategy team can highlight opportunities to better align priorities.

These big picture opportunities often reveal ways to better align this solution with the cloud strategy. This exercise has two common outcomes:

- These conversations can lead to improvements in the cloud strategy and better representation of this important customer need. Such a change can result in greater executive support for the team.
- Conversely, this conversation might show that investing in another solution is more appropriate for the cloud adoption team. In this case, consider migrating this solution before continuing to invest in innovation. Alternatively, it may indicate that a citizen developer approach is needed to test the business value first. In either case, it will help the team avoid making a big investment with limited business returns.

## Address solution alignment

It's fairly common for the answers to questions 1 and 2 (customer need and business opportunity) to be misaligned. This is especially common during early stages of ideation and development. Finding a balance between too much and too little definition is challenging for many development teams. In the Cloud Adoption Framework, lean approaches like build-measure-learn feedback loops are suggested as the best way to answer these questions. The following list shows opportunities and approaches to create alignment.

- **Hypothesis opportunity:** It's common for various stakeholders and development teams to have too many expectations for a solution. When this occurs, it's a sign that the hypothesis is too vague. Following the guidance on [building with customer empathy](./considerations/build.md) to construct a clearer hypothesis.
- **Build opportunity:** When teams are misaligned because they disagree on the way to solve the customer need, it typically indicates that the team is being [delayed by a premature technical spike](./considerations/build.md#reduce-complexity-and-delay-technical-spikes). To keep the team focused on the customer, start the first iteration and build a small MVP to address part of the hypothesis. For more guidance to help the team move forward, see [Developing digital inventions](./considerations/invention.md).
- **Training opportunity:** When either team is misaligned because they need deep technical requirements and extensive functional requirements, it reveals an opportunity for training in agile methodologies. When the team culture isn't ready for agile processes, it can be challenging to innovate and keep pace with the market. For training resources about DevOps and agile practices, see:
  - [Evolve your DevOps practices](https://docs.microsoft.com/learn/paths/evolve-your-devops-practices)
  - [Build applications with Azure DevOps](https://docs.microsoft.com/learn/paths/build-applications-with-azure-devops)
  - [Deploy applications with Azure DevOps](https://docs.microsoft.com/learn/paths/deploy-applications-with-azure-devops/)

Using this methodology and the backlog management tools in each section listed above can help create solution alignment.

## Next steps

Once the business value proposition is well-aligned and communicated, it's time to start building your solution. Return to the [innovate exercises](./index.md) for guidance on next steps.

> [!div class="nextstepaction"]
> [Return to the innovate exercises for next steps](./index.md)
