---
title: Plan your migration
description: Learn how to create migration plans that define workload sequencing, data transfer paths, and rollback strategies for successful Azure cloud migrations.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan your migration

A migration plan defines the specific order, timing, and approach for migrating workloads to Azure. This plan translates high-level migration strategies into actionable deployment sequences. It builds on the cloud adoption plan by addressing tactical decisions such as workload prioritization, migration sequencing, and data transfer methods.

**Prerequisites:** [Migration adoption plan](../plan/migration-adoption-plan.md), [Azure landing zone](/azure/cloud-adoption-framework/ready)

:::image type="content" source="./images/caf-migrate.svg" alt-text="Diagram showing the five-step process for migrating existing workloads to Microsoft Azure. On the left, two icons represent the starting point: a server rack labeled "On premises" and a cloud labeled "Other clouds." An arrow leads to a vertical list of five sequential steps in the center, each with a number and icon: 1 Plan migration, 2 Prepare workloads, 3 Execute migration, 4 Optimize in cloud, 5 Decommission source. A final arrow points from the steps to an Azure cloud icon on the right, indicating the destination of the migration." lightbox="./images/caf-migrate.svg" border="false":::

## Assess migration readiness and skills

A readiness assessment ensures that your team has the skills and support needed to execute the migration plan. This step identifies capability gaps and accelerates progress through targeted training or external support.

1. **Evaluate your team's Azure skills.** Review your team's experience with Azure services, migration tools, and cutover. This evaluation helps you identify specific knowledge gaps and determine what training your team needs to succeed.

1. **Engage external expertise when needed.** If your team lacks experience with cloud migration, bring in [Microsoft or a Microsoft partner](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate/#Nextsteps). External experts can validate your migration strategy, recommend appropriate tools, and help establish realistic timelines. This support reduces risk and speeds up your migration, especially for complex or large-scale projects.

## Choose your data migration path

A data migration path is how you move data from your current location to Azure. The right path ensures your data transfers securely, quickly, and cost-effectively. First, check what network connections you have available, ExpressRoute, VPN, or public internet, to understand your options.

1. **Use ExpressRoute when you have it.** ExpressRoute gives you a private, dedicated connection to Azure that's faster and more secure than internet connections. If you already have ExpressRoute or plan to get it, use this method for all your workloads. Keep in mind that ExpressRoute requires setup time and has data transfer costs.

1. **Use VPN if ExpressRoute isn't available.** Choose a VPN when you need secure data transfer but don't have ExpressRoute. A VPN creates an encrypted tunnel over the internet to Azure, though it's typically slower than ExpressRoute. Make sure you have a VPN Gateway configured in Azure before starting.

1. **Use Azure Data Box for large amounts of data.** Data Box is best for offline migrations with lots of data. Microsoft ships you a physical device to copy your data onto, then you ship it back. This option avoids using your network but takes the longest due to shipping time.

1. **Use public internet for less sensitive data.** This option works when your data doesn't need encryption and you can't use ExpressRoute or Data Box. While this method is available everywhere, it's the least secure and can slow down your other internet activities.

| Data Migration Path | When to use | Pros | Cons |
|----------------------|-------------|------|------|
| ExpressRoute | Any workload when available | Secure and fast | Set up required, costs money |
| VPN | Secure transfers when no ExpressRoute | More secure than public internet | Requires setup, slower than ExpressRoute |
| Azure Data Box | Offline migration with large amounts of data | Moves data without using your network | Slowest method due to shipping |
| Public internet | Nonsensitive data and can't use Data Box | Works everywhere | Least secure, uses your bandwidth |

## Determine the migration sequence

Migration sequencing reduces risk and builds team confidence by establishing a logical order for workload migration. The sequence determines which workloads move first and how dependent components migrate together to prevent service disruptions. Organize large portfolios into migration waves. For detailed guidance on wave planning, see [Migration wave planning](./migration-wave-planning.md).

### Find dependencies

[!INCLUDE [Steps to migrate dependencies together](./includes/migrate-dependencies-together.md)]

### Address split-environment operations

[!INCLUDE [Address split-environment operations](./includes/split-environment-dependencies.md)]

### Prioritize workloads to migrate

[!INCLUDE [Prioritize workloads to migrate](./includes/prioritize-workloads-to-migrate.md)]

### Create a detailed migration schedule

1. **Set start and end dates for each migration.** Include buffer time for testing and issue resolution to ensure smooth execution. This detailed scheduling reduces the risk of delays and supports effective resource planning.

2. **Align timelines with business events.** Avoid scheduling migrations during critical business periods such as financial close, product launches, or holiday seasons. This alignment reduces the risk of business disruption and ensures stakeholder confidence.

3. **Use project management tools to track progress.** Use tools like Azure DevOps to manage dependencies, track milestones, and communicate changes effectively. These tools provide visibility into migration progress and support proactive issue resolution.

## Choose the migration method for each workload

Migration methods fall into two categories: migration with downtime and migration with near-zero downtime. Choose the best migration method for each workload based on its downtime tolerance and business criticality.

1. **Choose downtime migration for workloads that tolerate planned outages.** Downtime migration is simpler and faster because it doesn't require real-time synchronization between source and target environments. This method works well for noncritical workloads such as development environments, test systems, or applications with scheduled maintenance windows. Document the acceptable downtime duration for each workload and schedule migrations during low-usage periods to minimize business effects.

2. **Choose near-zero downtime migration for critical workloads.** Near-zero downtime migration ensures that critical workloads remain operational during the transition through continuous data replication and cutover techniques. This method is essential for customer-facing applications, real-time transaction systems, or workloads with strict service level agreements. Validate that the workload architecture supports continuous replication and that network bandwidth can handle real-time data transfer. Test connectivity and replication processes in a nonproduction environment to confirm readiness for this migration method.

| Migration Method | When to use | Pros | Cons |
|------------------|-------------|------|------|
| Downtime migration | Noncritical workloads, development environments | Simpler process, faster execution | Service interruption required |
| Near-zero downtime migration | Critical workloads, strict SLAs | Minimal service disruption | Complex setup and requires testing |

## Define rollback plan

[!INCLUDE [Steps to define a rollback plan](../includes/define-rollback-plan.md)]

## Engage stakeholders on migration plan

Stakeholder approval validates your migration plan meets business requirements and risk tolerance. You should secure formal approval before executing migrations.

1. **Document the migration plan with business justification.** Create a structured plan showing workload name, owner, criticality, migration method, downtime window, and business effects. Include rationale for each approach and explain how it minimizes risk.

1. **Present tested rollback procedures.** Show specific rollback plans with steps, timeframes, and success criteria. Include automated and manual capabilities. Document preproduction test results to prove quick service restoration.

1. **Validate schedules against business constraints.** Review timelines with stakeholders to avoid critical business periods, maintenance freezes, and seasonal peaks. Provide alternative options with trade-offs if conflicts exist.

1. **Obtain formal approval and rollback authority.** Secure written approval from stakeholders for the migration plan and rollback procedures. Define decision-making authority and establish emergency communication channels.

1. **Define success criteria and review checkpoints.** Set measurable metrics including performance benchmarks, functionality validation, and user acceptance criteria. Schedule formal review points for go/no-go decisions.

## Next step

> [!div class="nextstepaction"]
> [Prepare workloads for the cloud](./prepare-workloads-cloud.md)
