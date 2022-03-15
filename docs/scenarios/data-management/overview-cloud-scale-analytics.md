---
title: Cloud-scale analytics overview
description: Learn about cloud-scale analytics for Azure.
author: mboswell
ms.author: mboswell
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Introduction to cloud-scale analytics

Cloud-scale analytics builds upon Azure landing zones for ease of deployment and governance. The principal purpose of an Azure landing zone is to ensure that when an application or workload lands on Azure, the required "plumbing" is already in place. There are sample templates, which get you started which can be used for data lakehouse and [data mesh](architectures/what-is-data-mesh.md) deployments. They provide agility and compliance with security and governance requirements. Azure landing zones must be in place before you deploy your first cloud-scale analytics landing zones.

## Cloud-scale analytics evaluation

Often businesses seek clarity or prescriptive guidance before they start to carve out the technical details for a specific use case, project, or an end-to-end cloud-scale analytics. It can be challenging to ensure that all strategic and required principles in the scope of the current use are considered for how the overall data strategy is formulated.

To speed up the delivery of this end-to-end insights journey while still keeping these challenges in mind, Microsoft has developed a prescriptive scenario for cloud-scale analytics. It aligns to the key themes discussed in [Develop a plan for cloud-scale analytics](plan.md).

Cloud-scale analytics builds on top of the Microsoft Cloud Adoption Framework whilst applying our Well-Architected framework lens. Microsoft Cloud Adoption Framework provides prescriptive guidance and best practices on cloud operating models, reference architecture, and platform templates. It's based on real-world learnings from some of our most challenging, sophisticated, and complex environments.

Cloud-scale analytics paves the way for customers to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of security, governance, and compliance. They're scalable and modular while supporting autonomy and innovation.

## Observations of existing architectures

In the late 1980s, there was the introduction of the data warehouse generation 1, which combined disparate data sources from across the enterprise. In the late 2000s came Gen2, with the introduction of the big data ecosystem like Hadoop and the data lake. In the mid 2010s, we had the cloud data platform. It was similar to previous generations, but with the introduction of the ingestion of streaming data, like kappa or lambda architectures. The early 2020s introduced the concepts of the data lakehouse, data mesh, data fabric, and data-centric operational patterns.

Understanding the evolution and looking forward, many organizations still have the centralized monolithic platform, generation 1. This system works well, up to a point. Bottlenecks because of interdependent processes, tightly coupled components, hyperspecialized teams, and thousands of extract, transform, load (ETL) jobs become prominent and can slow down delivery timelines.

The data warehouse and data lake is still valuable, and will play an important role in your overall architecture. We're highlighting some of the challenges that inevitably come forth when using these traditional practices. These challenges are especially relevant in a complex organization, where data sources, requirements, teams, and outputs change.

## Implementation Patterns tied to new approach to data management

Your current analytical data architecture and operating model could align include data warehouse, data lake, or data lakehouse structures – or even an emerging model like data fabric or data mesh.

Each has its own merits and challenges, and cloud-scale analytics helps you work from where you are now to shift your approach to data management so it can evolve with your infrastructure.

You can support any data platform with the scenario to create an end-to-end cloud-scale analytics framework that can serve as your foundation and allow for scaling.  

## Modern data platform and desired outcomes

To activate your data strategy to overcome your challenges by iteratively building a scalable and agile modern data platform.

Rather than drowning in service tickets and trying to meet competing business needs, a modern data platform enables you to play a more consultative role, freeing up your time to focus on more valuable work. You provide lines of business with the platform and systems to self-serve their data and analytics needs.

Recommended areas of initial focus are:

- Improve data quality, facilitate trust, and gain insights to make data-driven business decisions.

- Seamlessly implement holistic data, management, and analytics at scale, across your organization.

- Establish robust data governance that enables self-service and flexibility for lines of business.

- Maintain security and legal compliance in a fully-integrated environment.

- Quickly create the foundation for advanced analytics capabilities with an out-of-the-box solution of well-architected, repeatable, modular patterns.

