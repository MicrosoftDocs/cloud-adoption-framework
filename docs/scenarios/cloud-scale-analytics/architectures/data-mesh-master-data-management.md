---
title: Manage master data in data mesh
description: Learn about managing master data in data mesh.
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Manage master data in data mesh

Enterprises using a data mesh architecture often have a large number of domains, each containing unique systems and data. 

This widespread distribution of data increases complexity because multiple versions of the same data might exist in this setup. Integration requires more effort because owners have to integrate and harmonize all the different parts of the same data from multiple domains. Data can be inconsistent between these different domains, and data quality can also vary. Apply [master data management (MDM)](../../data-management/govern-master-data.md) to address these challenges.

## Domain-oriented master data management

Master identification numbers are an important aspect of your MDM. These numbers link together mastered data and data from your domains. They're critical to your ability to track down what data has been mastered and what data belongs together. You can only identify unique data and assign master identification numbers centrally, not locally within a system. Your master data from different systems must be together within your MDM solution.

MDM works differently in domain-oriented architectures due to their distributed nature. Consistency is harder to achieve because you rely on MDM within your domains.

One way to achieve consistency is to ask your domains to conform to centrally managed master data when distributing [data products](../../data-management/architectures/data-landing-zone-data-products.md). You can publish a list of master data in a master data store or central repository. Your domain can classify data using the enterprise reference identifiers from your enterprise reference data when distributing data products across other domains. This lets your other domains quickly recognize any master data within those data products.

:::image type="content" source="../media/master-data-management-01.png" alt-text="Master Data Management Domain" lightbox="../media/master-data-management-01.png":::

You can also create new MDM domains when grouping your MDM activities and using a master data store as a centralized repository. Each new MDM domain should contain a specific data subject that the identification and control of your master data focus on. Some well-known examples of this data include customers, products, employees, geographical locations, and finance and risk information. Mastered data from these MDM domains must find its way back to other domains. This distribution of data is similar to the distribution of your data products.

You can scope master data management and allow different approaches to data product distribution. Within the boundaries of a certain scope, data products don't have to conform to enterprise master data, but beyond the scope's boundaries, data products must conform. You can also apply this pattern in reverse, requiring adherence to master data only within a specific scope and not outside it. In these setups, your mastered data is centrally managed within your MDM solution. Your domains need to exchange master data so they know which local data to map to central master data. Identify and maintain these relationships so you know which data has been mastered and which data you can quickly link together. If a local domain keys in an operational system change, a master identifier is the only element binding everything together.

When you distribute master identifiers, don't extrapolate your MDM master identifiers to all source systems. Doing so can cause consistency issues. Only your applications or systems that are subject to MDM should obtain a master identifier from your MDM hub. Systems not subject to MDM should use their own local (domain) integrity.

### Domain-level master data management

When you look for overlapping data, you'll likely discover various degrees of overlap. Some data is generic and spans many domains. Other data has limited overlap and only spans a few domains. Distinguish the amount of data overlap and its importance by extending MDM to domain-level MDM. You can do this by creating partial views of your master data within a specific scope. This is useful when your data is shared between some, but not all, of your domains.

:::image type="content" source="../media/master-data-management-02.png" alt-text="Domain-level Master Data Management" lightbox="../media/master-data-management-02.png":::

It's important that overlapping domains manage data but have no central dependency. MDM solutions can help you achieve this. You can simplify usage tremendously by abstracting away infrastructure and providing MDM as a service to your domains. If you use a central solution, apply segregated views for each individual domain or scope.

### Achieve consistency with reusable components

Code sharing is another way to ensure master data collaboration and reusability. Instead of sharing master data, you share the underlying code (snippets and scripts) to generate outputs and promote effective reuse. Store this underlying code in a central and open repository with version control. Your teams can all contribute to and improve upon code that lives in this repository.

In this model, you apply business logic only within domains. Your teams can deviate, make improvements, or use slightly optimized versions of the logic as they see fit. You can regenerate your outputs as improvements from your community are added to your central code repository.

Note that allowing your teams to modify their code can make comparing results between various teams more difficult, which can impact consistency.

## Master data management summary

Users can only make correct decisions if the data they use is consistent and correct. By using MDM, you can ensure your data's consistency and quality at the enterprise level.

Your organization must find the correct balance for MDM. Having too many areas of master data or reference values leads to too much cross-domain alignment. Having no enterprise data at all makes it impossible to compare any results. A practical way to begin using MDM in a balanced way is to implement a repository. This is the simplest way to manage your organization's master data. With a repository, you don't need to adjust your domain systems to learn what data is low quality or needs to be aligned. With a repository helping you gain that information, you can deliver value more quickly.

After you implement a repository, you need to outline a clear scope. Don't fall into the trap of enterprise data unification by selecting all data. Only master data from your most important fields. Begin by selecting subjects that add the most value, like customers, contracts, products, and organizational units. Your number of attributes should be in the tens, not the hundreds or thousands.

Align your processes and governance after you've come to an agreement with your domains. Make any agreements on timelines and reviews clear to all domains. Also, make sure you work on your metadata. Catalog your master data. Ensure your domains know which data elements are candidates from which source systems, and how those elements flow through your data pipelines.

The final step, and your ultimate goal, is achieving coexistence. Your improvements should flow directly back to your domains. This is the most difficult part of the process because it requires you to make many architecture changes. Your domains need to be able to handle corrections and improvements sent from your centrally managed MDM solution.

## Next steps

- [Operationalize data mesh for AI/ML domain driven feature engineering](operationalize-data-mesh-for-ai-ml.md)