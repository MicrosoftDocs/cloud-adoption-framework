---
title: Deployment templates for cloud-scale analytics deployments
description: Learn about the core starter templates for cloud-scale analytics deployments.
author: mboswell
ms.author: mboswell
ms.date: 02/28/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-data-management
---

# Deployment templates for cloud-scale analytics

Cloud-scale analytics has the following core starter templates:

[!INCLUDE [deployment-templates-table](../../cloud-scale-analytics/includes/deployment-templates-table.md)]

## Cost estimates

We have provided links to the official cost calculator, where users can make changes depending on the expected amount of data and data throughput. All cost calculations specify a *base cost* of cloud-scale analytics for Cloud Adoption Framework for Azure. Base cost can be defined as the cost that occurs if no data workloads run inside the respective subscriptions.

### Data management landing zone costs

In a production scenario, we recommend that you rely on the Azure Firewall and private DNS zones that are hosted in the connectivity hub of [Azure landing zones](https://github.com/Azure/Enterprise-Scale). In minimal viable products, you can rely on the Azure Firewall and private DNS zones that are bundled with Cloud Adoption Framework cloud-scale analytics. Therefore, we provide the following two different cost calculations:

- [Calculation 1: Pricing calculator - data management landing zone without Azure Firewall and private DNS zones](https://azure.com/e/ebb7508a6d78487b9a1583878d0948cc)
- [Calculation 2: Pricing calculator - data management landing zone with Azure Firewall and private DNS zones](https://azure.com/e/658478643d4b46fdbf8b1972c4b0704b)

Keep in mind that the following services aren't listed in the overview, because they're either not available in the official pricing calculator or the pricing calculator doesn't allow you to set the compute hours to 0:

- Azure Purview
- Synapse Private Link hub
- Route table
- Network security group

### Data landing zone costs

For data landing zones, refer to the following cost calculation:

- [Pricing calculator - data landing zone](https://azure.com/e/55cb6feafcc24cec8cfeb10486d54ab5)

You can further reduce the cost by hosting the self-hosted integration runtime (SHIR) on-premises instead of hosting it on a virtual machine scale set.

Keep in mind that the following services aren't listed in the overview, because they're either unavailable in the official pricing calculator or the pricing calculator doesn't allow you to set the compute hours to 0:

- Azure Databricks
- Route table
- Network security group

## Next steps

[Solution accelerators for cloud-scale analytics](../../cloud-scale-analytics/architectures/solution-accelerators.md)
