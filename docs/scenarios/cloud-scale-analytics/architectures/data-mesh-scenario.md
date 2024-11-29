---
title: A financial institution scenario for data mesh
description: Learn about a data mesh scenario for cloud-scale analytics in Azure that uses landing zones, data integrations, and data products.
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-data-management
adobe-target: true
---

# A Financial Institution Scenario for Data Mesh

This scenario is for customers who want to use cloud-scale analytics for scalability and *data mesh* architectures. It demonstrates a complex scenario with landing zones, data integrations, and data products.

## Customer Profile

A fictitious enterprise, Woodgrove Bank, is a large financial services company with a worldwide footprint. Woodgrove Bank's data is housed in on-premises and cloud deployment systems. Within the Woodgrove Bank architecture, there are several data warehouse systems for consolidated marketing and integrated reporting. This architecture includes several data lakes for unplanned analytics and data discovery. Woodgrove Bank applications are interconnected via application integration patterns, which are mostly API-based or event-based.

## The Current Situation

It’s challenging for Woodgrove Bank to distribute data to different locations because of the complexity of data warehousing. Integrating new data is time-consuming, and it's tempting to duplicate data. Woodgrove Bank finds it difficult to oversee the end-to-end data landscape because of point-to-point connectivity. The bank underestimated the demand for intensive data consumption. New use cases are introduced quickly, one after another. Data governance, such as data ownership and quality, and costs are hard to control. Keeping current with regulations is difficult because Woodgrove Bank doesn't know exactly where its data resides.

## Architecture Solution: Data Mesh

Over the past several years, organizations recognize that data is at the heart of everything. Data opens new efficiencies, drives innovation, unlocks new business models, and increases customer satisfaction. It’s a top priority for companies to use data-driven methods, like data at scale.

Reaching a stage where the deeper value of data is accessible to all organization members is challenging. Legacy and tightly interconnected systems, centralized monolithic platforms, and complex governance can be significant barriers to generating value out of data.

### About Data Mesh

The concept of data mesh, a term coined by Zhamak Dehghani, encompasses data, technology, processes, and organization. Conceptually, it's an accessible approach to managing data where various domains use their own data. Data mesh challenges the idea of conventional centralization of data. Rather than looking at data as one huge repository, data mesh considers the decomposition of independent data products. This shift, from centralized to federated ownership, is supported by a modern, self-service data platform typically designed using cloud-native technologies.

When you break down the data mesh concept into building blocks, here are some key points to consider:

- **Data as a Product**: Each (organizational) domain operates its data end to end. Accountability lies with the data owner within the domain. Pipelines become a first-class concern of the domains themselves.
- **Federated Computational Data Governance**: To ensure that each data owner can trust the others and share its data products, an enterprise data governance body must be established. The governance body implements data quality, central visibility of data ownership, data access management, and data privacy policies.
- **Domain-Oriented Data Ownership**: The enterprise should ideally define and model each data-domain node within the mesh by applying the principles of domain-oriented design.
- **Self-Serve Data Platform**: A data mesh requires a self-serve data platform that allows users to remove the technical complexity and focus on their individual data use cases.

### Cloud-Scale Analytics

Data-as-a-product thinking and a self-service platform model aren't new to Microsoft. Microsoft observed best practices of distributed platforms, pipelines across domains, federated ownership, and self-explanatory data for many years.

Woodgrove Bank can transition to data mesh by using cloud-scale analytics. Cloud-scale analytics is an open-source and prescriptive blueprint for designing and quickly deploying modern data platforms. It's coupled with Azure best practices and design principles and is aligned with the Azure Well-Architected Framework. Cloud-scale analytics gives enterprises an 80 percent prescribed viewpoint, and the remaining 20 percent is customizable.

Cloud-scale analytics offers enterprises a strategic design path toward data mesh, and it can be used to quickly set up such an architecture. It offers a blueprint, including core data platform services for data management.

At the highest level, cloud-scale analytics uses a data management capability, which is enabled through the data management landing zone. This zone is responsible for the federated data governance of an organization of the (self-service) platform, and the data domains that drive business value through data products. The benefit of this approach is that it removes technical complexity while adhering to the same standards. It ensures that there's no proliferation of technology. It also allows enterprises to start modular, with a small footprint, and then grow over time.

The data management landing zone, as you can see in the following diagram, surrounds all data domains. It glues all domains together and provides the oversight that Woodgrove Bank is looking for.

:::image type="content" source="../images/data-mesh-plane.png" alt-text="Diagram showing how data mesh intelligently distributes data products between data domains." lightbox="../images/data-mesh-plane.png":::

Cloud-scale analytics also advocates the application of consistent governance that uses a common architecture when data products are distributed. The framework allows direct communication between domains. It stays in control by placing an emphasis on central cataloging and classification to protect data and allow groups to discover data. It places an umbrella on top of your data estate.

### Data Domains

When you use cloud-scale analytics as a strategic path, you need to think of the decomposition of your architecture and the resulting granularity. Data mesh decomposes data by not following the borders of technologies. Instead, it applies the principles of domain-driven design (DDD), an approach to software development that involves complex systems for larger organizations. DDD is popular because of its effect on modern software and application development practices, such as microservices.

