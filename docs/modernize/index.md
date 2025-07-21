---
title: Modernize in the cloud
description: Modernize in cloud and maximize value. Modernization is a critical approach to cloud adoption that increases efficiency and exceed objectives.
author: stephen-sumner
ms.author: pnp
ms.date: 10/4/2022
ms.topic: conceptual
ms.custom: internal
---

**Required to modernization:** Azure modernization skills, [Workload inventory]

Modernization is making improvements to existing workloads. The goal is to better meet business needs in alignment with cloud best practices. Modernization doesn't bring direct functional benefit to end users, it can still improve the end user experience and internal operations. Modernization replatforming, refactoring, rearchitecting. These are modernizations efforts you can execute as part of a migration or in cloud. Not every workload needs to be modernized. Focus your efforts where modernization delivers clear, measurable value to end users (better performance, uptime) or internal (cost optimized, improved reliability, better security, easier maintenance).

### Define modernization for your organization

1. **Define modernization as a technical improvement to existing workloads.** Modernization is replatforming, refactoring, and rearchitecting. You can modernize as part of a migration or once in the cloud. This definition distinguishes modernization from feature development. You should use this definition to align stakeholders and prevent scope creep. A clear and shared definition of modernization ensures alignment across teams and avoids misaligned expectations. This definition helps prioritize efforts that improve performance, reliability, and maintainability without expanding scope into feature development.

2. **Establish modernization as a shared responsibility across teams.** Modernization spans architecture, development, operations, and security functions within the organization. This shared responsibility requires strong communication channels and leadership support to succeed. You should set up regular forums for collaboration and decision-making to ensure alignment across all teams.

## Identify modernization opportunities

A structured approach to identifying modernization candidates ensures that resources are focused on high-impact workloads. You should evaluate workloads based on technical debt, business value, and operational risk.

1. **Modernize when modernization delivers value.** Identify key business drivers and desired outcomes. Clear business drivers might include reducing operational costs, improving application performance for users, enhancing security, or enabling new features faster. Work with business leaders to list and prioritize these outcomes (for example, is cost savings more important than adding new capabilities?). This clarity ensures that technical decisions serve the business. It is important because modernization can take significant effort, and focusing on agreed goals (like “improve page load time by 50%” or “reduce infrastructure costs by 30%”) lets you measure success and justify the investment. Not every workload benefits equally from modernization. Modernization should not be automatic. Evaluate the opportunity cost of not modernizing, such as delayed features or security gaps—against the benefits. You should document this analysis to support decision-making. Focus on workloads that improve end-user experience or internal operations. See common reasons to modernize:

    - **Reduce technical debt:** Legacy systems accumulate complexity over time, making them harder and more expensive to maintain.  
    - **Enable growth:** Older architectures often limit scalability, performance, and integration with modern services.  
    - **Avoid end-of-life risks:** Many legacy platforms and open-source tools have limited support lifespans.  
    - **Stay competitive:** Platform-as-a-service solutions enable faster feature delivery, better user experiences, and improved security.
    - **Improve operations:** Adopt infrastructure-as-code (IaC) and continuous integration and continuous development (CI/CD).
    - **Cost optimization:** educe operational costs compared to migrate and can also reduce operational costs within IT support. The total cost of ownership might reduce which would be good for most customers.

2. **Empower workload teams to make informed modernization decisions.** Teams closest to the applications possess the deepest understanding of application requirements and technical constraints. These teams need training, resources, and appropriate access to evaluate modernization opportunities effectively. You should provide self-service capabilities and clear guidelines to enable autonomous decision-making while maintaining organizational standards.

3. **Provide decision-making frameworks for modernization choices.** Frameworks help teams evaluate when to refactor, replatform, or rearchitect based on technical and business factors. Clear guidance ensures consistent decision-making across different workload teams. You should provide checklists, templates, and reference architectures to guide these modernization decisions.

4. **Use the Well-Architected Framework to identify modernization candidates.** This framework highlights design gaps across five pillars: reliability, security, cost optimization, operational excellence, and performance efficiency. You should assess workloads against these pillars and flag those that fall short as candidates for modernization.

## Plan the modernization

A well-structured plan reduces risk and ensures modernization aligns with cloud design principles. You should define scope, prioritize workloads, and choose the right modernization technique.

