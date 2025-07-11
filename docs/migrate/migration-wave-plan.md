---
title: Plan migration waves for Azure adoption
description: Learn how to organize workloads into migration waves for successful Azure adoption using an iterative approach that adapts to changing requirements.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan migration waves for Azure adoption

This article helps you organize workloads into manageable migration waves for successful cloud adoption. Learn how to group dependencies, prioritize workloads, and maintain flexibility throughout your Azure migration journey.

## Plan iteratively for cloud modernization

An iterative approach to cloud modernization groups workloads into waves and acknowledges that requirements evolve during execution. This approach provides flexibility to adapt your migration strategy as you discover technical challenges, shifting priorities, and unforeseen dependencies.

You need to structure your migration using waves because:

1. **Adjust plans based on lessons learned.** Each completed wave provides insights that improve subsequent migrations.
2. **Execute and plan simultaneously.** While you execute one wave, you plan the next and research future ones.
3. **Define waves progressively.** Later waves remain undefined until you gather enough information to address them effectively.

This flexibility allows you to focus on a manageable number of workloads at a time and refine your rationalization decisions as new information becomes available.

## Group dependent systems in the same wave

System dependencies determine your wave composition. You must identify systems that are interdependent or tightly integrated and group them into the same migration wave. This grouping minimizes disruption and reduces the risk of broken dependencies during migration.

1. **Map application dependencies first.** Use tools like Azure Migrate to discover which applications communicate with each other. Document all integration points between systems.
2. **Create dependency groups.** Group applications that share databases, APIs, or network connections. These groups form the foundation of your migration waves.
3. **Validate group completeness.** Ensure each group contains all components necessary for the applications to function. Include supporting infrastructure like load balancers or caching layers.

## Prioritize workloads for initial waves

Initial workload selection sets the foundation for your adoption plan. During incremental rationalization, your cloud adoption and strategy teams must agree on which workloads to migrate first. This agreement ensures alignment between technical capabilities and business objectives.

Your priority list typically includes:

1. **Start with pilot workloads.** Select simple workloads with fewer than 10 assets in self-contained deployments. These workloads help your team gain experience with minimal risk.
2. **Include representative complex workloads.** Add a few complex workloads to test broader scenarios. These workloads reveal challenges you'll face with mission-critical applications.
3. **Maintain a dynamic migration backlog.** Create an iterative backlog that you update as priorities shift. This flexibility prevents rigid plans that don't reflect real-world conditions.
4. **Capture business requirements.** Document acceptable downtime windows, stakeholder communication needs, compliance requirements, and integration dependencies for each workload.
5. **Assess technical readiness.** Evaluate application compatibility with Azure services, ISV support status, Azure landing zone requirements, and performance needs.

## Define timelines for each wave

Clear timelines for each wave provide structure to your migration effort. Defined start and end dates help manage scope, set stakeholder expectations, and track progress across teams.

1. **Set realistic wave durations.** Base timelines on workload complexity and team capacity. Typical waves range from 4-12 weeks.
2. **Build in buffer time.** Include contingency time for unexpected challenges. Plan for 20-30% additional time beyond initial estimates.
3. **Establish checkpoints.** Create milestone reviews within each wave to assess progress and adjust plans if needed.

## Manage your migration plan effectively

Collaborative planning tools enable effective wave management across your adoption team. Azure Boards provides features to track task status, ownership, sequencing, and updates throughout your migration.

Configure your planning tool with these work item types:

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
| Planning | [Azure Boards](https://azure.microsoft.com/services/devops/boards/) | Manages migration waves, tracks progress, and coordinates team activities |
| Discovery | [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-services-overview) | Discovers dependencies between applications and assesses migration readiness |
| Documentation | [Azure Architecture Center](https://docs.microsoft.com/azure/architecture/) | Provides reference architectures and best practices for cloud adoption |

## Next steps

> [!div class="nextstepaction"]
> [Assess workload readiness](./assess.md)
