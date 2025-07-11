---
title: Cloud adoption plan template for migration
description: Use this template to document your migration strategy, operating model, training plan, platform architecture, and workload details for successful Azure cloud adoption.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/15/2025
ms.topic: conceptual
---

# Cloud adoption plan template for migration

This article provides a cloud adoption plan template for organizations that migrate workloads to Azure. Use this template to document your operating model and responsibilities, training plan, and workload information

## Operating model and responsibilities

Use the table below to document details for each category.

| Category          | Documentation to add                                   |
|-------------------|-----------------------------------------------|
| Operating model   | Specify whether your operating model is shared management, centralized, or distributed. |
| Responsibilities  | Define and assign responsibility for the platform and workload(s). Include names, roles, and specific tasks. |

For more information, see [Prepare your organization](./prepare-organization-for-cloud.md).

## Cloud training plan

| Category                  | Documentation to add                                                                       |
|---------------------------|-----------------------------------------------------------------------------|
| Skills assessment summary | Summarize assessment results, including the date of the assessment, tools used, and key Azure skill gaps identified across teams. |
| Expert support engagement | Document the experts involved, such as Microsoft or partner experts, the type of engagement (e.g., workshops), and the schedule of sessions. |
| Certifications            | Specify the target Azure certifications required for each role. |
| Learning sandbox          | Provide details about the sandbox environment subscription, access policies, and usage guidelines. |
| Continuous learning program | Outline the monthly learning time allocated, recognition systems (e.g., points, badges), and plans for community engagement, such as events or user groups. |

For more information, see [Prepare your people](./prepare-people-for-cloud.md).

## Azure landing zone architecture

| Category                  | Documentation to add                                                                 |
|---------------------------|-------------------------------------------------------------------------------------|
| Platform components needed | Specify the required components, such as on-premises connectivity, hybrid identity, management tools, and application landing zone types (e.g., online, corporate, sandbox). |
| Resource hierarchy         | Define the hierarchy, including management groups, subscriptions, and resource groups. |
| Platform architecture       | Document shared resources, SKUs, and regions to ensure scalability and compliance. |
| Estimated platform cost     | Provide cost estimates for the platform architecture, including Azure services and operational expenses. |

For more information, see [Plan your Azure landing zone architecture](./estimate-total-cost-of-ownership.md#plan-your-azure-architecture)

## Details on each workload

For each workload in your inventory, gather business and technical details.

### Workload business details for migration

| Workload business details | Documentation to add      |
|-----------------|-------------|
| Workload name | Add the official name used across the organization for this workload. |
| Workload description | Provide a single sentence describing the workload's purpose. |
| Timelines | List the target date to complete migration strategy |
| Migration strategy | Specify the migration strategy: retire, rehost, replatform, or refactor. |
| Criticality level | Indicate the priority level: high (mission-critical), medium, or low priority. |
| Data sensitivity | Define the data sensitivity level: highly confidential, confidential, general, public, or non-business. |
| Workload owners | List the individuals accountable for this workload. |
| Business owners | Identify the executive or manager overseeing this workload. |
| Business unit | Name the department responsible for the workload's costs. |
| Business processes affected | Document the processes that depend on this workload. |
| Business teams affected | Specify the teams whose work depends on this workload. |
| Data owners | List the individuals responsible for data governance. |
| Business impact | Describe the impact on revenue, operations, or customers if the workload becomes unavailable. |
| Compliance requirements | Note any regulatory standards or certifications required for this workload. |
| Maintenance windows | Provide the scheduled times for updates and changes to this workload. |
| Business freeze periods | Specify the dates when no changes are permitted to this workload. |
| Geographic restrictions | Document any data residency or access location requirements. |
| Success metrics | Define specific measurements to evaluate the success of the migration. |

For more information, see [Document workload business details](./discover-existing-workload-inventory.md#document-workload-business-details).

### Workload technical details for migration

| Workload technical details               | Documentation to add                                                                       |
|--------------------------------|-----------------------------------------------------------------------------|
| Current architecture           | Document all components of the workload, including compute, storage, networking, databases, and application tiers. Include architecture diagrams and configuration details. |
| Application code               | Document programming languages, frameworks, and SDK versions. Note any deprecated APIs or compatibility issues with Azure services. |
| Databases                      | List all databases, including engine types, versions, and hosting models. Document dependencies and migration requirements. |
| Environments                   | Indicate whether the workload runs in production, test, or development. This affects downtime tolerance and migration strategy. |
| Component requirements         | List performance metrics (CPU, memory, IOPS, throughput), OS versions, VM sizes, storage types, and licensing details. Include any unsupported technologies or modernization needs. |
| SLAs (RTO/RPO)                 | Define service-level agreements, recovery point objectives (RPO), and recovery time objectives (RTO). Use this to guide backup, replication, and failover strategies. |
| Operating locations            | Specify regions where the workload is or must be hosted, considering data residency, compliance, and latency requirements. |
| Dependencies                   | List internal and external dependencies (e.g., shared databases, APIs, SaaS services). Include dependency maps and groupings for migration sequencing. |
| Security                       | Document authentication methods, service accounts, encryption (at rest/in transit), firewall rules, and access control lists. |
| ISV and licensing considerations | Validate third-party software compatibility with Azure. Note any Azure Hybrid Benefit eligibility or licensing constraints. |

For more information, see [Assess your workload](./assess-workloads-for-cloud-migration.md)

### Target Azure architecture for the workload

| Azure workload details | Description |
| --- | --- |
| Target architecture | A link to a diagram you created or sample architecture on Azure Architecture Center |
| Azure services and SKUs | List the Azure services and SKUs required for the workload |
| Azure regions | Specify the Azure regions where the workload will be hosted |
| Estimated workload cost | Estimated cost using the [Azure Pricing calculator](https://azure.microsoft.com/pricing/calculator/?msockid=396a7791057262e4306e626304176307) |
| Estimated operational cost | Estimate how many people or hours you dedicate to this workload |

For more information, see [Plan your Azure architecture](./estimate-total-cost-of-ownership.md#plan-your-azure-architecture)
