---
title: "Introduction to Hybrid and Multicloud"
description: Introduction to Hybrid and Multicloud
author: BrianBlanchard;deepakonics 
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Introduction to Hybrid and Multicloud

Microsoft Azure provides all of the products and features required to operate your technology solutions in the cloud. But we understand that there are legitimate business reasons that may necessitate the use of multiple private and/or public clouds. As a first step in the hybrid and multicloud journey, this article outlines Microsoft's view of these important terms.

## Hybrid and Multicloud definitions

A hybrid cloud—sometimes called a cloud hybrid—is a computing environment that combines an on-premises datacenter (also called a private cloud) with a public cloud, allowing data and applications to be shared between them. Some people define hybrid cloud to include “multicloud” configurations where an organization uses more than one public cloud in addition to their on-premises datacenter. Many organizations choose a hybrid cloud approach due to business imperatives such as meeting regulatory and data sovereignty requirements, taking full advantage of on-premises technology investment, or addressing low latency issues.

The hybrid cloud is evolving to include edge workloads as well. Cloud-managed Edge computing devices bring the computing power of the public cloud to the private cloud—closer to where the IoT devices reside. By moving workloads to the edge, devices spend less time communicating with the cloud, reducing latency, and they are even able to operate reliably in extended offline periods. No matter which definition of hybrid cloud you use, the benefits are the same: When computing and processing demand increases beyond an on-premises datacenter’s capabilities, businesses can use the cloud to instantly scale capacity up or down to handle excess capacity. It also allows them to avoid the time and cost of purchasing, installing, and maintaining new servers that they may not always need.

Multicloud computing refers to the use of multiple cloud computing services from more than one cloud provider—including private and public clouds—in a heterogeneous environment. A multicloud strategy provides greater flexibility and mitigates risk. Choose services from different cloud providers best suited for a specific task, or take advantage of services offered by a particular cloud provider in a specific location.

## Hybrid and Multicloud narrative

This scenario follows a common narrative & helps the reader understand what they will have to do differently to be successful. This is not limited to a single Cloud Adoption Framework (CAF) methodology, but instead looks at the overall adoption journey.

A hybrid cloud platform gives organizations many advantages—such as greater flexibility, more deployment options, security, compliance, and getting more value from their existing infrastructure. When computing and processing demand fluctuates, hybrid cloud computing gives businesses the ability to seamlessly scale up their on-premises infrastructure to the public cloud to handle any overflow—without giving third-party datacenters access to the entirety of their data. Organizations gain the flexibility and innovation the public cloud provides by running certain workloads in the cloud while keeping highly sensitive data in their own datacenter to meet client's specific needs or regulatory requirements.

This not only allows companies to scale computing resources— it also eliminates the need to make massive capital expenditures to handle short-term spikes in demand, as well as when the business needs to free up local resources for more sensitive data or applications. Companies will pay only for resources they temporarily use instead of having to purchase, program, and maintain additional resources and equipment that could remain idle over long periods of time.

However, as companies spread resources across on-premises, multiple clouds, and the edge, we often hear customers have four common needs:

1. They need to have visibility into the health of all their existing as well as future infrastructure and applications in a single pane of glass. 
2. From an IT point of view, while organizations understand the need for implementing a governance standard, they find it hard to integrate on-premises policies and updates with their cloud infrastructure.
3. Since there are often different app development teams in the organization, there exists a wide range of skills across on-premises and cloud. Customers are looking for consistent inter-operability between the two so they can unify development practices.
4. They also want to manage their security posture, without changing too much on their current operations. Cloud and multicloud compounds this challenge which can decrease trust and increase apprehension.

Cloud services are often thought of only in the context of moving data and applications to the public cloud. Scenarios where customers operate in highly regulated industries (e.g. government infrastructure, healthcare, financial services) where both internal and customer data must remain within the boundaries of on-premises datacenters, data latency sensitivity requires compute to be close to source data in on-premises datacenters, or when Internet connectivity disruptions have critical implications or are expected can prevent the use of the public cloud for some workloads. In these scenarios, hybrid solutions that bring cloud services, decreased management overhead, and the cloud billing model can be deployed in on-premises datacenters.

## Hybrid and Multicloud motivations

As a true enterprise-grade cloud provider, Azure is able to support your business objectives across public, hybrid, and multicloud environments. This article series will discuss different best practices that can help facilitate a variety of cloud mixes ranging from 100% Azure environments to environments that have little (or no) Azure infrastructure in place.

We recognize that there are many valid reasons for customers to choose to distribute their digital estate across hybrid and multicloud environments. The following are a few common business drivers:

- Minimize or avoid single cloud provider lock-in
- Business units, subsidiaries or acquired companies have already adopted different cloud platforms
- Different cloud providers may have regulatory and data sovereignty requirements in different countries
- Improve business continuity and disaster recovery by duplicating workloads across two cloud providers
- Maximize performance by running applications close to user locations, which may require hybrid or multicloud adoption
- Enable easy migration for some data platforms or industry-specific applications by adopting multicloud

## Hybrid and Multicloud concerns

Some of the motivations listed above can be easily accomplished with a sound hybrid and multicloud adoption strategy.

Others require significant effort pre- & post-deployment to realize those benefits. Cloud provider lock-in, for instance, is possible. But to avoid lock-in, organizations are required to limit their vision for cloud adoption. Many of the most beneficial products and features in a cloud provider are not portable to other cloud providers. To achieve portability and minimize lock-in, organizations are often required to limit cloud adoption to basic Infrastructure-as-a-Service (IaaS) or invest heavily in the use of cloud native technologies like Containers or Kubernetes.

Another commonly realized concern associated with hybrid and multicloud adoption comes after the workloads are released and are in production. When organizations attempt to provide operations management support to workloads in new environments, they often have to quickly rethink their practices. Existing operations management platforms were not build for these types of environments. Nor were most organizations' existing operations management policies and processes. To account for deviations in the cloud environments, companies often end up with distinct operations tooling and operations practices, this multiplies the cost of operations by the number of cloud environments supported.

## Next step: Minimize Hybrid and Multicloud concerns with unified operations

Before starting your hybrid and multicloud journey, it is important to understand the concept of unified operations. Consistent operations practices across all of your cloud environments with a common control plane, aids in addressing many of the concerns regarding and hybrid and multicloud.

Before proceeding with hybrid and multicloud adoption at scale, determine if you will duplicate operations for each cloud provider, or if you will need to implement a [unified operations approach to cloud management](./unified-operations.md).
