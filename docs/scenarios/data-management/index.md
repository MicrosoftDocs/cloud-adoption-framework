---
title: Azure data management and analytics scenario overview
description: Gain an overview of an end-to-end scenario for data management and analytics in the cloud, with a focus on Azure implementation.
author: mboswell
ms.author: mboswell
ms.date: 12/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Azure data management and analytics scenario

With larger, more sophisticated forms of cloud adoption, the journey to the cloud becomes more complex. This article series covers technical and non-technical considerations for data management and analytics in the cloud. This guidance strives to be cloud agnostic to support hybrid and multicloud adoption, but the technical implementation examples focus on Azure products.

## Objectives

This scenario focuses on supporting two targeted outcomes:

**Analytics:**

- Use the cloud to deliver increasingly mature analytics solutions.
- Migrate data platforms to the cloud.
- Democratize data by using advanced visualization tools.
- Answer complex analytical questions with cloud-based analytics tools.
- Extend workloads with machine learning.

This scenario also provides a framework built on the following principles to address challenges with complex data architectures that do not scale to the needs of enterprises:

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
| [Azure Well-Architected Framework](./well-architected-framework.md) |Workload architecture and operations have a direct impact on data. Understand how your architecture can improve management and governance of the data used by your workload.         |
| [Azure landing zones](../../ready/index.md) |Choosing a landing zone as the environment to host your workloads, preprovisioned through code establishes a code-based starting point for your Azure environment. Ensure the environment is prepared for the cloud adoption plan through Azure landing zones by starting with Cloud Adoption Framework [Azure landing zones](../../ready/enterprise-scale/index.md) to create the infrastructure of your data platform.         |
| [Data management and analytics scenario](enterprise-scale-landing-zone.md)  |Representing a strategic design path for an Azure data management and analytics. The Data management and analytics scenario pattern relies upon distribution of the data and its pipelines across domains. This pattern includes the capabilities such as storage, data lineage, data classification, data ingestion, networking, security, access management, encryption, resiliency and monitoring.         |

> [!TIP]
> Deployable reference implementations and templates make it easy to get started with the data management and analytics scenario. To learn more, see [Deployment templates](./architectures/frequently-asked-questions.md).

## Reference architecture

*Data management landing zone* and *data landing zone* architectures help accelerate deployment for many common data management and analytics solutions. The following diagram is an overview of a data platform with a central data management landing zone and multiple data landing zones:

:::image type="content" source="./images/high-level-design-multiple-landing-zones.png" alt-text="Diagram that shows a high-level design with a data management landing zone and data landing zones.":::

For more information, see:

- [Data management landing zone](architectures/data-management-landing-zone.md)
- [Data landing zone](architectures/data-management-landing-zone.md)

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

- **Prepare for centralized operations.** Use [Cloud Adoption Framework](/azure/cloud-adoption-framework) articles as resources. Establish processes and approaches to support the entire portfolio of workloads across your data estate.

- **Improve controls across your data estate.** Focus on [Govern](../../govern/index.md) and [Manage](../../manage/index.md) articles to integrate data management and analytics into existing operations. Use the [Ready](../../ready/index.md) articles to deploy controls across all your cloud environments.

- **Influence changes to individual workloads (central IT and governance):** As your data management and analytics processes improve, the central data governance teams will find requirements that depend on knowledge of the architecture behind individual workloads. Use the [Azure Well-Architected Framework](./well-architected-framework.md) guidance to help workload owners understand potential improvements to their workloads that will improve data operations.

- **Optimize individual workloads and workload teams.** Start with the [Azure Well-Architected Framework](./well-architected-framework.md) guidance to integrate data management and analytics strategies into individual workloads. The guidance describes best practices and architectures that central IT and governance teams typically deliver to accelerate individual workload development.

- **Use best practices to onboard individual assets.** Expand the **Best practices** section in the **Data management and analytics scenario** table of contents for articles about processes to onboard all of your data estate into one data management and analytics control plane.

- **Use specific Azure products.** Accelerate and improve data management and analytics capabilities by using the Azure products in the **Featured Azure products** section of the **Data management and analytics scenario** table of contents.

## Take action

For more information about planning for Azure data management and analytics, see:

- [Develop a plan for data management and analytics](plan.md)
- [Review your environment for Azure landing zones](ready.md)
- [Introduction to Data management and analytics scenario in Azure](enterprise-scale-landing-zone.md)

## Next steps

To start your cloud data management and analytics journey, learn about data governance:

> [!div class="nextstepaction"]
> [What is data governance?](overview-data-governance.md)
