---
title: Plan migration waves for Azure adoption
description: Learn how to organize workloads into migration waves for successful Azure adoption using an iterative approach that adapts to changing requirements.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan migration waves for Azure adoption

A migration wave is a structured group of workloads that move to Azure together. Organizing workloads into waves enables iterative planning, reduces risk, and accelerates cloud adoption. This article provides prescriptive guidance to define, execute, and manage migration waves effectively.

## Plan migration waves iteratively

An iterative wave-based approach improves agility and reduces risk during migration. Each wave builds on lessons learned from the previous one, enabling continuous improvement.

1. **Execute the first wave while planning the second.** Begin migrating the first wave while preparing the next to reduce idle time and accelerate progress. Use insights from the first wave to refine tools, runbooks, and timelines. This parallel approach increases efficiency and enables faster feedback loops.

2. **Use lessons learned to adjust future wave definitions.** Conduct structured retrospectives after each wave to identify technical issues, process gaps, and stakeholder concerns. Apply these insights to reprioritize workloads, update dependency maps, and improve readiness for future waves.

3. **Delay definition of later waves until sufficient data is available.** Avoid detailed planning for later waves until earlier waves provide enough insight. Maintain a backlog of candidate workloads and update their readiness based on discoveries. This approach prevents rework and ensures alignment with current business and technical realities.

4. **Group workloads in future waves based on evolving priorities and dependencies.** Reevaluate workload groupings as new information emerges. Consider business value, technical dependencies, and resource availability to ensure each wave remains achievable and strategically aligned.

## Group dependent systems in the same wave

A migration wave must include all interdependent systems to avoid broken integrations and business disruptions.

1. **Identify application and infrastructure dependencies.** Use dependency mapping tools or interviews with application owners to identify systems that must migrate together.

2. **Group tightly coupled systems into the same wave.** Include all systems that share data, authentication, or runtime dependencies in the same wave to preserve functionality.

3. **Validate integration points before migration.** Test key integrations in a staging environment to confirm that grouped systems function correctly post-migration.

## Select workloads for each wave

A structured workload selection process ensures alignment with business priorities and technical readiness.

1. **Define the first wave based on known workloads and low complexity.** Select internal systems or dev/test environments with minimal dependencies. These workloads typically involve fewer than 10 assets and serve as a pilot to validate tools and processes.

2. **Define business-driven prioritization criteria for next waves.** Use criteria such as datacenter exit deadlines, unsupported platforms, cost savings, or innovation opportunities to guide sequencing decisions.

3. **Capture business and technical requirements.** Document downtime windows, compliance needs, integration dependencies, and Azure compatibility for each workload.

4. **Maintain a dynamic migration backlog.** Continuously update the backlog to reflect new insights, shifting priorities, and lessons learned from earlier waves.

## Define timelines for each wave

Clear timelines provide structure and help manage stakeholder expectations.

1. **Set realistic wave durations.** Base timelines on workload complexity and team capacity. Typical waves last 4–12 weeks.

2. **Build in buffer time.** Add 20–30% contingency to account for unexpected challenges.

3. **Establish checkpoints.** Define milestone reviews within each wave to assess progress and adjust plans.

## Manage your migration wave plan

Structured project management improves coordination across teams and increases migration success rates.

### Configure work item hierarchy for migration tracking

1. **Create Epic-level migration objectives that span multiple waves.** Use Epics to represent major phases like "Legacy Application Portfolio Migration." Include success criteria and timelines aligned with business goals.

2. **Define Feature-level components within each Epic.** Use Features for major deliverables like "Database Platform Migration." Each Feature should span 2–4 weeks and involve multiple team members.

3. **Create detailed work items for specific deliverables.** Use Product Backlog Items or User Stories for tasks like "Migrate SQL Server database XYZ." Ensure each item fits within a sprint and includes acceptance criteria.

4. **Break down complex work into actionable tasks.** Use Tasks for activities like "Configure firewall rules." Each task should take 4–8 hours and include technical instructions.

5. **Track issues and blockers systematically.** Use Bug work items to document and resolve migration blockers. Include severity, business value, and resolution ownership.

6. **Establish validation criteria through test cases.** Use Test Cases to verify success criteria like "Confirm data integrity after migration." Include steps, expected results, and pass/fail criteria.

### Configure tracking workflows for migration stages

1. **Set up Epic workflows for strategic oversight.** Use states like "Proposed," "Approved," "In Progress," and "Completed" to track high-level progress.

2. **Configure Feature workflows for tactical management.** Use states like "New," "Active," "Resolved," and "Closed" to manage technical deliverables.

3. **Design task workflows for operational tracking.** Use "To Do," "In Progress," and "Done" to track daily work.

4. **Establish bug workflows for issue resolution.** Use "Active," "Resolved," "Verified," and "Closed" to manage blockers.

### Track dependencies and integration points

1. **Use Predecessor/Successor links to model sequential dependencies.** Identify critical path items and potential bottlenecks.

2. **Apply Parent/Child relationships for work breakdown.** Link Epics to Features and Features to Tasks for rollup reporting.

3. **Use Related links for cross-functional coordination.** Link work items across teams to ensure comprehensive coverage.

4. **Tag work items for cross-cutting concerns.** Use tags like "security-review" or "compliance-required" to highlight specialized needs.

### Monitor progress and adjust plans dynamically

1. **Create burndown charts to track wave progress.** Use sprint burndown charts to monitor completion rates and adjust resources.

2. **Use velocity metrics to improve estimation accuracy.** Track team velocity to set realistic expectations for future waves.

3. **Monitor blockers and impediments actively.** Use dashboards to highlight blocked items and risks.

4. **Conduct regular retrospectives to capture lessons learned.** Use Azure Boards queries to analyze completed work and document improvements.

## Work item types for migration management

| Work item type | Purpose | Migration example |
|----------------|---------|-------------------|
| Epic | Strategic migration phase spanning multiple waves | Data Center Exit – Phase 1: Foundation Services |
|