---
title: Organize for defense cloud adoption
description: Recommendations for organizing a defense organization for cloud adoption
author: stephen-sumner
ms.author: wayneme
ms.reviewer: ssumner
ms.date: 12/6/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
---
# Organize for defense cloud adoption

The organize methodology falls within the command domain of cloud adoption.

:::image type="content" source="./images/command.png" alt-text="Figure that shows a domain tracker. It shows command, platform, and mission. Command is highlighted to show we're in the command domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - command domain*

One of the biggest cloud adoption challenges in a defense organization isn't the technology but organizing the groups, teams, and roles to support the technology. Traditional IT operations differ from cloud operations. The traditional model is centralized, and a central authority builds and maintains the technology stack. The cloud challenges this model.

Cloud adoption provides capabilities that enable organizational change. One of these capabilities is building through code. Teams can use code to build every workload or service with scripts (ARM template, Bicep, Terraform, CLI, PowerShell). This capability is a significant departure from the past where infrastructure needed to be provisioned through a central group to ensure consistency and minimize risk. Mission owners can use code and deliver better consistency. Consistency allows mission owners to forecast spending, meet security requirements, and increase deployment efficiency. However, there’s an organizational component. Mission owners need personnel with automation and scripting skills and should have them on their team before building the platform.

A decentralized cloud empowers groups to build their own autonomous solutions and innovate to meet the needs at a mission level. However, this approach won't succeed without effective organizational alignment. A lack of governance and control could allow conflicting workloads into production. It’s essential that mission owners rethink and define roles and responsibilities

## Define new roles

Mission owners should define role and responsibilities with the cloud broker. As mission owner workloads move to the cloud, cloud brokers should take on more responsibility from the mission owner. It’s tempting for mission owners to map on-premises roles and responsibilities in the cloud, but the two operating models make it an ineffective approach. It’s important to remember that cloud brokers work on the cloud platform for months before mission owners gain access. Mission owners should recall their familiarity with the platform when defining new roles and responsibilities. Mission owners need to enable cloud brokers to build while protecting key assets.

For more information, see [required cloud functions](/azure/cloud-adoption-framework/organize/#understand-required-cloud-functions).

## Define platform responsibilities

The mission owner and cloud broker share responsibility for the platform. It’s best practice to define platform responsibilities along the following lines:

***Cloud service provider (Azure)*** – At a minimum, the cloud service provider maintains the physical infrastructure and secures the resources in the data center. This responsibility level corresponds to an infrastructure-as-a-service (IaaS) deployment. The responsibility changes with platform-as-a-service (PaaS) and software-as-a-service (SaaS) solutions.

***Cloud broker*** – The cloud broker manages most of the platform. It ensures connectivity to the on-premises defense network, manages the identity solution (tenant), and most supporting services.

***Mission owner*** – The mission owner builds, migrates, and manages applications on top of the platform. Responsibilities include code security, application reliability, data protection, and modernization.

## Assign financial oversight

A frequent area of concern in cloud adoption is financial oversight. Mission owners should assign personnel to manage, monitor, and forecast costs. Financial oversight that performs these duties will help avoid overspending. Mission owners should consider how often they receive debriefs on cloud spend. A briefing at least twice monthly provides the necessary oversight to make changes that prevent overspending. For more information, see:

- [Cloud accounting](https://learn.microsoft.com/en-us)/azure/cloud-adoption-framework/strategy/cloud-accounting)
- [Cost management strategy](./govern.md#create-a-cost-governance-strategy)

## Identify other cloud functions

The mission owner shouldn't manage the cloud solution as a single unit. Other cloud functions focused on governance, operations, security, automation, and data might be required to perform specific activities in the cloud platform.

For more information, see:

- [Organize overview](/azure/cloud-adoption-framework/organize/)
- [Mature organizational structure](/azure/cloud-adoption-framework/organize/organization-structures)

## Next step

The organize methodology is the last step in the command domain. The ready methodology of the platform domain is next.

> [!div class="nextstepaction"]
> [Ready](ready.md)
