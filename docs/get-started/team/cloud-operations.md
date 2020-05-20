---
title: "Get started: Build a cloud operations team"
description: This guide helps a cloud operations team understand scope, deliverables, and the functionality that they are responsible for.
author: JanetCThomas
ms.author: janet
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.topic: conceptual
ms.date: 05/15/2020
---

# Get started: Build a cloud operations team

An operations team focuses on monitoring, repairing, and the remediation of issues related to traditional IT operations and assets. In the cloud, many of the capital costs and operations activities are transferred to the cloud provider, giving IT operations the opportunity to improve and provide significant additional value.

![Get started building a cloud operations team](../../_images/get-started/operations-team-map.png)

## Step 1: Determine if a cloud operations team is needed

Prior to releasing any workloads into production, an agreement must be reached on the accountability for delivery of [cloud operations functions](../../organize/cloud-governance.md). For some portfolios, operational responsibilities might remain in the DevOps and cloud adoption team. In other cases, a managed service provider with cloud operations experience might assume ongoing operational duties.

If there are no DevOps or service-provider operations agreements in place, it's safe to assume that someone within IT will need to commit to ongoing operational duties regarding the management of any production workloads.

**Deliverables:**

- Determine if you need a cloud operations team.
- Document the decision and responsible individuals in the [RACI template](https://archcenter.blob.core.windows.net/cdn/fusion/management/raci-template.xlsx) under the Org Alignment tab.

**Guidance to support deliverable completion:**

- The [cloud operations functions](../../organize/cloud-operations.md) might be spread across multiple individuals or teams already. You will have to decide if a cloud operations team is required. But some level of operations is always needed for production workloads.
- If the company's long term cloud adoption strategy can be delivered from one landing zone in one cloud environment, then the amount of governance and operations efforts might be small enough to be delivered by one person or one team. That team is unlikely to be called cloud operations, as they will be serving many functions. Even for that team or person, the following guidance will help ensure the team is prepared to deliver on this important function of operations.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud adoption team <li> Cloud governance team |

## Step 2: Align with other teams

The operations team inherits operational responsibilities for all workloads in the production portfolio. Those responsibilities can vary between workloads, based on expectations and commitments made to the business. The architectural decisions made by migration and innovation focused cloud adoption teams also influence operational commitments that can be made. Before implementing any ongoing operations practices, it is important to align with other teams. The cloud operations team should meet with other teams identified in the RACI template to ensure alignment on critical topics such as security, cost, performance, governance, adoption, and deployment. Steps 4 and 5 can help facilitate the alignment.

**Deliverables:**

- Discuss current state implementation and ongoing adoption plans with each team.

**Guidance to support deliverable completion:**

- Review your company's [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) with members of the cloud strategy team to understand motivations, metrics, and strategy.
- Review your company's [cloud adoption plan template](../../plan/template.md) with members of the cloud adoption team to understand timelines and prioritization.
- Begin development of the [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to understand the operational requirements and commitments that have been established with the business.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud operations team | <li> Cloud strategy team <li> Cloud adoption team <li> Cloud governance team <li> Cloud center of excellence or Central IT |

## Step 3: Establish cadence with other teams

Cloud adoption generally comes in waves or releases. A regular cadence aligned to those releases will allow the cloud operations team to prepare for handoffs to be made at the end of the next wave. Staying engaged with the strategy, adoption, and governance teams during planning and review helps the operations team stay ahead of the coming operational demands.

**Deliverables:**

- Establish a cadence with each of the supporting teams. If possible, align that cadence to release and planning cycles.
- Establish a separate cadence directly with the cloud strategy team (or various team members) to review operational requirements associated with the next wave of adoption.

**Guidance to support deliverable completion:**

- See the [cloud operations functions](../../organize/cloud-operations.md#deliverables) for additional guidance on meeting cadences.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud operations team | <li> Cloud strategy team <li> Cloud adoption team <li> Cloud governance team |

## Step 4: Review the methodology

Review the Cloud Adoption Framework's Manage methodology to aid in establishing a future vision for operations management and a working approach to get to that vision.

**Deliverables:**

- Gain an understanding of the methodology, approach, and implementation that supports the Manage methodology.

**Guidance to support deliverable completion:**

- Review the [Manage methodology](../../manage/index.md).

**Accountable team:**

- The cloud operations team is accountable for the vision and approach to operations management.

## Step 5: Implement the operations baseline

If there are no operations practices deployed to your cloud environments, start with the operations baseline. That baseline will implement cloud-native, no-ops/low-ops practices to provide a base level of operational protection.

**Deliverables:**

- Deploy the basic Azure server management configurations required to operate the environment during the next few waves of adoption efforts.

**Guidance to support deliverable completion:**

- Implement the [operations baseline](../../manage/azure-server-management/index.md) configuration.

**Accountable team:**

- The cloud operations team is accountable for the operations baseline.

## Step 6: Align business commitments

Review the operations baseline commitments with the business. This baseline helps you evaluate the general requirements for the majority of workloads. The process also helps identify business stakeholders for various workloads and enables you to document their ongoing operational expectations.

**Deliverables:**

- Document business expectations.
- Determine if advanced operations are required for specific workloads or platforms.

**Guidance to support deliverable completion:**

- Create [business alignment](../../manage/considerations/business-alignment.md) in the cloud.
- Document the portfolio and operations expectations in the [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx).

**Accountable team:**

- The cloud operations team should understand the business expectations and is accountable for ongoing operational alignment with those expectations.

## Step 7: Operations maturity

Operational improvements can result in a few options:

- Enhance the operations baseline.
- Improve platform operations.
- Implement workload specific operations.

As additional workloads are transitioned to cloud operations, the need for operations improvements become clearer.

**Deliverables:**

- Improve operations maturity to support business commitments.

**Guidance to support deliverable completion:**

- Evaluate the best option for [advanced operations management](../../manage/design-principles.md).

**Accountable team:**

- The cloud operations team is accountable for operational improvements and maturity over time.

## Step 8: Scale operations consistency through governance

As operations mature, coordinate with the cloud governance team regularly to apply operations requirements across the portfolio.

**Deliverables:**

- Help the cloud governance team implement new resource consistency requirements.

**Guidance to support deliverable completion:**

- Example of a [resource consistency improvement with governance enforcement](../../govern/guides/complex/resource-consistency-improvement.md).

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud governance team | <li> Cloud operations team |

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

As adoption and operations scale, it's important to define and automate governance best practices that extend existing IT requirements. Forming a cloud center of excellence (CCoE) team is an important step to scaling cloud adoption, cloud operations, and cloud governance efforts.

Learn more about:

- [Cloud center of excellence functions](../../organize/cloud-center-of-excellence.md)
- [Organizational antipatterns: Silos and fiefdoms](../../organize/fiefdoms-silos.md)

Learn to align responsibilities across teams by developing a cross-team matrix that identifies responsible, accountable, consulted, and informed (RACI) parties. Download and modify the [RACI spreadsheet template](https://archcenter.blob.core.windows.net/cdn/fusion/management/raci-template.xlsx).
