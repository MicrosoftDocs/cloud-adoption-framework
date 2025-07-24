---
title: Plan your cloud modernization
description: Learn how to plan cloud modernization with structured change management, scope control, and phased deployment strategies to reduce risk and align technical work with business objectives.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan your cloud modernization

Proper planning and governance are critical to modernization. In this stage, you decide which modernization approach to apply to each component, design a phased roadmap, put in place change management controls, and define your deployment strategy (how to roll out changes). Thoughtful planning reduces the chance of budget overruns, scope creep, or service disruptions during execution.

## Choose a modernization strategy

Modernizing a workload means updating it to better align with current business goals, technical standards, and cloud capabilities. The three primary strategies (replatform, refactor, and rearchitect) exist on a continuum of complexity and impact. Most modernization efforts use a combination of these approaches. The key is to match the strategy to the specific needs of each component, considering your goals, timeline, and available resources. Avoid the temptation to over-modernize. While new technologies are exciting, every decision should be grounded in business value. If a simple replatform meets your reliability goals, it might be more effective than a year-long rearchitecture that delivers the same short-term benefit.

| Modernization strategy | Definition | Business driver | When to use | Pros | Cons |
|----------|-------------|-------------|-------------|------|------|
| **Replatform** | Move applications to cloud platforms with minimal code changes, typically from IaaS to PaaS services. | Need PaaS solutions and minimal code changes to meet business goals. | Use when you need quick wins with minimal disruption. • Ideal if the goal is to reduce ops burden or improve reliability fast, and you can't afford a long redevelopment. | Fast to implement (much quicker than a full rewrite). • Reduces maintenance effort since cloud services handle many ops tasks (patching, scaling). • Can improve reliability and performance somewhat just by running on better infrastructure | Limited upside as core application remains the same. • Won't get new capabilities or major performance gains beyond what the new platform provides |
| **Refactor** | Modify existing code to improve structure, performance, and cloud optimization while maintaining functionality. | Need code changes to meet business goal. | Use when technical debt is slowing you down or causing issues or code isn't optimized for the cloud.| Improves maintainability, performance, and security of code. • Enables easier future enhancements. • Users might notice things run faster or more reliably (even if features are the same). | Requires code-level work and thorough testing. • Users typically see no immediate new features as improvements are mostly behind-the-scenes. • Requires significant developer effort and thorough testing to ensure you didn't introduce new bugs. |
| **Rearchitect** | Redesign application architecture using cloud-native patterns like microservices, serverless, or event-driven designs. | Need architecture changes to meet goals. | Use when the current architecture limits growth or isn't optimized for the cloud. | Can address fundamental scalability, agility, and reliability issues at the root. • Uses cloud-native designs (microservices, event-driven architecture, serverless) and sets up the app up for long-term growth and innovation. • Enables use of the latest cloud services (AI, advanced analytics). • You get major improvements in capabilities and cost-to-serve in the long run. | Most complex and time-consuming. • This is effectively a partial or complete rebuild of the workload. • It demands strong skills and careful planning to avoid disrupting current operations. • High upfront cost and risk. • If done poorly, could introduce new bugs or delays. • You must ensure extensive testing, and often need to run old and new in parallel until confident. |

## Plan modernizations in phases

Trying to modernize an entire complex workload (or multiple) in one go is risky. Break the effort into logical phases. Phasing allows you to deliver incremental value, reduce risk by tackling manageable chunks, and adjust course between phases based on what you learn.

1. **Divide modernizations into logical phases.** Determine how to slice the work. There’s no single "right way." Choose the breakdown that makes sense for your architecture and team structure. The goal is that each phase is small enough to execute and test without overwhelming complexity, but meaningful enough to provide value. Common ways to break down phases:

    | Division method | Description | Example |
    |-----------------|-------------|---------|
    | By component or layer | Separate phases based on workload layers or workload boundaries | Phase 1: Database migration, Phase 2: Application refactoring, Phase 3: UI modernization |
    | By priority and complexity | Organize work from low-risk to high-risk changes | Phase 1: Noncritical services, Phase 2: Core business logic, Phase 3: Customer-facing features |
    | By business function | Structure phases around application or functional boundaries | Phase 1: User management workload, Phase 2: Payment processing, Phase 3: Reporting services |

