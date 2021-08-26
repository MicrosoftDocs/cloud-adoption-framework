---
title: Review your environment for Azure landing zones
description: Learn about how data management and analytics affects your Azure landing zone design.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Review your environment for Azure landing zones

Enterprise-scale for analytics and AI builds upon enterprise landing zones for ease of deployment and governance. The principal purpose of the enterprise landing zones is to ensure that when an application or workload lands on Azure, the required "plumbing" is already in place. It provides greater agility and compliance with enterprise security and governance requirements. Enterprise-scale landing zones must be in place before you deploy your first data management and analytics landing zones.

## Data management and analytics evaluation

Often enterprises seek clarity or prescriptive guidance before they start to carve out the technical details for a specific use case, project, or an end-to-end data analytics and AI platform. It can be challenging to ensure that all strategic and required principles in the scope of the current use are considered for how the overall data strategy is formulated.

To speed up the delivery of this end-to-end insights journey while still keeping these challenges in mind, Microsoft has developed a prescriptive offering for enterprise-scale for analytics and AI. It aligns to the key themes discussed in [Develop a plan for data management and analytics](./plan.md).

Enterprise-scale is part of the Microsoft Cloud Adoption Framework. It provides prescriptive guidance and best practices on cloud operating models, reference architecture, and platform templates. It's based on real-world learnings from some of our most challenging, sophisticated, and complex environments. Enterprise-scale for analytics and AI paves the way for customers to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of security, governance, and compliance. They're scalable and modular while supporting autonomy and innovation.

Enterprise-scale for analytics and AI architecture was designed with the same strategic principles in mind. To perform effectively, enterprise-scale for analytics and AI moves teams from working horizontally across each ingest, processing, analysis, consumption, and visualization tier to vertical data landing zone groups that coexist in an agile team. Platform teams such as data platform operations and platform operations are grouped together under a common platform group.

### Build on an enterprise-scale landing zone

Before you consider deploying enterprise-scale for analytics and AI, you need to understand how close you are to agility within your organization today.

Many enterprises have outdated data architectures that don't scale to the needs of large and multidisciplinary organizations. Centralized knowledge and capabilities introduce a bottleneck on a linear process workflow.

If you're a small enterprise with limited staff, then having a centralized model mixed with some business subject matter experts might fit your operations model.

If you're a large multinational enterprise with hundreds of data engineers and analysts spread around the business, a distributed operating model like a data lakehouse, data mesh, data fabric, data-centric, or others might fit your business better. What enterprise-scale for analytics and AI provides is guidance to deploy the infrastructure to underpin these operation models.

Your business should consider how to best:

- Serve data as a product versus a by product.
- Provide an ecosystem of data products instead of a singular data warehouse that might not best fit the data scenario.
- Drive a default way to enforce data governance and security.
- Drive teams to consistently prioritize business outcomes instead of obsessing over the underlying technology.

If you don't have an implementation of enterprise-scale landing zones, then it's important to consult your cloud teams about how to meet prerequisites. For more information, see [Ensure the environment is prepared for the cloud adoption plan](/azure/cloud-adoption-framework/ready/).

## Accelerate Azure landing zones for data management and analytics

Enterprise-scale for analytics and AI requires an understanding of landing zones and uses infrastructure-as-code to deploy end-to-end solution templates. These customizable The following templates are customizable and can help your organization to get started with most data management and analytics scenarios:

- [What is a landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/)
- [Choose a landing zone option](/azure/cloud-adoption-framework/ready/landing-zone/choose-landing-zone-option)
- [Refactor landing zones](/azure/cloud-adoption-framework/ready/landing-zone/refactor)
- [Data management and analytics landing zone](./enterprise-scale-landing-zone.md)

## Next step

[Introduction to enterprise-scale for analytics and AI for Azure](./enterprise-scale-landing-zone.md)
