---
title: Self-serve data platforms
description: Learn about design considerations for self-serve data platforms
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 02/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Design considerations for self-serve data platforms

Data mesh is an exciting new approach to designing and developing data architectures. Data mesh, contrasting to traditional data architecture, separates the responsibility between functional [data domains](./data-domains.md) that focus on creating [data products](./what-is-data-product.md) and the platform team who focus on technical capabilities. This separation of responsibilities also needs to be reflected in the platform, which requires you to make choices. You must strike a balance between providing domain-agnostic capabilities and enabling domain teams to model, process, and distribute their data across the organization. Designing the right level of domain granularity and rules for decoupling by using platforms isn't easy, so therefore we would like to provide you detailed guidance by running through several scenarios.

## cloud-scale analytics

When you want to build a data mesh on Azure, the recommended approach is to adopt [cloud-scale analytics](../index.md). This framework is a deployable reference architecture and comes with (open-source) templates and best practices. The architecture uses two major building blocks, which are fundamental for all deployment choices:

* Data management landing zone: this is the fundament of your data architecture. It contains all critical capabilities for data management, such data catalog, data lineage, API catalog, master data management, and so on.
* Data management landing zones: these are subscriptions that host your analytics and AI solutions. It includes key capabilities to host an analytics platform.

:::image type="content" source="../images/high-level-design-single-data-landing-zone.png" alt-text="The following diagram shows an overview of a cloud-scale analytics platform with a data management landing zone and a single data landing zone. Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within this architecture.":::

The following diagram shows an overview of a cloud-scale analytics platform with a data management landing zone and a single data landing zone. Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within the architecture. The framework isn't explicit on the exact type of data architecture you must provision. You can use it for many common cloud-scale analytics solutions, including (enterprise) data warehouses, data lakes, data lake houses and data meshes. For this article, we'll zoom into the latter for practically designing a data mesh.

Before showing any scenario, it's important to understand that all architectures adhere to the data mesh principles: domain ownership, data as product, self-serve data platform and federated computational governance. Next, different paths will lead to a data mesh. There's no right or wrong. It all boils down to making the right trade-offs.

## Single data landing zone

The simplest deployment pattern for building a data mesh architecture is using one data management landing zone and a single data landing zone. Your data architecture in such a scenario would look like the image below:

:::image type="content" source="../images/domain-agnostic-infra-01.png" alt-text="Single landing zone for when you're just starting or prefer to be in control" lightbox="../images/domain-agnostic-infra-01.png":::

In this model, all of your functional data domains will settle down on the same data landing zone. A single subscription will hold a standard set of services, while resource groups segregate different data domains and data products. Standard data services will apply to all domains, which are, for example,  Azure Data Lake Store, Azure Logic Apps and Azure Synapse Analytics.

All data domains follow the principles of data mesh: data follows domain ownership and data is treated like products. Also the platform is fully self-service, although variations of services are limited. A consideration for this deployment option can be that you want all domains to strongly adhere and conform to the same principles for data management. This deployment option could also make sense for smaller sized companies or greenfield projects. You want to embrace data mesh, but don't over-complicate things. Finally, this deployment could also be a choice when you're at the start of building something more complex. You plan for expanding into multiple landing zones at a later moment in time.

## Source system- and consumer-aligned landing zones

In the previous model, we didn't take into account other subscriptions or on-premises applications. Therefore, you can make a subtle variation to the previous model by adding a source system-aligned landing zone for managing all incoming data. Having two data landing zones, makes sense, because data onboarding is a difficult process. It remains one of the most challenging problems when using data at large. It also often requires extra tools for addressing integration challenges, which contrast to the way data consumption takes place. Therefore it's logical to distinguish between providing and consuming data.

:::image type="content" source="../images/domain-agnostic-infra-02.png" alt-text="Source system- and consumer-aligned landing zones" lightbox="../images/domain-agnostic-infra-02.png":::

