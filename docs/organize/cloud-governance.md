---
title: Understand cloud governance functions
description: Understand the function of a cloud governance team, including the source, the scope, and the deliverable.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

<!-- docutune:ignore IS -->

# Cloud governance functions

A cloud governance team ensure that risks and risk tolerance are properly evaluated and managed. This team ensures the proper identification of risks that can't be tolerated by the business. The people on this team convert risks into governing corporate policies.

Depending on the desired business outcomes, the skills needed to provide full cloud governance functions include:

- IT governance
- Enterprise architecture
- Security
- IT operations
- IT infrastructure
- Networking
- Identity
- Virtualization
- Business continuity and disaster recovery
- Application owners within IT
- Finance owners

These baseline functions help you identify risks related to current and future releases. These efforts help you evaluate risk, understand the potential impacts, and make decisions regarding risk tolerance. When doing so, quickly update plans to reflect the changing needs of the [cloud migration team](./cloud-migration.md).

## Preparation

- Review the [Govern methodology](../govern/index.md).
- Take the [governance benchmark assessment](../govern/benchmark.md).
- [Introduction to security in Azure](/learn/modules/protect-against-security-threats-azure/): Learn the basic concepts to protect your infrastructure and data in the cloud. Understand what responsibilities are yours and what Azure handles for you.
- Understand how to work across groups to [manage cost](./cost-conscious-organization.md).

## Minimum scope

