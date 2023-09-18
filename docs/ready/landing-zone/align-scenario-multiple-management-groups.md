---
title: Single/Few Management Groups to the Azure landing zone conceptual architecture
description: Learn how to transition existing Azure environments comprised of single or few Management Groups into the Azure landing zone conceptual architecture
author: sebassem
ms.author: sebassem
ms.reviewer: tozimmergren
ms.date: 09/18/2023
ms.topic: conceptual
ms.service: caf
---

<!-- docutune:casing resourceType resourceTypes resourceId resourceIds -->

# Scenario: Single/Few Management Groups to the Azure landing zone conceptual architecture

This page describes an example scenario that might match your current environment. The guide below details steps and considerations about migrating and transitioning your existing environment into the conceptual architecture of Azure landing zones. The scenario covers single or multiple management groups.

In this scenario, the customer has already started to use Azure; they have a management group hierarchy with one or more management groups, each with multiple subscriptions that already host a few applications or services within the platform. But, they've realized their current implementation limits their scalability and growth per their "cloud first" strategy.

As part of this expansion, they plan to migrate away from their on-premises datacenters into Azure. As part of the migration, they lead with modernizing and transforming their applications or services to use cloud-native technologies where possible. For example, they might use Azure SQL Database and Azure Kubernetes Service (AKS). But, they appreciate that it takes considerable time and effort, so they plan to "lift-and-shift" to start. Initially, this plan requires hybrid connectivity (VPN/ExpressRoute).

The customer evaluated the Azure landing zones conceptual architecture and decided to move their existing environment to this one. Doing so supports their "cloud first" strategy while having a robust platform that scales with them as they retire their on-premises datacenters.

## Current state

In this scenario, the current state of the customer's Azure environment is as follows:

- One or more management groups.
- Management group hierarchy based on organizational structure or geography
- An Azure subscription per application environment (dev/test/prod)
- Non-uniform resource distribution. Platform and workload resources for a single environment are deployed in the same Azure subscriptions.
- Policy assignments with audit and deny effects are assigned at the management group and subscription level.
- RBAC role assignments per subscription and resource groups.
- A hub virtual network for hybrid connectivity (VPN/ExpressRoute).
- A virtual network per application environment.
- Applications are deployed into the respective subscription as per their environment classification (dev/test/prod)
- Centrally controlled and operated by a central IT team.

The following diagram shows the current state of this sample scenario:

![Single subscription environment](./media/alz-align-scenario-multiple-mgs.png)

## Transition to the Azure landing zone conceptual architecture

To transition from this scenario's current state to an Azure landing zone conceptual architecture, we suggest this approach:

1. Review the [Azure landing zone conceptual architecture](./index.md), [Azure landing zone design principles](./design-principles.md) and [Azure landing zone design areas](./design-areas.md).

2. Deploy the [Azure landing zone accelerator](/azure/architecture/landing-zones/landing-zone-deploy#platform) into the same Azure AD tenant in parallel with the current environment.

   Doing so creates a new management group structure. This structure is aligned with Azure landing zones design principles and recommendations. It also ensures that the existing environment isn't affected by these changes.

3. Review the ["dev/test/production" workload landing zones guidance](./../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture) to understand how to handle "dev/test/production" workload landing zones.

4. (optional) Work with application or service teams to migrate the workloads deployed in the original subscriptions into new Azure subscriptions, per the guidance in [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#moving-resources-in-azure). They can be placed into the newly deployed Azure landing zone conceptual architecture management group hierarchy under the correct management group – corporate or online.

   Review the policy section in [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#policy) for details about the effect on resources when migrating. Eventually, the existing Azure subscription can be canceled and placed in the decommissioned management group.

   > [!NOTE]
   > The existing applications or services do not necessarily have to be migrated into new landing zones (Azure subscriptions)

5. Create new Azure subscriptions to provide landing zones supporting migration projects from on-premises. Place them under the proper management group (corporate or online).

The following diagram shows the state during the migration approach of this sample scenario:

:::image type="content" source="./media/alz-align-multiple-mgs-transition.png" alt-text="Single subscription environment - transition state" lightbox="./media/alz-align-multiple-mgs-transition.png":::

## Summary

In this scenario, the customer has helped themselves achieve their expansion and scaling plans within Azure by deploying the [Azure landing zone conceptual architecture](./index.md#azure-landing-zone-architecture) parallel to their existing environment.
