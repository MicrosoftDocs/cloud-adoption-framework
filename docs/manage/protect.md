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

This article explains how to manage reliability and security to protect the availability of your Azure cloud estate. Reliability ensures continuous operation with minimal downtime, while security implements safeguards to ensure confidentiality, availability, and integrity. Both are essential for successful cloud operations. Follow these best practices:

## Managing reliability

Use redundancy, replication, and backup as essential strategies to guard against service disruption and data loss. *Table 1* outlines three workload priorities and their reliability requirements. There’s also an example scenario that provides implementation guidance aligned with the minimum uptime service level objective (SLO).

*Table 1. Example of workload priority and reliability requirements.*

| Priority   | Business impact  | Minimum uptime SLO | Max downtime per month | Architecture redundancy  | Load balancing  | Data replication and backups  | Example scenario     |
|---|---|---|---|----|---|---|---|
| High (mission-critical)  | Immediate and severe effects on company reputation or revenue.   | 99.99%       | 4.32 minutes     | Multi-region & Multiple availability zones in each region | Active-active | Synchronous, cross-region data replication & backups for recovery | [Mission-critical baseline](https://learn.microsoft.com/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-intro)  |
| Medium       | Measurable effects on company reputation or revenue.   | 99.9%  | 43.20 minutes | Multiple region & Multiple availability zones in each region | Active-passive     | Asynchronous, cross-region data replication & backups for recovery | [Reliable web app pattern](https://learn.microsoft.com/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance) |
| Low       | No effect on company reputation, processes, or profits.    | 99%       | 7.20 hours    | Single region & Multiple availability zones   | Availability zone redundancy   | Synchronous data replication across availability zones & backups for recovery | [App Service baseline](https://learn.microsoft.com/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant)<br>[Virtual machine baseline](https://learn.microsoft.com/azure/architecture/virtual-machines/baseline) |

### Identify reliability responsibilities

Determine your responsibility for reliability for each deployment model to make informed reliability decisions for your cloud estate. Infrastructure (IaaS) and platform services (PaaS) operate within Azure. Compare these responsibilities with on-premises environments and software services (SaaS). Use this table to identify your responsibilities in each deployment model. For more information, see [Shared responsibility for reliability](/azure/reliability/concept-shared-responsibility)<a id="_Understand_operational_maturity"></a> .

| Responsibility     | On-premises | IaaS (Azure) | PaaS (Azure) | SaaS |
|--------------------|:-----------:|:------------:|:------------:|:----:|
| Data               |      ✔️      |      ✔️       |      ✔️       |  ✔️  |
| Code and runtime   |      ✔️      |      ✔️       |      ✔️       |      |
| Cloud resources    |      ✔️      |      ✔️       |      ✔️       |      |
| Physical hardware  |      ✔️      |               |                |      |

### Prioritize workloads

The priority determines your reliability requirements, such as uptime SLOs and recovery objectives. Assign a priority to all workloads across your cloud estate. Base the priority of workloads on their business value (revenue and reputation) and any regulatory compliance requirements. Meeting reliability requirements requires financial and time investments, so ensure the priorities align with the invest Classify workloads as high, medium, or low priority. Use medium priority as a default when you’re unclear to quickly identify higher priority workloads. Regularly review and maintain this list to ensure alignment to the business and environment/cost efficiency.

### Define reliability requirements

Reliability requirements define your goals for uptime, recovery times, and data loss tolerance. You must define reliability targets well because they drive architecture decisions. Here’s how:

1. ***Assign uptime service level objective (SLO) to all workloads.*** An uptime SLO is your target availability. Based on the workload priority, assign an uptime SLO for all workloads, such as 99.9% uptime. The higher the workload priority, the higher the uptime SLO should be. The uptime SLO affects your recovery objectives, architecture, data management, cost, and governance.

1. ***Identify service level indicators (SLIs).*** You also want to identify SLIs to measure if you achieve your uptime SLO over time.

1. ***Assign a recovery time objective (RTO) to all workloads.*** An RTO defines how long the business can operate without the workload. The RTO must be lower than your uptime SLO and must account for the number of failures you expect in each period. For example, an uptime SLO 99.99% requires less than 52 minutes of annual downtime. Here’s how you estimate an RTO:

	- ***Estimate the number of failures.*** Estimate how often you think a workload might fail per year. For workloads with operational history, use historical data to estimate this number. For new workloads, start with a default number, such as four per year. Workload teams should perform a [failure mode analysis](/azure/well-architected/reliability/failure-mode-analysis) to get a more accurate estimate.

	- ***Estimate the RTO.*** Take your uptime service level objective (99.9%) and divide it by the number of failures you anticipate. If you estimate four failures per year, then your RTO must be 13 minutes or less (52 minutes / 4 failures = 13-minute RTO).

	- ***Test your recovery time.*** Track the average time it takes to recover during failover tests and live failures. The time it takes you to recover from failure must be less than your RTO. If your business continuity solution takes hours to

1. ***Define recovery point objectives (RPO) for all workloads.*** You must decide how much data loss your business can absorb without causing major financial or operational issues. Business needs determine the acceptable data loss window. Also, compliance regulations might require you to limit data loss. Some industries set strict data protection standards. The frequency of data changes and backup capabilities affect your RPO.

1. ***Define workload reliability targets.*** For workload reliability targets, see the Well-Architected Framework’s [Recommendations for defining reliability targets.](/azure/well-architected/reliability/metrics)

### Manage data reliability

Data reliability relies on copying data to maintain workload reliability. Your workloads need data replication (replicas) and backups (point in time copies) to be reliable. Data reliability needs to support the recovery point objective (RPO) and recovery time objectives (RTO) of each workload.

*Table 3. Workload priority with example data reliability configurations.*

| Workload priority | Uptime SLO | Data replication | Data backups | Example scenario |
|-------------------|------------|------------------|--------------|------------------|
| High              | 99.99%     | Multi-region synchronous data replication<br>Synchronous data replication across availability zones | High frequency, cross-region backups. Frequency should support RTO and RPO. | [Mission-critical data platform](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-data-platform) |
| Medium            | 99.9%      | Multi-region asynchronous data replication<br>Synchronous data replication across availability zones | Cross-region backups. Frequency should support RTO and RPO. | [Database and storage solution in the Reliable Web App pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance#pick-the-right-azure-services)<br>Sample resources:<br>Azure SQL Database [zone redundancy](/azure/azure-sql/database/business-continuity-high-availability-disaster-recover-hadr-overview), [Active geo-replication](/azure/azure-sql/database/active-geo-replication-overview), and [native backups](/azure/azure-sql/database/automated-backups-overview)<br>Azure Storage [read-access geo-zone-redundant storage (RA-GZRS)](/azure/storage/common/storage-redundancy) |
| Low               | 99%        | Synchronous data replication across availability zones | Cross-region backups. Frequency should support RTO and RPO. | [Data resiliency in baseline web app with zone redundancy](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant#blob-storage) |

1. ***Manage data replication.*** When you replicate data, you must keep any changes to that data in sync between replicas. Data replication must align with the RTO and RPO requirements of each workload. See the following table to data replication recommendations:

    | Data replication method                  | Type                  | Configuration                        |
    |------------------------------------------|-----------------------|--------------------------------------|
    | Availability zone data replication       | Synchronous (near real-time) | PaaS services handle this natively   |
    | Multi-region data replication (active-active) | Synchronous           | Active-active load balancing         |
    | Multi-region data replication (active-passive) | Asynchronous (periodic) | Active-passive configuration         |

    For more information, see [Replication: Redundancy for data](/azure/reliability/concept-redundancy-replication-backup#replication-redundancy-for-data).

1. ***Manage data backups.*** Backups are for disaster recovery (hardware failure), data recovery (deletion or corruption), and incident response (security). Backups must support your RTO and RPO requirements for each workload. Prefer service-native backup solutions, such as those available in Azure Cosmos DB and Azure SQL Database. Use [Azure Backup](/azure/backup/) for services without a native solution and backing up on-premises data For more information, see [Backup](/azure/reliability/concept-redundancy-replication-backup#backup).

1. ***Design workload data reliability.*** For workload data reliability design, see the Well-Architected Framework:

    | Workload reliability | Details | Reliability pillar |
    |----------------------|---------|--------------------|
    | [Data partitioning](/azure/well-architected/reliability/partition-data) | Service guide | [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*) |

### Manage code and runtime reliability

Code and runtime are workload responsibilities. Follow the Well-Architected Framework’s [Recommendations for self-healing and self-preservation.](/azure/well-architected/reliability/self-preservation)

### Manage cloud resources reliability

Managing the reliability of your cloud resources requires redundancy (duplication). Add redundancy to meet reliability requirements, such as uptime SLO, RTO, RPO.

*Table 2. Workload priority and architecture redundancy examples.*

| Workload priority | Architecture redundancy         | Load balancing approach | Azure load balancing solution     | Example scenario      |
|-------------------|---------------------------------|-------------------------|-----------------------------------|-----------------------|
| High              | Two regions & availability zones | Active-active           | Azure Front Door (HTTP) or Azure Traffic Manager for non-HTTP traffic. | [Mission-critical baseline application platform](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-app-platform#global-load-balancer)     |
| Medium            | Two regions & availability zones | Active-passive          | Azure Front Door (HTTP) or Azure Traffic Manager for non-HTTP traffic. | [Reliable web app pattern architecture guidance](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance#architecture-guidance)  |
| Low               | Single region & availability zones | Across availability zones | Azure Application Gateway  | Add Azure Load Balancer for virtual machines<br>[App Service baseline](/azure/architecture/web-apps/app-service/architectures/baseline-zone-redundant)<br>[Virtual machine baseline](/azure/architecture/virtual-machines/baseline) |

1. ***Estimate the uptime of your current architecture.*** For each workload, calculate the composite SLA. Only include in your formulas the services that could cause the workload to fail. First, gather the [Microsoft SLAs](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services) for every service on the failure path of your workload. Then, plug those numbers into the correct formula. If your calculations meet your uptime SLO, then you’re all set. If they don’t align, then you need to adjust.

    | Use case   | Formula | Variables |
    | --- | --- | --- |
    | Single-region uptime estimate | N = S1 \* S2 \* … \* S*n*    | **N** is the composite SLA of all Azure services on the failure path within a single region.<br>**S** represents the SLA uptime percentage of an Azure service.<br>**n** is the total number of Azure services included in the calculation.<br><br>If you service component (SC) that distributes requests across two different Azure services within the same region, you need to account for this increased resiliency and estimate the uptime of  use this formula N = SC \* (1 - [(1 - S1) \* (1 - S2)]). For example, Application Gateway (LB) in front of Azure App Service (S2) and Azure Container Apps (S3).  |
    | Multi-region uptime estimate | M = 1 - (1 - N)^Regions  | **M** is the multi-region uptime estimate.<br>**N** is the composite SLA of the single region.<br>**Regions** is the number of regions.                                                                                                                                                           |

1. ***Adjust service tiers.*** Before changing your architecture, see if different service tiers (SKUs) help you align with your reliability requirements. SKUs can have different uptime estimates, such as Azure Managed Disks.

1. ***Adjust architecture redundancy.***  If the uptime estimate doesn’t meet your uptime SLO, add architecture redundancy (service instances) and distribute the architecture redundancy across availability zones and regions. For examples, see *Table 2.*

	- ***Use multiple availability zones.*** Configure your workloads to use multiple availability zones. Only a select number of services have uptime SLAs that account for availability zones. See the following table.

    | Azure service type | Azure services with Availability Zone SLAs |
    |--------------------|-------------------------------------------|
    | Compute Platform | App Service,<br>Azure Kubernetes Service,<br>Virtual Machines |
    | Datastore | Azure Service Bus,<br>Azure Storage Accounts,<br>Azure Cache for Redis,<br>Azure Files Premium Tier |
    | Database | Azure Cosmos DB,<br>Azure SQL Database,<br>Azure Database for MySQL,<br>Azure Database for PostgreSQL,<br>Azure Managed Instance for Apache Cassandra |
    | Load Balancer | Application Gateway |
    | Security | Azure Firewall |

	- ***Use multiple regions.***  Multiple regions are often essential to meet your uptime SLO. However, incorporating additional regions changes how you design and manage your workloads, particularly at the data level, to ensure consistency across replicas. You must also implement a global load balancer, such as Azure Front Door or Azure Traffic Manager, to route traffic across regions.

1. ***Manage architecture redundancy.*** If you have architecture redundancy, you need to determine how to best use it. You can use architecture redundancy as part of daily operations (active). Or you can use architecture redundancy only in disaster recovery scenarios (passive). For example, *see Table 2.*

	- ***Load balance across availability zones.*** All workloads must load balance traffic across availability zones. Many Azure PaaS services manage load balancing across availability zones automatically. IaaS workloads must use an [internal load balancer](/azure/load-balancer/quickstart-load-balancer-standard-internal-portal) to load balance across availability zones.

	- ***Load balance across regions.*** Multi-region workloads can be active-active or active-passive. Use reliability requirements to decide whether active-active or active-passive configurations are needed.

1. ***Manage service configurations.*** You need to apply service configurations consistently across architecture redundancy. Many settings should be set up the same way across each copy, so that the resources behave in the same way. Prefer [infrastructure as code](./administer.md#manage-code-based-deployments) to configure Azure services. For more information, see [Duplicate resource configuration](/azure/reliability/concept-redundancy-replication-backup#duplicate-resource-configuration).

1. ***Design workload reliability.*** For workload reliability design, see the Well-Architected Framework:

| Workload reliability | Guidance |
| ---| --- |
| Reliability pillar | - [Highly available multi-region design](/azure/well-architected/reliability/highly-available-multi-region-design)<br>- [Designing for redundancy](/azure/well-architected/reliability/redundancy)<br>- [Using availability zones and regions](/azure/well-architected/reliability/regions-availability-zones)|
|Service guide| [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*)|

For more information, see [Redundancy.](/azure/reliability/concept-redundancy-replication-backup#redundancy)

### Manage business continuity

Recovering from failure outlines a strategy to restore services quickly after an outage. You need a recovery approach that reduces disruption and maintains user satisfaction. Here’s how:

1. ***Prepare for failures.*** Your data reliability, code and runtime reliability, and cloud resource reliability are the foundation of your business continuity plan. Differentiate recovery procedures between high, medium, and low priority workloads. Depending on your workload, you can use a tool to help business continuity. For example, [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) is for on-premises and virtual-machine based server workloads.

1. ***Test and document recovery plan.*** Regularly test failover and failback processes to ensure workloads can meet RTO and RPO goals. Make sure to document these steps so you have something to follow during an incident. If you use a recovery tool like Azure Site Recovery, make sure it consistently meets your RTO.

1. ***Detect failures.*** Embrace a proactive approach to outage detection, even if it results in an increase in false positives. Prioritize customer experience and minimize outage impact over the potential increase in false positives. Ensure that the proactive approach helps maintain customer trust by minimizing the impact of outages.

	- ***Monitor failures.*** Deploy systems that can automatically detect potential service outages within one minute. Use [Azure Service Health](/azure/service-health/overview) and [Azure Resources Health](/azure/service-health/resource-health-overview) and use Azure Monitor alerts to notify the right people. You can also integrate these alerts within Azure DevOps or ITSM tools.

	- ***Collect service level indicators (SLIs).*** You need a way to measure the performance of your workloads against your service level objective. Have workload teams collect metrices that function as service level indicators that allow them to track their performance against service level objectives.

1. ***Respond to failures.*** Align your recovery response to the workload priority, which you [defined earlier](#prioritize-workloads). Implement failover to route requests to redundant architecture and data replicas. When healthy, fix any issues, synchronize data, and failback to the original state. For more information, see [Failover and failback.](/azure/reliability/concept-failover-failback)

1. ***Analyze failures.***  Identify the root causes of the issues and then address the problem. Document any lessons learned and implement necessary changes.

1. ***Manage workload failures.*** For workload disaster recovery, see the Well-Architected Framework:

| Workload reliability | Details |
| --- | --- |
| Reliability pillar | [Designing a disaster recovery strategy](/azure/well-architected/reliability/disaster-recovery) | 
| Service guide | [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*) |

### Azure reliability tools

| Use case                        | Solution                                                                                                                   |
|---------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| PaaS data replication and backup| [Azure service guides](/azure/well-architected/service-guides/?product=popular) (*start with the Reliability section*)      |
| Quick reference:                |                                                                                                                            |
|                                 | [Azure Cosmos DB](/azure/well-architected/service-guides/cosmos-db)                                                        |
|                                 | [Azure SQL Database](/azure/well-architected/service-guides/azure-sql-database-well-architected-framework#azure-sql-database-and-reliability) |
|                                 | [Azure Blob Storage](/azure/well-architected/service-guides/azure-blob-storage)                                            |
|                                 | [Azure Files](/azure/well-architected/service-guides/azure-files)                                                          |
| IaaS data backup and restore    | [Azure Backup](/azure/backup/backup-overview)                                                                              |
| IaaS business continuity        | [Azure Site Recovery](/azure/site-recovery/azure-to-azure-tutorial-enable-replication)                                     |
| Multi-region load balancer      | [Azure Front Door](/azure/frontdoor/front-door-overview) (HTTP)                                                            |
|                                 | [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) (non-HTTP)                                        |
| Multi-availability zone load balancer | [Azure Application Gateway](/azure/application-gateway/overview) (HTTP)                                               |
|                                 | [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) (non-HTTP)                                              |

## Manage security

Managing cloud security is about protecting your environment from security risks and enforcing confidentiality, integrity, and availability. Establish your security 

### Manage security cont

Establish an iterative security process to detect threats to your cloud estate. Follow these steps:

1. ***Standardize security tooling.*** Use security tools to detect security threats, fix vulnerabilities, investigate issues, secure data, harden cloud resources, and enforce compliance at scale. Find the [Azure security tools](#azure-security-tools) that facilitate security.

1. ***Baseline your environment.*** Document the normal state of your cloud estate. [Monitor security](/azure/cloud-adoption-framework/manage/monitor#monitor-security) and document network traffic patterns and user behaviors. Use [Azure security baselines](/azure/benchmark/azure/security-baselines-overview) and Azure Service guides to develop baseline configurations for services. This baseline makes it easier to detect anomalies and potential security weaknesses.

1. ***Apply security controls.*** Implement security measures, such as access controls, encryption, and multi-factor authentication, strengthens the environment and reduces the probability of compromise. For more information, see [Manage security](./administer.md#manage-security).

1. ***Assign security responsibilities.*** Assign responsibility for monitoring the security of the entire cloud estate. Regular monitoring and comparison against the baseline allow for the quick identification of incidents, such as unauthorized access or unusual data transfers. Continuous updates and periodic audits ensure that the baseline remains relevant and effective in mitigating emerging threats.

For more information, see [CAF Secure](/azure/cloud-adoption-framework/secure/overview).

### Manage security incidents

Adopt a process and tools to recover from security incidents, such as ransomware, denial of service, or threat actor intrusion. Follow these steps:

1. ***Prepare for incidents.*** Create an incident response plan that defines roles for investigation, mitigation, and communications. Test the efficacy of that plan regularly. Evaluate vulnerability management solutions, threat detection systems, and infrastructure monitoring tools. Harden your infrastructure to reduce attack surfaces and develop workload-based recovery strategies. For more information, see [Incident response overview](/azure/operations/incident-response-overview) and [Incident response playbooks](/azure/operations/incident-response-playbooks).

1. ***Detect incidents.*** Use security information and event management (SIEM) tool, like [Microsoft Sentinel](/azure/sentinel/overview?tabs=azure-portal), to consolidate security data. Use Microsoft Sentinel’s [security orchestration, automation, and response capabilities (SOAR)](/azure/sentinel/automation/automation) to automate security tasks. Incorporate [threat intelligence feeds](/azure/sentinel/understand-threat-intelligence) into your SIEM understand adversarial tools and techniques and how they might apply to your cloud estate.

1. ***Respond to incidents.*** Execute your incident response plan when an incident occurs. Initiate investigation and mitigation steps quickly. Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to regularly scan Azure for vulnerabilities. Microsoft Defender [integrates](/azure/sentinel/best-practices) with Microsoft Sentinel to provide a unified view of security events. Activate your disaster recovery plan to restore affected systems and keep your team informed with clear communications.

1. ***Analyze security incidents.*** Review threat intelligence and update your incident response plan with new lessons learned and public risk information like the [MITRE ATT&CK](https://attack.mitre.org/) knowledge base. Assess the effectiveness of your vulnerability management and detection tools and refine your strategies based on post-incident reviews.

For more information, see [Manage incident response (CAF Secure)](/azure/cloud-adoption-framework/secure/manage#managing-incident-preparedness-and-response).

### Azure security tools

| Security capability              | Microsoft solution                                                                 |
|----------------------------------|------------------------------------------------------------------------------------|
| Identity and access management   | [Microsoft Entra ID](/azure/fundamentals/whatis)                             |
| Role-based access control        | [Azure role-based access control](/azure/role-based-access-control/overview)       |
| Threat detection                 | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) |
| Security information management  | [Microsoft Sentinel](/azure/sentinel/overview?tabs=azure-portal)                   |
| Data security and governance     | [Microsoft Purview](/purview/purview)                                        |
| Cloud resource security          | [Azure security baselines](/azure/benchmark/azure/security-baselines-overview) |
| Cloud governance                 | [Azure Policy](/azure/governance/policy/overview)                                  |
| Endpoint security                | [Microsoft Defender for Endpoint](/defender-endpoint/microsoft-defender-endpoint) |
| Network security                 | [Azure Network Watcher](/azure/network-watcher/network-watcher-overview)           |
| Industrial security              | [Microsoft Defender for IoT](/azure/defender-for-iot/)                             |