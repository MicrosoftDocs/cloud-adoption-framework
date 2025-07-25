---
title: Plan the cloud-native solution
description: Plan the cloud-native solution
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan the cloud-native solution

A cloud-native solution creates new business value by building new applications or adding new features to existing ones. This guidance helps you deliver cloud-native workloads quickly and effectively by aligning technical efforts with business goals, and following a clear, repeatable process.

**Prerequisites:** [Architecture plan](/azure/cloud-adoption-framework/plan/estimate-total-cost-of-ownership), [Azure landing zone](/azure/cloud-adoption-framework/ready)

## Define requirements that drive implementation

1. **Document functional requirements.** Functional requirements describe the capabilities, features, and behaviors the system must provide to meet user needs. Capture these requirements as user stories that define who needs what functionality and why. For example: "As a customer, I need to track my order status in real time so I can plan for delivery."

2. **Establish non-functional requirements.** Nonfunctional requirements define performance expectations, security needs, scalability targets, and compliance obligations. Document specific, measurable targets for things like response time ("95% of requests under 2 seconds"), throughput, data protection standards, and availability (uptime SLAs). For example: "The system must support 1,000 concurrent users with response times under 2 seconds."

3. **Connect requirements directly to business objectives.** Ensure each requirement supports a business goal such as revenue growth, cost reduction, customer experience improvement, or market expansion. This alignment helps prioritize requirements based on business value and technical feasibility. Focus development efforts on the most valuable outcomes first. Every feature should trace back to a concrete business value.

## Design the cloud-native solution

1. **Design using Azure Well-Architected Framework principles.** Follow the five pillars of reliability, security, performance efficiency, cost optimization, and operational excellence throughout the design. Bake these principles into your architecture from the beginning rather than trying to add them later. This proactive approach reduces technical debt and accelerates time to production.

1. **Select Azure services that align with your requirements.** Use Azure’s decision guides and the Azure Architecture Center to choose the most appropriate services for your use case. Favor platform-as-a-service (PaaS) offerings whenever possible to reduce operational overhead by abstracting away infrastructure management. Managed services (for compute, databases, messaging, etc.) can accelerate development and simplify maintenance.

1. **Select the right service tier (SKU).** Estimate expected user concurrency, transaction volumes, data sizes, and latency requirements. Choose service SKUs that meet these targets and validate your choices through performance testing. Adjust the SKU if needed based on test results to achieve an optimal balance of cost and performance. It’s better to start with a smaller size and scale up as required than over-provision.

1. **Determine how many regions to use.** Use your reliability requirements, such as service level objectives (SLOs) for uptime, recovery point objectives (RPOs), and recovery time objectives (RTOs), to decide how many regions to use. For high availability or disaster recovery, multi-region deployments might be necessary. However, multi-region architectures can introduce complexity around data replication, latency, and data residency regulations. Work with your compliance team to ensure your regional strategy meets any legal or regulatory obligations.

1. **Plan governance controls.** Design the solution to fit within your organization’s established Azure landing zone structure (subscriptions, resource groups) so that it inherits existing governance policies. By deploying resources in the predefined application landing zone, you automatically apply Azure Policy definitions for things like tagging standards, allowed locations, and compliance requirements. Incorporate Azure role-based access control (RBAC) and security best practices from the start, rather than as an afterthought.

1. **Evaluate integration requirements**. Evaluate integration requirements and ecosystem compatibility. Assess how the new services and components integrate with existing systems and toolchains. Consider dependencies on identity and access management (Microsoft Entra ID), networking (virtual networks, hybrid connections), and other services. Ensure the technology stack of the solution is compatible with your organization’s IT ecosystem and your operational teams can manage it. Early identification of integration points (APIs, data feeds, authentication mechanisms) helps avoid surprises during development.

1. **Update or create architectures.** Develop a lightweight design document or architecture diagram that clearly outlines the solution. This architecture should include the chosen Azure services and their roles. It could include key design decisions and their justifications/trade-offs, and any critical nonfunctional requirements (such as compliance needs, latency expectations, or throughput targets) that influenced the design. Having this documentation facilitates stakeholder alignment, accelerates design reviews, and guides the implementation team.

## Prevent new build scope creep

1. **Define a focused scope that delivers core business value.** Clearly articulate the minimum viable product (MVP) or initial feature set that addresses the primary business requirements. Document the project scope boundaries so everyone understands what can and can't be delivered. This focus helps prevent feature creep during development. Defer nice-to-have enhancements to future phases. When new feature ideas come up, evaluate them against the project’s original objectives and timeline before deciding to include them now or later.

1. **Control scope changes.**  Establish a structured process for handling change requests. If stakeholders propose additions to the scope, record each request in a separate backlog ("future features" backlog) for later consideration. Only approve a scope change for the current release if it clearly supports the project’s goals and can be implemented without jeopardizing the timeline or budget. This formal check keeps the project on track.