2. **Start with low-risk, high-value changes.** For your Phase 1, pick something that is achievable and provides a tangible win, but doesn’t endanger the business if issues arise. For instance, modernize a backend service or internal tool first rather than the customer-facing website. Aim to complete the first phase relatively quickly (a month or two) as a proof-point. Early success builds team confidence and stakeholder support for subsequent phases.

3. **Sequence remaining phases by value and dependencies.** After the first phase, plan the order of the next ones logically. Essentially, build a roadmap (Phase 1, Phase 2, Phase 3) with each phase’s scope defined. Ensure that by the time you get to a critical piece, all supporting elements it relies on are either already modernized or at least compatible.

    - **Address fragile areas.** If a workload is very fragile in its current state, you might even need a preliminary “Phase 0” to stabilize it in place (apply urgent fixes in the old environment) so that it’s safe to modernize in Phase 1.
    - **Address prerequisites first:** If modernization of Workload B depends on Workload A being modernized (or at least stable), do Workload A first.  
    - **Consider business value vs risk:** You might decide to alternate, doing a high-value but riskier piece in one phase, then a lower-risk piece in the next, to balance load on the team and risk to the business.

4. **Define success criteria for each phase.** For each phase, decide how you’ll know it’s complete and successful. Having clear exit criteria prevents scope creep in a phase. This might include:

    | Success criteria type | Examples |
    |----------------------|----------|
    | **Technical goals** | • Service X runs on Azure App Service and handles 20% more load<br>• Database Y migrates to Azure SQL with zero data loss and performance within 10% of previous baseline |
    | **Quality gates** | • No Sev-1 bugs open<br>• All automated tests pass<br>• Security scan shows zero critical vulnerabilities |
    | **Timing and budget constraints** | • Complete within 3 months and within 5% of budget<br>• Deploy during scheduled maintenance windows |

5. **Adapt plans based on results.** After completing a phase, review results and lessons learned. You might find that some assumptions were off or some tasks were easier or harder than expected. Adjust the plan for upcoming phases accordingly, such as adding, combining, or re-prioritizing phases The phased approach is meant to be flexible. What’s important is not to try doing everything at once.

## Plan for modernization governance

Modernization often introduces significant changes to critical workloads, so strong governance is needed to manage risks. This involves change management processes, freezes, and controlling scope:

