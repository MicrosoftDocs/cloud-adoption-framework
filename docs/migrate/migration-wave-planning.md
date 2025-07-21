---
title: Migration wave planning
description: Learn how to organize workloads into migration waves for successful Azure adoption using an iterative approach that adapts to changing requirements.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Migration wave planning

This article shows you how to organize workloads into structured migration waves for successful Azure adoption. Migration wave planning divides large migration projects into smaller, manageable groups of workloads that can be migrated together. This approach reduces risk and complexity while increasing the speed of your cloud adoption journey. By migrating in controlled batches rather than attempting to move everything at once, you gain valuable experience with each wave that improves subsequent migrations.

## Plan iteratively to adapt to changing requirements

An iterative approach to migration planning groups workloads into waves and adapts to new information discovered during execution. This approach provides flexibility to adjust your migration strategy as you uncover technical challenges, shifting business priorities, and previously unknown dependencies. You should structure your migration using waves because iterative planning delivers better outcomes than rigid, comprehensive plans.

1. **Create learning cycles that improve subsequent migrations.** Each completed wave provides insights into performance requirements, dependency complexities, and organizational capabilities. Use these lessons to refine your approach for remaining workloads. Document what worked well and what challenges emerged to build institutional knowledge.

2. **Execute current waves while planning future ones.** While your team migrates one wave of workloads, use the time to plan the next wave and research future candidates. This parallel approach maximizes team productivity and maintains migration momentum. Assign team members to both execution and planning activities to ensure continuous progress.

3. **Keep future waves flexible until you have sufficient information.** Define only the immediate next wave in detail, leaving later waves at a high level until you understand their specific requirements. This flexibility prevents premature commitments based on incomplete information and allows you to incorporate lessons learned from earlier waves.

## Group dependent systems within the same wave

System dependencies determine your wave composition and migration sequencing. You must identify workloads that communicate or share resources and group them into the same migration wave. This grouping prevents service disruptions caused by broken dependencies and reduces migration complexity.

[!INCLUDE [Steps to migrate dependencies together](./includes/migrate-dependencies-together.md)]

## Prioritize workloads using a structured framework

Initial workload selection establishes the foundation for your migration program and builds team confidence through early successes. Your cloud adoption and strategy teams must agree on prioritization criteria that balance business value, technical risk, and organizational learning objectives.

1. **Maintain a prioritized migration backlog.** Create a backlog that ranks workloads based on business value, technical complexity, and strategic importance. Update priorities quarterly or when business conditions change to ensure your migration sequence reflects current organizational needs. Use a value-effort matrix to categorize applications:

    | Priority | Business value | Effort | Description |
    |----------|----------------|--------|-------------|
    | High | High | Low | Quick wins - migrate first for immediate impact |
    | Medium-High | High | High | Strategic investments - plan carefully with adequate resources |
    | Medium-Low | Low | Low | Easy candidates - fill gaps between major migrations |
    | Low | Low | High | Avoid or defer - focus resources on higher-value opportunities |

2. **Start with non-critical applications that have simple architectures.** Noncritical workloads provide a safe environment for your team to practice migration procedures and refine processes without risking essential business functions. Target internal tools, development environments, or low-usage applications with standalone architectures and minimal integration points.

3. **Schedule critical systems after you demonstrate initial success.** Critical applications require proven migration capabilities before you move them to Azure. Plan these migrations for later waves when your team demonstrates competency with Azure services. Business deadlines such as hardware refresh cycles might require you to prioritize critical applications earlier with more safeguards and extended testing periods.

4. **Include representative complex workloads to test scenarios.** Add one or two complex workloads to each early wave to expose challenges you face with mission-critical applications. Choose workloads that represent common patterns such as multi-tier applications or database-dependent systems.

5. **Assess technical readiness systematically.** Evaluate operating system support, application compatibility with Azure services, and performance requirements for each workload. Use Azure Migrate assessments to identify sizing recommendations and cost estimates.

## Define timelines for each wave

Clear timelines for each wave provide structure to your migration effort. Defined start and end dates help manage scope, set stakeholder expectations, and track progress across teams.

1. **Set wave durations based on workload complexity and team capacity.** Consider your team's Azure experience, availability of subject matter experts, and concurrent project demands when estimating durations. Factor in time for testing, validation, and knowledge transfer activities.

2. **Include buffer time for unexpected challenges and learning.** Add contingency time to initial estimates to account for unforeseen technical issues, dependency discoveries, and troubleshooting activities. Migration projects consistently encounter challenges that weren't apparent during planning. Buffer time prevents schedule pressure that leads to shortcuts or quality compromises.

3. **Establish milestone checkpoints within each wave.** Create review points at 25%, 50%, and 75% completion to assess progress, validate assumptions, and adjust plans when necessary. Use these checkpoints to communicate status to stakeholders, identify blockers early, and make course corrections before they affect downstream activities.

4. **Plan cutover windows during business-appropriate times.** Schedule final cutover activities during established maintenance windows, off-peak hours, or planned downtime periods. Coordinate with business stakeholders to ensure cutover timing aligns with business cycles, regulatory reporting periods, and critical business activities. Document rollback procedures and success criteria for each cutover.

5. **Adjust timelines based on execution feedback.** Migration timelines are dynamic. You should review actual vs. planned durations after each wave and adjust future waves to stay on track.

## Manage your migration plan

Collaborative planning tools enable effective wave management across your adoption team. Azure Boards provides features to track task status, ownership, sequencing, and updates throughout your migration. Configure your planning tool with these work item types:

| Work item type | Purpose | Example |
|----------------|---------|---------|
| Epic | Overall project scope | Data center migration to Azure |
| Feature | Major project component | Digital estate assessment |
| Product backlog item | Specific deliverable | Azure Migrate deployment |
| Task | Individual action item | Configure on-premises IP address ranges |
| Bug | Issue blocking progress | Firewall blocks Azure Migrate scanning |
| Test case | Validation criteria | Azure Migrate scans complete with zero errors |

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Planning | [Azure Boards](/azure/devops/boards/) | Manages migration waves, tracks progress, and coordinates team activities |
| Discovery | [Azure Migrate](/azure/migrate/migrate-services-overview) | Discovers dependencies between applications and assesses migration readiness |

## Next steps

> [!div class="nextstepaction"]
> [Choose the migration method](./plan-migration.md#choose-the-migration-method-for-each-workload)
