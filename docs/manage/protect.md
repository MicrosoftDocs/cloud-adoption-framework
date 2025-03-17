---
title: Protect your Azure cloud estate
description: Learn how to ensure the reliability and security your Azure cloud estate as part of your cloud operations.
author: stephen-sumner
ms.author: ssumner
ms.date: 03/17/2025
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Protect your cloud estate

This article provides best practices for maintaining the reliability and security of your Azure cloud estate. Reliability ensures your cloud services remain operational with minimal downtime. Security safeguards the confidentiality, integrity, and availability of your resources. Both reliability and security are critical for successful cloud operations.

## Manage reliability

Reliability management involves using redundancy, replication, and defined recovery strategies to minimize downtime and protect your business. *Table 1* provides an example of three workload priorities, reliability requirements (uptime SLO, max downtime, redundancy, load balancing, replication), and example scenarios that align with service-level objectives (SLOs)

*Table 1. Example of workload priority and reliability requirements.*

| Priority   | Business impact  | Minimum uptime SLO | Max downtime per month | Architecture redundancy  | Load balancing  | Data replication and backups  | Example scenario     |
|---|---|---|---|----|---|---|---|
| High (mission-critical)  | Immediate and severe effects on company reputation or revenue.   | 99.99%       | 4.32 minutes     | Multi-region & Multiple availability zones in each region | Active-active | Synchronous, cross-region data replication & backups for recovery | [Mission-critical baseline](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-intro)  |
| Medium       | Measurable effects on company reputation or revenue.   | 99.9%  | 43.20 minutes | Multiple region & Multiple availability zones in each region | Active-passive     | Asynchronous, cross-region data replication & backups for recovery | [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance) |
| Low       | No effect on company reputation, processes, or profits.    | 99%       | 7.20 hours    | Single region & Multiple availability zones   | Availability zone redundancy   | Synchronous data replication across availability zones & backups for recovery | [App Service baseline](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant)<br>[Virtual machine baseline](/azure/architecture/virtual-machines/baseline) |

### Identify reliability responsibilities

Reliability responsibilities vary by deployment model. Clarify your responsibilities to effectively manage reliability across Infrastructure (IaaS), Platform (PaaS), Software (SaaS), and on-premises solutions.

| Responsibility     | On-premises | IaaS (Azure) | PaaS (Azure) | SaaS |
|--------------------|:-----------:|:------------:|:------------:|:----:|
| Data               |      ✔️      |      ✔️       |      ✔️       |  ✔️  |
| Code and runtime   |      ✔️      |      ✔️       |      ✔️       |      |
| Cloud resources    |      ✔️      |      ✔️       |      ✔️       |      |
| Physical hardware  |      ✔️      |               |                |      |

For more information, see [Shared responsibility for reliability](/azure/reliability/concept-shared-responsibility) .

### Prioritize workloads

The priority determines your reliability requirements, such as uptime SLOs and recovery objectives. Assign a priority to all workloads across your cloud estate. Base the priority of workloads on their business value (revenue and reputation) and any regulatory compliance requirements. Meeting reliability requirements requires financial and time investments, so ensure the priorities align with the invest Classify workloads as high, medium, or low priority. Use medium priority as a default when you’re unclear to quickly identify higher priority workloads. Regularly review and maintain this list to ensure alignment to the business and environment/cost efficiency.

### Define reliability requirements

Clearly defined reliability requirements are critical for uptime targets, recovery, and data loss tolerance. Follow these steps to define reliability requirements:

1. ***Prioritize workloads.*** Assign high, medium (default), or low priorities to workloads based on business criticality and financial investment levels. Regularly review priorities to maintain alignment with business goals.

1. ***Assign uptime service level objective (SLO) to all workloads.*** Establish uptime targets according to workload priority. Higher-priority workloads require stricter uptime goals. Your SLO influences your architecture, data management strategies, recovery processes, and costs.

