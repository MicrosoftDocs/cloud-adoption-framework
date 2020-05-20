---
title: "Get started: Build a cloud governance team"
description: Establish a governance team's scope, deliverables, and the capabilities to prepare for successful cloud governance.
author: JanetCThomas
ms.author: janet
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.topic: conceptual
ms.date: 05/15/2020
---

# Get started: Build a cloud governance team

A cloud governance team ensure that risks and risk tolerance are properly evaluated and managed. This team ensures the proper identification of risks that can't be tolerated by the business. The people on this team convert risks into governing corporate policies.

![Get started building a cloud governance team](../../_images/get-started/governance-team-map.png)

## Step 1: Determine if a cloud governance team is needed

Official guidance in the Cloud Adoption Framework is to always create a cloud governance team. At first, that team might be exceptionally small. However, regardless of its size, this role will prove important. If a team is not needed, a group or individual on the team should agree to fulfill the responsibilities associated with the [cloud governance functions](../../organize/cloud-governance.md).

**Deliverables:**

- Determine if you need a cloud governance team.
- Document the decision and responsible individuals in the [RACI template](https://archcenter.blob.core.windows.net/cdn/fusion/management/raci-template.xlsx) under the Org Alignment tab.

**Guidance to support deliverable completion:**

- [Cloud governance functions](../../organize/cloud-governance.md) might be spread across multiple individuals or teams already. Having a team that goes by the title "cloud governance team" is of little importance. However, the required capabilities should sit with an accountable party or team.
- If the company's long-term cloud adoption strategy can be delivered from one landing zone in one cloud environment, then the amount of governance and operations efforts might be small enough for delivery by one person or one team. That team is unlikely to be called cloud governance, as they are serving many functions beyond the cloud governance. Even for that team, the following getting start guide will help ensure the team is prepared to deliver on this important function of governance.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud adoption team |

## Step 2: Align with other teams

The governance team ensures consistency and adherence to a set of common policies. Those policies come from an ongoing alignment with other teams. Before establishing policies or automated cloud governance, the cloud governance team should meet with other teams identified in the RACI template to ensure alignment on critical topics such as security, cost, performance, operations, and deployment. Steps 4 and 5 can help facilitate the alignment.

**Deliverables:**

- Discuss current state implementation and ongoing adoption plans with each team.

**Guidance to support deliverable completion:**

- Review your company's [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) with members of the cloud strategy team to understand motivations, metrics, and strategy.
- Review your company's [cloud adoption plan template](../../plan/template.md) with members of the cloud adoption team to understand timelines and prioritization.
- Review the operation team's [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to understand the operational requirements and commitments that have been established with the business.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud governance team | <li> Cloud strategy team <li> Cloud adoption team <li> Cloud operations team <li> Cloud center of excellence or Central IT |

## Step 3: Establish a cadence with other teams

Cloud adoption general comes in waves (or releases). A regular cadence aligned to those releases will allow the cloud governance team to see ahead and understand the risks that will be introduced in the next wave. Staying engaged with the strategy, adoption, and operations teams during planning and review will help the governance team stay ahead of coming risks.

**Deliverables:**

- Establish a cadence with each of the supporting teams. If possible, align that cadence to release and planning cycles.
- Establish a separate cadence directly with the cloud strategy team (or various team members) to review risks associated with the next wave of adoption and gauge their level of tolerance for those risks.

**Guidance to support deliverable completion:**

- Review the [functions of cloud governance](../../organize/cloud-governance.md#deliverable) for additional guidance on meeting cadences.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud governance team | <li> Cloud strategy team <li> Cloud adoption team <li> Cloud operations team |

## Step 4: Review the methodology

Review the Cloud Adoption Framework's Govern methodology to aid in establishing a future vision for governance and a working approach to get to that vision.

**Deliverables:**

- Gain an understanding of the methodology, approach, and implementation that supports the Govern methodology.

**Guidance to support deliverable completion:**

- Review the [Govern methodology](../../govern/methodology.md).

**Accountable team:**

- The cloud governance team is accountable for establishing a vision and approach to governance.

## Step 5: Complete the governance benchmark

Governance is a broad topic. This short assessment can help understand where to get started.

**Deliverables:**

- Complete the governance benchmark assessment based on conversations with various stakeholders (or ask other teams to complete the assessment on their own).

**Guidance to support deliverable completion:**

- Assess your governance needs and priorities with the [governance benchmark](../../govern/benchmark.md)

**Accountable team:**

- The cloud governance team is should understand the gaps identified in the governance benchmark and provide direction on governance that helps address the gaps.

## Step 6: Implement the initial governance best practice and configuration

The Govern methodology includes two approaches to an initial governance foundation. Review each and implement the one that most closely matches your needs.

**Deliverables:**

- Deploy the basic governance tools and organization configurations required to govern the environment during the next few waves of adoption efforts.

**Guidance to support deliverable completion:**

- Review the [initial best practice](../../govern/initial-foundation.md) configuration and implementation guidance.

**Accountable team:**

- The cloud governance team accountable for the review and implementation of governance best practices and an initial governance foundation.

## Step 7: Continuously improve the governance maturity

Governance needs grow as additional cloud adoption is completed. Stay aligned with the ongoing adoption plan to ensure the governance approach can maintain the proper levels of governance and control.

**Deliverables:**

- Implement governance improvements to guard against changing risks and governance needs.

**Guidance to support deliverable completion:**

- Implement [expanded governance scenarios](../../govern/foundation-improvements.md) to improve the initial governance foundation.

**Accountable team:**

- The cloud governance team accountable for aligning with ongoing adoption plans.

## Step 8: Evaluate landing zone changes

As landing zones are deployed and expanded, new risks or governance violations might emerge. Periodically review landing zone configurations to identify deviations from policy, which are not caught the cloud-native governance tools. Ensure that each landing zone deployment adheres to guidelines for landing zone governance.

**Deliverables:**

- Help the cloud platform team develop improvements to the landing zone, which comply with governance policies.

**Guidance to support deliverable completion:**

- Improve [landing zone governance](../../ready/considerations/landing-zone-governance.md).

**Accountable team:**

- The cloud governance team should make sure that each landing zone deployment adheres to governance guidelines.

## Step 9: Adoption handoffs

As new adoption efforts are completed, the cloud adoption team will hand off operational responsibilities to the cloud operations team and cloud governance teams. Stay aligned with adoption releases to ensure proper documentation and policy alignment to assume responsibility for the workloads.

**Deliverables:**

- Regularly review and accept handoffs from cloud adoption teams.

**Guidance to support deliverable completion:**

- Establish a process for [onboarding new workloads and resources](https://docs.microsoft.com/azure/azure-resource-manager/custom-providers/concepts-resource-onboarding).

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption teams | <li> Cloud governance team <li> Cloud operations team |

## What's next

Every company is unique, and so are their governance needs. Choose the level of maturity that fits your organization and use the Cloud Adoption Framework to guide the practices, processes, and tooling to help you get there.

As cloud governance matures, teams are empowered to adopt the cloud at faster paces. Continued cloud adoption efforts tend to trigger maturity in IT operations. Either develop a [cloud operations team](./cloud-operations.md), or sync with your cloud operations team to ensure governance is a part of operations development.
