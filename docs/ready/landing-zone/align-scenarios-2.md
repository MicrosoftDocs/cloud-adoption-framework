---
title: Regional organization with Management Group separation of Dev/Test/Prod to the Azure landing zone conceptual architecture
description: Learn how to transition existing regional Azure environments comprised of multiple Management Groups into the Azure landing zone conceptual architecture
author: sebassem
ms.author: sebassem
ms.date: 07/27/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- docutune:casing resourceType resourceTypes resourceId resourceIds -->

# Scenario: Regional organization with Management Group separation of Dev/Test/Prod to the Azure landing zone conceptual architecture

This page describes an example scenario that might match your current Azure environment. We detail steps and considerations about how to migrate and transition your Azure environment into the Azure landing zone conceptual architecture. The scenario covers a regional organization with Management Group separation of Dev/Test/Prod.

In this scenario, the customer has a large footprint on Azure, they have a management group hierarchy organized by Dev/Test/Prod environments then by region. Multiple subscriptions are deployed and already host a large number of applications and services within the platform. But, they've realized their current implementation is limiting their scalability and growth. They have applications deployed across the globe and each region (America, EMEA, APAC) is managed by a central IT team, this introduces some consistency, configuration and compliance challenges for their application teams when it comes to policies, access control, platform resources configuration and security compliance, as some applications are deployed in multiple regions.

The customer also adopts a Dev/Test/Prod management group hierarchy to separate different application environments and to provide developers with a more relaxed environment for testing and innovation. This approach introduces some governance challenges for them as some critical workloads need to have the same governance model across Dev, Test and Prod.

The customer has evaluated the Azure landing zones conceptual architecture. And they've decided to move from their existing approach to the Azure landing zones conceptual architecture. Doing so supports their "cloud first" strategy while having a robust platform that scales with them as they retire their on-premises datacenters.

## Current state

In this scenario, the current state of the customer's Azure environment is as follows:

- Multiple management groups.
- Management Group hierarchy based on Dev/Test/Prod environments at the first level then based on geography on the second level.
- An Azure subscription per geography and application environment (dev/test/prod).
- Non-uniform resource distribution. Platform and workload resources for a single environment are deployed in the same Azure subscriptions.
- Applications are deployed into the respective subscriptions as per their region and environment classification (Dev/Test/Prod).
- Policy assignments (audit and deny effects) are assigned at management group and subscription level.
- All applications in the same region and in the same environment type, have the same set of Azure Policies applied.
- RBAC role assignments per subscription and resource groups.
- A hub VNet for hybrid connectivity (VPN/ExpressRoute).
- A VNet per application environment.
- Each region has a central IT team that controls and operates the respective Management Group.

The following diagram shows the current state of this sample scenario:

![Regional organization environment](./media/alz-align-scenario-regional-org.png)

## Transition to the Azure landing zone conceptual architecture

To transition from this scenario's current state to an Azure landing zone conceptual architecture, we suggest this approach:

1. Review the [Azure landing zone conceptual architecture](./index.md), [Azure landing zone design principles](./design-principles.md) and [Azure landing zone design areas](./design-areas.md).

2. Deploy the [Azure landing zone accelerator](/azure/architecture/landing-zones/landing-zone-deploy#platform) into the same Azure AD tenant in parallel with the current environment.

   Doing so creates a new management group structure. This structure is aligned with Azure landing zones design principles and recommendations. It also ensures that the existing environment is not affected by these changes.

3. Review the ["dev/test/production" workload landing zones guidance](./../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture) to understand how to handle "dev/test/production" workload landing zones.

4. Review the [Azure Landing zone sandbox environments guidance](/azure/cloud-adoption-framework/ready/considerations/sandbox-environments) to understand how to leverage the sandbox management group hierarchy to empower developers to test and experiment without affecting other environments.

5. Review the [Adopt policy-driven guardrails guidance](../enterprise-scale/dine-guidance.md) to understand how to minimize disruption to applications and services during the migration.

6. (optional) Work with application or service teams to migrate the workloads deployed in the original subscriptions into new Azure subscriptions, per the guidance in [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#moving-resources-in-azure). They can be placed into the newly deployed Azure landing zone conceptual architecture management group hierarchy under the correct management group – corporate or online.

   Review the policy section in [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#policy) for details about the effect on resources when migrating. Eventually, the existing Azure subscription can be canceled and placed in the decommissioned management group.

   > [!NOTE]
   > The existing applications or services do not necessarily have to be migrated into new landing zones (Azure subscriptions)

7. Create new Azure subscriptions to provide landing zones that can support new applications/workloads. Place them under the proper management group (corporate or online).

The following diagram shows the state during the migration approach of this sample scenario:

:::image type="content" source="./media/alz-align-regional-org-transition.png" alt-text="Single subscription environment - transition state" lightbox="./media/alz-align-regional-org-transition.png":::

## Summary

In this scenario, the customer has established the necessary foundation to support their growth and scale plans for their workloads in Azure by deploying the [Azure landing zone conceptual architecture](./index.md#azure-landing-zone-architecture) in parallel to their existing environment.
