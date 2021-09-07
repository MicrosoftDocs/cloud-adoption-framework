---
title: "Get started: Document foundational alignment decisions"
description: Understand and document initial decisions required to drive the cloud adoption journey.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Get started: Understand and document foundational alignment decisions

The cloud adoption journey can unlock many business, technical, and organizational benefits. Whatever you want to accomplish, if your journey involves the cloud, there are a few initial decisions that every team involved should understand.

> [!NOTE]
> Selecting any of the following links might lead you to bounce around the table of contents for the Microsoft Cloud Adoption Framework for Azure, looking for fundamental concepts that you'll use later to help the team implement the associated guidance. Bookmark this page to come back to this checklist often.

## Before you begin

As you work through this guide, record our foundational decisions using the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx). The template can help you quickly onboard team members who participate in the cloud adoption lifecycle by clarifying how your cloud environment is configured and why.

If you already have an environment running in Azure, the [Azure governance visualizer](https://github.com/microsoft/CloudAdoptionFramework/tree/master/govern/AzureGovernanceVisualizer) can help you accelerate your documentation. Gain insight into policies, Azure role-based access control (Azure RBAC), Azure Blueprints, subscriptions, and more. From the collected data the tool provides visibility on your hierarchy map, creates a tenant summary, and builds granular scope insights about management groups and subscriptions.

## Step 1: Understand how Azure works

If you've chosen Azure as a cloud provider to support your cloud adoption journey, it's important to understand [how Azure works](./what-is-azure.md).

**Involved teams, deliverables, and supporting guidance:**

Everyone involved in the cloud adoption lifecycle should have a basic understanding of how Azure works.

## Step 2: Understand initial Azure concepts

Azure is built on a set of [foundational concepts](../ready/considerations/fundamental-concepts.md) that are required for a deep conversation about the technical strategy for Azure implementations.

**Involved teams, deliverables, and supporting guidance:**

Everyone involved in Azure implementation of the technology strategy should understand the terms and definitions in the foundational concepts.

## Step 3: Review the portfolio

Whatever cloud provider you choose, all cloud hosting and environmental decisions start with an understanding of the portfolio of workloads. The Cloud Adoption Framework includes a few tools for understanding and evaluating the portfolio.

**Deliverables:**

- Record the location, status, and accountable person for the portfolio documentation in the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx).

**Guidance to support deliverable completion:**

- [Fundamental concepts](../ready/considerations/fundamental-concepts.md) help you understand key Azure topics before you begin your cloud adoption.
- The [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) and business alignment approach help you understand the workloads and assets that have been transitioned to a cloud operations team.
- The [cloud adoption plan](../plan/plan-intro.md) provides a backlog of the workloads and assets that are slated for adoption in the cloud.
- [Digital estate analysis](../digital-estate/approach.md) is an approach to documenting existing workloads and assets that are slated for adoption in the cloud. In Azure, the digital estate is best represented in a tool called [Azure Migrate](/azure/migrate/migrate-support-matrix).

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> The cloud strategy team is accountable for defining a way to view the portfolio. | <li> Multiple teams will use the following guidance to create those views. Everyone involved in cloud adoption should know where to find the portfolio view to support decisions later in the process. |

## Step 4: Define portfolio-hierarchy depth to align the portfolio

Hosting assets and workloads in the cloud can be simple, consisting of a single workload and its supporting assets. For other customers, the cloud adoption strategy might include thousands of workloads and many more supporting assets. The portfolio hierarchy gives common names for each level to help create a common language for organization, regardless of the cloud provider.

**Deliverables:**

- Record the relevant hierarchy needs in the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx).

**Guidance to support deliverable completion:**

- Understand the levels of the [portfolio hierarchy](../reference/fundamental-concepts/hosting-hierarchy.md) to align fundamental terms.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> The cloud governance team is accountable for defining, enforcing, and automating the portfolio hierarchy to shape corporate policy in the cloud. | <li> Everyone involved in the technical strategy for cloud adoption should be familiar with the portfolio hierarchy and the levels of the hierarchy in use today. |

