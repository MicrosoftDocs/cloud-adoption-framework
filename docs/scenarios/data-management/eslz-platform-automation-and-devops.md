---
title: Azure enterprise-scale analytics platform automation and devops
description: Learn how this enterprise-scale scenario can improve platform automation and devops of data management and analytics.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform automation and devops for a data management and analytics enterprise-scale scenario

## Overview

The construction set is focused on separating the runtime, automation, and user layers.

User interaction to automation interaction should focus on using user interfaces (UIs) like PowerApps, Custom WebApp, and the ITSM tool. These UIs should integrate with REST APIs and a workflow engine for approval process and sequencing of deployment steps.

Automation to runtime interaction is done using Azure Pipelines and scripted Azure Resource Manager (ARM) templates.

> [!IMPORTANT]
> The enterprise-scale for analytics and AI construction set uses [Azure policies](/azure/governance/policy/overview) to put boundaries in place and ensure that changes performed by the data landing zone operations teams are compliant.

Enterprise-scale for analytics and AI uses policies to enforce:

- Naming conventions.
- Network rules.
- Non-allowed services.

The data landing zone has specific requirements over the standard configuration.

- The size of subnets.
- The number of subnets.
- The number of resource groups.
- The names of resource groups.
- Key vaults.

The following diagram shows how automation principles are implemented for a data landing zone.

:::image type="content" source="./images/automation-high-level.png" alt-text="Diagram that shows a high-level overview of automation." lightbox="./images/automation-high-level.png":::

## Deployment models

The enterprise-scale analytics and AI construction set consists of:

- A data management landing zone.
- One or more data landing zones.
- One or more data integrations in each data landing zone.
- One or more data products in each data landing zone.

Each asset can evolve independently over time because of different requirements and lifecycles. For example, one of the data landing zones might require RA-GRS storage accounts at some point. It's important to have an infrastructure as code (IaC) representation of each of asset in a repository. This way, changes can be implemented based on requirements in the respective data landing zone, data integration, or data product.

The following table summarizes the teams involved in an enterprise-scale analytics and AI deployment.

| Name | Role | # of teams |
|-|-|-|
| Cloud platform team | The Azure cloud platform team in your organization. | One for the whole Azure platform. |
| Data platform team | In charge of creating and maintaining ARM template repositories for different levels of the enterprise-scale for analytics and AI set. Also maintains the data management landing zone and supports other teams if there are deployment issues or required enhancements. | One for the enterprise-scale for analytics and AI set. |
| Data landing zone team | In charge of deploying and maintaining a specific data landing zone. Also supports the deployment and enhancement of data integrations and data products. | One team per data landing zone. |
| Integration team | In charge of data integration deployment and updates. | One team per domain. |
| Data product team |In charge of data products deployment and updates. | One team per data product. |

## Next steps

[Provisioning the enterprise-scale for analytics and AI platform](eslz-platform-provisioning.md)
