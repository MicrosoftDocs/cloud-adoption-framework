---
title: Manage for defense cloud adoption
description: Recommendations for managing cloud workloads in a defense organization
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 10/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
---
# Manage for defense cloud adoption

The manage methodology is in the workload domain of cloud adoption. It's the last methodology covered, but it isn't the end of cloud adoption.

:::image type="content" source="./images/workload.png" alt-text="Figure that shows a domain tracker. It shows mission, platform, and workload. Workload is highlighted to show we're in the workload domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - workload domain*

The manage methodology is about operational efficiency. Operational efficiency is doing more with less and in the right direction. The operations team must learn and drive toward mission objectives or risk steering workloads in a direction that doesn’t support the war fighter.

In a defense context, the technical and non-technical aspects of operations are equally important. It’s worth focusing on these recommendations here:

## Create resource baselines

There are several strategies defense organizations can adopt to improve operations. Technical teams need to know what cloud resources they have (inventory) and know what each resource is doing (visibility). Visibility requires baselines. Baselines make cloud resources measurable, which is critical to security and modernization. Operations teams need to create baselines so that progress can be measured.

## Choose a product owner

Communication is the key to getting the deliverables mission owners need. A product owner is a key asset in driving workload enhancements in the right direction. A product owner is a defense individual who serves as the single point of contact for the workload technical team. The product owner represents the interests of the stakeholders and handles stakeholder input. The product owner uses this input to identify the highest priority tasks for the technical team to focus on. The product owner should meet regularly with stakeholders and the workload technical team to set priorities and receive feedback.

If the stakeholders change the functional requirements of a workload, the product owner needs to update the existing requirements in writing and discuss the affected technical requirements with the technical team. Without bi-directional communication, the pace of innovation will slow, and the workload will drift from the requirements.

## Incentivize transparency

Mission owners should incentivize management transparency. Regular communication, deliverables, and read access environments are fundamental ways to drive transparency. Transparency generates productive communication, drives mission alignment, and creates accountability.

Mission owners should require artifacts from operations teams. Compliance reports and cloud spend reveal much about the status of workload operations, and Azure allows operations teams to easily generate both reports.

Security teams can create reports that detail how many resources follow security standards such as NIST SP 800-53. The first report received creates a management baseline, and subsequent reports should show improvements over time. We recommend asking the operations teams how much progress they expect to make and where they anticipate focusing their efforts.  

If contracts are a component of operations, foster contract relationships that require and incentivize transparency. Fixed-price contracts, for example, minimize mission-owner visibility. While they limit the risk of overrunning budget, they offer little visibility into the daily operations of the environment supporting your mission. Mission owners should review costs. Costs are transparent. They reflect the underlying technology and identify priorities. They reveal security concerns and help with business forecasts.

## Next step

The logical next step well-architected framework. It provides best practices for cloud workloads.

> [!div class="nextstepaction"]
> [Well-architected framework](/azure/architecture/framework/)
