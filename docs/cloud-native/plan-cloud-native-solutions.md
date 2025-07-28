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

**Prerequisites:** [Azure landing zone](/azure/cloud-adoption-framework/ready)

## Define business objectives for cloud-native solution

Start with clear business objectives and constraints. Decide what “success” looks like, such as the ability to handle 10x traffic, faster time-to-market. These success metrics guide all other decisions. Ensure stakeholder alignment before you begin.

## Define requirements for cloud-native solution

1. **Connect requirements directly to business objectives.** Ensure each requirement supports a business goal such as revenue growth, cost reduction, customer experience improvement, or market expansion. This alignment helps prioritize requirements based on business value and technical feasibility. Focus development efforts on the most valuable outcomes first. Every feature should trace back to a concrete business value.

1. **Document functional requirements.** Based on the business objectives, define the Functional requirements describe the capabilities, features, and behaviors the system must provide to meet user needs. Capture these requirements as user stories that define who needs what functionality and why. For example: "Customers need to track order status in real time."

1. **Establish nonfunctional requirements.** Nonfunctional requirements define technical expectations. Define target [reliability metrics](/azure/well-architected/reliability/metrics) like service level objectives (SLOs) for uptime, recovery point objectives (RPOs), and recovery time objectives (RTOs). Establish a [security baseline](/azure/well-architected/security/establish-baseline). Create [cost model](/azure/well-architected/cost-optimization/cost-model). Set [performance targets](/azure/well-architected/performance-efficiency/performance-targets).

1. **Control scope cloud-native solutions.** Define a focused scope that delivers core business value by clearly articulating the requirements. Document project scope boundaries to prevent feature creep and establish a structured process for handling change requests. Only approve scope changes that clearly support project goals and can be implemented without jeopardizing timeline or budget. Maintain a separate backlog for future enhancements and communicate project focus consistently through regular stakeholder updates. This disciplined approach keeps the project on track while capturing opportunities for future phases.

## Plan the cloud-native architecture

### Use the Azure Architecture Center

The [Azure Architecture Center](/azure/architecture/browse/) provides solutions for a variety of use cases. Adopt and modify these architectures to meet your requirements, or use them for inspiration. Make sure you know the [architecture fundamentals](azure/architecture/guide/) and [best pratices](/azure/architecture/best-practices/index-best-practices). Review the different architecture styles like [microservices](/azure/architecture/guide/architecture-styles/) and [web-queue worker](/azure/architecture/guide/architecture-styles/web-queue-worker). Ensure to use [cloud design patterns](/azure/architecture/patterns/) in your architecture to facilitate cloud-native design.

### Use the Well-Architected Framework

