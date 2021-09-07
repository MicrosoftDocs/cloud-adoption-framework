---
title: Enterprise-scale for analytics and AI data integrations in Azure
description: Learn about enterprise-scale for analytics and AI data integrations in Azure.
author: mboswell
ms.author: mboswell
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---


# Enterprise-scale for analytics and AI reference architectures

## Objectives

Built on top of the enterprise-scale architecture, [enterprise-scale for analytics and AI](/azure/cloud-adoption-framework/scenarios/data-management/enterprise-scale-landing-zone) provides a prescriptive data platform design coupled with Azure best practices and design principles. These principles serve as a compass for subsequent design decisions across critical technical domains. The architecture will continue to evolve alongside the Azure platform and is ultimately driven by the various design decisions that organizations must make to define their Azure data journey.

The Enterprise-Scale Analytics architecture consists of two core building blocks:

- Data Management Landing Zone which provides all data management and data governance capabilities for the data platform of an organization.
- Data Landing Zone which is a logical construct and a unit of scale in the Enterprise-Scale Analytics architecture that enables data retention and execution of data workloads for generating insights and value with data.

## Deploying enterprise-scale for analytics and AI in your own environment

The enterprise-scale for analytics and AI architecture is modular by design and allows customers to start with a small footprint and grow over time. Customers should decide upfront how they want to organize data domains across Data Landing Zones. All enterprise-scale for analytics and AI architecture building blocks can be deployed through the Azure Portal as well as through GitHub Actions workflows and Azure DevOps Pipelines. Our **template repositories** for the Data Management Landing Zone, Data Landing Zone and Data Integrations/Products contain sample YAML pipelines to more quickly get started with the setup of the environments.

> [!NOTE]
> The template repositories can be used to deploy the below reference architectures. Links to the relevant repositories are provided in the detailed description of each of the reference architectures.

### Reference architectures

| Reference architecture | Description | Link |
|:-------------------------|:------------|:----|
| Adatum Corporation       | Beginning architecture with one data landing zone |[Detailed description](./docs/reference/adatum/README.md) |
| Relecloud                | Multiple landing zones scenario                            |[Detailed description](./docs/reference/relecloud/README.md) |
| Lamna Healthcare       | Sensitive data scenario                                   |[Detailed description](./docs/reference/lamna/README.md) |
