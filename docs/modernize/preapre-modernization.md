---
title: Prepare for modernization
description: Modernize in cloud and maximize value. Modernization is a critical approach to cloud adoption that increases efficiency and exceed objectives.
author: stephen-sumner
ms.author: pnp
ms.date: 08/15/2025
ms.topic: conceptual
ms.custom: internal
---

**Required to modernization:** Azure modernization skills, [Workload inventory]

Modernization is making improvements to existing workloads in the cloud. The goal is to better meet business needs in alignment with cloud best practices. Modernization doesn't bring direct functional benefit to end users, it can still improve the end user experience and internal operations. Modernization replatforming, refactoring, rearchitecting. These are modernizations efforts you can execute as part of a migration or in cloud. Not every workload needs to be modernized. Focus your efforts where modernization delivers clear, measurable value to end users (better performance, uptime) or internal (cost optimized, improved reliability, better security, easier maintenance).

## Define modernization for your organization

Begin by establishing a shared definition of "modernization" in your organization. It’s crucial that everyone understands what is and isn’t included in a modernization project before any work begins. Modernization refers to technical improvements to existing workloads (applications, services, infrastructure) without adding new end-user features.

1. **Define modernization as technical improvements to existing workloads.** Modernization improves how existing applications work without adding new features or rebuilding entire systems. Modernization is replatforming (moving components to new hosting environment), refactoring (optimizing code), and rearchitecting (redesigning structure) in the cloud. Modernization does not include building new features, creating new workloads, or complete rebuilds. This definition prevents scope creep where teams add unrelated work under the modernization label.

2. **Communicate the definition of modernization.** Share this definition with all relevant teams and stakeholders. Ensure that project managers, engineers, product owners, and executives understand and agree. A unified understanding prevents misalignment. For instance, if someone isn’t aware and tries to slip in a feature request (“Since we’re touching this app, can we also add Feature X?”), the agreed definition makes it easier to say no because everyone knows new features are out of scope.

3. **Set expectations with all stakeholders.** Business leaders and technical teams must understand that modernization improves internal qualities like performance, reliability, and maintainability. Modernization does not deliver new customer features. Clear expectations prevent pressure to expand project scope beyond technical improvements. Document this definition and share it with all project participants.

4. **Create shared responsibility across teams.** Modernization requires collaboration between development, operations, security, and architecture teams. Each team contributes different expertise to modernization success. Establish regular communication and joint decision-making processes. Avoid siloed work that creates integration problems or missed requirements. Assign clear roles while maintaining cross-team coordination.

## Know what to modernize

After defining what constitutes modernization, the next step is to decide where to apply it for maximum benefit. This involves analyzing your IT landscape (using the inventory) and the business context to pinpoint which systems would yield the most value if improved. Focus your modernization efforts on workloads that deliver clear, measurable value from being updated. In practice, this means finding the sweet spot where business importance and technical need are both high.

1. **Identify goals for modernization.** Business value determines where modernization resources produce the strongest impact on organizational objectives. Rate each workload in your inventory according to its importance to business operations and strategic goals. Systems that directly affect revenue, customer experience, or regulatory compliance deserve higher priority than internal tools or legacy systems with limited business impact. Common business value factors include:

    - **Revenue generation or critical operations support:** Systems that directly process sales, manage customer transactions, or support core business functions where downtime translates to immediate financial impact
    - **Customer experience impact:** Applications that customers interact with directly, such as mobile apps, websites, or service portals where performance affects satisfaction and retention
    - **Compliance or regulatory requirements:** Workloads that must meet industry standards, government regulations, or security frameworks where non-compliance creates legal or operational risk
    - **Large user base or business dependency:** Systems supporting significant numbers of employees or customers where disruption affects productivity or service delivery across the organization

2. **Assess technical risk.** For each workload, evaluate its current technical state and pain points. Use the same scale (1 to 5) or categories (High, Medium, Low) to rank modernization need. A low ranking means limited technical risk. Higher means the modernization need is urgent given the technical risk. Common technical risks include:

    - **Technical debt:** Legacy code or architecture that accumulated shortcuts or compromises over time, increasing maintenance complexity and reducing development velocity
    - **Outdated or unsupported technology:** Systems running on platforms approaching end-of-life or no longer receiving security updates, creating operational risk
    - **High maintenance or operational costs:** Applications requiring excessive manual intervention, custom patches, or specialized expertise to maintain stable operations
    - **Frequent outages or performance issues:** Systems experiencing regular downtime, slow response times, or capacity limitations that affect user experience
    - **Limited scalability:** Applications that cannot handle increased load or business growth without significant architectural changes

3. **Enable workload teams to make technical modernization decisions.** Teams that maintain applications daily possess the deepest understanding of technical constraints and user requirements. Workload teams can identify the most effective modernization approaches when they understand business objectives and technical possibilities. Provide teams with clear business context, modernization strategy options, and decision-making authority within established budget and timeline parameters. Establish regular check-ins to ensure alignment with organizational goals while respecting team expertise.