### Manage modernization changes through formal processes

1. **Align modernization activities with change management policies.** A formal change management process ensures that modernization activities align with organizational governance and risk tolerance. Identify the approval workflows, risk thresholds, and deployment gates that apply to modernization efforts. This alignment ensures that modernization does not bypass governance controls. See [Manage change](/azure/cloud-adoption-framework/manage/administer#manage-change).

1. **Classify modernization changes by risk level.** Use risk-based classifications to determine the appropriate level of oversight. For example, containerizing a stateless service requires less scrutiny than rearchitecting a mission-critical database.

1. **Schedule changes to minimize business impact.** Coordinate modernization deployments during maintenance windows or low-usage periods to reduce operational risk.Coordinate modernization deployments during maintenance windows or low-usage periods to reduce operational risk.

3. Engage stakeholders and secure executive support. Stakeholder engagement means communicating the modernization plan and benefits to both technical teams and business executives. Present a concise case for each major change – for instance, explain that moving to a PaaS database will free the team from maintenance and improve uptime, or that refactoring a module will enable faster feature delivery. Be transparent about costs, timelines, and risks. You should obtain buy-in by showing how the modernization aligns with business strategy (such as enabling expansion into new markets or improving customer satisfaction scores). This support is important to ensure necessary resources are provided and to overcome resistance to change.

4. Define clear success metrics and track them. Establish metrics for each objective; for example, operational cost per month (for cost reduction), average response time or scalability metrics (for performance improvement), deployment frequency (for agility improvements), or compliance audit scores (for security enhancements). You should measure baseline values before modernization and set target values to achieve after modernization. Tracking these metrics during and after the project will show if you’re meeting your goals and alert you if adjustments are needed. This is important to demonstrate the value of the modernization effort and guide decision-making (e.g., if a particular change isn’t yielding the expected improvement, you might pivot or invest more in that area).

### Prioritize modernization efforts

1. **Start with low-risk modernizations.** Prioritization ensures that teams focus on workloads that deliver the most value or provide early validation of the modernization approach. Choose workloads with minimal dependencies and clear business value to validate your approach early.

2. **Prioritize high-impact modernizations when deadlines require it.** If business timelines demand it, modernize complex workloads first, but ensure that the team has the necessary skills and support.

3. **Prevent modernization scope creep.** Document the modernization scope in a project charter. A well-defined scope ensures that modernization focuses on technical improvements rather than feature expansion. Expanding scope midstream increases risk and delays delivery. Include the systems, components, and technical goals in the scope definition. Exclude new features unless they are required for modernization. Use a backlog to manage feature requests.** Capture new functionality in a separate backlog for [new cloud-native development](cloud-native](../innovate/index.md)). This separation keeps modernization focused and avoids unnecessary complexity.

### Capture baseline metrics

