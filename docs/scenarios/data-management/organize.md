---
title: Understand how to organize Data Operations team members for enterprise scale analytics and AI in Azure
description: Learn how to organize Data Operations team members for enterprise scale analytics and AI in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 07/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand how to organize Data Operations team members for enterprise scale analytics and AI in Azure

The enterprise scale analytics and AI architecture was designed with the following core principles:

1. Self-service enablement: Enable project teams to work on their own to allow agile development methods.

1. Governance: Enforce guard rails across the Azure platform to ensure that project teams only see, change, and execute the functions within their permissions.

1. Streamlined deployments: Ensure that common policies are available within the organization to help teams scale quickly and support teams with less experience in some core designs and artifacts.

The deployment process and data operations (DataOps) model is an essential part that supports some of these core principles. We recommend the following design guidelines to fulfill these concepts:

1. Using infrastructure as code, IaC
2. Deploying templates that cover core use cases within the company
3. Following a deployment process that includes a strategy for GitHub forks and branches
4. Maintaining a central repository and deploying data management landing zones

 Contributors with identifiable and individual skills should establish a Platform group to centrally govern data platform infrastructure and build and deploy common data infrastructure pieces for the data management landing zone, plus various data landing zones. The Platform group can also build, own, and provide agnostic technology that helps data integration and data products teams to capture, process, store, and maintain their datasets.

The team should present its services in a self-service manner, which can include tools for storing big data, versioning product data, organizing/implementing the data pipeline, de-identifying data, and more. These types of tools are key to minimizing bottlenecks in the workflow and reducing lead time for creating new data products.

The Platform group should follow the best practices outlined in this section to achieve their objectives. Other data product teams should use the following best practices to test and automate their data.
