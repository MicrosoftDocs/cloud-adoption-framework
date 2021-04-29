---
title: Cloud migration antipatterns
description: Avoid antipatterns, establish security and compliance guardrails, understand dependencies, and run thorough assessments before choosing an architecture.
author: lpassig
ms.author: brblanch
ms.date: 02/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Cloud migration antipatterns

Customers often experience antipatterns during the migration phase of cloud adoption. The following measures help to avoid migration antipatterns:

- Making sure security and compliance guardrails are in place.
- Understanding potential application and server dependencies.
- Choosing an architecture based on a thorough assessment.

## Antipattern: Migrate, modernize, or innovate without guardrails

When customers deploy their first workloads to the cloud, they consider it as a platform to test innovative solutions. They enjoy the flexibility that's available within the cloud. But, whenever these workloads become productive, need to hold company data, or need access to company systems, progress slows down as they need to adhere to the compliance, regulatory, and security standards.

### Example: Omit security guardrails

A company wants to modernize its online shop to improve its user experience. The modernization should be done by moving the online shop website and the underlying inventory database to Azure. Because dependencies exist between the inventory database and the company's SAP system, those systems need to communicate. So, the company needs to build up a hybrid cloud.

The online shop team is innovative, so it begins modernizing the application, but it doesn't consider security requirements because of the hybrid connection. When it tests the application, it finds that the IT security team doesn't allow communication within Azure and on-premises systems, because security and compliance requirements aren't met.

### Preferred outcome: Establish security and compliance guardrails

Before you shift workloads to the cloud, put security and compliance guardrails in place. These guardrails make sure that workloads follow security and compliance requirements. Have the cloud governance and cloud security teams deliver the guardrails within an [Azure landing zone](../ready/landing-zone/index.md). Check the guardrails with IT, especially for hybrid workloads. See [Cloud Adoption Framework enterprise-scale landing zone architecture](../ready/enterprise-scale/architecture.md) for help with defining guardrails that support workload teams, so that they work in a fast, consistent, compliant, and secure manner.

## Antipattern: Migrate, modernize, or innovate without an assessment

When a company considers a migration or modernization project, it needs to understand potential application and server dependencies so that it can plan more accurately. In application innovation scenarios, a company experiences more success by using architectural design sessions and reference architectures instead of aimless engineering efforts.

### Example: Cause downtime by migrating without planning thoroughly

A team member plans to migrate applications to the cloud to reduce the company's carbon footprint. The migration plan, which identifies the first asset to migrate, is based on configuration management database (CMDB) entries and a single application owner interview. After the team member migrates one of the application's database servers, several other application owners call IT to complain that their applications aren't working properly. The dependencies depicted in the CMDB aren't accurate anymore, causing unexpected downtime in other applications.

### Preferred outcome: Assess infrastructure before migrating or modernizing

For a large-scale migration or modernization project, perform an infrastructure assessment before migration starts. This assessment helps you identify dependencies and compatibility issues. See [Azure migration guide](../migrate/azure-migration-guide/index.md) for detailed information that the [Microsoft Cloud Adoption Framework for Azure](../overview.md) provides on [migration best practices](../migrate/azure-best-practices/index.md).

In modernization projects, use additional application assessments to identify coding antipatterns, compatibility issues, and technical debt. For more information about modernization aspects, see [Overview of application migration examples for Azure](../migrate/azure-best-practices/contoso-migration-overview.md).

For innovation projects, see [Azure innovative solutions guide overview](../innovate/innovation-guide/index.md) for help with identifying the correct way to plan and develop an innovative cloud solution.

<!-- docutune:casing ADS -->

For mission-critical workloads or workloads which require architectural change, use the [Azure Well-Architected Framework](/azure/architecture/framework/) or an [architectural design session (ADS)](/azure/architecture/serverless-quest/ads) to help design, build, and deploy a high-quality, robust architecture that scales within an enterprise. Use ADS whiteboards to discover, envision, and plan the solution.

## Antipattern: Dictate an architecture

A company might pursue a microservice-first strategy when developing in the cloud, assuming that a microservice architecture always outperforms a traditional, monolithic architecture. If the company doesn't perform a proper application assessment and due diligence for its application, this strategy can fail. Other architectural approaches might be more suitable for the application. Choosing or dictating a microservice architecture or an architecture for all situations often results in failed projects.

### Example: Use a microservice architecture for all applications

A company's chief information officer (CIO) establishes a policy of using a microservice architecture when building up new applications in the cloud. The company developers have never worked with the microservice architecture. They need to develop a simple web app. After working on the application for a few months, the developers realize that they probably would have already finished development if they had started with a monolithic architecture. The company hasn't achieved a faster time to market, among other benefits.

### Preferred outcome: Base architectural decisions on assessments

Instead of fixating on a specific architecture style, make an architectural decision based on an assessment and due diligence of the use case or an architecture. Don't limit what architectures can be used, because freedom of choice is one of the major benefits of the cloud. Picking an architecture just because it's in fashion is an antipattern to avoid. For more information, see the [Azure application architecture guide](/azure/architecture/guide/) and [cloud design patterns](/azure/architecture/patterns/).

## Antipattern: Use a single subscription

Companies often decide to use only one subscription to host all their workloads. They usually make this choice when implementing rapid migrations that require speed over everything else. This decision leads to poorly governed and designed landscapes. These companies can quickly run into subscription limits, which means they need to redesign the architecture.

### Example: Migrate under one subscription

A conglomerate decides to spin off its hotel division into a separate company. The hotel division needs to move or migrate its IT assets to a new place. The new hotel company chooses a cloud-first approach and migrates all IT assets to the cloud. Because of time constraints, the new company migrates everything into one subscription and uses a huge virtual network, where there are few possibilities for separating duties and the security model properly. Three months after the spin-off is complete, the hotel company determines that its assets are less secure and governed than before, and that it's running into subscription limits.

### Preferred outcome: Use a segmentation strategy

Separate various duties and plan for a different environment before you migrate to Azure. You can reach subscription limits quickly when you combine different stages into one subscription. Establish a [segmentation strategy](/azure/architecture/framework/security/design-segmentation) to make it easier to [implement governance and compliance](../ready/enterprise-scale/management-group-and-subscription-organization.md).

## Next steps

- [Azure migration guide overview](../migrate/azure-migration-guide/index.md)
- [Azure cloud migration best practices checklist](../migrate/azure-best-practices/index.md)
- [Management group and subscription organization](../ready/enterprise-scale/management-group-and-subscription-organization.md)
