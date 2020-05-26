---
title: Design principles
description: Design principles
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design principles

The enterprise-scale architecture prescribed in this playbook is based on the design principles described in this section. These principles serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with nonadherence.

## Subscription democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities, to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design and development/testing of new workloads and migration of workloads.

## Policy-driven governance

Azure Policy should be used to provide guard rails and ensure continued compliance of the customer platform and the applications deployed onto it while also providing application owners sufficient freedom and a secure, unhindered path to the cloud.

## Single control and management plane

Enterprise-scale architecture shouldn't consider any abstraction layers (such as customer-developed portals or tooling) and should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels that are subject to role-based access and policy-driven controls and should be used to establish a standardized set of policies and controls for governing the entire customer estate.

## Application-centric and archetype-neutral

Enterprise-scale architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations (moving virtual machines), and it shouldn't differentiate between old/new applications or infrastructure-as-a-service/platform-as-a-service applications. Ultimately, it should provide a safe and secure foundation for all application types to be deployed onto the customer Azure platform.

## Azure-native design and road map aligned

The enterprise-scale architecture approach advocates using Azure-native platform services and capabilities whenever possible, which should be aligned with Azure platform road maps to that ensure new capabilities are available within customer environments. Azure platform road maps should help to inform the migration strategy and enterprise-scale trajectory.

## Recommendations

Be prepared to trade off functionality, as it's unlikely that everything will be required on day one. Use preview services and take dependencies on service road maps in order to remove technical blockers.
