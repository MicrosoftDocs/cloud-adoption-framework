---
title: CAF enterprise-scale design principles
description: Learn about enterprise-scale design principles in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# CAF enterprise-scale design principles

The enterprise-scale architecture prescribed in this guidance is based on the design principles described here. These principles serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with nonadherence.

## Subscription democratization

Subscriptions should be used as a unit of management, and scale aligned with business needs and priorities, to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design, development, and testing of new workloads and migration of workloads.

## Policy-driven governance

Microsoft Azure Policy should be used to provide guard rails and ensure continued compliance with your organizations platform, plus the applications deployed onto it. It should also provide application owners sufficient freedom, and a secure, unhindered path to the cloud.

## Single control and management plane

<!-- cSpell:ignore AppOps -->

Enterprise-scale architecture shouldn't consider any abstraction layers (such as customer-developed portals or tooling). It should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels subject to role-based access and policy-driven controls. It can be used to establish a standardized set of policies and controls for governing the entire enterprise estate.

## Application-centric and archetype-neutral

Enterprise-scale architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations (such as moving virtual machines). It shouldn't differentiate between old and new applications, infrastructure as a service, or platform as a service applications. Ultimately, it should provide a safe and secure foundation for all application types to be deployed onto your Azure platform.

## Aligning Azure-native design and roadmaps

The enterprise-scale architecture approach advocates using Azure-native platform services and capabilities whenever possible. This should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help to inform the migration strategy and enterprise-scale trajectory.

## Recommendations

Be prepared to trade off functionality, as it's unlikely that everything will be required on day one. Use preview services and take dependencies on service roadmaps in order to remove technical blockers.
