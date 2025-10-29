---
title: Plan your cloud modernization
description: Comprehensive guide to planning cloud modernization projects with structured approaches for choosing modernization strategies (replatform, refactor, rearchitect), implementing phased execution, establishing governance frameworks, defining deployment strategies, mitigating risks, and securing stakeholder approval to ensure successful workload transformation.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: concept-article
---

# Plan your cloud modernization

Proper planning and governance are critical to modernization. In this stage, you decide which modernization approach to apply and how to do it. Thoughtful planning reduces the chance of budget overruns, scope creep, or service disruptions during execution.

## Choose a modernization strategy

Modernizing a workload means updating it to better align with current business goals, technical standards, and cloud capabilities. The three primary strategies (replatform, refactor, and rearchitect) exist on a continuum of complexity and value. Most modernization efforts use a combination of these approaches.

The key is to match the strategy to the specific needs of each component, considering your goals, timeline, and available resources. Avoid the temptation to over-modernize. While new technologies are exciting, every decision should be grounded in business value.

| Modernization strategy | Definition | When to use | Pros | Cons |
|----------|-------------|-------------|------|------|
| **Replatform** | Move applications to cloud platforms with minimal code changes (IaaS to PaaS). | Quick wins with minimal disruption needed. Current code works but operations burden is high. | Fast implementation. Reduces maintenance effort. Improves reliability through better infrastructure. | Limited capability gains. Core application remains unchanged. |
| **Refactor** | Modify existing code to improve structure, performance, and cloud optimization while maintaining functionality. | Technical debt causes issues or code isn't cloud-optimized. | Improves maintainability, performance, and security. Enables easier future enhancements. | Requires significant developer effort and testing. No immediate new features for users. |
| **Rearchitect** | Redesign application architecture using cloud-native patterns (microservices, serverless, event-driven). | Current architecture limits growth or cloud optimization. | Addresses fundamental scalability issues. Enables advanced cloud services. Sets foundation for long-term innovation. | Most complex and time-consuming. High upfront cost and risk. Requires extensive testing and parallel operations. |

## Plan modernizations in phases

Trying to modernize an entire complex workload (or multiple) in one go is risky. Break the effort into logical phases. Phasing allows you to deliver incremental value, reduce risk by tackling manageable chunks, and adjust course between phases based on what you learn.

1. **Divide modernizations into logical phases.** Determine how to slice the work. There’s no single "right way." Choose the breakdown that makes sense for your architecture and team structure. The goal is that each phase is small enough to execute and test without overwhelming complexity, but meaningful enough to provide value. Common ways to break down phases:

    | Division method | Description | Example |
    |-----------------|-------------|---------|
    | By component or layer | Separate phases based on workload layers or workload boundaries | Phase 1: Database migration, Phase 2: Application refactoring, Phase 3: UI modernization |
    | By priority and complexity | Organize work from low-risk to high-risk changes | Phase 1: Noncritical services, Phase 2: Core business logic, Phase 3: Customer-facing features |
    | By business function | Structure phases around application or functional boundaries | Phase 1: User management workload, Phase 2: Payment processing, Phase 3: Reporting services |

2. **Start with low-risk, high-value changes.** For your Phase 1, pick something that is achievable and provides a tangible win, but doesn’t endanger the business if issues arise. For instance, modernize a backend service or internal tool first rather than the customer-facing website. Aim to complete the first phase quickly (a month or two) as a proof-point. Early success builds team confidence and stakeholder support for subsequent phases.

3. **Sequence remaining phases by value and dependencies.** After the first phase, plan the order of subsequent phases based on business value and technical dependencies. Build a roadmap where each phase has a defined scope and ensures that critical components have their supporting elements already modernized or compatible.

    - **Address fragile areas.** If a workload is fragile in its current state, you might even need a preliminary "Phase 0" to stabilize it in place (apply urgent fixes in the old environment) so that it’s safe to modernize in Phase 1.
    - **Address prerequisites first:** If modernization of Workload B depends on Workload A being modernized (or at least stable), do Workload A first.  
    - **Consider business value vs risk:** You might decide to alternate, doing a high-value but riskier piece in one phase, then a lower-risk piece in the next, to balance load on the team and risk to the business.