- Understand [business risks](../govern/policy-compliance/risk-tolerance.md) introduced by the plan.
- Represent the [business's tolerance for risk](../govern/policy-compliance/risk-tolerance.md).
- Help create a [governance MVP](../govern/guides/index.md).

Involve the following participants in cloud governance activities:

- Leaders from middle management and direct contributors in key roles should represent the business and help evaluate risk tolerances.
- The cloud governance functions are delivered by an extension of the [cloud strategy team](./cloud-strategy.md). Just as the CIO and business leaders are expected to participate in cloud strategy functions, their direct reports are expected to participate in cloud governance activities.
- Business employees that are members of the business unit who work closely with the leadership of the line-of-business should be empowered to make decisions regarding corporate and technical risk.
- Information technology (IT) and information security (IS) employees who understand the technical aspects of the cloud transformation may serve in a rotating capacity instead of being a consistent provider of cloud governance functions.

## Deliverable

The cloud governance mission is to balance competing forces of transformation and risk mitigation. Additionally, cloud governance ensures that the [cloud migration team](./cloud-migration.md) is aware of data and asset classification, as well as architecture guidelines that govern adoption. Governance teams or individuals also works with the [cloud center of excellence](./cloud-center-of-excellence.md) to apply automated approaches to governing cloud environments.

**Ongoing monthly tasks:**

- Understand [business risks](../govern/policy-compliance/risk-tolerance.md) introduced during each release.
- Represent the [business's tolerance for risk](../govern/policy-compliance/risk-tolerance.md).
- Aid in the incremental improvement of [policy and compliance requirements](../govern/policy-compliance/index.md).

**Meeting cadence:**

The time commitment from each team member of the cloud governance team will represent a large percentage of their daily schedules. Contributions will not be limited to meetings and feedback cycles.

## Out of scope

As adoption scales, the cloud governance team may struggle to keep pace with innovations. This is especially true if your environment has heavy compliance, operations, or security requirements. If this happens you can shift some responsibilities to an existing IT team to reduce scope for the governance team.

## Next steps

Some large organizations have dedicated teams that focus on IT governance. These teams specialize in risk management across the IT portfolio. When those teams exist, the following maturity models can be accelerated quickly. But the IT governance team is encouraged to review the cloud governance model to understand how governance shifts slightly in the cloud. Key articles include extending corporate policy to the cloud and the Five Disciplines of Cloud Governance.

**No governance:** Organizations often move into the cloud with no clear plans for governance. Before long, concerns around security, cost, scale, and operations begin to trigger conversations about the need for a governance model and people to staff the processes associated with that model. Starting those conversations before they become concerns is always a good first step to overcome the antipattern of "no governance." The section on defining corporate policy can help facilitate those conversations.

**Governance blocked:** When concerns around security, cost, scale, and operations go unanswered, projects and business goals tend to get blocked. Lack of proper governance generates fear, uncertainty, and doubt among stakeholders and engineers. Stop this in its tracks by taking action early. The two governance guides defined in the Cloud Adoption Framework can help you start small, set initially limiting policies to minimize uncertainty and mature governance over time. Choose from the complex enterprise guide or standard enterprise guide.

**Voluntary governance:** There tend to be brave souls in every enterprise. Those gallant few who are willing to jump in and help the team learn from their mistakes. Often this is how governance starts, especially in smaller companies. These brave souls volunteer time to fix some issues and push cloud adoption teams toward a consistent well-managed set of best practices.

The efforts of these individuals are much better than "no governance" or "governance blocked" scenarios. While their efforts should be commended, this approach should not be confused with governance. Proper governance requires more than sporadic support to drive consistency, which is the goal of any good governance approach. The guidance in the Five Disciplines of Cloud Governance can help develop this discipline.

**Cloud custodian:** This moniker has become a badge of honor for many cloud architects who specialize in early stage governance. When governance practices first start out, the results appear similar to those of governance volunteers. But there is one fundamental difference. A cloud custodian has a plan in mind. At this stage of maturity, the team is spending time cleaning up the messes made by the cloud architects who came before them. But the cloud custodian aligns that effort to well structured corporate policy. They also use governance tools, like those outlined in the governance MVP.

Another fundamental difference between a cloud custodian and a governance volunteer is leadership support. The volunteer puts in extra hours above regular expectations because of their quest to learn and do. The cloud custodian gets support from leadership to reduce their daily duties to ensure regular allocations of time can be invested in improving cloud governance.

**Cloud guardian:** As governance practices solidify and become accepted by cloud adoption teams, the role of cloud architects who specialize in governance changes a bit, as does the role of the cloud governance team. Generally, the more mature practices gain the attention of other subject matter experts who can help strengthen the protections provided by governance implementations.

While the difference is subtle, it is an important distinction when building a governance-focused IT culture. A cloud custodian cleans up the messes made by innovative cloud architects, and the two roles have natural friction and opposing objectives. A cloud guardian helps keep the cloud safe, so other cloud architects can move more quickly with fewer messes.

Cloud guardians begin using more advanced governance approaches to accelerate platform deployment and help teams self-service their environmental needs, so they can move faster. Examples of these more advanced functions are seen in the incremental improvements to the governance MVP, such as improvement of the security baseline.

**Cloud accelerators:** Cloud guardians and cloud custodians naturally harvest scripts and governance tools that accelerate the deployment of environments, platforms, or even components of various applications. Curating and sharing these scripts in addition to centralized governance responsibilities develops a high degree of respect for these architects throughout IT.

Those governance practitioners who openly share their curated scripts help deliver technology projects faster and embed governance into the architecture of the workloads. This workload influence and support of good design patterns elevate cloud accelerators to a higher rank of governance specialist.

**Global governance:** When organizations depend on globally dispersed IT needs, there can be significant deviations in operations and governance in various geographies. Business unit demands and even local data sovereignty requirements can cause governance best practices to interfere with required operations. In these scenarios, a tiered governance model allows for minimally viable consistency and localized governance. The article on multiple layers of governance provides more insights on reaching this level of maturity.

Every company is unique, and so are their governance needs. Choose the level of maturity that fits your organization and use the Cloud Adoption Framework to guide the practices, processes, and tooling to help you get there.

As cloud governance matures, teams are empowered to adopt the cloud at faster paces. Continued cloud adoption efforts tend to trigger maturity in IT operations. Either develop a cloud operations team, or sync with your cloud operations team to ensure governance is a part of operations development.

Learn more about starting a [cloud governance team](../get-started/team/cloud-governance.md) or a [cloud operations team](../get-started/team/cloud-operations.md).

After you've established an [initial cloud governance foundation](../govern/initial-foundation.md), use these best practices in [Governance foundation improvements](../govern/foundation-improvements.md) to get ahead of your adoption plan and prevent risks.
