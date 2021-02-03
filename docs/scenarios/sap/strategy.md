---
title: "Strategy for SAP adoption"
description: Describe the scenario's impact on strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of SAP in the cloud

SAP Products form a mission critical platform for many organizations. When organizations leverage SAP as the foundation for business processes, the dependencies on SAP can be seen throughout the portfolio. The cloud adoption plan for this platform can have direct and indirect impacts on cloud adoption for all related workloads. While SAP isn't commonly the first platform an organization will move to the cloud, it can be the most important. Understanding the strategy for SAP's cloud migration and future state innovation targets is critical to the success of all other cloud adoption plans.

This article will aid in capturing the strategic impact of SAP cloud adoption using the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) and other references from the Cloud Adoption Framework.

## Why are we moving our SAP platform to the cloud?

As a broad reaching platform, there are several motivations for adopting SAP in the cloud. 

When considering a cloud strategy for SAP, the following motivations tend to shape cloud adoption plans:

- **Critical business events:** Adopting SAP in the cloud is often used by customers to mitigate contractural, regulatory, compliance, or sovereignty risks.
- **Migration motivations:** If SAP is a dependency for successful migration of other assets, the motivations tend to focus on reductions in cost, complexity, or operational overhead.
- **Innovation motivations:** The cloud unlocks new opportunities to expand SAP capabilities to deliver transformative products/services.
- **Uncertain Infrastructre requirements:** uncertainty of infrastructure required on the track of business transformation to S/4HANA

Often times, SAP customers are driven by motivations that span all three categories above. To ensure a successful implementation of our SAP platform in the cloud, it is imperative that cloud strategy team (including business and IT leaders) review and prioritize the motivations listed in the [cloud motivations article](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/motivations.md). Those inputs will help the cloud adoption team make informed decisions throughout the implementation process.

Motivations to adopt our SAP platform in the cloud are often based on an organizations strategic objectives. But the majority of motivations cite you common motivations for prioritizing SAP adoption in the near future. The following three are likely already topics of conversation in your organization, if you are reviewing this adoption scenario:

- SAP infrastructure refresh cycles require significant capital expenditures. If your SAP infrastructure is due for a refresh, the benefits of cloud adoption unlock timely cost avoidance strategies. 
- SAP hosting contracts create vendor lock-in spanning multiple fiscal years. If your hosting, managed service, or maintenance contracts are coming up for renewal, there is an opportunistic benefit to cloud adoption that can improve agile, unlock new innovations, and streamline operations for your most mission critical platform.
- Refresh and contract renewals can be triggered by SAP upgrade cycles or a business driver to expand into HANA, SAP Business Suite or others features of of SAP. If your organization is attempting to expand SAP capabilities, cloud adoption will provide cost avoidance and opportunities to innovate, optimize, and be more agile.

## How can we measure progress during SAP adoption?

Once you understand the top motivations for this scenario, the cloud strategy team can define measurable outcomes to further guide adoption activities. Examples of business outcomes commonly seen during cloud adoption can be reviewed in the article on [business outcomes](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/).

Given the impact of our SAP platform, it is likely that you will need to define a number of *Objectives*, each defined and measurable *Key Results*. Objectives and Key Results, commonly referred to as OKRs, can help you break down the adoption of SAP into manageable efforts. Learn more in the [Objectives and Key Results article](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/okr.md).

## How can we build a business justification for cloud migration?

The article series about [building a business justification for cloud migration](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case.md) can help build out your financial plan by dispelling a number of common myths. However, you will likely need to develop a detailed financial model with your finance team to account for all of the moving pieces associated with SAP cloud adoption.

For a analyst perspective, see the [Forrester study on the Total Economic Impact of Microsoft Azure for SAP](https://azure.microsoft.com/en-us/resources/sap-on-azure-forrester-tei/). According to that study, the following are common defensible justifications:

- Time to market benefits in excess of $3 million USD
- Cost avoidance in excess of $7 million USD
- 102% Return on Investment
- Payback in 9 months

Individual customers are likely to experience variations in actual return. However, the tables in that study can aid in capturing your organizations financial data for validation and justification.

> [!NOTE]
> During strategic alignment, understand that your initial business justification is a directional estimate to drive alignment. Create transparency with the cloud strategy team and other stakeholders that this justification is likely to change significantly as you complete planning acitivities. Look primarily for consensus that there is sufficient value to [gather inventory and develop a plan](./plan.md). Once your digital estate is catalogued & assessed, you will be able to refine your justification and present clearer plans for financial returns.

## Next step: Plan for our SAP platform on Azure

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for SAP](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate SAP](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
