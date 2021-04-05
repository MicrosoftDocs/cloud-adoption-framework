---
title: Engage via applications for digital invention
description: Understand how to create application solutions to shape data and create experiences that engage customers and support innovation.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: internal
---

# Engage via applications

As discussed in [Democratize data](./data.md), data is the new oil. It fuels most innovations across the digital economy. Building on that analogy, applications are the fueling stations and infrastructure required to get that fuel into the right hands.

In some cases, data alone is enough to drive change and meet customer needs. More commonly though, solutions to customer needs require applications to shape the data and create an experience. Applications are the way we engage the user and the home for the processes required to respond to customer triggers. Applications are how customers provide data and receive guidance. This article summarizes several principles that can help align you with the right application solution, based on the hypotheses to be validated.

![Engage via applications](../../_images/innovate/engage-via-apps.png)

## Shared code

Teams that more quickly and accurately respond to customer feedback, market changes, and opportunities to innovate typically lead their respective markets in innovation. The first principle of innovative applications is summed up in the [growth mindset overview](./learn.md#growth-mindset): "Share the code." Over time, innovation emerges from a cultural focus. To sustain innovation, diverse perspectives and contributions are required.

To be ready for innovation, all application development should start with a shared code repository. The most widely adopted tool for managing code repositories is [GitHub](https://guides.github.com), which allows you to create a shared code repository quickly. Alternatively, [Azure Repos](/azure/devops/repos/get-started/what-is-repos) is a set of version control tools in Azure DevOps Services that you can use to manage your code. Azure Repos provides two types of version control:

- [Git](/azure/devops/repos/get-started/what-is-repos#git): Distributed version control.
- [Team Foundation Version Control (TFVC)](/azure/devops/repos/get-started/what-is-repos#tfvc): Centralized version control.

## Citizen developers

Professional developers are a vital component of innovation. When a hypothesis proves accurate at scale, professional developers are required to stabilize and prepare the solution for scale. Most of the principles referenced in this article require support from professional developers. Unfortunately, current trends suggest there's a greater demand for professional developers than there are developers. Moreover, the cost and pace of innovation can be less favorable when professional development is deemed necessary. In response to these challenges, citizen developers provide a way to scale development efforts and accelerate early hypothesis testing.

The use of citizen developers is viable and effective when early hypotheses can be validated through tools like [Power Apps](/powerapps/powerapps-overview) for application interfaces, [AI Builder](/powerapps/use-ai-builder) for processes and predictions, [Power Automate](/power-automate/) for workflows, and [Power BI](/power-bi/) for data consumption.

> [!NOTE]
> When you rely on citizen developers to test hypotheses, it's advisable to have some professional developers on hand to provide support, review, and guidance. After a hypothesis is validated at scale, a process for transitioning the application into a more robust programming model will accelerate returns on the innovation. By involving professional developers in process definitions early on, you can realize cleaner transitions later.

## Intelligent experiences

Intelligent experiences combine the speed and scale of modern web applications with the intelligence of Cognitive Services and bots. Alone, each of these technologies might be sufficient to meet your customers' needs. When smartly combined, they broaden the spectrum of needs that can be met through a digital experience, while helping to contain development costs.

### Modern web apps

When an application or experience is required to meet a customer need, modern web applications can be the fastest way to go. Modern web experiences can engage internal or external customers quickly and allow for rapid iteration on the solution.

### Infusing intelligence

Machine learning and AI are increasingly available to developers. The wide-spread availability of common APIs with predictive capabilities allows developers to better meet the needs of the customer through expanded access to data and predictions.

Adding intelligence to a solution can enable speech to text, text translation, Computer Vision, and even visual search. With these expanded capabilities, it's easier for developers to build solutions that take advantage of intelligence to create an interactive and modern experience.

### Bots

Bots provide an experience that feels less like using a computer and more like dealing with a person, or at least with an intelligent robot. They can be used to shift simple, repetitive tasks (such as making a dinner reservation or gathering profile information) onto automated systems that might no longer require direct human intervention. Users converse with a bot through text, interactive cards, and speech. A bot interaction can range from a quick question-and-answer to a sophisticated conversation that intelligently provides access to services.

Bots are a lot like modern web applications: they live on the internet and use APIs to send and receive messages. What's in a bot varies widely depending on what kind of bot it is. Modern bot software relies on a stack of technology and tools to deliver increasingly complex experiences on a variety of platforms. However, a simple bot could just receive a message and echo it back to the user with very little code involved.

Bots can do the same things as other types of software: read and write files, use databases and APIs, and handle regular computational tasks. What makes bots unique is their use of mechanisms generally reserved for human-to-human communication.

## Cloud-native solutions

Cloud-native applications are built from the ground up, and they're optimized for cloud scale and performance. Cloud-native applications are typically built using a microservices, serverless, event-based, or container-based approaches. Most commonly, cloud-native solutions use a combination of microservices architectures, managed services, and continuous delivery to achieve reliability and faster time to market.

A cloud-native solution allows centralized development teams to maintain control of the business logic without the need for monolithic, centralized solutions. This type of solution also creates an anchor to drive consistency across the input of citizen developers and modern experiences. Finally, cloud-native solutions provide an innovation accelerator by freeing citizen and professional developers to innovate safely and with a minimum of blockers.

## Innovate through existing solutions

Many customer hypotheses can best be delivered by a modernized version of an existing solution. When the current business logic meets customer needs (or comes really close), you might be able to accelerate innovation by building on top of a modernized solution.

Most forms of modernization, including slight refactoring of the application, are included in the [Migrate methodology](../../migrate/index.md) within the Cloud Adoption Framework. That methodology guides cloud adoption teams through the process of migrating a [digital estate](../../digital-estate/index.md) to the cloud. The [Azure migration guide](../../migrate/azure-migration-guide/index.md) provides a streamlined approach to the same methodology, which is suitable for a small number of workloads or even a single application.

After a solution has been migrated and modernized, there are a variety of ways it can be used to create new, innovative solutions to customer needs. For example, [citizen developers](#citizen-developers) could test hypotheses, or professional developers could create [intelligent experiences](#intelligent-experiences) or [cloud-native solutions](#cloud-native-solutions).

### Extend an existing solution

Extending a solution is one common form of modernization. This is approach can be the fastest path to innovation when the following are true of the customer hypothesis:

- Existing business logic should meet (or comes close to meeting) the existing customer need.
- An improved experience would better meet the needs of a specific customer cohort.
- The business logic required by the minimum viable product (MVP) solution has been centralized, usually via an [n-tier](/azure/architecture/guide/architecture-styles/n-tier), web services, API, or [microservices](/azure/architecture/guide/architecture-styles/microservices) design. This approach consists of wrapping the existing solution within a new experience hosted in the cloud. In Azure, this solution would likely live in Azure App Service.

### Rebuild an existing solution

If an application can't be easily extended, it may be necessary to refactor the solution. In this approach, the workload is migrated to the cloud. After the application is migrated, parts of it are modified or duplicated, as web services or [microservices](/azure/architecture/guide/architecture-styles/microservices), which are deployed in parallel with the existing solution. The parallel service-based solution could be treated like an extended solution. This solution would simply wrap the existing solution with a new experience hosted in the cloud. In Azure, this solution would likely live in Azure App Service.

> [!CAUTION]
> Refactoring or rearchitecting solutions or centralizing business logic can quickly trigger a time-consuming [technical spike](./build.md#reduce-complexity-and-delay-technical-spikes) instead of a source of customer value. This is a risk to innovation, especially early in hypothesis validation. With a bit of creativity in the design of a solution, there should be a path to MVP that doesn't require refactoring of existing solutions. It's wise to delay refactoring until the initial hypothesis can be validated at scale.

## Operating model innovations

In addition to modern innovative approaches to application creation, there have been notable innovations in application operations. These approaches have spawned many organizational movements. One of the most prominent is the [cloud center of excellence](../../organize/cloud-center-of-excellence.md) operating model. When fully staffed and mature, business teams have the option to provide their own operational support for a solution.

The type of self-service operational management model found in a cloud center of excellence allows for tighter controls and faster iterations within the solution environment. These goals are accomplished by transferring operational control and accountability to the business team.

If you're trying to scale or meet global demand for an existing solution, this approach might be sufficient to validate a customer hypothesis. After a solution is migrated and slightly modernized, the business team can scale it to test a variety of hypotheses. These typically involve customer cohorts who are concerned with performance, global distribution, and other customer needs hindered by IT operations.

## Reduce overhead and management

The more there is to maintain within a solution, the slower that solution will iterate. This means you can accelerate innovation by reducing the impact of operations on available bandwidth.

To prepare for the many iterations required to deliver an innovative solution, it's important to think ahead. For example, minimize operational burdens early in the process by favoring serverless options. In Azure, serverless application options could include [Azure App Service](/azure/app-service/overview) or [containers](/azure/containers/).

In parallel, Azure provides serverless transaction data options that also reduce overhead. The [Azure product catalog](/azure/) provides database options that host data without the need for a full data platform.

## Next steps

Depending on the hypothesis and solution, the principles in this article can aid in designing applications that meet MVP definitions and engage users. Up next are the principles for [empowering adoption](./ci-cd.md), which offer ways to get the application and data into the hands of customers more quickly and efficiently.

> [!div class="nextstepaction"]
> [Empower adoption](./ci-cd.md)
