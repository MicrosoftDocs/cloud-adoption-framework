---
title: Assess your workloads for cloud migration
description: Learn how to conduct thorough workload assessments to gather architecture, requirements, and cloud readiness information for successful Azure migration.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/15/2025
ms.topic: conceptual
---

# Assess your workloads for cloud migration

This article helps you conduct thorough workload assessments to collect the necessary information for successful migration decisions. It shows you how to assess [workload architecture](#assess-workload-architecture), [application code](#assess-application-code), and [databases](#assess-databases). Use the following table to find discovery and assessment tools for on-premises workloads, Amazon Web Services (AWS) workloads, Google Cloud Platform (GCP) workloads, and application code.

[!INCLUDE [discovery and assessment table](./includes/discovery-assessment-table.md)]

## Assess workload architecture

Complete architectural documentation ensures visibility into workload components and dependencies. This visibility supports accurate migration planning and reduces risk by identifying potential issues before migration begins. You must collect and validate architectural data for each workload to ensure successful migration. Follow this guidance:

1. **Use assessment tools.** Tools like Azure Migrate or other products automate discovery of workload components and configurations. These tools reduce manual effort and provide consistent data collection across your environment, though they might miss undocumented dependencies. You can use a tool like Cloudockit to generate your diagrams. You can also create your own by using [Azure icons](/azure/architecture/icons/) or tweaking the downloadable diagrams in Azure Architecture Center.

1. **Validate architecture with subject matter expertise.** Workload owners can confirm tool findings and identify missing or outdated information. Conduct interviews or architecture review sessions to close gaps in the automated discovery data.

1. **Document architecture.** Store architecture diagrams, component lists, and configuration data in a format that supports planning and validation. Use tools like Microsoft Visio, spreadsheets, or Azure DevOps wikis for maintaining this information.

### Assess workload components

1. **Gather baseline workload data.** Baseline data enables you to compare workload functionality between the source environment and Azure after migration. You must capture comprehensive performance metrics from your source environment before migration to validate that Azure configurations meet your performance requirements. Document response times, throughput, resource utilization, and key business transaction performance from your current environment. Use these baseline measurements to identify performance improvements or degradation during testing. This comparison helps troubleshoot issues and isolate modernization efforts from migration problems. Use service management tools and configuration management databases (CMDBs) when available.

1. **Collect at least one week of performance data.** Performance metrics such as CPU utilization, memory usage, input/output per second (IOPS), and throughput reveal usage patterns and peak demands. Configuration data includes operating system type and version, VM size, storage type, and licensing details. This information is critical for selecting the correct Azure VM sizes and storage configurations.

1. **Document all security and identity configurations.** Security settings must be preserved or enhanced in Azure to maintain compliance and prevent vulnerabilities. You need to inventory all identities and document encryption and network security configurations to support secure migration.

    | Security Component | Action | Purpose |
    |-------------------|---------|----------|
    | Identity inventory | Record all service accounts, user accounts, and API keys that applications use for authentication | Affects migration sequencing when you choose between lift-and-shift or modernization approaches |
    | Encryption documentation | Document current encryption methods for data at rest and in transit | Map these requirements to Azure encryption services for maintaining security standards |
    | Network security configuration | Capture network security rules, firewall configurations, and access control lists | Use this information to design Azure network security groups and access policies |

### Identify unsupported or deprecated technologies

Azure supports a wide range of technologies, but certain legacy systems require updates or replacements before migration. This identification prevents wasted effort on migrating incompatible components and reduces the risk of post-migration failures. You must inventory all technology components and validate their Azure compatibility before migration begins.

1. **Use assessment tools to identify compatibility issues.** Automated tools provide systematic analysis of operating systems, middleware, and application frameworks against Azure support policies. These tools flag components that are unsupported, deprecated, or approaching end of support. Tools like Azure Migrate and third-party assessment solutions can detect these issues across your environment without manual configuration reviews.

1. **Document required changes for each flagged component.** Create a comprehensive list of all compatibility issues and their remediation requirements. Include operating system upgrades, middleware replacements, and application framework updates. Specify the effort required, timeline, and dependencies for each change. This documentation enables accurate project planning and resource allocation.

1. **Prioritize remediation based on migration impact.** Address blocking issues first, then components approaching end of support. Some changes can be deferred to post-migration phases if they don't prevent Azure deployment. This prioritization enables faster migration while ensuring long-term supportability.

1. **Validate remediation plans with vendors and stakeholders.** Confirm that proposed changes maintain application functionality and meet business requirements. Engage with software vendors to understand upgrade paths and licensing implications. This validation reduces the risk of compatibility issues during migration.

### Map internal and external dependencies

1. **Understand dependency mapping.** A complete dependency map ensures that applications maintain connectivity and performance after migration. Dependency mapping supports migration planning by revealing the order in which workloads must move to maintain system functionality. If you manage many workloads, organize them into migration waves based on the dependency relationships you identified. For more information, see [Migration wave planning](./migration-wave-plan.md).

1. **Use tools to discover internal dependencies.** Automated discovery tools provide a foundational view of application and infrastructure dependencies. These tools analyze network traffic, process interactions, and system configurations to uncover hidden or undocumented connections. Use tools like [Azure Migrate](/azure/migrate/migrate-overview) or other products for analyzing network traffic and uncover hidden dependencies. This step improves accuracy, reduces manual effort, and identifies dependencies that workload owners might not be aware of.

1. **Identify all external dependencies.** External dependencies create constraints that affect migration timing and architectural design. These dependencies include SaaS platforms, partner APIs, on-premises systems, and third-party services that applications require to function properly. You must catalog all upstream and downstream integrations, shared services, and data pipelines to understand the complete dependency landscape. Document APIs, messaging systems, ETL processes, shared databases, authentication methods, data exchange patterns, and service-level agreements. Review integration documentation and conduct interviews with application owners to ensure complete visibility into all external connections. This comprehensive mapping prevents integration failures and supports accurate migration sequencing.

1. **Engage workload owners to validate and complete dependency data.** Workload owners offer critical insights into system behavior, shared resources, and informal integrations that tools might not detect. You must conduct structured interviews or workshops with application and workload owners to validate tool-generated data and identify undocumented dependencies. This step ensures completeness and accuracy of the dependency map and helps capture business context that informs migration sequencing.

1. **Document all dependencies in a central repository.** Store dependency data in a format that supports cross-team collaboration and migration planning, such as spreadsheets, architecture diagrams, or dependency mapping tools. Ensure the repository is accessible and regularly updated to reflect changes during the migration process.

### Assess compliance and operational requirements

1. **Identify regulatory compliance requirements.** A clear understanding of regulatory compliance requirements ensures that your Azure architecture aligns with legal, industry, and organizational obligations. These requirements influence region selection, service availability, data protection, and architectural decisions. Regulatory and compliance standards include global, regional, industry-specific, and internal policies. These standards might include GDPR, HIPAA, FedRAMP, ISO 27001, or financial regulations such as SOX. Each standard imposes specific requirements on data handling, access control, encryption, and auditability. You must identify all applicable standards for each workload by consulting legal, compliance, and security stakeholders.

1. **Document SLAs, RPOs, and RTOs.** Service-level agreements (SLAs), recovery point objectives (RPOs), and recovery time objectives (RTOs) define acceptable levels of availability and data loss. These metrics guide the design of backup, replication, and failover strategies. You must document these values for each workload to ensure that the architecture meets business continuity expectations. See [Define reliability requirements](/azure/cloud-adoption-framework/manage/protect#define-reliability-requirements).

1. **Classify each workload environment to guide migration and operational planning.** Workloads typically run in production, test, or development environments. Each environment has different availability, security, and performance requirements. You must document the environment classification for each workload to inform migration sequencing, access controls, and resource allocation.

1. **Define acceptable maintenance windows to align with business operations.** Maintenance windows determine when migrations can occur without disrupting business operations. You should document acceptable downtime periods for each workload to guide scheduling. This classification also influences the choice of migration strategy, such as near-zero downtime or downtime migration.

1. **Validate ISV integration with Azure.** Many workloads depend on software from independent software vendors (ISVs). You must confirm that all ISV software is compatible with Azure before migration. Use vendor documentation, test environments, or direct validation with the ISV. Identify any required updates, replacements, or configuration changes. Also determine whether Azure Hybrid Benefit or other licensing models apply. Include licensing costs and compatibility adjustments in your migration plan for accurate budgeting and scheduling.

## Assess application code

An application code assessment identifies compatibility issues and modernization opportunities that can affect migration success. This assessment is essential to ensure applications run reliably in Azure and to plan migration waves effectively. You must assess application code to detect blockers early, reduce the risk of migration failure, and inform target architecture decisions.

### Use automated tools to assess application code

1. **Use AppCAT for .NET and Java applications.** [AppCAT](/azure/migrate/appcat/overview) provides detailed assessments for .NET and Java workloads. This tool identifies deprecated APIs, unsupported SDKs, and configuration issues that can prevent successful migration. Use AppCAT to generate compatibility and modernization recommendations for these workloads.

1. **Use third-party tools for other application languages.** Tools such as CloudPilot and CAST Highlight support languages like Python, JavaScript, Node.js, and Go. These tools identify code-level changes required for Azure compatibility and provide modernization insights. Use these tools to assess non-.NET and non-Java workloads.

1. **Use assessment results to inform target architecture decisions.** Application compatibility findings can influence the selection of Azure services. For example, an application that isn't compatible with one service might be compatible with another with minimal code changes. Use this flexibility to migrate applications sooner and defer code modernization to a later phase. This approach reduces migration risk and accelerates time to cloud.

### Validate framework and SDK compatibility

1. **Understand code compatibility.** Framework and SDK compatibility ensures that applications run reliably in Azure. Unsupported versions or incompatible SDKs can cause runtime failures or require significant rework. You must verify that Azure supports your application's language version and framework.

1. **Check Azure support for your application's language and framework.** Confirm that Azure supports your version of [.NET](/azure/dotnet/azure/intro#access-azure-services-from-net-applications), [Java](/azure/developer/java/), [Python](/azure/developer/python/get-started#write-your-python-app), [JavaScript, Node.js](/azure/developer/javascript/core/what-is-azure-for-javascript-development#use-azure-client-libraries-with-javascript), and [Go](/azure/developer/go/overview). Use the official Azure documentation to validate compatibility.

1. **Avoid unnecessary framework changes.** Only migrate to a new framework (such as .NET Framework to .NET Core) if there's a strong business justification. Framework changes require significant development effort and testing.

## Assess databases

Database dependencies often determine the success of application migration. Shared databases, cross-application dependencies, and integration patterns can complicate migration planning. You must assess the databases that support your applications and understand their dependencies. Follow this guidance:

1. **Identify all databases used by the application.** Create a complete inventory of all databases used by the application. Include database engine types (SQL Server, MySQL), versions, and hosting models (for example, on-premises, IaaS, PaaS). Use tools, such as Azure Migrate, to gather this information systematically. Specify whether the database is self-hosted, hosted on virtual machines, or delivered as a managed service. This information helps determine migration readiness and target platform compatibility.

1. **Map inbound and outbound dependencies.** A clear view of how data flows into and out of each database is critical for sequencing migrations and avoiding service disruptions. Dependencies often span multiple applications, services, and external systems. Include internal applications, APIs, batch jobs, reporting tools, and other integrations. Specify whether the dependency is read-only, write-only, or bidirectional. This detail helps prioritize workloads and identify potential migration blockers.

1. **Determine database migration strategy.** Decide whether to move the database as a shared instance or split it by workload. Shared databases simplify management but can delay migration if multiple applications depend on them. Splitting databases enables independent migration but requires careful coordination and testing. Ensure that the database migration plan supports the sequencing of application moves and minimizes downtime or service disruption.

### Create and maintain a risk register

A risk register identifies potential issues that could impact cloud adoption and defines mitigation strategies. Maintaining this register ensures proactive risk management.

1. **Establish a risk register for all workloads.** Record risks related to technical, operational, and organizational factors. This register provides visibility into potential blockers and their impact.

2. **Define mitigation strategies and track their status.** For each risk, document mitigation actions, responsible parties, and resolution timelines. This tracking ensures that risks are actively managed and resolved.

For more guidance, see [CAF Govern - Assess cloud risks](../govern/assess-cloud-risks.md)

## Azure resources and tools

| Category | Tool | Description |
|----------|------|-------------|
| Discovery and Assessment | [Azure Migrate](/azure/migrate/) | Comprehensive discovery and assessment for on-premises servers, databases, and applications |
| Arc-enabled servers | [Azure Arc](/azure/azure-arc/servers/) | Extends Azure management to on-premises and multicloud environments |
| Code Assessment | [AppCAT](/azure/migrate/appcat/overview) | Automated compatibility analysis for .NET and Java applications |
| Database Migration | [Data Migration Assistant](/sql/dma/dma-overview) | Assessment and migration tool for SQL Server databases |
| Multicloud mapping | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) | Service comparison guide for AWS to Azure migration |
| Multicloud mapping | [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) | Service comparison guide for GCP to Azure migration |
| Azure Development | [.NET on Azure](/azure/dotnet/azure/intro#access-azure-services-from-net-applications) | Guidance for accessing Azure services from .NET applications |
| Azure Development | [Java on Azure](/azure/developer/java/) | Resources for Java developers building on Azure |
| Azure Development | [Python on Azure](/azure/developer/python/get-started#write-your-python-app) | Resources for Python developers building on Azure |
| Azure Development | [JavaScript and Node.js on Azure](/azure/developer/javascript/core/what-is-azure-for-javascript-development#use-azure-client-libraries-with-javascript) | Guidance for JavaScript and Node.js development on Azure |
| Azure Development | [Go on Azure](/azure/developer/go/overview) | Resources for Go developers building on Azure |
| Cloud Adoption Framework | [Define reliability requirements](/azure/cloud-adoption-framework/manage/protect#define-reliability-requirements) | Guidance for defining reliability requirements for cloud workloads |

## Next steps

> [!div class="nextstepaction"]
> [Estimate total cost of ownership](./estimate-total-cost-of-ownership.md)
