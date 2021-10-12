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

This scenario focuses on supporting two targeted outcomes:

- **Analytics:** Use the cloud to deliver increasingly more mature analytics solutions. Migrate data platforms to the cloud. Democratize data using advanced visualization tools. Answer complex analytical questions with cloud-based analytics tools. Extend workloads with machine learning.

- **Data governance:** Properly manage your data estate to ensure data quality and maturity across all cloud deployments of your data. Govern how data is classified, categorized, and used to ensure your data is protected and reliable across all cloud deployments. For more information, see [Data summary and maturity model for Azure](./govern.md).

## Components of the scenario

This scenario is designed to guide the end-to-end customer journey throughout the cloud adoption lifecycle. Delivery of the full journey requires the following key components, or guidance sets:

- [Cloud Adoption Framework](/azure/cloud-adoption-framework/): Managing and governing data is a lifecycle process that starts by building on your existing cloud strategy and carries all the way through to ongoing operations management. The Cloud Adoption Framework will help to guide the full lifecycle for your data estate.

- [Azure Well-Architected Framework](./well-architected-framework.md): Workload architecture and operations have a direct impact on data. Understand how your architecture can improve management and governance of the data used by your workload.

- [Reference architectures](./architectures/data-management-landing-zone.md): These reference solutions help to accelerate deployment for many common data management and analytics solutions.

- [Best practices](./best-practices/data-lake-overview.md): These level-300+ articles in the table of contents help central IT teams to deploy tools and manage the processes to ensure proper management and governance of your data.

- **Featured Azure products:** Expand this section in the table of contents to learn more about the products that support data management and analytics in Azure.

- [Microsoft Learn modules](/learn/): Gain the hands-on skills required to implement, maintain, and support data management and analytics solutions.

## Common customer journeys

**Prepare for centralized operations:** Use Cloud Adoption Framework articles to establish the processes and approaches required to support an entire portfolio of workloads across your data estate.

**Improve controls across your data estate:** Focus on the [Govern methodology](/azure/cloud-adoption-framework/govern/) and [Manage methodology](/azure/cloud-adoption-framework/manage/) articles to integrate data management and analytics into your existing operations processes. Use the [Ready methodology](/azure/cloud-adoption-framework/ready/) articles to deploy controls across all of your cloud environments.

**Influence changes to individual workloads (central IT and governance):** As your data management and analytics processes improve, the central data governance teams will find requirements that depend on knowledge of the architecture behind individual workloads. Use the Azure Well-Architected Framework guidance to help workload owners understand potential improvements to their workloads that will improve data operations.

**Optimize individual workloads (workload teams):** Workload owners should start with the Well-Architected guidance to understand the best ways to integrate data management and analytics strategies into their workloads. If the team is also supported by central IT and governance teams, this guidance will provide insights into best practices and architectures that these teams are typically accountable to deliver to accelerate your workload development.

**Processes to onboard individual assets:** Expand the **Best practices** section in the table of contents to execute a series of processes to onboard all of your data estate into a single data management and analytics control plane.

**Implement specific Azure products:** Accelerate and improve data management and analytics capabilities by using various Azure products outlined in the **Featured Azure products** section of the table of contents.

## Next steps

[What is data governance?](./overview-data-governance.md)
