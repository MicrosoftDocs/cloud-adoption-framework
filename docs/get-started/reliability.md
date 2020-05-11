---
title: "Get started: Improve reliability with the right controls"
description: Learn the basics of improving reliability through governance controls and a management baseline.
author: JanetCThomas
ms.author: janet
ms.date: 04/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

<!-- docsTest:ignore Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template -->

# Get started: Improve reliability with the right controls

How do we apply the right controls to improve reliability? This guide helps minimize disruptions related to inconsistencies in configuration, resource organization, security baselines, or resource protection. The steps in this guide will help the operations team balance reliability and cost across the IT portfolio and aid the governance team in ensuring that balance is applied consistently. Reliability also depends on other roles and functions. This article maps those various supporting functions to help you create alignment between each of the involved teams.

Operations management and governance are equal partners in enterprise reliability. The decisions made regarding operational practices set the baseline for reliability. The approaches used to govern the overall environment ensure consistency across all resources. The first two steps in this guide help both teams get started. While they are listed sequentially, the following steps can progress in parallel. The subsequent steps help get the entire enterprise started on a shared journey towards more reliable solutions throughout the enterprise.

![Get started with enterprise reliability](../_images/get-started/reliability-map.png)

## Step 1: Establish operations management requirements

All workloads are not created equal. In any environment, there are workloads that have a direct and constant impact on the business. There are also supporting business processes and workloads that have a smaller impact on the overall business. In this step, the cloud operations team identifies and implements initial requirements to support the overall IT portfolio.

**Deliverables:**

- Implement a management baseline to define standard operations required for all production workloads.
- Negotiate business commitments with the cloud strategy team to develop a plan for advanced operations and resiliency requirements.
- Expand your management baseline, if additional operations are required for the majority of workloads.
- Apply advanced operations requirements to landing zones and resources that support higher criticality workloads.
- Document operations decisions across the IT portfolio in the [operations management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx).

**Guidance to support deliverable completion:**

- **[Management baseline](../manage/considerations/discipline.md):**

  - [Inventory and visibility](../manage/considerations/inventory.md): [Cloud-native tools](../manage/azure-management-guide/inventory.md) can help [collect data](../manage/monitor/data-collection.md), [configure alerts](../manage/monitor/index.md), and implement the [monitoring platform](../manage/monitor/index.md) that best fits your operating model.
  - [Operational compliance](../manage/considerations/operational-compliance.md): The highest percentages of outages tend to come from changes to resource configuration or poor maintenance practices. Follow the [Azure server management guide](../manage/azure-server-management/index.md) to implement cloud native tools to manage patching and changes to resource configuration.
  - [Protection and recovery](../manage/considerations/protect.md): Outages are inevitable on any platform. When a disruption occurs, be prepared with [backup and recovery solutions](../manage/azure-management-guide/protect-recover.md) to minimize the duration of any disruption.

- **[Advanced operations](../manage/design-principles.md):** Use the management baseline as the foundation for [business alignment](../manage/considerations/business-alignment.md) conversations to create clarity regarding [criticality](../manage/considerations/criticality.md), [business impact](../manage/considerations/impact.md), and [operations commitments](../manage/considerations/commitment.md). Business alignment helps quantify and validate requests for an [enhanced baseline](../manage/azure-management-guide/enhanced-baseline.md), management of specific [technology platforms](../manage/azure-management-guide/workload-specialization.md), or [workload-specific operations](../manage/azure-management-guide/platform-specialization.md).

