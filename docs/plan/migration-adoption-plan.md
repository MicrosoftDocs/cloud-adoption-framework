---
title: Cloud adoption plan template for migration
description: Use this template to document your migration strategy, operating model, training plan, platform architecture, and workload details for successful Azure cloud adoption.
author: github-username
ms.author: microsoft-alias
ms.date: 12/19/2024
ms.topic: conceptual
---

# Cloud adoption plan template for migration

This article provides a template for organizations that migrate workloads to Azure. Use this template to document your operating model and responsibilities, training plan, and capture essential platform and workload information to ensure a successful cloud adoption.

## Operating model and responsibilities

| Category          | Description                                   |
|-------------------|-----------------------------------------------|
| [Operating model](./prepare-organization-for-cloud.md#choose-a-cloud-operating-model)   | Shared management, centralized, distributed   |
| [Responsibilities](./prepare-organization-for-cloud.md#document-ownership-and-accountability)  | Assign responsibility for the platform and workload(s) |

## Cloud training plan

Skills development accelerates cloud adoption and reduces migration risks. Your team needs specific Azure competencies to manage workloads effectively. You must assess current skills, identify gaps, and create structured learning paths.

| Category                  | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| [Skills assessment summary](./prepare-people-for-cloud.md#identify-the-cloud-skills-you-need) | Summarize assessment results: date, tools used, and key Azure skill gaps identified across teams |
| [Expert support engagement](./prepare-people-for-cloud.md#train-your-people) | Identify Microsoft or partner experts involved, type of engagement (e.g., workshops), and schedule of sessions |
| [Certifications](./prepare-people-for-cloud.md#train-your-people)    | Target Azure certifications per role         |
| [Learning sandbox](./prepare-people-for-cloud.md#sustain-cloud-skills-across-your-organization)  | Detail the sandbox environment subscription, access policies, and usage guidelines |
| [Continuous learning program](./prepare-people-for-cloud.md#sustain-cloud-skills-across-your-organization) | Outline monthly learning time, recognition systems (Learn points, badges), and plans for community engagement (events, user groups) |

## Azure landing zone architecture

| Category | Description |
|----------|-------------|
| Platform components needed | On-premises connectivity, hybrid identity, management, application landing zone types (online, corp), sandbox |
| Resource hierarchy | Management groups |
| Platform architecture | Shared resources, SKUs and regions |
| Estimated platform cost | Estimates of how much the platform architecture costs |

For more information, see [Plan your Azure landing zone architecture](./estimate-total-cost-of-ownership.md#plan-your-architecture)

## Workload details for each workload

### Workload business data for migration

| Business detail | Description |
|-----------------|-------------|
| Workload name | Official name used across the organization |
| Workload description | Single sentence describing the workload's purpose |
| Migration strategy | Retire, rehost, replatform, refactor, 
| Criticality level | High (mission-critical), medium, or low priority |
| Data sensitivity | Highly confidential, confidential, general, public, non-business |
| Workload owners | Individuals accountable for workload |
| Business owners | Executive or manager overseeing this workload |
| Business unit | Department responsible for workload costs |
| Business processes affected | Processes that depend on this workload |
| Business teams affected | Teams whose work depends on this workload |
| Data owners | Individuals responsible for data governance |
| Business impact | Revenue, operations, or customer impact if unavailable |
| Compliance requirements | Regulatory standards or certifications required |
| Maintenance windows | Scheduled times for updates and changes |
| Business freeze periods | Dates when no changes are permitted |
| Geographic restrictions | Data residency or access location requirements |
| Success metrics | Specific measurements to evaluate migration success |

For more information, see [Document workload business details](./discover-existing-workload-inventory.md#document-workload-business-details).

### Document workload technical data

| Workload details               | Description                                                                 |
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

### Define target Azure architecture

Target architecture planning ensures optimal Azure service selection and cost management. Architecture decisions affect performance, scalability, and operational efficiency. You must design target architectures that meet current requirements while supporting future growth.

| Category | Description |
|----------|-------------|
| Target architecture | A link to a diagram you created or sample architecture on Azure Architecture Center |
| Estimated workload cost | Estimated cost using the [Azure Pricing calculator](https://azure.microsoft.com/pricing/calculator/) |
| Estimated operational cost | Estimate how many people or hours you dedicate to this workload |

For more information, see [Plan your Azure landing zone architecture](./estimate-total-cost-of-ownership.md#plan-your-architecture)

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Assessment | [Skills assessment](./prepare-people-for-cloud.md#identify-the-cloud-skills-you-need) | Identifies Azure skill gaps across teams |
| Training | [Expert support engagement](./prepare-people-for-cloud.md#train-your-people) | Provides structured learning through Microsoft or partner experts |
| Planning | [Azure Pricing calculator](https://azure.microsoft.com/pricing/calculator/) | Estimates costs for target architecture |
| Documentation | [Business details gathering](./discover-existing-workload-inventory.md#gather-business-details) | Captures workload business context and requirements |

## Next steps

> [!div class="nextstepaction"]
> [Prepare your organization for cloud adoption](./prepare-organization-for-cloud.md)