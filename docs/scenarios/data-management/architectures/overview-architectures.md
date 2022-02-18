---
title: Data management and analytics architecture overview in Azure
description: Learn about Data management and analytics architecture overview in Azure
author: mboswell
ms.author: mboswell
ms.date: 02/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Architectures Overview

In the previous sections, we've covered the data management and analytics scenario areas which you should consider before building out your first architecture.

| Section                         | Description                                                                                                                                                                                                            |
|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [**Building an Initial Strategy**](../strategy.md)| How to build out your data strategy and pivot to becoming a data driven organization
| [**Defining your plan**](../plan.md)        | How to develop a plan for data management and analytics                                                                                                                                                                    |
| [**Preparing analytics estate**](../ready.md)  | Overview of data management and data landing zones with key design area considerations such as enterpriser enrollment, networking, identity and access management, policies and business continuity and disaster recovery. |
| [**Govern your analytics**](../govern.md)      | Requirements for governing data, data catalog, lineage, master data management, data quality, data sharing agreements and metadata                                                                                         |
| [**Secure you analytics estate**](../secure.md) | How to security your analytics estate with authentication and authorization, data privacy and data access management                                                                                                       |
| [**Organize people and teams**](../organize.md)   | How do you organize for effective operations, roles and teams, team functions                                                                                                                                              |
| [**Manage your analytics estate**](../eslz-platform-automation-and-devops.md)| How do you provision the platform and the observability should you put in place for the scenario?                                                                                                                          |

## Physical architecture

This section focuses on the details of a physical implementation of the data management and analytics scenario. It maps out the physical architectures of [data management landing zone](data-management-landing-zone.md) and [data landing zone.](data-landing-zone.md).

## Data applications

[Data applications](data-landing-zone-data-products.md) are a core concept of delivering a data product and can be aligned to both lakehouse and data mesh pattern.

## Scaling Data management and analytics scenario

The data management and analytics scenario is scalable and [Scaling Data management and analytics scenario](scaling-architectures.md) addresses how to think about the number of data management landing zones you'll require.

## Data mesh

[Data mesh](what-is-data-mesh.md) can be implemented using the data management and analytics scenario.

Whilst most the data management and analytics scenario guidance applies, there are some difference which needs to be taken into account. We highlight the data mesh specific for data domains, self-serve, onboarding data products, governance, data marketplace, data sharing and operating model.

## Deployment templates for data management and analytics scenario

This section includes many reference templates that can be deployed.

[!INCLUDE [deployment-templates-table](../includes/deployment-templates-table.md)]

## Connect to environments privately

The reference architecture is secure by design. It uses a multilayered security approach to overcome common data exfiltration risks that are raised by customers.

This article on how to [connect to environments privately](connect-to-environments-privately.md) via Azure Bastion host and jump boxes.

## Frequently asked questions

As we learn, we continue to put curate [Frequently asked questions](frequently-asked-questions.md) for others to access.

## Next steps

[Overview of the data management landing zone](data-management-landing-zone.md)
