---
title: Cloud rationalization
description: Learn about cloud rationalization, which is the process of evaluating assets to determine the best way to migrate or modernize each asset in the cloud.
author: Zimmergren
ms.author: pnp
ms.date: 03/01/2023
ms.topic: conceptual
ms.custom: internal
---

# Cloud rationalization

Cloud rationalization is the process of evaluating assets to determine the best way to migrate or modernize each asset in the cloud. For more information about the process of rationalization, see [What is a digital estate](./index.md).

## Rationalization context

The *five Rs of rationalization* listed in this article are a great way to label a potential future state for any workload that's being considered as a cloud candidate. Put this labeling process into the correct context before you attempt to rationalize an environment. To provide that context, review the following myths:

### Myth: It's easy to make rationalization decisions early in the process

Good rationalization requires a deep knowledge of the workload and associated assets, like applications, infrastructure, and data. Most importantly, good rationalization decisions take time. We recommend that you use an [incremental rationalization process](./rationalize.md#incremental-rationalization).

### Myth: Cloud adoption has to wait for all workloads to be rationalized

When an entire IT portfolio or even a single datacenter is rationalized, it can delay the realization of business value by months or even years. Avoid full rationalization when possible. Instead, use the [Power of 10 approach to release planning](./rationalize.md#release-planning) to make wise decisions about the next 10 workloads that are slated for cloud adoption.

### Myth: Business justification has to wait for all workloads to be rationalized

To develop a business justification for a cloud adoption effort, make a few basic assumptions at the portfolio level. When motivations are aligned to innovation, assume rearchitecture. If they're aligned to migration, assume rehost. These assumptions can accelerate the business justification process. During the assessment phase of each workload's adoption cycle, assumptions are then challenged, and budgets are refined.

Now review the following five Rs of rationalization to familiarize yourself with the long-term process. While developing your cloud adoption plan, choose the option that best aligns with your motivations, business outcomes, and current state environment. The goal in digital estate rationalization is to set a baseline, not to rationalize every workload.

## The five Rs of rationalization

The following five Rs of rationalization describe the most common options for rationalization.

## Rehost

Also known as a *lift and shift* migration, a rehost effort moves a current state asset to the chosen cloud provider with minimal change to the overall architecture.

Common drivers might be to:

- Reduce capital expense.
- Free up datacenter space.
- Achieve rapid return on investment in the cloud.

Quantitative analysis factors are:

- VM size, including CPU, memory, and storage.
- Dependencies, like network traffic.
- Asset compatibility.

Qualitative analysis factors are:

- Tolerance for change.
- Business priorities.
- Critical business events.
- Process dependencies.

## Refactor

Platform as a service (PaaS) options can reduce the operational costs that are associated with many applications. It's a good idea to slightly refactor an application to fit a PaaS-based model.

*Refactor* also refers to the application development process of refactoring code to enable an application to deliver on new business opportunities.

Common drivers might include:

- Faster and shorter updates.
- Code portability.
- Greater cloud efficiency to help with resources, speed, cost, and managed operations.

Quantitative analysis factors are:

- Application asset size, like CPU, memory, and storage.
- Dependencies, like network traffic.
- User traffic, like page views, time on page, and load times.
- Development platforms, like languages, data platforms, and middle tier services.
- Database that includes CPU, memory, storage, and version.

Qualitative analysis factors are:

- Continued business investments.
- Bursting options or timelines.
- Business process dependencies.

## Rearchitect

Some aging applications aren't compatible with cloud providers. This incompatibility is because of the architectural decisions that were made when the application was built. In these cases, the application might need to be rearchitected before transformation.

In other cases, applications that are cloud-compatible, but not cloud-native, might create cost efficiencies and operational efficiencies by rearchitecting the solution into a cloud-native application.

Common drivers might include:

- Application scale and agility.
- Easier adoption of new cloud capabilities.
- Mix of technology stacks.

Quantitative analysis factors are:

- Application asset size, like CPU, memory, and storage.
- Dependencies, like network traffic.
- User traffic, like page views, time on page, and load times.
- Development platforms, like languages, data platforms, and middle tier services.
- Database that includes CPU, memory, storage, and version.

Qualitative analysis factors are:

- To grow business investments.
- Operational costs.
- Potential feedback loops and DevOps investments.

## Rebuild

In some scenarios, the delta that must be overcome to carry an application forward can be too large to justify further investment. This issue is especially true for applications that previously met the needs of a business but are now unsupported with the current business processes. To resolve the issue, create a new code base to align with a [cloud-native](https://azure.microsoft.com/overview/cloudnative/) approach.

Common drivers might be to:

- Accelerate innovation.
- Build applications faster.
- Reduce operational cost.

Quantitative analysis factors are:

- Application asset size, like CPU, memory, and storage.
- Dependencies, like network traffic.
- User traffic, like page views, time on page, and load times.
- Development platforms, like languages, data platforms, and middle tier services.
- Database that includes CPU, memory, storage, and version.

Qualitative analysis factors are:

- Declining end user satisfaction.
- Business processes that are limited by functionality.
- Potential cost, experience, or revenue gains.

## Replace

Solutions are typically implemented by using the best technology and approach available at the time. Sometimes software as a service (SaaS) applications can provide all the necessary functionality for the hosted application. In these scenarios, a workload can be scheduled for future replacement, which removes it from the transformation effort.

Common drivers might be to:

- Standardize around industry best practices.
- Accelerate the adoption of business process-driven approaches.
- Reallocate development investments into applications that create competitive differentiation or advantages.

Quantitative analysis factors are:

- General operating cost reductions.
- VM size, including CPU, memory, and storage.
- Dependencies, like network traffic.
- Assets to be retired.
- Database that includes CPU, memory, storage, and version.

Qualitative analysis factors are:

- Cost benefit analysis of the current architecture versus a SaaS solution.
- Business process maps.
- Data schemas.
- Custom or automated processes.

## Next steps

You can apply these five Rs of rationalization to a digital estate to help you make rationalization decisions about the future state of each application.

> [!div class="nextstepaction"]
> [What is a digital estate](./index.md)