## Step 5: Establish a naming and tagging standard across the portfolio

All existing workloads and assets should be properly named and tagged in accordance with a naming and tagging standard. Those standards should be documented and available as a reference for all team members. When possible, the standards should also be automatically enforced to ensure minimum tagging requirements.

**Deliverables:**

- Record the location, status, and accountable party for the naming and tagging conventions workbook in the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx).

**Guidance to support deliverable completion:**

- Create a [naming and tagging standard](../ready/azure-best-practices/naming-and-tagging.md).
- Populate the [naming and tagging conventions tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx) to track decisions.
- [Review and update existing tags in Azure](/azure/azure-resource-manager/management/tag-resources).
- [Enforce tagging policies in Azure](/azure/azure-resource-manager/management/tag-policies).

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> The cloud governance team is accountable for defining, enforcing, and automating the naming and tagging standards to ensure consistency across the portfolio. | <li> Everyone involved in the technical strategy for cloud adoption should be familiar with the naming and tagging standards before deployment to the cloud. |

## Step 6: Create a resource organization design to implement the portfolio hierarchy

To ensure consistent alignment with the portfolio hierarchy decisions, it's important to create a design for resource organization. Such a design aligns organizational tools from the cloud provider with the portfolio hierarchy required to support your cloud adoption plan. This design will guide implementation by clarifying which assets can be deployed into specific boundaries within the cloud environments.

**Deliverables:**

- Map Azure products to the aligned level of the portfolio hierarchy in the [initial decision template](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/references/initial-decisions-checklist.docx).

**Guidance to support deliverable completion:**

- Understand how [Azure products support the portfolio hierarchy](../reference/fundamental-concepts/hierarchy-azure-tools.md).
- Review existing subscriptions for alignment to the chosen portfolio hierarchy.

Build a subscription strategy:

- Start with [Two subscriptions by design](../ready/azure-best-practices/initial-subscriptions.md). Add basic subscription designs to account for common enterprise needs, like shared services or sandbox subscriptions.
- [Manage multiple subscriptions](../ready/azure-best-practices/organize-subscriptions.md) as additional subscriptions are required to support the cloud adoption plan.
- Establish [clear boundaries based on the portfolio hierarchy](../reference/fundamental-concepts/hierarchy-azure-tools.md#organizing-the-hierarchy-in-azure).
- When required, [move resource groups and assets between subscriptions](/azure/azure-resource-manager/management/move-resource-group-and-subscription) to adhere to the organization strategy.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> The cloud governance team is accountable for defining, implementing, and automating the resource organization design across the portfolio. | <li> Everyone involved in the technical strategy for cloud adoption should be familiar with the resource organization design before deployment to the cloud. |

## Step 7: Map capabilities, teams, and RACI to fundamental concepts

Complexity of the portfolio hierarchy will help inform organizational structures and methodologies to guide the day-to-day activities of various teams.

**Deliverables:**

- Complete the getting started guides for organizational alignment based on these concepts.

**Guidance to support deliverable completion:**

- Use the prior steps as a guide to evaluate the [portfolio hierarchy accountability guidance](../reference/fundamental-concepts/hosting-hierarchy.md#hierarchy-accountability-and-guidance). Determine which capabilities might need to be delivered by dedicated organizations or virtual teams.
- Use [Get started: Align your organization](./org-alignment.md) to apply the portfolio hierarchy accountability guidance to the RACI (responsible, accountable, consulted, and informed) diagram.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> The cloud strategy team is accountable for aligning virtual or dedicated organizational structures to ensure success of the cloud adoption lifecycle. | <li> Everyone involved in the cloud adoption lifecycle should be familiar with the alignment of people and levels of accountability. |

## What's next

Build on this set of fundamental concepts through the series of getting started guides in this section of the Cloud Adoption Framework.

> [!div class="nextstepaction"]
> [Apply fundamental concepts to other getting started guides](./index.md)
