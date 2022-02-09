---
title: Manage master data
description: Learn about managing master data in Data Mesh.
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 02/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Master Data Management in Data Mesh

Enterprises using a Data Mesh Architecture typically have a large multitude of domains, each with its own systems and data. This means increased complexity because the data is spread around and multiple versions of the same data might exist. Integration, for example providing a 360-degree view of your customers, consequently takes more effort because it requires you to integrate and harmonize all the different independent parts of the same data from the different domains. Another challenge is that data may be inconsistent in contexts between the different domains, and there might be variances in the levels of data quality. To address these challenges, you should apply [master data management (MDM)](../govern-master-data.md).

## Domain-oriented Master Data Management

An important aspect of MDM is master identification numbers, which link mastered data and data from your domains together. These data elements are critical for tracking down what data has been mastered and what belongs together. Identifying unique data and assigning master identifiers can only be done centrally, not locally within systems. It requires having your master data from the different systems together in an MDM solution. Master Data Management in a domain-oriented architecture works different because of its distributed nature. Consistency is harder to achieve because you rely on management of master data within your domains.

One approach for having master data consistency between domains is asking your domains, when distributing [data products](./data-landing-zone-data-products.md), to conform themselves to centrally managed master data. The list of master data is published, for example, in a master data store or central repository. When any of your domains distribute data products across, so to other domains, domains use the enterprise reference identifiers from the enterprise reference data to classify data. This allows other domains to quickly recognize master data within data products.

When grouping your MDM activities and using a master data stores as centralized repositories, you could also create new MDM domains. Such an MDM domain refers to a specific data subject where identification and control of the master data is focused. Well known examples are customers, products, geographical locations, finance and risk, and employee data. Mastered data from these MDM domains are expected to find its way back to domains. The distribution of this data is similar to how data products are being distributed.

You could scope master data management and allow different approaches of data product distribution. For example, some data products within the boundaries of a certain scope don't have to conform to enterprise master data, while data products that are distribute beyond the scope must conform. Or you apply this pattern the other way around: only within a specific scope strict adherence is required. The lists or reference data is typically centrally managed within an MDM solution.

### Domain-level Master Data Management

When you look for overlapping data, you’re likely to discover different degrees of overlap. Some data is generic and spans many domains; other data has limited overlap and spans only a few domains. To distinguish the importance and amount of overlap, you could also extend MDM to domain-level MDM by creating partial views of master data within a specific scope. This is useful for data that is shared between some, but not all, domains. It's important for the overlapping domains to manage their data but to have no central dependency. MDM solutions in that respect can be best offered as service. Abstracting away the infrastructure and providing MDM as a service to your domains could simplify usage tremendously. If you're using a central solution, the recommendation is to apply segregated views for each of your individual domains or scopes.

### Achieving MDM consistency via reusable components

Another way of master data collaboration and reusability is code sharing. Here it’s not the master data that is shared but the underlying code (snippets and scripts) to generate the outputs and promote effective reuse. This code is stored in a central and open repository, including versioning, allowing [DataOps](./data-mesh-dataops.md) teams to contribute and improve upon what has been published.

The benefit of this model is that business logic is applied only within domains, which allows teams to deviate, make improvements, or use slightly optimized versions of the logic as they see fit. In addition, these outputs can be regenerated as improvements from the community find their way to the central code repository. One drawback of this model is consistency, since allowing teams to modify their code can make
comparing results between teams more difficult.

## Next steps

The importance of master data management is obvious: users can only make the correct decisions if the data they use is consistent and correct. MDM ensures consistency and quality on the enterprise level. Organizations need to find a balance. Introducing too many areas of master data or reference values will introduce too much cross-domain alignment. No enterprise data at all makes it impossible to compare any results.

A practical way to begin implementing MDM into your organization is to start with the simplest way of master data management: implementing a repository. With a repository you can quickly deliver value by learning what data needs to be aligned or is of bad quality without adjusting any of your domain systems.

A next step will be setting clearer scope. Don't fall into the trap of enterprise data unification by selecting all data. Start with subjects that add most value, such as customers, contracts, organizational units, or products. Only select the most important fields to master. The number of attributes should be in the tens, not the hundreds. After you've come to an agreement with your domains, align processes and governance. Make your agreements on timelines and reviews clear to all domains. Work on the metadata, too, so master data is cataloged, domains know what data elements from what source systems are candidates, and how these elements flow through the data pipelines.

The last step, which is the ultimate goal, is to achieve coexistence: where improvements flow directly back to your domains. This step is the most difficult because it requires many changes to the architecture. Domains need to be capable of handling corrections and improvements coming from the centrally managed MDM solution.
