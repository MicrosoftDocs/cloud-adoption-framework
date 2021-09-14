---
title: The strategic impact of SAP in the cloud
description: Understand the strategic impact of SAP in the cloud.
author: JefferyMitchell
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# The strategic impact of SAP in the cloud

SAP products form a mission-critical platform for many organizations. When these products are foundational to an organization's business processes, the dependencies on SAP can be seen throughout the portfolio. The cloud adoption plan for this platform can directly and indirectly impact cloud adoption for all related workloads. While SAP isn't typically the first platform that an organization moves to the cloud, it can be the most important. Understanding the strategy for an SAP cloud migration and future-state innovation targets is critical to the success of all other cloud adoption plans.

This article uses the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) and other resources from the Cloud Adoption Framework to capture the strategic impact of SAP cloud adoption.

## Reasons to move an SAP platform to the cloud

SAP is an influential platform, and organizations have several motivations to adopt SAP in the cloud. When an organization considers a cloud strategy for SAP, the following motivations tend to shape cloud adoption plans:

- **Critical business events:** Customers often adopt SAP in the cloud to mitigate contractual, regulatory, compliance, or sovereignty risks.

- **Migration motivations:** If other assets depend on SAP to migrate successfully, then customers tend to focus on reducing costs, complexities, or operational overhead.

- **Innovation motivations:** The cloud unlocks new opportunities for SAP to expand and deliver transformative products and services.

- **Infrastructure scale flexibility requirements:** The cloud offers the ability to seamlessly scale up and down with infrastructure as part of business transformation with SAP S/4HANA.

SAP customers are often motivated by all four categories above. To successfully implement an SAP platform in the cloud, it's imperative for a cloud strategy team (including business and IT leaders) to review and prioritize the motivations listed in [Cloud motivations](../../strategy/motivations.md). This input will help the cloud adoption team to make informed decisions throughout the implementation process.

Motivations to adopt an SAP platform in the cloud are often based on an organization's strategic objectives. The following topics are for your organization if your team is reviewing this adoption scenario:

1. Cycles to refresh SAP infrastructure require significant capital expenditures. If your SAP infrastructure is due for a refresh, the benefits of cloud adoption can unlock timely strategies to reduce costs.

1. SAP hosting contracts lock in vendors across multiple years. If your hosting, managed service, or maintenance contracts are coming up for renewal, some cloud adoption opportunities and benefits are to improve agile, unlock new innovations, and streamline operations for your most mission-critical platform.

1. Refresh and contract renewals can be triggered by SAP upgrade cycles or a business driver to expand into HANA, SAP Business Suite, or others SAP features. If your organization is seeking to expand SAP capabilities, cloud adoption will provide opportunities to reduce costs, innovate, optimize, and be more agile.

## How to measure progress during an SAP adoption

Once you understand the top motivations for this scenario, the cloud strategy team can define measurable outcomes to further guide adoption activities. Examples of business outcomes commonly seen during cloud adoption can be reviewed in the article on [business outcomes](../../strategy/business-outcomes/index.md).

Given the impact of an SAP platform, you need to define a number of defined objectives and measurable key results. Commonly known as OKRs, objectives and key results can help you to break down SAP adoption into manageable efforts. Read [objectives and key results](../../strategy/business-outcomes/okr.md) to understand OKRs in more detail.

## How to build a business justification for cloud migration

[Building a business justification for cloud migration](../../strategy/cloud-migration-business-case.md) can dispel a number of common myths for your team's financial plan. However, your finance team might need to develop a detailed financial model to account for the moving pieces associated with SAP cloud adoption.

The [Forrester study on the total economic impact of Microsoft Azure for SAP](https://azure.microsoft.com/resources/sap-on-azure-forrester-tei/) offers an analysis where the following justifications are typically defendable:

- Time to market benefits exceed $3 million USD
- Cost avoidance exceeds $7 million USD
- 102-percent return on investment
- Pay back in nine months

Actual returns are likely to vary for individual customers. However, the tables in the Forrester study can capture your organization's financial data for validation and business justification activities.

Understand that your initial business justification is a directional estimate that can help to drive strategic alignment. Your organization can create transparency between the cloud strategy team and other stakeholders by affirming that this justification can change significantly throughout planning activities. Look for consensus that there's enough value to [gather inventory and develop a plan](./plan.md). Once your digital estate is catalogued and assessed, you can refine your justification and present clearer plans for financial returns.

## Next step: Plan for an SAP cloud adoption in Azure

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting SAP in Azure.

- [Plan for SAP cloud adoption in Azure](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate an SAP platform to Azure](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
