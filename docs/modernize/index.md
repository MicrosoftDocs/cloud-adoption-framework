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

## Define modernization for your organization

1. **Define modernization as a technical improvement to existing workloads.** Modernization is replatforming, refactoring, and rearchitecting. You can modernize as part of a migration or once in the cloud. This definition distinguishes modernization from feature development. You should use this definition to align stakeholders and prevent scope creep. A clear and shared definition of modernization ensures alignment across teams and avoids misaligned expectations. This definition helps prioritize efforts that improve performance, reliability, and maintainability without expanding scope into feature development.

3. Review modernization examples: 

2. **Establish modernization as a shared responsibility across teams.** Modernization spans architecture, development, operations, and security functions within the organization. This shared responsibility requires strong communication channels and leadership support to succeed. You should set up regular forums for collaboration and decision-making to ensure alignment across all teams.

## Know when to modernize

Organizations need systematic criteria to identify modernization candidates and determine when modernization becomes a priority. In general, Start with low-risk modernizations. Choose workloads with minimal dependencies and clear business value to validate your approach early. Prioritize high-impact modernizations when deadlines require it.** If business timelines demand it, modernize complex workloads first, but ensure that the team has the necessary skills and support.

1. **Evaluate modernization candidates using combined business and technical value criteria.** Business value drives successful modernization decisions while technical factors determine urgency and operational necessity. You should assess workloads using both dimensions to identify those that deliver the highest return on investment and address critical operational risks. Prioritize modernization for workloads that demonstrate high business impact through revenue generation, customer experience enhancement, competitive differentiation, or compliance requirements, combined with technical indicators such as excessive maintenance costs, end-of-life technology risks, scalability constraints, or security vulnerabilities. This combined evaluation ensures modernization efforts focus on workloads that both justify the investment through business outcomes and address technical debt that limits operational efficiency or creates risk exposure.

4. **Establish modernization triggers that create urgency.** Certain business or technical events transform modernization from a strategic initiative into an operational necessity. Recognizing these triggers helps organizations respond proactively rather than reactively to changing requirements:

   - **Business expansion requirements:** New market entry, customer growth, or service offerings that exceed current system capabilities.
   - **Compliance deadlines:** Regulatory changes or audit findings that mandate security, privacy, or operational improvements within specific timeframes.
   - **Technology transitions:** Migration projects, platform changes, or vendor support changes that create opportunities to modernize.
   - **Incident patterns:** Recurring outages, performance degradation, or security incidents that indicate systemic architectural problems requiring modernization solutions.

4. Define clear success metrics and track them. Establish metrics for each objective; for example, operational cost per month (for cost reduction), average response time or scalability metrics (for performance improvement), deployment frequency (for agility improvements), or compliance audit scores (for security enhancements). You should measure baseline values before modernization and set target values to achieve after modernization. Tracking these metrics during and after the project will show if you’re meeting your goals and alert you if adjustments are needed. This is important to demonstrate the value of the modernization effort and guide decision-making (e.g., if a particular change isn’t yielding the expected improvement, you might pivot or invest more in that area).

3. Engage stakeholders and secure executive support. Stakeholder engagement means communicating the modernization plan and benefits to both technical teams and business executives. Present a concise case for each major change – for instance, explain that moving to a PaaS database will free the team from maintenance and improve uptime, or that refactoring a module will enable faster feature delivery. Be transparent about costs, timelines, and risks. You should obtain buy-in by showing how the modernization aligns with business strategy (such as enabling expansion into new markets or improving customer satisfaction scores). This support is important to ensure necessary resources are provided and to overcome resistance to change.

## Know how to modernize

Use the Well-Architected Framework to how to reach those goals the right way.** The Azure Well-Architected Framework provides systematic evaluation across reliability, security, cost optimization, operational excellence, and performance efficiency pillars. You should conduct Well-Architected Reviews to assess existing workloads against these pillars and prioritize those demonstrating significant gaps as primary modernization candidates.

## Plan the modernization

A well-structured plan reduces risk and ensures modernization aligns with cloud design principles. You should define scope, prioritize workloads, and choose the right modernization technique.

