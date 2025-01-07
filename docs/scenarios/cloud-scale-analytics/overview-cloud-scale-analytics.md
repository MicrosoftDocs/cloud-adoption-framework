---
title: Introduction to Cloud-Scale Analytics
description: Learn about building and operationalizing landing zones to host and run cloud-scale analytics workloads.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Introduction to cloud-scale analytics

Cloud-scale analytics builds upon Azure landing zones to simplify deployment and governance. The main purpose of an Azure landing zone is to ensure that, when you deploy an application or workload on Azure, the required infrastructure is already in place. Before you deploy your cloud-scale analytics landing zone, you need to work through the [Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/) to deploy an [Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/) that has platform landing zones.

For sovereign workloads, Microsoft provides the [Sovereign Landing Zone (SLZ)](/industry/sovereignty/slz-overview), which is a variant of the enterprise-scale Azure landing zone. The SLZ is intended for organizations that need advanced sovereign controls. Cloud-scale analytics can be deployed against this Azure landing zone variant.

Cloud-scale analytics involves deploying to application landing zones. These zones typically reside under the landing zone management group. Policies filter down to the sample templates that Microsoft provides.

You can use these sample templates for your data lakehouse and [data mesh](architectures/what-is-data-mesh.md) deployments.

## Cloud-scale analytics evaluation

Often, a business seeks clarity or prescriptive guidance before it starts to define the technical details for a specific use case or project, or for end-to-end cloud-scale analytics. As a business formulates its overall data strategy, it can be challenging to ensure that all the required and strategic principles in the scope of the current use are taken into account.

To speed up the delivery of this end-to-end insights implementation, while taking these challenges into account, Microsoft has developed a prescriptive scenario for cloud-scale analytics. It aligns with the key themes that are discussed in [Develop a plan for cloud-scale analytics](../data-management/plan.md).

Cloud-scale analytics builds on the Cloud Adoption Framework and applies the principles of the Azure Well-Architected Framework. The Cloud Adoption Framework provides prescriptive guidance and best practices for cloud operating models, reference architectures, and platform templates. This guidance is based on real-world experiences from some of our most challenging, sophisticated, and complex environments.

Cloud-scale analytics helps you prepare to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of enhanced security, governance, and compliance. Landing zones are scalable and modular, but they support autonomy and innovation.

## History of data architecture

In the late 1980s, data warehouse generation 1 was introduced. This model combines disparate data sources from across an enterprise. In the late 2000s, generation 2 emerged, with the introduction of big data ecosystems like Hadoop and data lakes. The mid-2010s brought the cloud data platform: streaming data ingestion, like Kappa or Lambda architectures, were introduced. In the early 2020s, data lakehouses, data meshes, data fabrics, and data-centric operational patterns were introduced.

In spite of these advances, many organizations still use the centralized monolithic platform: generation 1. This system works well, up to a point. However, bottlenecks can occur because of interdependent processes, tightly coupled components, and hyperspecialized teams. Extract, transform, and load (ETL) jobs can become prominent and slow down delivery timelines.

Data warehouses and data lakes are still valuable and play an important role in your overall architecture. The following documentation highlights some of the challenges that can occur when you use these traditional practices for scaling. These challenges are especially relevant in a complex organization, where data sources, requirements, teams, and outputs change.

## Moving to cloud-scale analytics

Your current analytical data architecture and operating model can include data warehouse, data lake, and data lakehouse structures, data fabric, or data mesh.

Each data model has its own merits and challenges. Cloud-scale analytics helps you shift your current approach to data management so that it can evolve with your infrastructure.

You can support any data platform and scenario to create an end-to-end cloud-scale analytics framework that serves as your foundation and allows for scaling.

## Modern data platform and desired outcomes

One of the first steps is to activate your data strategy to meet your challenges by iteratively building a scalable and agile modern data platform.

Instead of being overwhelmed with service tickets and trying to meet competing business needs, when you implement a modern data platform, you can play a more consultative role because you can free up your time to focus on more valuable work. You provide lines of business with the platform and systems to self-serve data and analytics needs.

Following are recommended areas of initial focus:

- Improve data quality, facilitate trust, and gain insights to make data-driven business decisions.
- Implement holistic data, management, and analytics at scale, across your organization.
- Establish robust data governance that enables self-service and flexibility for lines of business.
- Maintain security and legal compliance in a fully integrated environment.
- Quickly create the foundation for advanced analytics capabilities by using an out-of-the-box solution of well-architected, repeatable, modular patterns.

## Govern your analytics estate

A second consideration is to determine how your organization will implement data governance.

Data governance is the process of ensuring that the data you use in your business operations, reports, and analysis is discoverable, accurate, trusted, and that it can be protected.

