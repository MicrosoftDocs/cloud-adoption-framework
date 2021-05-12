---
title: Understand cloud operating models
description: Understand cloud operating models and how they impact your cloud adoption strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 08/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal, operating-model
---

# Understand cloud operating models

Adopting the cloud creates an opportunity to revisit how you operate technology systems. This article series will clarify cloud operating models and the considerations that impact your cloud adoption strategy. But first, let's clarify the term *cloud operating model*.

## Define your operating model

Before deploying your cloud architecture, it's important to understand how you want to operate in the cloud. Understanding your strategic direction, people organization, and governance, risk, and compliance (GRC) needs helps define your future state cloud operating model. Then, Azure landing zones can provide a variety of architecture and implementation options to support your operating model. The next few articles will share a few foundational terms and provide examples of common operating models based on actual customer experiences, which together can guide your decision about the right Azure landing zone to implement.

## What is an operating model?

Prior to the existence of cloud technologies, technology teams established operating models to define how technology would support the business. Any company's IT operating model has a number of factors, but a few remain consistent: *alignment to business strategy, organization of people, change management (or adoption processes), operations management, governance/compliance, and security*. Each factor is essential to long-term technology operations.

When technology operations shift to the cloud, these vital processes are still relevant, but they're likely to change in some ways. Current operating models focus heavily on physical assets in physical locations funded largely through capital expenditure cycles. These assets are used to support the workloads that the business needs to maintain business operations. The mission of most operating models is to prioritize stability of the workloads by investing in the stability of the underlying physical assets.

## How is a cloud operating model different?

Redundancy in the hardware stack is a never-ending cycle. Physical hardware breaks down. Performance degrades. The degradation of hardware rarely aligns with the predictable budgetary cycles of an organization's capital expenditure planning cycles. Operating in the cloud breaks the treadmill of hardware refreshes and midnight patches by shifting the focus upstream to the digital assets: operating systems, applications, and data. This shift from physical to digital also shifts the technology operating model.

As your operating model shifts to the cloud, you still need the same people and processes, but they also shift to focus on a higher level of operations. If your people no longer focus on server uptime, then their success metrics will change. If security is no longer protected by the four walls of a datacenter, then your threat profile changes. When procurement is no longer a blocker to innovation, then the pace at which you manage change also changes.

A *cloud operating model* is the collection of processes and procedures that define how you want to operate technology in the cloud.

## Purpose of a cloud operating model

When hardware is removed as the most common unit of operations, the focus shifts to the digital assets and the workloads they support. As such, the purpose of the operating model shifts from keeping the lights on to ensuring consistent operations.

The [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) does a great job of decomposing workload considerations into a set of common architectural principles: cost optimization, operational excellence, performance efficiency, reliability, and security.

When moving to a higher level of operations, these common architectural principles help reframe the purpose of the cloud operating model. How do we ensure that all assets and workloads in the portfolio balance these architecture principles? What processes are needed to scale the application of those principles?

## Reimagine your operating model

If you updated your operating model to remove every reference to the procurement, change, operations, or protection of physical assets, what's left? For some organizations, their operating model is now a clean slate. For most organizations, the constraints that have developed over the years are now reduced. In either case, there is an opportunity to think about how you would like to operate in the cloud.

To help you imagine your future state operating model, these articles discuss the following subjects:

- [Define your cloud operating model](./define.md)
- [Compare common cloud operating models](./compare.md)
- [Implement your operating model with Azure landing zones](../ready/landing-zone/implementation-options.md)

## Next steps

Learn how the Cloud Adoption Framework helps you define your operating model.

> [!div class="nextstepaction"]
> [Compare common cloud operating models](./compare.md)
