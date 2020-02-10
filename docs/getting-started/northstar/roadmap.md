---
title: "Codename: CAF NorthStar"
titleSuffix: Cloud Adoption Framework
description: Codename - CAF NorthStar
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# CAF NorthStar architecture guide

![CAF CAF NorthStar architecture guide](./media/icon.png)

This guide expands the initial scope of the Cloud Adoption Framework's Ready methodology by exploring actionable architectural and implementation guidelines for large-scale enterprise Azure adoption, focusing on the platform CAF NorthStar design that must occur prior to application deployments, to support cloud migrations and position customers on a strategic transformation path for cloud-native innovation.

In this regard, this guide is intended to support enterprise Azure adoption by leveraging learnings from previous engineering engagements to provide a common CAF NorthStar design pattern, where the CAF NorthStar represents a strategic and ever-evolving design path for the platform, that is fully aligned with growth and advancement of the Azure platform.

> [!WARNING]
> The CAF NorthStar guidance is currently an internal FTE only asset. While in development it is not customer ready & requires Microsoft FTE access to access this PR's review site. Upon general availability of this content, the shortlink [https://aka.ms/adopt/northstar](https://aka.ms/adopt/northstar) will be redirected to the production home for this guidance. Until then, this site is safe for use for internal collaboration. Expect frequent changes and potential editing errors in this pre-release version of the content.

## Distinct technical and business advantage

For most customers, the Cloud Adoption Framework provides separate methodologies for implementing and maturing along the following pillars: adoption readiness/landing zones (CAF Ready), governance (CAF Govern), operational management (CAF Manage), and deployment automation (CAF innovate). In the standard approach featured throughout the framework, each methodology progresses at it's own pace based on the adoption plan and each teams' existing processes.

However, a number of scenarios require all three methodologies to reach a minimum level of maturity in unison. Examples of these scenarios include things like Large-scale migrations, extending a cloud center of excellence to a new cloud provider, hard commitments to exit a data center by a specific date, etc... For these complex scenarios and a number of others, the CAF NorthStar architecture pulls aspects of each methodology into a single, united implementation plan to ensure specific standards are met before adoption begins.

## Objective

The primary objective of this guide is to **help define a CAF NorthStar architecture**, considering requisite design decisions across fundamental technical topics and “what-must-be-true” before organization wide Azure adoption can occur at large scale. This guide also outlines architectural guidance for large-scale Azure adoption to provide critical insights in support of enterprise-scale migration/transformation projects.

## Community

This guide is developed largely by **Microsoft Cloud Solutions Architects and the broader Cloud Solutions Unit technical community**. This community actively advances this guide to share lessons learned during enterprise-scale adoption efforts.

While this guide shares the same design principles as the standard Ready methodology, it expands upon those principles to integrate topics like governance and security, earlier in the planning process. This expansion of the standard process is necessary because of a few natural assumptions that can be made when an adoption effort requires large-scale enterprise change.

## Prerequisites

To fully leverage the guidance contained within this guide, readers must have a collaborative engagement with key customer stakeholders across critical technical domains, such as identity, security, and networking. Ultimately, the success of any large-scale migration hinges on cross-discipline cooperation within the customer organization, since key requisite ”NorthStar” design decisions are cross cutting, and to be authoritative must involve domain SMEs (Subject Matter Experts) and stakeholders within the customer.

It is also assumed that readers have a broad understanding of key Azure constructs and services in order to fully contextualize the prescriptive recommendations contained within this guide.

## Next steps

Review the [NorthStar architecture](./northstar-architecture.md)

> [!div class="nextstepaction"]
> [NorthStar architecture](./northstar-architecture.md)