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

## Discovery and assessment tools

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

3. **Identify unsupported or deprecated technologies.** Azure does not support all legacy technologies, including certain operating systems, middleware, and application frameworks. Identify any components that are unsupported, deprecated, or nearing end of support, such as operating systems that will soon lose vendor support. For each flagged component, document the required changes, such as upgrading the OS, replacing middleware, or replatforming applications.

4. **Document all security and identity configurations.** Security settings must be preserved or enhanced in Azure to maintain compliance and prevent vulnerabilities. You need to inventory all identities and document encryption and network security configurations to support secure migration.

    | Security Component | Action | Purpose |
    |-------------------|---------|----------|
    | Identity inventory | Record all service accounts, user accounts, and API keys that applications use for authentication | Affects migration sequencing when you choose between lift-and-shift or modernization approaches |
    | Encryption documentation | Document current encryption methods for data at rest and in transit | Map these requirements to Azure encryption services to maintain security standards |
    | Network security configuration | Capture network security rules, firewall configurations, and access control lists | Use this information to design Azure network security groups and access policies |

### Map dependencies

A complete dependency map ensures that applications maintain connectivity and performance after migration. Dependency mapping enables accurate migration sequencing and prevents service disruptions caused by broken integrations. You must identify and document all internal and external dependencies to define move groups and migration order effectively.

1. **Use tools to discover internal dependencies.** Automated discovery tools provide a foundational view of application and infrastructure dependencies. These tools analyze network traffic, process interactions, and system configurations to uncover hidden or undocumented connections. Use tools like [Azure Migrate](/azure/migrate/migrate-overview) or third-party solutions to analyze network traffic and uncover hidden dependencies. This step improves accuracy, reduces manual effort, and identifies dependencies that workload owners might not be aware of.

2. **Identify all external systems and services.** External dependencies often introduce constraints that affect migration timing and design. These include SaaS platforms, partner APIs, and on-premises systems. You must review integration documentation and interview application owners to identify all external dependencies, including authentication methods, data exchange patterns, and service-level agreements. This step ensures that migration plans account for latency, compliance, and contractual limitations.

3. **Group interdependent workloads into migration waves.** Logical grouping of workloads based on dependency data reduces the risk of service disruption. You must use the validated dependency map to define move groups—sets of workloads that must migrate together or in a specific sequence. This approach minimizes latency, reduces data egress costs, and simplifies migration planning.

4. **Engage workload owners to validate and complete dependency data.** Workload owners offer critical insights into system behavior, shared resources, and informal integrations that tools may not detect. You must conduct structured interviews or workshops with application and workload owners to validate tool-generated data and identify undocumented dependencies. This step ensures completeness and accuracy of the dependency map and helps capture business context that informs migration sequencing.

5. **Document all dependencies in a central repository.** Store dependency data in a format that supports cross-team collaboration and migration planning, such as spreadsheets, architecture diagrams, or dependency mapping tools. Ensure the repository is accessible and regularly updated to reflect changes during the migration process.

### Gather requirements

A complete understanding of regulatory and operational requirements ensures that your Azure architecture complies with legal obligations and meets business expectations. This understanding supports region selection, backup planning, and service-level alignment. You must document all constraints to design compliant and resilient Azure solutions.

1. **Identify regulatory compliance requirements.** A clear understanding of regulatory compliance requirements ensures that your Azure architecture aligns with legal, industry, and organizational obligations. These requirements influence region selection, service availability, data protection, and architectural decisions. Regulatory and compliance standards include global, regional, industry-specific, and internal policies. These standards may include GDPR, HIPAA, FedRAMP, ISO 27001, or financial regulations such as SOX. Each standard imposes specific requirements on data handling, access control, encryption, and auditability. You must identify all applicable standards for each workload by consulting legal, compliance, and security stakeholders.

2. **Document SLAs, RPOs, and RTOs.** Service-level agreements (SLAs), recovery point objectives (RPOs), and recovery time objectives (RTOs) define acceptable levels of availability and data loss. These metrics guide the design of backup, replication, and failover strategies. You must document these values for each workload to ensure that the architecture meets business continuity expectations. See [Define reliability requirements](/azure/cloud-adoption-framework/manage/protect#define-reliability-requirements).

3. **Classify each workload environment to guide migration and operational planning.** Workloads typically run in production, test, or development environments. Each environment has different availability, security, and performance requirements. You must document the environment classification for each workload to inform migration sequencing, access controls, and resource allocation.

4. **Define acceptable maintenance windows to align with business operations.** Maintenance windows determine when updates, patches, or migrations can occur without disrupting business operations. You must document acceptable downtime periods for each workload to guide scheduling and minimize impact. This classification also influences the choice of migration strategy, such as near-zero downtime or downtime migration.

5. **Validate ISV integration with Azure.** Many workloads depend on third-party software from independent software vendors (ISVs). You must confirm that all ISV software is compatible with Azure before migration. Use vendor documentation, test environments, or direct validation with the ISV. Identify any required updates, replacements, or configuration changes. Also determine whether Azure Hybrid Benefit or other licensing models apply. Include licensing costs and compatibility adjustments in your migration plan to ensure accurate budgeting and scheduling.

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
