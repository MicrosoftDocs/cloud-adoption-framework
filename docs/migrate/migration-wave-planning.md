---
title: Migration wave planning
description: Learn how to organize workloads into migration waves for successful Azure adoption using an iterative approach that adapts to changing requirements.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Migration wave planning

This article helps you organize workloads into manageable migration waves for successful cloud adoption. Learn how to group dependencies, prioritize workloads, and maintain flexibility throughout your Azure migration journey.

## Plan iteratively to adapt to changing requirements

An iterative approach to migration planning groups workloads into waves and adapts to new information discovered during execution. This approach provides flexibility to adjust your migration strategy as you uncover technical challenges, shifting business priorities, and previously unknown dependencies. You should structure your migration using waves because iterative planning delivers better outcomes than rigid, comprehensive plans.

1. **Create learning cycles that improve subsequent migrations.** Each completed wave provides insights into performance requirements, dependency complexities, and organizational capabilities. Use these lessons to refine your approach for remaining workloads. Document what worked well and what challenges emerged to build institutional knowledge.

2. **Execute current waves while planning future ones.** While your team migrates one wave of workloads, use the time to plan the next wave and research future candidates. This parallel approach maximizes team productivity and maintains migration momentum. Assign team members to both execution and planning activities to ensure continuous progress.

3. **Keep future waves flexible until you have sufficient information.** Define only the immediate next wave in detail, leaving later waves at a high level until you understand their specific requirements. This flexibility prevents premature commitments based on incomplete information and allows you to incorporate lessons learned from earlier waves.

## Group dependent systems within the same wave

System dependencies determine your wave composition and migration sequencing. You must identify workloads that communicate or share resources and group them into the same migration wave. This grouping prevents service disruptions caused by broken dependencies and reduces migration complexity.

1. **Use automated tools to discover application dependencies.** Deploy dependency mapping tools to scan your environment and identify network communications, shared databases, and API integrations between applications. These tools provide objective data about actual system interactions that might not be documented. Supplement automated discovery with configuration management database (CMDB) data when available.

2. **Validate discoveries with subject matter experts.** Interview application owners, infrastructure teams, and business stakeholders to confirm tool findings and identify dependencies that automated scanning missed. Focus on shared services, batch processes, data feeds, and informal integrations that occur outside normal business hours. Document authentication methods, data exchange patterns, and integration frequencies.

3. **Create dependency groups using move group methodology.** Group applications that must migrate together due to tight integration, shared data stores, or synchronous communication requirements. Include all supporting infrastructure such as load balancers, caching layers, and security components. Each group should contain all components necessary for the applications to function independently in Azure.

4. **Map external dependencies that constrain migration timing.** Identify connections to SaaS platforms, partner systems, regulatory systems, and on-premises infrastructure that will remain. Document network requirements, authentication dependencies, and data residency constraints that affect migration design and timing.

## Prioritize workloads using a structured framework

Initial workload selection establishes the foundation for your migration program and builds team confidence through early successes. Your cloud adoption and strategy teams must agree on prioritization criteria that balance business value, technical risk, and organizational learning objectives.

1. **Begin with pilot workloads to build team expertise.** Select simple workloads minimal external dependencies, and non-critical business functions. These workloads provide hands-on experience with Azure services, migration tools, and operational procedures without risking business disruption. Target workloads with well-understood architectures and supportive business owners.

2. **Include representative complex workloads to test scenarios.** Add one or two complex workloads to each early wave to expose challenges you face with mission-critical applications. Choose workloads that represent common patterns in your environment such as multi-tier applications, database-dependent systems, or applications with specific compliance requirements. Use these workloads to validate your migration processes and identify skill gaps.

3. **Maintain a prioritized migration backlog.** Create a dynamic backlog that ranks remaining workloads based on business value, technical complexity, and strategic importance. Update priorities quarterly or when business conditions change to ensure your migration sequence reflects current organizational needs. Use a simple scoring system that combines business impact, technical readiness, and risk factors.

4. **Document business requirements for each workload.** Record acceptable downtime windows, stakeholder notification requirements, compliance obligations, and performance expectations. Include business owner contact information, escalation procedures, and rollback criteria. This documentation ensures migration plans align with business operations and regulatory requirements.

5. **Assess technical readiness systematically.** Evaluate operating system support, application compatibility with Azure services, ISV support status, and performance requirements for each workload. Document dependencies on specific hardware, network configurations, or legacy protocols that might require remediation. Use Azure Migrate assessments to identify sizing recommendations and cost estimates.

## Define timelines for each wave

Clear timelines for each wave provide structure to your migration effort. Defined start and end dates help manage scope, set stakeholder expectations, and track progress across teams.

Clear timelines provide structure and enable effective resource planning while accommodating the uncertainty inherent in migration projects. Realistic scheduling builds stakeholder confidence and prevents the quality compromises that result from overly aggressive timelines.

1. **Set wave durations based on workload complexity and team capacity.** Consider your team's Azure experience, availability of subject matter experts, and concurrent project demands when estimating durations. Factor in time for testing, validation, and knowledge transfer activities.

2. **Include buffer time for unexpected challenges and learning.** Add contingency time to initial estimates to account for unforeseen technical issues, dependency discoveries, and troubleshooting activities. Migration projects consistently encounter challenges that weren't apparent during planning. Buffer time prevents schedule pressure that leads to shortcuts or quality compromises.

3. **Establish milestone checkpoints within each wave.** Create review points at 25%, 50%, and 75% completion to assess progress, validate assumptions, and adjust plans when necessary. Use these checkpoints to communicate status to stakeholders, identify blockers early, and make course corrections before they impact downstream activities.

4. **Plan cutover windows during business-appropriate times.** Schedule final cutover activities during established maintenance windows, off-peak hours, or planned downtime periods. Coordinate with business stakeholders to ensure cutover timing aligns with business cycles, regulatory reporting periods, and critical business activities. Document rollback procedures and success criteria for each cutover.

## Manage your migration plan effectively

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
| Planning | [Azure Boards](https://azure.microsoft.com/services/devops/boards/) | Manages migration waves, tracks progress, and coordinates team activities |
| Discovery | [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-services-overview) | Discovers dependencies between applications and assesses migration readiness |
| Documentation | [Azure Architecture Center](https://docs.microsoft.com/azure/architecture/) | Provides reference architectures and best practices for cloud adoption |

## Next steps

> [!div class="nextstepaction"]
> [Assess workload readiness](./assess.md)