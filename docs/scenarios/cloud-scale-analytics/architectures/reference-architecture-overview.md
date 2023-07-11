---
title: Overview of reference architectures for cloud-scale analytics in Azure
description: Understand various reference architectures for cloud-scale analytics in Azure.
author: AnalyticJeremy
ms.author: jepeach
ms.date: 11/25/2021
ms.topic: conceptual
ms.subservice: scenario
ms.custom: think-tank, e2e-data-management
---

# Overview of reference architectures for cloud-scale analytics in Azure

Cloud-scale analytics is designed to be modular. It allows customers to start with a small footprint and grow over time. Customers should decide ahead how to organize data domains across data landing zones. The building blocks can be deployed through the Azure portal, GitHub Actions workflows, and Azure Pipelines. The template repositories for the data management landing zone, data landing zone, and data integrations/products contain sample YAML pipelines to help you get started faster with setting up your environments.

> [!NOTE]
> The template repositories can be used to deploy the reference architectures listed in this article. Links to these repositories are provided in the detailed description of each architecture.

## Reference architectures examples

The following architecture examples can help you to adapt cloud-scale analytics to your use case.

| Scenario                                     | Example customer                                       | Description                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------------------------------------|--------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Single data landing zone                     | [Adatum Corporation](reference-architecture-adatum.md) | This reference architecture is ideal for customers that have identified a unit of their business that's ready to deploy analytics workloads to Azure. This architecture deploys a single landing zone that can be used by the business unit to manage their data estate. It provides the flexibility to add more landing zones for other business units when they're ready to move to Azure. |
| Multiple data landing zones                  | [Relecloud](reference-architecture-relecloud.md)       | This reference architecture is relevant to customers that have already implemented a basic version of cloud-scale analytics and are now ready to host a new business that modernizes its analytics operations. It demonstrates a more complex scenario with multiple landing zones, data integrations, and data products.                                                                    |
| Highly sensitive data landing zones          | [Lamna Healthcare](reference-architecture-lamna.md)    | This reference architecture is for customers that want to use cloud-scale analytics not only for scalability but also to secure their data. It demonstrates how access to sensitive data can be controlled and how appropriately desensitized data can be shared with analysts.                                                                                                              |
| Financial institution scenario for data mesh | [Woodgrove Bank](data-mesh-scenario.md)  | This reference architecture is written for customers that want to use cloud-scale analytics for a data mesh analytical data architecture and operating model. It demonstrates a more complex scenario with multiple landing zones, data integrations, and data products.                                                                                                                                          |

## Next steps

- [Single data landing zone scenario](./reference-architecture-adatum.md)
- [Multiple data landing zones scenario](reference-architecture-relecloud.md)
- [Highly sensitive data landing zones scenario](reference-architecture-lamna.md)
- [Financial institution scenario for data mesh](data-mesh-scenario.md)