For cloud-native solutions, you must understand and follow and implement [Well-Architected Framework's](/azure/well-architected/pillars) principles for reliability, security, performance efficiency, cost optimization, and operational excellence. Bake these principles into your architecture from the beginning rather than trying to add them later. This proactive approach reduces technical debt and accelerates time to production.

## Evaluate integration requirements

Evaluate integration requirements and ecosystem compatibility. Assess how the new services and components integrate with existing systems and toolchains. Consider dependencies on identity and access management (Microsoft Entra ID), networking (virtual networks, hybrid connections), and other services. Ensure the technology stack of the solution is compatible with your organization’s IT ecosystem and your operational teams can manage it. Early identification of integration points (APIs, data feeds, authentication mechanisms) helps avoid surprises during development.

### Select Azure services

Use [Azure’s decision guides](/azure/architecture/guide/technology-choices/technology-choices-overview) to compare Azure services based on technical fit, cost, and operational complexity. In general, prefer platform-as-a-service (PaaS) offerings whenever possible. PaaS offerings reduce operational overhead by abstracting away infrastructure management. See also [Recommendations for selecting the right services](/azure/well-architected/performance-efficiency/select-services).

### Select the service tier (SKU)

Each Azure service offers multiple service tiers (also known as SKUs) that provide different levels of performance and available features. The right tier is essential to meet workload-specific requirements with all the features needed and avoid over- or under-provisioning. There are certain features available only on specific SKUs so even if your performance data applies to lower SKU you might need some feature that is available on higher SKU. You must use your workload requirements to determine the most appropriate service tier. Cloud-native solutions lack historical data. You must define expected usage patterns and performance targets to select an appropriate starting SKU. It’s better to start with a smaller size and scale up as required than over-provision. Adjust the SKU if needed based on test results to achieve an optimal balance of cost and performance.

### Select how many regions to use

Use your reliability requirements, such as SLO, RPO, and RTO, to decide how many regions to use. For high availability or disaster recovery, multi-region deployments might be necessary. However, multi-region architectures can introduce complexity around data replication, latency, and data residency regulations. Work with your compliance team to ensure your regional strategy meets any legal or regulatory obligations.

## Document architecture

Develop design document or architecture diagram that outlines the solution. This architecture should include the chosen Azure services, SKUs, and data or user flows. It could include key design decisions and their justifications/trade-offs, and any critical nonfunctional requirements (such as compliance needs, latency expectations, or throughput targets) that influenced the design. Having this documentation facilitates stakeholder alignment, accelerates design reviews, and guides the implementation team.

## Plan deployment strategy

A deployment strategy defines how to introduce a new workload or feature into production with minimal risk and maximum reliability. Selecting the right strategy ensures consistent delivery, enables rollback, and supports validation at each stage.

### Use development best practices

Follow [DevOps](/azure/well-architected/operational-excellence/devops-culture) principles. Formalize [operational tasks](/azure/well-architected/operational-excellence/formalize-operations-tasks) by using documentation, checklists, or automation. Formalize [software development processes](/well-architected/operational-excellence/formalize-development-practices).

### Plan deployment for a new workload

1. **Use progressive exposure.** For the production launch of a new workload, consider a canary deployment. Release the new workload to a small subset of users or a pilot environment first, verify everything works as expected, then gradually ramp up to full production. This approach limits the blast radius of any unforeseen issues in the initial release.

1. **Document operational procedures and escalation paths.** Documentation enables the support team to manage the workload effectively  Include procedures for restarting services, accessing logs, handling common issues, and escalating incidents. Store documentation in a central, accessible location such as a SharePoint site, Azure DevOps Wiki, or GitHub repository. By planning the handover, you ensure a smooth transition from development to steady-state operations with no gaps in accountability.

### Plan deployment for new features

1. **Use in-place updates for minor or backward-compatible changes.** Deploy the feature incrementally using rolling updates or feature flags. Start with a small percentage of users or a limited number of instances. Monitor system metrics and logs to validate stability before expanding the rollout. This approach minimizes user effects and supports fast rollback.

1. **Use parallel (blue-green) deployments for larger or riskier changes.** Deploy the updated version alongside the current version in a separate environment. Route a small portion of live traffic to the new version to validate performance and behavior. If successful, shift all traffic to the new version and decommission the old one. If issues arise, revert traffic to the original version instantly. This strategy ensures zero-downtime deployment and simplifies rollback.

1. **Plan for new feature integration.** When adding new features to existing applications, use your organization's change management process to control and record production changes. Define rollback procedures in advance by documenting how to revert application versions, disable feature flags, or restore database backups to minimize downtime if issues occur. Secure approval from key stakeholders and product owners before deployment to ensure the feature meets requirements and aligns with business readiness.

1. Plan for operational handover. For new apps and workloads, decide who should operate and support the new solution once it’s live in production. Assign a team, such as operations team, DevOps team, or product team. Define the support model, such as 24/7 on-call rotation and business-hours support. Ensure all stakeholders understand their roles. This clarity enables fast response to incidents and ensures continuity of service.

1. **Define ownership and support responsibilities.** For new features, ensure the current operations team is ready for the new feature and expanded responsibilities. 

1. Update operational procedures and escalation paths.** Update any new operational procedures and escalation paths.

## Next step

> [!div class="nextstepaction"]
> [Build the new solution](./build-cloud-native-solutions.md)