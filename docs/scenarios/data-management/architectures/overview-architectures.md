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

In the previous sections, we've covered cloud-scale analytics areas that you should consider before building out your first architecture.

[!INCLUDE [documentation-sections](../includes/documentation-sections.md)]

## Physical architecture

This section focuses on the details of a physical implementation of cloud-scale analytics. It maps out the physical architectures of [data management landing zone](data-management-landing-zone.md) and [data landing zone.](data-landing-zone.md).

## Data applications

[Data applications](data-landing-zone-data-products.md) are a core concept of delivering a data product and can be aligned to both lakehouse and data mesh pattern.

## Scaling Cloud-scale analytics

Cloud-scale analytics is scalable and [Scaling Cloud-scale analytics](scaling-architectures.md) addresses how to think about the number of data management landing zones you'll require.

## Data mesh

[Data mesh](what-is-data-mesh.md) can be implemented using cloud-scale analytics.

Whilst most cloud-scale analytics guidance applies, there are some differences that need to be taken into account. We highlight the data mesh specific for data domains, self-serve, onboarding data products, governance, data marketplace, data sharing and operating model.

## Deployment templates for cloud-scale analytics

This section includes many reference templates that can be deployed.

[!INCLUDE [deployment-templates-table](../includes/deployment-templates-table.md)]

## Connect to environments privately

The reference architecture is secure by design. It uses a multilayered security approach to overcome common data exfiltration risks that are raised by customers.

This article on how to [connect to environments privately](connect-to-environments-privately.md) via Azure Bastion host and jump boxes.

## Frequently asked questions

As we learn, we continue to put curate [Frequently asked questions](frequently-asked-questions.md) for others to access.

## Next steps

[Overview of the data management landing zone](data-management-landing-zone.md)
