---
title: Plan the cloud-native solution
description: Plan the cloud-native solution
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan the cloud-native solution

A cloud-native solution creates new business value by building new applications or adding new features to existing ones. Cloud-native solutions typically use modern architecture patterns, like microservices and event-driven design. It uses cloud-managed services and containerization, and embraces DevOps practices for rapid, reliable delivery. This guidance helps you deliver cloud-native workloads quickly and effectively by aligning technical efforts with business goals and following a clear, repeatable process.

**Prerequisites:** [Azure landing zone](/azure/cloud-adoption-framework/ready)

## Define business objectives for cloud-native solution

1. **Define business goals for the cloud-native solution.**  Identify the specific business outcomes the solution must support. For new workloads, define goals such as enabling a new digital product, entering a new market, or modernizing a legacy process. For new features, define goals such as improving customer experience, reducing operational costs, or increasing system scalability. Use measurable indicators like revenue growth, time-to-market, or support ticket volume to quantify success.

2. **Identify constraints and success criteria.** Document any business constraints such as budget, compliance, or delivery timelines. Define what success looks like for each goal. For example, “launch a new customer portal by Q4” or “reduce checkout latency by 40%.” These criteria guide prioritization and help evaluate tradeoffs during planning.

3. **Validate stakeholder alignment.** Confirm that all stakeholders agree on the business goals, constraints, and success criteria. Use workshops, review sessions, or documented sign-off to ensure alignment. This step reduces rework and ensures shared expectations across business and technical teams.

## Define requirements for cloud-native solution

1. **Document functional requirements.** Functional requirements describe the capabilities, features, and behaviors the system must provide to meet user needs. Each requirement must directly support a business goal such as revenue growth, cost reduction, customer experience improvement, or market expansion. Use stakeholder interviews and business strategy documents to identify high-value outcomes. Prioritize features based on business impact and technical feasibility. Trace each requirement to a measurable business objective to justify its inclusion.

1. **Establish nonfunctional requirements.** Nonfunctional requirements define technical requirements to meet functional requirements and governance. Define target [reliability metrics](/azure/well-architected/reliability/metrics) like service level objectives (SLOs) for uptime, recovery point objectives (RPOs), and recovery time objectives (RTOs). Establish a [security baseline](/azure/well-architected/security/establish-baseline). Create [cost model](/azure/well-architected/cost-optimization/cost-model). Set [performance targets](/azure/well-architected/performance-efficiency/performance-targets).

1. **Control scope cloud-native solutions.** A well-defined scope prevents feature creep and ensures the solution delivers the most valuable outcomes within time and budget constraints. Document scope boundaries and explicitly list what is in and out of scope. Establish a structured change control process to evaluate new requests. Approve only those changes that directly support project goals and can be delivered without compromising the timeline or budget. Maintain a separate backlog for future enhancements and communicate scope decisions in regular stakeholder updates.

## Plan the cloud-native architecture

A cloud-native architecture must align with proven design principles and organizational requirements. This alignment ensures the solution is scalable, secure, cost-effective, and operationally efficient.

### Explore validated cloud-native architectures

1. **Review architecture fundamentals and best practices.** The [Azure Architecture Center](/azure/architecture/browse/) to explore validated reference architectures for common workloads. These architectures help accelerate design decisions and reduce risk. Understand [architecture fundamentals](/azure/architecture/guide/) and [best practices](/azure/architecture/best-practices/index-best-practices). 

1. **Select an appropriate architecture style.** Choose from styles such as [microservices](/azure/architecture/guide/architecture-styles/) and [web-queue worker](/azure/architecture/guide/architecture-styles/web-queue-worker) based on workload characteristics. Each style supports different scalability, resilience, and operational models.

1. **Apply cloud design patterns.** Use [cloud design patterns](/azure/architecture/patterns/) in your architecture to facilitate cloud-native design.

### Apply the Well-Architected Framework

