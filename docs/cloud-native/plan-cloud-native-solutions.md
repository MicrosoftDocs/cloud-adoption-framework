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

## Align business objectives with solution goals

A clear set of business objectives ensures that cloud-native solutions, whether new workloads or new features, deliver measurable business value. This alignment helps prioritize technical decisions and maintain stakeholder focus throughout the planning process.

1. **Define business goals for the cloud-native solution.**  Identify the specific business outcomes the solution must support. For new workloads, define goals such as enabling a new digital product, entering a new market, or modernizing a legacy process. For new features, define goals such as improving customer experience, reducing operational costs, or increasing system scalability. Use measurable indicators like revenue growth, time-to-market, or support ticket volume to quantify success.

2. **Identify constraints and success criteria.** Document any business constraints such as budget, compliance, or delivery timelines. Define what success looks like for each goal. For example, “launch a new customer portal by Q4” or “reduce checkout latency by 40%.” These criteria guide prioritization and help evaluate tradeoffs during planning.

3. **Validate stakeholder alignment.** Confirm that all stakeholders agree on the business goals, constraints, and success criteria. Use workshops, review sessions, or documented sign-off to ensure alignment. This step reduces rework and ensures shared expectations across business and technical teams.

## Define requirements for cloud-native solution

1. **Document functional requirements.** Functional requirements describe the capabilities, features, and behaviors the system must provide to meet user needs. Each requirement must directly support a business goal such as revenue growth, cost reduction, customer experience improvement, or market expansion. Use stakeholder interviews and business strategy documents to identify high-value outcomes. Prioritize features based on business impact and technical feasibility. Trace each requirement to a measurable business objective to justify its inclusion.

1. **Establish nonfunctional requirements.** Nonfunctional requirements define technical requirements to meet functional requirements and governance. Define target [reliability metrics](/azure/well-architected/reliability/metrics) like service level objectives (SLOs) for uptime, recovery point objectives (RPOs), and recovery time objectives (RTOs). Establish a [security baseline](/azure/well-architected/security/establish-baseline). Create [cost model](/azure/well-architected/cost-optimization/cost-model). Set [performance targets](/azure/well-architected/performance-efficiency/performance-targets).

1. **Control scope cloud-native solutions.** A well-defined scope prevents feature creep and ensures the solution delivers the most valuable outcomes within time and budget constraints. Document scope boundaries and explicitly list what is in and out of scope. Establish a structured change control process to evaluate new requests. Approve only those changes that directly support project goals and can be delivered without compromising the timeline or budget. Maintain a separate backlog for future enhancements and communicate scope decisions in regular stakeholder updates.

## Plan the cloud-native architecture

A cloud-native architecture must align with proven design principles and organizational requirements. This alignment ensures the solution is scalable, secure, cost-effective, and operationally efficient.

### Use the Azure Architecture Center to explore cloud-native solutions

The [Azure Architecture Center](/azure/architecture/browse/) provides validated reference architectures for common workloads. These architectures help accelerate design decisions and reduce risk. Make sure you know the [architecture fundamentals](azure/architecture/guide/) and [best pratices](/azure/architecture/best-practices/index-best-practices). Review the different architecture styles like [microservices](/azure/architecture/guide/architecture-styles/) and [web-queue worker](/azure/architecture/guide/architecture-styles/web-queue-worker). Ensure to use [cloud design patterns](/azure/architecture/patterns/) in your architecture to facilitate cloud-native design.

### Apply the Well-Architected Framework to guide cloud-native design decisions