1. **Use change management process.** A formal change management process ensures that modernization activities align with organizational governance and risk tolerance. Identify the approval workflows, risk thresholds, and deployment gates that apply to modernization efforts. See [Manage change](/azure/cloud-adoption-framework/manage/administer#manage-change).

1. **Schedule changes to minimize business impact.** Coordinate modernization deployments during maintenance windows or low-usage periods to reduce operational risk.Coordinate modernization deployments during maintenance windows or low-usage periods to reduce operational risk.

3. **Prevent modernization scope creep.** Document the modernization scope in a project charter. A well-defined scope ensures that modernization focuses on technical improvements rather than feature expansion. Expanding scope midstream increases risk and delays delivery. Include the systems, components, and technical goals in the scope definition. Exclude new features unless they are required for modernization. Use a backlog to manage feature requests.** Capture new functionality in a separate backlog for [new cloud-native development](cloud-native](../innovate/index.md)). This separation keeps modernization focused and avoids unnecessary complexity.

1. **Capture baseline metrics.** Baseline the current workload to metrics for reliability (uptime), [security](/azure/well-architected/security/establish-baseline), [cost](/azure/well-architected/cost-optimization/cost-model), performance ([capacity, response time](/azure/well-architected/performance-efficiency/performance-targets#identify-key-metrics)), and operations (response times, development times). You want to compare the before and after for immediate rollbacks (such as increased response time) or long term challenges like cost and operations.

1. **Identify modernization phases.** A phased approach reduces risk and enables continuous learning. Incremental modernization allows teams to validate techniques and build confidence before addressing complex systems. You should break the system into logical components or services that can be modernized independently. Deliver value in each phase.** Each phase must provide measurable improvements, such as better performance, scalability, or maintainability. You should ensure that each phase contributes tangible benefits to validate the modernization approach and maintain stakeholder support. Validate each phase before proceeding.** Validation confirms success and reduces risk before moving to the next phase. You should use automated testing, monitoring, and rollback plans to confirm that each phase meets its objectives and maintains system stability.

3. **Choose the right modernization technique.** Workload teams should select the appropriate modernization path based on their specific requirements. Deployment patterns determine how safely you release changes. Each pattern suits different change types and risk levels.
Use in-place (rolling) updates for minor, backward-compatible changes
Rolling updates replace pods or instances gradually in the same environment.
This pattern suits stateless services and minor refactors without schema changes.
Use blue/green deployments for major upgrades or schema changes
Maintain two full environments and switch traffic after validation.
This pattern ensures rollback safety and supports compliance testing.
Use canary releases for behavioral changes or feature flags
Route a small percentage of traffic to the new version and monitor.
This pattern enables safe experimentation and gradual rollout.
Use strangler fig for stepwise monolith decomposition
Deploy new services alongside the old and gradually replace functionality.
This pattern supports long-term architectural modernization.
Use dark launches for hidden feature toggles
Deploy code behind flags and enable for limited users.
This pattern allows controlled testing before full rollout.
Stand up a separate environment when risks are high
A separate environment isolates risk and supports full validation. Use this approach when changes affect data, architecture, or compliance.
Create a green environment for incompatible or high-risk changes
Schema changes, new messaging backbones, or framework shifts require isolation.
This approach prevents instability and supports rollback.
Validate the new environment before cutover
Run smoke tests, integration tests, and compliance checks.
This ensures readiness and avoids production impact.
Perform a controlled cutover
Sync data, switch traffic via DNS or load balancer, and monitor.
Roll back to the blue environment if thresholds breach.
Update in-place when changes are safe
In-place updates reduce complexity and support rapid iteration. Use this approach when changes are backward-compatible and well-tested.
Ensure backward compatibility
New code must read old schema and toggle new paths via feature flags.
This prevents runtime errors and supports rollback.
Use feature flags and canary releases
Tools like Azure App Configuration and Kubernetes rolling updates support safe deployment.
This enables gradual rollout and monitoring.
Automate health gates and observability
Use CI/CD gates, error budgets, and telemetry to validate releases.
This ensures reliability and supports rollback decisions.

3. Define rollback plans. For each phase, document how to revert to the previous state if issues arise. Rollback plans protect uptime and user experience. Always prepare automated rollback paths.
Define rollback paths for each strategy
Blue/green swaps, canary aborts, and feature flag toggles must be ready.
This ensures fast recovery from failures.
Use expand and contract for data migrations
Add new fields, backfill data, and remove old fields after cutover.
This approach supports safe schema evolution.
Instrument both old and new paths
Use consistent metrics and tracing to compare performance.
This supports observability and alerting.

## Execute modernization

Once your plan is in place, begin implementing changes in a controlled, iterative manner. This reduces risk and allows for continuous learning and adjustment.

1. **Use software development best practices.** Use well managed CI/CD approach and lifecycle, not “big bang”. Instead, modernize in small, manageable stages, such as Fig leaf of strangler pattern. Start with one component or service. For example, containerize a single service and deploy it to Azure Container Apps in a development environment. Break work into discrete steps that deliver independent value. maturity levels.

1. **Follow design guidance.** Use the [Well-Architected Framework](/azure/well-architected/pillars) and [cloud design patterns](/azure/architecture/patterns/#pattern-catalog) to guide decisions. Evaluate downtime tolerance, performance needs, and compliance requirements. Ensure code and service changes align with proven best practices. For every new service in your architecture, review its [Azure service guides] to align each service to best practices.

1. **Test modernization changes.** Whether you're migrating or modernizing in the cloud, you need to test the modernization changes. Modernization can introduce regressions or integration issues. Testing is critical. Use the following testing approaches:
    - Unit tests for any code changes.
    - Integration tests to ensure different services work with the unchanged ones.
    - Performance tests to ensure the new approach doesn’t degrade system performance.
    - Fix any issues and promote to staging environment if you have one.

1. **Execute cutover.**

Cutover to the Modernized Azure Environment
The cutover is the moment of truth: switching production use from the old environment to the new Azure environment. A well-planned cutover minimizes downtime and mitigates risks of data loss or user impact. 

Final Data Synchronization: In the lead-up to cutover, ensure that the latest data is in Azure. If you had a continuous replication going (for near-zero downtime move), make sure it’s up to date. If it was a one-time migration, you likely put the source in a read-only or offline mode and took a final backup. Perform that final delta migration to capture any changes since the initial data load. For example, you might freeze the on-prem database (prevent new writes), then apply the last transaction log backups to the Azure database. This step ensures the Azure environment’s data is current so users won’t lose work when they switch over.
migration-center

Notify Stakeholders: Schedule the cutover at a low-usage period (perhaps a weekend or late night, depending on your business). Communicate the timeline to users and IT staff. If there will be any expected downtime or maintenance window, let users know in advance (“The system will be in read-only mode from 10 PM to midnight while we upgrade our systems”). Often, with a blue-green deployment, downtime can be near zero, but it’s still wise to have a maintenance window declared in case of unforeseen hiccups.
Execute the Cutover Plan: Depending on your strategy:

DNS and Endpoint Changes: Many cutovers involve DNS changes because users connect via a hostname (like app.company.com). DNS changes can take time to propagate (TTL considerations), but you can mitigate this by lowering the TTL value ahead of cutover (e.g., to 5 minutes) so that the flip happens quickly for most users. Alternatively, if using an application gateway or reverse proxy, you might simply reconfigure backend targets. Whichever method, ensure that connection strings, URLs, and any client configurations are updated to point to Azure. Sometimes, desktop applications or integrators have config files that need updating to the new server name – don’t overlook those.
Monitor During Cutover: The moment you start redirecting production traffic, closely monitor system metrics and logs. Use Azure Monitor, Application Insights, or custom dashboards that watch error rates, response times, CPU/memory, etc., on the new environment. Also monitor business transactions (e.g., are orders being placed successfully?). Have the team on standby to quickly address any unexpected behavior. This is often called a “war room” scenario – everyone eyes on glass as the switch occurs.
Immediate Validation: Right after cutover, perform a smoke test in production. This might mean having a few users or testers run through critical functions on the live system in Azure: create a sample transaction, retrieve some data, etc., just to confirm it’s functional for real users. Check that ancillary processes are working – for instance, scheduled jobs are running in Azure at their times, emails are sending out via the new system, etc.
Rollback Plan: Despite best efforts, sometimes you need to back out. Ensure that during the cutover window, the old environment is kept intact and running (but ideally isolated from updates) so that you can switch back if a severe issue occurs. Clearly define what conditions would trigger a rollback (e.g., error rate above X%, or a critical feature not working). Because you synchronized data up to the point of cutover, any transactions that occurred on the new system might need to be merged back if you rollback – this is tricky, so judge carefully. In many blue-green setups, if a failure is detected quickly, few new transactions have occurred and some organizations choose to accept losing that tiny set to regain stability. In phased cutovers, you can roll back just the affected phase relatively easily by moving that group back to the old system.
If the cutover is executed successfully, users will largely be unaware except noticing improvements (if any) or a brief outage if one was scheduled. They will now be using the workload in Azure. Keep the old environment running (but quiesced) for a short period until you are certain of stability on Azure. This is your safety net. For example, maybe keep the database in read-only on the old server and archive it after a week of smooth operations.

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
