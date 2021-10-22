---
title: "Scenarios: Transitioning existing Azure environments to the Azure landing zone conceptual architecture"
description:  Guidance for transitioning existing Azure environments into the Azure landing zone conceptual architecture
author: jtracey93
ms.author: jatracey
ms.date: 04/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready 
ms.custom: think-tank
---

<!-- docutune:casing resourceType resourceTypes resourceId resourceIds -->

# Scenarios: Transitioning existing Azure environments to the Azure landing zone conceptual architecture

This page will detail example scenarios, that may match your current Azure environment, and will detail steps and considerations in relation to how to migrate and transition your Azure environment into the Azure landing zone conceptual architecture.

## Scenario 1: Single subscription with no management groups

In this scenario the customer already has started to use Azure and already hosts a few applications/services within the platform, however, they have realized that their current implementation is limiting their scalability and growth as per their “cloud first” strategy.

As part of this expansion, they are also planning to migrate away from their on-premises data centres into Azure, whilst modernizing and transforming their applications/services using cloud native technologies where possible, like Azure SQL DB & Azure Kubernetes Service (AKS). However, they appreciate that this will take considerable time and effort so plan to “lift-and-shift” initially; this will require hybrid connectivity (VPN/ExpressRoute).

The customer has evaluated the Azure landing zones conceptual architecture and decided to move from their existing approach to an enterprise-scale architecture to support their “cloud first” strategy; whilst having a robust platform that can scale with them as they evacuate their on-premises datacentres.

### Current State

In this scenario the customers current state of their Azure environment is as follows:

- Single Azure Subscription
- No custom Management Groups.
- Non-uniform resource distribution –platform and workload resources are deployed in the same Azure Subscription.
- Minimal usage of Azure Policy, and Policy assignments (audit & deny effects) are done per Resource Group with exceptions.
- Resource Groups are treated as unit of management and scale.
- RBAC role assignments per Resource Group.
- Azure Blueprints are being used.
- Single VNET
  - No hybrid connectivity (VPN/ExpressRoute)
  - A new subnet is created per application.
- Multiple self-contained applications in each of the `app-xx-rg` Resource Groups
  - Each of these are controlled and operated by different application/service teams.

The following diagram depicts the current state of this sample scenario:

![Single Subscription Environment](./media/alz-align-scenario-single-sub.png)

### Transition to the Azure landing zone conceptual architecture

To transition from this scenario’s current state to an Azure landing zone conceptual architecture the following approach is suggested:

1. Review the [Azure landing zone conceptual architecture](./index.md) & [Azure landing zone Design Areas](./design-areas.md)
2. Deploy the [Azure landing zone accelerator](./index.md#azure-landing-zone-accelerator) into the same Azure AD Tenant in parallel with the current environment.
   1. This will create a new management group structure which is aligned with Azure landing zones design principles and recommendations, whilst it ensures that existing environment is not impacted by these changes.
3. (Optional) Work with application/service teams to migrate the workloads deployed in the original subscription into new Azure Subscriptions, as per guidance in [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#moving-resources-in-azure), placed into the newly deployed Azure landing zone conceptual architecture Management Group hierarchy at the correct scope, corporate or online management groups. - Please review the policy section in [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#policy) details on impact to resources when migrating
   1. Eventually the existing Azure Subscription can be cancelled and placed in the Decommissioned Management Group

>[!NOTE]
 > The existing applications/services do not necessarily have to be migrated into new landing zones (a.k.a. Azure subscriptions)

4. Create new Azure subscriptions to provide Landing Zones to support migration projects from on-premises, and place under the suited Management Group (corporate or online).

The below diagram depicts the state during the migration approach of this sample scenario:

![Single Subscription Environment - Transition State](./media/alz-align-single-sub-transition-state.png)

### Summary

In this scenario the customer has enabled themselves to achieve their expansion and scaling plans within Azure by deploying the [Azure landing zone conceptual architecture](./index.md#azure-landing-zone-conceptual-architecture) in parallel to their existing environment.