The [Well-Architected Framework's](/azure/well-architected/pillars) defines five pillars that support high-quality cloud-native solutions.
Integrate reliability, security, performance efficiency, cost optimization, and operational excellence into the architecture from the start.
Use the framework to identify trade-offs and avoid technical debt during implementation.

## Evaluate integration requirements

A cloud-native solution must integrate with existing systems and organizational processes. Early evaluation of integration points reduces delivery risk and improves operational readiness. Evaluate integration requirements and ecosystem compatibility. Assess how the new services and components integrate with existing systems and toolchains. Identify dependencies on Microsoft Entra ID, virtual networks, hybrid connections, and other shared services. Confirm compatibility with existing toolchains and operational processes. Document APIs, authentication mechanisms, and data feeds early in the design process.

### Select Azure services

Use [Azure’s decision guides](/azure/architecture/guide/technology-choices/technology-choices-overview) to select appropriate services. Prefer platform-as-a-service (PaaS) offerings whenever possible. PaaS offerings reduce operational overhead by abstracting away infrastructure management. See also [Recommendations for selecting the right services](/azure/well-architected/performance-efficiency/select-services).

### Select the service tier (SKU)

Each Azure service offers multiple service tiers (also known as SKUs) that provide different levels of performance and available features. The right tier is essential to meet workload-specific requirements with all the features needed and avoid over- or under-provisioning. For some services, certain features are only available specific SKUs. So even if your performance allows a lower SKU, you might need some feature that is available on higher SKU. Use your workload requirements to determine the most appropriate service tier. Cloud-native solutions lack historical data. You must define expected usage patterns and performance targets to select an appropriate starting SKU. It’s better to start with a smaller size and scale up as required than over-provision. Adjust the SKU if needed based on test results to achieve an optimal balance of cost and performance.

### Select how many regions to use

Use your reliability requirements, such as SLO, RPO, and RTO, to decide how many regions to use. For high availability or disaster recovery, multi-region deployments might be necessary. However, multi-region architectures can introduce complexity around data replication, latency, and data residency regulations. Work with your compliance team to ensure your regional strategy meets any legal or regulatory obligations.

## Document architecture

Create a design document or architecture diagram. Documentation provides a shared understanding of the solution. Include selected Azure services, SKUs, data flows, and user interactions. Record key design decisions, trade-offs, and nonfunctional requirements. Use the documentation to guide implementation and support design reviews.

## Plan deployment strategy

A deployment strategy defines how to introduce a new workload or feature into production with minimal risk and maximum reliability. Selecting the right strategy ensures consistent delivery, enables rollback, and supports validation at each stage.

### Use development best practices

Development practices ensure consistent delivery and operational readiness across environments. These practices reduce deployment risk and improve team coordination.

1. **Follow [DevOps](/azure/well-architected/operational-excellence/devops-culture) principles.** DevOps practices promote collaboration between development and operations teams. Use automation, version control, and continuous integration/continuous delivery (CI/CD) pipelines to streamline deployments.

1. **Formalize [operational tasks](/azure/well-architected/operational-excellence/formalize-operations-tasks) to improve support readiness.** Operational tasks include monitoring, alerting, and incident response. Document these tasks using checklists or automation scripts.

1. **Formalize [software development processes](/well-architected/operational-excellence/formalize-development-practices) to improve code quality and traceability.** Development processes include coding standards, peer reviews, and testing.

### Plan deployment for a new workload

1. **Use progressive exposure.** Progressive exposure limits the impact of unforeseen issues. Use canary deployments to release the workload to a small subset of users or a pilot environment. Monitor performance and user feedback before expanding to full production. For more information, see [WAF - Adopt a progressive exposure model](/azure/well-architected/operational-excellence/safe-deployments#adopt-a-progressive-exposure-model).

1. **Document operational procedures and escalation paths.** Clear documentation enables support teams to manage the workload effectively. Include procedures for restarting services, accessing logs, handling common issues, and escalating incidents. Store documentation in a central location such as SharePoint, Azure DevOps Wiki, or GitHub.

### Plan deployment for new features

1. **Use in-place updates for minor or backward-compatible changes.** An in-place update uses the existing production environment to deploy new features. Use rolling updates or feature flags to deploy incrementally. Start with a small percentage of users or a limited number of instances. Monitor system metrics and logs to validate stability before full rollout. This approach minimizes user effects and supports fast rollback.

1. **Use parallel (blue-green) deployments for larger or riskier changes.** Deploy the updated version alongside the current version in a separate environment. Route a small portion of live traffic to the new version to validate performance and behavior. If successful, shift all traffic to the new version and decommission the old one. If issues arise, revert traffic to the original version instantly. This strategy ensures zero-downtime deployment and simplifies rollback.

1. **Plan for new feature integration.** When adding new features to existing applications, use your organization's change management process to control and record production changes. Define rollback procedures in advance by documenting how to revert application versions, disable feature flags, or restore database backups to minimize downtime if issues occur. Secure approval from key stakeholders and product owners before deployment to ensure the feature meets requirements and aligns with business readiness.

1. **Plan for operational handover.** For new apps and workloads, decide who should operate and support the new solution once it’s live in production. Assign a team, such as operations team, DevOps team, or product team. Define the support model, such as 24/7 on-call rotation and business-hours support. Ensure all stakeholders understand their roles. This clarity enables fast response to incidents and ensures continuity of service.

1. **Define ownership and support responsibilities.** Ownership ensures accountability and fast incident response. Confirm that the operations team is prepared to support the new feature. Update documentation and escalation paths to reflect new responsibilities.

## Next step

> [!div class="nextstepaction"]
> [Build the new solution](./build-cloud-native-solutions.md)