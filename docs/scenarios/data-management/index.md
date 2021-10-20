---
title: Azure data management and analytics scenario overview
description: Gain an overview of an end-to-end scenario for data management and analytics in the cloud, with a focus on Azure implementation.
author: mboswell
ms.author: mboswell
ms.date: 10/08/2021
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

**Data governance:**

- Properly manage the data estate to ensure data quality and maturity across all cloud deployments.
- Govern how to classify, categorize, and use data to ensure data protection and reliability across all cloud deployments.

For more information, see [Data summary and maturity model for Azure](./govern.md).

This scenario also provides a framework built on the following key principles. These principles address current challenges with complex data architectures that don't scale to the needs of enterprises.

**Allow:**

- Scale without increased complexity.
- Separate concerns to make governance easier.
- Self-serve data infrastructure.

**Follow:**

- Best practices for well-architected cloud services.

**Support:**

- On-premises and multicloud scenarios.

**Adopt:**

- A product and vendor agnostic approach.
- The Cloud Adoption Framework.

**Commit to:**

- Azure landing zones as the baseline infrastructure for all workloads.
- An operational model.

**Enable:**

- Common data infrastructure.
- Distributed architecture under centralized governance.
- Secure network line-of-sight.

## Implementation guidance

The data management and analytics scenario is designed to guide the end-to-end customer journey through the cloud adoption lifecycle. The full journey requires the following key components or guidance sets:

|Documentation  |Description  |
|---------|---------|
|[Cloud Adoption Framework](/azure/cloud-adoption-framework)|Data management and governance is a lifecycle process. Start by building on your existing cloud strategy, and carry through to ongoing operations management. The Cloud Adoption Framework helps guide the full lifecycle for your data estate.|
|[Azure Well-Architected Framework](well-architected-framework.md)|Workload architecture and operations have a direct impact on data. Understand how your architecture can improve management and governance of the data your workloads use.|
|[Azure landing zones](../../ready/index.md)|Choose a landing zone as the environment to host your workloads. Preprovisioning through code establishes a starting point for your Azure environment. Make sure to prepare the environment for the cloud adoption plan through Azure landing zones. Start with cloud adoption framework [enterprise-scale landing zones](../../ready/enterprise-scale/index.md) to create the infrastructure for your data platform.|
|[Enterprise-scale for analytics and AI](enterprise-scale-landing-zone.md)|The enterprise-scale strategic design pattern for analytics and AI environment relies on distribution of data and its pipelines across domains. This pattern includes capabilities like storage, data lineage, data classification, data ingestion, networking, security, access management, encryption, resiliency, and monitoring.|

> [!TIP]
> Deployable reference implementations and templates make it easy to get started with the data management and analytics scenario. To learn more, see [Deployment templates](eslz-deployment-templates.md).

## Reference architecture

*Data management landing zone* and *data landing zone* architectures help accelerate deployment for many common data management and analytics solutions. The following diagram is an overview of a data platform with a central data management landing zone and multiple data landing zones:

:::image type="content" source="images/high-level-overview-multiple-data-landing-zones.png" alt-text="Diagram that shows a high-level design with a data management landing zone and data landing zones." border="false":::

For more information, see:

- [Data management landing zone](architectures/data-management-landing-zone.md)
- [Data landing zone](architectures/data-management-landing-zone.md)

## Best practices

The following advanced, level-300+ articles in the **Data management and analytics scenario** table of contents (TOC) can help central IT teams deploy tools and manage processes for data management and governance:

- [Data lake implementation](best-practices/data-lake-overview.md)
- [Azure Synapse Analytics implementation](best-practices/synapse.md)
- [Azure Databricks implementation](best-practices/azure-databricks-implementation.md)
- [Azure Purview implementation](best-practices/purview-checklist.md)
- [Data landing zone ingestion](best-practices/data-ingestion.md)
- [Data science environment](best-practices/data-science-best-practices.md)

## Featured Azure products

Expand the **Featured Azure products** section in the **Data management and analytics scenario** TOC to learn about the Azure products that support data management and analytics.

## Common customer journeys

The following common customer journeys support the cloud data management and analytics scenario:

- **Prepare for centralized operations.** Use [Cloud Adoption Framework](/azure/cloud-adoption-framework) articles as resources. Establish processes and approaches to support the entire portfolio of workloads across your data estate.

- **Improve controls across your data estate.** Focus on [Govern](../../govern/index.md) and [Manage](../../manage/index.md) articles to integrate data management and analytics into existing operations. Use the [Ready](../../ready/index.md) articles to deploy controls across all your cloud environments.

- **Use central IT governance to influence changes to individual workloads.** As data management and analytics processes improve, some requirements depend on knowing the architecture behind individual workloads. Use [Well-Architected Framework](./well-architected-framework.md) guidance to help individual workload owners improve their workloads to support data operations.

- **Optimize individual workloads and workload teams.** Start with the [Well-Architected Framework](./well-architected-framework.md) guidance to integrate data management and analytics strategies into individual workloads. The guidance describes best practices and architectures that central IT and governance teams typically deliver to accelerate individual workload development.

- **Use best practices to onboard individual assets.** Expand the **Best practices** section in the **Data management and analytics scenario** TOC for articles about processes to onboard all of your data estate into one data management and analytics control plane.

- **Use specific Azure products.** Accelerate and improve data management and analytics capabilities by using the Azure products in the **Featured Azure products** section of the **Data management and analytics scenario** TOC.

## Next steps

For more information about planning for Azure data management and analytics, see:

- [Develop a plan for data management and analytics](plan.md)
- [Review your environment for Azure landing zones](ready.md)
- [Introduction to enterprise-scale for analytics and AI in Azure](enterprise-scale-landing-zone.md)

To start your cloud data management and analytics journey, learn about data governance:

> [!div class="nextstepaction"]
> [What is data governance?](overview-data-governance.md)
