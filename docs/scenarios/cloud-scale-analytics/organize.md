---
title: Organize data operations team members for Cloud-scale analytics in Azure
description: Learn how to organize data operations team members for Cloud-scale analytics in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Organize data operations team members

Cloud-scale analytics architecture was designed with a set of core principles.

## Core principles

- **Self-service enablement:** Enable project teams to work on their own to allow agile development methods.

- **Governance:** Enforce guardrails across the Azure platform to ensure that project teams only see, change, and execute the functions within their permissions.

- **Streamlined deployments:** Ensure that common policies are available within the organization to help teams scale quickly and support teams with less experience in some core designs and artifacts.

## Roles and teams

Across Cloud-scale analytics, we recommend moving away from horizontally siloed teams to agile vertical cross-domain teams. Data operations teams focus on driving governance at the control plane, while data application teams focus on creating data-as-a-product. This differentiation requires organizational changes to a pattern more aligned with application development. For example, each application has a product owner who scopes out requirements and works with a cross-domain team to deliver a product. In this case, the product is data for consumption.

For more information, see [Understand the roles and teams for cloud-scale analytics in Azure](../cloud-scale-analytics/organize-roles-teams.md)

## Deployment and operations

The deployment process and data operations (DataOps) model is an essential part that supports some of these core principles. The following guidelines are recommended for organizations to align with the principles:

- Use infrastructure as code.
- Deploy templates that cover core use cases within the company.
- Follow a deployment process that includes a strategy for GitHub forks and branches.
- Maintain a central repository and deploying data management landing zones.

Contributors with identifiable and individual skills should establish a platform group to centrally govern data platform infrastructure and build and deploy common data infrastructure pieces for the data management landing zone, plus various data landing zones. The platform group can also build, own, and provide agnostic technology that helps data application teams to capture, process, store, and maintain their data applications.

The platform group should present its services in a self-service manner, which can include tools for storing big data, versioning product data, organizing/implementing the data pipeline, de-identifying data, and more. These types of tools are key to minimizing bottlenecks in the workflow and reducing lead time for creating new data products.

The platform group should follow the best practices outlined in this section to achieve their objectives. Other data product teams should use the best practices in the forthcoming articles to test and automate their data.

For more information, see [DevOps automation for Cloud-scale analytics in Azure](../cloud-scale-analytics/manage.md)

## Next steps

[Understand the teams for cloud-scale analytics in Azure](../cloud-scale-analytics/organize-roles-teams.md)
