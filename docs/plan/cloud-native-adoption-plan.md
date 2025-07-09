
# Cloud adoption plan for migration

This article provides a structured template for organizations migrating workloads into Azure. It helps document operational models, responsibilities, training plans, platform architecture, and workload details to ensure a successful migration. Follow these recommendations:

## Operating model and responsibilities

| Category          | Description                                   |
|-------------------|-----------------------------------------------|
| [Operating model](./prepare-organization-for-cloud.md#choose-a-cloud-operating-model)   | Shared management, centralized, distributed models to align with organizational needs |
| [Responsibilities](./prepare-organization-for-cloud.md#document-ownership-and-accountability)  | Assign responsibility for the platform and workload(s) to ensure accountability |

## Cloud training plan

| Category                  | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| [Skills assessment summary](./prepare-people-for-cloud.md#identify-the-cloud-skills-you-need) | Summarize assessment results: date, tools used, and key Azure skill gaps identified across teams |
| [Expert support engagement](./prepare-people-for-cloud.md#train-your-people) | Identify Microsoft or partner experts involved, type of engagement (e.g., workshops), and schedule of sessions |
| [Certifications](./prepare-people-for-cloud.md#train-your-people)    | Target Azure certifications per role to ensure skill alignment with organizational goals |
| [Learning sandbox](./prepare-people-for-cloud.md#sustain-cloud-skills-across-your-organization)  | Detail the sandbox environment subscription, access policies, and usage guidelines for hands-on learning |
| [Continuous learning program](./prepare-people-for-cloud.md#sustain-cloud-skills-across-your-organization) | Outline monthly learning time, recognition systems (Learn points, badges), and plans for community engagement (events, user groups) |

## Platform architecture

| Category                  | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| Platform components needed | On-premises connectivity, hybrid identity, management, application landing zone types (online, corp), sandbox |
| Resource hierarchy | Management groups to organize resources effectively |
| Platform architecture | Shared resources, SKUs, and regions to support workloads |
| Estimated platform cost | Estimates of how much the platform architecture costs |

## Workload details for each workload

### Workload business data for migration

| Workload business details | Description |
|-----------------|-------------|
| Workload name | Official name used across the organization |
| Workload description | Single sentence describing the workload's purpose |
| Criticality level | High (mission-critical), medium, or low priority |
| Data sensitivity | Highly confidential, confidential, general, public, non-business |
| Workload owners | Individuals accountable for workload |
| Compliance requirements | Regulatory standards or certifications required |
| Data residency | Data residency or access location requirements |
| Success metrics | Specific measurements to evaluate migration success |

For more information, see [Gather business details](./discover-existing-workload-inventory.md#gather-business-details).

### Workload requirements

| Workload technical details               | Description |
|--------------------------------|------------------------------------------------------|
| Component requirements         | List performance metrics (CPU, memory, IOPS, throughput), OS versions, VM sizes, storage types, and licensing details |
| SLAs (RTO/RPO)                 | Define service-level agreements, recovery point objectives (RPO), and recovery time objectives (RTO). Use this to guide backup, replication, and failover strategies |
| Operating regions          | Specify regions where the workload is or must be hosted, considering data residency, compliance, and latency requirements |

### Target Azure architecture for the workload

| Azure workload details | Description |
| --- | --- |
| Target architecture | A link to a diagram you created or sample architecture on Azure Architecture Center |
| Azure services and SKUs | List the Azure services and SKUs required for the workload |
| Azure regions | Specify the Azure regions where the workload will be hosted |
| Estimated workload cost | Estimated cost using the [Azure Pricing calculator](https://azure.microsoft.com/pricing/calculator/?msockid=396a7791057262e4306e626304176307) |
| Estimated operational cost | Estimate how many people or hours you dedicate to this workload |