1. ***Identify service level indicators (SLIs).*** Use SLIs to measure uptime performance against your SLO. Examples include [service health monitoring](./monitor.md#monitor-service-health) and [error rates](./monitor.md#monitor-code-and-runtime).

1. ***Assign a recovery time objective (RTO) to all workloads.*** The RTO defines the maximum acceptable downtime for your workload. RTO should be shorter than your annual downtime allowance. For example, an uptime SLO 99.99% requires less than 52 minutes of annual downtime (4.32 minutes per month). Follow these steps:

	1. ***Estimate the number of failures.*** Estimate how often you think each workload might fail per year. For workloads with operational history, use your SLIs. For new workloads, perform a [failure mode analysis](/azure/well-architected/reliability/failure-mode-analysis) to get an accurate estimate.

	1. ***Estimate the RTO.*** Divide your annual allowable downtime by the estimated number of failures. If you estimate four failures per year, then your RTO must be 13 minutes or less (52 minutes / 4 failures = 13-minute RTO).

	1. ***Test your recovery time.*** Track the average time it takes to recover during failover tests and live failures. The time it takes you to recover from failure must be less than your RTO. If your business continuity solution takes hours to

1. ***Define recovery point objectives (RPO) for all workloads.*** Determine how much data loss your business can tolerate. This objective influences how frequently you replicate and back up your data.

1. ***Define workload reliability targets.*** For workload reliability targets, see the Well-Architected Framework’s [Recommendations for defining reliability targets.](/azure/well-architected/reliability/metrics)

### Manage data reliability

Data reliability involves data replication (replicas) and backups (point in time copies) to maintain availability and consistency. Your approach must align with the workload’s defined RTO and RPO. Follow these steps:

*Table 2. Workload priority with example data reliability configurations.*

| Workload priority | Uptime SLO | Data replication | Data backups | Example scenario |
|-------------------|------------|------------------|--------------|------------------|
| High              | 99.99%     | Multi-region synchronous data replication<br>Synchronous data replication across availability zones | High frequency, cross-region backups. Frequency should support RTO and RPO. | [Mission-critical data platform](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-data-platform) |
| Medium            | 99.9%      | Multi-region asynchronous data replication<br>Synchronous data replication across availability zones | Cross-region backups. Frequency should support RTO and RPO. | [Database and storage solution in the Reliable Web App pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance#pick-the-right-azure-services)<br>Sample resources:<br>Azure SQL Database [zone redundancy](/azure/azure-sql/database/business-continuity-high-availability-disaster-recover-hadr-overview), [Active geo-replication](/azure/azure-sql/database/active-geo-replication-overview), and [native backups](/azure/azure-sql/database/automated-backups-overview)<br>Azure Storage [read-access geo-zone-redundant storage (RA-GZRS)](/azure/storage/common/storage-redundancy) |
| Low               | 99%        | Synchronous data replication across availability zones | Cross-region backups. Frequency should support RTO and RPO. | [Data resiliency in baseline web app with zone redundancy](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant#blob-storage) |

1. ***Manage data replication.*** Replicate your data synchronously or asynchronously according to your workload’s RTO and RPO requirements.

    | Data distribution                  | Data replication                  | Load balancing configuration                        |
    |------------------------------------------|-----------------------|--------------------------------------|
    | Across availability zones       | Synchronous (near real-time) | PaaS services handle this natively   |
    | Across regions (active-active) | Synchronous           | Active-active load balancing         |
    | Across regions (active-passive) | Asynchronous (periodic) | Active-passive configuration         |

    For more information, see [Replication: Redundancy for data](/azure/reliability/concept-redundancy-replication-backup#replication-redundancy-for-data).

1. ***Manage data backups.*** Backups are for disaster recovery (service failure), data recovery (deletion or corruption), and incident response (security). Backups must support your RTO and RPO requirements for each workload. Choose backup solutions that align with your RTO and RPO goals. Prefer Azure’s built-in solutions, such as Azure Cosmos DB and Azure SQL Database native backups. For other cases, including on-premises data, use [Azure Backup](/azure/backup/). For more information, see [Backup](/azure/reliability/concept-redundancy-replication-backup#backup).

1. ***Design workload data reliability.*** For workload data reliability design, see the Well-Architected Framework:

    | Workload reliability | Details | 
    |----------------------|---------|
    |Reliability pillar | [Data partitioning](/azure/well-architected/reliability/partition-data) |
    | Service guide | [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*) |

### Manage code and runtime reliability

Code and runtime are workload responsibilities. Follow the Well-Architected Framework’s [Recommendations for self-healing and self-preservation.](/azure/well-architected/reliability/self-preservation)

### Manage cloud resources reliability

Managing the reliability of your cloud resources often requires architecture redundancy (duplicate service instances) and an effective load-balancing strategy. See *Table 3* for examples of architecture redundancy aligned with workload priority.

*Table 3. Workload priority and architecture redundancy examples.*

| Workload priority | Architecture redundancy         | Load balancing approach | Azure load balancing solution     | Example scenario      |
|-------------------|---------------------------------|-------------------------|-----------------------------------|-----------------------|
| High              | Two regions & availability zones | Active-active           | Azure Front Door (HTTP)<br><br>Azure Traffic Manager (non-HTTP) | [Mission-critical baseline application platform](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-app-platform#global-load-balancer)     |
| Medium            | Two regions & availability zones | Active-passive          | Azure Front Door (HTTP)<br><br>Azure Traffic Manager (non-HTTP) | [Reliable web app pattern architecture guidance](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance#architecture-guidance)  |
| Low               | Single region & availability zones | Across availability zones | Azure Application Gateway<br><br>Add Azure Load Balancer for virtual machines  |[App Service baseline](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant)<br>[Virtual machine baseline](/azure/architecture/virtual-machines/baseline) |

Implement these adjustments based on your workload's reliability requirements. Follow these steps:

1. ***Estimate the uptime of your architectures.*** For each workload, calculate the composite SLA. Only include services that could cause the workload to fail (critical path). Follow these steps:

    1. Gather the [Microsoft uptime SLAs](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services) for every service on the critical path of your workload.

    1. If you have no independent critical paths, calculate single-region composite SLA by multiplying the uptime percentages of each relevant service. If you have independent critical paths, move to step 3 before calculating.

    1. When two Azure services provide independent critical paths, apply the independent critical paths formula to those services.

    1. For multi-region applications, input the single-region composite SLA (N) into the multi-region uptime formula.

    1. Compare your calculated uptime with your uptime SLO. Adjust service tiers or architecture redundancy if necessary.

    | Use case | Formula | Variables | Example | Explanation |
    |-----|------|--------|--------| --- |
    | Single-region uptime estimate   | N = S1 × S2 × S3 × … × U*n*  | **N**: Composite SLA of Azure services on a single-region critical path.<br>**S**: SLA uptime percentage of each Azure service.<br>**n**: Total number of Azure services.     | N = 99.99% (app) × 99.95% (database) × 99.9% (cache) | Simple workload with app (99.99%), database (99.95%), and cache (99.9%) in a single critical path.|
    | Independent critical paths estimate | 1 - [(1 - S2) × (1 - S3)] | **S**: SLA uptime percentage for Azure services providing independent critical paths.  | N = 99.99% (app) × ***(1 - [(1 - 99.95% database) × (1 - 99.9% cache)])***  | Two independent critical paths. Either database (99.95%) or cache (99.9%) can fail without downtime.|
    | Multi-region uptime estimate    | M = 1 - (1 - N)^R   | **M**: Multi-region uptime estimate.<br>**N**: Single-region composite SLA.<br>**R**: Number of regions used. | If N = 99.95% and R = 2, then M = 1 - (1 - 99.95%)^2 | Workload deployed in two regions. |

1. ***Adjust service tiers.*** Before modifying architectures, evaluate whether different Azure service tiers (SKUs) can meet your reliability requirements. Some Azure service tiers can have different uptime SLAs, such as Azure Managed Disks.

1. ***Add architecture redundancy.***  If your current uptime estimate falls short of your SLO, increase redundancy:

	1. ***Use multiple availability zones.*** Configure your workloads to use multiple availability zones. How availability zones improve your uptime can be difficult to estimate. Only a select number of services have uptime SLAs that account for availability zones. See the following table for some examples. Where SLAs account for availability zones, use them in your uptime estimates.

    | Azure service type | Azure services with Availability Zone SLAs |
    |--------------------|-------------------------------------------|
    | Compute Platform | App Service,<br>Azure Kubernetes Service,<br>Virtual Machines |
    | Datastore | Azure Service Bus,<br>Azure Storage Accounts,<br>Azure Cache for Redis,<br>Azure Files Premium Tier |
    | Database | Azure Cosmos DB,<br>Azure SQL Database,<br>Azure Database for MySQL,<br>Azure Database for PostgreSQL,<br>Azure Managed Instance for Apache Cassandra |
    | Load Balancer | Application Gateway |
    | Security | Azure Firewall |

	1. ***Use multiple regions.***  Multiple regions are often necessary to meet uptime SLOs. Use global load balancers (Azure Front Door or Traffic Manager) for traffic distribution. Note that multi-region architectures require careful data consistency management.

1. ***Manage architecture redundancy.*** Decide how to use redundancy: You can use architecture redundancy as part of daily operations (active). Or you can use architecture redundancy in disaster recovery scenarios (passive). For examples, see *Table 3.*

	1. ***Load balance across availability zones.*** Use all availability actively. Many Azure PaaS services manage load balancing across availability zones automatically. IaaS workloads must use an [internal load balancer](/azure/load-balancer/quickstart-load-balancer-standard-internal-portal) to load balance across availability zones.

	1. ***Load balance across regions.*** Determine whether multi-region workloads should run active-active or active-passive based on reliability needs.

1. ***Manage service configurations.*** Consistently apply configurations across redundant instances of Azure resources, so the resources behave in the same way. Use [infrastructure as code](./administer.md#manage-code-based-deployments) to maintain consistency. For more information, see [Duplicate resource configuration](/azure/reliability/concept-redundancy-replication-backup#duplicate-resource-configuration).

1. ***Design workload reliability.*** For workload reliability design, see the Well-Architected Framework:

    | Workload reliability | Guidance |
    | ---| --- |
    | Reliability pillar | - [Highly available multi-region design](/azure/well-architected/reliability/highly-available-multi-region-design)<br>- [Designing for redundancy](/azure/well-architected/reliability/redundancy)<br>- [Using availability zones and regions](/azure/well-architected/reliability/regions-availability-zones)|
    |Service guide| [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*)|

For more information, see [Redundancy](/azure/reliability/concept-redundancy-replication-backup#redundancy).

### Manage business continuity

Recovering from a failure requires a clear strategy to restore services quickly and minimize disruption to maintain user satisfaction. Follow these steps:

1. ***Prepare for failures.*** Create separate recovery procedures for workloads based on high, medium, and low priorities. [Data reliability](#manage-data-reliability), [code and runtime reliability](#manage-code-and-runtime-reliability), and [cloud resource reliability](#manage-cloud-resources-reliability) are the foundation of preparing for failure. Select other recovery tools to assist with business continuity preparation. For example, use [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) for on-premises and virtual-machine based server workloads.

1. ***Test and document recovery plan.*** Regularly test your failover and failback processes to confirm your workloads meet recovery time objectives (RTO) and recovery point objectives (RPO). Clearly document each step of the recovery plan for easy reference during incidents. Verify that recovery tools, such as Azure Site Recovery, consistently meet your specified RTO.

1. ***Detect failures.*** Adopt a proactive approach to identifying outages quickly, even if this method increases false positives. Prioritize customer experience by minimizing downtime and maintaining user trust.

	- ***Monitor failures.*** Monitor workloads to detect outages within one minute. Use [Azure Service Health](/azure/service-health/overview) and [Azure Resources Health](/azure/service-health/resource-health-overview) and use [Azure Monitor alerts](./monitor.md#configure-alerting) to notify relevant teams. Integrate these alerts with Azure DevOps or IT Service Management (ITSM) tools.

	- ***Collect service level indicators (SLIs).*** rack performance by defining and gathering metrics that serve as SLIs. Ensure your teams use these metrics to measure workload performance against your service level objectives (SLOs).

1. ***Respond to failures.*** Align your recovery response to the [workload priority](#prioritize-workloads). Implement failover procedures to reroute requests to redundant infrastructure and data replicas immediately. Once systems stabilize, resolve the root cause, synchronize data, and execute failback procedures. For more information, see [Failover and failback.](/azure/reliability/concept-failover-failback)

1. ***Analyze failures.***  Identify the root causes of the issues and then address the problem. Document any lessons learned and implement necessary changes.

1. ***Manage workload failures.*** For workload disaster recovery, see the Well-Architected Framework:

| Workload reliability | Details |
| --- | --- |
| Reliability pillar | [Designing a disaster recovery strategy](/azure/well-architected/reliability/disaster-recovery) | 
| Service guide | [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*) |

### Azure reliability tools

| Use case                        | Solution                                                                                                                   |
|---------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Data replication, backup, and business continuity| [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*)<br><br>Quick reference:<br>[Azure Cosmos DB](/azure/well-architected/service-guides/cosmos-db)<br>[Azure SQL Database](/azure/well-architected/service-guides/azure-sql-database-well-architected-framework#azure-sql-database-and-reliability)<br>[Azure Blob Storage](/azure/well-architected/service-guides/azure-blob-storage)<br>[Azure Files](/azure/well-architected/service-guides/azure-files)                                                          |
| Data backup    | [Azure Backup](/azure/backup/backup-overview)                                                                              |
| Business continuity (IaaS)        | [Azure Site Recovery](/azure/site-recovery/azure-to-azure-tutorial-enable-replication)                                     |
| Multi-region load balancer      | [Azure Front Door](/azure/frontdoor/front-door-overview) (HTTP)<br>[Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) (non-HTTP)                                        |
| Multi-availability zone load balancer | [Azure Application Gateway](/azure/application-gateway/overview) (HTTP)<br>[Azure Load Balancer](/azure/load-balancer/load-balancer-overview) (non-HTTP)                                              |

## Manage security

Use an iterative security process to identify and mitigate threats in your cloud environment. Follow these steps:

### Manage security controls

Manage your security controls to detect threats to your cloud estate. Follow these steps:

1. ***Standardize security tooling.*** Use standardized tools to detect threats, fix vulnerabilities, investigate issues, secure data, harden resources, and enforce compliance at scale. Refer to [Azure security tools](#azure-security-tools).

1. ***Baseline your environment.*** Document the normal state of your cloud estate. [Monitor security](/azure/cloud-adoption-framework/manage/monitor#monitor-security) and document network traffic patterns and user behaviors. Use [Azure security baselines](/security/benchmark/azure/security-baselines-overview) and [Azure service guides](/azure/well-architected/service-guides/?product=popular) to develop baseline configurations for services. This baseline makes it easier to detect anomalies and potential security weaknesses.

1. ***Apply security controls.*** Implement security measures, such as access controls, encryption, and multi-factor authentication, strengthens the environment and reduces the probability of compromise. For more information, see [Manage security](./administer.md#manage-security).

1. ***Assign security responsibilities.*** Designate responsibility for security monitoring across your cloud environment. Regular monitoring and comparisons to the baseline enable quick identification of incidents, such as unauthorized access or unusual data transfers. Regular updates and audits keep your security baseline effective against evolving threats.

For more information, see [CAF Secure](/azure/cloud-adoption-framework/secure/overview).

### Manage security incidents

Adopt a process and tools to recover from security incidents, such as ransomware, denial of service, or threat actor intrusion. Follow these steps:

1. ***Prepare for incidents.*** Develop an incident response plan that clearly defines roles for investigation, mitigation, and communication. Regularly test the effectiveness of your plan. Evaluate and implement vulnerability management tools, threat detection systems, and infrastructure monitoring solutions. Reduce your attack surface through infrastructure hardening and create workload-specific recovery strategies. See [Incident response overview](/security/operations/incident-response-overview) and [Incident response playbooks](/security/operations/incident-response-playbooks).

1. ***Detect incidents.*** Use security information and event management (SIEM) tool, like [Microsoft Sentinel](/azure/sentinel/overview?tabs=azure-portal), to centralize your security data. Use Microsoft Sentinel’s [security orchestration, automation, and response capabilities (SOAR)](/azure/sentinel/automation/automation) to automate routine security tasks. Integrate [threat intelligence feeds](/azure/sentinel/understand-threat-intelligence) into your SIEM to gain insights into adversary tactics relevant to your cloud environment. Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to regularly scan Azure for vulnerabilities. Microsoft Defender [integrates](/azure/sentinel/best-practices) with Microsoft Sentinel to provide a unified view of security events.

1. ***Respond to incidents.*** Immediately activate your incident response plan upon detecting an incident. Quickly start investigation and mitigation procedures. Activate your disaster recovery plan to restore affected systems, and clearly communicate incident details to your team.

1. ***Analyze security incidents.*** After each incident, review threat intelligence and update your incident response plan based on lessons learned and insights from public resources, such as the [MITRE ATT&CK](https://attack.mitre.org/) knowledge base. Evaluate the effectiveness of your vulnerability management and detection tools and refine strategies based on post-incident analysis.

For more information, see [Manage incident response (CAF Secure)](/azure/cloud-adoption-framework/secure/manage#managing-incident-preparedness-and-response).

### Azure security tools

| Security capability              | Microsoft solution                                                                 |
|----------------------------------|------------------------------------------------------------------------------------|
| Identity and access management   | [Microsoft Entra ID](/entra/fundamentals/whatis)                             |
| Role-based access control        | [Azure role-based access control](/azure/role-based-access-control/overview)       |
| Threat detection                 | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) |
| Security information management  | [Microsoft Sentinel](/azure/sentinel/overview?tabs=azure-portal)                   |
| Data security and governance     | [Microsoft Purview](/purview/purview)                                        |
| Cloud resource security          | [Azure security baselines](/security/benchmark/azure/security-baselines-overview) |
| Cloud governance                 | [Azure Policy](/azure/governance/policy/overview)                                  |
| Endpoint security                | [Microsoft Defender for Endpoint](/defender-endpoint/microsoft-defender-endpoint) |
| Network security                 | [Azure Network Watcher](/azure/network-watcher/network-watcher-overview)           |
| Industrial security              | [Microsoft Defender for IoT](/azure/defender-for-iot/)                             |