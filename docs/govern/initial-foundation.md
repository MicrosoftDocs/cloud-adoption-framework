---
title: Establish an initial cloud governance foundation
description: Use the Cloud Adoption Framework for Azure to get started with cloud governance by establishing an initial cloud governance foundation.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Establish an initial cloud governance foundation

Establishing cloud governance is a broad iterative effort. It's challenging to strike an effective balance between speed and control, especially during execution of early methodologies within the cloud adoption. The governance guidance in the Cloud Adoption Framework helps provide that balance via an agile approach to adoption.

This article provides two options for establishing an initial foundation for governance. Either option ensures that governance constraints can be scaled and expanded as the adoption plan is implemented and requirements become more clearly defined. By default, the initial foundation assumes an isolate-and-control position. It also focuses more on resource organization than on resource governance. This lightweight starting point is called a *minimum viable product (MVP)* for governance. The objective of the MVP is reducing barriers to establishing an initial governance position, and then enabling rapid maturation of the solution to address a variety of tangible risks.

## Already using the Cloud Adoption Framework

If you have been following along with the Cloud Adoption Framework, you may have already deployed a governance MVP. Governance is a core aspect of any operating model. It's present in every methodology of the cloud adoption lifecycle. As such, the [Cloud Adoption Framework](../index.yml) provides guidance that injects governance into activities related to the implementation of your [cloud adoption plan](../plan/index.md). One example of this governance integration is using blueprints to deploy one or more landing zones present in the [Ready methodology](../ready/index.md) guidance. Another example is guidance for [scaling out subscriptions](../ready/azure-best-practices/scale-subscriptions.md). If you have followed either of those recommendations, then the following MVP sections are simply a review of your existing deployment decisions. After a quick review, jump ahead to [mature the initial governance solution and apply best-practice controls](./foundation-improvements.md).

## Establish an initial governance foundation

The following are two different examples of initial governance foundations (also called governance MVPs) to apply a sound foundation for governance to new or existing deployments. Choose the MVP that best aligns with your business needs to get started:

- [Standard governance guide](./guides/standard/index.md): A guide for most organizations based on the recommended initial two-subscription model, designed for deployments in multiple regions but not spanning public and sovereign/government clouds.
- [Governance guide for complex enterprises](./guides/complex/index.md): A guide for enterprises that are managed by multiple independent IT business units or span public and sovereign/government clouds.

## Next steps

Once a governance foundation is in place, apply suitable recommendations to improve the solution and protect against tangible risks.

> [!div class="nextstepaction"]
> [Improve the initial governance foundation](./foundation-improvements.md)
