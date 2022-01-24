---
title: Understand cloud operating models
description: Understand cloud operating models and how they impact your cloud adoption strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal, operating-model
---

# Understand cloud operating models

Adopting the cloud creates an opportunity to revisit how you operate technological systems. This series of articles clarifies cloud operating models and how they might impact your cloud adoption strategy. However, let us clarify the meaning of *cloud operating model*.

## Define your operating model

Before deploying your cloud architecture, try to understand how you want to operate in the cloud. Strategic direction, among people organization, governance, risk, and compliance, help define your cloud operating model. Your landing zones might provide a variety of options to support your operating model. The proceeding articles share foundational terms and provide examples of common operating models. These models, which are based on actual customer experiences, might help guide your decision about the right Azure landing zone.

## What is an operating model?

Before the existence of cloud technologies, teams established operating models to define how technology would support the business. IT operating models have a number of factors. However, these factors remain consistent: *alignment to business strategy, organization of people, change management (or adoption processes), operations management, governance/compliance, and security*.

IT operating model factors are essential to long-term technology operations.

Some processes remain relevant when technology operations shift to the cloud. However,  the processes might change in some ways. Current operating models focus on physical assets in physical locations, which are funded through capital expenditure cycles. These assets are used to support workloads that the business needs to maintain operations. The mission of most operating models is to prioritize the workloads by investing in the stability of physical assets.

## How is a cloud operating model different?

The hardware stack is a never-ending cycle. Physical hardware breaks down and performance degrades. The breakdown of hardware rarely aligns with an organization's capital expenditure budget and planning cycles. Operating in the cloud changes the way you do hardware refreshes and midnight patches. The cloud shifts your focus upstream to operating systems, applications, and data digital assets. The shift from physical to digital also shifts your technology operating model.

As operating models shift to the cloud, you still need the same people and processes. However, the shift is focused on a higher level of operations. If your people no longer focus on server uptime, then their success metrics will change. When security is no longer protected by the four walls of a datacenter, then your threat profile changes. The way you manage changes might change when procurement is no longer a blocker to innovation.

A *cloud operating model* is the collection of processes and procedures that define how you want to operate technology in the cloud.

## Purpose of a cloud operating model

When we remove hardware from the unit of operations, we shift focus to digital assets and supported workloads. As such, operating models shift from keeping the lights on to ensuring consistent operations.

The [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) does a great job of decomposing workload considerations, which are a set of common architectural principles. We use these principles for cost optimization, operational excellence, performance efficiency, reliability, and security.

When moving to a higher level of operations, the common architectural principles help reframe the purpose of the cloud operating model. How do we ensure that all assets and workloads in the portfolio balance these architecture principles? What processes are needed to scale the application of those principles?

## Reimagine your operating model

Update your operating model to remove references to procurement, change, operations, or protection of physical assets is an option. If you do this, then what is left? For some organizations, their operating model is a clean slate, and the constraints developed over time are reduced. This is an opportunity to think about how you want to operate in the cloud.

To help you imagine the future state of your operating model, these articles discuss the following subjects:

- [Define your cloud operating model](./define.md)
- [Compare common cloud operating models](./compare.md)
- [Implement your operating model with Azure landing zones](../ready/landing-zone/implementation-options.md)

## Next steps

Learn how the Cloud Adoption Framework helps you define your operating model.

> [!div class="nextstepaction"]
> [Compare common cloud operating models](./compare.md)
