---
title: "Cloud migration Antipattern"
description: To avoid migration antipatterns make sure security and compliance guardrails in place, understand potential application and server dependencies, and choose an architecture based on a thorough assessment. 
author: lpassig
ms.author: brblanch
ms.date: 01/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Cloud migration Antipattern

Customers frequently experience a number of common cloud adoption antipatterns while in the migration phase of cloud adoption. To avoid migration antipatterns make sure security and compliance guardrails in place, understand potential application and server dependencies, and choose an architecture based on a thorough assessment.

## Antipattern: Migrate, modernize or innovate without any guardrails defined

When customers deploy their first workloads to the cloud, they consider it as a platform to test innovative solutions and therefore enjoy the flexibility they are given within the cloud. But as soon as these workloads become productive, need to hold company data, or need access to company systems they are slowed down as they need to adhere to the compliance, regulatory and security standards.

### Example of this antipattern

A. Datum wants to modernize their online shop to improve the experience for their users. This should be done by moving the online shop website and the underlying inventory database to Azure. As there are dependencies between the underlying inventory database and the SAP system, they need to allow communication between those systems and therefore need to build up a hybrid cloud.

As the online shop team is an innovative team, they start modernizing the application but do not consider security requirements due to the hybrid connection. As soon as they want to test the application, they find that the IT security team will not allow communication within Azure and on prem because security and compliance requirements are not met.

### Preferred outcome: have security guardrails in place and follow security and compliance requirements

Before shifting workloads to the cloud there need to be security and compliance guardrails in place, that make sure that these workloads follow security and compliance requirements. These guardrails are delivered within a [Landing Zone](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/), which is normally delivered by the cloud governance and cloud security team and is matched with the internal IT at least for hybrid workloads. [Enterprise-scale architecture](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) helps to define those guardrails to enable workload teams work fast, consistent, compliant, and secure.

## Antipattern: Migrate, modernize or innovate without a prior assessment or an architectural design session

When considering a migration or modernization project, companies need to understand potential application and server dependencies to be able to plan more accurate. In application innovation scenarios, architectural design sessions and the use of reference architectures result in more success compared to aimless engineering efforts.

### Example of this antipattern causing down time

A. Datum is planning on migrating applications to the cloud to reduce their carbon footprint. The migration plan, that identified the first asset that should be migrated, was purely based on CMDB entries and a single application owner interview. After migrating a database server of one of the applications, several other application owners called the IT to state that their application is not working properly. The dependencies depicted in the CMDB were not accurate any longer and therefore unexpected downtime in other applications occurred.

### Preferred outcome: prior infrastructure assessment

For a large-scale migration or modernization project it is indispensable to perform an infrastructure assessment. This helps companies identifying the eventual dependencies and compatibility issues before the migration starts. The Cloud Adoption Framework provides a detailed [Cloud Migration Guide](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/azure-migration-guide/) that help migrating by using [migration best practices](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/azure-best-practices/).

In modernization projects additional application assessments are highly recommended to identify coding antipatterns, compatibility issues and technical debt. To find out more about modernization aspects, read the [Overview of application migration examples for Azure](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-overview) article.

When looking at innovation projects the [Cloud Innovation Guide](https://docs.microsoft.com/azure/cloud-adoption-framework/innovate/innovation-guide/) can help companies to identify the right way to plan and develop an innovative cloud solution.

[Architectural Design Sessions (ADS)](https://docs.microsoft.com/azure/architecture/serverless-quest/ads) help design, build and deploy quality and robust architectures that scale in the enterprise. In an ADS you are engaged to discover, envision, and plan the solution in mind on a whiteboard.

## Antipattern: Forced architecture

Some companies have called out a "microservice-first" strategy when developing in the cloud. This strategy is mostly based on the assumption that a microservice architecture will always perform better compared to a traditional (monolithic) architecture. However, without performing a proper application assessment and due diligence, when it comes to the application, this strategy can fail. Depending on the use case, other architectural approaches might be more suitable for the application. Choosing or even dictating a microservice architecture or an architecture in general at all costs often results in failed projects.

### Example of forced architecture

The CIO of Contoso has defined to always use a microservice architecture when building up a new application in the cloud. However, the developers within the organization have never developed an application based on the microservice architecture. Additionally, the application that needs to be developed is a rather simple webapp. When starting to develop an application, the developers realize after a couple of months that they would probably have finished development already, if they would have started (off) with a monolithic architecture. The faster time to market among other benefits have not been fulfilled.

### Preferred outcome: make architectural decisions based on an assessment

Rather than fixate on a specific architecture style, companies should make an architectural decision based on an assessment and due diligence of the use case or an architecture. Limiting the choices of architectures that can be used, is counterproductive since freedom of choice in the cloud, is one of the major benefits of the cloud. Choosing an architecture just because it's in fashion is an easy to avoid antipattern. Find more on [architecture styles](https://docs.microsoft.com/azure/architecture/guide) and [Cloud Design Patterns](/azure/architecture/patterns).

## Antipattern: Use of a single subscription

Some companies decide that they'll use only **one** subscription to host all of their workload. This usually occurs when executing a rapid migration, that requires speed over everything else. However, this leads to a poorly governed and designed landscape, that most of the time needs a redesign afterwards since companies quickly run into subscription limits.  

### Example of a single subscription antipattern

Contoso Hotels was part of Contoso Ltd., but Contoso decided to carve-out the hotel branch of their business. This requires all IT assets of Contoso Hotels to be moved or migrated to a new place. Contoso Hotels decided to go for a cloud-first approach and migrate all IT assets to the cloud. However, due to time constraints they decided to migrate everything into one subscription. Leading up to a huge virtual network, where there are only very limited possibilities to establish a proper separation of duties and security model. Three months after the carve-out has been completed Contoso Hotels determines that their assets are less secure and governed than before and that they are running into subscription limits.

### Preferred outcome: proper segmentation

Companies should plan for separation of duties and different environment before migrating into Azure. Subscription limits can be reached rather quickly when different stages are mixed into one subscription. Additionally, the implementation of governance and compliance is harder to achieve, when there is [no proper segmentation](../ready/enterprise-scale/management-group-and-subscription-organization.md) strategy in place.

## Next steps

- [Cloud Migration Guide](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/azure-migration-guide/)
- [Migration best practices](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/azure-best-practices/)
- [Management group and subscription organization](../ready/enterprise-scale/management-group-and-subscription-organization.md)
