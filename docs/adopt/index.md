---
title: How to adopt the cloud
description: The adopt methodology shows you how to migrate, modernize, innovate, and relocate workloads in Azure.
author: stephen-sumner
ms.author: ssumner
ms.date: 2/3/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-adopt
keywords: cloud adoption, cloud framework, cloud adoption framework
---

# Cloud adoption

The adopt methodology shows you how to migrate, modernize, innovate, and relocate workloads in Azure. These four processes align to different phases and goals in cloud adoption journey. This article provides an overview of each process, so you can find the right guidance for your objectives.

## Migrate

Migration is when you move your workloads to the cloud. Different forms of migration exist, but the guidance focuses on rehosting, also known as the "lift-and-shift" approach. With rehosting, you move an existing workload to comparable solutions in the cloud without modifying the workload.

- ***Goals:*** Quickly exit on-premises, enhance security, and improve operations.

- ***Solutions:*** Adopt comparable solutions in the cloud.

- ***Key benefits:*** Cost, security, availability, visibility, performance. You don't have to worry about acquiring, managing, and securing hardware.

- ***Example:*** Migrate applications from on-premises to Azure virtual machines (infrastructure-as-a-service) or Azure App Service (platform-as-a-service).

> [!div class="nextstepaction"]
> [Migrate](../migrate/index.md)

## Modernize

Modernization enhances existing applications to improve operations, increase efficiency, maximize developer velocity, and reduce the total cost of ownership. Generally, modernization moves toward platform-as-a-service (PaaS) solutions to improve your business at scale.

- ***Goals:*** Reduce technical debt, modernize applications, and modernize data platforms.

- ***Solutions:*** Adopt more platform-as-a-service (PaaS) solutions across workload clusters.

- ***Key benefits:*** Cost, security, availability, visibility, performance, and operations. You don't have to manage the underlying infrastructure and can focus on scaling your business.

- ***Examples:*** Move to managed services. Move from SQL database to Azure SQL database. Containerize applications and migrate from virtual machines to Azure Kubernetes Service or Container Apps.

> [!div class="nextstepaction"]
> [Modernize](../modernize/index.md)

## Innovate

Innovation is when you adopt cloud-native technologies to create customer-focused solutions that rapidly transform business outcomes.

- ***Goals:*** Reposition your business, reposition technical solutions, and find innovative data plays.

- ***Solutions:*** Adopt data and application capabilities to empower adoption and build predictive tools.

- ***Key benefits:*** Predictive analytics, performance, and adaptability.

> [!div class="nextstepaction"]
> [Innovate](../innovate/index.md)

## Relocate

Relocation is when you move an Azure workload to a different region in Azure. You can relocate a workload anytime after migration. Relocation evaluations should be a regular part of your workload lifecycle so your workload evolves with your business needs.

- ***Goals:*** Respond to business changes and expand your global footprint, meet data sovereignty and residency requirements, provide lower latency to end users.

- ***Solutions:*** Adopt the location, services, and capabilities of a new Azure region.

- ***Key benefits:*** Respond to business changes, expand global footprint, meet data sovereignty and residency requirements, provide lower latency to end users.

- ***Examples:*** Relocate a workload in West US to East US, North Europe to West Europe, or Southeast Asia to East Asia.

> [!div class="nextstepaction"]
> [Relocate](../relocate/index.md)

## Next steps

Follow the guidance that best meets your goals. If you're still considering cloud adoption, it's help to get a sense of what the cloud adoption journey looks like. The next article outlines the typical cloud adoption journey, showing what workloads you should migrate and what order you should migrate them.

> [!div class="nextstepaction"]
> [Cloud adoption journey](cloud-adoption.md)
