---
title: Introduction to the data management and analytics scenario in Azure
description: Gain an overview of an end-to-end scenario for data management and analytics in the cloud, with a focus on Azure implementation.
author: mboswell
ms.author: mboswell
ms.date: 06/24/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Introduction to the data management and analytics scenario in Azure

As customers address larger, more sophisticated forms of cloud adoption, their journey to the cloud becomes more complex. This article series includes technical and non-technical considerations required to prepare for data management and analytics in the cloud. While this guidance strives to be cloud agnostic to allow for hybrid and multicloud adoption, the technical implementation examples focus on Azure products.

## Objectives and key results

This scenario focuses on supporting two targeted outcomes:

- **Analytics:** Use the cloud to deliver increasingly more mature analytics solutions. Migrate data platforms to the cloud. Democratize data using advanced visualization tools. Answer complex analytical questions with cloud-based analytics tools. Extend workloads with machine learning.

- **Data governance:** Properly manage your data estate to ensure data quality and maturity across all cloud deployments of your data. Govern how data is classified, categorized, and used to ensure your data is protected and reliable across all cloud deployments. For more information, see [Data summary and maturity model for Azure](./govern.md).

This scenario also provides a framework built on the following principles to address challenges with complex data architectures that do not scale to the needs of enterprises:

| Principle | Description |
|---------|---------|
|**Allow**     |<ul><li>Scale without increased complexity</li><li>Separation of concerns to facilitate governance</li><li>Self-serve data infrastructure</li></ul>|
|**Follow**     |<ul><li>Best practices for Well-Architected cloud services</li></ul>|
|**Support**     |<ul><li>On-premises and multicloud scenarios</li></ul>         |
|**Adopt**     |<ul><li>Product and vendor agnostic approach</li><li>Cloud Adoption Framework</li></ul>|
|**Commit**     |<ul><li>Azure landing zones as the baseline infrastructure for all workloads</li><li>Operational model</li></ul>|
|**Enable**     | <ul><li>Common data infrastructure</li><li>Distributed architecture under centralized governance</li><li>Secure network line-of-sight</li></ul>|

## Implementation guidance for the data management and analytics scenario

This scenario is designed to guide the end-to-end customer journey throughout the cloud adoption lifecycle. Delivery of the full journey requires the key components, or guidance sets described below.

|Documentation  |Description  |
|---------|---------|
|**[Cloud Adoption Framework](/azure/cloud-adoption-framework)**     |Managing and governing data is a lifecycle process that starts by building on your existing cloud strategy and carries all the way through to ongoing operations management. The Cloud Adoption Framework will help to guide the full lifecycle for your data estate.         |
|**[Azure Well-Architected Framework](./well-architected-framework.md)**     |Workload architecture and operations have a direct impact on data. Understand how your architecture can improve management and governance of the data used by your workload.         |
|**[Azure landing zones](/azure/cloud-adoption-framework/ready/)**     |Choosing a landing zone as the environment to host your workloads, preprovisioned through code establishes a code-based starting point for your Azure environment. Ensure the environment is prepared for the cloud adoption plan through Azure landing zones by starting with Cloud Adoption Framework [enterprise-scale landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/) to create the infrastructure of your data platform.         |
|**[Enterprise-scale for analytics and AI](enterprise-scale-landing-zone.md)**     |Representing a strategic design path for an Azure analytics and AI environment, the enterprise-scale for analytics and AI pattern relies upon distribution of the data and its pipelines across domains. This pattern includes the capabilities such as storage, data lineage, data classification, data ingestion, networking, security, access management, encryption, resiliency and monitoring.         |

> [!TIP]
> Deployable reference implementations and templates make it easy to get started with the data management and analytics scenario. To learn more, see [Deployment templates](./architectures/frequently-asked-questions.md).

## Reference architectures

This diagram is an overview of a data platform with a central data management landing zone and multiple data landing zones based on this scenario:

:::image type="content" source="./images/high-level-design-multiple-landing-zones.png" alt-text="High level design":::

Learn the details of the **data management landing zone** and **data landing zone** architectures that help to accelerate deployment for many common data management and analytics solutions:

- [Data management landing zone](./architectures/data-management-landing-zone.md)
- [Data landing zone](./architectures/data-management-landing-zone.md)

## Best practices

These level-300+ articles in the table of contents help central IT teams to deploy tools and manage the processes to ensure proper management and governance of your data.

- [Data lake implementation](best-practices/data-lake-overview.md)
- [Azure Synapse Analytics implementation](best-practices/synapse.md)
- [Azure Databricks implementation](best-practices/azure-databricks-implementation.md)
- [Azure Purview implementation](best-practices/purview-checklist.md)
- [Data landing zone ingestion](best-practices/data-ingestion.md)
- [Data science environment](best-practices/data-science-best-practices.md)

## Featured Azure products

Expand the **Featured Azure products** section in the table of contents to learn more about the products that support data management and analytics in Azure.

## Common customer journeys

**Prepare for centralized operations:** Use Cloud Adoption Framework articles to establish the processes and approaches required to support an entire portfolio of workloads across your data estate.

**Improve controls across your data estate:** Focus on the [Govern](/azure/cloud-adoption-framework/govern) and [Manage](/azure/cloud-adoption-framework/manage) articles to integrate data management and analytics into your existing operations processes. Use the [Ready](/azure/cloud-adoption-framework/ready) articles to deploy controls across all of your cloud environments.

**Influence changes to individual workloads (central IT and governance):** As your data management and analytics processes improve, the central data governance teams will find requirements that depend on knowledge of the architecture behind individual workloads. Use the Azure Well-Architected Framework guidance to help workload owners understand potential improvements to their workloads that will improve data operations.

**Optimize individual workloads (workload teams):** Workload owners should start with the Well-Architected guidance to understand the best ways to integrate data management and analytics strategies into their workloads. If the team is also supported by central IT and governance teams, this guidance will provide insights into best practices and architectures that these teams are typically accountable to deliver to accelerate your workload development.

**Processes to onboard individual assets:** Expand the Best practices section in the table of contents to execute a series of processes to onboard all of your data estate into a single data management and analytics control plane.

**Implement specific Azure products:** Accelerate and improve data management and analytics capabilities by using various Azure products outlined in the Featured Azure products section of the table of contents.

## Next steps

- [What is data governance?](./overview-data-governance.md)
- [Develop a plan for data management and analytics](plan.md)
- [Review your environment for Azure landing zones](ready.md)
- [Introduction to enterprise-scale for analytics and AI in Azure](enterprise-scale-landing-zone.md)
