---
title: Architectures overview
description: Learn about cloud-scale analytics architectures in Azure.
author: mboswell
ms.author: mboswell
ms.date: 03/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Architectures overview

Before you start to build out the data architectures of your cloud-scale analytics framework, review the articles in the following table.

[!INCLUDE [documentation-sections](../includes/documentation-sections.md)]

## Physical architecture

The physical implementation of cloud-scale analytics consists of two main architectures: the [data management landing zone](../../data-management/architectures/data-management-landing-zone.md) and [data landing zone](../../data-management/architectures/data-landing-zone.md).

## Data applications

[Data applications](../../data-management/architectures/data-landing-zone-data-products.md) are a core concept for delivering a data product and can be aligned to both lakehouse and data mesh patterns.

## Cloud-scale analytics

You can [scale](scale-architectures.md) your cloud-scale analytics deployment by using multiple data landing zones.

## Data mesh

Implement [data mesh](what-is-data-mesh.md) by using cloud-scale analytics. Although most cloud-scale analytics guidance applies, there are some differences to be aware of for data domains, self-serve data platforms, onboarding data products, governance, data marketplace, and data sharing.

## Deployment templates for cloud-scale analytics

The following table lists reference templates that you can deploy.

[!INCLUDE [deployment-templates-table](../includes/deployment-templates-table.md)]

## Connect to environments privately

The reference architecture is secure by design. It uses a multilayered security approach to overcome common data exfiltration risks.

The most simple security solution is to [host a jumpbox](../../data-management/architectures/connect-to-environments-privately.md#about-azure-bastion-host-and-jumpboxes) on the virtual network of the data management landing zone or data landing zone to connect to the data services through private endpoints.

## Frequently asked questions

For a list of questions and answers about cloud-scale analytics, see [Frequently asked questions](../../data-management/architectures/frequently-asked-questions.md).

## Next steps

[Cloud-scale analytics data management landing zone overview](../../data-management/architectures/data-management-landing-zone.md)
