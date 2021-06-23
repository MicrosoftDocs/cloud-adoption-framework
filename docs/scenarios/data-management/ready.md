---
title: "Landing Zone review for 'data management and analytics' in Azure"
description: Describe the scenario's impact on Azure Landing Zone design
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Landing Zone review for 'data management and analytics'

The Enterprise Scale Analytics and AI construction set builds upon Enterprise Landing Zones for ease of deployment and governance. The principle purpose of the Enterprise Landing Zones is to ensure that when an application or workload lands on Azure, the required "plumbing" is already in place, providing greater agility and compliance with enterprise security and governance requirements. This needs to be in-place before deploying your first data management and analytics landing zones.

## 'data management and analytics' evaluation

Often Enterprises seek clarity or prescriptive guidance before starting to carve out the technical details for a specific use case, project or an End-to-End Data Analytics & AI platform. This can be a stumbling block as how to ensure that all the strategic principles not only in the scope of current use case but also required for the formulation of the overall Data Strategy are considered.

So, keeping this challenge in view and speed up the delivery of end-to-end insights journey, Microsoft has developed a prescriptive offering in the context of an Enterprise Scale Analytics and AI which marries up perfectly to the key themes discussed in [Develop a plan for 'data management and analytics'](plan.md)

Enterprise Scale is part of Microsoft's Cloud Adoption Framework which provides prescriptive guidance, coupled with best practices, on cloud operating model, reference architecture and platform templates based on real-world learnings from some of our most challenging, sophisticated, and complex environments. Enterprise Scale Analytics and AI paves the way for customers to build and operationalize something called landing zones to host and run analytics workloads. These landing zones are built on the foundations of security, governance, and compliance yet are scalable and modular, supporting autonomy and innovation.

The Enterprise Scale Analytics and AI architecture was designed with the same strategic principles in mind as mentioned above. To deliver effectively the Enterprise Scale Analytics and AI moves teams from working horizontally across each tier such as Ingest, Processing, Analysis, Consumption and Visualization to vertical Data Landing Zone Groups coexisting together in an agile team. Platform teams such as Data Platform Ops and Platform Ops are grouped together under a common Platform Group.

### Alignment to Enterprise Scale Landing Zone

Before you consider deploying Enterprise Scale Analytics and AI construction set you need to understand how close you are to agility within your organization today.

Many enterprises are saddled with outdated data architectures that do not scale to the needs of large multi-disciplinary organizations. Centralized knowledge and capabilities introduce a bottleneck on a linear process workflow.

If you are small enterprise, with limited staff, then having this centralized model mixed with some business subject matter experts is likely to still fit your operations model.

However, if you are a large multi-national enterprise with hundreds of data engineers and analyst spread around the business then a distributed operating model such as Data Lakehouse, Data Mesh, Data Fabric, Data Centric etc. has potential to fit your business better. What Enterprise Scale Analytics and AI construction set provides is guidance to deploy the infrastructure to underpin any of those operation models.

Central to your business thinking is how to:

- Serve data as a product as opposed data as a by-product.
- Provide an ecosystem of data products as opposed a singular data warehouse which might not always be best fit for the data scenario.
- Drive a way to enforce Data Governance and security by default.
- Drive teams to always prioritize outcomes to the business instead of obsessing over the underlying technology.

If you have a partial implementation of Enterprise Scale Landing Zones then it is important that you check with your cloud teams that the following pre-requisites can be met:-

### Networking

- You should be operating in a hub and spoke architecture
- Allow vnet peerings between spokes
- Private Link/Private endpoint is a supported pattern in your deployment (Vnet injection when not supported)
- Support for Global DNS Zones for Data Services (Synapse, Purview, Data Factory, Azure Machine Learning, Key Vault, Storage, etc.)

### Management Group and Subscription Organization

- Operate as a Single tenant
- Deployment of cloud services is controlled by policy driven governance as this allows you to add data specific policies.
- Scalability with is via subscriptions and subscription democratization.

### Identity Access Management

- There is an automation process in place for managing AD groups
- There is an automation process in place for role assignments

So, keeping this challenge in view and speed up the delivery of end-to-end insights journey, Microsoft has developed a prescriptive offering in the context of an Enterprise Scale Analytics and AI which marries up perfectly to the key themes discussed in [Develop a plan for 'data management and analytics'](plan.md)

Enterprise Scale Analytics and AI requires an understanding of landing zones and makes use of Infrastructure-as-code to deploy end to end solution templates. These solution templates are customizable and are a starter for most data management and analytics scenarios.

- [What is a landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/)
- [Choose a landing zone option](/azure/cloud-adoption-framework/ready/landing-zone/choose-landing-zone-option)
- [Refactoring Landing Zones](/azure/cloud-adoption-framework/ready/landing-zone/refactor)

The Enterprise Scale Analytics and AI architecture was designed with the same strategic principles in mind as mentioned above. To deliver effectively the Enterprise Scale Analytics and AI moves teams from working horizontally across each tier such as Ingest, Processing, Analysis, Consumption and Visualization to vertical Data Landing Zone Groups coexisting together in an agile team. Platform teams such as Data Platform Ops and Platform Ops are grouped together under a common Platform Group.

## 'data management and analytics' Azure Landing Zone acceleration

Enterprise Scale Analytics and AI requires an understanding of landing zones and makes use of Infrastructure-as-code to deploy end to end solution templates. These solution templates are customizable and are a starter for most data management and analytics scenarios.

- [What is a landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/)
- [Choose a landing zone option](/azure/cloud-adoption-framework/ready/landing-zone/choose-landing-zone-option)
- [Refactoring Landing Zones](/azure/cloud-adoption-framework/ready/landing-zone/refactor)

## Next step: Assess for 'data management and analytics'

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for 'data management and analytics'](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Assess for 'data management and analytics' migration](./migrate-assess.md)
- [Migrate 'data management and analytics'](./migrate-deploy.md)
- [Release 'data management and analytics' to production](./migrate-release.md)
- [Innovate with 'data management and analytics'](./innovate.md)
- [Govern 'data management and analytics'](./govern.md)
- [Manage 'data management and analytics'](./manage.md)
