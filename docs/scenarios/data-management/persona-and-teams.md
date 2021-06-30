---
title: Azure Enterprise Scale Analytics and AI Teams
description: Enterprise Scale Analytics and AI Architecture Persona and Teams structure
author: abdale
ms.author: hamoodaleem # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Personas and Teams (Guidance only)

## Personas

There are multiple personas involved in an Enterprise Scale Analytics and AI deployment. The following sections attempts to give a high insight to those which we see are key to the success. Data Governance roles are called out specifically further down this page.

| Persona | Role |
|-|-|
|Product Owners| Product Owners leverage Azure to transform your solutions and bring agility to the business and optimize business processes.|
| Solution Architects | Define solutions to drive across the boundaries of the enterprise business network. Learn how to deal with diagnosis, analysis, design, deployment, and integration of Azure services. |
|Developer/DevOps Engineers|Design, build, deploy, test, and maintain continuous integration and delivery process with Azure DevOps or GitHub.|
| Security Engineers <sup>1</sup> | Enable your teams to design and implement a secure infrastructure on Azure leveraging best practices. |
| Technical/Business Managers <sup>1</sup>|Build an overall understanding of Azure services. Control your cloud costs and optimize your operations and the agility of your team.|
|Decision Makers / Business Users|Leverage Azure to access actionable insight, expecting it to be delivered in most relevant form. Leverage AI embedded in existing solutions to optimize business processes.|
| Data Managers | Responsible for provisioning and managing access to data assets. |
|Data Analysts / Performance Analysts |Leverage Azure to discover and share new insights from existing data assets or *ad hoc* data. Create one-click AI transformations, consume pre-built models, and generate ML models in clicks.|
|Data Engineers | Leverage Azure to build, integrate, and manage data and analytics products. Create AI enabled applications / solutions when applicable.|
|Citizen Data Scientists |Create ML models via powerful visual, drag-and-drop, no-code tools where no coding is necessary |
| Data Scientists | Use your preferred tools and machine learning frameworks to build scalable data science solutions. Accelerate end-to-end ML lifecycle.|
| ML Engineers | Enable right processes and infrastructure for easy model deployment and model management. |

>[!NOTE]
> <sup>1</sup> These roles are assisted by using Azure Policies to control some of the scope over which they would have guidance and control.

The Enterprise Scale Analytics and AI moves teams from working horizontally across each tier such as Ingest, Processing, Analysis, Consumption and Visualization to vertical Data Landing Zone Groups coexisting together in an agile team. Platform teams such as Data Platform Ops and Platform Ops are grouped together under a common Platform Group.

![Enterprise Scale Analytics and AI Teams](./images/enterprise-scale-analytics-ai-teams.png)

Figure 1: Enterprise Scale Analytics and AI Teams

## Data Landing Zone Teams

The Data Landing Zone Group consists of three teams.

### Data Product Teams (per Product)

- Are responsible for delivering new Data Products such as insights, reports, notebooks, and applications.
- Partner closely with business analysts and busienss unit stakeholders.
- Transform data into new read data stores.
- Manage access hierarchy (groups) and approval requests.
- Furnish meta data in data catalogue.

### Integration Ops (per integration)

- Ingest and Register new read data sources.
- Manage access hierarchy (groups) and approval requests.
- Furnish meta data in data catalogues.

### Data Landing Zone Ops (One Group per Data Landing Zone)

- Operate and maintain their Data Landing Zone instance.
- Respond to new Data Integration and Data Product service requests.

### Central or Business Data Office?

The Data Landing Zone Group can be resourced in different ways depending on the size and organizational structure of your business.

For example, you create one data landing zone where the business already has it's own set of data engineers, program managers and solution architects. We will call this a business data office. In this scenario, you could decide to provision a data landing zone and allow the business data office to operate the landing zone, based upon the governance from your central platform group.

In another example, the owning business of a data landing zone doesn't have a business data office to build out their data integrations or data products. In this scenario the central data office should consider themselves a consultancy who would take people off the bench to work on the data landing zone. Those resources should be embedded into the business to collect and execute on use cases in either a SCRUM or AGILE manner. Once completed they would return to the central data office.

In both of these models, these groups of individuals should be working as "multi-disciplinary teams", with shared goals, where the diversity of experience, skills and approaches they bring enablesmore  effective outcomes that if they operated "in silos". 

