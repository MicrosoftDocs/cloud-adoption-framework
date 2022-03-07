---
title: Scaling cloud-scale analytics in Azure
description: Learn how to scale cloud-scale analytics in Azure. Decide whether to use a single or multiple data landing zones to design a scalable platform.
author: marvinbuss
ms.author: mabuss
ms.date: 02/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Scaling Cloud-scale analytics

A scalable data platform is critical to accommodate the rapid growth of data. Vast amounts of data are generated every second.

The amount of available data is expected to grow exponentially over the next few years. The speed at which new data is generated and the speed at which data moves will increase. Even with more data, users expect that they'll get fast query results. Users expect to wait minutes rather than hours for results.

## Introduction

Today, many enterprises have large data platform monoliths built around the concept of a single Azure Data Lake Gen2 account and sometimes a single storage container. In addition, a single Azure subscription is often used for all data platform related tasks and the concept of subscription level scaling is absent in most architectural patterns. This can hinder continued adoption of Azure if users run into any of the [Azure subscription or service-level limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits). Even though some of the constraints are soft limits, hitting these can still have a significant impact within a data platform that should be avoided at best.

However the soft limits on specific services is not the thing that should be the only consideration for the design of the data platform. A major consideration around how you would structure your data platform is how you have organized your company or organization. This includes the data ownership and the functional responsibilities of the teams. If your organization have a large degree of distributed ownership and high degree of autonomy among the teams a mesh based architecture can be preferred.

Having several specialized teams within a single monolithic data platform own an orthogonal solution such as ingestion, cleansing, aggregation or serving can lead to a dramatic loss of velocity, because of dependency on several teams. For example, when a data consumer at the serving layer requires new data assets to be onboarded or functional changes to be implemented for a specific data asset, then multiple steps must be executed in a set sequence. The steps involve:

- The Data consumer must submit a ticket to the functional teams being responsible for the respective pipeline stages.
- Synchronization is now required between the functional teams as new ingestion services will be required, which will lead to changes required in the data cleansing layer, which will lead to changes on the data aggregation layer, which will again cause changes to be implemented on the serving layer. In summary, all pipeline stages could be affected by the requested changes and clear effect on the processing staged won't be visible to any of these teams as no one overviews the end-to-end lifecycle.
- In addition to the synchronization that is required between the various teams, the teams must design a well-defined release plan in order to not affect existing consumers or pipelines. This dependency management further increases the management overhead.
- All teams included in the requested change are most likely no subject matter experts for the specific data asset. Hence, extra consultation would be required to understand new dataset features or parameter values.
- After implementing all changes, the Data Consumer needs to be notified that the data asset is ready to be consumed.

If we now take into consideration that within a large organization there isn't a single data consumer but thousands of data consumers, the process described above makes clear why velocity is heavily affected by such an architectural and organizational pattern. The centralized teams quickly become a bottleneck for the business units, which will ultimately result in slower innovations on the platform, limited effectiveness of data consumers and possibly even to a situation where individual business units decide to build their own data platform.

## Methods of scaling in the Cloud-scale analytics

:::image type="content" source="../images/high-level-design-multiple-landing-zones.png" alt-text="Diagram of data management landing zone and multiple data landing zones.":::

> [!NOTE]
> Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within the architecture.

