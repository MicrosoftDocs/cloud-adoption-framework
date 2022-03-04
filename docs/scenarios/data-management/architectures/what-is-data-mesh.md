---
title: What is a data mesh?
description: Learn about data mesh in azure
author: simonlid
ms.author: simonlid
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# What is a data mesh?

## Background

The need for analytics is not new, companies has had the need for analyzing business performance and have done so using computers since the introduction of them. Around the 1980's companies started to build data warehousing solutions using databases specifically for decision support. These solutions served companies well for a long time.

However, as business has changed and with more and more diverse data being generated data warehousing solutions using relational databases was potentially not the best solution in many cases. In the 2000's big data was introduced as a common term and new solutions allowing analysis of large volumes of data with big diversity and generated with great velocity was quickly adopted. This included technology like data lakes and scale out solutions allowing analysis of large quantities of data.

In recent years architectural patterns that uses a combination of both the data warehousing technologies and the more recent big data technologies. This modern analytical pattern is now used by many organizations successfully.

:::image type="content" source="../images/azure-analytics-end-to-end.png" alt-text="Diagram of architecture." lightbox="../images/azure-analytics-end-to-end.png":::

However, some organizations have seen issues when deploying analytical solutions using this pattern.
Common for all these solutions is that they still are implemented as a monolithic solution, with a single team being the provider of the platform and being the team doing the data integration. This often works for smaller organizations or organizations that have a high degree of centralization from a team setup perspective. But larger organizations having a single team, this team quite often becomes a bottle neck. This often results in a huge backlog with parts of the company having to wait for data integration services and finished analytical solutions.

Many organizations have also seen this become a more common pattern with the adoption of data science within the company. The reason for this is that many data science solutions require more data compared to the more traditional business intelligence solutions adopted in the past.

Another driver for a longer backlog around data integration is the recent switch to micro services as a pattern for application development since the number of data sources increases with this switch.

Having a single team handling all of data ingestion on a single platform in a large organization can also be problematic because this team is seldom the experts on all the data sources. Most business and organizations are decentralized and distributed from a business perspective. You have different business units and departments handling different parts of the operation. This also means that the experts on the data is also spread throughout the organization.  

To address these problems a new architectural pattern called data mesh was introduced a couple of years ago. The intent behind this pattern is to create a way for distributed teams to work with and share information in an agile decentralized fashion.

This is not only a technical pattern but also requires organizational change. The benefits of a data mesh approach are achieved through adoption of the organizational change implementing multi disciplinary teams who both publish and consume data products.

To understand this architectural pattern, there are several foundational concepts that needs to be defined

* Data Domains
* Data Products
* Self Service Platform
* Federated Governance

## Data Domains

The foundation for data mesh is the concept around data domains. This is a concept that comes from Domain Driven Development, a paradigm that is often used in Software development as a way of modeling complex software solutions. In data mesh a data domain is a way of defining the boundaries around your enterprise data. Domains can vary a lot depending on your organization, in some cases you can define domains around your business organization. In other organizations you could choose to model your data domains based on business processes, or maybe you choose to model them around your source systems.

The most important aspect is that the boundaries that you choose renders itself to long term ownership meaning that it is something that will exists over a longer time and there is an identified owner. Another important thing to consider when you describe your data domains is that your domain should match reality and should not just be theoretical concept. The third aspect that you need to consider is if your domain has enough atomic integrity or if you just have group a bunch of different areas into a domain that really do not have any relationship with each other.

For a deeper understanding about data domains, see [What are data domains?](data-domains.md) which contains more information about data domain and how to define them.

## Data Products

Another important component of data mesh is the concept of data products. The idea of this is to take product thinking to the world of data. In product thinking there are several key definitions on how a success product is created.

First of all, a product needs to be usable. In the world of data mesh this means that there needs to be a set of users outside of the immediate data domain. Without usability there is no product.

The second aspect is that there the product needs to be valuable and that this value must exits over time.  If there is no long-term value to the product the product will not be successful. This is also true in the definition of a data product it needs to provide business value to the intended users
The last aspect is that the product needs to be feasible to build. If it cannot be built it will not be a successful product. Similar in the world of data products it needs to be possible to build it both from a data availability but also from a technical perspective.

Given this definition on how to define a successful product what is the definition of a product in the world of data mesh.  In data mesh a product is defined as the data together with the code assets that are needed to generate the data product, the meta data and the polices related to the data product. The data part of a product can be delivered in a number of ways, as an example it could be as a API, a report, a data set in a file on a data lake or a table. How it will be delivered is dependent on the users that will use the data product.

The code assets part of a data product would be the code that is used to generate the data product as well as the code that is used to deliver it. This would include the pipelines that are used to create the finished product as well as the report.

For more information about data products, see [Data management and analytics scenario data products and data applications in Azure](data-landing-zone-data-products.md) and for specific guidance about using this guidance in data mesh, see [What is a data product?](what-is-data-product.md).

## Self Service Platform

A core of data mesh is having a platform that allows the data domains to build their data products on their own. Meaning that they have the possibility to define their data products using the tools and processes that is relevant for their users without having a strong dependency on a central platform and a central platform team that maintains and create this platform. The reason for going for this decentralized model is that in a data mesh you will have many autonomous teams developing and managing autonomous products.

With the decentralization and alignment with business users that understands the data you will also have more generalists that will work on the platform this means that specialized tools that requires specialist knowledge of the platform cannot be the core foundation of a mesh-based platform.

Implementing this self-serve platform on Azure can be done successfully by adopting the practices defined in detail in the following [Design considerations for self-serve data platforms](self-serve-data-platforms.md).

## Federated Governance

With the adoption of a self-serve distributed data platform an increased effort needs to be placed on governance. Lacking this aspect of data mesh will lead to more silos and data duplication across the data domains. The governance needs to be federated as the people that understands the governance needs exits in the domain aligned teams and owners of the data.

To create this federated governance automated policies around both platform and data needs to be implemented. Something that will help with this federated governance platform is to adopt a high degree of automation for testing, monitoring but also with a code-first implementation strategy where standards, policies, data product and platform deployment is handled as code. More information around how to implement the federated governance aspects, see [Data Governance Overview](../govern.md).

## Summary

Data mesh can be a very effective way of implementing a enterprise data platform however it is not for all companies. It requires a distributed organization with a autonomous teams having the possibility to work independently. Typically it is adopted in large complex organizations with independent business units that has the need to scale adoption of analytics beyond a single platform and a single implementation team. Specific considerations needs to be taken around the governance aspect of a distributed platform to ensure that silos are not implemented. To be successful a product thinking around data has to be at the core of the implementation.

## Next Steps

[What are data domains?](data-domains.md)