4. **Define success criteria for each phase.** For each phase, decide when it’s complete and successful. Having clear exit criteria prevents scope-creep in a phase. Success criteria might include:

    | Success criteria type | Examples |
    |----------------------|----------|
    | **Technical goals** | • Service X runs on Azure App Service and handles 20% more load<br>• Database Y migrates to Azure SQL with zero data loss and performance within 10% of previous baseline |
    | **Quality gates** | • No Sev-1 bugs open<br>• All automated tests pass<br>• Security scan shows zero critical vulnerabilities |
    | **Timing and budget constraints** | • Complete within three months and within 5% of budget<br>• Deploy during scheduled maintenance windows |

5. **Adapt plans based on results.** After completing a phase, review results and lessons learned. You might find that some assumptions were off or some tasks were easier or harder than expected. Adjust the plan for upcoming phases accordingly, such as adding, combining, or reprioritizing phases The phased approach is meant to be flexible. What’s important isn't to try doing everything at once.

## Plan for modernization governance

Modernization often introduces significant changes to critical workloads, so strong governance is needed to manage risks. Modernization governance involves change management processes, freezes, and controlling scope:

1. **Establish a formal change approval workflow.** Define a structured approval process for all modernization-related changes. Integrate with existing Change Advisory Boards (CAB) or create a dedicated modernization review board. Assign approval authority based on change category and document the full workflow in your project plan. For more information, see [Manage change](/azure/cloud-adoption-framework/manage/administer#manage-change).

2. **Freeze changes when necessary.** Right before and during major deployment events, freeze other changes on those workloads. A change freeze means no other unrelated changes are done to those workloads in the lead-up and during the deployment. It stabilizes the environment so you’re not hitting a moving target. Communicate the freeze window to all relevant teams.

3. **Avoid scope creep.** Scope creep is a major challenge in modernizations. Require any proposed change to the agreed modernization scope to go through an evaluation and approval step. Most requests should be deferred unless they're crucial. Formalize the "no, not now" to extra work with a process.  Maintain a backlog of nice-to-have ideas that come up, which can feed into a future innovation project once the current modernization is done. Stakeholders should know their idea isn’t lost.

## Define your deployment strategy

A crucial execution decision is how to roll out the modernized components into production. There are two main strategies. In an in-place deployment, you upgrade the existing setup (like renovating a house while you live in it). In a parallel deployment, you build a new setup alongside (like constructing a new house, then moving in). Choose the strategy that fits the level of change and risk tolerance for each phase or workload. Often, each phase of modernization might use a different strategy. For instance, you might choose in-place for Phase 1 (if it’s a minor change) and parallel for Phase 2 (if that one involves a major database overhaul).

1. **Use in-place deployment for low-risk, reversible changes.** In-place deployment introduces changes directly into the current production environment, perhaps during a maintenance window. This strategy minimizes infrastructure overhead but increases the risk of downtime. Use in-place deployment only when changes are small, isolated, and easily reversible. Examples include minor code updates or schema changes that can be rolled back quickly using source control or backups.

2. **Use parallel deployment for complex or high-risk changes.** In this model, you set up a new environment for the modernized workload while the old workload still runs. Data is kept in sync (through replication or migration processes) so that when ready, you can cut over from the old to the new environment. Use for complex or high-risk changes where downtime must be minimal. If you’re doing a major database migration or a rearchitecting that involves new infrastructure, parallel is usually the way. Also, if the workload is mission-critical and can’t have more than a few minutes of downtime, parallel (with replication and quick cutover) is necessary.

    | Strategy | Description | When to use | Pros | Cons |
    |----------|-------------|-------------|------|------|
    | **In-place deployment** | Deploy changes directly into current production environment | Small, reversible changes with acceptable maintenance windows | No duplicate infrastructure, faster deployment | Higher risk, requires downtime, slower rollback |
    | **Parallel deployment** | Run new environment alongside existing workload during transition | Complex changes, mission-critical workloads requiring minimal downtime | Safer deployment, near-zero downtime, immediate fallback | Duplicate infrastructure costs, complex data sync, decommission effort |

## Plan to mitigate modernization risks

Even with the best planning and testing, not every change goes perfectly. Modernization often involves complex changes, and there’s always a risk that a deployment could introduce an issue, or something behaves unexpectedly in production. The mark of a well-prepared team is having a solid rollback plan for each change or phase.

1. **Use progressive deployment techniques.** If the platform allows, do canary releases or gradual traffic shifting to modernized portions of the app. For example, deploy the new version alongside the old and initially send only 5% of users to it while monitoring. This approach can catch issues while most users are unaffected. If metrics look good, increase to 50%, then 100%. If something starts failing, route back to 0% new (rollback) quickly.

2. **Create rollback procedures for every major change.** For every major change or phase deliverable, write a step-by-step rollback procedure. Clearly list each action to undo the change, who is responsible for each step, and how long it would take. After rollback, include what checks confirm things are back to normal.

3. **Automate rollbacks where possible.** Automated rollback scripts or infrastructure-as-code can make recovery fast and reliable. Use infrastructure-as-code tools (Terraform, ARM template, Bicep) to redeploy known good states. Blue-green or canary deployments inherently allow "switching back" to the previous version if needed. Test these mechanisms in staging. The goal is to reduce manual effort (at 3 AM during an incident) to a scripted action. Write the rollback steps alongside the deployment steps, so it’s easy to roll back.

4. **Have support on standby during and after deployment.** Plan deployments during low-traffic periods (weekends or overnight) when possible, but ensure the relevant experts are available. Don’t do it when key team members are on vacation. Have an extended support (hypercare) period right after deployment with developers and operations on standby to catch any issues early. For major go-lives, some organizations have war-room style monitoring for 24-48 hours after.

## Secure stakeholder approval

Up to this point, we focused on technical planning. Equally important is getting buy-in from stakeholders, both business and technical leadership. Modernization often requires significant investment, so you need to present a compelling case and keep stakeholders engaged throughout.

1. **Tailor the value proposition to each audience.** Different stakeholders care about different outcomes. Customize your messaging:

    - **Technical teams** prioritize operational efficiency: reduced maintenance, improved uptime, and fewer escalations.
    - **Business leaders** focus on outcomes: faster time-to-market, improved customer experience, and cost savings.

2. **Document a structured plan with milestones.** Stakeholders are more comfortable if they see a clear roadmap. Present the phases you planned, as decided earlier, and what each should achieve, with a rough timeline. Emphasize early wins, such as "Within 6 weeks, we aim to modernize X component and improve its performance by 20%."

3. **Quantify modernization value.** Prepare some before-and-after metrics and target improvements. Examples of metrics and typical improvement ranges (based on industry benchmarks) are:

    | Category | Example metrics | Typical value range |
    |----------|-----------------|-------------------|
    | Cost reduction | Infrastructure, maintenance, licensing | 20-40% annual savings |
    | Productivity gains | Deployment frequency, resolution time | 50-80% improvement |
    | Risk mitigation | Avoided downtime, security incidents | $100K-$ 1M+ cost avoidance |
    | Revenue | Faster time-to-market, customer retention | 10-25% revenue acceleration |

4. **Address project risks.** Identify potential challenges and demonstrate preparedness through specific mitigation strategies. Common risks include data replication, performance degradation, and integration issues. Present solutions such as automated rollback procedures, comprehensive testing protocols, and expert consultation availability. Transparent risk discussion builds stakeholder confidence in project leadership and planning thoroughness.

5. **Maintain regular communication cadence.** Report progress against defined success criteria, highlight completed deliverables, and communicate upcoming milestones. Request feedback actively and address concerns to maintain support throughout the modernization process.

## Next step

> [!div class="nextstepaction"]
> [Execute your cloud modernization](./execute-cloud-modernization.md)
