---
title: "Cloud innovation: Empower adoption"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Introduction to Cloud innovation - Empower adoption
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Empower adoption

The ultimate test of innovation is customer reaction to your invention. Did the hypothesis prove true? Do customers use the solution? Does it scale to meet the needs of the desired percentage of users? Most importantly, do they keep coming back? None of these questions can be asked until the MVP solution has been deployed. In this article, we will focus on the discipline of empowering adoption.

## Reducing friction to adoption

There are a few key friction points to adoption that can be minimized through a combination of technology and processes. For readers familiar with CI/CD or DevOps processes, the following will seem very similar. The focus of this article is to establish a starting point for cloud adoption teams, which will fuel innovation and feedback loops. Longer term, this starting point could grow into more robust CI/CD or DevOps approaches as the products and teams mature.

A described in [measuring customer impact](./measure.md), positive validation of any hypothesis requires iteration and determination. You will have way more failures than wins during any innovation cycle. This is expected. However, when customer need, hypothesis, and solution align at scale, the world changes quickly. This article aims to minimize [technical spike](./build.md#reduce-complexity-and-delay-technical-spikes) which would slow innovation, but ensure a few solid best practices are in place. Doing so will help the team design for future success, but deliver on current customer needs.

## Empowering adoption - maturity model

The primary objective of the [innovate methodology](./index.md) is to build customer partnerships and accelerate feedback loops, which will lead to market innovations.
The following image and sections of content describe initial implementations which will support the methodology.

![Empower adoption - maturity model](../../_images/innovate/empower-adoption-maturity.png)

- [Shared solution](#shared-solution): Establish a centralized repository for all aspects of the solution.
- [Feedback loops](#feedback-loops): Ensure feedback loops can be managed consistently through iterations.
- [Continuous integration](#continuous-integration): Regularly build and consolidate the solution.
- [Reliable testing](#reliable-testing): Validate solution quality and expected changes to drive ensure measures.
- [Solution deployment](#solution-deployment): Deployment of a solution to allow the team to quickly share changes with customers.
- [Integrated measurement](#integrated-measurements): Add learning metrics to the feedback loop for clear analysis by the full team.

Too minimize technical spikes, assume maturity will initially be low across each of these principles. But, plan ahead by aligning to tools and processes that can scale as hypotheses become more fine-grained. In Azure, the combination of [GitHub](https://guides.github.com) and [Azure DevOps](https://docs.microsoft.com/azure/devops) allows small teams to get started with little friction. Then grow to thousands of developers collaborating on scale solutions which test hundreds of customer-hypotheses. The remainder of this article will illustrate the plan big, start small approach to empowering adoption across each of these principles.

## Shared solution

A described in [measuring customer impact](./measure.md), positive validation of any hypothesis requires iteration and determination. You will have way more failures than wins during any innovation cycle. This is expected. However, when customer need, hypothesis, and solution align at scale, the world changes quickly.

When scaling innovation, there is no more valuable tool than a shared codebase for the solution. Sadly, there is no way of predicting which iteration or which MVP will yield the winning combination. That's why it's never too early to establish a shared codebase or repository. This is the one [technical spike](./build.md#reduce-complexity-and-delay-technical-spikes) that should never be delayed. As the team iterates through various MVP solutions, a shared repo will allow for ease of collaboration and accelerated development. When changes to the solution result in a negative impact on learning metrics, version control can allow for a rollback to the previous, more effective version of the solution.

The most common tool for managing code repositories is [GitHub](https://guides.github.com) which allows for the creation of a shared code repository with a few clicks. Additionally, the [Azure Repos](https://docs.microsoft.com/azure/devops/repos/get-started/what-is-repos?view=azure-devops) feature of Azure DevOps can be used to create a [Git](https://docs.microsoft.com/azure/devops/repos/get-started/what-is-repos?view=azure-devops#git) or [Team Foundation](https://docs.microsoft.com/azure/devops/repos/get-started/what-is-repos?view=azure-devops#tfvc) repository.

## Feedback loops

The key to building customer partnerships during innovation cycles is to make the customer a part of the solution. That is done at an arms length through [measuring customer impact](./measure.md). More closely, it requires conversations and direct testing with the customer. Both result in feedback that must be managed.

Every point of feedback is a potential solution to the customer need. More importantly, every bit of feedback directly from a customer is an opportunity to improve the partnership. If feedback makes it into an MVP solution, celebrate it with the customer. Even if the feedback isn't actionable, simply being transparent with the decision to deprioritize the feedback, demonstrates a [growth mindset](./learn.md#growth-mindset) and a focus on [continuous learning](./learn.md#continuous-learning).

[Azure DevOps](https://docs.microsoft.com/azure/devops) includes ways to [request, provide, and manage feedback](https://docs.microsoft.com/azure/devops/project/feedback). Each of these tools centralize feedback so the team can take action and report on feedback, providing a transparent feedback loop.

## Continuous integration

As adoptions scale and a hypothesis grows closer to true innovation at scale, the number of smaller hypotheses to be tested will grow rapidly. For accurate feedback loops and smooth adoption processes, it is important that each of those hypotheses are integrated and supportive of the primary hypothesis behind the innovation. Unfortunately, you also have to move quickly to innovate and grow, which will require multiple developers testing variants of the core hypothesis. For later stage development efforts, it may require multiple teams of developers each building toward a shared solution. Continuous integration is the first step toward management of the various moving parts.

In continuous integration, code changes are frequently merged into the main branch. Automated build and test processes ensure that code in the main branch is always production-quality. This ensures developers are working together to develop shared solutions that provide accurate and reliable feedback loops.

Azure DevOps and [Azure Pipelines](https://docs.microsoft.com/azure/devops/pipelines) provides continuous integration capabilities with a few clicks, for GitHub or a variety of other repositories.
Learn more about [Continuous Integration](https://docs.microsoft.com/azure/devops/learn/what-is-continuous-integration) or run through the [hands-on lab](https://www.azuredevopslabs.com/labs/azuredevops/continuousintegration) for more information. There are also solution architectures to accelerate creation of your [CI/CD pipelines using Azure DevOps](https://azure.microsoft.com/solutions/devops).

## Reliable testing

Defects in any solution can create false positives or false negatives. Unexpected errors can easily lead to misinterpretation of user adoption metrics. It can also lead to negative feedback from customers that doesn't properly represent the test of your hypothesis.

During early iterations of an MVP solution, defects are expected, early adopters can even find them endearing. In early releases, acceptance testing will likely be nonexistent. However, one aspect of building with empathy is the validation of the need and hypothesis. Both can be completed through unit tests at a code level and manual acceptance tests prior to deployment. Together, these will provide some means of reliability in testing. Longer term a well defined series of build, unit, and acceptance tests should be automated to ensure reliable metrics related to more fine grain tweaks to the hypothesis and resulting solution.

[Azure Test Plans](https://docs.microsoft.com/azure/devops/test/track-test-status?view=azure-devops) provides tooling to develop and operate test plans during manual or automated test execution.

## Solution deployment

Perhaps the most meaningful aspect of empowering adoption is the ability to control the release of a solution to customers. Providing a self-service or automated pipeline for releasing a solution to customers accelerates the feedback loop. Allowing customers to interact with changes in the solution quickly, invites the customer into the process. It also allows for quicker tests of hypotheses, reducing assumptions and potential rework.

The are several approaches to solution deployment, the following outline the 3 most common approaches:

- The most advanced approach, **continuous deployment**, automatically deploys code changes into production. For mature teams testing mature hypotheses, continuous deployment can be extremely valuable.
- During early stages of development, **continuous delivery** may be more appropriate. In continuous delivery, any code changes are automatically deployed to a production-like environment. Developers, business decision makers, and others on the team may use this environment to validate that their work is production-ready. It can also be used to test a hypothesis with customers, without affecting ongoing business activities.
- **Manual deployment** is the least advanced approach to release management. As the name suggests, someone on the team would manually deploy the most recent code changes. This approach is error prone, unreliable, and considered an antipattern by most seasoned engineers.

During the first iteration of an MVP solution, manual deployment is a common approach, in spite of the description above. When the solution is extremely fluid and customer feedback is unknown, there is a significant risk resetting the entire solution (or even the core hypothesis). The general rule for manual deployment: No customer proof, no deployment automation. Investing early can lead to lost time. More importantly, it can create dependencies on the release pipeline that would make the team more resistant to an early pivot. After the first few iterations or when customer feedback suggests potential success, a more advanced model of deployment should be quickly adopted.

At any stage of hypothesis validation, Azure DevOps and [Azure Pipelines](https://docs.microsoft.com/azure/devops/pipelines) provides continuous delivery and continuous deployment capabilities with just a few clicks. Learn more about [Continuous Delivery](https://docs.microsoft.com/azure/devops/learn/what-is-continuous-delivery) or run through the [hands-on lab](https://www.azuredevopslabs.com/labs/azuredevops/continuousdeployment) for more information. Solution architectures can also accelerate creation of your [CI/CD pipelines using Azure DevOps](https://azure.microsoft.com/solutions/devops).

## Integrated measurements

When [measuring for customer impact](./measure.md), it is important to understand how customers react to changes in the solution. This data, referred to as telemetry, provides insights into the actions a use (or cohort of users) took when using the solution. From this data, it's easy to get a quantitative validation of the hypothesis. Those metrics can then be used to adjust the solution and generate more fine-grained hypotheses. Those subtler changes help mature the initial solution in subsequent iterations, ultimately driving to repeat adoption at scale.

In Azure, [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview) provides the tools and interface to collect and review the data from customer experiences. Those observations and insights can be used to refine the backlog using [Azure Boards](https://docs.microsoft.com/azure/devops/boards).

## Next steps

With an understanding of the tools and processes needed to empower adoption, it's time to examine a more advanced innovation discipline, [interact with devices](./devices.md). Which can help reduce the barriers between physical and digital experiences, making your solution even easier to adopt.

> [!div class="nextstepaction"]
> [Interact with devices](./devices.md)
