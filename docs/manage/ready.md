---
title: Ready Azure cloud estate management
description: Learn how to ready your Azure cloud operations and manage your cloud operations to ensure business alignment.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2025
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Ready Azure cloud estate management

This article outlines the process to prepare for managing your Azure cloud estate. Organizations achieve successful cloud operations by having the right people, well-defined team structures, and efficient processes. Clear roles and responsibilities create ownership for governance, security, and other critical areas.

:::image type="content" source="./media/caf-manage-ready.svg" alt-text="Diagram showing the CAF Manage process: ready, administer, monitor, and protect (RAMP)." lightbox="./media/caf-manage-ready.svg" border="false":::

## Identify your management responsibilities

Managing your Azure involves centralized tasks and workload tasks. Central (or *platform*) responsibilities support your entire cloud estate. Workload tasks address a single workload. Use *Table 1* to ensure your operations account for essential cloud operations tasks.

*Table 1. Primary cloud management responsibilities*

| Cloud management areas | Central responsibilities | Workload responsibilities |
|------|----|-----|
| Compliance                               | ▪ Define [operational procedures](#document-operational-procedures).<br>- Enforce [governance policies](/azure/cloud-adoption-framework/govern/).<br>-Monitor for noncompliance and remediate or escalate as required. | - Follow operational procedures.<br>- Align design with governance policies. |
| Security                                 | - Manage organization-wide [security operations](./protect.md#manage-security-operations)<br>- Manage identities in [Microsoft Entra ID](/entra/identity/)<br>- Grant [access](/azure/role-based-access-control/overview) to Azure subscriptions<br>- Define and maintain security baselines via Azure Policy and Microsoft Defender for Cloud<br>- Oversee threat protection and incident response integration with Microsoft Sentinel | - Implement [secure workload design](/azure/well-architected/security/checklist#checklist)<br>- Respond to workload-specific security alerts and incidents<br>- Continuously assess vulnerabilities within the workload. |
| Resource management                      | - Define and maintain [resource hierarchy](/azure/azure-resource-manager/management/overview#understand-scope).<br>- Create workload subscriptions as requested.<br>- Define [naming strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).<br>- Define [network topology](/azure/cloud-adoption-framework/ready/azure-best-practices/define-an-azure-network-topology).<br>- Configure shared networking (VNET peering, on-premises connectivity).<br>- Manage cross-workload or shared resources/services.<br>- Monitor subscription [limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) and handle requests for quota increases.| - Manage workload-specific subscriptions (if delegated).<br>- Manage resource groups and resources for each workload.<br>- Adhere to and apply naming and tagging standards.<br>- Manage application-level resource utilization, ensuring resources remain within subscription quotas. |
| Deployment                               | - Standardize and govern [CI/CD pipelines and tools](./administer.md#manage-code-deployments) (Azure DevOps, GitHub Actions).<br>- Define reference infrastructure-as-code templates ([Bicep, Terraform, ARM templates](/azure/templates/))<br>- Provide central best practices for pipeline security (code scanning, secrets management). | - central CI/CD framework and IaC templates for [workload deployments](/azure/well-architected/operational-excellence/workload-supply-chain).<br> - Implement workload-specific deployment tasks (configure app settings, database).<br>- Adapt reference templates to workload needs while respecting central guidelines. |
| Development                              | - Provide and enforce standardized development toolchains and frameworks to accelerate consistency (coding standards, DevOps best practices).<br>- Maintain internal repositories or package feeds for shared libraries or modules. | - Adopt and adapt standard toolchains for [workload development](/azure/well-architected/operational-excellence/formalize-development-practices).<br>- Own the application lifecycle and incorporate best practices (unit testing, integration testing).<br>- Manage continuous improvement for the workload’s code base. |
| Monitoring                               | - Plan [monitoring strategy](./monitor.md#plan-your-monitoring-strategy).<br>- [Alert](./monitor.md#configure-alerting) on centralized responsibilities<br>- Define baseline monitoring data for workloads. | - Monitor [workload](/azure/well-architected/operational-excellence/observability)<br>- Extend or fine-tune central alerts to capture workload-specific conditions.<br>- Investigate and remediate workload-level incidents based on alerts and logs. |
| Cost                                     | - Allocate global or subscription-level cloud budgets<br>- Monitor organization-wide [cloud spend](/azure/cloud-adoption-framework/manage/monitor#monitor-costs) and create cost reports<br>- Allocate costs to business units or products, typically using tags or custom cost allocation models. | - [Cost optimize](/azure/well-architected/cost-optimization/) workload design<br>-Respect budget constraints. |
| Reliability                              | - Define reliability requirements (SLO, RPO, RTO) per workload priority.<br>- Provide guidance on business continuity and disaster recovery (BCDR).<br>- Manage centralized disaster recovery solutions.<br>- Support major incident management across all workloads. | - Design workload to meet [reliability requirements](/azure/well-architected/reliability/checklist#checklist) |
| Performance                              | - Monitor and maintain performance at centralized components (hub network, shared services).<br>- Provide guidelines for performance optimization and capacity planning. | - Design workload for [performance efficiency](/azure/well-architected/performance-efficiency/checklist#checklist) |

## Establish your cloud operations

With an understanding of essential tasks required in cloud operation. You now need to establish a foundation to fill those functions. Formalize an operational model with defined teams and shared standards. Follow these steps:

1. ***Define your cloud operations model.*** Choose a centralized or shared management model based on your organization's size and maturity. See the following table:

| Operations approach | Responsibilities and scope | Best for | Pros | Cons |
|---------------------|----------------------------|----------|------|------|
| Centralized         | A single team manages all tasks. | Startups or small cloud footprint. | The approach simplifies cloud management. | The approach can create operational bottlenecks. |
| Shared management   | A team handles central tasks. Workload teams manage workload tasks. | Clouds with diverse workloads. | The approach balances governance with workload agility. | The approach requires clear role definitions and ongoing coordination. |

1. ***Establish cloud estate operations.*** You need a cloud operations team that can cover all the essential cloud estate tasks. Use *Table 1* to define those operations within the context of your organization. Use *Table 1* to develop a skills matrix to acquire the right personnel.

1. ***Establish workload operations.*** You need a cloud operations team that can cover all the essential workload tasks. Use *Table 1* to get a high-level view of those tasks and develop a skills matrix to acquire the right personnel.

    - ***Conduct an Azure Well-Architected Review.*** Use the [Well-Architected Assessment tool](/azure/well-architected/what-is-well-architected-framework#assessment) to regularly reassess each workload. Focus on the Operational Excellence pillar.
    
    - ***Use the Azure Well-Architected Framework.*** Use the [Operational excellence](/azure/well-architected/operational-excellence/) pillar to guide your workload management responsibilities.

1. ***Assign responsibility.*** Assign named owners for every cloud operational responsibility. In a shared management model, each workload team is responsible for all workload tasks.

## Document your cloud operations

Document your cloud operations. This documentation helps everyone respond in crises and execute changes without causing issues. Define overarching procedures. Build guides for common, specific tasks. Follow these steps:

### Document operational procedures

You need to define operational procedures for change, disaster recovery, and daily maintenance tasks that you can’t automate. Follow these steps:

1. ***Define change management procedures.*** Change is the major cause of failure in the cloud. Develop a change management process. See [Manage change](./administer.md#manage-change).

1. ***Define deployment procedures (release management).*** Standardize deployments, releases, and promotion between environments to maintain configurations. See [Manage deployments](./administer.md#manage-cloud-resources).

1. ***Define disaster recovery and business continuity procedures.*** Develop a standardized plan to manage failure. See [Manage disaster recovery and business continuity](./protect.md#manage-business-continuity).

1. ***Define additional procedures.*** As needed, define processes for service requests, patches, and configuration management. Maintain these processes in documentation so that every stakeholder understands how to initiate or execute each activity.

### Document operational guides

Prepare step-by-step guides (runbooks or playbooks) for all key operational activities. This preparation ensures consistent execution, even when different people perform the work. It also reduces resolution time under pressure by providing pre-approved steps.

1. ***Define daily tasks.*** Create a manual that explains daily tasks, such as requesting elevated privileges, and reviewing logs. Define standard operating procedures for monitoring, which metrics to watch, alert thresholds, dashboard layouts for each system.

1. ***Create a library of Azure-centric runbooks.*** Include runbooks that address scenarios such as high CPU usage web app, failover and failback using your global load balancer, backup restore, and isolating resources and collecting Azure Activity Logs.

1. ***Store these runbooks in a central repository.*** Use means on-call engineers can quickly access or trigger them when an incident arises.

1. ***Implement operations programmatically.*** Use infrastructure as code as part of a runbook for provisioning common resources. This approach ensures they are built to spec every time.

### Document tools and solutions

Adopt a unified set of tools and processes for cloud operations across the organization. Each team uses a shared monitoring platform, ticketing system, infrastructure-as-code templates, and deployment pipeline. This practice creates consistency and simplifies collaboration. Teams gain clear system visibility and can support each other or assume responsibilities as necessary.

| Area              | Example benefits                                                                                   |
|-------------------|----------------------------------------------------------------------------------------------------|
| Integration       | Standardization simplifies integrations by consolidating logs and code repositories.               |
| Automation        | Teams reuse automation scripts and best practices across projects.                                 |
| Incident management | Incident records capture issues and generate remediation actions that integrate into release cycles. |

## Manage your cloud operations

Standardize tools, support coverage, and automation to streamline daily operations. Standardized processes reduce confusion and speed up issue resolution. Align teams with common monitoring, ticketing, and Infrastructure-as-Code practices. Consider these guidelines:

### Manage cloud support

Plan support coverage that addresses critical incidents around the clock. Provide round-the-clock coverage for high-priority cloud workloads. Satisfy service level agreements by ensuring a team member always remains available. Use a follow-the-sun model to shift responsibilities among global teams or establish a defined on-call rotation. Configure [alerts](/azure/cloud-adoption-framework/manage/monitor#configure-alerting) to notify the on-call engineer or team whenever an alert triggers.

### Manage repetitive work

Automate every routine operational task to reduce human error and operational toil. Let Azure handle routine tasks so your team can focus on higher-value work. Use Infrastructure as Code (ARM/Bicep or Terraform templates) for provisioning, Azure Automation runbooks or Functions for maintenance tasks, and CI/CD pipelines for deployments. Where it’s possible, use Azure policy to enforce operational processes.

| Use Case            | Examples                                                                                       |
|---------------------|------------------------------------------------------------------------------------------------|
| Automation          | Automate workflows in Azure DevOps Boards or ITSM system. Templates for “Change Request” and “Incident” work items. |
| Incident response   | Integrate Azure Monitor and Azure Service Health with ticketing system to auto-generate incident tickets with standard fields populated. |
| Change management   | Use Azure Automation and Logic Apps to auto-approve low-risk changes or auto-remediate certain incidents. |
| Compliance          | Use Azure Policy to enforce and monitor cloud compliance.                                       |
| Security            | Use Microsoft Defender for Cloud and Microsoft Sentinel to automate security threat detection and response. Use Microsoft Entra ID Governance to review permissions and automate permissions management. |

## Improve operations

Improving operations is about finding ways to optimize your Azure cloud estate. You need to invest in continuous learning and gather feedback. Follow these steps:

1. ***Train for operations.*** Bookmark key operational resources. Encourage continuous learning to keep your cloud operations dynamic and up to date. Provide sandbox environments for hands-on learning.

    | Action   | Description  |
    |---|---|
    | Get credentials | Set goals for [Microsoft credentials](/credentials/), like applied skills and Microsoft Certifications to build expertise. |
    | Use operational resources | See [Azure operational resources](#azure-operational-resources). |
    | Use product documentation | Use [Microsoft Learn](/azure/) to find guidance on [Azure services](/azure/?product=popular). |
    | Get hands-on practice | Encourage hands-on practice in non-production sandbox environments. |

1. ***Review operations to improve.*** Conduct regular reviews of operational health, governance, security, cost, compliance, data. For example, hold weekly ops review meetings to go over key metrics, recent incidents, changes deployed, and upcoming risks. This discipline of reviewing processes on a set cadence allows teams to continuously improve and ensure procedures remain effective​.

## Azure operational resources

| Category               | Operational resource                                                                 | Description                                              |
|------------------------|---------------------------------------------------------------------------------------|----------------------------------------------------------|
| Monitor                    | [Azure Advisor](/azure/advisor/advisor-overview)                                      | A digital assistant that helps you follow best practices in Azure. |
|  | [Azure Architecture Center](/azure/architecture/)                                  | Solutions for different use cases                        |
| Workload design        | [Well-Architected Framework](/azure/well-architected/)                                | Foundational guidance for workload tasks                 |
| Deployment             | [Bicep, ARM & Terraform templates](/azure/templates/)                                 | IaC templates for every Azure resource                   |
| Security               | [Microsoft Entra RBAC](/entra/identity/role-based-access-control/custom-overview)| Best practices to control access to identity resources   |
| Security               | [Azure RBAC](/azure/role-based-access-control/overview)                               | Role based access control for Azure resources            |
| Resource management    | [Abbreviations for Azure resources](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) | Azure resource abbreviations for many Azure resources    |
| Resource management    | [Azure naming rules](/azure/azure-resource-manager/management/resource-name-rules#microsoftnetwork) | Naming rules for all Azure resources                     |
| Deployment             | [Azure region pairs](/azure/reliability/regions-paired#list-of-region-pairs)          | List of Azure paired regions                             |
| Deployment             | [Directory of Azure Cloud Services](https://azure.microsoft.com//products/)           | Directory of all Azure services                          |
| Cost                   | [Azure Pricing](https://azure.microsoft.com//pricing/)                                | Pricing information for Azure services                   |
