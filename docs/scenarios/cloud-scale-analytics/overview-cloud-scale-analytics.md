---
title: Introduction to cloud-scale analytics
description: Learn about cloud-scale analytics for Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Introduction to cloud-scale analytics

Cloud-scale analytics builds upon Azure landing zones for ease of deployment and governance. The main purpose of an Azure landing zone is to ensure that, when an application or workload lands on Azure, the required infrastructure is already in place. Before you deploy your cloud-scale analytics landing zone, you must have already worked through the [cloud adoption framework](/azure/cloud-adoption-framework/) to deploy an [Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/) with platform landing zones.

For sovereign workloads, Microsoft has the [Sovereign Landing Zone (SLZ)](/industry/sovereignty/slz-overview), which is a variant of the enterprise-scale Azure Landing Zone intended for organizations that need advanced sovereign controls. Cloud-scale analytics can be deployed against this variant of Azure Landing Zone.

Cloud-scale analytics involves deploying to application landing zones. These zones typically reside under the landing zone management group, with policies filtering down to the sample templates provided by Microsoft.

Microsoft provides sample templates to get you started, which you can use for your data lakehouse and [data mesh](architectures/what-is-data-mesh.md) deployments.

## Cloud-scale analytics evaluation

Often, a business seeks clarity or prescriptive guidance before it starts to carve out the technical details for a specific use case, project, or end-to-end cloud-scale analytics. As a business formulates its overall data strategy, it can be challenging to ensure that it considers all the strategic and required principles in the scope of the current use.

To speed up the delivery of this end-to-end insights journey, while keeping these challenges in mind, Microsoft has developed a prescriptive scenario for cloud-scale analytics. It aligns with the key themes discussed in [Develop a plan for cloud-scale analytics](../data-management/plan.md).

Cloud-scale analytics builds on top of the Microsoft Cloud Adoption Framework, while applying the Microsoft Azure Well-Architected Framework lens. The Microsoft Cloud Adoption Framework provides prescriptive guidance and best practices on cloud operating models, reference architecture, and platform templates. It's based on real-world learnings from some of our most challenging, sophisticated, and complex environments.

Cloud-scale analytics paves the way for customers to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of security, governance, and compliance. They're scalable and modular, while supporting autonomy and innovation.

## History of data architecture

In the late 1980s, data warehouse generation 1 was introduced, which combined disparate data sources from across the enterprise. In the late 2000s came Gen2, with the introduction of big data ecosystems like Hadoop and data lake. The mid-2010s brought the cloud data platform. It was similar to previous generations, but with the introduction of streaming data ingestion, like kappa or lambda architectures. The early 2020s introduced the concepts of the data lakehouse, data mesh, data fabric, and data-centric operational patterns.

In spite of these advances, many organizations still use the centralized monolithic platform, generation 1. This system works well, up to a point. However, bottlenecks can occur because of interdependent processes, tightly coupled components, and hyperspecialized teams. Extract, transform, and load (ETL) jobs can become prominent and slow down delivery timelines.

Data warehouse and data lake are still valuable and play an important role in your overall architecture. In the documentation that follows, we've highlighted some of the challenges that can occur when using these traditional practices to scale. These challenges are especially relevant in a complex organization, where data sources, requirements, teams, and outputs change.

## Moving to cloud-scale analytics

Your current analytical data architecture and operating model can include data warehouse, data lake, and data lakehouse structures, data fabric, or data mesh.

Each data model has its own merits and challenges. Cloud-scale analytics helps you work from your current setup to shift your approach to data management so that it can evolve with your infrastructure.

You can support any data platform and scenario to create an end-to-end cloud-scale analytics framework that serves as your foundation and allows for scaling.

## Modern data platform and desired outcomes

One of the first focus areas is to activate your data strategy to meet your challenges by iteratively building a scalable and agile modern data platform.

Instead of being overwhelmed with service tickets and trying to meet competing business needs, a modern data platform enables you to play a more consultative role by freeing up your time to focus on more valuable work. You provide lines of business with the platform and systems to self-serve data and analytics needs.

Recommended areas of initial focus are:

- Improve data quality, facilitate trust, and gain insights to make data-driven business decisions.
- Seamlessly implement holistic data, management, and analytics at scale, across your organization.
- Establish robust data governance that enables self-service and flexibility for lines of business.
- Maintain security and legal compliance in a fully integrated environment.
- Quickly create the foundation for advanced analytics capabilities, with an out-of-the-box solution of well-architected, repeatable, modular patterns.

## Govern your analytics estate

A second consideration is to determine how the organization implements data governance.

Data governance is how you ensure that the data you use in your business operations, reports, and analysis is discoverable, accurate, trusted, and can be protected.

