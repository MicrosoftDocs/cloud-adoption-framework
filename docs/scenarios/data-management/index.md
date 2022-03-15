---
title: cloud-scale analytics overview
description: Gain an overview of an end-to-end scenario for cloud-scale analytics, with a focus on Azure implementation.
author: mboswell
ms.author: mboswell
ms.date: 02/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Cloud-scale analytics

With larger, more sophisticated forms of cloud adoption, the journey to the cloud becomes more complex. The Azure Cloud Scale Analytics is a scalable, repeatable framework for building a modern data platform that meets your unique business needs.

Cloud-scale analytics covers technical and non-technical considerations for analytics and governance in the cloud. This guidance strives to be cloud agnostic to support hybrid and multicloud adoption, but the technical implementation examples focus on Azure products. Key areas are to:

- Serve data as a product rather than a byproduct.
- Provide an ecosystem of data products instead of a singular data warehouse that might not best fit the data scenario.
- Drive a default approach to enforce data governance and security.
- Drive teams to consistently prioritize business outcomes instead of focusing just on the underlying technology.

It builds upon Microsoft's cloud adoption framework and requires understanding of landing zones. [What is a landing zone?](../../ready/landing-zone/index.md). If you don't have an implementation of Azure landing zones, then it's important to consult your cloud teams about how to meet prerequisites. For more information, see [Ensure the environment is prepared for the cloud adoption plan](../../ready/index.md).

Reference architectures allow you to start with a small footprint and grow over time, adapting the scenario to your use cases.

Cloud-scale analytics includes repeatable templates to accelerate five core infrastructure and resource deployments.

Cloud-scale analytics is adaptable for the size of your business so that if you're a small enterprise with limited staff, then having a centralized operations model mixed with some business subject matter experts might fit your business. However, if you're a large multinational enterprise with the goal of autonomous business units (with their own data engineers and analysts), a distributed operating model like data mesh or data fabric might fit your business better.

## Objectives

Cloud-scale analytics provides a framework built on the following principles to address challenges with complex data architectures that don't scale to the needs of businesses:

| Principle | Description |
|---------|---------|
|**Allow**     |<ul><li>Scale without increased complexity</li><li>Separation of concerns to facilitate governance</li><li>Self-serve data infrastructure</li></ul>|
|**Follow**     |<ul><li>Best practices for well-architected cloud services</li></ul>|
|**Support**     |<ul><li>On-premises and multicloud scenarios</li></ul>         |
|**Adopt**     |<ul><li>Product and vendor agnostic approach</li><li>Cloud Adoption Framework</li></ul>|
|**Commit**     |<ul><li>Azure landing zones as the baseline infrastructure for all workloads</li><li>Operating model</li></ul>|
|**Enable**     | <ul><li>Common data infrastructure</li><li>Distributed architecture under centralized governance</li><li>Secure network line-of-sight</li></ul>|

## Implementation guidance

Implementation guidance can be broken into two sections, guidance such as Cloud Adoption Framework and Azure Well-Architected Framework, apply to all workloads and then the documentation, which is specific to cloud-scale analytics.

### Global guidance

|Documentation  |Description  |
|---------|---------|
| [Cloud Adoption Framework](/azure/cloud-adoption-framework) |Managing and governing data is a lifecycle process that starts by building on your existing cloud strategy and carries all the way through to ongoing operations. The Cloud Adoption Framework will help to guide the full lifecycle for your data estate.         |
| [Azure Well-Architected Framework](./well-architected-framework.md) |Workload architecture and operations have a direct effect on data. Understand how your architecture can improve management and governance of the data used by your workload.         |

### Cloud-scale specific guidance

[!INCLUDE [documentation-sections](includes/documentation-sections.md)]

## Architectures

This section focuses on the details of a physical implementation of cloud-scale analytics. It maps out the physical architectures of data management landing zone and data landing zone.

