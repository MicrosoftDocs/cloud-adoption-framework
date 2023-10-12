---
title: Scenario- Migrate an environment by duplicating a landing zone management group
description: Learn about a migration approach to transition to the Azure landing zone conceptual architecture by duplicating a landing zone management group.
author: sebassem
ms.author: sebassem
ms.reviewer: tozimmergren
ms.date: 09/18/2023
ms.topic: conceptual
ms.service: caf
---

<!-- docutune:casing resourceType resourceTypes resourceId resourceIds -->

# Scenario: Migrate an environment by duplicating a landing zone management group

This article describes an example approach that transitions an environment to the Azure landing zone conceptual architecture by duplicating the landing zone management group with policies in *audit only* mode. With this approach, you can quickly access the new desired target architecture and then assess the application or workload subscriptions for compliance. This approach eliminates the risk of affecting the application teams because the policies are in *audit only* mode.

## Transition to the Azure landing zone conceptual architecture

Use this approach to transition to an Azure landing zone conceptual architecture:

1. Review [Azure landing zone conceptual architecture](./index.md), [Azure landing zone design principles](./design-principles.md), and [Azure landing zone design areas](./design-areas.md).

1. Deploy the [Azure landing zone accelerator](/azure/architecture/landing-zones/landing-zone-deploy#platform) into the same Microsoft Entra ID tenant in parallel with the current environment. This method provides a smooth and phased transition to the new landing zone architecture with minimal disruption to active workloads.

   This deployment creates a new management group structure. This structure aligns with Azure landing zone design principles and recommendations. It also ensures that these changes don't affect the existing environment.

   For information about minimizing disruption to applications and services during the migration, see [Adopt policy-driven guardrails](../enterprise-scale/dine-guidance.md).

1. To duplicate the landing zone management group and it's children (Corp and Online in the following diagram) including all policy assignments, configure them to *audit only* mode. Set the [*Enforcement mode* on the policy assignments to DoNotEnforce/Disabled](/azure/governance/policy/concepts/assignment-structure#enforcement-mode). This approach provides quick access to the new desired target architecture. Then the applications teams can assess the policies without the risk of affecting active applications.

    ![Diagram that shows duplicate brownfield landing zones with audit only policies.](./media/alz-duplicate-brownfield-auditonly.png)

   > [!NOTE]
   > This approach has no additional cost because it only duplicates the management group hierarchy and the assigned policies, not the workloads.

1. (Optional) Work with application or service teams to migrate the workloads that are deployed in the original subscriptions into new Azure subscriptions. For more information see, [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#move-resources-in-azure). You can place workloads into the newly duplicated management group hierarchy under the correct management group, such as *Corp Brownfield* or *Online Brownfield*.

   For information about the effect on resources when migrating, see [Transition existing Azure environments to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md#policy). Eventually, you can cancel the existing Azure subscription and place it in the decommissioned management group.

   > [!NOTE]
   > You don't necessarily have to migrate the existing applications or services into new landing zones, or Azure subscriptions.

1. After the application teams work with the platform teams to get their policy compliance into the required state, their subscriptions are moved to the proper management group, such as Corporate or Online. They're covered by the assigned policies and your team can efficiently and compliantly operate their workload.

   For more information, see [Readying your landing zone for migration guidance](../.././migrate/azure-migration-guide/ready-alz.md).

The following diagram shows the state during the migration approach of this sample scenario:

:::image type="content" source="./media/duplicate-brownfield.svg" alt-text="Diagram that shows a single subscription environment in the transition state." border="false" lightbox="./media/duplicate-brownfield.svg":::

## Summary

You used this approach to safely migrate your workloads in Azure by deploying the [Azure landing zone conceptual architecture](./index.md#azure-landing-zone-architecture) in parallel with your existing environment with minimal disruption.