1. **Integrate the five pillars into design decisions.** Use the [Well-Architected Framework's](/azure/well-architected/pillars) to guide decisions across reliability, security, performance efficiency, cost optimization, and operational excellence.

1. **Use the framework to evaluate trade-offs.** Identify potential risks and technical debt early. Document trade-offs to support informed decision-making and future reviews.

### Evaluate integration requirements

1. **Identify integration points early.** Assess how new services interact with existing systems, including APIs, authentication, and data flows. Integration planning ensures compatibility with existing systems and reduces delivery risk.

1. **Assess dependencies on shared services.** Confirm compatibility with Microsoft Entra ID, virtual networks, hybrid connections, and other shared services.

1. **Validate toolchain compatibility.** Ensure the architecture aligns with existing CI/CD pipelines, monitoring tools, and operational processes.

### Select appropriate Azure services

1. **Use decision guides to evaluate services.** Refer to [Azure’s decision guides](/azure/architecture/guide/technology-choices/technology-choices-overview) to compare services based on workload needs.

1. **Prefer platform-as-a-service (PaaS).** PaaS offerings reduce operational overhead by abstracting away infrastructure management. See also [Recommendations for selecting the right services](/azure/well-architected/performance-efficiency/select-services).

### Select the appropriate service tier (SKU)

1. **Define workload requirements and usage patterns.** The right SKU ensures performance and feature alignment without over-provisioning. Estimate expected load and performance targets to select a starting SKU.

1. **Start with a smaller SKU and scale as needed.** Avoid over-provisioning by testing and adjusting based on actual performance.

1. **Validate feature availability by SKU.** Some features are only available in higher SKUs. Ensure the selected tier supports all required capabilities.

### Select how many regions to use

1. **Use reliability targets to guide regional strategy.** Regional strategy affects availability, compliance, and complexity. Define service-level objectives (SLO), recovery point objectives (RPO), and recovery time objectives (RTO) to determine regional requirements.

2. **Evaluate trade-offs of multi-region deployments.** Multi-region architectures improve availability but increase complexity in data replication, latency, and compliance.

3. **Confirm compliance with data residency regulations.** Work with legal and compliance teams to ensure regional choices meet regulatory obligations.

### Document architecture

1. **Create a detailed architecture diagram and design document.** Documentation supports implementation, review, and future maintenance. Include selected Azure services, SKUs, data flows, and user interactions. Ensure the diagram provides a clear visual representation of the architecture to support implementation and reviews.

2. **Record key design decisions and trade-offs.** Document the rationale behind architectural choices, including nonfunctional requirements such as reliability, security, and performance. Highlight any trade-offs made to balance competing priorities.

3. **Use documentation to support implementation and reviews.** Ensure the design document is comprehensive and accessible to all stakeholders. This documentation fosters a shared understanding of the architecture and serves as a reference during development and future reviews.

## Plan deployment strategy

A deployment strategy defines how to introduce a new workload or feature into production with minimal risk and maximum reliability. Selecting the right strategy ensures consistent delivery, enables rollback, and supports validation at each stage.

### Use development best practices

Development practices ensure consistent delivery and operational readiness across environments. These practices reduce deployment risk and improve team coordination.

1. **Follow [DevOps](/azure/well-architected/operational-excellence/devops-culture) principles.**  DevOps practices align development and operations teams through automation, version control, and CI/CD pipelines. Use tools like Azure DevOps or GitHub Actions to automate build, test, and deployment workflows. This approach reduces manual errors and accelerates release cycles.

1. **Formalize [operational tasks](/azure/well-architected/operational-excellence/formalize-operations-tasks) to improve support readiness.** Operational tasks include monitoring, alerting, and incident response. Document these tasks using runbooks or automation scripts. Store them in a central location such as Azure DevOps Wiki or GitHub to ensure accessibility and consistency.

1. **Formalize [software development processes](/well-architected/operational-excellence/formalize-development-practices) to improve code quality and traceability.** Use coding standards, peer reviews, and automated testing to ensure traceability and maintainability. Integrate these practices into your CI/CD pipeline to enforce quality gates before deployment.

### Plan deployment for a new workload

1. **Use progressive exposure to limit impact.** Progressive exposure limits the impact of unforeseen issues. Use canary deployments to release the workload to a small subset of users or a pilot environment. Monitor performance and user feedback before expanding to full production. For more information, see [WAF - Adopt a progressive exposure model](/azure/well-architected/operational-excellence/safe-deployments#adopt-a-progressive-exposure-model).

1. **Document operational procedures and escalation paths.** Create clear documentation for restarting services, accessing logs, handling common issues, and escalating incidents. Store this documentation in a shared repository such as SharePoint or GitHub to ensure availability for support teams.

### Plan deployment for new features

1. **Plan for new feature integration using change management.** Follow your organization’s change management process to control and document production changes. Define rollback procedures, such as reverting application versions or restoring database backups. Secure stakeholder approval before deployment to ensure alignment with business goals. For more information, see [Manage change](/azure/cloud-adoption-framework/manage/administer#manage-change) in CAF.

1. **Use in-place updates for minor or backward-compatible changes.** Deploy updates directly to the production environment using rolling updates or feature flags. Start with a small percentage of users or instances. Monitor system metrics and logs to validate stability before full rollout.

1. **Use parallel (blue-green) deployments for major or high-risk changes.** Deploy the new version in a separate environment. Route a small portion of live traffic to the new version to validate behavior. If successful, shift all traffic to the new version. If issues arise, revert traffic to the original version to ensure continuity.

1. **Plan for operational handover for new workloads.** Identify the team responsible for operating and supporting the solution post-deployment. Define the support model (e.g., 24/7 on-call or business-hours support) and ensure all stakeholders understand their roles.

1. **Define ownership and support responsibilities.** Confirm that the operations team is prepared to support the new feature. Update documentation and escalation paths to reflect new responsibilities and ensure fast incident response.

## Define rollback plan for cloud-native solutions

[!INCLUDE [Steps to define a rollback plan](../includes/define-rollback-plan.md)]

## Next step

> [!div class="nextstepaction"]
> [Build the new solution](./build-cloud-native-solutions.md)