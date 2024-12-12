---
title: 'Get started: Document foundational alignment decisions'
description: Understand and document initial decisions required to drive the cloud adoption journey.
author: martinekuan
ms.author: martinek
ms.reviewer: tozimmergren
ms.date: 05/06/2024
ms.topic: conceptual
ms.custom: internal, engagement-fy23, UpdateFrequency3
---

# Get started: Understand and document foundational alignment decisions

Cloud adoption provides numerous business, technical, and organizational benefits. Whatever your organization wants to accomplish along its cloud adoption journey, there are certain initial decisions that every team involved in the journey needs to understand. This article provides a list of steps to help you document design decisions and prepare your organization for its cloud adoption process.

> [!NOTE]
> The links in this article lead to multiple areas of the Cloud Adoption Framework documentation. Bookmarking this article can make it easier for you to find this checklist again after you explore different articles the checklist recommends.

## Before you begin

As you work through this guide, use the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx) to record each foundational decision you make. The template helps you clarify the configuration of your cloud environment and the reasons behind each decision. Having this information in one place enables you to rapidly onboard team members participating in your cloud adoption lifecycle.

If you have an environment running in Azure, you can use [Azure Governance Visualizer](https://github.com/azure/azure-governance-visualizer) to accelerate your documentation. The visualizer provides insight into Azure role-based access control (RBAC), infrastructure as code (IaC) such as Terraform or Bicep, policies, and subscriptions. The visualizer also uses collected data to provide visibility into your hierarchy map, create a tenant summary, and build granular scope insights for your management groups and subscriptions.

## Step 1: Understand how Azure works

When using Azure as the cloud provider for your cloud adoption journey, you need to understand [how Azure works](./what-is-azure.md).

**Involved teams, deliverables, and supporting guidance:**

Everyone involved in your organization's cloud adoption lifecycle should understand what Azure is and how it works.

## Step 2: Understand initial Azure concepts

Azure is built on a set of [foundational concepts](../ready/considerations/fundamental-concepts.md). It would help if you understood these concepts to have in-depth discussions about technical strategy for your Azure implementation.

**Involved teams, deliverables, and supporting guidance:**

Everyone involved in implementing your organization's Azure technology strategy should understand the terms and definitions of Azure's foundational concepts.

## Step 3: Review the portfolio

All cloud hosting and environment decisions require you to understand the portfolio of workloads. Microsoft's Cloud Adoption Framework includes tools to help you understand and evaluate the portfolio.

**Deliverables:**

- In your [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx), record the location and status of the portfolio documentation and who is responsible for managing it.

**Guidance to support deliverable completion:**

- [Fundamental concepts](../ready/considerations/fundamental-concepts.md) help you understand critical Azure topics before embarking on your cloud adoption journey.

- The [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) and business alignment approach help you understand the workloads and assets that transition to your cloud operations team.

- The [cloud adoption plan](../plan/plan-intro.md) provides a backlog of workloads and assets slated for cloud adoption.

- The [digital estate analysis](../digital-estate/approach.md) approach helps you document existing workloads and assets slated for cloud adoption. In Azure, the digital estate is best represented in the [Azure Migrate](/azure/migrate/migrate-support-matrix) tool.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Your cloud strategy team is accountable for defining a way to view the portfolio. | <li> Multiple teams will use the following guidance to create views. Everyone involved in your organization's cloud adoption should know where to find the portfolio view to support decisions further into the adoption process. |

## Step 4: Define portfolio-hierarchy depth to align the portfolio

Some organizations can use a single workload and its supporting assets to host their assets and workloads in the cloud. Other organizations might need to include thousands of workloads and many supporting assets for their cloud adoption strategy. The portfolio hierarchy provides common names for each level, creating a common language regardless of which cloud provider an organization decides to use.

**Deliverables:**

- In your [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx), record all relevant hierarchy needs.

**Guidance to support deliverable completion:**

- Understand the levels of the [portfolio hierarchy](../resources/fundamental-concepts/hosting-hierarchy.md) so you can align fundamental terms.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Your cloud governance team is accountable for defining, enforcing, and automating the portfolio hierarchy to shape corporate policy in the cloud. | <li> Everyone involved in your technology strategy for cloud adoption should be familiar with the portfolio hierarchy and the hierarchy levels in use today. |

## Step 5: Establish naming and tagging standards across the portfolio

All existing workloads and assets should be suitably named and tagged following specific naming and tagging standards. Document these standards and make them available as a reference for all team members. You should enforce the standards automatically whenever possible to ensure minimum tagging requirements.

**Deliverables:**

- In your [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx), record the location and status of your naming and tagging conventions workbook and who is responsible for managing it.

**Guidance to support deliverable completion:**

- Create a [naming and tagging standard](../ready/azure-best-practices/naming-and-tagging.md).

- [Review and update existing tags in Azure](/azure/azure-resource-manager/management/tag-resources).

- [Enforce tagging policies in Azure](/azure/azure-resource-manager/management/tag-policies).

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Your cloud governance team is accountable for defining, enforcing, and automating your naming and tagging standards to ensure consistency across the portfolio. | <li> Everyone involved in your technology strategy for cloud adoption should be familiar with your naming and tagging standards before cloud deployment. |

## Step 6: Create a resource organization design to implement the portfolio hierarchy

You must create a resource organization design to ensure consistent alignment with the portfolio hierarchy decisions. This design aligns organizational tools from your cloud provider with the portfolio hierarchy that supports your cloud adoption plan. It also helps guide your implementation by clarifying which assets you can deploy into specific boundaries within a cloud environment.

**Deliverables:**

- In your [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx), map Azure products to the aligned level of the portfolio hierarchy.

**Guidance to support deliverable completion:**

- Understand how [Azure products support the portfolio hierarchy](../resources/fundamental-concepts/hierarchy-azure-tools.md).

- Review your existing subscriptions for alignment with your chosen portfolio hierarchy.

Build a subscription strategy:

- [Start with two subscriptions](../ready/azure-best-practices/initial-subscriptions.md). Add basic subscription designs to account for common enterprise needs like shared services or [sandbox subscriptions.](../ready/considerations/sandbox-environments.md)

- Ensure you can [manage multiple subscriptions](../ready/azure-best-practices/organize-subscriptions.md) as more subscriptions are needed to support your cloud adoption plan.

- Establish [clear boundaries based on the portfolio hierarchy](../resources/fundamental-concepts/hierarchy-azure-tools.md#organizing-the-hierarchy-in-azure).

- [Move resource groups and assets between subscriptions](/azure/azure-resource-manager/management/move-resource-group-and-subscription) when necessary to adhere to your organization strategy.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Your cloud governance team is accountable for defining, implementing, and automating your resource organization design across the portfolio. | <li> Everyone involved in your technology strategy for cloud adoption should be familiar with your resource organization design before cloud deployment. |

## Step 7: Map capabilities, teams, and RACI to fundamental concepts

Portfolio hierarchy complexity informs organizational structures and methodologies that guide the day-to-day activities of your various teams.

**Deliverables:**

- Complete the getting started guides for organizational alignment.

**Guidance to support deliverable completion:**

- Use the previous steps to evaluate the [portfolio hierarchy accountability guidance](../resources/fundamental-concepts/hosting-hierarchy.md#hierarchy-accountability-and-guidance). Determine which capabilities, if any, might need to be delivered by dedicated organizations or virtual teams.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Your cloud strategy team is accountable for aligning virtual or dedicated organizational structures to ensure the success of your cloud adoption lifecycle. | <li> Everyone involved in your cloud adoption lifecycle should be familiar with the alignment of people and levels of accountability. |

<!-- docutune:ignore "Get started" -->

## Next steps

Follow the guides in the "Get started" section of the Microsoft Cloud Adoption Framework to build on these foundational concepts.

> [!div class="nextstepaction"]
> [Apply fundamental concepts to other getting started guides](./index.md)