>[!NOTE]
>In the scenario where only a single data landing zone is deployed, it is likely that you will mix businesses into one data landing zone. You might then end up with a crossover of functions where Integration Ops or Data Product teams could be resourced from central and business data offices. However, in this scenario we would recommend that the function of Data Landing Zone Ops is all located in the central data office.

## Platform Group Teams

### Data Platform Ops

- The Data Platform Ops Group defines common policies for Data Landing Zone, Data Integration and Data Product services.
- They provision and operate Data Management services such as the data catalog and shared integration runtimes.
- They instantiate Data Landing Zone scaffolding such as Data Lakes and Metadata Management configuration before passing it over to the Data Landing Zone Ops.
- Provide support and concierge to stakeholders.

### Platform Ops

- Operate and own the cloud platform all up.
- They instantiate Data Management Landing Zone and Data Landing Zone scaffolding such as networking, peering, monitoring, and other core services.

## Digital Security Office

Digital security spans the whole of the Enterprise Scale Analytics and AI construction set. It is usually a dedicated department lead by a Chief Information Security Officer (CISO). This department will work closely with the Data Platform Ops, Data Governance Review Board, and Architecture Review Board.

## Data Governance Roles and Responsibilities

With respect to people, there are a number of data governance roles and responsibilities.These can vary across organization and so the follow roles and responsibilities listed in the table below are provided as guidance only.

|Role |   Responsibility|
|--|--|
|Executive sponsor (e.g. CFO / CIO)  |  Senior business stakeholder with authority and budget who is accountable for ensuring data governance is established|
|Data Governance program leader (e.g. CDO or appointed lead) |   The person with overall accountability and responsibility for implementing the data governance program.|
|Data Governance Control Board |   Includes data governance lead and data owners. Sets success metrics, owns the data governance roadmap, selects working groups, holds the budget for the data governance program, arbitrates when conflicts occur on priorities and definitions of cross functional data|
|Data Governance Working Group  |  Plan and progress data definition and improvement of a specific data domain (E.g. Customer or Supplier), update Data Governance Control Board on progress, manage stewardship across the enterprise for a specific domain|
|Data owner   | Senior business stakeholder with authority and budget who is accountable for overseeing the quality and protection of a specific data subject area or data entity across the enterprise and make decisions on who has the right to access and maintain that data and on how it is used|
|Business data steward |   Business professional responsible for overseeing the quality and protection of a data subject area or data entity. They are typically experts in the data domain and work in a team with other data stewards across the enterprise to monitor and make decisions to ensure data quality is maintained|
|Data Protection Officer (DPO)   | Senior business stakeholder with authority and budget who is accountable for the protection of personal data specific to compliance legislation in all jurisdictions that the company operates|
|Data security team  |  Responsible and accountable for data access security and data privacy policy enforcement|
|Data Publishing Manager   | Responsible and accountable for quality assurance checking and publishing of newly created trusted data assets in a data marketplace for consumers to find and use|

:::image type="content" source="images/data-governance-review-board.png" alt-text="data governance review board":::

Figure 2: Data governance organization structure

The objective is to organize in a way that allows you to take a 'divide and conquer' approach to governing data throughout its lifecycle across a hybrid computing environment. One way of doing this is to have multiple working groups reporting into a Data Governance Control Board (Figure 3) with each working group responsible for a particular data domain / data entity (e.g. Customer) or a data subject area that consists of multiple data entities.

:::image type="content" source="images/data-governance-review-board-example.png" alt-text="data governance board example":::

Figure 3: Data Governance Board example

In the figure 3, the Data Governance Control board has an approval processes for data naming, integrity rules, policies etc. The operating model is independent of location and line of business. There should be a dispute resolution process to overcome disagreements.

## Other Groups

Across the whole operating model, companies have the option to run several smaller teams with key stakeholders and subject matter experts to maintain a centralized view of the analytics platform.

### Architecture Review Board

The Architecture Review Board performs the primary function of reviewing and assessing architectures and creating and maintaining standards and references. The Board consists of individuals who are experts in their field; typically, these will be the domain architects and other technical leaders invited to give opinions where required.

### Feedback and Support Operating Board

The Feedback and Support Operating Board are responsible for taking feedback on processes and working with the other groups to create backlog items to address gaps and improvements to the solution.

For further details on all how the groups align inside the Data Management Landing Zone and Data Landing Zone(s) please see [Enterprise Scale Analytics and AI DevOps Models](team-functions.md).
