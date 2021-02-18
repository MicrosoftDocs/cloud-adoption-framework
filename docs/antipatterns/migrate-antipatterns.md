---
title: Cloud migration antipattern
description: To avoid migration antipatterns make sure security and compliance guardrails in place, understand potential application and server dependencies, and choose an architecture based on a thorough assessment. 
author: lpassig
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Cloud migration antipattern

Customers frequently experience a number of common cloud adoption antipatterns while in the migration phase of cloud adoption. To avoid migration antipatterns, make sure security and compliance guardrails are in place, understand potential application and server dependencies, and choose an architecture based on a thorough assessment.

## Antipattern: Migration, modernization, or innovation without any defined guardrails

When customers deploy their first workloads to the cloud, they consider it as a platform to test innovative solutions. They enjoy the flexibility that's available within the cloud. But, whenever these workloads become productive, need to hold company data, or need access to company systems, they are slowed as they need to adhere to the compliance, regulatory, and security standards.

### Example: Missing guardrail antipattern

A company wants to modernize its online shop to improve the user experience. The modernization should be done by moving the online shop website and the underlying inventory database to Azure. Because dependencies exist between the inventory database and the SAP system, the company needs to allow communication between those systems. So, it needs to build up a hybrid cloud.

The online shop team is innovative, so it begins modernizing the application, but it doesn't consider security requirements because of the hybrid connection. When it tests the application, it finds that the IT security team doesn't allow communication within Azure and on-premises, because security and compliance requirements aren't met.

### Preferred outcome: Security guardrails in place, following the security and compliance requirements

Before you shift workloads to the cloud, put security and compliance guardrails in place. These guardrails make sure that these workloads follow security and compliance requirements. The guardrails are delivered within an [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/), which is normally delivered by the cloud governance and cloud security team and is matched with the internal IT at least for hybrid workloads. [Enterprise-scale architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) helps define those guardrails to support workload teams, so that they can work in a fast, consistent, compliant, and secure manner.

## Antipattern: Migration, modernization, or innovation without a prior assessment or an architectural design session

When a company considers a migration or modernization project, it needs to understand potential application and server dependencies so that it can plan more accurately. In application innovation scenarios, a company experiences more success by using architectural design sessions and reference architectures instead of aimless engineering efforts.

### Example: Downtime antipattern

A company team member plans to migrate applications to the cloud to reduce its carbon footprint. The migration plan, which identifies the first asset to migrate, is purely based on CMDB entries and a single application owner interview. After the team member migrates a database server of one of the applications, several other application owners call IT to complain that their application isn't working properly. The dependencies depicted in the CMDB aren't accurate anymore, causing unexpected downtime in other applications.

### Preferred outcome: Prior infrastructure assessment

For a large-scale migration or modernization project, perform an infrastructure assessment. This assessment helps you identify the eventual dependencies and compatibility issues before the migration starts. The Microsoft Cloud Adoption Framework for Azure provides a detailed [Cloud Migration Guide](/azure/cloud-adoption-framework/migrate/azure-migration-guide/) that helps your company migrate by using [migration best practices](/azure/cloud-adoption-framework/migrate/azure-best-practices/).

In modernization projects, use additional application assessments to identify coding antipatterns, compatibility issues, and technical debt. For more information about modernization aspects, see the [overview of application migration examples for Azure](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-overview) article.

For innovation projects, the [Azure innovative solutions guide overview](/azure/cloud-adoption-framework/innovate/innovation-guide/) can help your company identify the correct way to plan and develop an innovative cloud solution.

Use [architectural design sessions (ADS)](/azure/architecture/serverless-quest/ads) to help design, build, and deploy a quality, robust architecture that scales in the enterprise. In an ADS, you use a whiteboard to discover, envision, and plan the solution.

## Antipattern: Forced architecture

A company might pursue a "microservice-first" strategy when developing in the cloud, assuming that a microservice architecture always outperforms a traditional (monolithic) architecture. If the company doesn't perform a proper application assessment and due diligence for its application, this strategy can fail. Other architectural approaches might be more suitable for the application. Choosing or dictating a microservice architecture or an architecture for all situations often results in failed projects.

### Example: Forced architecture antipattern

A company's chief information officer (CIO) decides to always use a microservice architecture when building up a new application in the cloud. The company developers have never developed an application based on the microservice architecture, though. The application that needs to be developed is a simple web app. When they start to develop an application, the developers realize after a couple of months that they probably would've finished development already if they had started with a monolithic architecture. The company hasn't achieved a faster time to market, among other unfulfilled benefits.

### Preferred outcome: Architectural decisions based on an assessment

Instead of fixating on a specific architecture style, make an architectural decision based on an assessment and due diligence of the use case or an architecture. Don't limit what architectures can be used, because freedom of choice is one of the major benefits of the cloud. Picking an architecture just because it's in fashion is an antipattern to avoid. For more information, see the [Azure application architecture guide](/azure/architecture/guide) and [cloud design patterns](/azure/architecture/patterns).

## Antipattern: Use of a single subscription

A company might decide to use only one subscription to host all of its workload. The company usually makes this choice when it executes a rapid migration that requires speed over everything else. This decision leads to a poorly governed and designed landscape. The company often runs into subscription limits quickly, so the architecture needs to be redesigned later.

### Example: Single-subscription antipattern

A conglomerate decides to spin off its hotel division into a separate company. The hotel division must move or migrate its IT assets to a new place. The new hotel company chooses a cloud-first approach and migrates all IT assets to the cloud. Because of time constraints, the new company migrates everything into one subscription and uses a huge virtual network, where there are few possibilities for separating the duties and the security model properly. Three months after the spinoff is complete, the hotel company determines that its assets are less secure and governed than before, and that it's running into subscription limits.

### Preferred outcome: Proper segmentation

Separate the duties and plan for a different environment before you migrate to Azure. You can reach subscription limits quickly when different stages are mixed into one subscription. It's harder to implement any governance and compliance without [proper segmentation](../ready/enterprise-scale/management-group-and-subscription-organization.md) strategy in place.

## Next steps

- [Azure migration guide overview](/azure/cloud-adoption-framework/migrate/azure-migration-guide/)
- [Azure cloud migration best practices checklist](/azure/cloud-adoption-framework/migrate/azure-best-practices/)
- [Management group and subscription organization](../ready/enterprise-scale/management-group-and-subscription-organization.md)