---
title: Building a plan for data management and analytics in Azure
description: Building a plan for data management and analytics
author: pratimdas
ms.author: brblanch
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Develop a plan for data management and analytics

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. The Plan methodology also provides templates to create your backlog and plans to build necessary skills across your teams. The backlog and plans you create are all based on what you are trying to do in the cloud.

This article builds on the Plan methodology. It has specific guidance for data estate rationalization and skilling plans, specific to data management and analytics.

## Data estate rationalization

Much of the guidance in the Plan methodology focuses on the [five Rs of rationalizing your digital estate](../../digital-estate/5-rs-of-rationalization.md). This scenario narrows the primary focus of rationalization to the **data estate**, which is a subset of the overall digital estate. This plan will also look broader and deeper at the data estate than you might in other plans. Specifically, it must include plans for your overall analytics and [data governance](./govern.md) required to support the desired maturity.

### Strategic initiatives

To properly rationalize your data estate, begin by aligning your business outcomes to each of your data initiatives. This alignment will aid in prioritization and a clear understanding of the value your can derive from each data initiative. Initiatives that represent little business value and present lesser complexity for migration, can easily be included in your cloud migration plan to deliver quick efficiency gains. Initiatives with the greatest business impact or technical complexity typically require richer planning to enable long-term innovation value.

:::image type="content" source="./images/strategic-initiative.png" alt-text=" Diagram of strategic initiative." lightbox="./images/strategic-initiative.png":::

### Prioritization

To prioritize projects (like those pictured in the prior section), it's critical to begin with an [inventory and benchmark of your data estate](../../digital-estate/inventory.md). Tools like Azure Migrate can be used to capture rich benchmarking data from the infrastructure and data assets in your estate. This data can aid in tracking progress and measuring success. With this data, you can also quantify the exact investment needed for people, process, and technology.

A mapping of the business impact (from your strategic business outcomes) and technical complexity (from your data estate inventory) will identify waves of cloud adoption efforts to aid in prioritization of data projects.

|Wave| Rationalization | Outcomes |
|----------|--------------|
|**Migrate & Modernize**| Rehost and refactor | Tactical, quick wins can be included in a standard migration projects alongside other applications and infrastructure. Tools like Azure Migrate can automated this type of one-time migration to the cloud. When possible, this approach allows for modernization of the data platform to Azure SQL Database, Azure Cosmos DB, or other transactional data structures.|
|**Transform & Modernize**| Rehost and refactor | When business value increases, so may the complexity of data estate management. These data assets will likely require a degree of transmission, transformation, & synchronization to keep on-premises processes running, while also enabling richer functions in the cloud. Tools like Azure Data Factory can help with the ongoing transformation after the data asset is migrated and modernized.|
|**Innovate with confidence**| Rearchitect or rebuild | Achieving high business value requires the ability to innovate with confidence. Use cloud-native data tools to democratize data, analyze information, and predict outcomes. |

### Workload identification

Strategic initiatives are delivered by the workloads which run on top of your data environment. To properly architect workloads, you must first identify the workloads running within your data estate. At times, this process can be complex. Data workloads can include one or more data sources. They may also include one or more processes for preparing data, analyzing information, or predicting outcomes.

To simplify workload identification, start with wave planning approach described in the prior two sections. For each wave, identify the data sources, applications, and infrastructure required to deliver the strategic initiative. Evaluate their dependencies to see workload groupings more clearly, using the Azure Migrate tool.

- Transactional data assets will typically be associated with an existing application, making workload identification easier.
- Analysis and AI/machine learning solutions may be a bit more complex, requiring a more granular review of the outcomes delivered by each. When possible, associate analysis and AI solutions with the business processes which consumes their outputs, often creating an application level mapping. For cross-application BI, AI, or machine learning solutions, create new workload names to map the data assets to the business processes they impact.

Workloads identified in the digital estate assessment will be used throughout adoption to drive business impact classification. The derived values should be recorded using the same [naming and tagging standards](/ready/azure-best-practices/naming-and-tagging.md) used for other cloud adoption efforts.

It will also develop a better understanding of the skills your teams will need to be successful.

## Develop a skilling plan

Developing a skilling plan is part of building the capability to drive your data strategy. It's important to create a clear mapping of the product, services, or tools capabilities maturity assessment, along with your organization's people skills. The exercise assists with how to decide who will help deliver on the achieving the overall objectives.

:::image type="content" source="./images/who-can-transform.png" alt-text="Diagram of who can help transform." lightbox="./images/who-can-transform.png":::

This list isn't exhaustive and it might vary depending on the organization type or structure.

### Assess capability maturity

There must be an exercise in assessing the data analytics and AI capabilities required to deliver on a specific use case, holistically or at an organizational level. However, there has to be some guiding principles and processes to complete the assessment:

- Define current capabilities and ambition
- Identify risks and blockers to progress
- Clearly state benefits and key stakeholders
- Link benefits to stated business objectives
- Identify key dependencies

As a next step, look at Azure native services, and start mapping what you need to deliver success.

Along with the capability maturity assessment, culture is also another important aspect that is the key focus of this framework to make it successful.

## Prepare your plan with these tips

This section provides an overview of the critical tips that can improve your overall plan.

### Prepare for potential challenges and roadblocks early

It's challenging to harness the power of data in a secure and compliant manner. You might run into challenges like organizational silos, building a data-driven culture, and the use of multiple tools and technologies across the organization. Time-to-market is one of the most critical factors for all businesses. Organizations can have great ideas and data can be an enabler. But because of challenges, it might take weeks or months before you start gaining insights and ultimately deliver business value from data. It's important to prepare for potential challenges early.

### Initial organization alignment: center of excellence

Center of excellence can assist with:

- Driving adoption, standards, best practices, and innovation
- Funded team for full delivery and specialist skills provision
- Deep technical skills in key technologies
- Active participation and evangelizing in communities of practice

![Diagram of the strategy cycle.](./images/strategy-cycle.png)

### Adopting agile delivery method

Agile is the ability to create and respond to change. It's a way of dealing with, and ultimately succeeding in, an uncertain and turbulent environment.

Agility is about thinking through how to understand what's going on in your current environment, identify what uncertainty you're facing, and plan how to adapt as you go.

## Next step

The following articles can guide your cloud adoption journey and help you succeed in the cloud adoption scenario.

- [Review your environment or Azure landing zones](./ready.md)
- [Govern data management and analytics](./govern.md)
- [Secure data management and analytics](./secure.md)
