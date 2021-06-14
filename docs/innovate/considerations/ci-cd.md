---
title: CI/CD pipeline with digital invention
description: Use the maturity model of the Innovate methodology to reduce friction that slows adoption in the CI/CD pipeline, while keeping best practices in place.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: internal, seo-caf-innovate
keywords: continuous integration, continuous deployment, ci cd, digital invention, ci cd pipeline
---

# Empower adoption with digital invention

The ultimate test of innovation is customer reaction to your invention. Did the hypothesis prove true? Do customers use the solution? Does it scale to meet the needs of the desired percentage of users? Most importantly, do they keep coming back? None of these questions can be asked until the minimum viable product (MVP) solution has been deployed.

In this article, we'll focus on empowering adoption with continuous integration and continuous deployment (CI/CD) pipeline tools. Continuous integration is the automating of code multiple times per day in order to have an updated single project. Continuous deployment is the automatic delivery of those functions throughout the day.

## Reduce CI/CD friction that affects adoption

Some obstacles to adoption can be minimized through a combination of technology and processes. For readers with knowledge of CI/CD or DevOps processes, the following CI/CD pipeline processes will be familiar. This article establishes a starting point for cloud adoption teams that fuels innovation and feedback loops. This starting point might foster more robust CI/CD or DevOps approaches as the products and teams mature.

