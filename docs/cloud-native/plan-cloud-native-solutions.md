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

### Plan integration with existing systems

1. **Identify all system integration points.** Modern cloud-native solutions must connect with existing systems through APIs, authentication services, data stores, and network infrastructure. Document each integration point and map data flows between systems. Assess the current state of existing APIs to determine if modifications are necessary. This analysis prevents integration surprises during development and ensures smooth system interoperability.

2. **Validate compatibility with shared enterprise services.** Enterprise environments rely on shared services such as Microsoft Entra ID for authentication, virtual networks for connectivity, and hybrid connections for on-premises integration. Confirm that your architecture design supports these existing services without requiring modifications. Test authentication flows and network connectivity early in the planning process to identify potential conflicts or configuration requirements.

3. **Ensure alignment with existing development and operations tools.** Cloud-native solutions must work within established toolchains for continuous integration, deployment, monitoring, and incident response. Review your CI/CD pipeline requirements and confirm compatibility with existing tools such as Azure DevOps, GitHub Actions, or Jenkins. Validate that monitoring and logging solutions can accommodate the new architecture without significant changes to operational processes.

### Select appropriate Azure services and service tiers

1. **Use decision guides to select services that match workload requirements.** Azure decision guides provide structured comparisons of services based on specific workload characteristics such as data volume, transaction patterns, and integration needs. Review the [technology choices overview](/azure/architecture/guide/technology-choices/technology-choices-overview) to identify services that align with your functional and nonfunctional requirements. Prioritize platform-as-a-service (PaaS) options because these services reduce operational overhead by handling infrastructure management, patching, and scaling automatically.

2. **Define usage patterns and performance requirements to select service tiers.** Service tier selection affects both cost and capability. Document expected transaction volumes, concurrent user loads, storage requirements, and performance targets such as response times and throughput. Use these metrics to select an initial SKU that meets baseline requirements without significant over-provisioning. Plan to adjust tiers based on actual usage patterns after deployment.

3. **Validate feature compatibility across selected service tiers.** Critical features such as advanced security capabilities, high availability options, or integration APIs vary by service tier. Create a feature matrix that maps required capabilities to available SKUs. Ensure the selected tier supports all necessary features to avoid costly migrations or architectural changes later. Reference [service-specific documentation](/azure/well-architected/performance-efficiency/select-services) to confirm feature availability and limitations.

### Select how many regions to use

1. **Use reliability targets to guide regional strategy.** Regional strategy affects availability, compliance, and complexity. Define service-level objectives (SLO), recovery point objectives (RPO), and recovery time objectives (RTO) to determine regional requirements.

2. **Evaluate trade-offs of multi-region deployments.** Multi-region architectures improve availability but increase complexity in data replication, latency, and compliance.

3. **Confirm compliance with data residency regulations.** Work with legal and compliance teams to ensure regional choices meet regulatory obligations.

### Document architecture

1. **Create a detailed architecture diagram and design document.** Documentation supports implementation, review, and future maintenance. Include selected Azure services, SKUs, data flows, and user interactions. Ensure the diagram provides a clear visual representation of the architecture to support implementation and reviews.

2. **Record key design decisions and trade-offs.** Document the rationale behind architectural choices, including nonfunctional requirements such as reliability, security, and performance. Highlight any trade-offs made to balance competing priorities.

## Plan deployment strategy

A deployment strategy defines how to introduce a new workload or feature into production with minimal risk and maximum reliability. Selecting the right strategy ensures consistent delivery, enables rollback, and supports validation at each stage.

### Plan development and deployment practices

Development and deployment practices ensure consistent delivery and operational readiness across environments. These practices reduce deployment risk and improve team coordination.

1. **Establish [DevOps](/azure/well-architected/operational-excellence/devops-culture) practices for deployment automation.** DevOps practices align development and operations teams through automation, version control, and CI/CD pipelines. Use tools like Azure DevOps or GitHub Actions to automate build, test, and deployment workflows. This approach reduces manual errors, accelerates release cycles, and provides consistent deployment processes across environments.

1. **Plan [operational readiness](/azure/well-architected/operational-excellence/formalize-operations-tasks) to support deployment activities.** Operational readiness includes monitoring, alerting, and incident response procedures for deployment scenarios. Document deployment runbooks and automation scripts that cover rollback procedures, health checks, and troubleshooting steps. Store these resources in a central location such as Azure DevOps Wiki or GitHub to ensure accessibility during deployment activities.

1. **Define [development practices](/well-architected/operational-excellence/formalize-development-practices) that support reliable deployments.** Use coding standards, peer reviews, and automated testing to ensure code quality and deployment readiness. Integrate these practices into your CI/CD pipeline to enforce quality gates before deployment. Include deployment-specific tests such as integration tests, smoke tests, and performance validation to verify system readiness for production.

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