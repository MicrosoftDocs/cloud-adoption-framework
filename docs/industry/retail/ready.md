---
title: "Azure Landing Zones for the Retail industry"
description: Prepare Azure environments for retail industry cloud adoption 
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Landing Zones for the Retail industry

The [Ready methodology in the Cloud Adoption Framework](../../ready/index.md) guides the creation of all Azure environments using [Azure landing zones](../../ready/landing-zone/index.md). Azure landing zones provide many [implementation options](../../ready/landing-zone/implementation-options.md) built around a set of [common design areas](../../ready/landing-zone/design-areas.md).

With Azure landing zones, you can start with a small implementation and expand over time. For more sophisticated environments, you can start with enterprise-scale implementation options. The variety of implementation options ensure that you can start with an Azure environment that meets your short term needs. Overtime, those same environments can be extended to meet your longer term operational needs.

## Organizational alignment impact

For retail companies, IT operations will be heavily influenced by the companies historical growth patterns; more specifically, the impact those growth patterns have had on your organizational structures across your technology teams. To understand how this influences operations management, review the article on [Initial organizational alignment](./organize.md#understand-common-growth-patterns-for-retailers).

- Will Central IT, CCoE, or other forms of centralize operations be responsible for operating all workloads?
- Does your strategy and plan require your brick & mortar locations to be integrated into your cloud environment?
- Does your strategy and plan include any deployments which would require adherence to regulatory compliance standards, such as PCI-DSS?

## Operating model alignment

If you plan to enable enterprise operations & need to enable separation of duty between IT and workload teams, then the Enterprise-scale implementation options are most likely to accelerate your environmental configuration.

If your plan is to focus on central operations, then the 'start-small approach' may be a better initial implementation option, as long as your complete the [Govern](./govern.md) and [Manage](./manage.md) methodologies in parallel to your cloud adoption plan.

## Network: branch strategy

If connectivity to your edge locations (Specifically brick & mortar retail locations) is included in your cloud adoption plans, a thorough understanding of [perimeter networks](/azure/cloud-adoption-framework/ready/azure-best-practices/perimeter-networks) is a required part of your overall Azure Landing Zone strategy. 

In addition to perimeter network connections, you will also need to consider traffic patterns, advanced security controls, and other practices. Each of which could more easily be deployed using one of the Enterprise-Scale landing zone implementation options of the Azure Landing Zones.

## Compliance: PCI-DSS

Most retail organizations require compliance with [Payment Card Industry (PCI) Data Security Standards (DSS)](/azure/compliance/offerings/offering-pci-dss). But this is just one example of the compliance requirements common seen in retail cloud adoption requirements.

If your cloud adoption strategy and plan call for adherence to regulatory compliance standards, review the compliance section of the [governance for retail](./governance.md) article, before deploying your Azure Landing Zones.

## Next step: Assess for the Retail industry

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Cloud adoption plan for the Retail industry](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate common Retail industry technologies](./migrate.md)
- [Innovation in the Retail industry](./innovate.md)
- [Governance in the Retail industry](./govern.md)
- [Management in the Retail industry](./manage.md)
