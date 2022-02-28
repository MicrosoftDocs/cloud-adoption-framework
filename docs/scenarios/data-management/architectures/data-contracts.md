---
title: Data contracts
description: Data contracts in a data mesh
author: simonlid
ms.author: simonlid
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data contracts

## Background

With the distributed nature of a data mesh implementation and the dependencies that will be created between the data products special considerations needs to be taken around how the different data products are allowed to create dependencies between them.

One way to address this is through the implementation of data contracts. This is a concept that comes from the software development world where it is used when building micro-services using API's. In this world a contract describes how the API is working and what the expected output is. This allows users of the API to take a predictable dependency on that code.

Something similar needs to exist between the data producers and consumers in the data mesh world. Otherwise it is easy to get into a situation when dependencies are unmanageable and data products cannot be trusted.

## Implementing data contracts

### Documentation

To document a data product there needs to be a clear description on were the data is sourced from, what transformations that been applied to the data and how it will be delivered. The contract should also describe how the data can be used. For example, the product might only be used for development, testing or production.

Another aspect that needs to be part of the data contract documentation is the terms of service and service-level agreement (SLA). A good SLA typically describes the quality of data delivery and interface. This part of the SLA might include uptime, error rates, and availability. It could also include deprecation, a roadmap, and version numbers.

### Versioning

To allow data products to change over time versioning is strongly recommended. You also need to manage the compatibility and deployment of your data products. Without versioning reusability will be low and changes to a data product will break the dependent products if the any of their dependencies are changed.

### Lineage and dependencies

Having a clear understanding on how data is used across the entire federated platform is important. This includes the ability to discover the data products within the platform. Implementing data catalog product such as [Azure Purview](https://docs.microsoft.com/en-us/azure/purview/) can help with both the discoverability and the ability to discover linage and dependencies. However, contracts and dependencies between data products also need to be discoverable. This can be implemented using source control where both data contracts and data consumption can be documented.

## Summary

With the implementation of a mesh based data architecture you can enable extensive data reuse within an organization. But without clear contracts, discoverable meta data and versioning the reuse can become an issue. Implementing systems that allows users to create and document data contracts, discover data contracts will help building trusted data products that will deliver value to an organization.
