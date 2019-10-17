---
title: "Cloud innovation: Engage through applications"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Introduction to Cloud innovation - Engage through applications
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/24/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Engage through applications

As discussed in the article on [democratizing data](./data.md), data is the new oil. It fuels most innovations across the digital economy. Building on that analogy, applications are the fueling station and infrastructure required to get that fuel into the right hands.

In some cases, data is enough to drive change and meet the customers' needs. More commonly, the solution to customer needs will require applications to shape the data and create an experience. Applications are the way we engage the user. They are the home for the processes required to respond to customer triggers. They are the customers means of providing data and receiving guidance. This article will outline a few principles that will aid in aligning the right application solution, based on the hypotheses to be validated.

## Shared code

Team's that can more quickly and accurately respond to customer feedback, market changes, and opportunities to innovate, will lead their respective markets in innovation. The first principle of innovative applications is outlined in the [growth mindset overview](./learn.md#growth-mindset), "Share the code". Innovation over time, can only come from a cultural focus. To sustain innovation, diverse perspectives and contributions will be required.

To be ready for innovation, all application development should start with a shared code repository. The most common tool for managing code repositories is [GitHub](https://guides.github.com/), which allows for the creation of a shared code repository with a few clicks. Alternatively, the [Azure Repos](/azure/devops/repos/get-started/what-is-repos?view=azure-devops) feature of Azure DevOps can be used to create a [Git](/azure/devops/repos/get-started/what-is-repos?view=azure-devops#git) or [Team Foundation](/azure/devops/repos/get-started/what-is-repos?view=azure-devops#tfvc) repository.

## Citizen developers

Professional developers are a vital component of innovation. When a hypothesis proves accurate at scale, professional developers are required to stabilize and prepare the solution for scale. Most of the principles referenced in this article will require support from professional developers. Unfortunately, current trends suggest that there are more openings for professional developers, then there are developers. Further, the cost and pace of innovation can be less favorable when the rigors of professional development are required. Citizen developers provide a way to scale development efforts and accelerate early hypothesis testing.

Citizen developers may be wise approach when early hypotheses can be validated using tools like [PowerApps](https://docs.microsoft.com/powerapps/powerapps-overview) for app interfaces, [AI Builder](/powerapps/use-ai-builder) for processes and predictions, [Microsoft Flow](https://docs.microsoft.com/flow) for workflows, or [Power BI](https://docs.microsoft.com/power-bi) for data consumption.

> [!NOTE]
> When leveraging citizen developers to test hypotheses, it is advised that the professional developers provide support, review, and guidance. Once a hypothesis is validated at scale, a process to transitioning the application into a more robust programming model will accelerate returns on the innovation. Involving professional developers in early process definitions can result in cleaner transitions later.

## Modern web experiences

When an application or experience is required to meet a customer need, modern web applications can be the fastest way to meet that need. Modern web experiences can engage internal or external customers quickly and allow for rapid iteration on the solution.

Azure App Service provides a hosting environment for your applications that removes the burden of infrastructure management and OS patching. It provides for automation of scale to meet the demands of your users but bound by limits you define to keep costs in check. App Service provides first-class support for languages such as ASP.NET, ASP.NET Core, Java, Ruby, Node.js, PHP, or Python. If you have the need to host another run-time stack, Web App for Container offers the ability to quickly and easily host a Docker container within the App Service environment to allow you to host your custom code stack in an environment that gets you out of the server business.

## Cloud-native solutions

Cloud native applications are built from the ground up. Cloud native applications are optimized for cloud scale and performance. Cloud-native applications are typically built using a microservices, serverless, event-based, or container-based approaches. Most commonly, cloud-native solutions leverage a combination of microservices architectures, managed services, and continuous delivery to achieve reliability and faster time to market.

A cloud-native solution allows centralized development teams to maintain control of the business logic, without the need for monolithic centralized solutions. This type of solution also creates an anchor to drive consistency across citizen developers and modern experiences. Finally, cloud-native solutions provide an innovation accelerator by freeing citizen and professional developers to innovate safely and with minimal blockers.

## Innovate through existing solutions

Many customer hypotheses can best be delivered by a modernized version of an existing solution. When the current business logic meets the customer needs (or comes really close), you may be able to accelerate innovation by building on top of a modernized solution.

Most forms of modernization, including slight refactoring of the application, are included in the [Migrate methodology](../../migrate/index.md) within the Cloud Adoption Framework. That methodology guides cloud adoption teams through the processes for migrating a [digital estate](../../digital-estate/index.md) to the cloud. The [Azure Migration Guide](../../migrate/azure-migration-guide/index.md) provides a streamlined approach to the same methodology, which is suitable for a small number of workloads or even a single application.

Once migrated and modernized, there are a variety of ways the solution could be leveraged in the creation of new innovative solutions to customer needs. For instance, [citizen developers](#citizen-developers) could test hypotheses or professional developers could create [Modern web experiences](#modern-web-experiences) or [cloud-native solutions](#cloud-native-solutions).

### Extend an existing solution

Extending a solution is one common form of modernization. This is approach can be the fastest path to innovation when the following are true of the customer hypothesis:

- Existing business logic should meet (or comes close to meeting) the existing customer need.
- An improved experience would better meet the needs of a specific customer cohort.
- The business logic required by the MVP solution has been centralized, usually via an [N-tier](/azure/architecture/guide/architecture-styles/n-tier), web services, API, or [microservices](/azure/architecture/guide/architecture-styles/microservices) design. This approach consists of wrapping the existing solution with a new experience hosted in the cloud. In Azure, this solution would likely live in Azure App Services.

### Rebuild an existing solution

If an application can't be easily extended, it may be necessary to refactor the solution. In this approach, the workload is migrated to the cloud. Once migrated, parts of the application are modified or duplicated, as web services or [microservices](/azure/architecture/guide/architecture-styles/microservices), which are deployed in parallel to the existing solution. The parallel service-based solution could be treated like an extended solution. This solution would simply wrap the existing solution with a new experience hosted in the cloud. In Azure, this solution would likely live in Azure App Services.

> [!CAUTION]
> Refactoring/rearchitecting solutions or centralizing business logic can quickly become a time-consuming [technical spike](./build.md#reduce-complexity-and-delay-technical-spikes), as opposed to a source of customer value. This is a risk to innovation, especially early in hypothesis validation. With a bit of creativity in the design of a solution, there should be a path to MVP that doesn't require refactoring of existing solutions. It is wise to delay refactoring, until the initial hypothesis can be validated at scale.

## Operating model innovations

In addition to modern innovation approaches to the creation of apps, there have been innovations regarding the operations of apps. The approaches have spawned many organizational movements. One of the most prominent is a movement toward [cloud center of excellence](../../organize/cloud-center-of-excellence.md) operating models. When fully staffed and mature, business teams have the option to provide their own operational support for a solution.

The type of self-service operational management model, found in a cloud center of excellence, allows for tighter controls and faster iterations within the solution environment. This is accomplished by transferring operational control and accountability to the business team.

When the objective is to scale or meet global demand for an existing solution, this approach may be sufficient to validate a customer hypothesis. Once migrated and slightly modernized, the business team would have the ability to scale solutions to test a variety of hypotheses regarding customer cohorts who are concerned with performance, global distribution, or other customer needs hindered by IT operations.

## Reduce overhead and management

The more there is to maintain within a solution, the slower that solution will iterate. Accelerate innovation by reducing the impact operations has on available velocity.

To prepare for the many iterations required to deliver an innovative solution, it is important to think ahead. Minimize operational burdens early in the process, by favoring serverless options.

In Azure, serverless application options could include [Azure App Service](https://docs.microsoft.com/azure/app-service/overview), [Service Fabric](https://docs.microsoft.com/azure/architecture/example-scenario/infrastructure/service-fabric-microservices), [containers](https://docs.microsoft.com/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-rearchitect-container-sql), etc.

In parallel, Azure provides serverless transaction data options which also reduce overhead. The [database products list](https://docs.microsoft.com/azure/#pivot=products&panel=databases) provides  options for hosting data, without the need for a full data platform.

## Next steps

Depending on the hypothesis and solution, the principles in this article can aid in designing apps that meet MVP definitions and engage users. Up next are the principles of [empowering adoption](./ci-cd.md), which will discuss ways to quickly get the application and data into the hands of customers more quickly.

> [!div class="nextstepaction"]
> [Empower adoption](./ci-cd.md)
