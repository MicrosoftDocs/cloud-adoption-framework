---
title: Document your cloud adoption plan
description: Learn how to document your cloud adoption plan to ensure alignment, accountability, and traceability across stakeholders. This article provides actionable guidance for organizing plans, detailing Azure landing zones, aligning with standards, estimating timelines, and preparing for successful Azure adoption.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/15/2025
ms.topic: conceptual
---

# Document your cloud adoption plan

A cloud adoption plan provides a single source of truth for all decisions, estimates, and strategies related to Azure adoption. This documentation ensures alignment across stakeholders, supports governance, and enables continuous refinement of cloud efforts. You must document each component of the plan to ensure visibility, accountability, and traceability.

## Align your plan with standards and frameworks

Alignment with organizational standards and governance frameworks ensures that cloud adoption efforts remain consistent, compliant, and measurable.

1. **Select and tailor a cloud adoption template that matches your scenario.** Choose a template that aligns with your adoption approach. Use the [Cloud-native adoption plan](./cloud-native-adoption-plan.md) if you're building new solutions in Azure. Use the [Migration adoption plan](./migration-adoption-plan.md) if you're migrating existing workloads.

2. **Ensure alignment with organization standards.** Ensure the cloud adoption plan aligns with your organization’s project management methodologies. Include required artifacts, approval gates, and checkpoints. This alignment ensures that cloud adoption activities integrate with broader delivery processes.

3. **Document reporting and accountability structures.** Record how progress is tracked and reported, and who is accountable for each aspect of the plan. Capture approvals from technical and business stakeholders to confirm shared ownership and alignment with the cloud adoption plan.

## Document organization and people plans

A clear organizational and people plan ensures that the right teams are prepared and accountable for cloud adoption success.

1. **Capture the cloud operating model.** Define how cloud services are delivered and managed. Document the structure, roles, and processes that support cloud operations, governance, and support functions.

2. **Record team responsibilities.** Assign clear responsibilities to each team. Document ownership for architecture, security, operations, and business alignment to reduce ambiguity and ensure accountability.

3. **Document the skilling plan.** Outline required training and certifications for each role. Record learning paths and timelines to ensure teams are prepared to support cloud adoption effectively.

## Document Azure landing zone and workload details

A well-documented plan for your Azure environment ensures Azure meets your business objectives.

1. **Record the Azure landing zone architecture.** Document the design of the foundational Azure environment, including networking, identity, security, and governance components. This documentation ensures that the landing zone supports scalability, compliance, and operational readiness.

2. **Maintain a complete workload inventory.** List all workloads targeted for migration or cloud-native development. Include metadata such as workload owner, business criticality, and dependencies. This inventory provides visibility into workload priorities and interdependencies.

3. **Document migration plans.** For each workload, record the migration strategy (retire, rehost, refactor, rearchitect, replace, retain), success metrics, assessment results, target architecture, and cost estimates. Use the guidance in [Migration adoption plan](./migration-adoption-plan.md) for consistency and alignment.

4. **Document cloud-native workload plans.** For each planned cloud-native workload, record the architecture, requirements, success metrics, and cost estimates. Use the guidance in [Cloud-native adoption plan](./cloud-native-adoption-plan.md) for effective planning and execution.

## Document estimated timelines

Timelines provide a shared understanding of when workloads are ready and help manage dependencies and risks.

1. **Record estimated timelines for each workload.** Use available data and business drivers to estimate when each workload is production-ready in Azure. This step ensures alignment with organizational priorities and resource planning.

2. **Capture key milestones and dependencies.** Document major phases, dependencies, and blockers to support planning and risk mitigation. This documentation provides visibility into critical path activities and potential risks.

3. **Include a process for timeline updates.** Define how and when timelines are reviewed to reflect actual progress. This process ensures that plans remain accurate and actionable throughout the adoption lifecycle.

## Next step

By the end of the Plan phase, you have a cloud adoption roadmap that all stakeholders understand. Now it’s time to build your Azure environment.

> [!div class="nextstepaction"]
> [CAF Ready](../ready/index.md)