For many companies, the expectation is that data and AI will drive a competitive advantage. As a result, executives are eager to sponsor AI initiatives in their determination to become data-driven. However, for AI to become effective, the data it's using must be trusted. Otherwise, decision accuracy can be compromised, decisions might be delayed, or actions might be missed, which can affect the bottom line. Companies don't want the quality of their data to be garbage in, garbage out. At first, it might seem simple to fix data quality until you look at the effect that digital transformation has had on data.

With data spread out across a hybrid multicloud and a distributed-data landscape, organizations struggle to find where their data is and to govern it. The ungoverned data can have a considerable effect on the business. Poor data quality impacts business operations because data errors cause process errors and delays. Poor data quality also affects business decision-making and the ability to remain compliant. Ensuring data quality at the source is often preferred because fixing quality issues in the analytical system can be more complex and costly than applying data quality rules early in the ingestion phase. To help track and govern data activity, data governance must include:

- Data discovery
- Data quality
- Policy creation
- Data sharing
- Metadata

## Secure your analytics estate

Another major driver for data governance is data protection. Data protection can help you be compliant with regulatory legislation and can prevent data breaches. Data privacy and the growing number of data breaches have made data protection a top priority in the boardroom. These breaches highlight the risk to sensitive data, such as personally identifiable customer data. The consequences of data privacy violation or a data security breach are many and can include:

- Loss or serious damage to brand image
- Loss of customer confidence and market share
- Fall in share price, which impacts stakeholder return on investment and executive salary
- Major financial penalties because of audit or compliance failure
- Legal action
- The domino effect of the breach, for example, customers might fall victim to identity theft

In most cases, publicly quoted companies must declare these breaches. If breaches occur, customers are more likely to blame the company first, rather than the hacker. The customer might boycott the company for several months or might never return.

Failure to comply with regulatory legislation on data privacy can result in significant financial penalties. Governing your data help you avoid such risks.

## Operating model and benefits

Adopting a modern data strategy platform doesn't only change the technology that your organization uses, but also how it operates.

Cloud-scale analytics provides prescribed guidance to help you consider how to organize and skill your people and teams, including:

- Persona, role, and responsibility definitions
- Suggested structures for agile, vertical, and cross-domain teams
- Skilling resources, including Azure data and AI certifications via Microsoft Learn

It's also important to engage your end users throughout the modernization process, and as you continue to evolve your platform and onboard new use cases.

## Architectures

Azure landing zones represent the strategic design path and target technical state for your environment. They allow ease of deployment and governance to provide greater agility and compliance. Azure landing zones also ensure that when a new application or workload lands in your environment, the proper infrastructure is already in place. Azure data management and data landing zones, integrated with Microsoft software-as-service governance and analytics solutions, are designed with these same foundational principles in mind and, when combined with the other elements of cloud-scale analytics, can help to enable:

- Self-service
- Scalability
- Fast start
- Security
- Privacy
- Optimized operations

### Data management landing zone

The data management landing zone provides the foundation for your platform's centralized data governance and management across your organization. It also facilitates communication to ingest data from your entire digital estate, including multicloud and hybrid infrastructure.

The data management landing zone supports numerous other data management and governance capabilities, such as:

- Data catalog
- Data quality management
- Data classification
- Data lineage
- Data modeling repository
- API catalog
- Data sharing and contracts

> [!TIP]
> If you're using partner solutions for data catalog, data quality management, or data lineage capabilities, they should reside in the data management landing zone. Alternatively, Microsoft Purview can be deployed as a software-as-a-service solution, connecting to both the data management landing zone and the data landing zones.

### Data landing zones

Data landing zones bring data closer to users and enable self-service while maintaining common management and governance via connection to the data management landing zone.

They host standard services like networking, monitoring, data ingestion and processing, as well as customizations like data products and visualizations.

Data landing zones are key to enabling your platform's scalability. Depending on your organization's size and needs, you can start with one or multiple landing zones.

As you decide between single and multiple landing zones, consider regional dependencies and data residency requirements. For example, are there local laws or regulations that require data to stay in a specific location?

Regardless of your initial decision, you can add or remove data landing zones as needed. If you're starting with a single landing zone, we recommend that you plan to extend to multiple landing zones to avoid future needs for migration.

> [!NOTE]
> Where Microsoft Fabric has been deployed, the data landing zone hosts non-software-as-service solutions such as data lakes and other Azure data services.

For more information about landing zones, see [Azure landing zones for cloud-scale analytics](../data-management/ready.md).

## Conclusion

After you've read this documentation set, in particular the governance, security, operating, and best practices sections, we recommend you set up a proof-of-concept environment by using the deployment templates. These templates, along with architecture guidance, give you hands-on experience with some of the Azure and Microsoft software-as-a-service technologies. For more information, see the [Getting started checklist](architectures/data-mesh-checklist.md).

## Next steps

> [!div class="nextstepaction"]
> [Integrate cloud-scale analytics into your cloud adoption strategy](../data-management/strategy.md)