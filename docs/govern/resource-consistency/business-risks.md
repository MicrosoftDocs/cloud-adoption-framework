---
title: Motivations and business risks in the Resource Consistency discipline
description: Use the Cloud Adoption Framework for Azure to understand typical customer adoption of a Resource Consistency discipline within a cloud governance strategy.
author: alexbuckgit
ms.author: abuck
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Motivations and business risks in the Resource Consistency discipline

This article discusses the reasons that customers typically adopt a Resource Consistency discipline within a cloud governance strategy. It also provides a few examples of potential business risks that can drive policy statements.

## Relevance

When it comes to deploying resources and workloads, the cloud offers increased agility and flexibility over most traditional on-premises datacenters. These potential cloud-based advantages also come with potential management drawbacks that can seriously jeopardize the success of your cloud adoption. What assets have you deployed? What teams own what assets? Do you have enough resources supporting a workload? How do you know whether workloads are healthy?

Resource consistency is crucial to ensure that resources are deployed, updated, and configured consistently in a repeatable manner, and that service disruptions are minimized and remedied in as little time as possible.

The Resource Consistency discipline is concerned with identifying and mitigating business risks related to the operational aspects of your cloud deployment. Resource consistency includes monitoring of applications, workloads, and asset performance. It also includes the tasks required to meet scale demands, provide disaster recovery capabilities, mitigate performance service-level agreement (SLA) violations, and proactively avoid those SLA violations through automated remediation.

Initial test deployments may not require much beyond adopting some cursory naming and tagging standards to support your resource consistency needs. As your cloud adoption matures and you deploy more complicated and mission-critical assets, the need to invest in the Resource Consistency discipline increases rapidly.

## Business risk

The Resource Consistency discipline attempts to address core operational business risks. Work with your business and IT teams to identify these risks and monitor each of them for relevance as you plan for and implement your cloud deployments.

Risks will differ between organization, but the following serve as common risks that you can use as a starting point for discussions within your cloud governance team:

- **Unnecessary operational cost.** Obsolete or unused resources, or resources that are overprovisioned during times of low demand, add unnecessary operational costs.
- **Underprovisioned resources.** Resources that experience higher than anticipated demand can result in business disruption as cloud resources are overwhelmed by demand.
- **Management inefficiencies.** Lack of consistent naming and tagging metadata associated with resources can lead to IT staff having difficulty finding resources for management tasks or identifying ownership and accounting information related to assets. This results in management inefficiencies that can increase cost and slow IT responsiveness to service disruption or other operational issues.
- **Business interruption.** Service disruptions that result in violations of your organization's established service-level agreements (SLAs) can result in loss of business or other financial impacts to your company.

## Next steps

Use the [Resource Consistency discipline template](./template.md) to document business risks that are likely to be introduced by the current cloud adoption plan.

Once an understanding of realistic business risks is established, the next step is to document the business's tolerance for risk and the indicators and key metrics to monitor that tolerance.

> [!div class="nextstepaction"]
> [Understand indicators, metrics, and risk tolerance](./metrics-tolerance.md)
