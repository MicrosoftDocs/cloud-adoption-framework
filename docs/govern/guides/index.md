---
title: Cloud governance guides
description: Review cloud governance guides that illustrate best practices for an incremental approach to any governance scenario.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/05/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Cloud governance guides

The actionable governance guides in this section illustrate the incremental approach of the Cloud Adoption Framework governance model, based on the [Govern methodology](../methodology.md) previously described. You can establish an agile approach to cloud governance that will grow to meet the needs of any cloud governance scenario.

## Review and adopt cloud governance best practices

To begin your cloud adoption journey, choose one of the following governance guides. Each guide outlines a set of best practices, based on a set of fictional customer experiences. For readers who are new to the incremental approach of the Cloud Adoption Framework governance model, review the high-level introduction to governance theory below before adopting either set of best practices.

- [Standard governance guide](./standard/index.md): A guide for most organizations based on the recommended two-subscription model, designed for deployments in multiple regions but not spanning public and sovereign/government clouds.

> [!div class="nextstepaction"]
> [Standard governance guide](./standard/index.md)

- [Governance guide for complex enterprises](./complex/index.md): A guide for enterprises that are managed by multiple independent IT business units or span public and sovereign/government clouds.

> [!div class="nextstepaction"]
> [Governance guide for complex enterprises](./complex/index.md)

## An incremental approach to cloud governance

## Choose a governance guide

The guides demonstrate how to implement a governance MVP. From there, each guide shows how the cloud governance team can work ahead of the cloud adoption teams as a partner to accelerate adoption efforts. The Cloud Adoption Framework governance model guides the application of governance from foundation through subsequent improvements and evolutions.

To begin a governance journey, choose one of the two options below. The options are based on synthesized customer experiences. The titles are based on the complexity of the enterprise for ease of navigation. Your decision may be more complex. The following tables outline the differences between the two options.

> [!WARNING]
> A more robust governance starting point may be required. In such cases, consider the [CAF enterprise-scale landing zone](../../ready/enterprise-scale/index.md). This approach focuses on adoption teams who have a mid-term objective (within 24 months) to host more than 1,000 assets (infrastructure, apps, or data) in the cloud. The CAF enterprise-scale landing zone is the typical choice for complex governance scenarios in large cloud adoption efforts.
<!-- -->
> [!NOTE]
> It's unlikely that either guide aligns entirely with your situation. Choose whichever guide is closest and use it as a starting point. Throughout the guide, additional information is provided to help you customize decisions to meet specific criteria.

### Business characteristics

| Characteristic | Standard organization | Complex enterprise |
|---|---|---|
| Geography (country or geopolitical region) | Customers or staff reside largely in one geography | Customers or staff reside in multiple geographies or require sovereign clouds. |
| Business units affected | Business units that share a common IT infrastructure | Multiple business units that do not share a common IT infrastructure. |
| IT budget | Single IT budget | Budget allocated across business units and currencies. |
| IT investments | Capital expense-driven investments are planned yearly and usually cover only basic maintenance. | Capital expense-driven investments are planned yearly and often include maintenance and a refresh cycle of three to five years. |

### Current state before adopting cloud governance

| State | Standard enterprise | Complex enterprise |
|---|---|---|
| Datacenter or third-party hosting providers | Fewer than five datacenters | More than five datacenters |
| Networking | No WAN, or 1 &ndash; 2 WAN providers | Complex network or global WAN |
| Identity | Single forest, single domain. | Complex, multiple forests, multiple domains. |

<!-- docutune:casing "Cost Management" "Security Baseline" -->

### Desired future state after incremental improvement of cloud governance

| State | Standard organization | Complex enterprise |
|---|---|---|
| Cost Management: cloud accounting | Showback model. Billing is centralized through IT. | Chargeback model. Billing could be distributed through IT procurement. |
| Security Baseline: protected data | Company financial data and IP. Limited customer data. No third-party compliance requirements. | Multiple collections of customers' financial and personal data. Might need to consider third-party compliance. |

## CAF enterprise-scale landing zone

[CAF enterprise-scale landing zone](../../ready/enterprise-scale/index.md) is an approach to making the most of the Azure cloud platform's capabilities while respecting an enterprise's security and governance requirements.

Compared to traditional on-premises environments, Azure allows workload development teams and their business sponsors to take advantage of the increased deployment agility that cloud platforms offer. As your cloud adoption efforts expand to include mission-critical data and workloads, this agility may conflict with corporate security and policy compliance requirements established by your IT teams. This is especially true for large enterprises that have existing sophisticated governance and regulatory requirements.

The CAF enterprise-scale landing zone architecture aims to address these concerns earlier in the adoption lifecycle by architectures, implementations, and guidance to help achieve a balance between cloud adoption team requirements and central IT team requirements during enterprise cloud adoption efforts. Central to this approach is the concept of a shared service architecture and well-managed landing zones.

CAF enterprise-scale landing zone deploys your own "isolated cloud" within the Azure platform, integrating management processes, regulatory requirements, and security processes required by your governance policies. Within this virtual boundary, CAF enterprise-scale landing zone offers example models for deploying workloads while ensuring consistent compliance and provides basic guidance on implementing an organization's separation of roles and responsibilities in the cloud.

### CAF enterprise-scale landing zone qualifications

Although smaller teams may benefit from the architecture and recommendations the CAF enterprise-scale landing zone provides. Our objective is to continue to streamline the CAF enterprise-scale landing zone implementations to make them more friendly for smaller teams. Currently, this approach is designed to guide central IT teams managing large cloud environments.

The [CAF enterprise-scale landing zone](../../ready/enterprise-scale/index.md) approach focuses on adoption teams who have a mid-term objective (within 24 months) to **host more than 1,000 assets (applications, infrastructure, or data assets) in the cloud**.

For organizations that meet the following criteria, you may also want to start with the [CAF enterprise-scale landing zone](../../ready/enterprise-scale/index.md):

- Your enterprise is subject to regulatory compliance requirements that require centralized monitoring and audit capabilities.
- You need to maintain common policy and governance compliance and centralized IT control over core services.
- Your industry depends on a complex platform that requires complex controls and deep domain expertise to govern the platform. This is most common in large enterprises within finance, manufacturing, and oil and gas.
- Your existing IT governance policies require tighter parity with existing features, even during early stage adoption.

## Next steps

Choose one of these guides:

> [!div class="nextstepaction"]
> [Standard enterprise governance guide](./standard/index.md)
>
> [Governance guide for complex enterprises](./complex/index.md)
