---
title: Balance competing priorities
description: Learn strategies for balancing competing priorities.
author: martinekuan
ms.author: martinek
ms.date: 03/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Balance competing priorities

The success of any digital transformation is determined by the business and technology stakeholders' ability to balance competing priorities.

Like other digital transformations, cloud adoption exposes competing priorities throughout the adoption lifecycle. And as with other forms of transformation, the ability to balance those priorities has a significant effect on the realization of business value. Balancing these competing priorities requires open and sometimes difficult conversations among stakeholders, and sometimes with individual contributors.

This article outlines some of the competing priorities commonly discussed during the implementation of each methodology. It can help you prepare for those discussions when you develop your cloud adoption strategy.

![Diagram that provides an overview of the cloud adoption lifecycle.](../_images/caf-overview.png)

The following sections align to the flow in the preceding cloud adoption lifecycle diagram. However, it's important to recognize that cloud adoption is an iterative process, not a sequential one, and that these competing priorities might reemerge at various points during your cloud adoption journey.

## The general theme of the Cloud Adoption Framework approach

Monolithic solutions and advanced planning are both built on a series of assumptions that might prove to be inaccurate over time. Adopting the cloud is often a new experience for a business and its technical teams. As with most new experiences, there's some likelihood that that initial assumptions will be proven incorrect.

Following proven agile principles of delayed technical decisions is the favored approach for most guidance within this framework. That approach follows a consistent pattern: establish a general end state, move quickly to initial implementation, test and validate assumptions, and refactor early to address faulty assumptions. This type of growth mindset maximizes learning and minimizes risk to business value, but it requires some comfort with ambiguity.

Ambiguity can sometimes be scarier, or more dangerous, than false assumptions. Although this framework prioritizes learning and addressing ambiguity during implementation, many situations require the team to prioritize analysis-based or assumption-based approaches. The following sections provide at least one "expanded scope example" to illustrate when a second deeper iteration might be valuable.

## Balance during the strategy phase

The core objective of the Strategy methodology is to develop alignment among stakeholders. After it's defined, the aligned strategic position drives behavior throughout each of the methodologies to ensure that technical decisions align with desired business outcomes. Fostering alignment among stakeholders creates a common set of competing priorities: *depth of justification* versus *time to business impact*.

**Competing priorities:**

- **Depth of justification:** Stakeholders often want a deep financial analysis and full business justification before they're comfortable with aligning to a strategic direction. Unfortunately, that level of analysis might require an extended time period to allow for data collection and analysis.
- **Time to business impact:** Conversely, stakeholders are often held accountable for delivering business outcomes within defined timeframes. Time-consuming analysis and assessment can put those outcomes at risk before the technical work even begins.

**Minimum scope:** Finding the correct balance requires stakeholder discussions early in the process. The Strategy methodology suggests limiting the scope of alignment during this early effort. In the suggested approach, stakeholders focus on aligning around a set of core motivations, measurable outcomes, and a high-level business justification. Stakeholders should then quickly commit to a few initial projects or pilots to drive required learning opportunities.

**Expanded scope example:** If the initial business analysis indicates a high risk of negatively affecting the business, stakeholders might need to slow down and more cautiously evaluate a deeper analysis during business justification.

## Balance during the planning phase

As during the strategy phase, there's a need during the planning phase to balance the depth of initial planning versus delayed technical decisions.

**Competing priorities:**

- **Depth of initial planning** for technical implementation in the cloud is often based on many assumptions. Especially when there are skill gaps on the team, the environment suffers from discovery gaps, or the workloads don't have clearly defined architectural end states. All of these assumptions are common in detailed cloud adoption plans. Experimentation, pilots, and qualitative analysis are required to verify or improve upon these assumptions.
- **Delayed technical decisions** are based on the assumption that the later a technical decision is made, the more accurate it is. Following principles of agile product planning helps to delay technical decisions, allowing them to happen at the right time, based on sufficient information. However, this approach results in more ambiguity in the initial plan.

**Minimum scope:** We suggest agile product development approaches to drive prompt action within manageable plans. The Plan methodology recommends the following steps to achieve this balance: 
1. Inventory the full digital estate by using automated discovery tools, but use incremental rationalization to plan as far as the next 1 to 3 months of work. 
1. Ensure proper organizational alignment to move quickly. 
1. Create a skills readiness plan for the assigned team. Use the strategy and plan template to quickly deploy an initial backlog.

**Expanded scope example:** The delivery of a cloud adoption plan might sometimes be in response to a time-sensitive or high-impact business event. When success requires the movement of a high number of assets during a fixed period of time, the preceding steps are often followed by a deeper planning effort. The key to success in these scenarios is to plan enough to get going, and then later plan for the full engagement. This approach reduces the likelihood that planning will block business outcomes.

