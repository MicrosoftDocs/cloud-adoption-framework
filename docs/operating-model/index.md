---
title: "Understanding cloud operating models"
description: Gain an understanding on cloud operating models and how they impact your cloud adoption strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/20/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.custom: operating-model
---

# Understanding cloud operating models

Adopting the cloud creates an opportunity to "hit refresh" on you operate technology systems. This article series will create clarity around cloud operating models and the considerations which will impact your cloud cloud adoption strategy. But first, this initial article will provide clarity on the term cloud operating model.

## What is an operating model?

Prior to the existence of cloud technologies, technology teams established operating models to define how technology would support the business. There are a number of factors in any companies IT operating model, but a few remain consistent: **Alignment to business strategy, organization of people, change management (or adoption processes), operations management, governance/compliance, and security**. Each of these modular tenants is essential to long term technology operations.

When technology operations moves to the cloud, these vital processes are still relevant. But, they are likely to change in some ways. Current operating models focus heavily on physical assets in physical locations funded largely through capital expenditure (CapEx) cycles. Those assets are used to support the workloads that the business needs to maintain business operations. The mission of most operating models is to prioritize stability of the workloads by investing in the stability of the underlying physical assets.

## How is a cloud operating model different?

Redundancy in the hardware stack is a never ending cycle. Physical hardware breaks down. Performance degrades. Seldom does the degradation of hardware align with the predictable budgetary cycles of an organization's capital expenditure planning cycles. Operating in the cloud, breaks the treadmill of hardware refreshes & mid-night patches by shifting the focus upstream to the digital assets: Operating Systems, Applications, and Data - Or Assets. This shift from physical to digital causes a shift in the technology operating model.

As your operating model shifts to the cloud, you still need the same people and processes. But they too shift to focus on a higher level of operations. If your people no longer focus on server uptime, their success metrics will change. If security is no longer protected by the four walls of a data center, your threat profile changes. When procurement is no longer a blocker to innovation, the pace at which you manage change, also changes.

A cloud operating model, is the collection of processes and procedures that define how you want to operate technology in the cloud.

## Purpose of a cloud operating model

When hardware is removed as the most common unit of operations, the focus shifts to the digital assets and the workloads they support. As such, the purpose of the operating model shifts from "Keeping the lights on" to ensuring consistent operations.

The [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) does a great job of decomposing workload considerations into a set of common architectural principles: Cost optimization, Operational Excellence, Performance Efficiency, Reliability, and Security.  

When moving to a higher level of operations, these common architectural principles help re-frame the purpose of the cloud operating model. How do we ensure that all assets and workloads in the portfolio balance these architecture principles? What processes are needed to scale the application of those principles?

## Reimagine your operating model

If you updated your operating model to remove every reference to the procurement, change, operations, or protection of physical assets, what's left? For some organizations, their operating model is now a clean slate. For most organizations, the constraints that have developed over the years are now reduced. In either case, there is an opportunity to think about how you would like to operate in the cloud.

To aid in imagining your future state operating model, this article series walks through the following topics:

- [Common examples of cloud operating models](./common-examples.md)
- [Defining each aspect of your operating model](./methodologies.md)
- [Implement your operating model with Azure landing zones](./implement.md)

## Next steps

Before defining your operating model, review the common approaches other customers take to operating the cloud, with [common operating model examples](./common-examples.md).
