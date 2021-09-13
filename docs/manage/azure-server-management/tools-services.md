---
title: Azure server management services
description: Use the Cloud Adoption Framework for Azure to learn about areas within the suite of Azure server management services.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Azure server management tools and services

As is discussed in the [overview](./index.md) of this guidance, the suite of Azure server management services covers these areas:

- Migrate
- Secure
- Protect
- Monitor
- Configure
- Govern

The following sections briefly describe these management areas and provide links to detailed content about the main Azure services that support them.

## Migrate

Migration services can help you migrate your workloads into Azure. To provide the best guidance, the Azure Migrate service starts by measuring on-premises server performance and assessing suitability for migration. After Azure Migrate completes the assessment, you can use [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) and [Azure Database Migration Service](/azure/dms/dms-overview) to migrate your on-premises machines to Azure.

## Secure

[Azure Security Center](/azure/security-center/security-center-introduction) is a comprehensive security management application. By onboarding to Security Center, you can quickly get an assessment of the security and regulatory compliance status of your environment. For instructions on onboarding your servers to Azure Security Center, see [Configure Azure management services for a subscription](./onboard-at-scale.md#azure-security-center).

## Protect

To protect your data, you need to plan for backup, high availability, encryption, authorization, and related operational issues. These topics are covered extensively online, so here we'll focus on building a business continuity and disaster recovery (BCDR) plan. We'll include references to documentation that describes in detail how to implement and deploy this type of plan.

When you build data-protection strategies, first consider breaking down your workload applications into their different tiers. This approach helps because each tier typically requires its own unique protection plan. To learn more about designing applications to be resilient, see [Designing resilient applications for Azure](/azure/architecture/framework/resiliency/design-resiliency).

The most basic data protection is backup. To speed up the recovery process if servers are lost, back up not just data but also server configurations. Backup is an effective mechanism to handle accidental data deletion and ransomware attacks. [Azure Backup](/azure/backup/) can help you protect your data on Azure and on-premises servers running Windows or Linux. For details about what Azure Backup can do and for how-to guides, see the [Azure Backup service overview](/azure/backup/backup-overview).

If a workload requires real-time business continuity for hardware failures or datacenter outage, consider using data replication. [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) provides continuous replication of your VMs, a solution that provides bare-minimum data loss. Site Recovery also supports several replication scenarios, such as replication:

- Of Azure VMs between two Azure regions.
- Between servers on-premises.
- Between on-premises servers and Azure.

For more information, see the [complete Azure Site Recovery replication matrix](/azure/site-recovery/site-recovery-overview#what-can-i-replicate).

For your file-server data, another service to consider is [Azure File Sync](/azure/storage/files/storage-sync-files-planning). This service helps you centralize your organization's file shares in Azure Files, while preserving the flexibility, performance, and compatibility of an on-premises file server. To use this service, follow the instructions for deploying Azure File Sync.

## Monitor

[Azure Monitor](/azure/azure-monitor/overview) provides a view into various resources, like applications, containers, and virtual machines. It also collects data from several sources:

- [Azure Monitor for VMs](/azure/azure-monitor/vm/vminsights-overview) provides an in-depth view of VM health, performance trends, and dependencies. The service monitors the health of the operating systems of your Azure Virtual Machines, virtual-machine scale sets, and machines in your on-premises environment.
- [Log Analytics](/azure/azure-monitor/logs/log-query-overview) is a feature of Azure Monitor. Its role is central to the overall Azure management story. It serves as the data store for log analysis and for many other Azure services. It offers a rich query language and an analytics engine that provides insights into the operation of your applications and resources.
- [Azure activity log](/azure/azure-monitor/essentials/platform-logs-overview) is also a feature of Azure Monitor. It provides insight into subscription-level events that occur in Azure.

## Configure

Several services fit into this category. They can help you to:

- Automate operational tasks.
- Manage server configurations.
- Measure update compliance.
- Schedule updates.
- Detect changes to your servers.

These services are essential to supporting ongoing operations:

- [Update Management](/azure/automation/update-management/overview) automates the deployment of patches across your environment, including deployment to operating-system instances running outside of Azure. It supports both Windows and Linux operating systems, and tracks key OS vulnerabilities and nonconformance caused by missing patches.
- [Change Tracking and Inventory](/azure/automation/change-tracking/overview) provides insight into the software that's running in your environment, and highlights any changes that have occurred.
- [Azure Automation](/azure/automation/automation-intro) lets you run Python and PowerShell scripts or runbooks to automate tasks across your environment. When you use Azure Automation with the [Hybrid Runbook Worker](/azure/automation/automation-hybrid-runbook-worker), you can extend your runbooks to your on-premises resources as well.
- [Azure Automation State Configuration](/azure/automation/automation-dsc-overview) enables you to push PowerShell Desired State Configuration (DSC) configurations directly from Azure. DSC also lets you monitor and preserve configurations for guest operating systems and workloads.

## Govern

Adopting and moving to the cloud creates new management challenges. It requires a different mindset as you shift from an operational management burden to monitoring and governance. The Cloud Adoption Framework starts with [governance](../../govern/index.md). The framework explains how to migrate to the cloud, what the journey will look like, and who should be involved.

The governance design for standard organizations often differs from governance design for complex enterprises. To learn more about governance best practices for a standard organization, see the [standard enterprise governance guide](../../govern/guides/standard/index.md). To learn more about governance best practices for a complex enterprise, see the [governance guide for complex enterprises](../../govern/guides/complex/index.md).

## Billing information

To learn about pricing for Azure management services, go to these pages:

- [Azure Site Recovery](https://azure.microsoft.com/pricing/details/site-recovery/)

- [Azure Backup](https://azure.microsoft.com/pricing/details/backup/)

- [Azure Monitor](https://azure.microsoft.com/pricing/details/monitor/)

- [Azure Security Center](https://azure.microsoft.com/pricing/details/security-center/)

- [Azure Automation](https://azure.microsoft.com/pricing/details/automation/), including:
  - Desired State Configuration
  - Update Management solution
  - Change Tracking and Inventory solution

- [Azure Policy](https://azure.microsoft.com/pricing/details/azure-policy/)

- [Azure File Sync service](https://azure.microsoft.com/pricing/details/storage/blobs/)

> [!NOTE]
> The Azure Update Management solution is free, but there's a small cost related to data ingestion. As a rule of thumb, the first 5 gigabytes (GB) per month of data ingestion are free. We generally observe that each machine uses about 25 MB per month. So, about 200 machines per month are covered for free. For more servers, multiply the number of additional servers by 25 MB per month. Then, multiply the result by the storage price for the additional storage that you need. For information about costs, see [Azure Storage pricing](https://azure.microsoft.com/pricing/details/storage/). Each additional server typically has a nominal impact on cost.
