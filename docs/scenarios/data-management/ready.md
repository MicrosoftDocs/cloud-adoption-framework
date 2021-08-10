---
title: Landing zone review for data management and analytics in Azure
description: Learn about how data management and analytics affects your Azure landing zone design
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure landing zone review for data management and analytics

Enterprise-scale for analytics and AI builds upon enterprise landing zones for ease of deployment and governance. The principle purpose of the enterprise landing zones is to ensure that when an application or workload lands on Azure, the required "plumbing" is already in place. It provides greater agility and compliance with enterprise security and governance requirements. Enterprise-scale landing zones must be in place before you deploy your first data management and analytics landing zones.

## Data management and analytics evaluation

Often enterprises seek clarity or prescriptive guidance before they start to carve out the technical details for a specific use case, project, or an end-to-end data analytics and AI platform. It can be challenging to ensure the consideration of all strategic principles in the scope of the current use case, and required for the formulation of the overall data strategy.

To speed up the delivery of this end-to-end insights journey, while still keeping these challenges in mind, Microsoft has developed a prescriptive offering for enterprise-scale for analytics and AI. It aligns to the key themes discussed in [Develop a plan for data management and analytics](./plan.md).

Enterprise-scale is part of Microsoft's Cloud Adoption Framework. It provides prescriptive guidance, coupled with best practices, on cloud operating model, reference architecture, and platform templates. It's based on real-world learnings from some of our most challenging, sophisticated, and complex environments. Enterprise-scale for analytics and AI paves the way for customers to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of security, governance, and compliance. They're scalable and modular, supporting autonomy and innovation.

The enterprise-scale for analytics and AI architecture was designed with the same strategic principles in mind. To deliver effectively, enterprise-scale for analytics and AI moves teams from working horizontally across each tier such as ingest, processing, analysis, consumption, and visualization, to vertical data landing zone groups, coexisting together in an agile team. Platform teams such as data platform operations and platform operations are grouped together under a common platform group.

### Building on enterprise-scale landing zone

Before you consider deploying enterprise-scale for analytics and AI, you need to understand how close you are to agility within your organization today.

Many enterprises have outdated data architectures that don't scale to the needs of large multidisciplinary organizations. Centralized knowledge and capabilities introduce a bottleneck on a linear process workflow.

If you're a small enterprise with limited staff, then having a centralized model, mixed with some business subject matter experts, can likely fit your operations model.

If you're a large multinational enterprise with hundreds of data engineers and analysts spread around the business, a distributed operating model such as data lakehouse, data mesh, data fabric, data-centric, and others, has potential to fit your business better. What enterprise-scale for analytics and AI provides is guidance to deploy the infrastructure to underpin any of these operation models.

Central to your business thinking must be how to:

- Serve data as a product, as opposed data as a by-product
- Provide an ecosystem of data products, as opposed to a singular data warehouse that might not always be best fit for the data scenario
- Drive a way to enforce data governance and security by default
- Drive teams to always prioritize outcomes to the business, instead of obsessing over the underlying technology

If you don't have an implementation of enterprise-scale landing zones, then it's important that you check with your cloud teams to be sure the pre-requisites can be met. For more information, see [Ensure the environment is prepared for the cloud adoption plan](/azure/cloud-adoption-framework/ready/).

## Data management and analytics Azure landing zone acceleration

Enterprise-scale for analytics and AI requires an understanding of landing zones and makes use of infrastructure-as-code to deploy end to end solution templates. These solution templates are customizable and are a starter for most data management and analytics scenarios.

- [What is a landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/)
- [Choose a landing zone option](/azure/cloud-adoption-framework/ready/landing-zone/choose-landing-zone-option)
- [Refactoring landing zones](/azure/cloud-adoption-framework/ready/landing-zone/refactor)
- [Refactoring landing zones](/azure/cloud-adoption-framework/ready/landing-zone/refactor)
- [Data management and analytics landing zone](./enterprise-scale-landing-zone.md)

## Next steps

The following articles can guide your cloud adoption journey and help you succeed in the cloud adoption scenario.

- [Plan for data management and analytics](./plan.md)
- [Review your environment or Azure landing zone](./ready.md)
- [Govern data management and analytics](./govern.md)
- [Secure data management and analytics](./secure.md)