1. **Establish a formal change approval workflow.** Define a structured approval process for all modernization-related changes. Integrate with existing Change Advisory Boards (CAB) or create a dedicated modernization review board. Assign approval authority based on change category and document the full workflow in your project plan. For more information, see [Manage change](/azure/cloud-adoption-framework/manage/administer#manage-change).

2. **Freeze changes when necessary.** Right before and during major deployment events, freeze other changes on those workloads. This means no other unrelated changes are done to those workloads in the lead-up and during the deployment. It stabilizes the environment so you’re not hitting a moving target. Communicate the freeze window to all relevant teams.

3. **Avoid scope creep.** Scope creep is a major challenge in modernizations. Require any proposed change to the agreed modernization scope to go through an evaluation and approval step. Most requests should be deferred unless they are crucial. Formalize the “no, not now” to extra work with a process, so stakeholders know their idea isn’t lost and it won’t derail the current modernization without proper justification. Maintain a backlog of nice-to-have ideas that come up, which can feed into a future innovation project once the current modernization is done.

## Define your deployment strategy

A crucial execution decision is how to roll out the modernized components into production. There are two main strategies. In an in-place deployment, you upgrade the existing setup (like renovating a house while you live in it). In a parallel deployment, you build a new setup alongside (like constructing a new house, then moving in). Choose the strategy that fits the level of change and risk tolerance for each phase or workload. Often, each phase of modernization might use a different strategy. For instance, you might choose in-place for Phase 1 (if it’s a minor change) and parallel for Phase 2 (if that one involves a major database overhaul).

1. **Use in-place deployment for low-risk, reversible changes.** In-place deployment introduces changes directly into the current production environment, perhaps during a maintenance window. This strategy minimizes infrastructure overhead but increases the risk of downtime. Use in-place deployment only when changes are small, isolated, and easily reversible. Examples include minor code updates or schema changes that can be rolled back quickly using source control or backups.

2. **Use parallel deployment for complex or high-risk changes.** In this model, you set up a new environment for the modernized workload while the old workload still runs. Data is kept in sync (through replication or migration processes) so that when ready, you can cut over from the old to the new environment. Use for complex or high-risk changes where downtime must be minimal. If you’re doing a major database migration or a rearchitecting that involves new infrastructure, parallel is usually the way. Also, if the workload is mission-critical and can’t have more than a few minutes of downtime, parallel (with replication and quick cutover) is necessary.

    | Strategy | Description | When to use | Pros | Cons |
    |----------|-------------|-------------|------|------|
    | **In-place deployment** | Deploy changes directly into current production environment | Small, reversible changes with acceptable maintenance windows | No duplicate infrastructure, faster deployment | Higher risk, requires downtime, slower rollback |
    | **Parallel deployment** | Run new environment alongside existing workload during transition | Complex changes, mission-critical workloads requiring minimal downtime | Safer deployment, near-zero downtime, immediate fallback | Duplicate infrastructure costs, complex data sync, additional decommission effort |

## Plan to mitigate modernization risks

Even with the best planning and testing, not every change goes perfectly. Modernization often involves complex changes, and there’s always a risk that a deployment could introduce an issue, or something behaves unexpectedly in production. The mark of a well-prepared team is having a solid rollback plan for each change or phase.

1. **Use progressive deployment techniques.** If the platform allows, do canary releases or gradual traffic shifting to modernized portions of the app. For example, deploy the new version alongside the old and initially send only 5% of users to it while monitoring. This can catch issues while most users are unaffected. If metrics look good, increase to 50%, then 100%. If something starts failing, route back to 0% new (rollback) quickly.

2. **Create rollback procedures for every major change.** For every major change or phase deliverable, write a step-by-step rollback procedure. Clearly list each action to undo the change, who is responsible for each step, and how long it would take. After rollback, include what checks confirm things are back to normal.

3. **Automate rollbacks where possible.** Automated rollback scripts or infrastructure-as-code can make recovery fast and reliable. Use infrastructure-as-code tools (Terraform, ARM, Bicep) to redeploy known good states. Blue-green or canary deployments inherently allow “switching back” to the previous version if needed. Test these mechanisms in staging. The goal is to reduce manual effort (at 3 AM during an incident) to a scripted action. Write the rollback steps alongside the deployment steps, so it’s easy to roll back.

4. **Have support on standby during and after deployment.** Plan deployments during low-traffic periods (weekends or overnight) when possible, but ensure the relevant experts are available. Don’t do it when key team members are on vacation. Have an extended support (hypercare) period right after deployment with developers and operations on standby to catch any issues early. For major go-lives, some organizations have war-room style monitoring for 24-48 hours after.

## Secure stakeholder approval

Up to this point, we’ve focused on technical planning. Equally important is getting buy-in from stakeholders, both business and technical leadership. Modernization often requires significant investment, so you need to present a compelling case and keep stakeholders engaged throughout.

1. **Tailor the value proposition to each audience.** Different stakeholders care about different outcomes. Customize your messaging:

    - **Technical teams** prioritize operational efficiency: reduced maintenance, improved uptime, and fewer escalations.
    - **Business leaders** focus on outcomes: faster time-to-market, improved customer experience, and cost savings.

2. **Document a structured plan with milestones.** Stakeholders are more comfortable if they see a clear roadmap. Present the phases you have planned (as decided earlier) and what each will achieve, with a rough timeline. Emphasize early wins, such as "Within 6 weeks, we aim to modernize X component and improve its performance by 20%."

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