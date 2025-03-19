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

Effectively managing your Azure environment involves central (platform-wide) responsibilities and workload responsibilities. Central responsibilities support your entire Azure cloud estate. Workload responsibilities focus on individual applications or services. Use *Table 1* to ensure your operations account for essential cloud operations responsibilities.

*Table 1. Primary cloud management responsibilities*

| Cloud management areas | Central responsibilities | Workload responsibilities |
|------|----|-----|
| Compliance                               | ▪ Define [operational procedures](#document-operational-procedures).<br>- Enforce [governance policies](/azure/cloud-adoption-framework/govern/).<br>-[Monitor compliance](./monitor.md#monitor-compliance) and remediate or escalate as required. | - Follow operational procedures.<br>- Align design with governance policies. |
| Security                                 | - Manage organization-wide [security operations](./protect.md#manage-security-operations)<br>- Manage identities in [Microsoft Entra ID](/entra/identity/)<br>- Grant [access](/azure/role-based-access-control/overview) to Azure subscriptions<br>- Define and maintain security baselines via Azure Policy and Microsoft Defender for Cloud<br>- Oversee threat protection and incident response integration with Microsoft Sentinel | - Implement [secure workload design](/azure/well-architected/security/checklist#checklist)<br>- Respond to workload-specific security alerts and incidents<br>- Continuously assess vulnerabilities within the workload. |
| Resource management                      | - Define and maintain [resource hierarchy](/azure/azure-resource-manager/management/overview#understand-scope).<br>- Create workload subscriptions as requested.<br>- Define [naming and tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).<br>- Define [network topology](/azure/cloud-adoption-framework/ready/azure-best-practices/define-an-azure-network-topology).<br>- Configure shared networking (virtual network peering, on-premises connectivity).<br>- Manage cross-workload or shared resources/services.<br>- Monitor subscription [limits](/azure/azure-resource-manager/management/azure-subscription-service-limits) and handle requests for quota increases.| - Manage workload-specific subscriptions (if delegated).<br>- Manage resource groups and resources for each workload.<br>- Adhere to and apply naming and tagging standards.<br>- Manage application-level resource utilization, ensuring resources remain within subscription quotas. |
| Deployment                               | - Standardize and govern [CI/CD pipelines and tools](./administer.md#manage-code-deployments) (Azure DevOps, GitHub Actions).<br>- Define reference infrastructure-as-code templates ([Bicep, Terraform, ARM templates](/azure/templates/))<br>- Provide central best practices for pipeline security (code scanning, secrets management). | - central CI/CD framework and IaC templates for [workload deployments](/azure/well-architected/operational-excellence/workload-supply-chain).<br> - Implement workload-specific deployment tasks (configure app settings, database).<br>- Adapt reference templates to workload needs while respecting central guidelines. |
| Development                              | - Provide and enforce standardized development toolchains and frameworks to accelerate consistency (coding standards, DevOps best practices).<br>- Maintain internal repositories or package feeds for shared libraries or modules. | - Adopt and adapt standard toolchains for [workload development](/azure/well-architected/operational-excellence/formalize-development-practices).<br>- Own the application lifecycle and incorporate best practices (unit testing, integration testing).<br>- Manage continuous improvement for the workload’s code base. |
| Monitoring                               | - Plan [monitoring strategy](./monitor.md#plan-your-monitoring-strategy).<br>- [Alert](./monitor.md#configure-alerting) on centralized responsibilities<br>- Provide dashboards for common operational metrics across the environment.| - Monitor [workload](/azure/well-architected/operational-excellence/observability)<br>- Extend or fine-tune central alerts to capture workload-specific conditions.<br>- Investigate and remediate workload-level incidents based on alerts and logs. |
| Cost                                     | - Allocate global or subscription-level cloud budgets<br>- Monitor organization-wide [cloud spend](/azure/cloud-adoption-framework/manage/monitor#monitor-costs) and create cost reports<br>- Allocate costs to business units or products, typically using tags or custom cost allocation models.<br>- Apply tagging strategy for cost allocation. | - [Cost optimize](/azure/well-architected/cost-optimization/) workload design<br>-Respect budget constraints. |
| Reliability                              | - Define [reliability requirements](./protect.md#define-reliability-requirements) (SLO, RPO, RTO) per workload priority.<br>- Provide guidance on business continuity and disaster recovery (BCDR).<br>- Manage centralized [disaster recovery](./protect.md#manage-business-continuity) solutions.<br>- Support major incident management across all workloads. | - Design workload to meet [reliability requirements](/azure/well-architected/reliability/checklist#checklist) |
| Performance                              | - Monitor and maintain performance at centralized components (hub network, shared services).<br>- Provide guidelines for performance optimization and capacity planning.<br>- Monitor quota | - Design workload for [performance efficiency](/azure/well-architected/performance-efficiency/checklist#checklist) |

## Establish your cloud operations

Use the responsibilities outlined in *Table 1* to build an effective operational foundation. Clearly define teams, standards, and processes by following these steps:

1. ***Define your cloud operations model.*** Choose a centralized or shared management model based on your organization's size and maturity, outlined in the following table:

| Operations approach | Responsibilities and scope | Best for | Pros | Cons |
|---------------------|----------------------------|----------|------|------|
| Centralized         | A single team manages all tasks. | Startups or small cloud footprint. | Simplifies cloud management. | Risks creating bottlenecks. |
| Shared management   | Separate central (platform) and workload teams | Organizations with diverse workloads. | Balances governance and agility. | Requires clear assignment of responsibility |

1. ***Establish central responsibilities.*** Form a dedicated team to handle central management tasks. Develop a skills matrix from Table 1 to identify required expertise.

1. ***Establish workload responsibilities.*** Set up specialized teams for workload-specific tasks. Identify responsibilities using *Table 1* then recruit accordingly.

    - ***Conduct an Azure Well-Architected Review.*** Use the [Well-Architected Assessment tool](/azure/well-architected/what-is-well-architected-framework#assessment) to reassess each workload while developing and testing design changes.

    - ***Use the Azure Well-Architected Framework.*** Use the [Operational excellence](/azure/well-architected/operational-excellence/) pillar to guide your workload management responsibilities.

1. ***Assign responsibility.*** Name specific owners for all cloud management responsibilities. In a shared management model, workload teams should have autonomy to manage their subscriptions.

## Document your cloud operations

Clearly document your cloud operations to enable efficient crisis response and smooth implementation of changes. Establish overarching procedures and create detailed guides for frequent and specific tasks.

### Document operational procedures

Define operational procedures for managing change, disaster recovery, and routine maintenance tasks that automation can't handle. Follow these steps:

1. ***Define change management procedures.*** Change is the major cause of failure in the cloud. Develop a standardized process for managing changes to avoid failures in your cloud environment. See [Manage change](./administer.md#manage-change).

1. ***Define deployment procedures (release management).*** To maintain consistent configuration, standardize your deployments, releases, and environment promotions. See [Manage deployments](./administer.md#manage-cloud-resources).

1. ***Define disaster recovery and business continuity procedures.*** To handle potential failures, prepare a standardized response plan. See [Manage disaster recovery and business continuity](./protect.md#manage-business-continuity).

1. ***Define additional procedures.*** Document processes for managing service requests, patching, and configuration management. Clearly document these processes to ensure stakeholders know how to initiate or complete each task.

### Document operational guides

Create detailed step-by-step guides (runbooks or playbooks) for key operational tasks. This preparation ensures consistent execution, improves efficiency, and shortens resolution times during critical events

1. ***Define daily tasks.*** Prepare manuals covering daily responsibilities, such as privilege escalation requests and log reviews. Establish standard operating procedures (SOPs) for monitoring metrics, alert thresholds, and dashboards for each system.

1. ***Create a library of Azure-centric runbooks.*** Create Azure-specific runbooks addressing scenarios such as:

    | Scenario | Example |
    |----------|-------------|
    | High CPU usage | [Azure App Service](/azure/app-service/manage-scale-up) |
    | Failover and failback | [Azure Site Recovery](/azure/site-recovery/failover-failback-overview-modernized) |
    | Blue/green deployments | [Azure Front Door](/azure/frontdoor/blue-green-deployment) |
    | Backup restoration | [Azure Blob Storage](/azure/storage/common/storage-disaster-recovery-guidance) and [Azure Cosmos DB](/azure/cosmos-db/restore-account-continuous-backup) |

1. ***Store these runbooks in a central repository.*** Maintain runbooks in a central repository accessible by on-call engineers for immediate use during incidents.

1. ***Implement operations programmatically.*** Integrate infrastructure-as-code into your runbooks to deploy common resources consistently and accurately each time.

1. ***Review and update.*** Periodically review and revise documentation to reflect operational adjustments and cloud service updates.

### Document tools and solutions

Adopt standardized tools and processes for cloud operations throughout your organization. Ensure teams use Azure Monitor, ticketing system, infrastructure-as-code (IaC) [templates]((/azure/templates/) ), and deployment pipelines (GitHub Actions or Azure Pipelines). This approach promotes consistency, reduces redundancy, and enhances cross-team support capabilities.

| Area | Example benefits |
|-----|----|
| Integration       | Standardization simplifies integrations by consolidating logs and code repositories.               |
| Automation        | Reuse IaC templates across teams, automation scripts, and best practices across projects.                                 |
| Incident management | Capture issues and generate remediation actions that integrate into release cycles. |

## Manage your cloud operations

Standardize tools, automate routine tasks, and align support coverage to simplify daily cloud operations. Clear processes minimize confusion and accelerate incident resolution. Ensure teams adopt unified monitoring, ticketing, and Infrastructure-as-Code practices. Follow these operational guidelines:

### Manage cloud support

Provide continuous support for critical incidents by establishing 24/7 coverage. Meet service level agreements with clearly assigned responsibilities. Implement either a follow-the-sun model across global teams or maintain a structured on-call schedule. Configure [alerts](/azure/cloud-adoption-framework/manage/monitor#configure-alerting) to notify the on-call engineer or team whenever an alert triggers.

### Manage repetitive work

Automate repetitive operational tasks to eliminate manual errors and reduce operational burden. Use Azure services for handling routine work, allowing your team to focus on strategic tasks.

| Use Case            | Examples                                                                                       |
|---------------------|------------------------------------------------------------------------------------------------|
| Automation          | Automate workflows in Azure Boards or ITSM system. Templates for "Change Request" and "Incident" work items. |
| Incident response   | To autogenerate incident tickets with standard fields populated, integrate Azure Monitor and Azure Service Health with ticketing system. |
| Change management   | Use [Azure Logic Apps](/azure/logic-apps/logic-apps-overview) to autoapprove low-risk changes or autoremediate certain incidents. |
| Compliance          | Use Azure Policy to enforce and monitor cloud compliance.                                       |
| Security            | Use Microsoft Defender for Cloud and Microsoft Sentinel to automate security threat detection and response. Use Microsoft Entra ID Governance to review permissions and automate permissions management. |

## Improve operations

Optimize your Azure cloud environment by promoting continuous improvement. Regularly evaluate operations and prioritize ongoing learning and feedback. Follow these steps:

1. ***Review operations to improve.*** Follow best practices to [monitor](./monitor.md#configure-monitoring) the health, compliance, security, costs, data, and cloud resources. Conduct weekly operational reviews to discuss key metrics, recent incidents, deployed changes, and anticipated risks. Actively address [resource sprawl](./administer.md#manage-resource-sprawl) and [technical debt](/azure/well-architected/performance-efficiency/continuous-performance-optimize#address-technical-debt).

1. ***Train for operations.*** Foster ongoing skill development by prioritizing essential learning resources. Maintain dynamic cloud operations through practical training environments.

    | Operations training   | Description  |
    |---|---|
    | Get credentials | Set goals for [Microsoft credentials](/credentials/), like applied skills and Microsoft Certifications to build expertise. |
    | Use operational resources | See [Azure operational resources](#azure-operational-resources). |
    | Use product documentation | Use [Microsoft Learn](/azure/) to find guidance on [Azure services](/azure/?product=popular). |
    | Get hands-on practice | Encourage hands-on practice in nonproduction sandbox environments. |

## Azure management resources

| Category  | Management resource  | Description   |
|---|---|---|
| Compliance | [CAF Govern](../govern/index.md) | Microsoft's cloud governance framework |
| Security| [Manage security operations](./protect.md#manage-security-operations)| Guidance to manage security operations  |
| Security| [Microsoft security tool](./protect.md#azure-security-tools) | A list of Microsoft and Azure security tools |
| Security | [Workload security](/azure/well-architected/security/checklist) | Workload guidance for security |
| Resource management    | [Naming and tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) | Naming and tagging recommendations to manage resources     |
| Resource management | [Azure abbreviation](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) | List of abbreviations for Azure resources |
| Resource management | [Azure Advisor](/azure/advisor/advisor-overview) | A digital assistant to align with Azure best practices. |
| Resource management    | [Azure naming rules](/azure/azure-resource-manager/management/resource-name-rules#microsoftnetwork) | Naming rules for all Azure resources |
| Resource management | [Azure service guides](/azure/well-architected/service-guides/?product=popular) | Guidance for service configuration decisions |
| Development | [Workload software development](/azure/well-architected/operational-excellence/formalize-development-practices) | Workload guidance for software development |
| Development  | [Azure Architecture Center](/azure/architecture/) | Architectures and guides for different use cases    |
| Development | [Developer resource hub](https://developer.microsoft.com/) | A hub for developer tools and resources |
| Deployment   | [Bicep, Terraform, and ARM templates](/azure/templates/)   | IaC templates for every Azure resource    |
| Deployment   | [Azure region pairs](/azure/reliability/regions-paired#list-of-region-pairs)| List of Azure paired regions    |
| Deployment   | [Directory of Azure Cloud Services](https://azure.microsoft.com//products/) | Directory of all Azure services |
| Deployment | [Workload deployment](/azure/well-architected/operational-excellence/release-engineering-continuous-integration) | Workload guidance for continuous integration |
| Monitoring | [Monitor your Azure cloud estate](./monitor.md) | Comprehensive Azure monitoring guidance |
| Monitoring | [Workload monitoring](/azure/well-architected/operational-excellence/observability) | Workload guidance for monitoring |
| Cost | [Manage costs](./administer.md#manage-costs) | Cost management guidance |
| Cost | [Workload cost optimization](/azure/well-architected/cost-optimization/checklist) | Workload guidance for cost optimization |
| Reliability | [Manage data reliability](./protect.md#manage-data-reliability) | Guidance to maintain data reliability |
| Reliability | [Manage cloud resource reliability](./protect.md#manage-cloud-resources-reliability) | Guidance to maintain resource reliability |
| Reliability | [Manage security incidents](./protect.md#manage-security-incidents) | Recommendations to respond to security incidents |
| Performance | [Workload performance efficiency](/azure/well-architected/performance-efficiency/checklist) | Workload guidance for performance efficiency |
