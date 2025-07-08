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

1. **Use assessment tools to collect architectural data.** Tools like Azure Migrate or third-party solutions automate discovery of workload components and configurations. These tools reduce manual effort and provide consistent data collection across your environment, though they might miss undocumented dependencies.

2. **Validate tool output with subject matter expertise.** Workload owners and architects can confirm tool findings and identify missing or outdated information. Conduct interviews or architecture review sessions to close gaps in the automated discovery data.

3. **Capture architecture in a central repository.** Store architecture diagrams, component lists, and configuration data in a format that supports planning and validation. Use tools like Microsoft Visio, spreadsheets, or Azure DevOps wikis to maintain this information.

### Assess architecture component requirements

Detailed component understanding ensures correct sizing and configuration in Azure. This knowledge prevents performance issues and compatibility problems after migration. You need to gather detailed specifications for each component to make informed migration decisions. Follow this guidance:

1. **Collect performance and configuration data.** Gather metrics such as CPU utilization, memory usage, IOPS, and throughput patterns. Record operating system type, version, VM size, storage type, and licensing details for accurate Azure sizing.

2. **Identify unsupported technologies.** Review Azure documentation to confirm compatibility for all components. Flag any technologies that require modernization or replacement before migration can proceed.

3. **Document security and identity configurations.** Capture authentication methods, access controls, and encryption settings to ensure compliance requirements are met in Azure. This information supports security planning and regulatory compliance.

### Map internal dependencies

Internal dependency mapping ensures that interconnected components migrate together without service disruptions. This step prevents broken integrations and supports accurate migration sequencing. You must identify and document all internal dependencies to maintain application functionality. Follow this guidance:

1. **Engage workload owners to identify dependencies.** Use structured interviews or workshops to capture application interconnections, shared databases, and network configurations. Workload owners possess critical knowledge about system interactions that automated tools might miss.

2. **Use discovery tools to validate and enrich data.** Tools like Azure Migrate or third-party solutions can uncover hidden dependencies through network traffic analysis. Use these tools to supplement manual discovery efforts and identify undocumented connections.

3. **Document dependencies in a central repository.** Store dependency data in spreadsheets, architecture diagrams, or dependency mapping tools. Ensure the format supports migration planning and sequencing decisions across multiple teams.

### Map external dependencies

External dependency mapping ensures that applications maintain connectivity and performance after migration. This step helps define move groups and migration order based on system interdependencies. You must identify and plan for all external dependencies to avoid service disruptions. Follow this guidance:

1. **Identify all external systems and services.** Interview application owners and review integration documentation to find dependencies on SaaS platforms, partner APIs, or on-premises systems. External dependencies often constrain migration timing and sequencing.

2. **Group interdependent applications into migration waves.** Use dependency data to define logical groupings of applications that must migrate together or in a coordinated sequence. This approach minimizes service disruptions and reduces migration complexity.

### Gather regulatory and operational requirements

Requirement gathering ensures that the target architecture meets compliance and service expectations. This step supports region selection, backup planning, and service level agreement alignment. You must document all regulatory and operational constraints to design appropriate Azure solutions. Follow this guidance:

1. **Identify regulatory constraints.** Note any data residency or compliance requirements that affect region selection or architecture design. These constraints often limit Azure service options and require specific configurations.

2. **Document SLAs, RPOs, and RTOs.** Capture service-level agreements, recovery point objectives, and recovery time objectives. Use this data to design backup, replication, and failover strategies. See [Define reliability requirements](/azure/cloud-adoption-framework/manage/protect#define-reliability-requirements).

3. **Align architecture with requirements.** Ensure that Azure services and configurations meet documented constraints and expectations. This alignment prevents compliance issues and performance problems after migration.

### Validate ISV integration with Azure

ISV integration validation ensures that third-party software continues to function after migration. This step helps avoid unexpected costs or modernization needs during the migration process. You must confirm compatibility and licensing for all ISV components before migration. Follow this guidance:

1. **Test ISV software in Azure.** Use test environments or vendor documentation to confirm compatibility. Identify any required updates or replacements before migration begins to avoid delays.

2. **Review licensing and cost impacts.** Determine whether Azure Hybrid Benefit or other licensing models apply. Include licensing costs in your migration plan to ensure budget accuracy.

3. **Update the migration plan based on ISV findings.** Adjust timelines, budgets, or architecture based on ISV compatibility and licensing requirements. This adjustment prevents surprises during migration execution.

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
