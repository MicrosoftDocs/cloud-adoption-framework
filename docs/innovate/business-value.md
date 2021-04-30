---
title: Build business value through innovation
description: Use the Cloud Adoption Framework for Azure to learn about business value, and how to build consensus around the definition of business value across stakeholders.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: internal, seo-caf-innovate
keywords: business value, business value definition, what is business value, business values, business innovation
---

# Build consensus on the business value of innovation

The first step to developing any new innovation is to identify how that innovation can drive business value. In this exercise, you answer a series of questions that highlight the importance of investing ample time when your organization defines business value.

## What is business value?

Business value is an informal term that might vary from business to business. It's the net benefit realized by the customer and includes all forms of value, which determines the health and well-being of the company in the long run.

## Qualifying questions to determine business value

Before you develop any business innovation or business value solution (in the cloud or on-premises), validate your business value criteria by answering the following questions:

1. What is the defined customer need that you want to address with this solution?
2. What opportunities would this solution create for your business?
3. Which business outcomes are achieved with this solution?
4. Which of your company's motivations are served with this solution?

If the answers to all four questions are well documented, you might not need to complete the rest of this exercise. Fortunately, you can easily test any documentation. Set up two short meetings to test both the documentation and your organization's internal alignment. Invite committed business stakeholders to one meeting and set up a separate meeting with the engaged development team. Ask the four questions above to each group, and then compare the results.

> [!NOTE]
> The existing documentation **should not** be shared with either team before the meeting. If true alignment exists, the guiding hypotheses should be referenced or even recited by members of each group.

<!-- -->

> [!WARNING]
> Don't facilitate the meeting. This test is to determine alignment; it's not an alignment creation exercise. When you start the meeting, remind the attendees that the objective is to test directional alignment to existing agreements within the team. Establish a five-minute time limit for each question. Set a timer and close each question after five minutes even if the attendees haven't agreed upon an answer.

Account for the different languages and interests of each group. If the test results in answers that are directionally aligned, consider this exercise a victory. You're ready to move on to solution development.

If one or two of the answers are directionally aligned, recognize that your hard work is paying off. You're already better aligned than most organizations. Future success is likely with minor continuing investment in alignment. Review each of the following sections for ideas that might help you build further alignment.

If either team fails to answer all four questions in 30 minutes, then alignment and the considerations in the following sections are likely to have a significant impact on this effort and others. Pay careful attention to each of the following sections.

<!-- docutune:casing "Strategy, Plan, Ready, and Adopt" -->

## Address the big picture first

The Cloud Adoption Framework follows a prescribed path through four phases: strategizing, planning, readiness, and adoption. Cloud and business innovation fits within the adoption phase of this process. The answers to [qualifying questions](#qualifying-questions-to-determine-business-value) three and four concern outcomes and motivations. When these answers are misaligned, it indicates that your organization missed something during the strategizing phase of the cloud adoption lifecycle. Several of the following scenarios are likely to be at play.

- **Alignment opportunity:** When business stakeholders can't agree on motivations and business outcomes related to a cloud and business innovation effort, it's a symptom of a larger challenge. The exercises in the [Strategy methodology](../strategy/index.md) can be useful in developing alignment among business stakeholders. Additionally, it's highly recommended that the same stakeholders form a [cloud strategy team](../organize/cloud-strategy.md) that meets regularly.

- **Communication opportunity:** When the development team can't agree on motivations and business outcomes, it might be a symptom of strategic communication gaps. You can quickly resolve this issue by reviewing the cloud strategy with the cloud adoption team. Several weeks after the review, the team should repeat the qualifying questions exercise.

- **Prioritization opportunity:** A cloud strategy is essentially an executive-level hypothesis. The best cloud strategies are open to iteration and feedback. If both teams understand the strategy, but still can't align answers to these questions, then priorities might be misaligned. Organize a session with the cloud adoption team and the cloud strategy team. This session can help the efforts of both groups. The cloud adoption team starts by sharing their aligned answers to the qualifying questions. From there, a conversation between the cloud adoption team and cloud strategy team can highlight opportunities to better align priorities.

These big picture opportunities often reveal ways to better align the innovative solution with the cloud strategy. This exercise has two common outcomes:

- These conversations can help your team improve your organization's cloud strategy and better represent important customer needs. Such a change can result in greater executive support for your team.
- Conversely, these conversations might show that your cloud adoption team should invest in a different solution. In this case, consider migrating this solution before continuing to invest in innovation. Alternately, these conversations might indicate that you adopt a citizen developer approach to test the business value first. In either case, they will help your team avoid making a large investment with limited business returns.

## Address solution alignment

It's fairly common for the answers to questions one and two to be misaligned. During the early stages of ideation and development, customer need and business opportunity often get out of alignment. Many development teams find it challenging to achieve a balance between too much and too little definition. The Cloud Adoption Framework recommends lean approaches like build-measure-learn feedback loops to answer these questions. The following list shows opportunities and approaches to create alignment.

- **Hypothesis opportunity:** It's common for various stakeholders and development teams to have too many expectations for a solution. Unrealistic expectations can be a sign that the hypothesis is too vague. Follow the guidance on [building with customer empathy](./considerations/build.md) to construct a clearer hypothesis.
- **Build opportunity:** Teams might be misaligned because they disagree on the way to solve the customer need. Such disagreement typically indicates that the team is being [delayed by a premature technical spike](./considerations/build.md#reduce-complexity-and-delay-technical-spikes). To keep the team focused on the customer, start the first iteration and build a small minimum viable product (MVP) to address part of the hypothesis. For more information, see [Develop digital inventions](./considerations/invention.md).
- **Training opportunity:** Either team can be misaligned because they need deep technical requirements and extensive functional requirements. This need can lead to an opportunity for training in agile methodologies. When the team culture isn't ready for agile processes, you might find innovation and keeping pace with the market to be a challenge. For training resources about DevOps and agile practices, see:
  - [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices/)
  - [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops/)
  - [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops/)

By following the Innovate methodology and the backlog management tools in each section of this article, you can help create solution alignment.

## Next steps

After you've aligned your business value proposition and communicated it, you're ready to start building your solution.

> [!div class="nextstepaction"]
> [Return to the innovate exercises for next steps](./index.md)