In the architecture on the left, you would generally expect services to facilitate all data onboarding, like [CDC](https://en.wikipedia.org/wiki/Change_data_capture), services that pull APIs, or data lake services for dynamically building immutable datasets. The services from this platform can pull data from either on-premises, cloud environments or SaaS vendors. Such a platform is typically also expected to have more overhead, since there's more coupling with the underlying operational applications. Therefore you might want to treat this differently from any data usage.

On the right, you optimize for consumption and expect services aimed to turn data into value: machine learning, reporting, and so on. Again in these architecture domains follow all principles of data mesh. Domains take ownership of data and are allowed to directly distribute data to other domains.

## Hub-, generic- and special data landing zones

The next deployment option is another iteration of the previous design. This deployment follows a governed mesh topology: data is distributed via a central hub, in which data is partitioned per domain, logically isolated and thus not integrated. The hub in this model uses its own (domain-agnostic) data landing zone and could be owned by a central data governance team overseeing what data is distributed to what other domains. The hub also carries services to facilitate data onboarding, so therefore the overlap with the previous deployment option.

:::image type="content" source="../images/domain-agnostic-infra-03.png" alt-text="Hub-, generic- and special data landing zones" lightbox="../images/domain-agnostic-infra-03.png":::

For domains requiring standard services for consuming, using, analyzing and creating new data, a generic data landing zone will be used. This single subscription will hold a standard set of services and in a way is similar to the single landing zone deployment as seen previously. In this configuration, I also encourage you to apply data virtualization, because most of your data products are already persisted in the hub. There's no need for more data duplication.

In addition, this deployment allows for 'specials': More landing zones that can be provisioned when logically grouping domains aren't possible. For example, when regional or legal boundaries apply, or when domains have unique and contrasting requirements. Or situations where a strong global subsidiary governance is applied, with exceptions for overseas activities. In such a situation of segregation, you could deploy another data landing zones.

The hub deployment option is a consideration for organization that strongly needs to control what data is distributed and consumed by what other domains. It could also be valid option when addressing time-variant and non-volatile concerns for large data consumers. If so, you more strongly standardize on how data products are designed, allowing your domains to time-travel and perform redeliveries. This model is often used by organizations within the financial industry.

## Functional and regionally aligned data landing zones

An approach to scalability is provisioning multiple data landing zones for grouping functional domains based on the cohesion and efficiency in the way of working and sharing data. In such a scenario, all of your data landing zones adhere to the same controls and auditing, but you allow for flexibility and design changes between different data landing zones.

:::image type="content" source="../images/domain-agnostic-infra-04.png" alt-text="Functional and regionally aligned data landing zones" lightbox="../images/domain-agnostic-infra-04.png":::

There are different aspects driving what functional data domains will be logically grouped together and become candidates for sharing a data landing zone. Regional boundaries, for example, could result in the implementation of the same blueprints. Ownership, security or legal boundaries might force domains to be segregated. Flexibility, pace of change or potentially selling or separating off your capabilities are important drivers too. More guidance and best practices on this subject can be found on [data domains](./data-domains.md).

Different landing zones don't stand on themselves. If you have multiple zones, the zones can connect to data lakes hosted in other zones. This approach allows domains to collaborate across the enterprise. You could also apply polyglot persistence to mix different data store technologies, allowing domains to directly read data from other domains without the need of data duplication.

When deploying multiple data landing zones, you should be aware that there's some management overhead attached to each data landing zone: VNET peering must be applied between all data landing zones, extra private endpoints that must be managed, and so on.

Deploying multiple data landing zones is good consideration when your data architecture is larger. You can scale a data mesh architecture by adding more landing zones to the architecture for addressing common needs of different domains. These landing zones use virtual network peering to connect to the data management landing zone and all other landing zones. This pattern allows you to share datasets and resources across zones. And by splitting into separate zones, you can spread workloads across Azure subscriptions and resources. This approach allows you to implement the data mesh organically.

## Large scale enterprise requiring different data management zones

The last deployment option is for brutally large enterprises operating on a global scale. In such a scenario there could be contrasting data management requirements between different parts of the organization. To tackle this, you can deploy multiple data management and data landing zones together. Such an architecture is visualized below:

:::image type="content" source="../images/domain-agnostic-infra-05.png" alt-text="Large scale enterprise requiring different data management zones" lightbox="../images/domain-agnostic-infra-05.png":::

It's important to stress out that multiple data management landing zones, should justify the overhead and integration complexity. another data management landing zone, for example, could make sense for situations where (meta)data of the organization not allowed to be seen by others.

## Conclusion

A transition towards data mesh is mostly a cultural shift that comes with nuances, trade offs and considerations. For the technology part, you can use cloud-scale analytics to obtain best practices and executable resources. The reference architectures as described in this article can be starting point for kick-starting your implementation.

## Next Steps

[Data onboarding](data-onboarding.md)
