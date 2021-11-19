---
title: Financial institution scenario for data mesh
description: Learn about the data mesh scenario for data management and analytics in Azure.
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 10/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.custom: think-tank, e2e-data-management
---

# A financial institution scenario for data mesh

This reference architecture is written for customers that want to use enterprise-scale analytics and AI for scalability and *data mesh* architectures. It demonstrates a more complex scenario, with multiple landing zones, data integrations, and data products.

## Customer profile

Fictitious enterprise Woodgrove Bank is a very large financial services company with a world-wide footprint. Woodgrove Bank's data is housed in many different systems, which include on-premises and cloud deployments. Within the Woodgrove Bank architecture are several data warehouse systems for consolidated marketing and integrated reporting. This architecture also includes several data lakes for ad hoc analytics and data discovery. Finally, many of Woodgrove Bank's applications are interconnected via application integration patterns, which are mostly API-based or event-based.

## The current situation

Woodgrove Bank finds it challenging to distribute data toward different locations because of the complexity of data warehousing. Integrating new data is time consuming, and it's tempting to duplicate data. Woodgrove Bank also finds it difficult to oversee the end-to-end data landscape because of point-to-point connectivity. The bank underestimated the sheer demand for intensive data consumption. New use cases are introduced quickly, one after another. Data governance, such as data ownership and quality, and costs are hard to control. Keeping current with regulations is difficult because Woodgrove Bank doesn't know exactly where its data resides.

## Architecture solution: Data mesh

Over the past several years, organizations have recognized that data is at the heart of everything. Data opens new efficiencies, drives innovation, unlocks new business models, and increases customer satisfaction. Becoming data-driven (using data at scale) remains a top priority for most companies.

Reaching a stage where the deeper value of data becomes accessible to all organization members is challenging. Legacy and tightly interconnected systems, centralized monolithic platforms, and complex governance can be significant barriers to generating value out of data. For these and other reasons, data mesh is gaining a lot of traction among modern businesses.

### About data mesh

The concept of data mesh, a term coined by Zhamak Dehghani, encompasses data, technology, processes, and organization. On a conceptual level, it's a democratized approach to managing data where various domains operationalize their own data. Data mesh challenges the idea of conventional centralization of data: rather than looking at data as one huge repository, data mesh considers the decomposition of independent data products. This shift, from centralized to federated ownership, is backed by a modern and self-service data platform, which is typically designed using cloud-native technologies.

As we break down the data mesh concept into building blocks, here are some key points to consider:

- **Data as a product**: Each (organizational) domain operates its data end to end. Accountability lies with the data owner within the domain. Pipelines in this respect become a first-class concern of the domains themselves.
- **Federated data governance**: To ensure that each data owner can trust the others and share its data products, an enterprise data governance body must be established to implement data quality, central visibility of data ownership, data access management, and data privacy policies.
- **Domain boundaries**: The enterprise should ideally define and model each data-domain node within the mesh by applying the principles of domain-oriented design.
- **Data platform**: A data mesh requires a self-serve data platform that allows users to abstract the technical complexity and focus on their individual data use cases.

### Cloud Adoption Framework for data management and analytics

Data-as-a-product thinking and a self-service platform paradigm aren't new to Microsoft. We've observed best practices of distributed platforms, pipelines across domains, federated ownership, and self-explanatory data for many years.

Woodgrove Bank can embark on its transition to data mesh by using Cloud Adoption Framework for Azure for data management and analytics. Cloud Adoption Framework is an open-source and prescriptive blueprint for designing and quickly deploying modern data platforms. It has been coupled with Azure best practices and design principles, and is aligned with Azure Well-Architected Framework. Cloud Adoption Framework aims to give enterprises an 80 percent prescribed viewpoint and the ability to customize the remaining 20 percent.

Cloud Adoption Framework offers enterprises a strategic design path toward data mesh, and it can be used to quickly set up such an architecture. It offers a blueprint, including core data platform services for data management.

At the highest level, Cloud Adoption Framework uses a data management capability, which is enabled through the data management landing zone. This zone is responsible for the federated data governance of an organization of the (self-service) platform, as well as the data domains that drive business value through data products. The benefit of this approach is that it abstracts away all technical complexity, while adhering to the same standards. It ensures that there is no proliferation of technology. It also allows enterprises to start modular, with a small footprint, and then grow over time. 

The data management zone, as you can see in the following diagram, surrounds all data domains. It glues all domains together and provides the oversight that Woodgrove Bank is looking for.

:::image type="content" source="../images/data-mesh-plane.png" alt-text="Diagram showing how data mesh intelligently distributes data products between data domains." lightbox="../images/data-mesh-plane.png":::

Cloud Adoption Framework also advocates the application of consistent governance that uses a common architecture when data products are distributed. The framework allows direct communication between domains, while staying fully in control by placing a strong emphasis on central cataloging and classification to protect data and allow various groups to discover data. It places an umbrella on top of your data estate.

### Data domains

When you use Cloud Adoption Framework as a strategic path, you need to think of the decomposition of your architecture and the resulting granularity. Data mesh, in this respect, decomposes data by not following the borders of technologies. Instead, it applies the principles of domain-driven design (DDD), an approach to software development that involves complex systems for larger organizations. DDD is popular because of its impact on modern software and application development practices, such as microservices.

One of the patterns from domain-driven design is known as *bounded context*. Bounded contexts are used to set the logical boundaries of a domain's solution space to better manage complexity. It's important that teams understand which aspects, including data, they can change on their own and which are shared dependencies for which they need to coordinate with others. Data mesh embraces bounded context and uses this pattern for describing how organizations can organize around data domains with a focus on delivering data as a product. Each data domain, in this regard, owns and operates multiple data products with its own technology stack, which is independent from the others.

