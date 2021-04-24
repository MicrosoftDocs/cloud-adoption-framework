---
title: "Governance in the Retail industry"
description: Describe the scenario's impact on Governance
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Governance for the Retail industry

The [Cloud Adoption Framework provides a methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio across five governance disciplines pictured below. This article refines that methodology by mapping governance to needs specific to the retail industry.

![Infographic of the Cloud Adoption Framework governance model](../../_images/operational-transformation-govern-large.png)

When developing your cloud governance strategy, follow the approach in the standard methodology. But consider the following topics as potential additions to accelerate or extend your cloud governance capabilities specific to retail.

## Governing hybrid and multicloud assets

Aside from a select few online-only retailers, it's safe to assume that retail organizations operate from a number of distributed physical locations to deliver brick & mortar retail. Due to latency limitations, it is also safe to assume that those locations contain technology assets that must be governed, operated, and secured to protect the business from unnecessary risks.

It may be safe to assume that distributed governance is a requirement of your governance strategy. But it may not be a part of your cloud adoption strategy. Does your cloud adoption strategy include efforts to deliver digital transformation associated with [Supply chain optimization](./retail-supply-chain-optimization.md), [Building management optimization](./retail-building-management-optimization.md), or the customers' in-store experience?

If you are responsible for distributed locations AND need to drive a cloud adoption strategy that impacts the assets in those locations, then you will likely need to consider a [unified operations strategy](../../scenarios/hybrid/unified-operations.md?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/industry/retail/toc.json) to deliver governance and operations across public cloud, private cloud, and edge locations.

## Compliance with Payment Card Industry (PCI) Data Security Standards (DSS)

Most retail organizations require compliance with [PCI-DSS standards](/azure/compliance/offerings/offering-pci-dss) in order to process credit cards. Microsoft Azure maintains a [PCI-DSS validation](/azure/compliance/offerings/offering-pci-dss#azure-and-pci-dss), which can make it easier to govern PCI-DSS compliant deployments in the cloud. But, your organization also shares in a number of responsibilities to fully comply with PCI-DSS standards.

If any of your cloud deployments require PCI-DSS compliance, review the [control mapping of PCI-DSS v3.2.1](/azure/governance/blueprints/samples/pci-dss-3.2.1/control-mapping) to better understand your responsibilities. The accompanying [blueprint sample](/azure/governance/blueprints/samples/pci-dss-3.2.1/deploy) can be deployed and assigned to specific Azure environments to automate many of the required PCI controls.

For a list of additional compliance standards which have been automated in a similar Azure blueprint approach, review the full list of [Azure Blueprint Samples](/azure/governance/blueprints/samples/). If you prefer to work with built-in Azure policy initiatives, you could also review the list of [Regulatory Compliance built-ins in Azure Policy](/azure/governance/policy/samples/iso-27001).

## Next step: Management in the Retail industry

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Management in the Retail industry](./manage.md)
