---
title: "Introduction to the operating model"
description: Use the Cloud Adoption Framework for Azure to learn how to establish an operating model for the cloud.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.custom: operating-model
---

# Establish an operating model for the cloud

Cloud adoption is an iterative effort focusing on what you do in the cloud. The cloud strategy outlines the digital transformation to guide business programs, as various teams execution adoption projects. Planning and Readiness help ensure the success of each of those important elements. All steps of cloud adoption equate to tangible projects with manageable objectives, timelines, and budgets.

These adoption efforts are relatively easy to track and measure, even when they involve multiple projected iterations and releases. Each phase of the adoption lifecycle is important. Each phase is prone to potential roadblocks across business, culture, and technology constraints. But, each phase depends heavily on the underlying operating model.

**If adoption describes what you are doing, the operating model defines the underlying who and how that enable adoption.**

"Culture eats strategy for breakfast." The operating model is the embodiment of the IT culture, captured in a number of measurable processes. When the cloud is powered by a strong operating model, the culture will drive to the strategy, accelerating adoption and business values realization. Conversely, when adoption is successful but there is no operating model, the returns can be impressive but very short lived. For long-term success, it is vital that adoption and operating models advance in parallel.

## Establish your operating model

Current operating models can scale to support adoption of the cloud. A modern operating model will help you remove nontechnical blockers to cloud adoption.

This section of the Cloud Adoption Framework provides an actionable operating model to guide nontechnical decisions. This operating model consists of three methodologies to aid in creating your own cloud operating model:

- [Govern](../govern/index.md): Ensure consistency across adoption efforts. Align to governance or compliance requirements to maintain a well-managed cross-cloud environment.
- [Manage](../manage/index.md): Align ongoing processes for operational management of the technology to maximize value attainment and minimize disruptions.
- [Organize](../organize/index.md): As the operating model matures, so will the organization of various teams and capabilities supporting the operating model.

## Align operating models

The cloud and the digital economy have exposed the need for multiple operating models. Sometimes this need is driven by a requirement to support multiple public clouds. More commonly, the need is highlighted by the transition from on-premises to the cloud. In either scenario, it's important to align operating models for maximum performance and minimum redundancy.

Analysts are predicting multicloud adoption at high volumes. Many customers are moving toward that prediction. Unfortunately, customers are reporting significant challenges operating multiple clouds. Duplicated resources, processes, skills, and technologies is resulting in increased costs, not the savings promised by the cloud predictions. To avoid this trend, customers should adopt a specialized operating model. When aligning operating models, there should always be one **general operating model**. Additional **specialized operating models** would be used for specific scenarios to support deviations from the standard model.

- **General operating model:** The general operating model aligns to a single public or private cloud platform. Operations of that platform defines operational standards, policies, and processes. This operating model should be the primary means of powering the go-forward cloud strategy. In this model, the goal is to use the primary cloud provider for the bulk of cloud adoption.

- **Specialized operating model:** Specific business outcomes may be a better fit for an alternative cloud provider. When a compelling business case is present, the standards, policies, and processes from the general operating model are applied to the new cloud provider but are then modified to fit the specialized use case.

If Azure is the primary platform of choice, the guides and best practices in each of the operating model sections listed above will prove valuable in the creation of your operating model. But this framework recognizes that not all of our readers have committed to Azure as the primary platform. To accommodate this broader audience, the theory content in each section can be applied to public or private cloud operating models with similar outcomes.

## Next steps

Governance is a common first step toward establishing an operating model for the cloud.

> [!div class="nextstepaction"]
> [Learn about cloud governance](../govern/index.md)
