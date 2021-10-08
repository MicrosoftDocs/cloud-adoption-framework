---
title: Financial institution scenario for data mesh
description: Learn about data mesh scenario for data management and analytics in Azure.
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 10/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.custom: think-tank, e2e-data
---

# Financial institution scenario for data mesh

This reference architecture is written for customers that want to use enterprise-scale for analytics and AI for scalability and data mesh architectures. It demonstrates a more complex scenario with multiple landing zones, data integrations, and data products.

## Customer profile

Woodgrove Bank is a very large financial services company with a world-wide footprint. Woodgrove Bank’s data is housed in many different systems, which include on-premises and cloud deployments. Within Woodgrove Bank’s architecture there are several data warehouse systems for consolidated marketing and integrated reporting. This architecture also includes several data lakes for ad-hoc analytics and data discovery. Lastly, many of Woodgrove Bank’s applications are interconnected via application integration patterns, which are mostly API- or event-based.

## Current situation

Woodgrove Bank finds it challenging to distribute data towards different locations because of the data warehousing complexity. Integrating new data is time consuming and it’s tempting to duplicate data. Woodgrove Bank also finds it very hard to oversee the end-to-end data landscape because of point-to-point connectivity. Lastly, Woodgrove Bank underestimated the sheer demand for intensive data consumption. New use cases are quickly introduced one after another. Data governance, such as data ownership and quality, and costs are hard to control. Keeping up with regulation difficult since Woodgrove Bank doesn’t know where data exactly resides. 

A critical concern for Lamna is the security of the patient data. As a healthcare company, they are subject to several different data protection laws.

## Architecture solution: Data Mesh

Over the past several years, organizations have recognized that data is at the hearth of everything. Data opens new efficiencies, drives innovation, unlocks new business models, and increases customer satisfaction. Becoming data-driven -utilizing data at scale- remains top priority for most companies.
Reaching a stage where the deeper value of data becomes accessible for all organization members is challenging. Legacy and tightly interconnected systems, centralized monolithic platforms, and complex governance are barriers for generating value out of data. It’s not without a reason why data mesh gains a lot of traction.


### Data mesh

The Data Mesh concept, which term has been coined by Zhamak Dehghani, encompasses data, technology, processes, and organization. On a conceptual level it is a democratized approach of managing data where different domains operationalize their own data. It challenges conventional centralization of data: rather than looking at data as one huge data repository, data mesh considers decomposition of independent data products. This shift, from centralized to federated ownership, is backed by a modern and self-service data platform, which is typically designed using cloud-native technologies. 

When breaking down the concept into building blocks there are some key points you need to consider:

•	*Data as a product*: each (organizational) domain operates their data end to end. The accountability lies with the data owner within the domain. Pipelines in this respect become a first-class concern of the domains themselves.
•	*Federated data governance*: to ensure everybody can trust and share their data products, an enterprise data governance body must implement data quality, central visibility of data ownership, data access management and data privacy policies.
•	*Domain boundaries*: each data domain, node within the mesh, should ideally be defined and modeled by leveraging principles of domain-oriented design.
•	*Data platform*: a data mesh requires self-serve data platform that allows users to abstract the technical complexity and focus on their individual data use cases.

### Cloud Adoption Framework for Data Management and Analytics

Data-as-a-product thinking and self-service platform paradigm aren’t new to Microsoft. We have observed the best practices of distributed platforms, pipelines across domains, federated ownership, and self- explanatory data over the past years.

To support Woodgrove Bank in this transition, they can leverage Cloud Adoption Framework (CAF) for Data Management and Analytics: an open-source and prescriptive blueprint for designing and quickly deploying modern data platforms. It has been coupled with Azure best practices, design principles, and is aligned with our Cloud Adoption Framework and Well-Architected Framework. CAF aims to provide you an 80% prescribed viewpoint with the ability for to customize the remaining 20%.

With respect to data mesh, CAF offers a strategic design path towards data mesh. CAF can be used to quickly provision such an architecture. It offers a blueprint, including core data platform services for data management. 

At the highest level, CAF utilizes a data management capability, which is enabled through the data management landing zone. This zone is responsible for the federated data governance of an organization of the (self-service) platform, as well as the data domains which drive business value through data products. The benefit of this approach is that it abstracts all technical complexity away, while adhering to the same standards. It ensures that there is no proliferation of technology. It also allows you to start modular using a small footprint and grow over time. The data management zone, as you can see, surrounds all data domains. It glues all domains together and provides the oversight, which Woodgrove Bank is looking for.

:::image type="content" source="../images/data-mesh-plane.png" alt-text="Diagram showing abstract data mesh" lightbox="../images/data-mesh-plane.png":::

CAF also advocates consistent governance using a common architecture when distributing data products. It allows direct communication between domains, while staying fully in control by placing a strong emphasis on central cataloging and classification to protect data and allow various groups to discover data. It places an umbrella on top of your data estate.

### Data Domains

When using CAF as a strategic path you need to think of the decomposition of your architecture and the granularity. Data Mesh, in this respect, decomposes data by not following the borders of technologies. Instead, it leverages the principles of Domain-Driven Design: an approach to software development that involves complex systems for larger organizations, originally described by Eric Evans. DDD is popular because many of its impact it had on modern software and application development practices, such as microservices.