## Balance during the readiness phase

When teams are preparing for their first steps into cloud adoption, there are often competing priorities between time to adoption and long-term operations. The team might struggle with the balance between being well suited to deliver on the task at hand and being well managed. This struggle is necessary in traditional IT environments, where the act of developing a platform requires physical assets and acquisition cycles. However, when the entire IT platform is defined in code, traditional development tactics, like refactoring, reduce the need to be well managed from the beginning.

**Competing priorities:**

- **Long-term operations:** Organizations are often blocked by the desire to have a cloud environment that meets feature parity with current operations management, governance, and security systems. In one study, more than 90 percent of organizations needed support to get past that mindset. This blocker can create months of delay, slowing down or preventing business impact.
- **Time to adoption:** Cloud-based tools like Azure Policy, Azure Blueprints, and management groups can simplify the process of refactoring across the IT platform. Additionally, predefined landing zones provide recommendations to accelerate deployment toward an environment that already meets many feature parity requirements. These tools provide opportunities to accelerate time to market with minimal effect on long-term operations.

**Minimum scope:** The Ready methodology outlines a direct path from rapid adoption to long-term operations. This approach starts with a basic introduction to the tools that you can use to refactor your environment. The tools take into account your requirements and guide you to a selection of predefined landing zones, each delivered with infrastructure as code models. You can then refactor the code during the course of cloud adoption to improve operations, security, and management.

<!-- docutune:casing "Govern and Manage methodologies" -->

**Expanded scope example:** For teams whose adoption plan calls for a mid-term objective (within 24 months) to host more than 1,000 assets (applications, infrastructure, or data assets) in the cloud, we recommend a more robust view of landing zones. In these situations, you should consider the Govern and Manage methodologies during your initial landing zone conversations. However, this deeper consideration often adds weeks or months to a cloud adoption plan. To minimize the effect on business outcomes, the adoption team should pilot actual workloads in the cloud while, at the same time, creating a more mature landing zone and central architecture solution.

## Balance during the migration phase

During migration, adoption teams commonly assume that workloads will be rehosted in the cloud in their current configuration. This assumption competes with a forward-looking plan to rearchitect every workload to better take advantage of cloud capabilities. The two views aren't mutually exclusive and can be complimentary when you manage them by using a common process.

**Competing priorities:**

- **Rehost:** Organizations often equate migration with a *lift-and-shift* approach that replicates all assets to the cloud in their current configuration. This approach results in little drift within the IT portfolio. It's also the fastest way to retire assets in an existing datacenter.
- **Rearchitect:** Modernizing the architecture of each workload maximizes the value of cloud adoption across cost, performance, and operations. However, this approach is slower and often requires access to each applications' source code.

**Minimum scope:** During early-stage planning, use the rehost option for planning, with a clear understanding that this choice is based on an initial business assumption and isn't a technical decision. In the Migrate methodology, the cloud adoption team then challenges this assumption for each migrated workload. This methodology follows the assess/migrate/promote approach for each workload or group of workloads to create a migration factory. During the assessment phase, the adoption team evaluates the technical fit and architecture of each workload. That assessment effort seldom results in a pure lift-and-shift approach because many of the components in the architecture tend to be selected for refactoring and modernization.

**Expanded scope example:** For mission-critical or high-sensitivity workloads, like mainframe or multitier microservices applications, a more thorough assessment of the workload might be required during the assessment phase. In these rearchitecture situations, you should use the Azure Well-Architected Review and the [Azure Well-Architected Framework](/azure/architecture/framework) to refine workload requirements during the assessment.

## Balance during the innovation phase

True customer-facing innovation frequently creates conflicting priorities between the need to deliver on a planned feature set and a implementing customer-empathy development process.

**Competing priorities:**

- **Feature focus:** Initial plans for innovation build on the existing digital estate and cloud capabilities to deliver a set of features that meet a customer need. It's easy to allow the plan to drive technical implementation, leading to a feature-focused development effort. This approach often leads to temporary stakeholder satisfaction but reduces the likelihood of driving innovation that influences customer behavior.
- **Customer empathy:** Initial plans are an important part of the business side of development and should be included in regular reporting. However, learning, measuring, and building with customer empathy as a goal is a more accurate measure of success in an innovation effort. Focusing on customers over features is more likely to result in short-term and long-term customer satisfaction and business impact.

**Minimum scope:** The Innovate methodology illustrates how to integrate strategy and plans through business-value consensus. The guide then introduces cloud-native tools that can accelerate each discipline of innovation and best practices for implementation. Finally, the process improvements section demonstrates approaches for building customer empathy while respecting plans and strategies across the cloud adoption journey. This approach focuses on delivering innovation with the use of as little technology as possible.

