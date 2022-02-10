---
title: Azure data management and analytics scenario overview
description: Gain an overview of an end-to-end scenario for data management and analytics in the cloud, with a focus on Azure implementation.
author: mboswell
ms.author: mboswell
ms.date: 02/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Azure data management and analytics scenario

With larger, more sophisticated forms of cloud adoption, the journey to the cloud becomes more complex. This article series covers technical and non-technical considerations for data management and analytics in the cloud. This guidance strives to be cloud agnostic to support hybrid and multicloud adoption, but the technical implementation examples focus on Azure products.

It builds upon the cloud adoption framework and azure landing zones.

## Built on an Azure landing zone

Before you consider deploying the data management and analytics scenario, you need to understand how close you're to agility within your organization today.

Many enterprises have outdated data architectures that don't scale to the needs of large and multidisciplinary organizations. Centralized knowledge and capabilities introduce a bottleneck on a linear process workflow.

If you're a small enterprise with limited staff, then having a centralized model mixed with some business subject matter experts might fit your operations model.

If you're a large multinational enterprise with hundreds of data engineers and analysts spread around the business, a distributed operating model like data mesh might fit your business better. Data management and analytics scenario provides guidance to deploy the infrastructure to underpin these operation models.

Your business should consider how to best:

- Serve data as a product rather than a byproduct.
- Provide an ecosystem of data products instead of a singular data warehouse that might not best fit the data scenario.
- Drive a default way to enforce data governance and security.
- Drive teams to consistently prioritize business outcomes instead of obsessing over the underlying technology.

If you don't have an implementation of Azure landing zones, then it's important to consult your cloud teams about how to meet prerequisites. For more information, see [Ensure the environment is prepared for the cloud adoption plan](../../ready/index.md).

## Accelerate Azure landing zones for data management and analytics

Data management and analytics scenario requires an understanding of landing zones and uses infrastructure-as-code to deploy sample end-to-end solution templates. These customizable templates can help your organization get started with most data management and analytics scenarios:

- [What is a landing zone?](../../ready/landing-zone/index.md)
- [Choose a landing zone option](../../ready/landing-zone/choose-landing-zone-option.md)
- [Refactor landing zones](../../ready/landing-zone/refactor.md)
- [Data management and analytics landing zone](./ready.md)

This scenario focuses on supporting two targeted outcomes:

**Analytics:**

- Use the cloud to deliver increasingly mature analytics solutions.
- Migrate data platforms to the cloud.
- Data Democratize by making data and insights accessible to the average end user (subject to access privileges).
- Answer complex analytical questions with cloud-based analytics tools.
- Extend workloads with machine learning.

This scenario also provides a framework built on the following principles to address challenges with complex data architectures that don't scale to the needs of businesses:

| Principle | Description |
|---------|---------|
|**Allow**     |<ul><li>Scale without increased complexity</li><li>Separation of concerns to facilitate governance</li><li>Self-serve data infrastructure</li></ul>|
|**Follow**     |<ul><li>Best practices for well-architected cloud services</li></ul>|
|**Support**     |<ul><li>On-premises and multicloud scenarios</li></ul>         |
|**Adopt**     |<ul><li>Product and vendor agnostic approach</li><li>Cloud Adoption Framework</li></ul>|
|**Commit**     |<ul><li>Azure landing zones as the baseline infrastructure for all workloads</li><li>Operational model</li></ul>|
|**Enable**     | <ul><li>Common data infrastructure</li><li>Distributed architecture under centralized governance</li><li>Secure network line-of-sight</li></ul>|

## Implementation guidance

The data management and analytics scenario is designed to guide the end-to-end customer journey through the cloud adoption lifecycle. The full journey requires the following key components or guidance sets:

|Documentation  |Description  |
|---------|---------|
| [Cloud Adoption Framework](/azure/cloud-adoption-framework) |Managing and governing data is a lifecycle process that starts by building on your existing cloud strategy and carries all the way through to ongoing operations management. The Cloud Adoption Framework will help to guide the full lifecycle for your data estate.         |
| [Azure Well-Architected Framework](./well-architected-framework.md) |Workload architecture and operations have a direct affect on data. Understand how your architecture can improve management and governance of the data used by your workload.         |
| [Azure landing zones](../../ready/index.md) |Choosing a landing zone as the environment to host your workloads, preprovisioned through code establishes a code-based starting point for your Azure environment. Ensure the environment is prepared for the cloud adoption plan through Azure landing zones by starting with Cloud Adoption Framework [Azure landing zones](../../ready/enterprise-scale/index.md) to create the infrastructure of your data platform.         |
| [Data management and analytics scenario](ready.md)  |Representing a strategic design path for an Azure data management and analytics. The data management and analytics scenario pattern relies upon distribution of the data and its pipelines across domains. This pattern includes the capabilities such as storage, data lineage, data classification, data ingestion, networking, security, access management, encryption, resiliency and monitoring.         |

> [!TIP]
> Deployable reference implementations and templates make it easy to get started with the data management and analytics scenario. To learn more, see [Deployment templates](./architectures/deployment-templates.md).

## Reference architecture

*Data management landing zone* and *data landing zone* architectures help accelerate deployment for many common data management and analytics solutions. The guidance can be adopted for lakehouse and data mesh architectures. It highlights the capabilities required for a well-governed analytics platform which can scale according to your requirements.

The following diagram is an overview of a data platform with a central data management landing zone and multiple data landing zones. You can start with a single landing zone and scale to multiple landing zones, which are all governed from the data management landing zone.
:::image type="content" source="./images/data-landing-zone-index.png" alt-text="Diagram that shows a high-level design with a data management landing zone and data landing zones.":::

For more information, see:

- [Data management landing zone](architectures/data-management-landing-zone.md)
- [Data landing zone](architectures/data-landing-zone.md)

## Best practices

The following advanced, level-300+ articles in the **Data management and analytics scenario** table of contents can help central IT teams deploy tools and manage processes for data management and governance:

- [Data lake implementation](best-practices/data-lake-overview.md)
- [Azure Synapse Analytics implementation](best-practices/synapse.md)
- [Azure Databricks implementation](best-practices/azure-databricks-implementation.md)
- [Azure Purview implementation](best-practices/purview-checklist.md)
- [Data landing zone ingestion](best-practices/data-ingestion.md)
- [Data science environment](best-practices/data-science-best-practices.md)

## Featured Azure products

Expand the **Featured Azure products** section in the **Data management and analytics scenario** table of contents to learn about the Azure products that support data management and analytics.

## Common customer journeys

The following common customer journeys support the cloud data management and analytics scenario:

- **Prepare your environment** Use [Prepare your environment](./plan.md) articles as resources. Establish processes and approaches to support the entire portfolio of workloads across your data estate.

- **Improve controls across your data estate.** Focus on [Govern your data estate](./govern.md) and [Secure your data estate](./secure.md) articles to integrate data management and analytics into existing operations.

- **Influence changes to individual workloads:** As your data management and analytics processes improve, the central data governance teams will find requirements that depend on knowledge of the architecture behind individual workloads. Use the [Architecture](./architectures/architectures.md) articles to understand how you can use the scenario in for your use case.

- **Optimize individual workloads and workload teams.** Start with the [Azure Well-Architected Framework](./well-architected-framework.md) guidance to integrate data management and analytics strategies into individual workloads. The guidance describes best practices and architectures that central IT and governance teams typically deliver to accelerate individual workload development.

- **Use best practices to onboard individual assets.** Expand the **Best practices** section in the **Data management and analytics scenario** table of contents for articles about processes to onboard all of your data estate into one data management and analytics control plane.

- **Use specific Azure products.** Accelerate and improve data management and analytics capabilities by using the Azure products in the **Featured Azure products** section of the **Data management and analytics scenario** table of contents.

## Take action

For more information about planning for Azure data management and analytics, see:

- [Develop a plan for data management and analytics](plan.md)
- [Introduction to data management and analytics scenario](ready.md)

## Next steps

To start your cloud data management and analytics journey, learn about data governance:

> [!div class="nextstepaction"]
> [What is data governance?](overview-data-governance.md)
