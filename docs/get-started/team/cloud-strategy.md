---
title: "Get started: Build a cloud strategy team"
description: Establish a cloud strategy team's to ensures that cloud adoption efforts progress in alignment with business outcomes and you are prepared for a successful cloud adoption journey.
author: JanetCThomas
ms.author: janet
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.topic: conceptual
ms.date: 04/04/2020
---

<!-- docsTest:ignore Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template -->

# Get started: Build a cloud strategy team

Every cloud adoption journey will need some level of strategy to be successful. This getting started guide will help you establish a dedicate team or virtual team (v-team) to deliver a solid cloud strategy. The first step is to decide if you need a strategy team, or if the existing team members can deliver on cloud strategy as a distributed responsibilities.

Create a cloud strategy team to defined motivations and business outcomes, and to validate and maintain alignment between business priorities and cloud adoption efforts. When the business outcomes impact business functions, the strategy team should include business leaders from across the organization. The goal of the cloud strategy team is to produce tangible business results that are enabled by cloud technologies. Overall, this team ensures that cloud adoption efforts progress in alignment with business outcomes. Whenever possible, business outcomes and the cloud strategy team should both be defined early in the process.

![Get started building a cloud strategy team](../../_images/get-started/strategy-team-map.png)

> [!NOTE]
> This article will mention a strategy facilitator. As the cloud strategy team gets started, the strategy facilitator will help the team stay aligned and will temporarily hold accountability for creating alignment. The strategy facilitator is often the person who is most accountable for the success of the cloud adoption journey. This role is also commonly held by a program manager, architect, or a consultant.

## Step 1: Determine if a cloud strategy team is needed

A cloud strategy team delivers on a required capability in the cloud, referred to as the cloud strategy capability. Forming a cloud strategy team would require a defined group of dedicated business leaders, stakeholders, and program managers to meet on a regular, recurring cadence to advance the strategy driving cloud adoption.

**Deliverables:**

- Determine if you need a cloud strategy team.

**Guidance to support deliverable completion:**

This team is often a requirement if cloud adoption is import to the business, requires ongoing executive support, or presents a risk to the business.

<!-- markdownlint-disable MD033 -->
<br>

|                                                     |                                                                                                                            |
|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| **Important to the business:** | <li> The cloud adoption effort has board level visibility. <li> Success of the cloud adoption effort will improve market positioning, customer retention, or revenue. <li> The programs in the adoption portfolio map directly to strategic business outcomes. <li> The portfolio of workloads in this adoption effort are strategic, mission-critical and could affect multiple business units. |
| **Requires ongoing executive support:** | <li> The cloud adoption effort will have an impact on how we manage organizational change. <li> The cloud adoption effort will require additional training from multiple business users and could interrupt business functions. <li> The existing IT operations team or vendor is motivated to stay in existing datacenters. <li> The existing IT team is not fully bought into effort. |
| **Presents risk to the business:** | <li> Failure to complete migration within the specified time window will result in negative market impact or increased hosting costs. <li> Workloads slated for adoption need to be protected from data leakage that could affect business success or customer security. <li> Metrics being used to measure the cloud effort are business aligned, creating a dependency and risk on the technical success. |

If the following represent your existing requirements, then the following steps will help establish a cloud strategy team.

<!-- markdownlint-disable MD026 -->

**Accountable team:**

- The strategy facilitator is accountable for determining if a cloud strategy team is needed.

## What if I don't need a cloud strategy team?

