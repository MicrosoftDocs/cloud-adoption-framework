---
title: Cloud-scale analytics overview
description: Learn about cloud-scale analytics for Azure.
author: mboswell
ms.author: mboswell
ms.date: 03/17/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Introduction to cloud-scale analytics

Often businesses seek clarity or prescriptive guidance before they start to carve out the technical details for a specific use case, project, or an end-to-end cloud-scale analytics. It can be challenging to ensure that all strategic and required principles in the scope of the current use are considered for how the overall data strategy is formulated.

To speed up the delivery of this end-to-end insights journey while still keeping these challenges in mind, Microsoft has developed a prescriptive scenario for cloud-scale analytics. It aligns to the key themes discussed in [Develop a plan for cloud-scale analytics](plan.md).

Cloud-scale analytics builds on top of the Microsoft Cloud Adoption Framework whilst applying our Well-Architected framework lens. Microsoft Cloud Adoption Framework provides prescriptive guidance and best practices on cloud operating models, reference architecture, and platform templates. It's based on real-world learnings from some of our most challenging, sophisticated, and complex environments.

Cloud-scale analytics paves the way for customers to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of security, governance, and compliance. They're scalable and modular while supporting autonomy and innovation.

There are sample templates, which get you started which can be used for data lakehouse and [data mesh](architectures/what-is-data-mesh.md) deployments.

## Problem space

In the late 1980s, there was the introduction of the data warehouse generation 1, which combined disparate data sources from across the enterprise. In the late 2000s came Gen2, with the introduction of the big data ecosystem like Hadoop and the data lake. In the mid 2010s, we had the cloud data platform. It was similar to previous generations, but with the introduction of the ingestion of streaming data, like kappa or lambda architectures. The early 2020s introduced the concepts of the data lakehouse, data mesh, data fabric, and data-centric operational patterns.

Understanding the evolution and looking forward, many organizations still have the centralized monolithic platform, generation 1. This system works well, up to a point. Bottlenecks because of interdependent processes, tightly coupled components, hyperspecialized teams, and thousands of extract, transform, load (ETL) jobs become prominent and can slow down delivery timelines.

The data warehouse and data lake is still valuable, and will play an important role in your overall architecture. We're highlighting some of the challenges that inevitably come forth when using these traditional practices to scale. These challenges are especially relevant in a complex organization, where data sources, requirements, teams, and outputs change.

## New approach to cloud-scale analytics

Your current analytical data architecture and operating model could align include data warehouse, data lake, or data lakehouse structures – or even an emerging model like data fabric or data mesh.

Each has its own merits and challenges, and cloud-scale analytics helps you work from where you're now to shift your approach to data management so it can evolve with your infrastructure.

You can support any data platform with the scenario to create an end-to-end cloud-scale analytics framework that can serve as your foundation and allow for scaling.  

## Modern data platform and desired outcomes

One of the first focus areas is to activate your data strategy to overcome your challenges by iteratively building a scalable and agile modern data platform.

Rather than drowning in service tickets and trying to meet competing business needs, a modern data platform enables you to play a more consultative role, freeing up your time to focus on more valuable work. You provide lines of business with the platform and systems to self-serve their data and analytics needs.

Recommended areas of initial focus are:

- Improve data quality, facilitate trust, and gain insights to make data-driven business decisions.

- Seamlessly implement holistic data, management, and analytics at scale, across your organization.

- Establish robust data governance that enables self-service and flexibility for lines of business.

- Maintain security and legal compliance in a fully integrated environment.

- Quickly create the foundation for advanced analytics capabilities with an out-of-the-box solution of well-architected, repeatable, modular patterns.

## Govern your analytics estate

The second consideration is how will the organization implement data governance?

Data governance is how you ensure data that is used in your business operations, reports, and analysis is discoverable, accurate, trusted, and can be protected.

For many companies, the expectation in the boardroom is that data and AI will drive competitive advantage. As a result, executives are eager to sponsor AI initiatives in their determination to become data-driven. For AI to become effective, the data it's using must be trusted. Otherwise, decision accuracy might be compromised, decisions might be delayed, or actions might be missed, which can affect on the bottom line. Companies don't want the quality of their data to be "garbage in, garbage out". It might seem simple to fix data quality, until you look at the effect that digital transformation has had on data.

