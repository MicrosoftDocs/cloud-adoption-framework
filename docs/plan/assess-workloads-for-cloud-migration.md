---
title: Assess your workloads for cloud migration
description: Learn how to conduct thorough workload assessments to gather architecture, requirements, and cloud readiness information for successful Azure migration.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/15/2025
ms.topic: conceptual
---

# Assess your workloads for cloud migration

This article helps you conduct thorough workload assessments to collect the necessary information for successful migration decisions. It shows you how to assess [workload architecture](#assess-workload-architecture), [application code](#assess-application-code), and [databases](#assess-databases).

[!INCLUDE [discovery and assessment table](./includes/discovery-assessment-table.md)]

## Assess workload architecture

Complete architectural documentation ensures visibility into workload components and dependencies. This visibility supports accurate migration planning and reduces risk by identifying potential issues before migration begins. You must collect and validate architectural data for each workload to ensure successful migration. Follow this guidance:

1. **Use assessment tools to collect architectural data.** Tools like Azure Migrate or third-party solutions automate discovery of workload components and configurations. These tools reduce manual effort and provide consistent data collection across your environment, though they might miss undocumented dependencies. You can use a tool like Cloudockit to generate your diagrams. You can also create your own by using [Azure icons](/azure/architecture/icons/) or tweaking the downloadable diagrams in Azure Architecture Center.

2. **Validate architecture with subject matter expertise.** Workload owners and architects can confirm tool findings and identify missing or outdated information. Conduct interviews or architecture review sessions to close gaps in the automated discovery data.

3. **Capture architecture in a central repository.** Store architecture diagrams, component lists, and configuration data in a format that supports planning and validation. Use tools like Microsoft Visio, spreadsheets, or Azure DevOps wikis to maintain this information.

### Assess workload components

A complete understanding of each workload component is essential for accurate sizing and configuration in Azure. This assessment ensures performance consistency, avoids compatibility issues, and supports informed migration decisions. You must collect detailed specifications and operational data for each component to plan a successful migration.

1. **Use service management or CMDB systems to gather baseline data.** Service management tools and configuration management databases (CMDBs) provide authoritative data on workload components. These systems accelerate migration planning when they contain current and complete information. Validate the accuracy of this data before using it to inform migration decisions.

2. **Collect at least one week of performance and configuration data.** Performance metrics such as CPU utilization, memory usage, IOPS, and throughput reveal usage patterns and peak demands. Configuration data includes operating system type and version, VM size, storage type, and licensing details. This information is critical for selecting the correct Azure VM sizes and storage configurations.

3. **Identify unsupported or deprecated technologies.** Azure does not support all legacy technologies. Review the Azure documentation to confirm compatibility for each component. Flag any unsupported technologies that require modernization or replacement before migration. This step prevents delays and ensures workload readiness.

4. **Document all security and identity configurations.** Security settings must be preserved or enhanced in Azure to maintain compliance and prevent vulnerabilities. You need to inventory all identities and document encryption and network security configurations to support secure migration.

    | Security Component | Action | Purpose |
    |-------------------|---------|----------|
    | Identity inventory | Record all service accounts, user accounts, and API keys that applications use for authentication | Affects migration sequencing when you choose between lift-and-shift or modernization approaches |
    | Encryption documentation | Document current encryption methods for data at rest and in transit | Map these requirements to Azure encryption services to maintain security standards |
    | Network security configuration | Capture network security rules, firewall configurations, and access control lists | Use this information to design Azure network security groups and access policies |

### Map dependencies

A complete dependency map ensures applications maintain connectivity and performance after migration. Dependency mapping supports accurate migration sequencing and prevents service disruptions caused by broken integrations. You must identify and document all internal and external dependencies to define move groups and migration order effectively. Follow this guidance:

1. **Engage workload owners to identify dependencies.** Conduct structured interviews or workshops with application and workload owners to capture interconnections, shared databases, and network configurations. Workload owners provide critical insights into system interactions that automated tools might not detect. This step ensures undocumented or informal dependencies are not overlooked.

2. **Use discovery tools to validate and enrich dependency data.** Use tools like [Azure Migrate](/azure/migrate/migrate-overview) or third-party solutions to analyze network traffic and uncover hidden dependencies. These tools supplement manual discovery efforts and help identify connections that are not documented or visible through interviews alone.

3. **Identify all external systems and services.** Review integration documentation and interview application owners to identify dependencies on SaaS platforms, partner APIs, or on-premises systems. External dependencies often influence migration timing and sequencing due to contractual, technical, or latency constraints.

4. **Group interdependent workloads into migration waves.** Use the collected dependency data to define logical groupings of workloads that must migrate together or in a specific sequence. This approach reduces service disruption, minimizes latency, lowers data egress costs, and simplifies migration planning.

5. **Document all dependencies in a central repository.** Store dependency data in a format that supports cross-team collaboration and migration planning, such as spreadsheets, architecture diagrams, or dependency mapping tools. Ensure the repository is accessible and regularly updated to reflect changes during the migration process.

### Gather regulatory and operational requirements

Requirement gathering ensures that the target architecture meets compliance and service expectations. This step supports region selection, backup planning, and service level agreement alignment. You must document all regulatory and operational constraints to design appropriate Azure solutions. Follow this guidance:

1. **Identify regulatory constraints.** Note any data residency or compliance requirements that affect region selection or architecture design. These constraints often limit Azure service options and require specific configurations.

2. **Document SLAs, RPOs, and RTOs.** Capture service-level agreements, recovery point objectives, and recovery time objectives. Use this data to design backup, replication, and failover strategies. See [Define reliability requirements](/azure/cloud-adoption-framework/manage/protect#define-reliability-requirements).

3. Document environments. Document whether the workload runs in production, test, or development environments. 

4. Document maintenance windowThis classification determines your migration approach and acceptable downtime windows.

4. **Validate ISV integration with Azure.** ISV integration validation ensures that third-party software continues to function after migration. Use test environments or vendor documentation to confirm compatibility. Identify any required updates or replacements before migration begins to avoid delays. Determine whether Azure Hybrid Benefit or other licensing models apply. Include licensing costs in your migration plan to ensure budget accuracy. Adjust timelines, budgets, or architecture based on ISV compatibility and licensing requirements. This adjustment prevents surprises during migration execution.

## Assess application code

Application code assessment reduces the risk of migration failure and helps you plan migration waves effectively. Code-level issues can prevent applications from running correctly in Azure. You need to determine if migrating to Azure breaks the application and identify required changes. Follow this guidance:

### Use automated tools to assess application code

Automated tools provide fast and consistent analysis of application code across different languages and frameworks. This assessment identifies compatibility issues and modernization opportunities without manual code review. You should use automated tools to evaluate application readiness and identify potential blockers. Follow this guidance:

1. **Use AppCAT for .NET and Java applications.** [AppCAT](/azure/migrate/appcat/overview) provides detailed assessments for .NET and Java workloads, including Azure compatibility and modernization recommendations. Use AppCAT to identify deprecated APIs, unsupported SDKs, and configuration issues.

2. **Use third-party tools for other application languages.** Tools like CloudPilot and CAST Highlight support a broader range of languages such as Python, JavaScript, Node.js, and Go. These tools help identify code-level changes required for Azure compatibility and provide modernization insights.

### Validate framework and SDK compatibility

Framework and SDK compatibility ensures that your application runs reliably on Azure. Unsupported versions or incompatible SDKs can cause runtime failures or require significant rework. You must verify that Azure supports your application's language version and framework. Follow this guidance:

1. **Check Azure support for your application's language and framework.** Confirm that Azure supports your version of [.NET](/azure/dotnet/azure/intro#access-azure-services-from-net-applications), [Java](/azure/developer/java/), [Python](/azure/developer/python/get-started#write-your-python-app), [JavaScript and Node.js](/azure/developer/javascript/core/what-is-azure-for-javascript-development#use-azure-client-libraries-with-javascript), [Go](/azure/developer/go/overview). Use the official Azure documentation to validate compatibility.

2. **Avoid unnecessary framework changes.** Only migrate to a new framework (such as .NET Framework to .NET Core) if there is a strong business justification. Framework changes require significant development effort and testing.

## Assess databases

Database dependencies often determine the success of application migration. Shared databases, cross-application dependencies, and integration patterns can complicate migration planning. You must assess the databases that support your applications and understand their dependencies. Follow this guidance:

1. **Identify all databases used by the application.** Document the database engines, versions, and hosting models (on-premises, IaaS, PaaS). Use tools like Azure Migrate or Data Migration Assistant to gather this information systematically.

2. **Map inbound and outbound dependencies.** Identify all applications and services that read from or write to the database. This assessment includes APIs, batch jobs, reporting tools, and third-party integrations that affect migration planning.

3. **Determine database migration strategy.** Decide whether to move the database as a shared instance or split it by workload. Shared databases can limit migration flexibility, while splitting databases increases complexity. Align the strategy with your migration wave planning.

## Azure resources and tools

| Category | Tool | Description |
|----------|------|-------------|
| Discovery and Assessment | [Azure Migrate](/azure/migrate/) | Comprehensive discovery and assessment for on-premises servers, databases, and applications |
| Arc-enabled servers | [Azure Arc](/azure/azure-arc/servers/) | Extends Azure management to on-premises and multi-cloud environments |
| Code Assessment | [AppCAT](/azure/migrate/appcat/overview) | Automated compatibility analysis for .NET and Java applications |
| Database Migration | [Data Migration Assistant](/sql/dma/dma-overview) | Assessment and migration tool for SQL Server databases |
| Multi-cloud mapping | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) | Service comparison guide for AWS to Azure migration |
| Multi-cloud mapping | [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) | Service comparison guide for GCP to Azure migration |
| Azure Development | [.NET on Azure](/azure/dotnet/azure/intro#access-azure-services-from-net-applications) | Guidance for accessing Azure services from .NET applications |
| Azure Development | [Java on Azure](/azure/developer/java/) | Resources for Java developers building on Azure |
| Azure Development | [Python on Azure](/azure/developer/python/get-started#write-your-python-app) | Resources for Python developers building on Azure |
| Azure Development | [JavaScript and Node.js on Azure](/azure/developer/javascript/core/what-is-azure-for-javascript-development#use-azure-client-libraries-with-javascript) | Guidance for JavaScript and Node.js development on Azure |
| Azure Development | [Go on Azure](/azure/developer/go/overview) | Resources for Go developers building on Azure |
| Cloud Adoption Framework | [Define reliability requirements](/azure/cloud-adoption-framework/manage/protect#define-reliability-requirements) | Guidance for defining reliability requirements for cloud workloads |

## Next steps

> [!div class="nextstepaction"]
> [Estimate total cost of ownership](./estimate-total-cost-of-ownership.md)
