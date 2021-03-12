---
title: Resource Consistency tools in Azure
description: See how Azure native tools can help mature policies and processes that support the Resource Consistency discipline.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Resource Consistency tools in Azure

[Resource consistency](./index.md) is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md). This discipline focuses on ways of establishing policies related to the operational management of an environment, application, or workload. Within the Five Disciplines of Cloud Governance, the Resource Consistency discipline involves monitoring of application, workload, and asset performance. It also involves the tasks required to meet scale demands, remediate performance SLA violations, and proactively avoid performance SLA violations through automated remediation.

<!-- docutune:casing "conditional access to resources" -->

The following is a list of Azure tools that can help mature the policies and processes that support this discipline.

| Tool | [Azure portal](https://azure.microsoft.com/features/azure-portal/) | [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | [Azure Blueprints](/azure/governance/blueprints/overview) | [Azure Automation](/azure/automation/automation-intro) | [Azure AD](/azure/active-directory/fundamentals/active-directory-whatis) | [Azure Backup](/azure/backup/backup-overview) | [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) |
|---------|---------|---------|---------|---------|---------|---------|---------|
| Deploy resources                             | Yes | Yes | Yes | Yes | No  | No | No |
| Manage resources                             | Yes | Yes | Yes | Yes | No  | No | No |
| Deploy resources using templates             | No  | Yes | No  | Yes | No  | No | No |
| Orchestrated environment deployment          | No  | No  | Yes | No  | No  | No | No |
| Define resource groups                       | Yes | Yes | Yes | No  | No  | No | No |
| Manage workload and account owners           | Yes | Yes | Yes | No  | No  | No | No |
| Manage conditional access to resources       | Yes | Yes | Yes | No  | No  | No | No |
| Configure Azure RBAC users                   | Yes | No  | No  | No  | Yes | No | No |
| Assign roles and permissions to resources | Yes | Yes | Yes | No  | Yes | No | No |
| Define dependencies between resources        | No  | Yes | Yes | No  | No  | No | No |
| Apply access control                         | Yes | Yes | Yes | No  | Yes | No | No |
| Assess availability and scalability          | No  | No  | No  | Yes | No  | No | No |
| Apply tags to resources                      | Yes | Yes | Yes | No  | No  | No | No |
| Assign Azure Policy rules                    | Yes | Yes | Yes | No  | No  | No | No |
| Apply automated remediation                  | No  | No  | No  | Yes | No  | No | No |
| Manage billing                               | Yes | No  | No  | No  | No  | No | No |
| Plan resources for disaster recovery         | Yes | Yes | Yes | No  | No  | Yes | Yes |
| Recover data during an outage or SLA violation     | No | No  | No  | No  | No  | Yes | Yes |
| Recover applications and data during an outage or SLA violation     | No | No  | No  | No  | No  | Yes | Yes |

Along with these Resource Consistency tools and features, you will need to monitor your deployed resources for performance and health issues. [Azure Monitor](/azure/azure-monitor/overview) is the default monitoring and reporting solution in Azure. Azure Monitor provides features for monitoring your cloud resources. This list shows which feature addresses common monitoring requirements.

| Tool | [Azure portal](https://azure.microsoft.com/features/azure-portal/) | [Application Insights](/azure/azure-monitor/app/app-insights-overview) | [Log Analytics](/azure/azure-monitor/logs/log-query-overview) | [Azure Monitor REST API](/rest/api/monitor/) |
|----------------------------------------------------|--------------|----------------------|---------------|------------------------|
| Log virtual machine telemetry data                 | No           | No                   | Yes           | No                     |
| Log virtual networking telemetry data              | No           | No                   | Yes           | No                     |
| Log PaaS services telemetry data                   | No           | No                   | Yes           | No                     |
| Log application telemetry data                     | No           | Yes                  | No            | No                     |
| Configure reports and alerts                       | Yes          | No                   | No            | Yes                    |
| Schedule regular reports or custom analysis        | No           | No                   | No            | No                     |
| Visualize and analyze log and performance data     | Yes          | No                   | No            | No                     |
| Integrate with on-premises or third-party monitoring solution     | No           | No                   | No            | Yes                    |

When planning your deployment, you will need to consider where logging data is stored and how you integrate cloud-based [reporting and monitoring services](../../decision-guides/logging-and-reporting/index.md) with your existing processes and tools.

> [!NOTE]
> Organizations also use third-party DevOps tools to monitor workloads and resources. For more information, see [DevOps tool integrations](https://azure.microsoft.com/products/devops-tool-integrations/).

## Next steps

Learn to create, assign, and manage [policy definitions](/azure/governance/policy/) in Azure.
