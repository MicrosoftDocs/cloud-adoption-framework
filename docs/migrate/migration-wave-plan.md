---
title: Plan migration waves for Azure adoption
description: Learn how to organize workloads into migration waves for successful Azure adoption using an iterative approach that adapts to changing requirements.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan migration waves for migration to Azure

This article helps you organize workloads into manageable migration waves for successful cloud adoption. Learn how to group dependencies, prioritize workloads, and maintain flexibility throughout your Azure migration journey.

## Plan iteratively for migration to Azure

An iterative approach migration to Azure groups workloads into waves and acknowledges that requirements evolve during execution. This approach provides flexibility to adapt your migration strategy as you discover technical challenges, shifting priorities, and unforeseen dependencies.

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

Initial workload selection sets the foundation for your adoption plan. During incremental rationalization, your cloud adoption and strategy teams must agree on which workloads to migrate first. This agreement ensures alignment between technical capabilities and business objectives. Follow crawl, walk, run, fly model while planning your waves.

Your priority list typically includes:

1. **Start with pilot workloads.** Select simple workloads with fewer than 10 assets in self-contained deployments. These workloads help your team gain experience with minimal risk.
2. **Include representative complex workloads.** Add a few complex workloads to test broader scenarios. These workloads reveal challenges you'll face with mission-critical applications.
3. **Maintain a dynamic migration backlog.** Create an iterative backlog that you update as priorities shift. This flexibility prevents rigid plans that don't reflect real-world conditions.
4. **Capture business requirements.** Document acceptable downtime windows, stakeholder communication needs, compliance requirements, and integration dependencies for each workload.
5. **Assess technical readiness.** Evaluate application compatibility with Azure services, ISV support status, Azure landing zone requirements, and performance needs.

Define your criteria for 'priority'. Is it workloads that:
- Meet a deadline (e.g. datacentre exit)
- Have the highest risk (out of date OS)
- Have the highest business value (need to add AI to a line of business app to remain competitive)
- Save the most money
...etc.

## Define timelines for each wave

Clear timelines for each wave provide structure to your migration effort. Defined start and end dates help manage scope, set stakeholder expectations, and track progress across teams.

1. **Set realistic wave durations.** Base timelines on workload complexity and team capacity. Typical waves range from 4-12 weeks.
2. **Build in buffer time.** Include contingency time for unexpected challenges. Plan for 20-30% additional time beyond initial estimates.
3. **Establish checkpoints.** Create milestone reviews within each wave to assess progress and adjust plans if needed.

## Manage your migration wave plan

Effective migration management requires collaborative planning tools that provide visibility across your adoption team. Azure Boards offers comprehensive work item tracking capabilities designed specifically for complex project coordination. This tool set enables teams to monitor progress, manage dependencies, and maintain accountability throughout your migration journey.

You must implement structured project management practices for migration waves because complex cloud adoption projects involve multiple stakeholders, interdependent tasks, and evolving requirements. Organizations that use collaborative planning tools report 40% better project completion rates compared to teams relying on informal tracking methods.

### Configure work item hierarchy for migration tracking

Azure Boards supports hierarchical work item structures that mirror your migration wave organization. You should configure your planning tool with work item types that reflect the natural progression from high-level migration objectives down to specific implementation tasks.

1. **Start with Epic-level migration objectives that span multiple waves.** Configure Epics to represent major migration phases like "Phase 1: Foundation Services Migration" or "Legacy Application Portfolio Migration." Each Epic should contain a clear success criteria and timeline that aligns with your business objectives. These high-level work items provide strategic visibility for executive stakeholders and help maintain focus on business outcomes.

2. **Define Feature-level components within each Epic.** Create Features for major technical deliverables such as "Active Directory Migration," "Database Platform Migration," or "Network Infrastructure Setup." Features should represent substantial work packages that typically require 2-4 weeks to complete and involve multiple team members. This level provides the right granularity for wave planning and resource allocation.

3. **Create detailed work items for specific deliverables.** Use Product Backlog Items (Scrum process) or User Stories (Agile process) to represent concrete migration tasks like "Migrate SQL Server database XYZ" or "Configure Azure Virtual Network peering." These items should be sized for completion within a single sprint iteration and include clear acceptance criteria.

4. **Break down complex work into actionable tasks.** Create Task work items for individual activities that technical team members can complete independently. Examples include "Export database schema," "Configure firewall rules," or "Update DNS records." Tasks should represent 4-8 hours of work and include specific technical instructions.

