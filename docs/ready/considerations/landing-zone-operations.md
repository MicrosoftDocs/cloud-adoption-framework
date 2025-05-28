---
title: Improve Azure landing zone operations
description: Improve Azure landing zone operations using the Manage methodology from the Microsoft Cloud Adoption Framework.
author: Zimmergren
ms.author: pnp
ms.date: 07/05/2022
ms.topic: conceptual
ms.custom: internal
---

# Improve landing zone operations

When you've achieved the [Ready](../index.md) state and implemented [Azure landing zones](../landing-zone/index.md), you still have an ongoing responsibility to manage your cloud environment in the most efficient way possible. This article provides guidance on improving landing zone operations as you scale, helping you meet growing operational excellence, reliability, and performance requirements.

## The Manage methodology

The [Manage methodology](../../manage/index.md) of the Cloud Adoption Framework provides guidance for establishing tooling for a management baseline and building operations management capacity across landing zones. It also outlines ways to extend your management baseline and build extra resiliency. We use the basic structure of the Azure Management Guide to improve operations across landing zones.

## Prerequisite: Establish a management baseline

A management baseline establishes the foundation for operations management. It represents the minimum set of tools and processes that should be applied to every asset in a cloud environment. The disciplines and guidance can be applied to any landing zone to improve initial operations.

An effective management baseline encompasses three areas:

### 1. Inventory and visibility

This discipline comes first because collecting proper operational data is vital when making decisions about operations. Cloud management teams must understand what is managed and how well those assets are operated.

### 2. Operational compliance

Improving operational compliance reduces the likelihood of an outage related to configuration drift or vulnerabilities related to systems being improperly patched.

### 3. Protect and recover

Protect and recover is the final discipline in any cloud-management baseline, aiming to reduce the duration and impact of outages that can't be prevented. 

## Create business alignment

Once you've established a management baseline, you need to understand the criticality and impact of each workload within a landing zone in order to drive ongoing management improvements.

When an organization moves to the cloud, management and operations naturally shift a bit. This shift creates an opportunity to develop tighter business alignment by defining criticality, business impact, and business commitments.

### Define criticality

Most businesses have a few workloads that are too important to fail, while other workloads can go months at a time without being used. Understanding the criticality of each workload in the IT portfolio is the first step toward establishing mutual commitments to cloud management.

### Understand business impact

In order to manage investments wisely, it's important to understand the impact on the business when an outage or performance degradation occurs.

### Define business commitments

Defining business commitments is an exercise in balancing priorities. The objective is to align the proper level of operational management at an acceptable operating cost.

## Enhance the management baseline

Identify the workloads that require improving landing zone operations beyond the initial baseline. Some workloads might require enhancements to the baseline that aren't necessarily specific to a single platform or workload. Although these enhancements aren't cost effective for every workload, you should establish common processes, tools, and solutions for any workload that can justify the cost of the extra management support.

## Apply advanced operations and design principles

Review the design and operations of specific workloads, platforms, or full landing zones to meet deeper requirements. In some cases, aspects of workload and platform operations might require changes to design and architecture principles. The two primary areas of management specialization are **platform specialization** and **workload specialization**.

### Platform specialization

Platform specialization means to invest in ongoing operations of a shared platform, distributing the investment across multiple workloads.

### Workload specialization

Workload specialization means to invest in ongoing operations of a specific workload, generally reserved for mission-critical workloads.

## Landing zone operations best practices

For more information, see [how to manage your Azure cloud estate](../../manage/index.md)

## Next steps

Understand how to [improve landing zone governance](./landing-zone-governance.md) to support adoption at scale.

> [!div class="nextstepaction"]
> [Improve landing zone governance](./landing-zone-governance.md)
