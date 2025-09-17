---
title: Plan the cloud-native solutions
description: Plan cloud-native Azure apps with proven strategies for business goals, architecture design, service selection, and deployment automation.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan the cloud-native solutions

A cloud-native solution creates new business value by building new workloads (applications) or adding new features to existing workloads. Whether you're developing a brand-new application or adding new features to an existing system, cloud-native development is a journey through planning, building, deploying, and optimizing your workloads. This framework provides end-to-end guidance to ensure your cloud-native application is aligned with business goals, well-architected, and delivered with minimal risk.

**Prerequisites:** [Azure landing zone](/azure/cloud-adoption-framework/ready)

:::image type="complex" source="./images/cloud-native-process.png" alt-text="Diagram showing Microsoft and Azure services with decision points for each service." lightbox="./images/cloud-native-process.png" border="false":::
    On the left, three labeled boxes, Startups, Enterprises, and Existing workloads, are grouped under the heading "Create new business value." Arrows lead from these boxes to a vertical sequence of four steps: 1 Plan cloud-native, 2 Build cloud-native, 3 Deploy cloud-native, and 4 Optimize cloud-native. A final arrow points to an Azure indicated it's where "Cloud-native apps, workloads, & features" live.
:::image-end:::

## Define business objectives for cloud-native solutions

1. **Start with clear business goals.**  Define the specific outcomes your cloud-native solution should achieve, such as enabling a new digital product, entering a new market, improving customer experience, or reducing operational costs. Use measurable indicators like revenue growth, time-to-market reduction, or support ticket volume to quantify success. For new features, define goals such as improving customer experience, reducing operational costs, or increasing system scalability.

2. **Identify constraints and success criteria.** Document any business constraints such as budget, compliance, or delivery timelines. Define what success looks like for each goal. For example, "launch a new customer portal by Q4" or "reduce checkout latency by 40%." These criteria guide prioritization and help evaluate tradeoffs during planning.

3. **Validate stakeholder alignment.** Confirm all stakeholders (business and technical) agree on the goals, constraints, and what success looks like. This alignment might involve workshops or formal sign-offs. Early alignment prevents later miscommunication and avoids costly rework, ensuring everyone shares the same expectations from the start.

## Define requirements for cloud-native solutions

1. **Document functional requirements.** Document the capabilities and features the system must provide to meet user needs. Each requirement should tie back to a business objective, ensuring the development effort directly supports desired outcomes. Use stakeholder interviews and business strategy documents to identify high-value outcomes. Prioritize features based on business value and technical feasibility. Trace each requirement to a measurable business objective to justify its inclusion.

1. **Establish nonfunctional requirements.** Nonfunctional requirements define technical requirements to meet functional requirements and governance. Establish the quality attributes and technical targets needed to support those features. Define target [reliability metrics](/azure/well-architected/reliability/metrics) like service level objectives (SLOs) for uptime, recovery point objectives (RPOs), and recovery time objectives (RTOs). Establish a [security baseline](/azure/well-architected/security/establish-baseline). Create [cost model](/azure/well-architected/cost-optimization/cost-model). Set [performance targets](/azure/well-architected/performance-efficiency/performance-targets).

1. **Control scope cloud-native solutions.** Clearly define what is in-scope vs out-of-scope for the initial release. It’s tempting to include more "nice to have" features, but scope creep can jeopardize timelines and budgets. Document the boundaries of your solution and implement a change control process for any new requests. Only approve changes that directly support the defined goals and that can be delivered without undermining the schedule or budget. Defer lower-priority ideas to a future backlog. Rigorously managing scope keeps the team focused on delivering the most valuable functionality first within constraints.

## Plan the cloud-native architectures

A well-planned architecture is critical to meeting your goals and requirements. Every major architectural decision involves trade-offs in scalability, complexity, cost, and agility. The following steps and decision points help you craft a cloud-native design aligned with best practices:

### Explore validated cloud-native architectures

1. **Review architecture fundamentals and best practices.** Before inventing an architecture from scratch, review validated reference architectures and fundamentals from the [Azure Architecture Center](/azure/architecture/browse/). Familiar architectural styles include to explore validated reference architectures for common workloads. These architectures help accelerate design decisions and reduce risk.

1. **Select an appropriate architecture style.** Choose an [architecture style](/azure/architecture/guide/architecture-styles/) based on your workload’s characteristics and team capabilities. Architecture styles include N-tier (monolithic), microservices, event-driven (message-based), web-queue-worker. For example, if you need rapid development for a relatively simple application, a well-structured N-tier monolith might suffice. For a large-scale or rapidly evolving application with distinct domains, microservices or event-driven approaches offer flexibility (at the cost of complexity). In practice, many systems end up with a hybrid style. For example, there's a microservices core with some shared services or an event-driven subsystem. The key is understanding the trade-offs of each style and selecting the approach that best meets your scalability, resilience, and agility requirements.