- **Guide an architecture review:** Architecture changes at the workload level might be required to meet operations requirements. The [Azure Architecture Framework](https://docs.microsoft.com/azure/architecture/framework/cost/tradeoffs) and [Azure Architecture Review](https://docs.microsoft.com/assessments?id=azure-architecture-review) can help guide those conversations with the technical owner of a specific workload.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud operations team | <li> Cloud strategy team <li> Cloud adoption team <li> Cloud governance team <li> Cloud center of excellence or Central IT |

## Step 2: Consistently apply the management baseline

Enterprise reliability requires consistent application of the management baseline. That consistency comes from appropriate corporate policy, IT processes, and automated tools to govern the implementation of the management baseline for all affected resources.

**Deliverables:**

- Ensure proper application of the management baseline for all affected systems.
- Document your Resource Consistency policies, processes, and design guidance in the [Resource Consistency discipline template](../govern/resource-consistency/template.md).

**Guidance to support deliverable completion:**

- Ensure all workloads and resources follow [proper naming and tagging conventions](../ready/azure-best-practices/naming-and-tagging.md) and [enforce tagging conventions using Azure Policy](https://docs.microsoft.com/azure/governance/policy/tutorials/govern-tags), with a specific emphasis on tags for "criticality".
- If you are new to cloud governance, establish [governance policies, processes, and disciplines](../govern/index.md) using the Govern methodology.
- If you are new to the Cost Management discipline, consider following the [cost management improvements article](../govern/guides/complex/cost-management-improvement.md), with a focus on the [implementation](../govern/guides/complex/cost-management-improvement.md#incremental-improvement-of-the-best-practices) section.

> [!NOTE]
> **Steps to start reliability partnerships with other teams:** Various decisions throughout the cloud adoption lifecycle can have a direct impact on reliability. The following steps help outline the partnerships and supporting efforts required to deliver consistent reliability across the IT portfolio.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud governance team | <li> Cloud strategy team <li> Cloud operations team <li> Cloud center of excellence or Central IT |

## Step 3: Define your strategy

**Deliverables:**

- Record motivations, outcomes, and business justification in the [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx).
- Ensure the management baseline provides operational support which aligns to the strategic direction of cloud adoption.

**Guidance to support deliverable completion:**

- [Understand motivations](../strategy/motivations.md): Critical business events and some migration motivations tend to be cost sensitive, which increases the importance of cost control for all subsequent efforts. Other forward looking motivations related to innovation or growth through migration might be focused more on top-line revenue. Understanding motivations helps you understand how high of a priority cost management should be.
- [Business outcomes](../strategy/business-outcomes/index.md): Some fiscal outcomes tend to be extremely cost sensitive. When the desired outcomes map to fiscal metrics, you should invest in the Cost Management discipline of governance early.
- [Business justification](../strategy/cloud-migration-business-case.md): The business justification serves as a high-level view of the overall financial plan for cloud adoption. This can be a good source for initial budgeting efforts.

Strategic decisions directly affect reliability, rippling through the adoption lifecycle and into long-term operations. Strategic clarity improves reliability efforts.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or Central IT |

## Step 4: Develop a cloud adoption plan

The digital estate (or analysis of the existing IT portfolio) can aid in validating the business justification and provide a refined view of the overall IT portfolio. The adoption plan provides clarity on the timeline of activities during adoption. Aligning that plan and digital estate analysis provides a means of planning for future operations management dependencies. Understanding the plan also invites the cloud operations team into the development cycles to evaluate and plan for any changes to the management baseline, required to provide workload operations.

**Deliverables:**

- Update the [strategy and plan template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) to reflect change that is needed to realize the desired strategy. The changes recorded can include the following:
  - An assessment of the existing digital estate.
  - A cloud adoption plan reflecting required changes and work involved.
  - The organizational change required to deliver on the plan.
  - A plan for addressing the skills that are needed to enable the existing team to successfully complete the required work.
- Work with the governance team to align cost models and forecast models, including efforts to start optimizing spend through quantitative analysis.

**Guidance to support deliverable completion:**

- [Gather inventory](../digital-estate/inventory.md). Establish a source of data for analysis of the digital estate prior to adoption.
- [Best practice - Azure Migrate](../plan/contoso-migration-assessment.md). Use Azure Migrate to gather inventory.
- [Incremental rationalization](../digital-estate/rationalize.md#incremental-rationalization). During incremental rationalization a quantitative analysis can identify cloud candidates for budgeting purposes.
- [Align cost models and forecast models](../digital-estate/calculate.md). Use Azure Cost Management to align cost and forecast models by [creating budgets](https://docs.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).
- [Build your cloud adoption plan](../plan/plan-intro.md#build-your-cloud-adoption-plan). Build a plan with actionable workload, assets, and timeline details.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud adoption team <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or Central IT |

## Step 5: Implement landing zone best practices

The Ready methodology of the Cloud Adoption Framework focuses heavily on the development of landing zones to host workloads in the cloud. During landing zone implementation, multiple decisions could affect operations. Consult the cloud operations team to help review the landing zone for operations improvements. Also consult the cloud governance team to understand "resource consistency" policies and design guidance that might affect the landing zone design.

**Deliverables:**

- Deploy one or more landing zones capable of hosting workloads in the short term adoption plan.
- Ensure all landing zones meet operations decisions and resource consistency requirements.

**Guidance to support deliverable completion:**

- [Improve landing zone operations](../ready/considerations/landing-zone-operations.md): Best practices for improving operations within a given landing zone.

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud operations team <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or Central IT |

## Step 6: Complete waves of adoption effort and change

Long-term operations can be affected by the decisions made during migration and innovation efforts. Maintaining consistent alignment early in adoption processes helps remove barriers to production releases, and reduces the effort required to onboard new solutions into operations management practices.

**Deliverables:**

- Test operational readiness of production deployments using Resource Consistency policies.
- Validate adherence to resource consistency design guidance and operations requirements.
- Document any advanced operations requirements in the [operations management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx).

**Guidance to support deliverable completion:**

- [Environmental readiness checklist](../migrate/migration-considerations/prerequisites/planning-checklist.md)
- [Pre-promotion checklist](../migrate/migration-considerations/optimize/ready.md)
- [Production release checklist](../migrate/migration-considerations/optimize/promote.md)

<!-- markdownlint-disable MD033 -->
<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team <li> Cloud operations team <li> Cloud governance team <li> Cloud center of excellence or Central IT |

## Value statement

The above steps will help implement the right controls and processes needed to ensure reliability across the enterprise and all hosted resources.