As described in [Measure for customer impact](./measure.md), positive validation of any hypothesis requires iteration and determination. This CI/CD article aims to minimize [technical spikes](./build.md#reduce-complexity-and-delay-technical-spikes) that slow innovation, while making sure you keep best practices in place. Doing so will help the team design for future success while delivering on current customer needs.

## Empower adoption and digital invention: The maturity model

The primary goal of the [Innovate methodology](./index.md) is to build customer partnerships and accelerate feedback loops, which lead to market innovations. The following image and sections describe initial implementations that support this methodology.

![Diagram that shows the empower adoption maturity model.](../../_images/innovate/empower-adoption-maturity.png)

- [Shared solution](#shared-solution): Establish a centralized repository for all aspects of the solution.
- [Feedback loops](#feedback-loops): Make sure that feedback loops can be managed consistently through iterations.
- [Continuous integration](#continuous-integration): Regularly build and consolidate the solution.
- [Reliable testing](#reliable-testing): Validate solution quality and expected changes to ensure the reliability of your testing metrics.
- [Solution deployment](#solution-deployment): Deploy solutions so that the team can quickly share changes with customers.
- [Integrated measurement](#integrated-measurements): Add learning metrics to the feedback loop for clear analysis by the full team.

To minimize technical spikes, assume that maturity will initially be low across each of these principles. Plan ahead by aligning to tools and processes that can scale as hypotheses become more fine-grained. In Azure, [GitHub](https://guides.github.com) and [Azure DevOps](/azure/devops/) allow small teams to get started with little friction. These teams might grow to include thousands of developers who collaborate on scale solutions and test hundreds of customer hypotheses. The rest of this article illustrates the "plan big, start small" approach to empowering adoption across each of these principles.

## Shared solution

As described in [Measure for customer impact](./measure.md), positive validation of any hypothesis requires iteration and determination. You'll experience far more failures than wins during any innovation cycle. This is expected. However, when a customer need, hypothesis, and solution align at scale, the world changes quickly.

When you're scaling digital invention and innovation, there's no more valuable tool than a shared code base for the solution. Unfortunately, there's no reliable way of predicting which iteration or which MVP will yield the winning combination. That's why it's never too early to establish a shared code base or repository. This is the one [technical spike](./build.md#reduce-complexity-and-delay-technical-spikes) that shouldn't be delayed. As the team iterates through various MVP solutions, a shared repo enables easy collaboration and accelerated development. When changes to the solution drag down learning metrics, version control lets you roll back to an earlier, more effective version of the solution.

The most widely adopted CI/CD tool for managing code repositories is [GitHub](https://guides.github.com), which lets you create a shared code repository in just a few steps. Additionally, the [Azure Repos](/azure/devops/repos/get-started/what-is-repos) feature of Azure DevOps can be used to create a [Git](/azure/devops/repos/get-started/what-is-repos#git) or [TFVC](/azure/devops/repos/get-started/what-is-repos#tfvc) repository.

## Feedback loops

Making the customer part of the solution is the key to building customer partnerships during innovation cycles. That's accomplished, in part, by [measuring customer impact](./measure.md). It requires conversations and direct testing with the customer. Both generate feedback that must be managed effectively.

Every point of feedback is a potential solution to the customer need. More importantly, every bit of direct customer feedback represents an opportunity to improve the partnership. If feedback makes it into an MVP solution, celebrate that with the customer. Even if some feedback isn't actionable, simply being transparent with the decision to deprioritize the feedback demonstrates a [growth mindset](./learn.md#growth-mindset) and a focus on [continuous learning](./learn.md#continuous-learning).

[Azure DevOps](/azure/devops/) includes ways to [request, provide, and manage feedback](/azure/devops/project/feedback/). Each of these tools centralizes feedback so that the team can take action and provide follow-up in service of a transparent feedback loop.

## Continuous integration

Continuous integration is the automating of code multiple times per day to have an updated single project. As adoptions scale and a hypothesis gets closer to true innovation at scale, the number of smaller hypotheses to be tested tends to grow rapidly. For accurate feedback loops and smooth adoption processes, it's important that each of those hypotheses is integrated and supportive of the primary hypothesis behind the innovation. This requires you to move quickly to innovate and grow, which requires multiple developers for testing variations of the core hypothesis. For later stage development efforts, you might even need multiple teams of developers, each building toward a shared solution. Continuous integration is the first step toward management of all the moving parts.

In continuous integration, code changes are frequently merged into the main branch. Automated build and test processes make sure that code in the main branch is always production quality. This ensures that developers are working together to develop shared solutions that provide accurate and reliable feedback loops.

Azure DevOps and [Azure Pipelines](/azure/devops/pipelines/) provide continuous integration capabilities with just a few steps in GitHub or other repositories. For more information, see [What is continuous integration?](/devops/develop/what-is-continuous-integration) or try the [continuous integration hands-on lab](https://www.azuredevopslabs.com/labs/azuredevops/continuousintegration/). Solution architectures are available that can accelerate creation of your [CI/CD pipelines via Azure DevOps](https://azure.microsoft.com/solutions/devops/).

## Reliable testing

Defects in any solution can create false positives or false negatives. Unexpected errors can easily lead to misinterpretation of user adoption metrics. They can also generate negative feedback from customers that doesn't accurately represent the test of your hypothesis.

During early iterations of an MVP solution, defects are expected. Early adopters might even find them endearing. In early releases, acceptance testing is typically nonexistent. However, one aspect of building with empathy concerns the validation of the need and hypothesis. Both can be completed through unit tests at a code level and manual acceptance tests before deployment. Together, these provide some means of reliability in testing. You should try to automate a well-defined series of build, unit, and acceptance tests. These will ensure reliable metrics related to finer tweaks to the hypothesis and the resulting solution.

The [Azure Test Plans](/azure/devops/test/track-test-status) feature provides tooling to develop and operate test plans during manual or automated test execution.

## Solution deployment

Perhaps the most meaningful aspect of empowering adoption is your ability to control the release of a solution to customers. By providing a self-service or automated pipeline for releasing a solution to customers, you'll accelerate the feedback loop. By allowing customers to quickly interact with changes in the solution, you invite them into the process. This approach also triggers quicker testing of hypotheses, reducing assumptions and potential rework.

There are several methods for solution deployment. The three most common are:

- **Continuous deployment** is the most advanced method, as it automatically deploys code changes into production. For mature teams that are testing mature hypotheses, continuous deployment can be extremely valuable.
- During early stages of development, **continuous delivery** might be more appropriate. In continuous delivery, any code changes are automatically deployed to a production-like environment. Developers, business decision-makers, and others on the team can use this environment to verify that their work is production-ready. You can also use this method to test a hypothesis with customers without affecting ongoing business activities.
- **Manual deployment** is the least sophisticated approach to release management. As the name suggests, someone on the team manually deploys the most recent code changes. This approach is error prone, unreliable, and considered an antipattern by most seasoned engineers.

During the first iteration of an MVP solution, manual deployment is common, despite the preceding assessment. When the solution is extremely fluid and customer feedback is unknown, there's a significant risk in resetting the entire solution (or even the core hypothesis). Here's the general rule for manual deployment: no customer proof, no deployment automation.

Investing early can lead to lost time. More importantly, it can create dependencies on the release pipeline that make the team more resistant to an early pivot. After the first few iterations or when customer feedback suggests potential success, a more advanced model of deployment should be quickly adopted.

At any stage of hypothesis validation, Azure DevOps and [Azure Pipelines](/azure/devops/pipelines/) provide continuous delivery and continuous deployment capabilities. Learn more about [continuous delivery](/devops/deliver/what-is-continuous-delivery), or check out the [hands-on lab](https://www.azuredevopslabs.com/labs/azuredevops/continuousdeployment/). Solution architecture can also accelerate creation of your [CI/CD pipelines through Azure DevOps](https://azure.microsoft.com/solutions/devops/).

## Integrated measurements

When you [measure for customer impact](./measure.md), it's important to understand how customers react to changes in the solution. This data, known as *telemetry*, provides insights into the actions a user (or cohort of users) took when working with the solution. From this data, it's easy to get a quantitative validation of the hypothesis. Those metrics can then be used to adjust the solution and generate more fine-grained hypotheses. Those subtler changes help mature the initial solution in later iterations, ultimately driving to repeat adoption at scale.

In Azure, [Azure Monitor](/azure/azure-monitor/overview) provides the tools and interface to collect and review data from customer experiences. You can apply those observations and insights to refine the backlog by using [Azure Boards](/azure/devops/boards/).

## Next steps

After you've gained an understanding of the CI/CD pipeline tools and processes needed to empower adoption, it's time to examine a more advanced innovation discipline: [interact with devices](./devices.md). This discipline can help reduce the barriers between physical and digital experiences, making your solution even easier to adopt.

> [!div class="nextstepaction"]
> [Interact with devices](./devices.md)
