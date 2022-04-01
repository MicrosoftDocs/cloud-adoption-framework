---
title: What is a data mesh?
description: Learn about data mesh in azure
author: simonlid
ms.author: simonlid
ms.date: 04/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# What is a data mesh?

Data mesh is an architectural pattern that creates an efficient way of implementing an enterprise data platform in large complex organizations. It helps to scale adoption of analytics beyond a single platform and a single implementation team.

## Background

The need for analytics is not new, companies has had the need for analyzing business performance and have done so using computers since the introduction of them. Around the 1980's, companies started to build data warehousing solutions using databases specifically for decision support. These solutions served companies well for a long time.

However, as business has changed and with more and more diverse data being generated data warehousing solutions using relational databases was potentially not the best solution in many cases. In the 2000's, big data was introduced as a common term and new solutions allowing analysis of large volumes of data with big diversity and generated with great velocity was quickly adopted. This included technology like data lakes and scale out solutions allowing analysis of large quantities of data.

In recent years, the modern architectural and analytical patterns that uses a combination of both the data warehousing technologies and the more recent big data technologies are being used by many organizations successfully.

:::image type="content" source="../images/azure-analytics-end-to-end.png" alt-text="Diagram of architecture." lightbox="../images/azure-analytics-end-to-end.png":::

However, some organizations have seen issues when deploying analytical solutions using this pattern. Common for all these solutions is that they are still implemented as a monolithic solution, with a single team being the provider of the platform and being the team doing the data integration. This often works for smaller organizations or organizations that have a high degree of centralization from a team setup perspective. But larger organizations having a single team, this team quite often becomes a bottle neck. This often results in a huge backlog with parts of the company having to wait for data integration services and finished analytical solutions.

Many organizations have also seen this become a more common pattern with the adoption of data science within the company. The reason for this is that many data science solutions require more data compared to the more traditional business intelligence solutions adopted in the past.

Another driver for a longer backlog around data integration is the recent switch to micro services as a pattern for application development since the number of data sources increases with this switch.

Having a single team handling all of data ingestion on a single platform in a large organization could also be problematic because this team is seldom the experts on all the data sources. Most business and organizations are decentralized and distributed from a business perspective. You have different business units and departments handling different parts of the operation. This also means that the experts on the data is also spread throughout the organization.  

To address these problems, a new architectural pattern called data mesh was introduced a couple of years ago. The intent behind this pattern is to create a way for distributed teams to work with and share information in an agile decentralized fashion.

This technical pattern requires organizational change. The benefits of a data mesh approach are achieved through adoption of the organizational change implementing multi disciplinary teams that publish and consume data products.

The following concepts are the foundational concepts to understand this architectural pattern:

* Data Domains
* Data Products
* Self Service Platform
* Federated Governance

## Data Domains

Data Domain is the foundation for data mesh. This concept  comes from Domain Driven Development, a paradigm that is often used in Software development as a way of modeling complex software solutions. In data mesh a data domain is a way of defining the boundaries around your enterprise data. Domains can vary a lot depending on your organization, in some cases you can define domains around your business organization. In other organizations you could choose to model your data domains based on business processes, or source systems.

There are three aspects to data domains:

- The most important aspect is that the boundaries that you choose renders itself to long term ownership meaning that it is something that exists over a longer time and there is an identified owner.

- Another important thing to consider when you describe your data domains is that your domain should match reality and should not just be theoretical concept.

- If your domain has enough atomic integrity or if you just have a group of different areas into a domain, that really do not have any relationship with each other.

For more information about data domain and how to define them, see [What are data domains?](data-domains.md).

## Data Products

Another important component of data mesh is the concept of data products. The idea of data products is to take the products thinking to the world of data.
In order for the data product to be successful, it needs to provide a long term business value to the intended users.

In data mesh, a product is defined as the data with code assets to generate data product, meta data, and the polices related to the data product.

The data part of a product is dependent on the users that use the data product. The data product can be delivered as an API, a report, a data set in a file on a data lake or a table.

The success of the product is assessed if the product is:

- Usuable\
    A product needs to be usable. In the world of data mesh this means that there needs to be a set of users outside of the immediate data domain.

- Valuable\
    The second aspect is that the product needs to be valuable and its value must exist over time.  If there is no long-term value to the product, the product will not be successful.

- Feasible\
The last aspect is that the product needs to be feasible to build. If it cannot be built it will not be a successful product. Similar in the world of data products it needs to be possible to build it both from a data availability but also from a technical perspective.

The code assets part of a data product would be the code that is used to generate the data product as well as the code that is used to deliver it. This would include the pipelines that are used to create the finished product as well as the report.

For more information about data products, see [Cloud-scale analytics data products and data applications in Azure](data-landing-zone-data-products.md).

For specific guidance about using the data mesh, see [What is a data product?](what-is-data-product.md).

## Self Service Platform

A core of data mesh is having a platform that allows the data domains to build their data products on their own. Meaning that they have the possibility to define their data products using the tools and processes that are relevant for their users without having a strong dependency on a central platform and a central platform team that maintains and create this platform. The reason for going for this decentralized model is that in a data mesh you will have many autonomous teams developing and managing autonomous products.

With the decentralization and alignment with business users that understands the data you will also have more generalists that will work on the platform this means that specialized tools that requires specialist knowledge of the platform cannot be the core foundation of a mesh-based platform.

Implementing this self-serve platform on Azure can be done successfully by adopting the practices defined in detail in the  [Design considerations for self-serve data platforms](self-serve-data-platforms.md).

## Federated Governance

With the adoption of a self-serve distributed data platform, an increased effort needs to be placed on governance. Lacking this aspect of data mesh will lead to more silos and data duplication across the data domains. The governance needs to be federated as the people that understands the governance need exits in the domain aligned teams and owners of the data.

To create this federated governance automated policies around both platform and data you can adopt a high degree of automation for testing, monitoring and with a code-first implementation strategy where standards, policies, data product and platform deployment is handled as code.

For more information about how to implement the federated governance aspects, see [Data Governance Overview](../govern.md).

## Summary

Data mesh is an effective way of implementing an enterprise data platform in large complex organizations with independent business units that has the need to scale adoption of analytics beyond a single platform and a single implementation team. It requires a distributed organization with an autonomous teams having the possibility to work independently. Specific considerations needs to be taken around the governance aspect of a distributed platform to ensure that silos are not implemented. To be successful a product thinking around data has to be at the core of the implementation.

## Next Steps

[What are data domains?](data-domains.md)