**Expanded scope example:** An innovation is sometimes dependent on mission-critical or high-sensitivity workloads. When the customer is an internal user, the development effort might be both mission-critical and high-sensitivity during the earliest iterations. In these scenarios, adoption teams should use the Azure Well-Architected Review and the [Azure Well-Architected Framework](/azure/architecture/framework) to evaluate advanced architectural design early in the process.

## Balance during the governance phase

The practice of cloud governance is a balance between two competing priorities: speed and agility versus a well-governed environment. The cloud governance team focuses on evaluating and minimizing risks to the business through uniform controls and minimizing change. The adoption team focuses on driving business outcomes, which require new risks and inherently creates change.

**Competing priorities:**

- **Well-governed:** Every control designed to minimize risk blocks some aspect of change or limits design options. Control is essential to a well-governed environment. However, when controls are designed and deployed in isolation, they can be as damaging as the risks they're intended to prevent.
- **Speed and agility:** Speed and agility are fundamental business requirements in the digital economy. Both require the ability to drive change with minimal blockers to innovation or adoption. But when change is driven without governance, it generates new risks that could harm the business in unexpected ways.

**Minimum scope:** The Govern methodology suggests that neither governance nor adoption should ever happen in isolation. This methodology starts with an understanding of the governance disciplines and a conversation about business risk, policy, and process. As an active participant throughout cloud adoption, the governance team can implement a minimum set of safeguards to address the tangible risks within the cloud adoption plan. Over time, the governance team can refactor and expand those safeguards to meet new risks. This approach maximizes learning and innovation while minimizing risk.

**Expanded scope example:** When business risk is high, especially early in adoption, the cloud governance team might need to speed up the expansion of governance implementations. You can use the same guidance and exercises to add this higher level of governance, but you might need to go faster. In some scenarios, an advanced state of governance might even be required while you're developing the first landing zones.

## Balance during the management phase

The IT business model for operations management has continuously evolved over the past decade. As hardware maintenance moves further from IT's core value proposition, the view on operations management has shifted. As IT increases a focus on delivering business value, operations management teams are conflicted by the need to balance no-ops and low-ops versus broad investments.

**Competing priorities:**

- **Broad investments:** Investing equally in outage avoidance, rapid recovery, and monitoring across the environment is the traditional approach to operations management. This approach can be expensive and sometimes duplicates the supporting products provided by the cloud vendor.
- **No-ops and low-ops:** Use cloud-native operations tools to minimize repetitive and recurring tasks that were previously delivered by your employees. Reducing these operational dependencies frees employees to drive value in other ways. In isolation, however, this approach can lead to subpar operations support.

**Minimum scope:** The Manage methodology suggests establishing a cloud-native, no-ops baseline. Acknowledging that the no-ops baseline won't meet all business needs, work with the business to define commitments and better align investments. Expand the baseline to meet common needs for all workloads. Then enable platform teams or specific workload teams to maintain well-managed solutions within a well-managed environment.

**Expanded scope example:** In most environments, the business value of a small percentage of workloads justifies deep investments in operations from IT. For those workloads, the IT team might want to use the Azure Well-Architected Review and the Azure Well-Architected Framework to guide deeper operations.

## Balance during the organization phase

The competing priorities described in this article reflect IT's drive to deliver on business demands for speed and agility. The same shift is appearing in changes to org charts or virtual team structures to provide better support for business outcomes. As IT leaders reflect on team structures, two competing priorities are commonly addressed: centralized control versus delegated control.

**Competing priorities:**

- **Centralized control:** This operating model focuses on the centralization of all controls that are required to enforce rigid policies. In this model, IT serves as a blocker to innovation, speed, and agility. However, IT can ensure a higher degree of stability, compliance, and security.
- **Delegated control:** In this distributed operating model, it's assumed that each DevOps team or business application team will provide their own set of controls, based on the solutions that are required to deliver on business objectives. In this model, IT provides guidelines to help teams avoid risks but minimizes the number of enforced technical constraints whenever possible.

**Minimum scope:** Most organizations go through a natural set of evolutions over time. The Organize methodology outlines the most common series of evolutions. We recommend that teams try to move toward a cloud center of excellence (CCoE) structure to deliver delegated control approaches.

**Expanded scope example:** Many situations trigger a need for centralized control. Third-party compliance requirements and temporary security exposure are two examples of triggers for centralized control. In these situations, there's commonly a need to establish limiting policies and rigid, fixed controls. However, to enable innovation and adoption to continue, we encourage central IT teams to deliver those controls based on the criticality and sensitivity of each workload. Providing environments with less control but a reduced scope or risk profile allows flexibility even when control is required.

## Next steps

Learn to [balance migration, innovation, and experimentation](./balance-the-portfolio.md) to maximize the value your cloud migration efforts.

> [!div class="nextstepaction"]
> [Balance the portfolio](./balance-the-portfolio.md)
