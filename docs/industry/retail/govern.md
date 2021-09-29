---
title: Governance for the retail industry
description: Learn how to use the Cloud Adoption Framework methodology to improve governance of your cloud portfolio for the retail industry.
author: mpvenables
ms.author: brblanch
ms.date: 09/24/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal, e2e-retail
---

# Governance for the retail industry

Use the [Cloud Adoption Framework methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio across the five governance disciplines pictured below. This article refines the methodology for governance needs specific to the retail industry.

![Screenshot of the Cloud Adoption Framework governance model](../../_images/operational-transformation-govern-large.png)

When developing your cloud governance strategy, start out by following the approach in the standard methodology.

# The challenges of good data governance

Retailers are facing challenges tied to how data is stored, analyzed, managed, and governed. Unlocking the necessary business value to differentiate and grow in an increasingly competitive digital ecosystem means that retailers will face challenges. Along with generating insights at scale from disparate datasets—ensuring data storage, data sharing, and data integrity across silod systems, maintaining a culture built upon the strategic management of business data, and a unified practice of foundational governance, compliance, and security.

To solve these issues, one view of data is necessary in order to democratize and modernize the data that you use to make important decisions regarding healthy business growth. We suggest using a master data management (MDM) approach, coupled with [unified operations](./scenarios/hybrid/unified-operations.md)—consistent controls and processes for data governance, compliance, and security operations management, on an intelligent [hybrid and multicloud](../../scenarios/hybrid/index.md) platform.  

## The data governance imperative

Lack of data ownership causes data to be curated and assembled on a case-by-case basis, leading to quality issues, or data gaps, when being levered for other use cases. The common lack of governance policies and related policy enforcement leaves organizations open to compliance risk. And, compliance regulations are constantly evolving, leaving organizations to spend a lot of energy and effort to ensure compliance with laws and certification that important data is secured. 

According to aggregate data in the report, [The New Intelligent Supply Chain: Strategies for agility, sustainability, and operational excellence](https://clouddamcdnprodep.azureedge.net/gdc/gdcSP3mu5/original?ocid=eml_pg213712_gdc_comm_dt&mkt_tok=MTU3LUdRRS0zODIAAAF_tG7MLPUdet-mYf1Y1PD9PfDE134zkWJLqww_-UsO6Qvccaups4t-fFzNFFq3iufQVu2EkvPbeFwvepmGnxOpEAU22nXVpMvygIexrERAEFImtF-gZPCkLg), the three macro forces affecting the consumer goods and retail industries are rapidly changing consumer expectations, growing demands for sustainability, and the shift to a digitally fueled supply chain. Any digitally fueled supply chain will need to rely on sound source data to be efficient and productive. This is why proper data governance across environments is one such challenge, especially with disparate datasets stored in silod departments across your organization.

It's important to manage the availability, usability, integrity, and security of the data in your organization, based on internal data standards and policies that also control data usage. For good data governance, data must be consistent and trustworthy, without getting misused. This is important data to your company—the data that helps optimize operations and drives business decision-making in a competitive e-commerce global ecosystem, where companies  are constantly confronted with new data privacy regulations, and increasingly depend on data analytics to factor changing customer behaviors and future business growth trajectories.
 
## Unified operations and data management
 
Against the global supply chain disruptions caused by the COVID pandemic, the retail sector faces challenges that are deeply rooted in the traditional brick-and-mortar supply chain model, and its historic ways of operating, managing, and governing consumer data in on-premises datacenters amid a quickly evolving, omnichannel e-commerce landscape.

To address the challenges of maintaining data visibility and data integrity across disparate, siloed departments in your organization, we recommend having one view of data—necessary to democratize your data and modernize the datasets you use to make decisions with, and on which your future business growth depends. We suggest using a [master data management (MDM) approach](../../retail/industry-priority-scenarios.md), coupled with [unified operations](../../scenarios/hybrid/unified-operations.md)—consistent controls and processes for data governance, compliance and operations management, with a [hybrid and multicloud](../../scenarios/hybrid/index.md) strategy. Cloud assets that are distributed across disparate environments can benefit from a unified operations approach—maintaining one set of tools and processes to consistently manage scattered resources across cloud providers through common governance and operations management practices.

## Governance for hybrid and multicloud assets

Aside from online-only retailers, retail organizations operate from several distributed physical locations to deliver brick and mortar retail. Because of latency limitations, those locations can contain technology assets. You need to govern, operate, and secure those assets to help protect your business from risks.

Your governance strategy might require distributed governance, but that might not be a part of your cloud adoption strategy. Does your cloud adoption strategy include digital transformation for [supply chain optimization](./retail-supply-chain-optimization.md), [building management optimization](./retail-building-management-optimization.md), or in-store experience for your customers?

If you have distributed locations and need to drive a cloud adoption strategy for assets in those locations, consider a unified operations strategy. This strategy can deliver governance and operations across public cloud, private cloud, and edge locations. For more information, see [Introduction to unified operations](../../scenarios/hybrid/unified-operations.md).

## Intelligent retail on hybrid and multicloud

Using a unified operations approach, and hybrid and multicloud strategy can guide and unify disparate data governance and data management approaches and deliver higher maximum value for your organization using AI and ML-driven apps and services with SaaS. According to the report, sponsored by Microsoft Corporation, [Cloud Drives Digital Transformation In Retail, Excerpts from the 2020 Frost & Sullivan Global Cloud User Survey](https://clouddamcdnprodep.azureedge.net/gdc/gdc4fqB1U/original), "Multicloud adoption has skyrocketed among retailers in the past year, up nearly 50%. Hybrid cloud adoption is up by 19%. An intelligent hybrid cloud platform enables retailers to maximize the value of their data."

Read more about Microsoft's approach to [Industry Priority Scenarios](./retail/industry-priority-scenarios.md), and how they can unlock tailored, cross-platform customer experiences, and create robust future business growth levering AI and ML-driven customer insights to match ephemeral expectations of the e-commerce customer now, and deliver a very personal customer experience on any platform.

To institute consistent governance, compliance, and operational management controls across hybrid and multicloud environments for the retail sector, we recommend that you first review the comprehensive guidance on [hybrid and multicloud](../../scenarios/hybrid/index.md), and then review the documentation on [unified operations](../../scenarios/hybrid/unified-operations.md).

## Compliance with data security standards

Most retail organizations require compliance with Payment Card Industry data security standards (PCI DSS) to process credit cards. For more information, see [PCI DSS](/azure/compliance/offerings/offering-pci-dss).

Microsoft Azure maintains PCI DSS validation, which can make it easier to govern PCI DSS compliant deployments in the cloud. For more information, see [Azure and PCI DSS](/azure/compliance/offerings/offering-pci-dss#azure-and-pci-dss). Your organization also shares in responsibilities to fully comply with PCI DSS standards.

If your cloud deployments require PCI DSS compliance, review the [control mapping of PCI DSS v3.2.1](/azure/governance/blueprints/samples/pci-dss-3.2.1/control-mapping). You can deploy the blueprint sample and assign it to specific Azure environments. It can automate many of the required PCI controls. For more information, see [Deploy the PCI DSS v3.2.1 blueprint sample](/azure/governance/blueprints/samples/pci-dss-3.2.1/deploy).

For compliance standards that have been automated in a similar Azure blueprint approach, see [Azure blueprint samples](/azure/governance/blueprints/samples/). If you prefer to work with built-in Azure Policy initiatives, see [Regulatory compliance built-ins in Azure Policy](/azure/governance/policy/samples/iso-27001).

## Next steps

The following article provides guidance to help you succeed in the cloud adoption scenario:

- [Innovation in the retail industry](./innovate.md)
- [Governance in the retail industry](./govern.md)
- [Management in the retail industry](./manage.md)