1. **Communicate project focus consistently.** Provide regular updates to stakeholders highlighting progress on the agreed-upon scope and upcoming planned work. Transparency about what the team is currently focused on makes it easier to push back on out-of-scope requests. If someone asks for extra features mid-stream, politely remind them of the agreed scope and timeline, and explain that new requests will be logged for future evaluation. Consistent messaging reinforces discipline and manages expectations.

1. **Capture future opportunities separately.** It’s common during a cloud-native project to identify new ideas or opportunities (for example, "wouldn’t it be great if the app also did X…"). Rather than expanding the current project to chase these ideas, maintain a list or backlog for future improvements. This way, good ideas aren't lost, but they also don’t derail the current delivery. This approach allows the team to finish the current scope while laying the groundwork for subsequent iterations.

## Plan deployment strategy

A deployment strategy defines how to introduce a new workload or feature into production with minimal risk and maximum reliability. Selecting the right strategy ensures consistent delivery, enables rollback, and supports validation at each stage.

### Plan deployment for a new workload

1. **Use infrastructure-as-code (IaC) and CI/CD pipelines to deploy consistently.** IaC templates and automated pipelines ensure repeatable, version-controlled deployments across development, test, staging, and production environments. Use tools like Bicep, ARM templates, or Terraform with Azure DevOps or GitHub Actions to enforce consistency and reduce manual errors.

1. **Promote the workload through multiple environments before production.** Deploy to development, test, and staging environments to validate functionality, performance, and integration. Use automated and manual testing at each stage to catch issues early and reduce production risk.

1. **Use a canary deployment to launch the workload in production.** For the production launch, consider a canary deployment. Release the new workload to a small subset of users or a pilot environment first, verify everything works as expected, then gradually ramp up to full production. This approach limits the blast radius of any unforeseen issues in the initial release.

### Plan deployment for new features in an existing system

1. **Use in-place updates for minor or backward-compatible changes.** Deploy the feature incrementally using rolling updates or feature flags. Start with a small percentage of users or a limited number of instances. Monitor system metrics and logs to validate stability before expanding the rollout. This approach minimizes user effects and supports fast rollback.

1. **Use parallel (blue-green) deployments for larger or riskier changes.** Deploy the updated version alongside the current version in a separate environment. Route a small portion of live traffic to the new version to validate performance and behavior. If successful, shift all traffic to the new version and decommission the old one. If issues arise, revert traffic to the original version instantly. This strategy ensures zero-downtime deployment and simplifies rollback.

### Plan for new feature integration

When you add new features to an existing application or workload, more planning is needed to integrate changes smoothly and ensure stability.

1. **Use a change management process.** Follow your organization’s change management procedures to control and record changes to the production environment. You typically need to create a change record, getting approval from a change advisory board (if applicable), and scheduling deployments during approved windows. A formal process ensures all stakeholders are aware of upcoming changes and that proper rollback plans are in place.

1. **Define rollback and recovery procedures.** For each feature deployment, decide in advance how to roll back if something goes wrong. You could revert to the previous version of an application, disabling a feature flag, or restoring a database from backup. Document the steps needed to safely undo the deployment and recover normal operations. Having a tested rollback plan minimizes downtime and business issues if the new feature causes issues in production.

1. **Secure stakeholder approval.** Before deploying a new feature, make sure you have approval from key stakeholders, product owners, or business sponsors. They should agree that the feature meets the requirements and acceptance criteria. Additionally, confirm that stakeholders understand the deployment plan, including any potential user effects or downtime. Gaining approval and awareness from all parties ensures there are no surprises and that the feature launch aligns with business readiness (for example, avoiding deploying right before a critical business period).

## Plan for operational handover

1. **Define ownership and support responsibilities before deployment.** Decide early who should operate and support the new solution once it’s live in production. Assign a team, such as operations team, DevOps team, or product team. Define the support model, such as 24/7 on-call rotation, business-hours support. Ensure all stakeholders understand their roles. This clarity enables fast response to incidents and ensures continuity of service.

1. **Design the solution with operational readiness in mind.** Operational readiness includes monitoring, logging, alerting, and disaster recovery. Integrate Azure Monitor and Application Insights to track system health and performance. Configure alerts for key metrics and failure conditions. Define and document a disaster recovery plan that includes recovery time objectives (RTO) and recovery point objectives (RPO). These capabilities ensure the team can detect and respond to issues quickly.

1. **Document operational procedures and escalation paths.** Documentation enables the support team to manage the workload effectively  Include procedures for restarting services, accessing logs, handling common issues, and escalating incidents. Store documentation in a central, accessible location such as a SharePoint site, Azure DevOps Wiki, or GitHub repository. By planning the handover, you ensure a smooth transition from development to steady-state operations with no gaps in accountability.

1. **Conduct a formal handover before transitioning to steady-state operations.** A formal handover ensures that the receiving team is prepared to support the workload. Review the system architecture, monitoring setup, known issues, and support procedures. Validate that the team has access to all required tools and documentation. This step confirms readiness and prevents operational gaps.

## Next step

> [!div class="nextstepaction"]
> [Build the new solution](./build-cloud-native-solutions.md)