With data spread out across a hybrid multicloud and a distributed-data landscape, organizations struggle to find where their data is, to govern it. The ungoverned data can have a considerable effect on the business. Poor data quality impacts business operations because data errors cause process errors and delays. Poor data quality also affects business decision making and the ability to remain compliant. Ensuring data quality at the source is often preferred since fixing quality issues in the analytical system is often more complex and costly than applying data quality rules early in the ingestion phase. To help track and govern data activity, data governance must include:

- Data discovery

- Data quality

- Policy creation

- Data sharing

- Metadata

## Secure your analytics estate

Another major driver for data governance is data protection. Data protection can help you be compliant with regulatory legislation. It can help you prevent data breaches. Data privacy, and the growing number of data breaches, has made data protection a top priority in the boardroom. These breaches highlight the risk to sensitive data, such as personally identifiable customer data. The consequences of data privacy violation or a data security breach are many, and can include:

- Loss or serious damage to brand image

- Loss of customer confidence and market share

- Fall in share price, which impacts stakeholder return on investment and executive salary

- Major financial penalties because of audit or compliance failure

- Legal action

- The "domino effect" of the breach, for example, customers might fall victim to identity theft

In most cases, publicly quoted companies must declare these breaches.

If breaches occur, customers are more likely to blame the company first, rather than the hacker. The customer might boycott the company for several months or might never return.

Failure to comply with regulatory legislation on data privacy might result in significant financial penalties. Governing your data will help you avoid such risks.

## Operating model + benefits

Adopting a modern data strategy platform doesn't only change the technology that your organization uses, but also how it operates.

Cloud-scale analytics  provides prescribed guidance to help you consider how to organize and skill your people and teams including

- Persona, role, and responsibility definitions
- Suggested structures for agile, vertical, cross-domain teams
- Skilling resources, including Azure data and AI certifications via Microsoft Learn

It's also important that you engage your end users throughout the modernization process and as you continue to evolve your platform and onboard new use cases.

## Architectures

Azure landing zones represent the strategic design path and target technical state for your environment. They're for ease of deployment and governance to provide greater agility and compliance. They also ensure that when a new application or workload lands in your environment, the proper 'plumbing' is already in place. Azure data management and data landing zones are designed with these same foundational principles in mind and when combined with the other elements of the cloud-scale analytics, they can help to enable:

- Self-service
- Scalability
- Fast start
- Security
- Privacy
- Optimized operations

### Data management landing zone

The data management landing zone provides the foundation for your platform's centralized data governance and management across your organization.

It also facilitates communication to ingest data from your entire digital estate, including multicloud and hybrid infrastructure.

Supports numerous other data management and governance capabilities:

- Data catalog
- Data classification
- Data lineage
- Data quality management
- Data modeling repository
- Master data management
- API catalog
- Data sharing and contracts

### Data landing zone

Data landing zones bring data closer to users and enable self-service, while maintaining common management and governance via connection to the data management landing zone.

They host standard services like networking, monitoring, data ingestion and processing, as well as customizations like data products and visualizations.

Data landing zones are key to enabling your platform's scalability. Depending on your organization's size and needs, you can start with one or multiple landing zones.  
When deciding between single and multiple landing zones, consider regional dependencies and data residency requirements. Are there any local laws or regulations that require data to stay in a specific location?

Regardless of your initial decision, you can add or remove data landing zones as needed. If you're starting with one, we recommend that you plan to extend to multiple to avoid future needs for migration.

For more information, see [Azure landing zones for cloud-scale analytics](ready.md)

## Where to start?

One you've consumed this documentation set, in particular the governance, security, operating and best practices sections we would recommend trying to get a proof of concept environment running using the deployment templates. These templates, with the architecture guidance, will get you hand-on with some of the Azure technology stack. The [Getting Started Checklist](architectures/data-mesh-checklist.md) has four stages of maturity and items you need to start small with your first landing zone (stage 1) through to stage 4 (critical governance components) which can come later in your cloud-scale analytics deployment.

## Next steps

[Integrate cloud-scale analytics into your cloud adoption strategy](./strategy.md)
