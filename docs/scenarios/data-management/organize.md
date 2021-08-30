---
title: Understand how to organize data operations team members for the data management and analytics scenario in Azure
description: Learn how to organize data operations team members for the data management and analytics scenario in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand how to organize data operations team members for the data management and analytics scenario in Azure

The data management and analytics scenario architecture was designed with a set of core principles.

## Core principles

- **Self-service enablement:** enable project teams to work on their own to allow agile development methods.

- **Governance:** enforce guardrails across the Azure platform to ensure that project teams only see, change, and execute the functions within their permissions.

- **Streamlined deployments:** ensure that common policies are available within the organization to help teams scale quickly and support teams with less experience in some core designs and artifacts.

## Deployment and operations

The deployment process and data operations (DataOps) model is an essential part that supports some of these core principles. The following guidelines are recommended for organizations to align with the principles:

- Use infrastructure as code.
- Deploy templates that cover core use cases within the company.
- Follow a deployment process that includes a strategy for GitHub forks and branches.
- Maintain a central repository and deploying data management landing zones.

Contributors with identifiable and individual skills should establish a platform group to centrally govern data platform infrastructure and build and deploy common data infrastructure pieces for the data management landing zone, plus various data landing zones. The platform group can also build, own, and provide agnostic technology that helps data integration and data product teams to capture, process, store, and maintain their datasets.

The team should present its services in a self-service manner, which can include tools for storing big data, versioning product data, organizing/implementing the data pipeline, de-identifying data, and more. These types of tools are key to minimizing bottlenecks in the workflow and reducing lead time for creating new data products.

The platform group should follow the best practices outlined in this section to achieve their objectives. Other data product teams should use the best practices in the forthcoming articles to test and automate their data.

## Next steps

[Organize for effective data operations](./organize-data-operations.md)
