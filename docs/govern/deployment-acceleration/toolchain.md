---
title: Deployment Acceleration tools in Azure
description: See how Azure native tools can help mature policies and processes that support the Deployment Acceleration discipline.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Deployment Acceleration tools in Azure

The [Deployment Acceleration discipline](./index.md) is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md). This discipline focuses on ways of establishing policies to govern asset configuration or deployment. Within the Five Disciplines of Cloud Governance, the Deployment Acceleration discipline involves deployment and configuration alignment. This could be through manual activities or fully automated DevOps activities. In either case, the policies involved would remain largely the same.

Cloud custodians, cloud guardians, and cloud architects with an interest in governance are each likely to invest a lot of time in the Deployment Acceleration discipline, which codifies policies and requirements across multiple cloud adoption efforts. The tools in this toolchain are important to the cloud governance team and should be a high priority on the learning path for the team.

The following is a list of Azure tools that can help mature the policies and processes that support this discipline.

|  | [Azure Policy](/azure/governance/policy/overview) | [Azure management groups](/azure/governance/management-groups/) | [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | [Azure Blueprints](/azure/governance/blueprints/overview) | [Azure Resource Graph](/azure/governance/resource-graph/overview) | [Azure Cost Management + Billing](/azure/cost-management-billing/) |
|---------|---------|---------|---------|---------|---------|---------|
| **Implement corporate policies**     | Yes | No  | No  | No | No | No |
| **Apply policies across subscriptions**     | Required | Yes  | No  | No | No | No |
| **Deploy defined resources**     | No | No  | Yes  | No | No | No |
| **Create fully compliant environments**      | Required | Required | Required | Yes | No | No |
| **Audit policies**      | Yes | No  | No  | No | No | No |
| **Query Azure resources**      | No | No  | No  | No | Yes | No |
| **Report on cost of resources**      | No | No  | No  | No | No | Yes |

The following are additional tools that may be required to accomplish specific deployment acceleration objectives. Often these tools are used outside of the governance team, but are still considered an aspect of the Deployment Acceleration discipline.

|  | [Azure portal](https://azure.microsoft.com/features/azure-portal/) | [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | [Azure Policy](/azure/governance/policy/overview) | [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) | [Azure Backup](/azure/backup/backup-overview) | [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) |
|---------|---------|---------|---------|---------|---------|---------|
| **Manual deployment (single asset)**     | Yes | Yes  | No  | Not efficiently | No | Yes |
| **Manual deployment (full environment)**     | Not efficiently | Yes | No  | Not efficiently | No | Yes |
| **Automated deployment (full environment)**     | No  | Yes  | No  | Yes  | No | Yes |
| **Update configuration of a single asset**     | Yes | Yes | Not efficiently | Not efficiently | No | Yes, during replication |
| **Update configuration of a full environment**     | Not efficiently | Yes | Yes | Yes  | No | Yes, during replication |
| **Manage configuration drift**     | Not efficiently | Not efficiently | Yes  | Yes  | No | Yes, during replication |
| **Create an automated pipeline to deploy code and configure assets (DevOps)**     | No | No | No | Yes | No | No |

Aside from the Azure native tools mentioned above, it's common for customers to use third-party tools to facilitate deployment acceleration and DevOps deployments.
