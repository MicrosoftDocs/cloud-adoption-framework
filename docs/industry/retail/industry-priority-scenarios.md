---
title: Retail Industry Priority Scenarios
description: Learn how Microsoft approach to Retail Industry Priority Scenarios.
author: Jamin Almond
ms.author: jaalmond
ms.date: 09/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal, e2e-retail
---

# Industry Priority Scenarios

Industry Priority Scenarios (IPS) represent Microsoft’s approach to current addressable needs within the retail industry. Each scenario is backed by products and services within our portfolio that enable retail organizations to solve those challenges and drive digital transformation forward. 


There are four Industry Priority Scenarios for retail:
- Know your customers 
- Empower your employees
- Deliver intelligent supply chain
- Reimagine retail


|Industry Priority Scenario (IPS)|Know your customers|Empower your employees|Build a resilient supply chain|Reimagine retail|
|--------------------------------|-------------------|----------------------|------------------------------|----------------|
|Key message|                    Create digital experiences,and use AI and predictive analytics to anticipate evolving customer needs and deliver individualized interactions across channels|Enable secure digital collaboration across your business and reduce costs|Gain visibility across your end-to-end supply chain using technology solutions|Create innovative customer experiences, optimize in-store operations, and use technology to evolve products, services, and business models|

## Know your customers

Great customer service is—and has long been—the core art of retail. But the way consumers engage with retailers has changed, and the way retailers get to know them along with it. Fortunately, data and predictive AI offers retailers the opportunity to create digital customer experiences that take customer service to the next level while unlocking new business opportunities.

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
