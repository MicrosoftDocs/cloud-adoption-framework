---
title: Azure landing zones for the retail industry
description: Learn how to prepare Microsoft Azure environments for retail industry cloud adoption using Azure landing zones.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal, e2e-retail
---

# Azure landing zones for the retail industry

The [Ready methodology](../../ready/index.md) in the Cloud Adoption Framework for Azure guides the creation of Azure environments using [Azure landing zones](../../ready/landing-zone/index.md). Azure landing zones give you many [implementation options](../../ready/landing-zone/implementation-options.md) built around a set of [common design areas](../../ready/landing-zone/design-areas.md).

Azure landing zones allow you to start with a small implementation and expand over time. For more sophisticated environments, you can start with enterprise-scale implementation options. The variety of implementation options ensure that you can start with an Azure environment that meets your short term needs. Over time, these same environments can be extended to meet your long term operational needs.

## Organizational alignment impact

For retail companies, IT operations are heavily influenced by the company's historical growth patterns. Specifically, the impact those growth patterns have had on your organizational structures across your technology teams. To understand how this influences operations management, see [Initial organizational alignment](./organize.md#common-growth-patterns-for-retailers).

- Will central IT, a cloud center of excellence (CCoE), or other forms of centralized operations be responsible for operating all workloads?
- Does your strategy and plan require your brick and mortar locations to be integrated into your cloud environment?
- Does your strategy and plan include any deployments that require adherence to regulatory compliance standards, such as the Payment Card Industry Data Security Standard (PCI DSS)?

## Operating model alignment

Do you plan to enable enterprise operations, and need to enable a separation of duties between IT and workload teams? Then the enterprise-scale implementation options might work best to accelerate your environmental configuration.

If you plan to focus on central operations, the *start small* approach might be a better implementation option. With this approach, make sure you execute the [Govern methodology](./govern.md) and [the Manage methodology](./manage.md) in parallel with your cloud adoption plan.

## Network: Branch strategy

Connectivity to your edge locations, specifically brick and mortar retail locations, might be a part of your cloud adoption plan. In that plan, an understanding of [perimeter networks](../../ready/azure-best-practices/perimeter-networks.md) is a required part of your overall Azure landing zone strategy.

Consider traffic patterns, advanced security controls, and other practices in addition to perimeter network connections. It's easier to deploy these practices using an enterprise-scale landing zone implementation option from the Azure landing zones.

## Compliance: PCI DSS

Your retail organization might require compliance with Payment Card Industry data security standards [PCI DSS](/azure/compliance/offerings/offering-pci-dss). But PCI DSS is just one example of the compliance requirements commonly seen in retail cloud adoption requirements.

Your cloud adoption strategy and plan might require adherence to regulatory compliance standards. If so, review the compliance section of the [governance for retail](./govern.md) article before deploying your Azure landing zones.

## Next steps

The following articles can guide your cloud adoption journey and help you succeed in the cloud adoption scenario.

- [Cloud adoption plan for the retail industry](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate common retail industry technologies](./migrate.md)
- [Innovation in the retail industry](./innovate.md)
- [Governance in the retail industry](./govern.md)
- [Management in the retail industry](./manage.md)