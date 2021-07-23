---
title: Understand the personas and teams for enterprise scale analytics and AI in Azure
description: Learn about the personas and teams for enterprise scale analytics and AI in Azure.
author: abdale
ms.author: hamoodaleem 
ms.date: 07/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand the personas and teams for enterprise scale analytics and AI in Azure

Enterprise scale analytics and AI creates the landing zone groups that coexist in agile teams by moving teams like Ingest, Processing, Analysis, Consumption, and Visualization from working horizontally to vertically in each tier. Platform teams like Data Platform Operations (Ops) and Platform Ops are grouped together in a common platform group.

![Overview of enterprise scale analytics and AI teams.](./images/enterprise-scale-analytics-ai-teams.png)

*Figure 1: Overview of enterprise scale analytics and AI teams.*

## Personas

Multiple personas involved in an enterprise scale analytics and AI deployment. The following sections outline the personas that are key to a successful deployment, and data governance roles are described further down this page.

| Persona | Role |
|-|-|
|Product owners| They optimize Azure to transform solutions, bring agility to the business, and optimize business processes.|
| Solution Architects | They propose solutions for the boundaries of the enterprise business network and learn how to diagnose, analyze, design, deploy, and integrate Azure services. |
|Developer/DevOps engineers|They use Azure DevOps or GitHub to design, build, deploy, test, and maintain continuous integration and delivery processes.|
| Security engineers <sup>1</sup> | They support teams to design and implement secure Azure infrastructure with best practices. |
| Technical/business managers <sup>1</sup>|They help to develop an understanding of Azure services, control costs, and optimize your team's operations and agility.|
|Decision makers/business users|They optimize Azure to gain actionable insights in their most relevant forms and identify AI embedded in current solutions to streamline business processes.|
| Data managers | They provision and manage access to data assets. |
|Data/performance analysts |They use Azure to discover and share new insights from existing data assets or as-needed data queries. They create one-click AI transformations, consume pre-built models, and generate machine learning (ML) models in clicks.|
|Data engineers | They use Azure to build, integrate, and manage data and analytics products. When necessary, they also create AI-enabled applications/solutions.|
|Citizen data scientists |They create ML models with powerful visual, drag-and-drop, and no-code tools where coding isn't necessary. |
| Data scientists | They use preferred tools and ML frameworks to build scalable data science solutions. They also accelerate the end-to-end ML life cycle.|
| ML engineers | They support the right processes and infrastructure models to be deployed and managed easily. |

>[!NOTE]
> Azure policies assist these roles to control some of the scope that they oversee.

## Data Landing Zone teams

The Data Landing Zone group consists of three teams.

**Data Product teams (per product)**:

- Are responsible for delivering new data products such as insights, reports, notebooks, and applications.
- Partner closely with business analysts and business unit stakeholders.
- Transform data into new read data stores.
- Manage access hierarchy (groups) and approval requests.
- Furnish metadata in data catalogs.

**Integration Ops (per integration)**:

- Ingest and register new read data sources.
- Manage access hierarchy (groups) and approval requests.
- Furnish metadata in data catalogs.

**Data Landing Zone Ops (one group per data landing zone)**:

- Operate and maintain their data landing zone instance.
- Respond to new data integration and data product service requests.

### Decide between a central or business data office

Based your organization's size and structure, the Data Landing Zone group can be assembled in different ways. For example, you create one data landing zone where the business already has its own set of data engineers, program managers, and solution architects (for example, a business data office). In this scenario, you could provision a data landing zone and allow the business data office to operate the landing zone based on governance from your central platform group.

In another example, a data landing zone's business doesn't have a business data office to build out their data integrations or data products. In this scenario, the central data office should consider themselves a consultancy that would take people off the bench to work on the data landing zone. Those resources should be embedded into the business to collect and execute on use cases with SCRUM or AGILE methods. Once completed, they would return to the central data office.

