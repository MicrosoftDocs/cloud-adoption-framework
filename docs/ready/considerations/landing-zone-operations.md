---
title: Improve Azure landing zone operations
description: Improve Azure landing zone operations using the Manage methodology from the Microsoft Cloud Adoption Framework.
author: martinekuan
ms.author: martinek
ms.date: 07/05/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Improve landing zone operations

When you've achieved the [Ready](../index.md) state and implemented [Azure landing zones](../landing-zone/index.md), you still have an ongoing responsibility to manage your cloud environment in the most efficient way possible. This article provides guidance on improving landing zone operations as you scale, helping you meet growing operational excellence, reliability, and performance requirements.

## The Manage methodology

The [Manage methodology](../../manage/index.md) of the Cloud Adoption Framework provides guidance for establishing tooling for a management baseline and building operations management capacity across landing zones. It also outlines ways to extend your management baseline and build extra resiliency. We use the basic structure of the [Azure Management Guide](../../manage/azure-management-guide/index.md) to improve operations across landing zones.

:::image type="content" source="../../_images/manage/caf-manage.png" alt-text="Screenshot showing the Manage methodology of the Cloud Adoption Framework." border="false":::
*Figure 1: The Manage methodology of the Cloud Adoption Framework.*

## Prerequisite: Establish a management baseline

A management baseline establishes the foundation for operations management. It represents the minimum set of tools and processes that should be applied to every asset in a cloud environment. For high-level information, see [Cloud management disciplines](../../manage/considerations/discipline.md) and [Overview of Azure server management services](../../manage/azure-server-management/index.md). The disciplines and guidance can be applied to any landing zone to improve initial operations.

An effective management baseline encompasses three areas:

### 1. Inventory and visibility

This discipline comes first because collecting proper operational data is vital when making decisions about operations. Cloud management teams must understand what is managed and how well those assets are operated. See [Inventory and visibility in Azure](../../manage/azure-management-guide/inventory.md) and [Inventory and visibility in cloud management](../../manage/considerations/inventory.md).

### 2. Operational compliance

Improving operational compliance reduces the likelihood of an outage related to configuration drift or vulnerabilities related to systems being improperly patched. See [Operational compliance in Azure](../../manage/azure-management-guide/operational-compliance.md) and [Operational compliance in cloud management](../../manage/considerations/operational-compliance.md).

### 3. Protect and recover

Protect and recover is the final discipline in any cloud-management baseline, aiming to reduce the duration and impact of outages that can't be prevented. See [Protect and recover in Azure](../../manage/azure-management-guide/protect-recover.md) and [Protect and recover in cloud management](../../manage/considerations/protect.md).

## Create business alignment

Once you've established a management baseline, you need to understand the criticality and impact of each workload within a landing zone in order to drive ongoing management improvements.

When an organization moves to the cloud, management and operations naturally shift a bit. This shift creates an opportunity to develop tighter business alignment by defining criticality, business impact, and business commitments. See [Create business alignment in cloud management](../../manage/considerations/business-alignment.md).

### Define criticality

Most businesses have a few workloads that are too important to fail, while other workloads can go months at a time without being used. Understanding the criticality of each workload in the IT portfolio is the first step toward establishing mutual commitments to cloud management. See [Business criticality in cloud management](../../manage/considerations/criticality.md).

### Understand business impact

In order to manage investments wisely, it's important to understand the impact on the business when an outage or performance degradation occurs. See [Business impact in cloud management](../../manage/considerations/impact.md).

### Define business commitments

Defining business commitments is an exercise in balancing priorities. The objective is to align the proper level of operational management at an acceptable operating cost. See [Business commitment in cloud management](../../manage/considerations/commitment.md).

## Enhance the management baseline

Identify the workloads that require improving landing zone operations beyond the initial baseline. Some workloads might require enhancements to the baseline that aren't necessarily specific to a single platform or workload. Although these enhancements aren't cost effective for every workload, you should establish common processes, tools, and solutions for any workload that can justify the cost of the extra management support. See [Enhanced management baseline in Azure](../../manage/azure-management-guide/enhanced-baseline.md).

## Apply advanced operations and design principles

Review the design and operations of specific workloads, platforms, or full landing zones to meet deeper requirements. In some cases, aspects of workload and platform operations might require changes to design and architecture principles. The two primary areas of management specialization are **platform specialization** and **workload specialization**. See [Apply design principles and advanced operations](../../manage/design-principles.md).

### Platform specialization

Platform specialization means to invest in ongoing operations of a shared platform, distributing the investment across multiple workloads. See [Platform specialization for cloud management](../../manage/azure-management-guide/platform-specialization.md) and [Platform operations in cloud management](../../manage/considerations/platform.md).

### Workload specialization

Workload specialization means to invest in ongoing operations of a specific workload, generally reserved for mission-critical workloads. See [Workload specialization for cloud management](../../manage/azure-management-guide/workload-specialization.md) and [Workload operations in cloud management](../../manage/considerations/workload.md).

## Landing zone operations best practices

The following links provide best practices for improving landing zone operations.

- [Establish operational management practices in the cloud](../../manage/best-practices.md): This section of the Cloud Adoption Framework guides you through various transitions into operational management in the cloud.
- [Azure server management](../../manage/azure-server-management/index.md): An onboarding guide to incorporating the cloud-native tools and services needed to manage operations.
- [Hybrid monitoring](../../manage/monitor/index.md): Many customers have already made a substantial investment in System Center Operations Manager. For those customers, this guide to hybrid monitoring can help them compare and contrast the cloud-native reporting tools with Operations Manager tooling. This comparison makes it easier to decide which tools to use for operational management.
- [Centralize management operations](../../manage/centralize-operations.md): Use Azure Lighthouse to centralize operations management across multiple Azure tenants.
- [Establish an operational fitness review](../../manage/operational-fitness-review.md): Review an environment for operational fitness.
- Workload specific operations best practices:
  - [Resiliency checklist](/azure/architecture/checklist/resiliency-per-service?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Failure mode analysis](/azure/architecture/resiliency/failure-mode-analysis?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Recover from a region wide service disruption](/azure/architecture/resiliency/recovery-loss-azure-region?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
  - [Recover from data corruption or accidental deletion](/azure/architecture/framework/resiliency/data-management?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
- Build a Subscription Vending process to automate the creation of subscriptions for application teams via a request workflow as described in [Subscription vending](../landing-zone/design-area/subscription-vending.md)

## Next steps

Understand how to [improve landing zone governance](./landing-zone-governance.md) to support adoption at scale.

> [!div class="nextstepaction"]
> [Improve landing zone governance](./landing-zone-governance.md)
