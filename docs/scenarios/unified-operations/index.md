---
title: "Introduction to the Hybrid and Multicloud scenario"
description: Describe the scenario
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Hybrid and Multicloud

This series of articles in the Cloud Adoption Framework outline the scenario of Hybrid and Multicloud to guide your holistic cloud adoption journey.

## Executive Scenario

Michael to fill in information outlining why this scenario is important.

## Hybrid and Multicloud definitions

A hybrid cloud is a type of cloud computing that combines on-premises infrastructure—or a private cloud—with a public cloud. Hybrid clouds allow data and apps to move between the two environments. Many organizations choose a hybrid cloud approach due to business imperatives such as meeting regulatory and data sovereignty requirements, taking full advantage of on-premises technology investment, or addressing low latency issues.
The hybrid cloud is evolving to include edge workloads as well. Edge computing brings the computing power of the cloud to IoT devices—closer to where the data resides. By moving workloads to the edge, devices spend less time communicating with the cloud, reducing latency, and they are even able to operate reliably in extended offline periods.

Unified operations is an enterprise control plane that provides operations management control across hybrid solutions.For customers running workloads in multiple locations, whether their datacenter, other clouds, or at the edge, there is a common need to get control over resources at the organizaional, team, and personal levels. By bringing all your resources into a single system, you can organize and inventory through a variety of Azure scopes, such as Management Groups, Subscriptions, and Resource Groups. Unifying operations under a single control plane, like Azure Arc, allows customers to: 
- Extend cloud pratices on premise 
- Easily implement Azure security anywhere 
- Integrate DevOps and management capabilities 
- Streamline governance and configuration on Kubernetes apps, data, and infrastructure anywhere 

## Hybrid and Multicloud narrative

This scenario follows a common narrative & helps the reader understand what they will have to do differently to be successful. This is not limited to a single CAF methodology, but instead looks at the overall adoption journey.

A hybrid cloud platform gives organizations many advantages—such as greater flexibility, more deployment options, security, compliance, and getting more value from their existing infrastructure. When computing and processing demand fluctuates, hybrid cloud computing gives businesses the ability to seamlessly scale up their on-premises infrastructure to the public cloud to handle any overflow—without giving third-party datacenters access to the entirety of their data. Organizations gain the flexibility and innovation the public cloud provides by running certain workloads in the cloud while keeping highly sensitive data in their own datacenter to meet client needs or regulatory requirements.

This not only allows companies to scale computing resources— it also eliminates the need to make massive capital expenditures to handle short-term spikes in demand, as well as when the business needs to free up local resources for more sensitive data or applications. Companies will pay only for resources they temporarily use instead of having to purchase, program, and maintain additional resources and equipment that could remain idle over long periods of time.

However, as companies spread resources across on-premises, multiple clouds, and the edge, we often hear customers have three common needs: 
1. They need to have visibility into the health of all their existing as well as future infrastructure and applications in a single pane of glass. 
2. From an IT point of view, while organizations understand the need for implementing a governance standard, they find it hard to integrate on-premises policies and updates with their cloud infrastructure. 
3. Since there are often different app development teams in the organization, there exists a wide range of skills across on-premises and cloud. Customers are looking for consistent inter-operability between the two so they can unify development practices.

Now, let’s also consider the deployment of cloud native services. Some customers operate in highly regulated industries (e.g. government infrastructure, healthcare, financial services) where both internal and customer data are deemed critical and must remain within the boundaries of on-premises datacenters. There could also be a need for latency requirements where the data processing needs to happen close to the source of data while minimizing disruptions that may arise from internet connectivity issues. Another common scenario is that customers don’t want the management overhead of maintaining these services on-premises and would like to flip to a cloud billing model.

## Next step: Integrate Hybrid and Multicloud into your cloud adoption journey

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Strategy for Hybrid and Multicloud](./strategy.md)
- [Plan for Hybrid and Multicloud](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Hybrid and Multicloud migration assessment](./migrate-assess.md)
- [Hybrid and Multicloud migration](./migrate-deploy.md)
- [Release Hybrid and Multicloud architectures to production](./migrate-release.md)
- [Innovate with Hybrid and Multicloud](./innovate.md)
- [Govern](./govern.md)
- [Manage](./manage.md)
