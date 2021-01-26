---
title: "Introduction to the Hybrid and Multicloud scenario"
description: Describe the scenario
author: mpvenables
ms.author: brblanch
ms.date: 01/11/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Introduction to hybrid and multicloud

Microsoft Azure provides all of the products and features required to help you to build and operate your technology solutions in the cloud. We also understand that there are sound business reasons that may drive the necessity of using multiple private and/or public clouds. As a first step in your hybrid and multicloud journey, this article outlines and expands on Microsoft's unique perspective on important cloud computing terms.

## Defining hybrid and multicloud

Reducing latency by moving workloads to the edge, devices spend less time communicating with the cloud, and can operate reliably in extended offline periods. Expanded compute, storage, and service availability provides experience-driven resources closer to your customers.
A hybrid cloud is a type of cloud computing that combines a private cloud (on-premises infrastructure), with a public cloud (computing services offered by third-party providers over the public Internet). Hybrid clouds allow data and apps to consistently move between the two cloud environments. Many organizations choose a hybrid cloud strategy because of business requirements, such as meeting regulatory and data sovereignty requirements, maximizing  on-premises technology investments, or addressing latency issues.

The hybrid cloud is evolving to include edge workloads as well. Cloud-managed edge computing devices bring the computing power of the public cloud to the private cloud—closer to where the IoT devices reside—data residing on apps, connected devices, and mobile consumer services. Reducing latency by moving workloads to the edge, devices spend less time communicating with the cloud, and can operate reliably in extended offline periods. Expanded compute, storage, and service availability provides experience-driven resources closer to your customers.

Multicloud computing refers to the use of multiple cloud computing services from more than one cloud provider (including private and public clouds), in a heterogeneous environment. A multicloud strategy provides greater flexibility, and mitigates risk. Choose services from different cloud providers that are best suited for a specific task, or take advantage of services offered by a particular cloud provider in a specific location.

## Hybrid and multicloud narrative

This scenario follows a common hybrid and multicloud narrative, and provides guidance on what you can do differently to be successful during your organization's cloud adoption effort. This general narrative is not restricted to a single cloud adoption methodology, but takes a view of the entire cloud adoption journey.

A hybrid cloud platform gives your organization many advantages—greater flexibility, control, and scalability—with more deployment options, global scale, integrated, cross-platform security, unified compliance, and [boosts workload, operational, and cost efficiencies](https://customers.microsoft.com/story/846315-ge-aviation-manufacturing-azure) across the enterprise—**consistently achieving more value from existing infrastructure**. When computing and processing demand fluctuates, hybrid cloud computing enables you to seamlessly scale up your on-premises infrastructure to the public cloud to handle any overflow—without giving third-party datacenters access to the entirety of your data. By running certain workloads in the cloud, your organization gains the flexibility and innovation the public cloud provides, while retaining highly sensitive data in your own datacenter to meet client needs, or remain in compliance with regulatory requirements.

This allows you to scale computing resources, while modernizing and protecting [mission-critical applications and data](https://azure.microsoft.com/solutions/business-critical-applications/). Eliminate the need to make massive capital expenditures to meet short-term spikes in demand, or being forced to free up local resources for more sensitive data. With cloud billing models, your organization will only pay for resources you temporarily use, instead of having to purchase, program, and maintain additional resources and equipment that could remain idle for long periods.

Companies are spreading resources across on-premises, multiple clouds, and the edge. Customers have three common needs that we often hear about:

1. Visibility into the health of all their existing as well as future infrastructure and applications in a single pane of glass.
2. Difficulty integrating on-premises policies and updates with cloud infrastructure. Organizations understand the need for implementing a governance standard,
3. Wide range of skills across on-premises and cloud, because there are often different app development teams in the organization. Customers are looking for consistent inter-operability between the two so they can unify development practices.
4. Desire to manage security posture, without heavily modifying current operations. Cloud and multicloud compounds this challenge which can decrease trust and increase apprehension.

Consider the deployment of cloud-native services in a hybrid and multicloud environment. Cloud services are often strictly contextualized as simply "moving data and applications to the public cloud". A hybrid strategy fully supports highly regulated industries (e.g. government infrastructure, healthcare, financial services) and customer operations that preclude the use of the public cloud for some workloads. In these sectors, internal and customer data is required to remain within the boundaries of on-premises datacenters—data latency sensitivity requires compute to be close to source data in on-premises datacenters—and internet connectivity disruptions are expected, or have critical implications. In these scenarios, hybrid solutions that bring cloud services, decreased management overhead (maintaining these services on-premises), and a pay-as-you-go cloud billing model can be deployed in on-premises datacenters.

## Hybrid and multicloud motivations

As a true enterprise-grade cloud provider, Azure supports your business objectives across public, hybrid, and multicloud environments. This series will discuss different best practices that can help facilitate a variety of cloud mixes ranging from 100% Azure environments to environments that have little, or no, Azure infrastructure in place.

We recognize that there are many valid reasons for customers to choose to distribute their digital estate across hybrid and multicloud environments. Here are some common business drivers:

- Minimize or avoid single cloud provider lock-in
- Business units, subsidiaries or acquired companies have already adopted different cloud platforms
- Different cloud providers may have regulatory and data sovereignty requirements in different countries
- Improve business continuity and disaster recovery by duplicating workloads across two cloud providers
- Maximize performance by running applications close to user locations, which may require hybrid or multicloud adoption
- Enable easy migration for some data platforms or industry-specific applications by adopting multicloud strategies

## Hybrid and Multicloud concerns

Some of the motivations listed above can become business transformations with a sound hybrid and multicloud adoption strategy.

Others require significant effort pre and post deployment efforts to realize those innovative benefits. Cloud provider lock-in, for instance, is possible. But to avoid lock-in, organizations are required to limit their vision for cloud adoption. Many of the most beneficial products and features in a cloud provider are not portable to other cloud providers. To achieve portability and minimize lock-in, organizations are often required to limit cloud adoption to basic Infrastructure-as-a-Service (IaaS), or invest heavily in the use of cloud-native technologies like containers, or Kubernetes.

After workloads are released and are in production, another common concern associated with hybrid and multicloud adoption surfacees. When organizations attempt to provide operations management support to workloads in new environments, they often have to quickly rethink their practices. Existing operations management platforms (including existing operations management policies and processes), were not built for these types of environments. To account for deviations in cloud environments, companies often end up with disparate operations tooling and operations practices, which multiplies the cost of operations by the number of cloud environments supported.

## Next step: Minimize Hybrid and Multicloud concerns with unified operations

Understand the concept of unified operations before starting your hybrid and multicloud journey—consistent operations practices across all of your cloud environments with a common control plane can help to address many concerns regarding hybrid and multicloud strategies.

Determine whether you need to duplicate operations for each cloud provider or implement a [unified operations approach to cloud management](./unified-operations.md) before proceeding with hybrid and multicloud adoption at scale.
