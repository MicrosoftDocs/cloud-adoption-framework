---
title: Architectures overview
description: Learn about cloud-scale analytics architectures in Azure
author: mboswell
ms.author: mboswell
ms.date: 03/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Architectures overview

Before you build out your first architecture, consider these cloud-scale analytics areas listed in the following table.

[!INCLUDE [documentation-sections](../includes/documentation-sections.md)]

## Physical architecture

The physical implementation of cloud-scale analytics consists of the physical architectures of the [data management landing zone](data-management-landing-zone.md) and [data landing zone](data-landing-zone.md).

## Data applications

[Data applications](data-landing-zone-data-products.md) are a core concept of delivering a data product and can be aligned to both lakehouse and data mesh patterns.

## Cloud-scale analytics

Cloud-scale analytics is scalable. [Scaling cloud-scale analytics](scaling-architectures.md) addresses how to think about the number of data management landing zones you require.

## Data mesh

[Data mesh](what-is-data-mesh.md) can be implemented by using cloud-scale analytics. Although most cloud-scale analytics guidance applies, there are some differences to take into account. We highlight the data mesh specific for data domains, self-serve, onboarding data products, governance, data marketplace, data sharing and the operating model.

## Deployment templates for cloud-scale analytics

The following table lists reference templates that you can deploy.

[!INCLUDE [deployment-templates-table](../includes/deployment-templates-table.md)]

## Connect to environments privately

The reference architecture is secure by design. It uses a multilayered security approach to overcome common data exfiltration risks.

The most simple solution is to [host a jumpbox](connect-to-environments-privately.md#about-azure-bastion-host-and-jumpboxes) on the virtual network of the data management landing zone or data landing zone to connect to the data services through private endpoints.

## Frequently asked questions

For a list of questions and answers about cloud-scale analytics, see [Frequently asked questions](frequently-asked-questions.md).

## Next steps

[Cloud-scale analytics data management landing zone overview](data-management-landing-zone.md)
