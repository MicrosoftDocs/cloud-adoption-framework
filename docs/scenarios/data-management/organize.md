---
title: "Organize people"
description: people
author: abdale
ms.author: hamoodaleem
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# DataOps Overview

The Enterprise Scale Analytics and AI architecture was designed with the following core principles in mind:

1. Self-Service Enablement: Enable project teams to work on their own in order to allow agile development methods.
2. Governance: Enforce guardrails on the whole Azure platform, in order to ensure that project teams are only allowed to see, change, and execute what they are supposed to.
3. Streamlined Deployments: Ensure that common policies are available and can be used across the organization to scale quickly and to enable teams which are not as experienced with some of core designs and artifacts.

The deployment process and Data Ops working model is an essential part and enable for some of these core principles. In order to fulfill these concepts, we prescribe the following design guidelines:

1. Use of Infrastructure as Code (IaC).
2. Deployment templates covering the core use cases within the company
3. Deployment process that includes a forking and branching strategy
4. Central repository and deployment of Data Management Landing Zone

A Platform Group team should be put in place to centrally govern the data platform infrastructure and not duplicate skills required to build and deploy common data infrastructure pieces required for the Data Management Landing Zone as well as the various Data Landing Zones.

The Platform Group team can build, own, and provide the necessary agnostic technology that the Data Integration and Data Products need to capture, process, store, and serve their datasets.

The team should provide the services in a self-service manner, which should include tools for big data storage, data product versioning, data pipeline implementation and orchestration, data de-identification, etc. This is key to remove bottlenecks in the workflow and reduce the lead time to create new Data Products.

The Platform Group team should follow existing best practices outlined in this section to achieve their objective.

Other data product teams should also use the following best practices for proper testing and automation.
