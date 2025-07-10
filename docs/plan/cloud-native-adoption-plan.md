---
title: Cloud adoption plan template for cloud-native startups
description: Use this template to document your Azure adoption plan for cloud-native startups
author: stephen-sumner
ms.author: ssumner
ms.date: 07/15/2025
ms.topic: conceptual
---


# Cloud adoption plan for cloud-native startups

This article provides a template for startups building a cloud-native business in Azure. It helps you document operational models, responsibilities, training plans, platform architecture, and workload details to ensure a successful migration.

## Operating model and responsibilities

Use the table below to document details for each category.

| Category          | Documentation to add                                   |
|-------------------|-----------------------------------------------|
| Operating model   | Specify whether your operating model is centralized or not. |
| Responsibilities  | Define and assign responsibility for the platform and workload(s). Include names, roles, and specific tasks. |

For more information, see [Prepare your organization](./prepare-organization-for-cloud.md).

## Cloud training plan

| Category                  | Documentation to add                                                                       |
|---------------------------|-----------------------------------------------------------------------------|
| Learning sandbox          | Provide details about the sandbox environment subscription, access policies, and usage guidelines. |
| Continuous learning program | Outline the monthly learning time allocated, recognition systems (e.g., points, badges), and plans for community engagement, such as events or user groups. |

For more information, see [Prepare your people](./prepare-people-for-cloud.md).

## Azure landing zone architecture

| Category                  | Documentation to add                                                                 |
|---------------------------|-------------------------------------------------------------------------------------|
| Resource hierarchy         | Define the hierarchy, including management groups, subscriptions, and resource groups. |

For more information, see [Plan your Azure landing zone architecture](./estimate-total-cost-of-ownership.md#plan-your-azure-architecture)

## Requirements for each cloud-native workload

For each workload you plan to build, document business and technical requirements.

### Workload business requirements for cloud-native builds

| Workload business details | Description |
|-----------------|-------------|
| Workload name | Official name used across the organization |
| Workload description | Single sentence describing the workload's purpose |
| Workload owners | Individuals accountable for workload |
| Compliance requirements | Regulatory standards or certifications required |
| Target users | Number of location of user base |

For more information, see [Document workload business details](./discover-existing-workload-inventory.md#document-workload-business-details).

### Workload technical requirements for cloud-native builds

| Workload technical details               | Description |
|--------------------------------|------------------------------------------------------|
| Component requirements         | List performance metrics (CPU, memory, IOPS, throughput), OS versions, VM sizes, storage types, and licensing details |
| SLAs (RTO/RPO)                 | Define service-level agreements, recovery point objectives (RPO), and recovery time objectives (RTO). Use this to guide backup, replication, and failover strategies |

For more information, see [Assess your workload](./assess-workloads-for-cloud-migration.md).

### Target Azure architecture for the workload

| Azure workload details | Description |
| --- | --- |
| Target architecture | A link to a diagram you created or sample architecture on Azure Architecture Center |
| Azure services and SKUs | List the Azure services and SKUs required for the workload |
| Azure regions | Specify the Azure regions where the workload will be hosted |
| Estimated workload cost | Estimated cost using the [Azure Pricing calculator](https://azure.microsoft.com/pricing/calculator/) |
| Estimated workload operational cost | Estimate how many people or hours you dedicate to this workload |
