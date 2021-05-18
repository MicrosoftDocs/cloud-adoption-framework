---
title: Improve landing zone operations
description: Improve landing zone operations.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Improve landing zone operations

Landing zone operations provide the initial foundation for operations management. As operations scale, these improvements will refactor landing zones to meet growing operational excellence, reliability, and performance requirements.

## Landing zone operations best practices

The following links provide best practices for improving landing zone operations.

- [Azure server management](../../manage/azure-server-management/index.md): An onboarding guide to incorporating the cloud-native tools and services needed to manage operations.
- [Hybrid monitoring](../../manage/monitor/index.md): Many customers have already made a substantial investment in System Center Operations Manager. For those customers, this guide to hybrid monitoring can help them compare and contrast the cloud-native reporting tools with Operations Manager tooling. This comparison makes it easier to decide which tools to use for operational management.
- [Centralize management operations](../../manage/centralize-operations.md): Use Azure Lighthouse to centralize operations management across multiple Azure tenants.
- [Establish an operational fitness review](../../manage/operational-fitness-review.md): Review an environment for operational fitness.
- Workload specific operations best practices:
  - [Resiliency checklist](/azure/architecture/checklist/resiliency-per-service?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Failure mode analysis](/azure/architecture/resiliency/failure-mode-analysis?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Recover from a region wide service disruption](/azure/architecture/resiliency/recovery-loss-azure-region?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Recover from data corruption or accidental deletion](/azure/architecture/framework/resiliency/data-management?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)

## Four steps to improve operations beyond a single landing zone

The [Manage methodology](../../manage/index.md) provides overall guidance for building out operations management capacity, see the [Manage methodology](../../manage/index.md). We will use the basic structure of that methodology and the following steps from that methodology to improve landing zone operations and operations across all landing zones.

![Manage methodology](../../_images/manage/caf-manage.png)
*Figure 1: The Manage methodology of the Cloud Adoption Framework.*

1. [Establish a management baseline](../../manage/azure-server-management/index.md): A management baseline establishes the foundation for operations management. The guidance under this first step can be applied to any landing zone to improve initial operations.
2. [Define business commitments](../../manage/considerations/business-alignment.md): Understanding the criticality and impact of each workload within a landing zone will establish a "definition of done" for any ongoing management improvements for any landing zone. This process will also identify the reliability, performance, and operations requirements of each workload.
3. [Expand the management baseline](../../manage/best-practices.md): This set of best practices can be applied to improve landing zone operations beyond the initial baseline.
4. [Advanced operations and design principles](../../manage/design-principles.md): Review the design and operations of specific workloads, platforms, or full landing zones to meet deeper requirements.

## Test-driven development cycle

Before beginning any security improvements, it's important to understand the "definition of done" and all "acceptance criteria". For more information, see the articles on [test-driven development of landing zones](./test-driven-development.md) and [test-driven development in Azure](./azure-test-driven-development.md).

![Test-driven development process for cloud landing zones](../../_images/ready/test-driven-development-process.png)
*Figure 2: The test-driven development process for cloud landing zones.*

## Next steps

Understand how to [improve landing zone governance](./landing-zone-governance.md) to support adoption at scale.

> [!div class="nextstepaction"]
> [Improve landing zone governance](./landing-zone-governance.md)