5. **Track issues and blockers systematically.** Use Bug work items to document problems that prevent migration progress, such as "Application dependency on legacy SSL certificate" or "Network connectivity issues between on-premises and Azure." Each bug should include severity assessment, impact analysis, and assigned resolution owner.

6. **Establish validation criteria through test cases.** Create Test Case work items to verify migration success criteria like "Verify application performance meets SLA requirements" or "Confirm data integrity after database migration." Test cases should include step-by-step procedures, expected results, and pass/fail criteria.

### Implement tracking workflows for migration stages

Migration work items follow distinct lifecycle stages that require different workflow states. Azure Boards provides customizable workflows that you can align with your organization's migration processes and approval requirements.

1. **Configure Epic workflows for strategic oversight.** Epic work items should use states like "Proposed," "Approved," "In Progress," and "Completed" to track high-level migration phases. These states provide executive visibility into overall migration progress and help identify waves that require additional resources or executive attention.

2. **Set up Feature workflows for tactical management.** Feature work items benefit from more detailed states including "New," "Active," "Resolved," and "Closed." The "Active" state indicates active development work, while "Resolved" means technical work is complete but pending validation. The "Closed" state confirms business acceptance and successful deployment.

3. **Design task workflows for operational tracking.** Task work items should use simple states like "To Do," "In Progress," and "Done" to provide clear visibility into daily work progress. This granular tracking enables daily standup meetings and helps identify tasks that require additional support or resources.

4. **Establish bug workflows for issue resolution.** Bug work items require specialized workflows including states like "Active," "Resolved," "Verified," and "Closed." The "Verified" state indicates successful testing of the fix, while "Closed" confirms the issue no longer impacts migration progress.

### Track dependencies and integration points

Migration projects involve complex dependencies between applications, infrastructure components, and business processes. Azure Boards provides linking capabilities that help visualize and manage these critical relationships.

1. **Use Predecessor/Successor links to model sequential dependencies.** Link work items that must complete before other work can begin, such as "Network configuration must complete before application deployment." These links help identify critical path items and potential bottlenecks in your migration schedule.

2. **Implement Parent/Child relationships for work breakdown.** Link high-level Epics to their constituent Features, and Features to their related tasks. This hierarchy enables rollup reporting and helps stakeholders understand how detailed work contributes to strategic objectives.

3. **Apply Related links for cross-functional coordination.** Link work items that require coordination between different teams or technical domains, such as security configuration tasks that support application migration work. These links facilitate communication and ensure comprehensive migration coverage.

4. **Tag work items for cross-cutting concerns.** Use tags like "security-review," "network-dependency," or "compliance-required" to identify work items that require specialized attention or expertise. Tags enable quick filtering and help ensure that cross-cutting requirements receive appropriate focus.

### Monitor progress and adjust plans dynamically

Migration projects require continuous monitoring and adjustment based on lessons learned and changing requirements. Azure Boards provides reporting and analytics capabilities that support data-driven decision making.

1. **Create burndown charts to track wave progress.** Configure sprint burndown charts to monitor work completion rates within each migration wave. These charts help identify when waves are falling behind schedule and enable proactive resource adjustment.

2. **Use velocity metrics to improve estimation accuracy.** Track team velocity across completed waves to improve estimation for future work. Historical velocity data helps set realistic expectations and improves stakeholder confidence in migration timelines.

3. **Monitor blockers and impediments actively.** Create dashboards that highlight work items in blocked states or those approaching deadline risks. Regular impediment tracking ensures that issues receive prompt attention and don't cascade into larger problems.

4. **Conduct regular retrospectives to capture lessons learned.** Use Azure Boards queries to analyze completed work and identify improvement opportunities. Document lessons learned as work items or comments to inform future wave planning and execution.

### Configure the following work item types for migration management

| Work item type | Purpose | Migration-specific example |
|----------------|---------|----------------------------|
| Epic | Strategic migration phase spanning multiple waves | "Data Center Exit - Phase 1: Foundation Services" |
| Feature | Major technical component or capability | "Active Directory Domain Services Migration" |
| Product backlog item / User Story | Specific migration deliverable | "Migrate CRM database to Azure SQL Database" |
| Task | Individual technical activity | "Configure Azure SQL Database firewall rules" |
| Bug | Issue preventing migration progress | "Application fails to connect to migrated database" |
| Test case | Validation criteria for migration success | "Verify application performance meets baseline SLA" |
| Issue | Risk or impediment requiring management attention | "Vendor software license incompatible with Azure" |

## Next steps

> [!div class="nextstepaction"]
> [Assess workload readiness](./assess.md)