Cloud-scale analytics (DMA) uses two core concepts to address the scaling challenges mentioned in the [introduction](#introduction):

- Scaling through the concept of data landing zones.
- Scaling through the concept of Data Product or Data Integrations to enable distributed and decentralized data ownership.

A data landing zone is equal to an Azure subscription and allows single or multiple data landing zones deployments. Data landing zones are connected to a data management landing zone for discovery and management of data. A data management landing zone is a single Azure subscription.

Subscriptions are a unit of management, billing, and scale within Azure. Subscriptions play a critical role when you're designing for large-scale Azure adoption.

## Scaling with data landing zones

Cloud-scale analytics is centered around the concepts of Data Management Zone and data landing zone. Each of these artifacts should land in a separate Azure subscription to allow for clear separation of duties, to follow the least privilege principal and to partially address the first issue mentioned in the [introduction](#introduction) around subscription scale issues. Hence, the minimal setup of Cloud-scale analytics consists of a single Data Management Zone and a single data landing zone.

For large-scale data platform deployments, a single data landing zone and hence a single subscription won't be sufficient, especially if we consider that companies build these platforms and make the respective investments to consistently and efficiently scale their data and analytics efforts in the upcoming years. Therefore, to fully overcome the subscription-level limitations and embrace the "subscription as scale unit" concept from [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/), cloud-scale analytics allows an institution to further increase the data platform footprint by adding extra data landing zones to the architecture. Furthermore, this also addresses the concern of a single Azure Data Lake Gen2 being used for a whole company as each data landing zone comes with a set of three Data Lakes. Ultimately, this leads to a distribution of projects and activities of multiple domains across more than one Azure subscription, allowing for greater scalability.

The question of how many data landing zones an organization requires should be considered before adopting the cloud-scale analytics prescriptive architectural pattern. But using this pattern an organization has the possibility to start small with a single landing zone and then later grow the platform as needed.

Having at least an idea on the number of landing zones is still a good idea, because it lays the foundation for an effective and efficient data platform. When done right, it will prevent enterprises from ending up in a migration project of data products and data assets from one data landing zone to another and will allow an effective and consistent scaling of any big data and analytics efforts for the upcoming years.

The following factors should be considered when deciding about how many data landing zones should be deployed:

| Factor                                            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                |
|---------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Organizational structure and data ownership       | How is the organization organized from a business perspective and how is data owned across the organization.                                                                                                                                                                                                                                                                                                                               |
| Region/Location                                   | Multi-region data landing zone deployments. <br/> In which Azure Regions will the organization deploy their data platform? <br/> Will the platform be hosted in a single region or will it span across multiple regions? <br/>  Are there data residency requirements that need to be taken into account?                                                                                                                                  |
| Quotas                                            | Consider that subscription quotas aren't capacity guarantees and are applied on a per region basis.                                                                                                                                                                                                                                                                                                                                        |
| Data sovereignty                                  | Due to data sovereignty regulations data is required to be stored in a specific region or have region specific policies enforced.                                                                                                                                                                                                                                                                                                          |
| Azure policies                                    | Requirements for different Azure policies to be applied to a data landing zone                                                                                                                                                                                                                                                                                                                                                             |
| Management boundary                               | Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns.                                                                                                                                                                                                                                                                                                                                |
| Networking                                        | A landing zone is provisioned with a virtual network and given that vnets are regionally bound a new region implies a new landing zone and the vnets needs to bee peered to enable cross domain communication.                                                                                                                                                                                                                             |
| Limits                                            | There are some limits associated with a subscription scope and splitting into several subscriptions mitigate the chance of hitting any of these limits.                                                                                                                                                                                                                                                                                    |
| Cost Allocation                                   | Are shared services like storage accounts paid centrally or do these need to be split by business unit or domain? Using a separate subscription creates a boundary for cost allocation, but you can also use tags to achieve the same functionality                                                                                                                                                                                        |
| Data classifications and highly confidential data | These extra security mechanisms even impact usability of the data platform and data product development. <br/> What data classifications exist within the organization? <br/> Does the organization have datasets that are classified as highly confidential and do these datasets require special treatment in form of just in time access, customer managed keys (CMK), fine grained network controls or more encryption being enforced? |
| Other legal or security implications              | Is there any other legislation's or security requirements that an organization needs to comply with that justify logical and/or physical separation of data?                                                                                                                                                                                                                                                                               |

For a data mesh implementation, when deciding on the distribution of your data landing zones and your data domains also look at:

| Factor       | Description                                                                                                                                                                                                                                                                                      |
|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Data Domains | What data domains does the organization encompass and which data domains will land on the data platform? <br/> What is the size of these individual data domains?  <br/> For information, see [What are data domains?](data-domains.md)                                                          |
| Latency      | Domains that collaborate on large amounts of data could transfer a large amount of data across landing zones. In this case you might want to collocate them in the same landing zone or region. Otherwise it will increase latency and for cross region domains you might see an increased cost. |
| Security     | Some service deployments or configurations requires elevated privileges on a subscription. Giving this to users in one domain will implicitly give them the privileges in another domain within the scope of that same subscription.                                                             |

Further considerations are documented in the cloud adoption framework guidance for [Subscriptions](../../../ready/landing-zone/design-area/resource-org-subscriptions.md).
Efficient scaling within an enterprise data platform is a much-desired goal of many organizations and as business units should be enabled to build their own (data) solutions and applications that fulfill their requirements. However, achieving this goal is a challenge as many existing data platforms aren't built around the core concepts of scalability and decentralized ownership. This isn't only true from an architectural standpoint but also becomes clear when looking at the teams structure and ops model that underpin these data platforms.

It's important to emphasize that data landing zones aren't creating data silos within an organization, as the recommended network setup in cloud-scale analytics enables secure and in-place data sharing across Landing Zones and therefore enables innovation across data domains and business units. Read the [Network architecture considerations](../eslz-network-considerations-single-region.md) to find out more about how this is achieved. The same is true for the identity layer. Since a single Azure AD tenant is recommended to be used, identities can be granted access to data assets within multiple data landing zones. For the actual authorization process of users and identities to data assets it's recommended to you review [Data Access Management](../security-provisioning.md).

> [!NOTE]
> If you have multiple data landing zones, the zones can connect to data hosted in other zones. This approach allows groups to collaborate across the business.

Cloud-scale analytics advocates consistent governance using a common architecture. The architecture defines baseline capabilities and policies. All data landing zones adhere to the same controls and auditing. Teams can create data pipelines, ingest sources, and create data products, such as reports and dashboards. Teams can do Spark/SQL analysis as needed. You can augment data landing zone capabilities by adding services to the capability in the policy. For instance, a team could add a third-party graph engine to address a niche business requirement.

Cloud-scale analytics places a strong emphasis on central cataloging and classification to protect data and allow various groups to discover data products.

> [!CAUTION]
> We recommend against querying data cross region and instead recommend making sure data is close to the compute whilst respecting regional boundaries.

Lastly, it needs to be highlighted that the prescriptive cloud-scale analytics architecture and the concept of data landing zones allows corporations to naturally increase the size of their data platform over time. Extra data landing zones can be added in a phased approach and customers aren't forced to start with a multi-data landing zone setup right from the start. When adopting the pattern, companies should start prioritizing few data landing zones and data products that should land inside them respectively, to make sure that the adoption of cloud-scale analytics is successful.

## Scaling with Data Products

Within a data landing zone, the Cloud-scale analytics allows organizations scale through the concept of data applications. A data application is a unit or component of the data architecture that encapsulates functionality for making read-optimized data product available for consumption by other data application. In the Azure context, a data application is an environment in form of resource group that allows cross-functional teams to implement data solutions and workloads on the platform. The associated team takes care of the end-to-end lifecycle of their data solution including ingest, cleansing, aggregation and serving tasks for a particular data-domain, subdomain, dataset or project.

With the data product concept, Cloud-scale analytics addresses the data integration and responsibility issue mentioned in the [introduction](#introduction). Instead of having an architectural design build around monolithic functional responsibilities for the ingestion of tables and integration of source systems, the reference design is pivoting the design towards a distributed, data domains driven architecture, where cross functional teams take over the end-to-end functional responsibility and ownership for the respective data scope. In summary, this means that instead of having a centralized technical stack and team being responsible for each and every orthogonal solution of the data processing workflow, we're distributing the end-to-end responsibility from ingestion to the serving layer for data domains or subdomains across multiple autonomously working cross-functional Data Integration teams. The Data Integration teams own a domain or subdomain capability and must be encouraged to serve datasets for access by any team for any purpose or project they could be working on.

This architectural paradigm shift ultimately leads to an increased velocity within the data platform as data consumers do no longer have to rely on a set of centralized teams or have to fight for prioritization of the requested changes. As smaller teams take ownership of the end-to-end integration workflow, the feedback loop between data provider and data consumer is much shorter and therefore allows for much quicker prioritization, development cycles and a more agile development process. Additionally, complex synchronization processes and release plans between teams are no longer required as the cross-functional Data Integration team has full visibility of the end-to-end technical stack and any implications that could arise due to the implemented changes. The team can apply software engineering practices to run unit and integration tests to minimize overall effect on consumers.

In an ideal world, the data integration would be owned by the same team that owns the source systems. But the team should in general not only consist of data engineers that work on the source systems, but also of subject matter experts (SMEs) for these datasets, cloud engineers and data product owners. Such a cross-functional team setup reduces the communication required to teams outside and will be essential when developing the complete stack from infrastructure to actual data pipelines.

Integrated datasets from source systems become the foundation of the data platform and will enable Data Product teams to further innovate on top of the business fact tables to eventually improve decision making and optimize business processes. Both Data Integration and Data Product teams should offer SLAs to consumers and ensure hat agreements are met. These SLAs can be related to data quality, timeliness, error rates, uptime and other tasks.

## Summary

The sections above are summarizing the scaling mechanisms within Cloud-scale analytics that organizations can use to grow their data estate within Azure over time without running into well-known technical limitations. Both scaling mechanisms are helping to overcome different technical complexities and can be used in an efficient and simple way.

## Next steps

[What is a data mesh?](what-is-data-mesh.md)