1. **Apply design best practices.** No matter which style you pick, adhere to cloud [architecture fundamentals](/azure/architecture/guide/) and [best practices](/azure/architecture/best-practices/index-best-practices). The Azure Architecture Center provides a catalog of [cloud design patterns](/azure/architecture/patterns/) (Retry, Circuit Breaker, CQRS) which address common challenges in distributed workloads. Integrating these patterns into your design can improve reliability and performance.

1. **Integrate the five pillars into design decisions.** Use the [Well-Architected Framework's](/azure/well-architected/pillars) to guide decisions across reliability, security, performance efficiency, cost optimization, and operational excellence. These five pillars should inform all design decisions. For example, when choosing a database, consider reliability (redundancy, backup), performance, and cost together to strike the right balance. Document where you make trade-offs between pillars, such as more cost for higher performance. These notes are valuable for future governance and reviews.

### Plan integrations with existing systems

1. **Inventory all dependent systems and services.** New cloud-native solutions rarely operate in isolation, unless you're an early-stage startup. Consider how your new workload or feature fits into the environment. Map out data flows and ensure compatibility with standards. Create a comprehensive list of all systems your workload interacts with. This list includes internal APIs, databases, identity providers (Microsoft Entra ID), monitoring tools, CI/CD pipelines, and on-premises systems accessed via VPN or ExpressRoute. Use architecture diagrams and dependency maps to visualize these relationships.

2. **Classify integration types and protocols.** Categorize each integration point by type (authentication, data exchange, messaging) and protocol (REST, gRPC, ODBC, SAML, OAuth2). This classification helps identify compatibility requirements and potential bottlenecks.

3. **Validate identity and access integration.** Ensure your solution integrates with the organization's identity provider. For example, use Microsoft Entra ID for authentication and authorization instead of introducing a new identity system. Confirm support for single sign-on (SSO), role-based access control (RBAC), and conditional access policies.

4. **Assess network connectivity and security.** Review how your workload connects to other systems. Validate firewall rules, DNS resolution, and routing paths. For hybrid scenarios, confirm ExpressRoute or VPN configurations are in place and tested. Use Azure Network Watcher to monitor and troubleshoot connectivity.

5. **Ensure data flow compatibility and compliance.** Map out data flows between systems. Confirm data formats, schemas, and transformation requirements. Ensure compliance with data residency, encryption, and retention policies.

6. **Test integration points early and continuously.** Perform integration testing during early development stages. Use mocks or stubs for unavailable systems. Automate these tests in your CI/CD pipeline using tools like Azure DevOps or GitHub Actions. Monitor for latency, throughput, and error rates. For example, you want to avoid an API your app depends on not supporting the required load or a network firewall blocking your service.

7. **Document integration contracts and SLAs.** Define and document the expected behavior, availability, and performance of each integration point. Include retry logic, timeout settings, and fallback mechanisms. Align with service-level agreements (SLAs) of dependent systems.

### Select appropriate Azure services and service tiers

1. **Use decision guides to select services that match workload requirements.** Azure provides multiple options to run your application code, each with pros and cons. Review the [technology choices overview](/azure/architecture/guide/technology-choices/technology-choices-overview) to identify services that align with your functional and nonfunctional requirements. Prioritize platform-as-a-service (PaaS) options because these services reduce operational overhead by handling infrastructure management, patching, and scaling automatically.

2. **Define usage patterns and performance requirements to select service tiers.** Service tier selection affects both cost and capability. Document expected transaction volumes, concurrent user loads, storage requirements, and performance targets such as response times and throughput. Use these metrics to select an initial service tier (SKU) that meets baseline requirements without significant over-provisioning. Plan to adjust tiers based on actual usage patterns after deployment.

3. **Validate feature compatibility across selected service tiers.** Critical features such as advanced security capabilities, high availability options, or integration APIs vary by service tier. Create a feature matrix that maps required capabilities to available SKUs. Ensure the selected tier supports all necessary features to avoid costly migrations or architectural changes later. Reference [service-specific documentation](/azure/well-architected/performance-efficiency/select-services) to confirm feature availability and limitations.

### Select how many regions to use

1. **Evaluate trade-offs of multi-region deployments.** Single-region architectures are simpler and cheaper, but a regional outage would bring down your app. Multi-region deployments can achieve higher availability (one region can fail and users are served from another) and can also improve performance by serving users from the nearest region. The trade-off is increased complexity in deployment and data synchronization. You must handle data replication across regions with potential consistency issues, global traffic routing, and higher costs. Let your reliability requirements drive this decision.

1. **Use reliability targets to guide regional strategy.** Define service-level objectives (SLO), recovery point objectives (RPO), and recovery time objectives (RTO) to determine regional requirements.

1. **Confirm compliance with data residency regulations.** Work with legal and compliance teams to ensure regional choices meet regulatory obligations.

### Document architectures

1. **Create a detailed architecture diagram and design document.** Documentation supports implementation, review, and future maintenance. Include selected Azure services, SKUs, data flows, and user interactions. Ensure the diagram provides a clear visual representation of the architecture to support implementation and reviews.

2. **Record key design decisions and trade-offs.** Document the rationale behind architectural choices, including nonfunctional requirements such as reliability, security, and performance. Highlight any trade-offs made to balance competing priorities.

## Plan the cloud-native deployment strategy

When you deploy the cloud-native solution to production, follow a planned strategy rather than an ad-hoc push. A solid deployment plan minimizes the effects on users and provides ways to recover if something goes wrong.

### Plan development and deployment practices

Development and deployment practices ensure consistent delivery and operational readiness across environments. These practices reduce deployment risk and improve team coordination.

1. **Establish [DevOps](/azure/well-architected/operational-excellence/devops-culture) practices for deployment automation.** DevOps practices align development and operations teams through automation, version control, and CI/CD pipelines. Use tools like Azure DevOps or GitHub Actions to automate build, test, and deployment workflows. This approach reduces manual errors, accelerates release cycles, and provides consistent deployment processes across environments.

1. **Plan [operational readiness](/azure/well-architected/operational-excellence/formalize-operations-tasks) to support deployment activities.** Operational readiness includes monitoring, alerting, and incident response procedures for deployment scenarios. Document deployment runbooks and automation scripts that cover rollback procedures, health checks, and troubleshooting steps. Store these resources in a central location such as Azure DevOps Wiki or GitHub to ensure accessibility during deployment activities.

1. **Define [development practices](/azure/well-architected/operational-excellence/formalize-development-practices) that support reliable deployments.** Use coding standards, peer reviews, and automated testing to ensure code quality and deployment readiness. Integrate these practices into your CI/CD pipeline to enforce quality gates before deployment. Include deployment-specific tests such as integration tests, smoke tests, and performance validation to verify system readiness for production.

### Plan deployment for new workloads

1. **Use progressive exposure to limit impact.** For a new application (greenfield) with no existing users, you should do a soft launch. Deploy to production but expose it only to internal users or a pilot group initially. This approach is a canary deployment for a new workload. If it’s truly brand new and isolated, a one-time deployment to full production is possible, but progressive exposure is still recommended to catch any issues in a controlled way. Don’t unleash the system on 100% of users on day one without some real-world validation first. For more information, see [WAF - Adopt a progressive exposure model](/azure/well-architected/operational-excellence/safe-deployments#adopt-a-progressive-exposure-model).

1. **Document operational procedures and escalation paths.** Create clear documentation for restarting services, accessing logs, handling common issues, and escalating incidents. Store this documentation in a shared repository such as SharePoint or GitHub to ensure availability for support teams.

### Plan deployment for new features

1. **Plan for new feature integration using change management.** Follow your organization’s change management process to control and document production changes. Define rollback procedures, such as reverting application versions or restoring database backups. Secure stakeholder approval before deployment to ensure alignment with business goals. For more information, see [Manage change](/azure/cloud-adoption-framework/manage/administer#manage-change) in CAF.

1. **Use in-place updates for minor or backward-compatible changes.** Deploy updates directly to the production environment using rolling updates or feature flags. Start with a small percentage of users or instances. Monitor system metrics and logs to validate stability before full rollout.

1. **Use parallel (blue-green) deployments for major or high-risk changes.** Deploy the new version in a separate environment. Route a small portion of live traffic to the new version to validate behavior. If successful, shift all traffic to the new version. If issues arise, revert traffic to the original version to ensure continuity.

1. **Plan for operational handover for new workloads.** Identify the team responsible for operating and supporting the solution post-deployment. Define the support model (24/7 on-call or business-hours support) and ensure all stakeholders understand their roles.

1. **Define ownership and support responsibilities.** Confirm that the operations team is prepared to support the new feature. Update documentation and escalation paths to reflect new responsibilities and ensure fast incident response.

## Define rollback plan for cloud-native solutions

[!INCLUDE [Steps to define a rollback plan](../includes/define-rollback-plan.md)]

## Next step

> [!div class="nextstepaction"]
> [Build the new solution](./build-cloud-native-solutions.md)
