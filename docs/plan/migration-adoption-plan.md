
# Cloud adoption plan for migration

Here's a template for organizations migrating workloads into Azure. Document your ope

## Operating model and responsibilities

| Category          | Description                                   |
|-------------------|-----------------------------------------------|
| [Operating model](./prepare-organization-for-cloud.md#choose-a-cloud-operating-model)   | Shared management, centralized, distributed   |
| [Responsibilities](./prepare-organization-for-cloud.md#document-ownership-and-accountability)  | Assign responsibility for the platform and workload(s) |

## Cloud training plan

| Category                  | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| [Skills assessment summary](./prepare-people-for-cloud.md#identify-the-cloud-skills-you-need) | Summarize assessment results: date, tools used, and key Azure skill gaps identified across teams |
| [Expert support engagement](./prepare-people-for-cloud.md#train-your-people) | Identify Microsoft or partner experts involved, type of engagement (e.g., workshops), and schedule of sessions |
| [Certifications](./prepare-people-for-cloud.md#train-your-people)    | Target Azure certifications per role         |
| [Learning sandbox]((./prepare-people-for-cloud.md#sustain-cloud-skills-across-your-organization))  | Detail the sandbox environment subscription, access policies, and usage guidelines |
| [Continuous learning program](./prepare-people-for-cloud.md#sustain-cloud-skills-across-your-organization) | Outline monthly learning time, recognition systems (Learn points, badges), and plans for community engagement (events, user groups) |

## Per workload migration plan

For each workload, capture all or most of the relavant business data and technical information.

### Workload business data for migration

| Business detail | Description |
|-----------------|-------------|
| Workload name | Official name used across the organization |
| Workload description | Single sentence describing the workload's purpose |
| Criticality level | High (mission-critical), medium, or low priority |
| Data sensitivity | Highly confidential, confidential, general, public, non-business |
| Workload owners | Individuals accountable for workload |
| Business owners | Executive or manager oversseing this workload |
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
| Business outcomes | Expected benefits from cloud migration |

For more information, see [](./discover-existing-workload-inventory.md#gather-business-details)

## Workload technical data for migration

| Data Point                     | Description                                                                                                                                                                                                 |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Current architecture           | Document all components of the workload, including compute, storage, networking, databases, and application tiers. Include architecture diagrams and configuration details.                                 |
| Target Azure architecture      | Describe the intended Azure deployment model (IaaS, PaaS, containers), services used, and any changes from the current architecture. Include diagrams and reference landing zones if applicable.             |
| Component requirements         | List performance metrics (CPU, memory, IOPS, throughput), OS versions, VM sizes, storage types, and licensing details. Include any unsupported technologies or modernization needs.                         |
| SLAs (RTO/RPO)                 | Define service-level agreements, recovery point objectives (RPO), and recovery time objectives (RTO). Use this to guide backup, replication, and failover strategies.                                       |
| Operating geographies          | Specify regions where the workload is or must be hosted, considering data residency, compliance, and latency requirements.                                                                                  |
| Dependencies                   | List internal and external dependencies (e.g., shared databases, APIs, SaaS services). Include dependency maps and groupings for migration sequencing.                                                     |
| User traffic geographies       | Identify regions with significant user traffic to inform Azure region selection and network design.                                                                                                         |
| Security and identity configuration | Document authentication methods, service accounts, encryption (at rest/in transit), firewall rules, and access control lists.                                                                            |
| Environment classification     | Indicate whether the workload runs in production, test, or development. This affects downtime tolerance and migration strategy.                                                                             |
| Maintenance window             | Define acceptable downtime windows and any blackout periods. Use this to plan cutover timing.                                                                                                               |
| ISV and licensing considerations | Validate third-party software compatibility with Azure. Note any Azure Hybrid Benefit eligibility or licensing constraints.                                                                                |