## Data governance

The first consideration is how will the organization implement data governance?

Data governance is how you ensure data that is used in your business operations, reports, and analysis is discoverable, accurate, trusted, and can be protected.

There are many reasons why data governance is needed. These reasons include the need to govern data to maintain its quality and the need to protect it. To support this protection, you must discover data in your organization by cataloging, scanning, and classifying your data.

- Data governance is needed to improve data quality, so that data is trusted.

- Data quality is important because when companies work with inferior data, it negatively impacts their downstream insights, analysis, and recommendations.

- Data quality requires that the data is complete, unique, valid, timely, accurate, and consistent.

- Data quality problems can affect business operations. Poor data quality can cause process errors, process delays, unplanned operational costs, and inaccurate decisions.

- Data must be governed across a distributed computing environment.

## Trusted data

For many companies, the expectation in the boardroom is that data and AI will drive competitive advantage. As a result, executives are eager to sponsor AI initiatives in their determination to become data-driven. For AI to become effective, the data it is using must be trusted. Otherwise, decision accuracy might be compromised, decisions might be delayed, or actions might be missed, which can affect on the bottom line. Companies do not want the quality of their data to be "garbage in, garbage out". It might seem simple to fix data quality, until you look at the effect that digital transformation has had on data.

For many companies, the introduction of digital transformation has led to a more complex operating environment. The environment spans the edge, multiple clouds, and datacenters. This can mean that both operational and analytical systems are running in the cloud and the datacenter. Examples of operational transaction processing systems that run in the cloud include Microsoft Dynamics 365, Workday, Salesforce, ServiceNow, and Marketo. Analytical systems that run in the cloud might include data warehouses, graph databases, data lakes used by data scientists, and real-time IoT streaming analytic applications. The result is that companies have a hybrid environment with data in multiple data stores, spread across their digital landscape.

These data stores include data stored in edge databases, relational or NoSQL database management systems, files, cloud storage, Hadoop systems, and scalable message queuing systems, like Kafka.

The other effect of digital transformation is there are many new data sources that organizations want to analyze. These data sources go beyond the traditional data found in data warehouses. These sources include machine generated data like clickstream data in web server log files, human generated data from social networks, inbound email, and open government data.
In addition to these relational data sources unstructured or semi-structured data like images, videos, documents, and logs are valuable data sources that is used in organizations for analytical purposes.

With data spread out across a hybrid multicloud and a distributed-data landscape, organizations struggle to find where their data is, to govern it. The ungoverned data can have a considerable effect on the business. Poor data quality impacts business operations because data errors cause process errors and delays. Poor data quality also affects business decision making and the ability to remain compliant. Ensuring data quality at the source is often preferred since fixing quality issues in the analytical system is often more complex and costly than applying data quality rules early in the ingestion phase. To help track and govern data activity, data governance must include:

- Data discovery

- Data quality

- Policy creation

- Data sharing

- Metadata

### The need to protect data

The other major driver for data governance is data protection. Data protection can help you be compliant with regulatory legislation. It can help you prevent data breaches. Data privacy, and the growing number of data breaches, has made data protection a top priority in the boardroom. These breaches highlight the risk to sensitive data, such as personally identifiable customer data. The consequences of data privacy violation or a data security breach are many, and can include:

- Loss or serious damage to brand image

- Loss of customer confidence and market share

- Fall in share price, which impacts stakeholder return on investment and executive salary

- Major financial penalties because of audit or compliance failure

- Legal action

- The "domino effect" of the breach, for example, customers might fall victim to identity theft

In most cases, publicly quoted companies must declare these breaches.

If breaches occur, customers are more likely to blame the company first, rather than the hacker. The customer might boycott the company for several months or might never return.

Failure to comply with regulatory legislation on data privacy might result in significant financial penalties. Governing your data will help you avoid such risks.

## Next steps

[Integrate cloud-scale analytics into your cloud adoption strategy](./strategy.md)