One of the patterns from domain-driven design is known as bounded context. Bounded contexts set the logical boundaries of a domain's solution space to better manage complexity. It's important that teams understand which aspects, including data, they can change and which are shared dependencies that require coordination with others. Data mesh embraces bounded context. It uses this pattern to describe how organizations can coordinate around data domains and focus on delivering data as a product. Each data domain owns and operates multiple data products with its own technology stack, which is independent of the others.

:::image type="content" source="../images/data-mesh-architecture.png" alt-text="Diagram showing the data mesh architecture." lightbox="../images/data-mesh-architecture.png":::

#### Data Products

When you zoom in on the inner architecture of such a data domain, you expect to find data products within it.

Data products fulfill a specific need within businesses that use data. Data products manage, organize, and make sense of the data across domains and then present the insights they gained. A data product results from data from one or many data integrations or other data products. Data products are closely aligned with data domains and inherit the same constructed, formalized language agreed upon by stakeholders and designers. Each domain that generates data is responsible for making these data products available to the other domains.

To help quickly deliver data products, cloud-scale analytics offers templates for data distribution and integration patterns. The framework provides data batch, streaming, and analytics to address the needs of diverse consumers.

One great thing about cloud-scale analytics is how domains and data products are organized. Each data domain aligns with one data landing zone, which is a logical construct and a unit of scale in cloud-scale analytics architecture. It enables data retention and execution of data workloads, which generates insights and value. Each data product aligns with one resource group within the data landing zone, and all data landing zones and management zones align with subscriptions. This approach eases implementation and management.

All cloud-scale analytics templates inherit the same set of policies from the data management landing zone. The templates automatically deliver necessary metadata for data discoverability, governance, security, cost management, and operational excellence. You can quickly onboard new data domains without the need for complex onboarding, integrating, and testing.

The following diagram illustrates what a data product might look like:

:::image type="content" source="../images/data-mesh-product.png" alt-text="Diagram of a data domain containing a data product." lightbox="../images/data-mesh-product.png":::

A pragmatic approach to building data products is to either align with the source, where the data originates, or with the consuming use case. In both cases, you need to provide an abstract view of the underlying (complex) application data model. You must try to hide the technical details and optimize for intensive data consumption. An Azure Synapse view or Parquet file, which logically groups data together, is an example of how a data product can be shared across various data domains.

Next, you need to work on data discoverability, provenance, usage, and lineage. A proven approach is to use a data governance service, like Microsoft Purview, to register all data. Data integration in cloud-scale analytics perfectly connects the dots because it allows building these data products as it simultaneously performs metadata registration.

By aligning data domains and Microsoft Purview collections, you automatically capture all data origin, lineage, data quality details, and consumption information from the individual domains. With this approach, you can connect multiple data domains and products to a centralized governance solution, which stores all the metadata from each environment. The benefit is that it centrally integrates all the metadata and makes it easily accessible to various consumers. You can extend this architecture to register new data products.

The following diagram illustrates a cross-domain data mesh architecture that uses cloud-scale analytics.

:::image type="content" source="../images/data-mesh-integration.png" alt-text="Diagram showing data integration." lightbox="../images/data-mesh-integration.png":::

The network design allows data products to be shared across domains by using minimal cost and eliminating a single point of failure and bandwidth limitations. To help ensure security, you can use the Microsoft *Zero Trust* security model. Cloud-scale analytics proposes the use of network isolation through private endpoints and private network communication, an identity-driven data access model that uses MIs, UMIs, and nested security groups, following the *principle of least privilege*.

You can use managed identities to ensure that a least privilege access model is followed. Applications and services in this model have limited access to data products. Azure policies, with the upcoming data policies, are used to enable self-service and enforce compliant resources within all data products, at scale. With this design, you can have uniform data access while staying fully in control via centralized data governance and auditing.

:::image type="content" source="../images/data-mesh-contract.png" alt-text="Diagram illustrating a data contract." lightbox="../images/data-mesh-contract.png":::

#### Evolve Toward the Future

Cloud-scale analytics is designed with data mesh in mind. Cloud-scale analytics provides a proven approach by which organizations can share data across many data domains. This framework allows domains to have the autonomy to make choices and it governs the architecture by ring-fencing it with data management services.

When you're implementing data mesh, logically group and organize your domains. This approach requires an enterprise view and is likely a cultural shift for your organization. The shift requires you to federate data ownership among data domains and owners who are accountable for providing their data as products. It also requires teams to conform to centralized capabilities offered by the data management landing zone. This new approach might require individual teams to give up their current mandates, which are likely to generate resistance. You might have to make certain political choices and strike a balance between centralized and decentralized approaches.

You can scale a data mesh architecture by adding more landing zones to the architecture for individual domains. These landing zones use virtual network peering to connect to the data management landing zone and all other landing zones. This pattern allows you to share data products and resources across zones. When you split into separate zones, you can spread workloads across Azure subscriptions and resources. This approach allows you to implement the data mesh organically.

## Learn More

Microsoft resources:

- [Data management landing zone template](https://github.com/Azure/data-management-zone)
- [Data landing zone template](https://github.com/Azure/data-landing-zone)

Article by data mesh founder Zhamak Dehghani:

- [How to move beyond a monolithic data lake to a distributed data mesh](https://martinfowler.com/articles/data-monolith-to-mesh.html)