For many companies, the expectation is that data and AI will drive a competitive advantage. As a result, executives are eager to sponsor AI initiatives in their determination to become data driven. However, for AI to be effective, it must use trusted data. Otherwise, decision accuracy can be compromised, decisions might be delayed, or actions might be missed, which can affect the outcome. Companies don't want the quality of their data to be poor. Until you review the effect that digital transformation has had on data, it might seem simple to fix data quality.

Organizations that have data spread across a hybrid multicloud and distributed-data landscape struggle to find where their data is and to govern it. Ungoverned data can have a considerable effect on business. Poor data quality affects business operations because data errors cause process errors and delays. Poor data quality also affects business decision-making and the ability to remain compliant. Ensuring data quality at the source is often preferred because fixing quality issues in the analytical system can be more complex and costly than applying data quality rules early in the ingestion phase. To help you track and govern data activity, data governance must include:

- Data discovery.
- Data quality.
- Policy creation.
- Data sharing.
- Metadata.

## Secure your analytics estate

Another major driver for data governance is data protection. Data protection can help you ensure compliance with regulatory legislation and can prevent data breaches. Data privacy and the growing number of data breaches have made data protection a top priority. Data breaches highlight the risk to sensitive data, such as personally identifiable customer data. The consequences of data privacy violation or a data security breach can include:

- Serious damage to brand image.
- Loss of customer confidence and market share.
- A reduction in share price, which affects stakeholder return on investment and executive salaries.
- Significant financial penalties because of audit or compliance failures.
- Legal action.
- Secondary effects of the breach, for example, customers might fall victim to identity theft.

In most cases, publicly quoted companies must declare breaches. If breaches occur, customers are likely to blame the company rather than the hacker. Customers might boycott the company for several months or might never return.

Failure to comply with regulatory legislation on data privacy can result in significant financial penalties. Governing your data helps you avoid these risks.

## Operating model and benefits

Adopting a modern data strategy platform doesn't just change the technology that your organization uses. It also changes how the organization operates.

Cloud-scale analytics provides guidance to help you organize and train your employees, including:

- Persona, role, and responsibility definitions.
- Suggested structures for agile, vertical, and cross-domain teams.
- Training resources, including Azure data and AI certifications via Microsoft Learn.

It's also important to engage your end users throughout the modernization process and as you continue to evolve your platform and onboard new use cases.

## Architectures

Azure landing zones represent the strategic design path and target technical state for your environment. They make deployment and governance easier so that you can improve agility and compliance. They also ensure that, when a new application or workload is added to your environment, the proper infrastructure is already in place. Azure data management and data landing zones, integrated with Microsoft software as a service (SaaS) governance and analytics solutions, are designed with these foundational principles in mind and, when combined with the other elements of cloud-scale analytics, can help to enable:

- Self-service.
- Scalability.
- A fast start.
- Security.
- Privacy.
- Optimized operations.

### Data management landing zone

The data management landing zone provides the foundation for your platform's centralized data governance and management across your organization. It also facilitates communication to ingest data from your entire digital estate, including multicloud and hybrid infrastructures.

The data management landing zone supports numerous other data management and governance capabilities, such as:

- Data catalogs.
- Data quality management.
- Data classification.
- Data lineage.
- Data modeling repositories.
- API catalogs.
- Data sharing and contracts.

> [!TIP]
> If you use partner solutions for data catalog, data quality management, or data lineage capabilities, they should reside in the data management landing zone. Alternatively, you can deploy Microsoft Purview as a SaaS solution, connecting to both the data management landing zone and the data landing zones.

### Data landing zones

Data landing zones bring data closer to users and enable self-service while maintaining common management and governance via connection to the data management landing zone.

They host standard services like networking, monitoring, and data ingestion and processing, in addition to customizations like data products and visualizations.

Data landing zones are key to enabling your platform's scalability. Depending on your organization's size and needs, you can start with one or multiple landing zones.

When you decide between single and multiple landing zones, consider regional dependencies and data residency requirements. For example, are there local laws or regulations that require data to stay in a specific location?

Regardless of your initial decision, you can add or remove data landing zones as needed. If you start with a single landing zone, we recommend that you plan to extend to multiple landing zones to avoid future needs for migration.

> [!NOTE]
> Where Microsoft Fabric is deployed, the data landing zone hosts non-SaaS solutions like data lakes and other Azure data services.

For more information about landing zones, see [Azure landing zones for cloud-scale analytics](../data-management/ready.md).

## Conclusion

After you read this documentation set, in particular the governance, security, operating, and best practices sections, we recommend that you set up a proof-of-concept environment by using the deployment templates. These templates, along with architecture guidance, give you hands-on experience with some of the Azure and Microsoft SaaS technologies. For more information, see the [Getting started checklist](architectures/data-mesh-checklist.md).

## Next step

> [!div class="nextstepaction"]
> [Integrate cloud-scale analytics into your cloud adoption strategy](../data-management/strategy.md)