4. **Identify modernization triggers.** Be on the lookout for specific events or requirements that make modernization urgent. Even a workload that wasn’t top of list can shoot up in priority if a trigger occurs. Common triggers include:

    - **Address security vulnerabilities:** Known security gaps in current systems that require updates or patches
    - **Enable business growth:** Older systems that limit scalability, performance, and integration capabilities that constrain business expansion
    - **Avoid end-of-life risks:** Legacy platforms approaching end-of-support dates that create operational vulnerability
    - **Meet expansion requirements:** New market entry or customer growth that exceeds current system capacity
    - **Comply with regulatory deadlines:** New compliance requirements that demand security or operational improvements within specific timeframes
    - **Support technology transitions:** Migration projects or vendor changes that create opportunities to modernize simultaneously
    - **Fix repeated incidents:** Patterns of outages or performance issues that indicate underlying architectural problems requiring structural changes

5. **Prioritize workloads based on business value and technical risk.** Create a matrix that compares business importance against modernization urgency to identify where you should focus first. This systematic approach ensures you invest modernization resources where they deliver maximum return on investment. Here's a sample business value vs. technical risk priority matrix:

    | Business value | Technical risk | Modernization priority | Action |
    |-----------------|----------------|-------------------------|--------|
    | High            | High           | Immediate priority | Start modernization now - high business impact justifies investment and technical issues create operational risk |
    | High            | Low            | Monitor closely | Delay modernization unless specific business benefits exist - systems work well currently |
    | Low             | High           | Evaluate case-by-case | Consider modernization if maintenance costs exceed business value, otherwise evaluate retirement |
    | Low             | Low            | Retain as-is | Defer modernization - resources produce better returns elsewhere |

6. **Focus on high-priority workloads first.** Limit initial modernization efforts to systems in the "Immediate priority" category where high business value intersects with high technical risk. These workloads deliver the strongest return on investment and reduce operational risk simultaneously. Document your prioritized list with the primary business driver and key technical issues for each workload. This focused approach prevents resource dilution across too many concurrent projects.

7. **Prepare to explain workload exclusions.** Stakeholders might question why certain systems are not prioritized for modernization. Document clear rationales for excluded workloads to demonstrate thorough evaluation and strategic focus. Common reasons for exclusion include:

    - **Low business value:** Systems that support non-critical functions or are scheduled for retirement don't justify modernization investment
    - **Recent modernization:** Applications updated within the past two years typically don't require additional improvements
    - **High operational risk:** Unstable systems require stabilization before modernization to prevent additional disruption
    - **Dependency constraints:** Systems requiring prerequisite modernization of integrated applications should wait for proper sequencing

    This transparency builds stakeholder confidence in your evaluation process and reinforces that selective modernization delivers better returns than attempting to modernize everything simultaneously.

## Establish modernization success metrics

Success metrics transform vague modernization goals into concrete, measurable outcomes. “What does success look like?” Modernization is only worthwhile if it delivers tangible improvements. Before implementing changes, define how you will measure the outcomes. Establishing clear success metrics (Key Performance Indicators, or KPIs) keeps the effort focused on business value and allows you to demonstrate progress to stakeholders. These metrics help you focus on delivering real business value and properly scope your modernization effort. You should define baseline measurements and target outcomes before you start any modernization work.

| Metric Category        | Business goal                            | Example metrics                                              | Baseline example                                      |
|-----------------------|-------------------------------------------|--------------------------------------------------------------|-------------------------------------------------------|
| Performance           | Improve customer experience or scalability | Page load time (seconds), throughput (requests/sec), batch time (hours) | Page load: 4.2s, Throughput: 150/sec, Batch: 8h       |
| Reliability           | Increase uptime and reduce incidents       | Uptime (%), incidents/month, mean time to recovery (MTTR)     | Uptime: 98.7%, Incidents: 5/quarter, MTTR: 45min      |
| Cost Efficiency       | Reduce operating and maintenance costs     | Monthly Azure cost ($), cost/transaction, maintenance hours   | Cost: $50,000/mo, Cost/txn: $0.15, Maintenance: 120h/mo|
| Operational Efficiency| Accelerate releases and changes            | Deployment frequency, lead time, provisioning time, support tickets | Deploy: 1/8wks, Lead: 4wks, Provision: 2d             |
| Security and Compliance| Improve security and compliance posture   | Security scan pass rate, high-severity vulnerabilities, audit scores, patch time | Pass rate: 75%, Vulnerabilities: 12, Patch: 2wks      |

1. **Tie success metrics to business goals.** Each modernization goal requires specific, measurable outcomes that demonstrate improvement over the baseline. Focus on metrics that directly support your business objectives. Revisit the business drivers and improvement goals for each workload. For each goal, decide on a quantifiable metric that would indicate success. Some common examples:

2. **Capture baseline measurements before modernization begins.** Baseline metrics provide the foundation for measuring modernization success and identifying areas that need course correction. Before making any changes, measure the current values of each chosen metric. Document these baselines. This is your “before modernization” benchmark. For example, you might record “Order System average throughput = 200 orders/minute, peaks at 300 (baseline, cannot go higher due to server constraints).” Make sure these measurements are as accurate as possible; you may need to run specific tests or use APM (Application Performance Monitoring) tools to get them. The effort is worth it, because these numbers will justify your project and guide your targets.

3. **Work with workload teams to set realistic targets.** Workload teams possess the technical expertise to determine what improvements are achievable within specific timeframes and budgets. Either let the workload team set the success metrics based on technical possibilities, or if business stakeholders set the success metrics, have the workload teams indicate what modernization scope and effort it takes to reach those goals. This collaboration ensures targets are both ambitious enough to deliver business value and realistic enough to achieve with available resources.

4. **Track metrics consistently during modernization.** Set up systems to capture and review your metrics as you make changes. Use Azure Monitor, Log Analytics, or Application Insights to collect data for your KPIs. For performance, define clear test scenarios—such as running load tests after each major update. For cost, organize your Azure resources with tags or resource groups so you can track spending for each workload. Assign clear ownership for each metric: for example, a performance engineer runs load tests, the finance team checks cost savings, and operations monitors uptime. If your project runs in phases, measure results after each phase to see progress and catch issues early. Regular reviews with stakeholders keep everyone aligned and help you make quick, data-driven adjustments if something isn’t working as planned. Automated monitoring and dashboards make it easy to see how you’re tracking against your targets.

5. **Report on results after modernization completes.** Once your changes are stable and running in production, measure the same metrics you established as baselines to calculate actual improvements. Create clear before-and-after comparisons that demonstrate the value your modernization delivered. For example, you might report "CPU utilization dropped from 80% to 50% at peak load, and response time improved from 500ms to 200ms—that's 60% faster for our users." For cost savings, show concrete numbers like "Monthly Azure spending decreased from $45,000 to $31,500, saving $162,000 annually." For operational improvements, highlight gains such as "Deployment frequency increased from quarterly releases to monthly releases, reducing time-to-market for new features by 75%." These results validate your modernization investment and build organizational confidence for future projects. Share these success stories with stakeholders to demonstrate clear return on investment and establish modernization as a proven strategy for business improvement.

## Choose how to modernize

You know why you need to modernize, but figuring out what to modernize and how can feel overwhelming. The good news is you don't have to guess—there are proven tools and approaches that make these decisions much clearer.

1. **Start with the Azure Well-Architected Framework to identify modernization opportunities.** Think of the Well-Architected Framework as your modernization roadmap. It evaluates your workloads across five key areas: reliability, security, cost optimization, operational excellence, and performance efficiency. Run a Well-Architected Review on your applications to spot gaps. Those gaps become your modernization targets. The bigger the gap, the more urgent the modernization need.

2. **Pick the right modernization strategy for your situation.** You have three main strategies, and you can use all three on the same workload if needed. Start small to build confidence and skills, but plan ahead so you don't repeat work unnecessarily.

    - **Choose replatforming when you want quick wins with low risk.** Replatforming moves your applications to managed Azure services without touching the core functionality. Picture moving your database or application running on Azure Virtual Machines to Azure SQL Database or Azure App Service. You get immediate benefits like reduced maintenance and better reliability without the complexity of code changes.

    - **Choose refactoring when technical debt is slowing you down.** Refactoring improves how your code works internally without changing what users see. This means cleaning up inefficient code. Your application becomes easier to maintain and ready for future improvements.

    - **Choose rearchitecting when you need cloud-native capabilities.** Rearchitecting rebuilds your system using cloud-native patterns like microservices, serverless functions, or event-driven architectures. This approach unlocks scalability and new business capabilities, but it requires solid planning and advanced skills. Rearchitecting usually includes refactoring as part of the process.

3. **Check if your team has the skills to succeed.** Even the best modernization plan fails without the right skills. Before you start, assess what your team knows about cloud services, DevOps practices, and modern application patterns. Identify the gaps and create a learning plan. Whether that's training your existing team or bringing in outside expertise. Also make sure your CI/CD pipelines, monitoring systems, and automation tools can support your modernization goals. Skills matter more than technology when it comes to modernization success.

## Document the modernization scope in a project charter

Create a clear scope document that specifies which workloads you plan to modernize and what improvements you'll make to each one. This charter becomes your project boundaries and prevents scope creep. Include specific details about what's in scope and what's explicitly out of scope. For example: "Scope: Modernize the Order Processing System - Replatform database to Azure SQL Database, refactor API code for better performance. Out of scope: Changes to the user interface or adding new ordering features." Get stakeholder approval on this document before starting work. When someone suggests additional changes during the project, you can reference the approved charter to maintain focus and timeline commitments.

## Next step

> [!div class="nextstepaction"]
> [Plan your modernization](./plan-modernization.md)