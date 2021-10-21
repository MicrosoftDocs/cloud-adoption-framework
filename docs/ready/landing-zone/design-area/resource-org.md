---
title: Resource organization - design area
description: Overview for resource organization design area
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Resource organization

This critical design area establishes consistent patterns for organization of resources deployed to the cloud.

## Design Area review

**Involved roles or functions:** This design area will likely require support from one or more of the following functions or roles to make decisions and implement those decisions: [Cloud Platform](../../../organize/cloud-platform.md), and [Cloud Center of Excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The objective of this exercise is to establish consistent patterns for naming, tagging, subscription design, and management group design. These decisions will serve as a foundation for all compliance related design areas. In alignment with the Azure Landing Zone Conceptual Architecture, the initial scope of this exercise assumes a subscription design based on workload or application level subscription and landing zone assignment to support common separation of duty and subscription democratization requirements.

**Out of scope:** Alternative subscription design patterns are out of scope for the suggested path through this discussion. Guidance in this design area assumes that your business is committed to long term operations in the cloud, requiring the use of operational management, security, and governance tooling in the cloud to manage your Azure, hybrid, &/or multicloud solutions. This guidance also assumes that those management or platform deployments will be in separate subscriptions and management groups from resources which power your workload or application resources. These assumptions are the basis for the workload subscription design patterns. For alternative subscription design patterns, see [subscription design patterns](../../../decision-guides/subscriptions/). If you are early in your cloud journey and need to start with a smaller set of subscriptions, first complete this exercise to think forward, then consult the article series on [organic subscription scaling](../../azure-best-practices/initial-subscriptions.md).

## Design Area overview

As organizations start out on their cloud adoption journey, the scale of the starting point will vary.

Some require scale quickly in order to address business demands such as a data center migration, while others may start out with a smaller number of applications in the cloud and grow over time.

In either scenario, there should be an assumption that the environment will grow to accommodate further applications and services.

A key consideration, therefore, is how to organize resources to enable simplified management across the environment as the number of workloads increases.

In addition, as part of designing and implementing an organization's landing zone it is important to consider and decide on the foundational structure of management groups and subscriptions in order to avoid create constraints when scaling later.

The resource organization design area explores the considerations and recommendations associated with the techniques and technologies than can help maintain good structures to resource topologies within your cloud environments.

![The four scope levels for organizing your Azure resources](../../azure-setup-guide/media/organize-resources/scope-levels.png)

*Figure 1: The four scope levels for organizing your Azure resources.*

## Next steps

Explore the guidance further in the following two sections:

- [**Management groups**](./resource-org-management-groups.md)
- [**Subscriptions**](./resource-org-subscriptions.md)