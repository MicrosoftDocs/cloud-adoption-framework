---
title: Cloud-scale analytics - Microsoft Cloud Adoption Framework for Azure
description: Gain an overview of an end-to-end scenario for cloud-scale analytics, with a focus on Azure implementation.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank, build-2023, build-2023-dataai
---

# Cloud-scale analytics

With larger, more sophisticated forms of cloud adoption, your journey to the cloud becomes more complex. Azure cloud-scale analytics is a scalable, repeatable framework that meets your organization's unique needs for building modern data platforms.

Cloud-scale analytics covers both technical and nontechnical considerations for analytics and governance in the cloud. This guidance strives to support hybrid and multicloud adoption by being cloud agnostic, but the included technical implementation examples focus on Azure products.

Cloud-scale analytics has the following goals:

- Serve data as a product, rather than a byproduct
- Provide an ecosystem of data products, rather than a singular data warehouse that might not best fit your data scenario
- Drive a default approach to enforce data governance and security
- Drive teams to consistently prioritize business outcomes instead of focusing just on the underlying technology.

Cloud-scale analytics builds upon Microsoft's cloud adoption framework and requires an understanding of [landing zones](../../ready/landing-zone/index.md). If you don't already have an implementation of Azure landing zones, consult your cloud teams about how to meet prerequisites. For more information, see [Ensure the environment is prepared for the cloud adoption plan](../../ready/index.md).

Reference architectures allow you to begin with a small footprint and grow over time, adapting the scenario to your use cases.

Cloud-scale analytics includes repeatable templates that accelerate five core infrastructure and resource deployments. It's also adaptable for different organization sizes. If you're a small enterprise with limited resources, a centralized operations model mixed with some business subject matter experts might fit your situation. If you're a larger enterprise with autonomous business units (each with their own data engineers and analysts) as your goal, then a distributed operating model such as data mesh or data fabric might better address your needs.

## Objectives

Cloud-scale analytics provides a framework that is built on the following principles. These principles address challenges with complex data architectures that don't scale to the needs of organizations.

| Principle | Description |
|---------|---------|
|**Allow**     |<ul><li>Scaling without increased complexity</li><li>Separation of concerns to facilitate governance</li><li>Creation of self-serve data infrastructure</li></ul>|
|**Follow**     |<ul><li>Best practices for well-architected cloud services</li></ul>|
|**Support**     |<ul><li>On-premises and multicloud scenarios</li></ul>         |
|**Adopt**     |<ul><li>Product and vendor agnostic approach</li><li>Cloud Adoption Framework</li></ul>|
|**Commit**     |<ul><li>Azure landing zones as baseline infrastructure for all workloads</li><li>Operating model</li></ul>|
|**Enable**     | <ul><li>Common data infrastructure</li><li>Distributed architecture under centralized governance</li><li>Secure network line-of-sight</li></ul>|

## Implementation guidance

Implementation guidance can be broken into two sections:

- Global guidance that applies to all workloads.
- Cloud-scale specific guidance

### Global guidance

|Documentation  |Description  |
|---------|---------|
| [Cloud Adoption Framework](/azure/cloud-adoption-framework) |Managing and governing data is a lifecycle process, which begins by building on your existing cloud strategy and carries all the way through to your ongoing operations. The Cloud Adoption Framework helps guide your data estate's full lifecycle.         |
| [Azure Well-Architected Framework](./well-architected-framework.md) |Workload architecture and operations have a direct effect on data. Understand how your architecture can improve your management and governance of workload data.         |

### Cloud-scale specific guidance

[!INCLUDE [documentation-sections](../cloud-scale-analytics/includes/documentation-sections.md)]

## Architectures

This section addresses the details of physical implementations of cloud-scale analytics. It maps out the physical architectures of data management landing zones and data landing zones.

Cloud-scale analytics has two key architectural concepts:

- The data landing zone
- The data management landing zone
- Integration with software-as-a-service solutions such as Microsoft Fabric and Microsoft Purview 

These architectures standardize best practices and minimize deployment bottlenecks for your development teams, and can accelerate the deployment of common cloud-scale analytics solutions. You can adopt their guidance for lakehouse and data mesh architectures. That guidance highlights the capabilities you need for a well-governed analytics platform that scales to your needs.

For more information, see: [Architectures Overview](../cloud-scale-analytics/architectures/overview-architectures.md)

## Best practices

The following advanced, level-300+ articles in the **cloud-scale analytics** table of contents can help central IT teams deploy tools and manage processes for data management and governance:

- [Data ingestion for cloud-scale analytics](best-practices/data-ingestion.md)
- [Data lake storage for cloud-scale analytics](best-practices/data-lake-overview.md)
- [Use Azure Synapse Analytics for cloud-scale analytics](best-practices/azure-synapse-analytics-implementation.md)

## Featured Azure products

Expand the **Featured Azure products** section in the **cloud-scale analytics** table of contents to learn about the Azure products that support cloud-scale analytics.

## Common customer journeys

The following common customer journeys support cloud-scale analytics:

- **Prepare your environment.** Use the [Prepare your environment](./plan.md) articles as resources. Establish processes and approaches that support the entire portfolio of workloads across your data estate.

- **Influence changes to individual workloads.** As your cloud-scale analytics processes improve, your central data governance teams find requirements that depend on knowledge of the architecture behind individual workloads. Use the [Architecture](../cloud-scale-analytics/architectures/overview-architectures.md) articles to understand how you can use the scenarios within for your use case.

- **Optimize individual workloads and workload teams.** Start with the [Azure Well-Architected Framework](./well-architected-framework.md) guidance to integrate cloud-scale analytics strategies into individual workloads. This guidance describes best practices and architectures that central IT and governance teams should use to accelerate individual workload development.

- **Use best practices to onboard individual assets.** Expand the **Best practices** section in the **cloud-scale analytics** table of contents to find articles about processes for onboarding your entire data estate into one cloud-scale analytics control plane.

- **Use specific Azure products.** Accelerate and improve your cloud-scale analytics capabilities by using the Azure products in the **Featured Azure products** section of the **cloud-scale analytics** table of contents.

## Take action

For more information about planning for implementing the cloud-scale analytics, see:

- [Develop a plan for cloud-scale analytics](plan.md)
- [Introduction to cloud-scale analytics](ready.md)

## Next steps

Begin your cloud-scale analytics journey:

> [!div class="nextstepaction"]
> [Introduction to cloud-scale analytics](../cloud-scale-analytics/overview-cloud-scale-analytics.md)