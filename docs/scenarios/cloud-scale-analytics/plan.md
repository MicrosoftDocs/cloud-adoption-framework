---
title: Develop a plan for cloud-scale analytics
description: Understand how to build a plan for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Develop a plan for cloud-scale analytics

The Cloud Adoption Framework's [Plan methodology](../../plan/index.md) helps you create an overall cloud adoption plan to guide all programs and teams involved in your cloud-based digital transformation. The Plan methodology also provides templates to help you create your backlog and plans to help your teams build necessary skills. The backlog and plans you create should be based on what you plan to do in the cloud.

This article provides further guidance for data estate rationalization and skilling plans that are specific to cloud-scale analytics.

## Data estate rationalization

Much of the guidance in the Plan methodology focuses on the [five Rs of rationalizing your digital estate](../../digital-estate/5-rs-of-rationalization.md).

Using a cloud-scale analytics scenario shifts the primary focus of rationalization to the **data estate**, a subset of the overall digital estate. Your organization must evaluate the data estate more broadly and deeply than other scenarios require. Include plans for the overall analytics and [data governance](./govern.md) needed to support your desired maturity.

### Strategic initiatives

Begin to properly rationalize your data estate by aligning your business outcomes with each of your data initiatives. This alignment allows you to prioritize and clearly understand what value you can derive from each data initiative.

In your cloud migration plan, initiatives with small business impacts and lesser migration complexity can deliver quick efficiency gains. Initiatives with large business impacts or greater technical complexity require more detailed planning, but they can provide long-term innovation value.

:::image type="content" source="./images/strategic-initiative.png" alt-text="Diagram of strategic initiatives." lightbox="./images/strategic-initiative.png":::

### Prioritization

To begin prioritizing data projects, complete an [inventory and benchmark of your data estate](../../digital-estate/inventory.md). You can use tools like Azure Migrate to capture rich benchmarking data from the infrastructure and data assets in your estate. This benchmarking data helps you track progress and measure success. It can also help you quantify the exact investment needed for people, processes, and technology.

A mapping of business impact (from your strategic business outcomes) and technical complexity (from your data estate inventory) can guide your prioritization of data projects. The mapping achieves this prioritization by helping you identify waves of your cloud adoption effort. The waves can guide you as you prioritize data projects. The following table describes these cloud adoption waves in more detail.

| Wave | Rationalization | Outcomes |
|------|-----------------|----------|
|**Migrate & Modernize**| Rehost and refactor | Quick, tactical wins can be included in standard migration projects alongside other applications and infrastructure. Use tools like Azure Migrate to automate this type of one-time cloud migration. This approach allows you to modernize data platforms to Azure SQL Database, Azure Cosmos DB, or other transactional data structures.|
|**Transform & Modernize**| Rehost and refactor | When business value increases, so can the complexity of data estate management. Some amount of transmission, transformation, and synchronization is likely required to keep on-premises processes running while enabling richer functions in the cloud. Use tools like Azure Data Factory to help with the ongoing transformation after your data asset is migrated and modernized.|
|**Innovate with confidence**| Rearchitect or rebuild | Achieving high business value requires an ability to innovate with confidence. Use cloud-native data tools to democratize data, analyze information, and predict outcomes.|

### Workload identification

Strategic initiatives are delivered by the workloads that run on top of your data environment. To properly architect workloads, you must first identify the workloads running within your data estate. The identification process can be complex. Data workloads can include one or more data sources. They can also include multiple processes for preparing data, analyzing information, or predicting outcomes.

Use the previously described wave planning approach to simplify workload identification. For each wave, identify the data sources, applications, and infrastructure required to deliver your strategic initiative. Use the Azure Migrate tool to evaluate their dependencies and clearly understand workload groupings.

Transactional data assets are typically associated with an existing application, making workload identification easier.

Analysis and AI/machine learning solutions can be more complex, requiring a more granular review of the outcomes delivered by each. Associate analysis and AI solutions with the business processes that consume their outputs, often creating an application-level mapping. For cross-application BI, AI, or machine learning solutions, create new workload names to map the data assets to the business processes they impact.

Workloads identified in the digital estate assessment can be used throughout your adoption to drive business impact classification. Record the derived values using the [naming and tagging standards](../../ready/azure-best-practices/naming-and-tagging.md) that apply to all Azure cloud adoption efforts.

Identifying workloads will also help you gain a better understanding of the skills your teams need to be successful.

## Develop a skilling plan

Developing a skilling plan is part of building your capability to drive your data strategy. It's important to create a clear mapping of your product, services, or tools and your organization's people skills. The following exercise helps you to develop your skilling plan by preparing early and practicing agility.

## Prepare your plan with these tips

This section provides useful tips for developing your skilling plan.

### Prepare for potential challenges and roadblocks early

Harnessing the power of data in a secure and compliant manner is a challenge. You can run into various difficulties throughout the process, including:

* Organizational silos dividing your organization
* Roadblocks in your effort to build a data-driven culture
* Multiple tools and technologies being in use across your organization

Time-to-market is one of the most critical factors for any business. Your organization can have an excellent idea and the data to enable it, but challenges and roadblocks can significantly extend your time-to-market. An unexpected challenge might prevent you from gaining insights and business value from your data for weeks or months. It's important for you to prepare for potential challenges and roadblocks early, so you minimize the impact they can have on your time.

### Adopting agile delivery method

Agile is the ability to create and respond to change. It's a way to deal with, and ultimately succeed in, any uncertain and turbulent environment.

Agility requires you to think through what's going on in your current environment, identify any uncertainties, and plan how to adapt as you go.

## Next steps

The following articles can guide your cloud adoption journey and help your cloud adoption scenario to succeed:

- [Review your environment for Azure landing zones](./ready.md)
- [Govern cloud-scale analytics](./govern.md)
- [Secure cloud-scale analytics](./secure.md)