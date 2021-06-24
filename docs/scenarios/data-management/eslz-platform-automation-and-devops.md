---
title: "Azure Enterprise Scale Analytics platform automation and devops for 'data management and analytics'"
description: Describe how this enterprise-scale scenario can improve platform automation and devops of 'data management and analytics'
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform automation and devops for 'data management and analytics' Enterprise-Scale scenario


# Deployment Models

The Enterprise Scale Analytics and AI construction set consists of:

- A Data Management Landing Zone.
- One or more Data Landing Zones.
- One or more Data Integrations in each Data Landing Zone.
- One or more Data Products in each Data Landing Zone.

Each of these assets can evolve independently over time, because of different requirements and lifecycles (e.g. one of the Data Landing Zones may requires RA-GRS storage accounts at some point). Therefore it is important to have an IaC representation of each of these assets in a repository, so that changes can be implemented based on requirements in the respective Data Landing Zone, Data Integration or Data Product.

Table 1, summarizes the teams involved in an Enterprise Scale Analytics and AI deployment.

|Name  |Role|# of teams|
|-|-|-|
|Cloud Platform Ops| The Azure Cloud Platform team in your organization| One for the whole Azure platform |
|Data Platform Ops|In charge of creating and maintaining ARM template repositories for the different levels of the Enterprise Scale Analytics and AI. Also maintains the Data Management Landing Zone and supports other ops teams in case of deployment issues or required enhancements.| One for the Enterprise Scale Analytics and AI |
|Data Landing Zone Ops |In charge of deploying and maintaining a specific Data Landing Zone. Also, supports the deployment and enhancement of Data Integrations and Data Products. | One team per Data Landing Zone |
|Integration Ops|In charge of Data Integration deployment and updates| One team per domain |
|Data Product Team|In charge of Data Products deployment and updates| One team per Data Product |

Table 1: Enterprise Scale Analytic and AI Teams

## High Level Overview

The solution pattern has focused on separating the runtime, automation and users layers.

Users interaction, to Automation interaction, should focus on using User Interfaces (PowerApps, Custom WebApp, ITSM tool). These should integrate with REST APIs and a workflow engine for approval process and sequencing of deployment steps.

Automation to Runtime interaction is done via Azure DevOps Pipelines and scripted ARM Templates.

>[!IMPORTANT]
>The Enterprise Scale Analytics and AI construction set uses [Azure policies](/azure/governance/policy/overview) to put boundaries in place and ensure that changes performed by the Data Landing Zone Ops teams are compliant.

Enterprise Scale Analytics and AI uses Policies to enforce:

- Naming conventions
- Network rules
- Optional: Non-allowed Services

Over the standard configuration the Data Landing Zone has specific requirements:

- Size of subnets
- Number of subnets
- Number of RGs
- Name of RGs
- Key Vaults

:::image type="content" source="./images/automation-high-level.png" alt-text="Automation High Level Overview" lightbox="./images/automation-high-level.png":::

*Figure 1: Automation High Level Principles*

Figure 1, illustrates how their automation principle are implemented for a Data Landing Zone. How they call API's and the functions of each team.