Review the [cloud strategy functions](../../organize/cloud-strategy.md) that are required to deliver on cloud strategy needs. Not every organization will need a dedicated team or v-team to have their strategic needs met. In your [RACI template](https://archcenter.blob.core.windows.net/cdn/fusion/management/raci-template.xlsx), list out the core accountabilities of the strategy and identify the person on your team who will be accountable for each. If one person will take on all of those accountabilities, simple replace "cloud strategy" with that person's name in the RACI template.

## Step 2: Establish the cloud strategy team

The cloud strategy team will serve as a recurring alignment point between business leaders and IT leaders. Based on the levels of importance, risk, and executive support driving the need for a strategy team, participation and composition of the team might vary.

**Deliverables:**

- Identify appropriate organizations or individuals who are willing to share in the accountability and responsibility for driving the cloud adoption strategy.

**Guidance to support deliverable completion:**

- Document and share your reasoning from step 1 above to identify stakeholders who will benefit from regular involvement and will be able to help drive the strategy.
- See the [functions of cloud strategy](../../organize/cloud-strategy.md) for ideas on who might be a good fit.
- Review the [minimum scope](../../organize/cloud-strategy.md#minimum-scope) and [deliverable](../../organize/cloud-strategy.md#deliverable) for this capability to validate alignment and bandwidth from each potential participant.
- Review the various [RACI configuration examples](../../organize/raci-alignment.md#strategic-alignment) to establish the right RACI chart based on you current team structures. Or use one of the example tabs included with the RACI template.
- Document the results in the [RACI template](https://archcenter.blob.core.windows.net/cdn/fusion/management/raci-template.xlsx) under the Org Alignment tab.

**Accountable team:**

- The strategy facilitator is accountable for establishing the cloud strategy team.

## Step 3: Establish a cadence

Early in the cloud adoption journey, this team will require frequent interaction and iterative strategy reviews. As adoption starts, that frequency will reduce, transitioning to a focus on status and validation/adjustment of the backlog priorities.

Steps 4, 5, and 6 below should be completed within 4 to 6 weeks. The remaining steps will be completed in subsequent meetings. Higher frequency meetings should be maintained until step 7 below is kicked off by the team.

**Deliverables:**

Review the suggested meeting cadence and schedule meetings with all strategy team participants.

**Guidance to support deliverable completion:**

- Review the suggested short-term and long-term [meeting cadence](../../organize/cloud-strategy.md#deliverable) to align each of the documented participants.

**Accountable team:**

- The strategy facilitator is accountable for establishing the cadence for the cloud strategy team.

## Step 4: Establish a motivation-driven strategy

Cloud adoption journeys include both migration and innovation approaches. When technical teams define the strategy, it is common for the strategy to be driven by the teams' current skills and strengths. Such a strategy is likely to be a technical success, but is at risk of producing limiting business impact.

The first objective of the cloud strategy team is to define a high-level strategy based on business motivations. This can usually be completed in a one-hour workshop with all of the cloud strategy team members. It will also require a minimum of one additional hour to review the motivations with various technical teams and affected stakeholders.

During the first workshop, each member of the team should prioritize the motivations in the [understand motivations](../../strategy/motivations.md) article and share their top priorities. The strategy facilitator will help guide one or more rounds of conversation until a theme emerges in the direction of migration or innovation. There will likely be motivations in the top 3 list from both categories, which might require the team to go deeper on their list before a clear pattern leans to one direction or the other.

**Deliverables:**

This exercise will surface conversations that can help build alignment between the team members. The deliverable will help guide the rest of the strategy and following plan.

- Record motivations in the [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx).

**Guidance to support deliverable completion:**

- [Understand motivations](../../strategy/motivations.md): Critical business events and some migration motivations tend to be cost sensitive, increasing the importance of cost control for all subsequent efforts. Other forward looking motivations related to innovation or growth through migration might be focused more on top-line revenue. Understanding motivations will help understand how high of a priority cost management should be.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | Review motivations and general strategic direction with: <li> Cloud governance team <li> Cloud adoption team <li> Cloud center of excellence or Central IT |

## Step 5: Establish business outcomes

Each member of the cloud strategy team is asked to define one or more business outcomes, with specific metrics to measure business success. If that metric can be improved as a direct result of the cloud adoption effort, the team member is asked to share the expected impact. If the cloud adoption effort doesn't impact the metrics, but will enable the business to better drive that metric, that too should be documented.

Many of the leaders on the cloud strategy team might need to decompose their core metrics to identify an outcome that can be affected or influenced by the cloud adoption effort. If the team members outcomes can't be affected or influenced by this journey, then it will be hard to maintain their level of interest in the program. The facilitator should work with each leader to develop an aligned metric and reevaluate whether that team member is the right person to participate in the strategy team.

Impact to business outcomes can take time. Those types of changes typically move slower than technical changes. To maintain transparency, the strategy team should agree on shorter term learning metrics. Those metrics might include technical and other changes that can be reviewed at each team meeting to demonstrate progress towards technical goals and business outcomes.

**Deliverables:**

- Identify at least one expected outcome per member of the cloud strategy team.
- Refine the list of members to align expected time commitments with expected outcomes.
- Align on a set of short-term and mid-term metrics to support ongoing progress reports.

**Guidance to support deliverable completion:**

- Record business outcomes in the [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx).
- [Business outcomes](../../strategy/business-outcomes/index.md): Some fiscal outcomes tend to be extremely cost sensitive. When the desired outcomes map to fiscal metrics, it can be wise to invest in the Cost Management discipline of governance very early.
- [Learning metrics](../../strategy/learning-metrics.md): Learning metrics help bridge the gap between business outcomes and technical adoption efforts.

**Accountable teams:**

The cloud strategy team is accountable for defining business outcomes with specific metrics that can be used to measure the success of the business outcome.

## Step 6: Make a decision to proceed or cancel based on the business justification

Business justification can help with planning, long term return expectations, and an expectation of total cost of ownership (TCO). In this step, the cloud strategy team should agree on the minimum amount of analysis required to help the strategy team align on a go-forward decision. Strategic alignment might require deep planning and TCO analysis. Most cloud strategy teams will find a simple cost analysis as a sufficient analysis to align on direction.

Each member of the strategy team should review the common myths and approaches to business justification to help communicate the specific analysis expected from the supporting teams. Once that expectations is communicated, the strategy team can reduce their time investment and meeting cadence. However, the team will maintain accountability for completing the strategy until the business justification and digital estate analysis have both been agreed upon.

**Deliverables:**

- Kick off the business justification effort with supporting teams.
- Meet with the supporting teams monthly (or as needed) until the strategy team can align on a go/no go decision to proceed with cloud adoption.

**Guidance to support deliverable completion:**

- [Business justification](../../strategy/cloud-migration-business-case.md): The business justification serves as a high-level view of the overall financial plan for cloud adoption. This can be a good source for initial budgeting efforts.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud governance team <li> Cloud adoption team <li> Cloud center of excellence or Central IT |

## Step 7: Support adoption through a regular rhythm

Once a go forward strategy decision has been agreed upon with the cloud strategy team, the team can transition into a less intense and less frequent rhythm. The expectations of the team also shifts at this point. Once the journey moves from strategic definition to adoption efforts (plan, ready, adopt), the strategy team is expected to focus on prioritization and strategic support.

**Deliverables:**

- **Prioritization:** When the existing digital estate is rationalized, the strategy team will help establish waves of migration or innovation priorities to help the technical implementation teams focus on actions that drive the greatest business value.
- **Evaluate risks:** As cloud adoption grows, the new forms of adoption will expose new risks. The strategy team is responsible for helping evaluate those new risks. The expectations of the strategy team is to evaluate new risks and determine if the business can tolerate the risk or needs policies that prevent the risk.
- **Review budget and spend:** As cloud adoption increases, so will budgets for various workloads in the portfolio. On a monthly basis, the cloud strategy team should review actual spend against budget to identify issues which need to be resolved. Detecting and addressing budgetary change early will avoid sticker shock later in the adoption lifecycle.
- **Business planning:** When the adoption teams complete migration or innovation efforts, additional business planning will be required to maximize return from the new technology solutions. That could include end user training, business process modifications, or other post adoption activities.
- **Executive support:** Cloud adoption will result in organization change. This is most visible within the IT organization. At times, various teams or team members might need additional support from the strategy team to understand the changes, develop new skills, and understand how to best operate in the new models.

**Guidance to support deliverable completion:**

- [Incremental rationalization](../../digital-estate/rationalize.md): An agile approach to rationalization that properly aligns late-bound technical decisions.
- [The five Rs of rationalization](../../digital-estate/5-rs-of-rationalization.md): Understand the various rationalization options.


<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud governance team <li> Cloud adoption team <li> Cloud center of excellence or Central IT |

## What's next

Strategy and planning are important. However, nothing is actionable without cloud adoption functions. Understand the role of this important capability before beginning adoption efforts.

Align your strategy with the [cloud adoption functions](../../organize/cloud-adoption.md) by working with the adoption team or individuals responsible for this function.

Learn to align responsibilities across teams by developing a cross-team matrix that identifies responsible, accountable, consulted, and informed (RACI) parties. Download and modify the [RACI spreadsheet template](https://archcenter.blob.core.windows.net/cdn/fusion/management/raci-template.xlsx).