Individuals should work within multidisciplinary teams in both of these scenarios, sharing goals and diverse experience, skills, and approaches that support more effective outcomes than if everyone is siloed.

>[!NOTE]
>In the scenario where only one data landing zone is deployed, it's common to mix businesses into one data landing zone. This could create crossover functions where Integration Operations or Data Product teams are sourced from central and business data offices. However, Data Landing Zone Ops functions to be located in the central data office for this scenario.

## Teams within the Platform group

The Platform group consists of two teams:

**Data Platform Ops**:

- Define common policies for data landing zone, integration, and product services.

- Provision and operate data management services like the data catalog and runtimes for shared integration.

- Instantiate data landing zone scaffolding, including data lakes and configuring how metadata is managed before passing it to Data Landing Zone Ops.

- Support stakeholders.

**Platform Ops**:

- Operate and own the cloud platform.

- Instantiate data management landing zone and data landing zone scaffolding, including networking, peering, monitoring, and other core services.

## Digital security office

Digital security deals with the entire enterprise scale analytics and AI construction set. It is usually a dedicated department lead by a Chief Information Security Officer. This department works closely with Data Platform Ops, the data governance review board, and the architecture review board.

## Data governance roles and responsibilities

With respect to people, there are a number of data governance roles and responsibilities.These can vary across organization and so the follow roles and responsibilities listed in the table below are provided as guidance only.

|Role |   Responsibility|
|--|--|
|Executive sponsor (for example, the CFO/CIO)  |  This is a senior business stakeholder with authority and budget; they're accountable for establishing data governance.|
|Data governance program leader (for example, the Chief Development Officer or the appointed lead) |   This person is accountable and responsible for implementing the data governance program.|
|Data governance control board |   This board includes a data governance lead and data owners. They establish metrics for success, own the data governance roadmap, select working groups, hold the budget for the data governance program, and mediate during conflicts about prioritizing and defining cross-functional data.|
|Data governance working group  |  They plan and develop defining data and improving specific data domains (for example, customer, or supplier); update the data governance control board on progress; and manage stewardship across the enterprise for a specific domain.|
|Data owner   | This is a senior business stakeholder with authority and budget; they're accountable for quality assurance (QA) and protecting a specific data subject area or entity across the enterprise. They decide who can access and maintain that data and how it's used.|
|Business data steward |   This business professional responsible oversees QA and protects a data subject area or entity. They are often experts in the data domain, work in a team with other data stewards across the enterprise, and monitor and decide how data quality is maintained.|
|Data protection officer  | This is a senior business stakeholder with authority and budget, accountable for protecting personal data; their tasks are specific to compliance legislation in all jurisdictions where company operates.|
|Data security team  |  This team is responsible and accountable for enforcing data access security and a data privacy policy.|
|Data publishing manager   | This person is responsible and accountable for checking QA and publishing new, trusted data assets in a data marketplace for consumer use.|

:::image type="content" source="./images/data-governance-review-board.png" alt-text="The structure of how to organize data governance.":::

*Figure 2: The structure of how to organize data governance.*

The goal is for businesses to organize governance in a way that allows them to divide and conquer when governing data throughout its life cycle across a hybrid computing environment. One way of doing this is to have multiple working groups reporting to a data governance control board, with each working group responsible for a particular data domain/entity (for example, the customer) or a data subject area that consists of multiple data entities.

## Other groups

Companies can run several smaller teams with key stakeholders and subject matter experts across the entire operating model to maintain a centralized view of the analytics platform.

### Architecture review board

The architecture review board's main functions are to review and assess architectures, and create and maintain standards and references. The board consists of individuals who are experts in their field; typically, these are domain architects and other technical leaders invited to give opinions when needed.

### Feedback and support operating board

The feedback and support operating board receives feedback about processes and works with the other groups to create backlog items to address gaps and improve the solution.

For more information about how groups align within a data management landing zone and data landing zone(s), view [enterprise scale analytics and AI DevOps models](./organize-team-functions.md).
