---
title: Understand the roles and teams for cloud-scale analytics in Azure
description: Learn about the roles and teams for Cloud-scale analytics in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Understand the teams for cloud-scale analytics in Azure

For Cloud-scale analytics, we recommend moving teams like ingest, processing, analysis, consumption, and visualization from working in horizontally siloed teams, to agile vertical cross domain teams in each tier. Platform teams like data platform operations and platform operations are grouped together in a common platform group.

![Overview of Cloud-scale analytics teams.](./images/enterprise-scale-analytics-ai-teams.png)

Within scale analytics, we identify the following teams:

- Platform ops
- Data platform ops
- Data landing zone ops
- Data Application teams

Each team focuses on a specific aspect of Cloud-scale analytics. For a comprehensive understanding of team functions, refer to the [Roles and Responsibilities](organize-roles-responsibilities.md) and [Understand teams and functions for cloud-scale analytics in Azure](../data-management/organize-team-functions.md) guides.

## Data landing zone teams

The data landing zone group consists of three teams:

**Data Application teams (one team per application)**:

- Are responsible for delivering new data products such as insights, reports, notebooks, and applications.
- Partner closely with business analysts and business unit stakeholders.
- Transform data into new read data stores.
- Manage access hierarchy (groups) and approval requests.
- Furnish metadata in data catalogs.

**Data landing zone ops (one group per data landing zone)**:

- Operate and maintain their data landing zone instance.
- Respond to new data application service requests.

### Decide between a central or business data office

Depending on your organization's size and structure, a data landing zone group can be assembled in various ways. For instance, if you establish a data landing zone where the business already has its own data engineers, program managers, and solution architects, such as a business data office, you can provision the data landing zone. Then, you can allow the business data office to operate the data landing zone under the governance of your central platform group.

Another option is when a business doesn't have a data office to build out their data applications. In this scenario, the central data office can act as a consultancy, assigning staff to work on the data landing zone. These resources should be embedded within the business to collect and execute use cases using Scrum or agile methods. After the work is completed, they would return to the central data office.

Individuals should work within multidisciplinary teams in both scenarios, sharing goals and diverse experiences, skills, and approaches. This collaboration supports more effective outcomes than working in silos.

> [!NOTE]
> In the scenario where only one data landing zone is deployed, it's common for businesses to overlap in one data landing zone. This could create crossover functions where data application teams are sourced from central and business data offices. However, data landing zone operations functions to be located in the central data office for this scenario.

## Teams within the platform group

The platform group consists of two teams:

**Data Platform Ops:**

- Define common policies for data landing zone and data applications.

- Instantiate data landing zone scaffolding, including core services before passing it to data landing zone operations.

- Support stakeholders.

**Platform Operations:**

- Operate and own the cloud platform.

- Instantiate data management landing zone and data landing zone scaffolding, including networking, peering, monitoring, and other core services.

## The digital security office

Digital security deals with the entire Cloud-scale analytics. It's usually a dedicated department lead by a chief information security officer. This department works closely with data platform ops, the data governance review board, and the architecture review board.

## Data governance roles and responsibilities

There are many data governance roles and responsibilities related to people. The roles and responsibilities can vary across organization. The roles and responsibilities in the table are provided as guidance only.

|Role |   Responsibility|
|--|--|
|Executive sponsor, for example, the CFO or CIO. |  This is a senior business stakeholder with authority and budget. They're accountable for establishing data governance.|
|Data governance program leader, for example, the chief development officer, or the appointed lead. | This person is accountable and responsible for implementing the data governance program.|
|Data governance control board |   This board includes a data governance lead and data owners. They establish metrics for success, own the data governance roadmap, select working groups, hold the budget for the data governance program, and mediate during conflicts about prioritizing and defining cross-functional data.|
|Data governance working group  |  They plan and develop defining data and improving specific data domains (for example, customer, or supplier); update the data governance control board on progress; and manage stewardship across the enterprise for a specific domain.|
|Data owner   | This is a senior business stakeholder with authority and budget. They're accountable for quality assurance (QA) and protecting a specific data subject area or entity across the enterprise. They decide who can access and maintain that data and how it's used.|
|Business data steward |   This business professional responsible oversees QA and protects a data subject area or entity. They're often experts in the data domain, work in a team with other data stewards across the enterprise, and monitor and decide how to maintain data quality.|
|Data protection officer  | This is a senior business stakeholder with authority and budget, accountable for protecting personal data. Their tasks are specific to compliance legislation in all jurisdictions where company operates.|
|Data security team  |  This team is responsible and accountable for enforcing data access security and a data privacy policy.|
|Data publishing manager   | This person is responsible and accountable for checking QA and publishing new, trusted data assets in a data marketplace for consumer use.|

:::image type="content" source="./images/data-governance-review-board.png" alt-text="Diagram of the structure of how to organize data governance.":::

The goal is for businesses to organize governance in a way that enables them to effectively manage data throughout its lifecycle across a hybrid computing environment. One approach is to have multiple working groups reporting to a data governance control board, with each group responsible for a specific data domain or entity, such as customer data, or a data subject area that includes multiple data entities.

## Other groups

Companies can run several smaller teams with key stakeholders and subject matter experts across the entire operating model to maintain a centralized view of the analytics platform.

### Architecture review board

The architecture review board's main functions are to review and assess architectures, and create and maintain standards and references. The board consists of individuals who are experts in their field. Typically, the individuals are domain architects and other technical leaders invited to give opinions when needed.

### Feedback and support operating board

The feedback and support operating board receives feedback about processes and works with the other groups to create backlog items to address gaps and improve the solution.

## Next steps

[Roles and Responsibilities](organize-roles-responsibilities.md)
