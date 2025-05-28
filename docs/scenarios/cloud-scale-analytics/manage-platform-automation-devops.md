---
title: Platform automation and DevOps for a cloud-scale analytics scenario
description: Learn how this cloud-scale analytics scenario can improve platform automation and DevOps of cloud-scale analytics.
author: Zimmergren
ms.author: pnp
ms.date: 02/22/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Platform automation

Cloud-scale analytics is focused on separating the runtime, automation, and user layers.

Automation to runtime interaction is done using Azure Pipelines and scripted Azure Resource Manager templates.

> [!IMPORTANT]
> Cloud-scale analytics uses [Azure policies](/azure/governance/policy/overview) to put boundaries in place and ensure that changes performed by the data landing zone operations teams are compliant.

Cloud-scale analytics uses policies to enforce:

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

Cloud-scale analytics consists of:

- A data management landing zone.
- One or more data landing zones.
- One or more data application which produces data products in each data landing zone.

Each application can evolve independently over time because of different requirements and lifecycles. For example, one of the data landing zones might require RA-GRS storage accounts at some point. It's important to have an infrastructure as code (IaC) representation of each of asset in a repository. This way, changes can be implemented based on requirements in the respective data landing zone and data applications.

The following table summarizes the teams involved in a cloud-scale analytics deployment.

| Name | Role | Number of teams |
|-|-|-|
| Cloud platform team | The Azure cloud platform team in your organization. | One for the whole Azure platform. |
| Data platform team | In charge of creating and maintaining Azure Resource Manager template repositories for different levels of cloud-scale analytics. Also maintains the data management landing zone and supports other teams if there are deployment issues or required enhancements. | One for cloud-scale analytics. |
| Data landing zone team | In charge of deploying and maintaining a specific data landing zone. Also supports the deployment and enhancement of data applications which produce data products. | One team per data landing zone. |
| Data applications team |In charge of data products deployment and updates. | One team per data application. |

## Next steps

[Provision cloud-scale analytics platform](./manage-provision-platform.md)
