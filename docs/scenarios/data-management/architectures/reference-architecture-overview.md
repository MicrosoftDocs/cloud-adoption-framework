---
title: Overview of reference architectures for cloud adoption framework for data management and analytics
description: Learn about different types of reference architectures for cloud adoption framework for data management and analytics
author: AnalyticJeremy
ms.author: jepeach
ms.date: 09/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Overview of reference architectures for cloud adoption framework for data management and analytics

The cloud adoption framework for data management and analytics is modular by design. It allows customers to start with a small footprint and grow over time. Customers should decide upfront how they want to organize data domains across data landing Zones. All the building blocks can be deployed through the Azure portal and through GitHub Actions workflows and Azure Pipelines. Our **template repositories** for the Data Management Landing Zone, Data Landing Zone, and Data Integrations/Products contain sample YAML pipelines to more quickly get started with the setup of the environments.

> [!NOTE]
> The template repositories can be used to deploy the below reference architectures. Links to the relevant repositories are provided in the detailed description of each of the reference architectures.

## Reference architectures examples

To enable deeper understanding of implementing the cloud adoption framework for data management and analytics we have provided three example architectures, which show how you can adapt this framework for your use case.

## Adatum Corporation scenario

This reference architecture is ideal for customers that have identified a unit of their business that is ready to deploy analytics workloads to Azure.  This architecture deploys a single landing zone that can be used by the business unit to manage their data estate.  It provides the flexibility to add more landing zones for other business units when they are ready to move to Azure.

## Relecloud scenario

This reference architecture is relevant to customers that have already implemented a basic version of enterprise-scale for analytics and AI and are now ready to host a new business unit that is modernizing its analytics operations.  It demonstrates a more complex scenario with multiple landing zones, multiple data integrations, and multiple data products.

## Lamna Healthcare scenario

This reference architecture is written for customers that want to use enterprise-scale for analytics and AI not only for scalability but also for security of their data.  It demonstrates how access to sensitive data can be controlled and how appropriately desensitized data can be shared with analysts.

## Next Steps

[Learn about Adatum Corporation scenario](reference-architecture-adatum.md)
[Learn about Relecloud scenario](reference-architecture-relecloud.md)
[Learn about Lamna Healthcare](reference-architecture-lamna.md)