Baseline the current workload to metrics for reliability (uptime), [security](/azure/well-architected/security/establish-baseline), [cost](/azure/well-architected/cost-optimization/cost-model), performance ([capacity, response time](/azure/well-architected/performance-efficiency/performance-targets#identify-key-metrics)), and operations (response times, development times). You want to compare the before and after for immediate rollbacks (such as increased response time) or long term challenges like cost and operations.

### Plan the modernization phases

1. **Identify modernization phases.** A phased approach reduces risk and enables continuous learning. Incremental modernization allows teams to validate techniques and build confidence before addressing complex systems. You should break the system into logical components or services that can be modernized independently. Deliver value in each phase.** Each phase must provide measurable improvements, such as better performance, scalability, or maintainability. You should ensure that each phase contributes tangible benefits to validate the modernization approach and maintain stakeholder support. Validate each phase before proceeding.** Validation confirms success and reduces risk before moving to the next phase. You should use automated testing, monitoring, and rollback plans to confirm that each phase meets its objectives and maintains system stability.

2. Define rollback plans. For each phase, document how to revert to the previous state if issues arise.

3. **Choose the right modernization technique.** Workload teams should select the appropriate modernization path based on their specific requirements. Use progressive exposure models like blue-green or canary deployments. With these models, you deploy the modernized updates and test them in production on a limited set of uses before a full cutover. The key is to validate in Azure under real conditions and ensure the modernized system can handle production load and patterns. Only flip the switch for all users when you’re confident in the new implementation.

## Implement modernization

Once your plan is in place, begin implementing changes in a controlled, iterative manner. This reduces risk and allows for continuous learning and adjustment.

5. **Use software development best practices.** Use well managed CI/CD approach and lifecycle, not “big bang”. Instead, modernize in small, manageable stages, such as Fig leaf of strangler pattern. Start with one component or service. For example, containerize a single service and deploy it to Azure Container Apps in a development environment. Break work into discrete steps that deliver independent value. maturity levels.

1. **Follow design guidance.** Use the [Well-Architected Framework](/azure/well-architected/pillars) and [cloud design patterns](/azure/architecture/patterns/#pattern-catalog) to guide decisions. Evaluate downtime tolerance, performance needs, and compliance requirements. Ensure code and service changes align with proven best practices. For every new service in your architecture, review its [Azure service guides] to align each service to best practices.

1. **Test modernization changes.** Whether you're migrating or modernizing in the cloud, you need to test the modernization changes. Modernization can introduce regressions or integration issues. Testing is critical. Use the following testing approaches:
    - Unit tests for any code changes.
    - Integration tests to ensure different services work with the unchanged ones.
    - Performance tests to ensure the new approach doesn’t degrade system performance.
    - Fix any issues and promote to staging environment if you have one.

1. **Execute cut over.** Plan the transition like a migration cutover. Depending on scope, it might be a series of small cutovers (each component flip) or one larger event (tightly coupled systems). Ensure all dependencies now point to the new components or updated code.

1. **Ensure data consistency.** Validate data flow when switching to a modernized component. For example, if switching databases, migrate data and consider running dual writes for a transition period.

1. **Monitor closely.** Once the modern component is live, monitor it closely. If any issues arise, roll back or fix forward quickly. Ensure Azure Monitor is capturing the correct metrics and alerts are configured appropriately. Confirm that Azure Monitor is capturing the right metrics and alerts are configured appropriately. AMBA or sign posting it for BAseline alerting, and maybe some literature around Azure Monitor and App Insights. For more information, For more information, see [Monitor your Azure cloud estate](/azure/azure-monitor/overview).

## Optimize post-modernization

Modernization is an ongoing process. Each iteration makes your cloud environment more efficient and easier to maintain. Over time, your applications will use more fully managed services, deployment frequency will increase, and operational incidents will decrease.

1. **Fine-tune configurations.** Azure provides flexibility to quickly adjust resources. Post-modernization, workloads may behave differently. Adjust configurations based on recommendations in their Azure service guides. Use Azure Advisor and Microsoft Defender for Cloud to receive tailored recommendations on cost optimization, performance, reliability, and security.

2. **Monitor costs.** Use Azure Cost Management to identify cost anomalies and Azure Advisor for relevant performance and reliability improvements. Compare current costs to your pre-modernization baseline. Identify and address any configuration or feature changes that increase costs.

5. **Update architecture.** Update your documentation to reflect the modernized system. Capture the current architecture, including all modernized components. update/refine documentation to ensure it aligns with the deployed environment.

6. **Update operations.** Document operational procedures for managing the new environment or component. Train the operations team on any new technologies, such as container orchestration, serverless functions, or platform-as-a-service (PaaS) solutions.

7. **Gather feedback from users.** Collect and document feedback from end users. Address any issues, such as performance concerns or newly discovered bugs. Positive feedback, such as improved speed, can validate modernization success.

8. **Capture lessons learned.** Document insights from the modernization effort. Identify what worked well and what didn’t. Highlight gaps, such as the need for better development/test environments or more automation. Feed these lessons back into your Cloud Adoption Framework to improve future projects.

9. **Track quantitative outcomes.** Quantify the impact of modernization to demonstrate its value. Track key metrics such as performance improvements, cost savings, and incident reduction. Share results with stakeholders to build support for future modernization efforts. Examples: “Page load time dropped from 4 seconds to 2 seconds.” “We eliminated 3 VMs, saving $X/month.”

**Validate backups.** Confirm backup jobs are configured correctly and completing successfully. Test restore procedures to ensure data recoverability. For more information, see [Manage data reliability](/azure/backup/backup-overview).

**Decommission source components.** After a stable period, shut down old workloads or components and update your inventory. See [Decommission source workload](./)

## Next steps

Use CAF guidance to govern, secure, and manage your Azure estate.
