---
title: Governance for the retail industry
description: Learn how to use the Cloud Adoption Framework methodology to improve governance of your cloud portfolio for the retail industry.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal, e2e-retail
---

# Governance for the retail industry

Use the [Cloud Adoption Framework methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio across the five governance disciplines pictured below. This article refines the methodology for governance needs specific to the retail industry.

![Screenshot of the Cloud Adoption Framework governance model](../../_images/operational-transformation-govern-large.png)

When developing your cloud governance strategy, follow the approach in the standard methodology. Use this article for potential additions to accelerate or extend your cloud governance capabilities for retail.

## Governance for hybrid and multicloud assets

Aside from online-only retailers, retail organizations operate from several distributed physical locations to deliver brick and mortar retail. Because of latency limitations, those locations can contain technology assets. You need to govern, operate, and secure those assets to help protect your business from risks.

Your governance strategy might require distributed governance, but that might not be a part of your cloud adoption strategy. Does your cloud adoption strategy include digital transformation for [supply chain optimization](./retail-supply-chain-optimization.md), [building management optimization](./retail-building-management-optimization.md), or in-store experience for your customers?

If you have distributed locations and need to drive a cloud adoption strategy for assets in those locations, consider a unified operations strategy. This strategy can deliver governance and operations across public cloud, private cloud, and edge locations. For more information, see [Introduction to unified operations](../../scenarios/hybrid/unified-operations.md).

## Compliance with payment card standards

Most retail organizations require compliance with Payment Card Industry data security standards (PCI DSS) to process credit cards. For more information, see [PCI DSS](/azure/compliance/offerings/offering-pci-dss).

Microsoft Azure maintains PCI DSS validation, which can make it easier to govern PCI DSS compliant deployments in the cloud. For more information, see [Azure and PCI DSS](/azure/compliance/offerings/offering-pci-dss#azure-and-pci-dss). Your organization also shares in responsibilities to fully comply with PCI DSS standards.

If your cloud deployments require PCI DSS compliance, review the [control mapping of PCI DSS v3.2.1](/azure/governance/blueprints/samples/pci-dss-3.2.1/control-mapping). You can deploy the blueprint sample and assign it to specific Azure environments. It can automate many of the required PCI controls. For more information, see [Deploy the PCI DSS v3.2.1 blueprint sample](/azure/governance/blueprints/samples/pci-dss-3.2.1/deploy).

For compliance standards that have been automated in a similar Azure blueprint approach, see [Azure blueprint samples](/azure/governance/blueprints/samples/). If you prefer to work with built-in Azure Policy initiatives, see [Regulatory compliance built-ins in Azure Policy](/azure/governance/policy/samples/iso-27001).

## Next steps

The following article provides guidance to help you succeed in the cloud adoption scenario:

- [Management in the retail industry](./manage.md)