:::image type="content" source="../images/data-mesh-architecture.png" alt-text="Diagram showing data mesh architecture." lightbox="../images/data-mesh-plane.png":::

#### Data products

When you zoom in on the inner architecture of such a data domain, you expect to find data products within it.

Data products fulfill a specific need within businesses that use data. Data products manage, organize, and make sense of the data across domains and then present the insights they've gained. A data product is a result of data from one or many data integrations or other data products. Data products, as you might expect, are closely aligned with data domains, and inherit the same ubiquitous language: a constructed, formalized language, agreed upon by stakeholders and designers, to serve the needs of the design. Each domain, which generates data, is responsible for making these data products available to the other domains.

To help quickly deliver data products, Cloud Adoption Framework offers various templates for data distribution and integration patterns. The framework provides data batch, streaming, and analytics for addressing the needs of a diverse set of consumers. 

One great thing about Cloud Adoption Framework is how domains and data products are organized. Each data domain aligns with one data landing zone, which is a logical construct and a unit of scale in the Cloud Adoption Framework architecture that enables data retention and execution of data workloads for generating insights and value with data. Each data product aligns with one resource group within the data landing zone, and all data landing zones and management zones align with subscriptions. This approach eases implementation and management.

All Cloud Adoption Framework templates inherit the same set of policies from the data management landing zone. The templates automatically deliver all necessary metadata for data discoverability, governance, security, cost management, and operational excellence. This approach allows you to quickly onboard new data domains without the need of complex onboarding, integrating, and testing. 

The following diagram illustrates what a data product might look like:

:::image type="content" source="../images/data-mesh-product.png" alt-text="Diagram of a data domain containing a data product." lightbox="../images/data-mesh-product.png":::

A pragmatic approach to building data products is to either align with the source, where the data originates, or with the consuming use case. In both cases, you need to provide an abstract view of the underlying (complex) application data model. You must try to hide the technical details and optimize for intensive data consumption. An Azure Synapse view or Parquet file, which logically groups data together, is a good example of how a data product can be shared across various data domains.

Next, you need to work on data discoverability, provenance, usage, and lineage. A proven approach is to use a data governance service, like Azure Purview, to register all data. From this standpoint, data integration in the Cloud Adoption Framework perfectly connects the dots, because it allows building these data products as it simultaneously performs metadata registration. Data integration teams (also known as integration ops) are responsible for ingestion of data to a read data source. The data shouldn't have any data transformation applied apart from the data quality checks and data types that are applied.

By using data integration and aligning data domains and Azure Purview collections, you automatically capture all data origin, lineage, data quality details, and consumption information from the individual domains. With this approach, you can connect multiple data domains and products to a centralized governance solution, which stores all the metadata from each environment. The benefit is that it centrally integrates all the metadata and makes it easily accessible to various consumers. You can extend this architecture to register new data products.

The following diagram illustrates a cross-domain data mesh architecture that uses Cloud Adoption Framework data integration.

:::image type="content" source="../images/data-mesh-integration.png" alt-text="Diagram showing data integration." lightbox="../images/data-mesh-integration.png":::

The network design allows a simple sharing of datasets across domains without bandwidth limitations, a single point of failure, and minimal cost. To help ensure security, you can use the Microsoft *Zero Trust* security model. Cloud Adoption Framework proposes the use of network isolation through private endpoints and private network communication, an identity-driven data access model that uses MIs, UMIs, and nested security groups, following the *principle of least privilege*. 

You can use managed identities to ensure that a least privilege access model is followed. Applications and services in this model have limited access to data products. Azure policies, in conjunction with the upcoming data policies, are used to enable self-service and enforce compliant resources within all data products, at scale. With this design, you can have uniform data access, while staying fully in control via centralized data governance and auditing.

:::image type="content" source="../images/data-mesh-contract.png" alt-text="Diagram illustrating a data contract." lightbox="../images/data-mesh-contract.png":::

#### Evolving toward the future

Cloud Adoption Framework for data management and analytics is designed with data mesh in mind. Cloud Adoption Framework provides a proven approach by which organizations can share data across many data domains. Cloud Adoption Framework allows domains to have autonomy to make choices, and at the same time it governs the architecture by ring-fencing it with data management services.

A consideration to keep in mind, when you're implementing data mesh, is how to logically group and organize your domains. This requires an enterprise view and is likely also a cultural shift for your organization. The shift requires you to federate data ownership among data domains and owners who are accountable for providing their data as products. It also requires teams to conform to centralized capabilities that are offered by the data management zone. This new approach might require individual teams to give up their current mandates, which is likely to generate resistance. You might have to make certain political choices and strike a balance between centralized and decentralized approaches.

You can scale a data mesh architecture by adding more landing zones to the architecture for individual domains. These landing zones use virtual network peering to connect to the data management zone and all other landing zones. This pattern allows you to share datasets and resources across zones. And by splitting into separate zones, you can spread workloads across Azure subscriptions and resources. This approach allows you to implement the data mesh organically.

## Learn more

Microsoft resources:
- [Data management zone template](https://github.com/Azure/data-management-zone)
- [Data landing zone template](https://github.com/Azure/data-landing-zone)

Article by data mesh founder Zhamak Dehghani:
- [How to Move Beyond a Monolithic Data Lake to a Distributed Data Mesh](https://martinfowler.com/articles/data-monolith-to-mesh.html) 
