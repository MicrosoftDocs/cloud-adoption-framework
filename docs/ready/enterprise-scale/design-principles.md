---
title: Cloud Adoption Framework enterprise-scale design principles
description: Learn about enterprise-scale design principles in the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Cloud Adoption Framework enterprise-scale design principles

The enterprise-scale architecture prescribed in this guidance is based on these design principles described. These principles serve as a compass for design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with nonadherence.

## Subscription democratization

Use subscriptions as a unit of management and scale that aligns with business needs and priorities. Subscriptions can support business areas and portfolio owners to accelerate application migrations and new application development. Business units that have subscriptions can support the design, development, and testing of new workloads and migration of workloads.

## Policy-driven governance

Use Azure Policy to provide guardrails and ensure continued compliance with your organization's platform and the applications deployed onto it. Azure Policy also provides application owners with independence and a secure, unhindered path to the cloud.

## Single control and management plane

Enterprise-scale architecture doesn't include any abstraction layers, such as customer-developed portals or tooling. It provides a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels that are subject to role-based access and policy-driven controls. You can use Azure to establish a standardized set of policies and controls for governing the entire enterprise estate.

## Application-centric and archetype-neutral

Enterprise-scale architecture focuses on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. It doesn't differentiate between old and new applications, infrastructure as a service, or platform as a service applications. Ultimately, it provides a safe and secure foundation for all application types that you deploy onto your Azure platform.

## Align Azure-native design and roadmaps

The enterprise-scale architecture approach advocates using Azure-native platform services and capabilities whenever possible. This approach aligns with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps help to inform the migration strategy and enterprise-scale trajectory.

## Recommendations

Be prepared to trade off functionality; it's unlikely that everything will be required on day one. Use preview services and take dependencies on service roadmaps to remove technical blockers.
