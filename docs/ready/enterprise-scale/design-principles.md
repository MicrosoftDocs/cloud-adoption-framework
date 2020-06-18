---
title: Design principles
description: Design principles.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design principles

The enterprise-scale architecture prescribed in this guidance is based on the design principles described in this section. These principles serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with nonadherence.

## Subscription democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities, to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design and development/testing of new workloads and migration of workloads.

## Policy-driven governance

Microsoft Azure Policy should be used to provide guard rails and ensure continued compliance of the customer platform plus the applications deployed onto it while also providing application owners sufficient freedom and a secure, unhindered path to the cloud.

## Single control and management plane

<!-- cSpell:ignore AppOps -->

Enterprise-scale architecture shouldn't consider any abstraction layers (such as customer-developed portals or tooling) and should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels subject to role-based access and policy-driven controls and used to establish a standardized set of policies and controls for governing the entire customer estate.

## Application-centric and archetype-neutral

Enterprise-scale architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations (such as moving virtual machines), and it shouldn't differentiate between old and new applications or infrastructure as a service or platform as a service applications. Ultimately, it should provide a safe and secure foundation for all application types to be deployed onto the customer Azure platform.

## Aligning Azure-native design and roadmaps

The enterprise-scale architecture approach advocates using Azure-native platform services and capabilities whenever possible, which should align with Azure platform roadmaps to ensure that new capabilities are available within customer environments. Azure platform roadmaps should help to inform the migration strategy and enterprise-scale trajectory.

## Recommendations

Be prepared to trade off functionality, as it's unlikely that everything will be required on day one. Use preview services and take dependencies on service roadmaps in order to remove technical blockers.
