---
title: What is a landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- markdownlint-disable MD026 -->

# What is a landing zone?

A properly configured cloud environment can become a blocker to cloud adoption efforts. Fundamental environment configuration can add a learning curve for team members and require changes to aspects of operations, security, governance, and compliance. Deployment of descrete purpose built landing zones help flatten those curves to help the team stay safely on track with adoption plans. This article will define the term _landing zone_ and create clarity on the importance of landing zones. Other articles in this series will guide the creation and deployment of landing zones.

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4xdvm]

<!-- markdownlint-enable MD034 -->

## Defining Azure landing zones

A _landing zone_ is a segment of a cloud environment that is dedicated to the support of **one or more workloads**. Landing zones provide access to foundational tools and controls to establish a compliant place to innovate & build new workloads in the cloud, or to migrate existing workloads to the cloud. Landing zones use defined sets of cloud services and best practices to set you up for success. 

More specifically, a landing zone is the basic building block for any customer who centrally operates a large or complex portfolio of workloads. For larger customers or more complex adoption plans, the term _landing zone_ refers to a logical construct that enables workloads to co-exist on top of a _platform foundation_. Together, landing zones and the platform foundation capture everything that must be in place and ready to enable cloud adoption across the IT portfolio.

**Goal:** Cloud adoption teams focus on deploying well-architected workloads. Landing zones scale a subset of the same well-architected concepts to ensure they are consistently applied across all workloads in the cloud portfolio. This approach reduces some of the burden on cloud adoption teams by creating guardrails which include centralized solutions for cost optimization, performance efficiency, reliability, security, and operational excellence. Landing zones don't eliminate the effort required to deploy well-architected workloads, but these centralized solutions can automate application of many of the common best practices.

## Next steps

Before choosing a deployment option for your Azure landing zone, it is important to [understand Microsoft's recommended design principles for landing zones](./design-principles.md).

> [!div class="nextstepaction"]
> [Review design principles](./design-principles.md)
