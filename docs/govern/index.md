---
title: "Governance in the Microsoft Cloud Adoption Framework for Azure"
description: Use the Cloud Adoption Framework for Azure to learn to assess existing policies, build an initial governance foundation, and iteratively add governance tools.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: governance
---

# Governance in the Microsoft Cloud Adoption Framework for Azure

The cloud creates new paradigms for the technologies that support the business. These new paradigms also change how those technologies are adopted, managed, and governed. When entire datacenters can be virtually torn down and rebuilt with one line of code executed by an unattended process, we have to rethink traditional approaches. This is especially true for governance.

Cloud governance is an iterative process. For organizations with existing policies that govern on-premises IT environments, cloud governance should complement those policies. The level of corporate policy integration between on-premises and the cloud varies depending on cloud governance maturity and a digital estate in the cloud. As the cloud estate changes over time, so do cloud governance processes and policies. The following exercises help you start building your initial governance foundation.

<!-- markdownlint-disable MD033 -->

1. [Methodology](./methodology.md): Establish a basic understanding of the methodology that drives cloud governance in the Cloud Adoption Framework to begin thinking through the end state solution.
2. [Benchmark](./benchmark.md): Assess your current state and future state to establish a vision for applying the framework.
3. [Initial governance foundation](./initial-foundation.md): Begin your governance journey with a small, easily implemented set of governance tools. This initial governance foundation is called a minimum viable product (MVP).
4. [Improve the initial governance foundation](./foundation-improvements.md): Throughout implementation of the cloud adoption plan, iteratively add governance controls to address tangible risks as you progress toward the end state.

## Objective of this content

The guidance in this section of the Cloud Adoption Framework serves two purposes:

- Provide examples of actionable governance guides that represent common experiences often encountered by customers. Each example encapsulates business risks, corporate policies for risk mitigation, and design guidance for implementing technical solutions. By necessity, the design guidance is specific to Azure. All other content in these guides could be applied in a cloud-agnostic or multicloud approach.
- Help you create personalized governance solutions that meet a variety of business needs. These needs include the governance of multiple public clouds through detailed guidance on the development of corporate policies, processes, and tooling.

This content is intended for use by the cloud governance team. It's also relevant to cloud architects who need to develop a strong foundation in cloud governance.

## Intended audience

The content in the Cloud Adoption Framework affects the business, technology, and culture of enterprises. This section of the Cloud Adoption Framework interacts heavily with IT security, IT governance, finance, line-of-business leaders, networking, identity, and cloud adoption teams. Various dependencies on these personnel require a facilitative approach by the cloud architects using this guidance. Facilitation with these teams might be a one-time effort. In some cases, interactions with these other personnel will be ongoing.

The cloud architect serves as the thought leader and facilitator to bring these audiences together. The content in this collection of guides is designed to help the cloud architect facilitate the right conversation, with the right audience, to drive necessary decisions. Business transformation that's empowered by the cloud depends on the cloud architect to help guide decisions throughout the business and IT.

**Cloud architect specialization in this section:** Each section of the Cloud Adoption Framework represents a different specialization or variant of the cloud architect role. This section of the Cloud Adoption Framework is designed for cloud architects with a passion for mitigating or reducing technical risks. Some cloud providers refer to these specialists as _cloud custodians_, but we prefer _cloud guardians_ or, collectively, the _cloud governance team_. The actionable governance guides show how the composition and role of the cloud governance team might change over time.

## Use this guide

Reading the Govern methodology content end-to-end will help you develop a robust cloud governance strategy in parallel with cloud implementation. The guidance walks you through the theory and implementation of this strategy.

For a crash course on the theory and quick access to Azure implementation, get started with the [governance guides overview](./guides/index.md). Using this guidance, you can start small and iteratively improve your governance needs in parallel with cloud adoption efforts.
