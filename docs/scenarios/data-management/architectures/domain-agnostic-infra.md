---
title: Domain Agnostic Infra
description: Learn about domain agnostic infra
author: mboswell
ms.author: mboswell
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Domain Agonistic Infra

Implementing Data Mesh on Azure
Data mesh is an exciting new approach to designing and developing data architectures. After my first series of articles and more recent materials on data products and data domains, I received queries on explaining what a practical implementation on Azure could look like. I'll try to answer this question in this blogpost.
Azure data management and analytics scenario
For building a data mesh on Azure, I recommend you to pay close attention to Azure data management and analytics scenario. This framework is a deployable reference architecture and comes with (open-source) templates and best practices. The architecture uses two major building blocks, which are fundamental for all deployment choices:
*    Data management landing zone: this is the fundament of your data architecture. It contains all critical capabilities for data management, such data catalogue, data lineage, API catalog, master data management, and so on.
*    Data management landing zones: these are subscriptions that host your analytics and AI solutions. It includes key capabilities to host an analytics platform.
 The following diagram shows an overview of an data management and analytics scenario platform with a data management landing zone and a single data landing zone. Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within the architecture. (Source: Microsoft.com)
The framework isn't explicit on the exact type of data architecture you must provision. You can use it for many common data management and analytics solutions, including (enterprise) data warehouses, data lakes, data lake houses and data meshes. For the purpose of this blogpost, we will zoom into the latter for practically designing a data mesh.
Data Mesh on Azure
Before showing any solution, I want to clearly state that all the architectures adhere to the data mesh principles: domain ownership, data as product, self-serve data platform and federated computational governance. Next, different paths will lead to a data mesh. There is no right or wrong. It all boils down to making the right trade-offs.
Single data landing zone
The simplest deployment pattern for building a data mesh architecture is using one data management landing zone and a single data landing zone. Your data architecture in such a scenario would look like the image below:
 
In this model, all of your functional data domains will settle down on the same data landing zone. A single subscription will hold a standard set of services, while resource groups segregate different data domains and data products. Standard services will apply to all domains, which are for example Azure Data Lake Store, Azure Logic Apps and Azure Synapse Analytics.
All data domains follow the principles of data mesh: data follows domain ownership and data is treated like products. Also the platform is fully self-service, although variations of services are limited. A consideration for this deployment option can be that you want all domains to strongly adhere and conform to the same principles for data management. This deployment option could also make sense for smaller sized companies or greenfield projects. You want to embrace data mesh, but don't overcomplicate things. Finally, this deployment could also be a choice when you're at the start of building something more complex. You plan for expanding into multiple landing zones at a later moment in time.
Source system- and consumer-aligned landing zones
In the previous model, we didn't take into account other subscriptions or on-premises applications. Therefore, I would like to propose a subtle variation to the previous model by adding a source system-aligned landing zone for managing all incoming data. Having two data landing zones, makes sense, because data onboarding is a difficult process. It remains one of the most challenging problems when using data at large. It also often requires additional tools for addressing integration challenges, which contrast to the way data consumption takes place. Therefore it is logical to distinguish between providing and consuming data.
 
In the architecture on the left, you would generally expect services to facilitate all data onboarding, like CDC, services that pull APIs, or data lake services for dynamically building immutable data products. The services from this platform can pull data from either on-premises, cloud environments or SaaS vendors. Such a platform is typically also expected to have more overhead, since there's more coupling with the underlying operational applications. Therefore you might want to treat this differently from any data usage.
On the right, you optimize for consumption and expect services aimed to turn data into value: machine learning, reporting, and so on. Again in this architecture domains follow all principles of data mesh. Domains take ownership of data and are allowed to directly distribute data to other domains.
Hub-, generic- and special data landing zones
The next deployment option is another iteration of the previous design. This deployment follows a governed mesh topology: data is distributed via a central hub, in which data is partitioned per domain, logically isolated and thus not integrated. The hub in this model uses its own (domain-agnostic) data landing zone and could be owned by a central data governance team overseeing what data is distributed to what other domains. The hub also carries services to facilitate data onboarding, so therefore the overlap with the previous deployment option.
 
For domains requiring standard services for consuming, using, analyzing and creating new data, a generic data landing zone will be used. This single subscription will hold a standard set of services and in a way is similar to the single landing zone deployment as seen previously. In this configuration, I also encourage you to apply data virtualization, because most of your data products are already persisted in the hub. There is no need for additional data duplication.
In addition, this deployment allows for 'specials': additional landing zones that can be provisioned when logically grouping domains isn't possible. For example, when regional or legal boundaries apply, or when domains have unique and contrasting requirements. Or situations where a strong global subsidiary governance is applied, with exceptions for overseas activities. In such a situation of segregation, you could deploy additional data landing zones.
The hub deployment option is a consideration for organization that strongly need to control what data is distributed and consumed by what other domains. It could also be valid option when addressing time-variant and non-volatile concerns for large data consumers. If so, you more strongly standardize on how data products are designed, allowing your domains to time-travel and perform re-deliveries. I often see this model being used by organizations within the financial industry.
Functional and regionally aligned data landing zones
An approach to scalability is provisioning multiple data landing zones for grouping functional domains based on the cohesion and efficiency in the way of working and sharing data. In such a scenario, all of your data landing zones adhere to the same controls and auditing, but you allow for flexibility and design changes between different data landing zones.
 
There are different aspects driving what functional data domains will be logically grouped together and become candidates for sharing a data landing zone. Regional boundaries, for example, could result in the implementation of the same blueprints. Ownership, security or legal boundaries might force domains to be segregated. Flexibility, pace of change or potentially selling or separating off your capabilities are important drivers too. I compiled a lengthy blogpost on this subject providing you with nuances and considerations: https://towardsdatascience.com/data-domains-where-do-i-start-a6d52fef95d1
Different landing zones don't stand on themselves. If you have multiple zones, the zones can connect to data lakes hosted in other zones. This approach allows domains to collaborate across the enterprise. You could also apply polyglot persistence to mix different data store technologies, allowing domains to directly read data from other domains without the need of data duplication.
When deploying multiple data landing zones you should be aware that there is some management overhead attached to each data landing zone: VNET peering must be applied between all data landing zones, additional private endpoints that must be managed, and so on. 
Deploying multiple data landing zones is good consideration when your data architecture is larger. You can scale a data mesh architecture by adding more landing zones to the architecture for addressing common needs of different domains. These landing zones use virtual network peering to connect to the data management landing zone and all other landing zones. This pattern allows you to share data products and resources across zones. And by splitting into separate zones, you can spread workloads across Azure subscriptions and resources. This approach allows you to implement the data mesh organically
Large scale enterprise requiring different data management zones
The last deployment option is for brutally large enterprises operating on a global scale. In such a scenario there could be contrasting data management requirements between different parts of the organization. To tackle this, you can deploy multiple data management and data landing zones together. Such an architecture is visualized below:
 
It is important to stress out that multiple data management landing zones, should justify the additional overhead and integration complexity. An additional data management landing zone, for example, could make sense for situations where (meta)data of the organization not allowed to be seen by others.
Wrapping up
A transition towards data mesh is mostly a cultural shift that comes with nuances, trade offs and considerations. For the technology part, you can leverage the data management and analytics scenario to obtain best practices and executable resources. The reference architectures as described in blogpost can be starting point for kickstarting your implementation.