One of the patterns from domain-driven design is called bounded context. Bounded contexts are used to set the logical boundaries of a domain’s solution space for better managing complexity. It’s important that teams understand which aspects, including data, they can change on their own and which are shared dependencies for which they need to coordinate with others. Data mesh embraces bounded context and uses this pattern for describing how organizations can organize around data domains with a focus on delivering data as a product. Each data domain, in this regard, owns and operates multiple data products with its own technology stack, which is independent from others.

:::image type="content" source="../images/data-mesh-architecture.png" alt-text="Diagram showing data mesh architecture" lightbox="../images/data-mesh-plane.png":::

#### Data product

When zooming in on the inner architecture of such a data domain, we expect to find data products.

Data products fulfil a specific need within a business using data. Data products manage, organize and make sense of the data across domains and present the insights gained from the data products. A data product is a result of data from one or many data integrations and/or other data products. Data products, as you expect, are closely aligned with data domains, and inherit the same ubiquitous language: a constructed, formalized language, agreed upon by stakeholders and designers, to serve the needs of your design. Each domain, which generates data, is responsible for making these data products available to the other domains.

For quickly delivering data products, CAF delivers various templates for data distribution and integration patterns. CAF provides Data Batch, Streaming and Analytics for addressing the needs of a diverse set of consumers. One great thing of CAF is how domains and data products are organized. Each data domain aligns to one data landing zone, which is a logical construct and a unit of scale in the CAF’s architecture that enables data retention and execution of data workloads for generating insights and value with data. Each data product aligns to one resource group within the data landing zone, and all data landing zones and management zones align to subscriptions. This approach eases implementation and management.

All CAF’s templates inherit the same set of policies from the data management landing zone. They automatically deliver all necessary metadata for data discoverability, governance, security, cost management and operational excellence. This approach allows you to quickly onboard new data domains without the need of complex onboarding, integrating, and testing. The following diagram illustrates what a data product might look like.

:::image type="content" source="../images/data-mesh-product.png" alt-text="Diagram showing data product" lightbox="../images/data-mesh-product.png":::

A pragmatic approach to build data products is to either align with the source, where the data originates, or with the consuming use case. In both cases you need to provide an abstract view of the underlying (complex) application data model. You must try to hide the technical details and optimize for intensive data consumption. A Synapse view or parquet file, which logically groups data together is a good example of how a data product can be shared across different data domains.

Next, you need to work on data discoverability, provenance, usage, and lineage. A proven approach is to use a data governance service, like Azure Purview, to register all data. From this standpoint, CAF’s data integration perfectly connects the dots, because it allows building these data products, while simultaneously performing metadata registration. Data Integration Teams (also known as Integration Ops) are responsible for ingestion of data to a read data source. The data shouldn’t have any data transformation applied apart from data quality checks and data types being applied.

By using data integration, aligning data domains and Purview’s collections you automatically capture all data origin, lineage, data quality details and consumption information from the individual domains. With this approach, you can connect multiple data domains and products to a centralized governance solution, which stores all the metadata from each environment. The benefit is that it centrally integrates all the metadata and makes it easily accessible for various consumers. You can extend this architecture to register new data products. 

The following diagram illustrates a cross-domain data mesh architecture using CAF’s data integration.

:::image type="content" source="../images/data-mesh-integration.png" alt-text="Diagram showing data integration" lightbox="../images/data-mesh-integration.png":::

The network design allows simple sharing of datasets across domains without bandwidth limitations, single point of failures and minimal cost. For security you can leverage Microsoft’s Zero Trust security model. CAF proposes the use of network isolation through private endpoints and private network communication, an identity driven data access model using MIs, UMIs and nested security groups following the least privilege principle. You can use managed identities to ensure a least privilege access model is followed. Applications and services in this model will have limited access to data products. Azure Policies in conjunction with the upcoming data policies are used to enable self-service and enforce compliant resources within all data products at scale. With this design you can have uniform data access, while staying fully in control via centralized data governance and auditing.

:::image type="content" source="../images/data-mesh-contract.png" alt-text="Diagram showing data contract" lightbox="../images/data-mesh-contract.png":::

#### How to evolve in the future

The Cloud Adoption Framework for Data Management and Analytics is designed with data mesh in mind. CAF provides a proven approach by which organizations can share data across many data domains. CAF allows domains to have autonomy to make choices but at the same time it governs the architecture by ring-fencing it with data management services.

A consideration you must make, when implementing data mesh, is how to logically group and organize your domains. This requires an enterprise view and is also a cultural shift. It requires you to federate data ownership among data domain and owners who are held accountable for providing their data as products. It also requires teams to conform to centralized capabilities offered by the data management zone. This might require individual teams give up their mandate and is likely to spark resistance. You may have to make political choices and strike a balance between what must be operated central and decentral.

Scaling a data mesh architecture is accomplished by adding more landing zones to the architecture for the individual domains. These landing zones will use VNet peering to connect to the data management zone and all the other landing zones. This pattern allows datasets and resources to be shared across zones. By splitting into different zones, the workloads are spread across Azure subscriptions and resources. This approach allows enterprises to implement a data mesh organically.

## Learn more

- [Data management landing zone template](https://github.com/Azure/data-management-zone)
- [Data landing zone template](https://github.com/Azure/data-landing-zone)
- [How to Move Beyond a Monolithic Data Lake to a Distributed Data Mesh](https://martinfowler.com/articles/data-monolith-to-mesh.html)