Cloud-scale analytics uses two key architectural concepts: The *Data management landing zone* and the *data landing zones*. These architectures help accelerate deployment for many common cloud-scale analytics solutions by standardizing best practice and minimizing deployment bottlenecks for development teams. The guidance can be adopted for lakehouse and data mesh architectures. It highlights the capabilities required for a well-governed analytics platform that can scale according to your requirements.

The following diagram is an overview of a data platform with a central data management landing zone and multiple data landing zones. You can start with a single landing zone and scale to multiple landing zones, which are all governed from the data management landing zone.
:::image type="content" source="./images/data-landing-zone-index.png" alt-text="Diagram that shows a high-level design with a data management landing zone and data landing zones.":::

For more information, see: [Architectures Overview](architectures/overview-architectures.md)

## Deployment templates

This section includes many reference templates that can be deployed.

[!INCLUDE [deployment-templates-table](includes/deployment-templates-table.md)]

For more information, see [Deployment templates](./architectures/deployment-templates.md).

### Solution accelerators

Solution Accelerators are open-source projects on GitHub. They're repositories of resources and information that simplify and accelerate how problems are solved through the implementation of technology.

For more information, see [Solution Accelerators](architectures/solution-accelerators.md).

## Best practices

The following advanced, level-300+ articles in the **cloud-scale analytics** table of contents can help central IT teams deploy tools and manage processes for data management and governance:

- [The ingest process with cloud-scale analytics in Azure](best-practices/data-ingestion.md)
- [Overview of Azure Data Lake Storage for cloud-scale analytics](best-practices/data-lake-overview.md)
- [Use Azure Databricks within cloud-scale analytics in Azure](best-practices/azure-databricks-implementation.md)
- [Use Azure Synapse Analytics with cloud-scale analytics](best-practices/azure-synapse-analytics-implementation.md)
- [Azure Purview readiness checklist for cloud-scale analytics](best-practices/purview-checklist.md)
- [Azure Machine Learning as a data product for cloud-scale analytics](best-practices/data-science-best-practices.md)

## Featured Azure products

Expand the **Featured Azure products** section in the **cloud-scale analytics** table of contents to learn about the Azure products that support cloud-scale analytics.

## Common customer journeys

The following common customer journeys support the cloud-scale analytics:

- **Prepare your environment** Use [Prepare your environment](./plan.md) articles as resources. Establish processes and approaches to support the entire portfolio of workloads across your data estate.

- **Improve controls across your data estate.** Focus on [Govern your data estate](./govern.md) and [Secure your data estate](./secure.md) articles to integrate cloud-scale analytics into existing operations.

- **Influence changes to individual workloads:** As your cloud-scale analytics processes improve, the central data governance teams will find requirements that depend on knowledge of the architecture behind individual workloads. Use the [Architecture](./architectures/overview-architectures.md) articles to understand how you can use the scenario in for your use case.

- **Optimize individual workloads and workload teams.** Start with the [Azure Well-Architected Framework](./well-architected-framework.md) guidance to integrate cloud-scale analytics strategies into individual workloads. The guidance describes best practices and architectures that central IT and governance teams typically deliver to accelerate individual workload development.

- **Use best practices to onboard individual assets.** Expand the **Best practices** section in the **cloud-scale analytics** table of contents for articles about processes to onboard all of your data estate into one cloud-scale analytics control plane.

- **Use specific Azure products.** Accelerate and improve cloud-scale analytics capabilities by using the Azure products in the **Featured Azure products** section of the **cloud-scale analytics** table of contents.

## Take action

For more information about planning for implementing the cloud-scale analytics, see:

- [Develop a plan for cloud-scale analytics](plan.md)
- [Introduction to cloud-scale analytics](ready.md)

## Next steps

To start your cloud-scale analytics journey, learn about data governance:

> [!div class="nextstepaction"]
> [Introduction to cloud-scale analytics overview](overview-cloud-scale-analytics.md)
