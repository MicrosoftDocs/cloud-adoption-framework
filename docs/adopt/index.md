---
title: Adopt the cloud
description: Use the Cloud Adoption Framework for Azure to understand the adoption horizons necessary to identify and prioritize, based on your adoption goals.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/26/2022

ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-adopt
keywords: cloud adoption, cloud framework, cloud adoption framework
---
<!--This article was called out as a dependency needed for the "envision" content of the modernize methodology documentation. Alternative proposed filename was "establishing-cloud-horizons", but naming index.md for now since it's serving as the overview for "adopt", at least for the time being.*-->
# Adopt the cloud

There are three paths to cloud adoption: migrate, modernize, or innovate. The path you choose and when depends your business goals (*see figure*). We provide guidance in this methodology to help you decide the best path for your needs. Most cloud adoption plans visit all three paths at some point. Your business goals will determine your specific cloud adoption plan.

:::image type="content" source="../_images/adopt/cloud-adoption-plan.png" alt-text="Image showing three cloud adoption paths":::

## Migrate

Migration is moving workloads to the cloud. There are many different forms of migration. But in this context, migration refers to simple rehosting or "lift-and-shift." You are trading on-premises infrastructure for cloud infrastructure-as-a-service (IaaS) solutions.

- *Example:* Migrate application from on-premises to IaaS solutions in the cloud.
- *Goals:* Exit the data center, enhance security, improve operations.
- *Solutions:* Trade your on-site capital expense for a pay-as-you-go model and adopt IaaS solutions.
- *Key Benefits:* Cost, security, availability, visibility, performance.

> [!IMPORTANT]
> You can modernize while you migrate. See next steps.

## Modernize

Modernization is the process of adopting the benefits of the cloud. The most common form of modernization is moving from on-premises or IaaS models to PaaS and SaaS solutions. The focus is enhancing business processes at scale.

- *Examples*: Move SQL database to Azure SQL database. Move a containerized application to Azure Kubernetes Service.
- *Goals:* Reduce technical debt, modernize applications, and modernize data platforms
- *Solutions:* Adopt platform-as-a-service (PaaS) solutions across workload clusters.
- *Key Benefits:* Cost, security, availability, visibility, performance, and operations.

## Innovate

The innovate horizon focuses on applying customer-focused solutions that transform business outcomes.

- *Goals:* Reposition your business, reposition technical solutions, and find innovative data plays.
- *Solutions:* Use data and applications to empower adoption and build predictive tools.
- *Key Benefits:* Predictive analytics, performance, and adaptability.

## Next steps

> [!div class="nextstepaction"]
> [Migrate or Modernize?](../adopt/migrate-modernize-approaches.md)
