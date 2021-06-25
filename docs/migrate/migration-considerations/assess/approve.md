---
title: Approve architecture changes before migration
description: Learn to classify the architectural changes when they are required and also establish proper approval activities.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/09/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

<!-- cSpell:ignore ITIL -->

# Approve architecture changes before migration

During the assess process of migration, each workload is evaluated, architected, and estimated to develop a future state plan for the workload. Some workloads can be migrated to the cloud with no change to the architecture. Maintaining on-premises configuration and architecture can reduce risk and streamline the migration process. Unfortunately, not every application can run in the cloud without changes to the architecture. When architecture changes are required, this article can help classify the change and can provide some guidance on the proper approval activities.

## Business impact and approval

During migration, some things are likely to change in ways that impact the business. Although change sometimes can't be avoided, surprises as a result of undisclosed or undocumented changes should be. To maintain stakeholder support throughout the migration effort, it's important to avoid surprises as well as negative disruption to business or operations. Surprising application owners or business stakeholders can slow or halt a cloud adoption effort.

Prior to migration, it is important to prepare the workload's business owner for any changes that could affect business processes, such as changes to:

- Service-level agreements.
- Access patterns or security requirements that impact the end user.
- Data retention practices.
- Core application performance.
- Operational practice changes such as support model, change model, cost model changes.
- Anticipated user experience changes.

Even when a workload can be migrated with minimal to no change, there could still be a business impact. Replication processes can slow the performance of production systems. Changes to the environment in preparation for migration have the potential to cause routing or network performance limitations. There are many additional impacts that could result from replication, staging, or promotion activities.

Regular approval activities can help minimize or avoid surprises as a result of change or performance-driven business impacts. The cloud adoption team should establish a suitable change approval process at the end of the assessment process, before beginning the migration process.

## Existing culture

Your IT teams likely have existing mechanisms for managing change involving your on-premises assets. Typically these mechanisms are governed by traditional Information IT Service Management (ITSM) change management processes. In many enterprise migrations, these processes typically involve a change advisory board (CAB) that's responsible for reviewing, documenting, and approving all IT-related requests for changes (RFC).

The CAB generally includes experts from multiple IT and business teams, offering a variety of perspectives and detailed review for all IT-related changes. A CAB approval process is a proven way to reduce risk and minimize the business impact of changes involving stable workloads managed by IT operations.

## Technical approval

Organizational readiness for the approval of technical change is among the most common reasons for cloud migration failure. More projects are stalled by a series of technical approvals than any deficit in a cloud platform. Preparing the organization for technical change approval is an important requirement for migration success. The following are a few best practices to ensure that the organization is ready for technical approval.

### ITSM change advisory board challenges

Every change management approach has its own set of controls and approval processes. Migration is a series of continuous changes that start with a high degree of ambiguity and develop additional clarity through the course of execution. As such, migration is best governed by agile-based change management approaches, with the cloud strategy team serving as a product owner.

However, the scale and frequency of change during a cloud migration doesn't fit well with the nature of change advisory boards. The requirements of a CAB approval can risk the success of a migration, slowing or stopping the effort. Further, in the early stages of migration, ambiguity is high and subject matter expertise tends to be low. For the first several workload migrations or releases, the cloud adoption team is often in a learning mode. As such, it could be difficult for the team to provide the types of data needed to pass a typical CAB approval.

The following best practices can help the CAB maintain a degree of comfort during migration without become a painful blocker.

### Standardize and pre-approve change through standard change models

It is tempting for a cloud adoption team to consider detailed architectural decisions for each workload being migrated to the cloud. It is equally tempting to use cloud migration as a catalyst to refactor past architectural decisions. For organizations that are migrating a few hundred VMs or a few dozen workloads, either approach can be properly managed. When migrating a datacenter consisting of 1,000 or more assets, each of these approaches is considered a high-risk antipattern that significantly reduces the likelihood of success. Modernizing, refactoring, and rearchitecting every application requires a diverse skill set and a wide variety of changes, and these tasks create dependencies on human efforts at scale. Each of these dependencies injects risk into the migration effort.

The article on [digital estate rationalization](../../../digital-estate/rationalize.md) discusses the agility and time-saving impact of basic assumptions when rationalizing a digital estate. By choosing a default (standard) rationalization approach to govern the migration effort, the cloud advisory board or product owner can review and approve the application of one change to a long list of workloads. This reduces technical approval of each workload to those that require a significant architecture change to be cloud compatible. Additionally to this, once the assessment process for the migration has been performed, there should be a clear idea of what changes will be required going forward and this initial list could be used to identify common change types or categories of change (standard changes). The cloud adoption team should meet with the relevant change managers and approvers early in the project to agree on the categories and types of changes in the list, and then establish appropriate pre-approved standard change models that will enable changes to be made without the need of the CAB approval, provided certain criteria or prerequisites for the changes are met. For example, changes can be preapproved for none production, or changes will require a tested backout plan, or changes might need a peer review.

> [!IMPORTANT]
> An organizations ITSM change processes might need to be realigned to work effectively and iteratively with the fast pace of change expected in the cloud. See [Technical complexity](../prerequisites/technical-complexity.md)  for more guidance.

It needs to be understood that this realignment does not happen overnight. The use of standard pre-approved changes will enable a lot more flexibility around the change process, but they need to be carefully managed to ensure the do not result in negative technical or business impact. If a standard change fails and has negative impact technically or operationally, then that pre-approved status should be removed and the change will need to go through a proper risk review and CAB the next time it is required. This practice will help increase confidence with change managers and approvers in the use of standard pre-approved changes.

### Seek approval early

When possible, technical change should be detected and documented during the assessment process as mentioned above. Regardless of approval processes, the cloud adoption team should engage approvers early. The sooner that change approval can begin, the less likely an approval process is to block migration activities.

### Clarify expectations and roles of approvers

Before the first workload is assessed, the cloud strategy team should document and communicate the expectations of anyone involved in the approval of change. This simple activity can avoid costly delays when the cloud adoption team is fully engaged.

### Establishment of a Cloud Change Authority

If possible, a Cloud Change Authority could be established to facilitate triage and potential approvals of cloud changes. Having an authority focusing on the approval of cloud changes can ensure the correct subject matter expertise and context is applied to assess cloud change risk. It can also ensure that additional pressure and risk of a bottleneck at the CAB authority is minimized. Establishing this will require an agreement with change managers, approvers, and likely clear criteria about what can be approved through the Cloud Change Authority, and what will need the CAB authorities approval.

## Next steps

With the help of these best practices, it should be easier to integrate proper, low-risk approval into migration efforts. After workload changes are approved, the cloud adoption team is ready to migrate workloads.

> [!div class="nextstepaction"]
> [Migrate workloads](../migrate/index.md)
