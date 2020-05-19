---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design Principles

The **North Star** architecture prescribed in this playbook is based on the design principles described in this section. These principles serve as a compass for subsequent design decisions across critical technical domains. Readers are strongly advised to familiarize themselves with these principles to better understand their impact and the trade-offs associated with non-adherence.

## Subscription Democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities, to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design and development/testing of new workloads and migration of workloads.

## Policy Driven Governance

Azure Policy should be used to provide the **guard-rails** and ensure the continued compliance of the customer platform and applications deployed onto it, whilst also providing application owners sufficient freedom and a secure unhindered path to cloud.

## Single Control and Management Plane

The "North Star" architecture should not consider any abstraction layers such as customer developed portals or tooling and should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels which should be used to establish a consistent set of policies and controls for governing the entire customer estate, subject to RBAC and policy driven controls.

## Application Centric and Archetype-Neutral

The "North Star" architecture should focus on application centric migrations and development rather than a pure infrastructure "lift and shift" migration (i.e. movement of virtual machines) and should not differentiate between old/new applications or IaaS/PaaS applications. Ultimately, it should provide the foundation for all application types to be deployed onto the customer Azure platform securely and safely.

## Azure Native Design and Roadmap Aligned

The **Enterprise Scale architecture** approach advocates the use of native platform services and capabilities whenever possible, which should be aligned with Azure platform roadmaps to ensure new capabilities are made available within customer environments. Azure platform roadmaps should help inform the migration strategy and **North Star** trajectory.

## Recommendations

-   Be prepared to trade off functionality as not everything will likely be required on day one.
-   Leverage preview services and take dependencies on service roadmaps in order to remove technical blockers.
