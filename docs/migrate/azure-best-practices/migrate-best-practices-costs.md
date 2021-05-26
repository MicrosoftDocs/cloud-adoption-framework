---
title: Best practices to cost and size workloads migrated to Azure
description: Use the Cloud Adoption Framework for Azure to learn best practices for costing and sizing workloads migrated to Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

<!-- docutune:casing ARO -->

# Best practices to cost and size workloads migrated to Azure

As you plan and design for an Azure migration, focusing on costs can help to ensure its long-term success. During a migration project, it's critical that all teams (such as finance, management, and application development teams) understand the costs associated with this process.

- Before migration, it's important to have a baseline for monthly, quarterly, and yearly budget targets in order to estimate the amount you'd spend on your migration and ensure its success.
- After migration, you should optimize costs, continually monitor workloads, and plan for future usage patterns. Migrated resources might start out as one type of workload but because of usage, costs, and shifting business requirements, shift to another type over time.

This article describes best practices for preparing for and managing cost and size, both before and after migration.

> [!IMPORTANT]
> The best practices and opinions described in this article are based on Azure platform and service features available at the time of writing. Features and capabilities change over time. Not all recommendations might be applicable for your deployment, so select what works for you.

## Before migration

Before you move your workloads to the cloud, estimate the monthly cost of running them in Azure. Proactively managing cloud costs helps you adhere to your operating expense budget. If budget is limited, take this into account before migration. Consider converting workloads to Azure serverless technologies, where appropriate, to reduce costs.

The best practices in this section help you to:

- Estimate costs.
- Perform right-sizing for virtual machines (VMs) and storage.
- Use Azure Hybrid Benefit.
- Use Azure Reserved VM Instances.
- Estimate cloud spending across subscriptions.

## Best practice: Estimate monthly workload costs

You can use several tools to forecast your monthly bill for migrated workloads.

<!-- TODO: Change "input costs" -->

- **Azure pricing calculator:** Select the products you want to estimate, such as VMs and storage. Then, input costs into the calculator to build an estimate.

  ![Screenshot of the Azure pricing calculator.](./media/migrate-best-practices-costs/pricing.png)
    *Figure 1: Azure pricing calculator.*

- **Azure Migrate:** To estimate costs, you need to review and account for all the resources required to run your workloads in Azure. To acquire this data, you create inventory of your assets, including servers, VMs, databases, and storage. You can use Azure Migrate to collect this information.

  - Azure Migrate discovers and assesses your on-premises environment to provide an inventory.
  - Azure Migrate can map and show you dependencies between VMs, so that you have a complete picture.
  - An Azure Migrate assessment contains estimated cost.
    - **Compute costs:** Using the Azure VM size recommended when you create an assessment, Azure Migrate uses the Azure Billing APIs to calculate estimated monthly VM costs. The estimation considers the operating system, Software Assurance, Azure Reserved VM Instances, VM uptime, location, and currency settings. It aggregates the cost across all VMs in the assessment, and calculates a total monthly compute cost.
    - **Storage cost:** Azure Migrate calculates total monthly storage costs by aggregating the storage costs of all VMs in an assessment. You can calculate the monthly storage cost for a specific machine by aggregating the monthly cost of all disks attached to it.

    ![Screenshot of Azure Migrate](./media/migrate-best-practices-costs/assess.png)
    *Figure 2: Azure Migrate assessment.*

**Learn more:**

- Use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/).
- Read the [Azure Migrate overview](/azure/migrate/migrate-services-overview).
- Read about [Azure Migrate assessments](/azure/migrate/concepts-assessment-calculation).
- Learn more about [Azure Database Migration Service](/azure/dms/dms-overview).

## Best practice: Right-size VMs

You can choose various options when you deploy Azure VMs to support workloads. Each VM type has specific features and different combinations of CPU, memory, and disks. VMs are grouped as shown in the following table:

| Type | Details | Usage |
| --- | --- | --- |
| **General-purpose** | Balanced CPU-to-memory. | Good for testing and development, small- to medium-sized databases, and low- to medium-volume traffic web servers. |
| **Compute-optimized** | High CPU-to-memory. | Good for medium-volume traffic web server, network appliances, batch processes, and application servers. |
| **Memory-optimized** | High memory-to-CPU. | Good for relational databases, medium- to large-size cache, and in-memory analytics. |
| **Storage optimized** | High disk throughput and I/O. | Good for big data, and SQL and NoSQL databases. |
| **GPU optimized** | Specialized VMs. Single or multiple GPUs. | Heavy graphics and video editing. |
| **High performance** | Fastest and most powerful CPU. VMs with optional high-throughput network interfaces (RDMA). | Critical high-performance applications. |

- It's important to understand the pricing differences between these VMs, and the long-term budget effects.
- Each type has several VM series within it.
- Additionally, when you select a VM within a series, you can only scale the VM up and down within that series. For example, a `DS2_v2` instance can scale up to `DS4_v2`, but it can't be changed to an instance of a different series, such as a `F2s_v2` instance.

**Learn more:**

- Learn more about [VM types and sizing](/azure/virtual-machines/sizes), and map sizes to types.
- Plan [sizes for VM instances](/azure/cloud-services/cloud-services-sizes-specs).
- Review a [sample assessment for the fictional Contoso company](../../plan/contoso-migration-assessment.md).

## Best practice: Select the right storage

Tuning and maintaining on-premises storage (SAN or NAS), and the networks to support them, can be costly and time-consuming. File (storage) data is commonly migrated to the cloud to help alleviate operational and management headaches. Microsoft provides several options for moving data to Azure, and you need to make decisions about those options. Picking the right storage type for data can save your organization several thousands of dollars every month. Here are a few considerations:

- Data that isn't accessed much and isn't business-critical doesn't need to be placed on the most expensive storage.
- Conversely, important business-critical data should be located on higher tier storage options.
- During migration planning, take an inventory of data and classify it by importance, in order to map it to the most suitable storage. Consider budget and costs, as well as performance. Cost shouldn't necessarily be the main factor. Picking the least expensive option might expose the workload to performance and availability risks.

### Storage data types

Azure provides different types of storage data.

| Data type | Details | Usage |
| --- | --- | --- |
| **Blobs** | Optimized to store massive amounts of unstructured objects, such as text or binary data. <br><br> | Access data from everywhere over HTTP/HTTPS. <br><br> Use for streaming and random access scenarios. For example, to serve images and documents directly to a browser, stream video and audio, and store backup and disaster recovery data. |
| **Files** | Managed file shares accessed over SMB 3.0. | Use when migrating on-premises file shares and to provide multiple access/connections to file data. |
| **Disks** | Based on page blobs. <br><br> Disk type: standard (HDD or SSD) or premium (SSD). <br><br> Disk management: unmanaged (you manage disk settings and storage) or managed (you select the disk type and Azure manages the disk for you). | Use premium disks for VMs. Use managed disks for simple management and scaling. |
| **Queues** | Store and retrieve large numbers of messages accessed via authenticated calls (HTTP or HTTPS). | Connect application components with asynchronous message queueing. |
| **Tables** | Store tables. | This data type is part of Azure Cosmos DB Table API. |

### Access tiers

Azure Storage provides different options for accessing block blob data. Selecting the right access tier helps ensure that you store block blob data in the most cost-effective manner.

| Access tier | Details | Usage |
| --- | --- | --- |
| **Hot** | Higher storage cost than cool. Lower access charges than cool. <br><br> This is the default tier. | Use for data in active use, that's accessed frequently. |
| **Cool** | Lower storage cost than hot. Higher access charges than hot. <br><br> Store for minimum of 30 days. | Store short-term. Data is available but accessed infrequently. |
| **Archive** | Used for individual block blobs. <br><br> Most cost-effective option for storage. Data access is more expensive than hot and cold. | Use for data that can tolerate several hours of retrieval latency and will remain in the tier for at least 180 days. |

### Storage account types

Azure provides different types of storage accounts and performance tiers.

| Account type | Details | Usage |
| --- | --- | --- |
| **General-purpose v2 standard** | Supports blobs (block, page, and append), files, disks, queues, and tables. <br><br> Supports hot, cool, and archive access tiers. Zone-redundant storage (ZRS) is supported. | Use for most scenarios and most types of data. Standard storage accounts can be HDD- or SSD-based. |
| **General-purpose v2 premium** | Supports Blob Storage data (page blobs). Supports hot, cool, and archive access tiers. ZRS is supported. <br><br> Stored on SSD. | Microsoft recommends using for all VMs. |
| **General-purpose v1** | Access tiering isn't supported. Doesn't support ZRS. | Use if applications need the Azure classic deployment model. |
| **Blob** | Specialized storage account for storing unstructured objects. Provides block blobs and append blobs only (no file, queue, table, or disk storage services). Provides the same durability, availability, scalability and performance as general-purpose v2. | You can't store page blobs in these accounts, and therefore can't store VHD files. You can set an access tier to hot or cool. |

### Storage redundancy options

Storage accounts can use different types of redundancy for resilience and high availability.

| Type | Details | Usage |
| --- | --- | --- |
| **Locally redundant storage (LRS)** | Protects against a local outage by replicating within a single storage unit to a separate fault domain and update domain. Keeps multiple copies of your data in one datacenter. Provides at least 99.999999999 percent (eleven nines) durability of objects over a particular year. | Consider whether your application stores data that can be easily reconstructed. |
| **Zone-redundant storage (ZRS)** | Protects against a datacenter outage by replicating across three storage clusters in a single region. Each storage cluster is physically separated and located in its own Availability Zone. Provides at least 99.9999999999 percent (twelve nines) durability of objects over a particular year, by keeping multiple copies of your data across multiple datacenters or regions. | Consider whether you need consistency, durability, and high availability. Might not protect against a regional disaster, when multiple zones are permanently affected. |
| **Geo-redundant storage (GRS)** | Protects against an entire region outage, by replicating data to a secondary region hundreds of miles away from the primary. Provides at least 99.99999999999999 percent (sixteen nines) durability of objects over a particular year. | Replica data isn't available unless Microsoft initiates a failover to the secondary region. If failover occurs, read and write access is available. |
| **Read-access geo-redundant storage (RA-GRS)** | Similar to GRS. Provides at least 99.99999999999999 percent (sixteen nines) durability of objects over a particular year. | Provides 99.99 percent read availability, by allowing read access from the second region used for GRS. |

**Learn more:**

- Review [Azure Storage pricing](https://azure.microsoft.com/pricing/details/storage/).
- Learn about [Azure Import/Export](/azure/import-export/storage-import-export-service).
- Compare [blobs, files, and disk storage data types](/azure/storage/common/storage-introduction).
- Learn more about [access tiers](/azure/storage/blobs/storage-blob-storage-tiers).
- Review [different types of storage accounts](/azure/storage/common/storage-account-overview).
- Learn about [Azure Storage redundancy](/azure/storage/common/storage-redundancy), including LRS, ZRS, GRS, and read-access GRS.
- Learn more about [Azure Files](/azure/storage/files/storage-files-introduction).

## Best practice: Take advantage of Azure Hybrid Benefit

A portfolio that integrates on-premises Microsoft software with Azure can provide you with competitive and cost advantages. If you currently have an operating system or other software licensing through Software Assurance, you can take those licenses with you to the cloud, with Azure Hybrid Benefit.

**Learn more:**

- [Take a look at](https://azure.microsoft.com/pricing/hybrid-benefit/) the Azure Hybrid Benefit savings calculator.
- Learn more about [Azure Hybrid Benefit for Windows Server](https://azure.microsoft.com/pricing/hybrid-benefit/).
- Review [pricing guidance for SQL Server Azure VMs](/azure/azure-sql/virtual-machines/windows/pricing-guidance).

## Best practice: Use reserved VM instances

Most cloud platforms use a pay-as-you-go payment model. This model presents disadvantages, because you don't necessarily know how dynamic your workloads will be. When you specify clear intentions for a workload, you contribute to infrastructure planning.

When you use Azure Reserved VM Instances, you prepay for a one-year or three-year term for VM instances.

- Prepayment provides a discount on the resources you use.
- You can significantly reduce VM, Azure SQL Database compute, Azure Cosmos DB, or other resource costs that compare to pay-as-you-go prices.
- Reservations provide a billing discount, and don't affect the runtime state of your resources.
- You can cancel reserved instances.

![Screenshot of comparison of pay-as-you-go and Azure Hybrid Benefit with reserved instances.](./media/migrate-best-practices-costs/reserve.png)
*Figure 3: Azure Reserved VM Instances.*

**Learn more:**

- Learn about [Azure Reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations).
- Read the [Azure Reserved VM Instances FAQ](https://azure.microsoft.com/pricing/reserved-vm-instances/#faq).
- Review [pricing guidance for SQL Server on Azure VMs](/azure/azure-sql/virtual-machines/windows/pricing-guidance).

## Best practice: Aggregate cloud spending across subscriptions

Eventually, it's very likely that you'll have more than one Azure subscription. For example, you might need an additional subscription to separate development and production boundaries, or you might have a platform that requires a separate subscription for each client. Having the ability to aggregate data reporting across all the subscriptions into a single platform is a valuable feature.

To do this, you can use Azure Cost Management + Billing APIs. Then, after aggregating data into a single source such as Azure SQL Database, you can use tools like Power BI to surface the aggregated data. You can create aggregated subscription reports, and granular reports. For example, for users who need proactive insights into cost management, you can create specific views of costs, based on department, resource group, or other information. You don't need to provide them with full access to Azure billing data.

**Learn more:**

- Read the [Azure Consumption APIs overview](/azure/cost-management-billing/manage/consumption-api-overview).
- Learn how to [connect to Azure Consumption Insights in Power BI Desktop](/power-bi/connect-data/desktop-connect-azure-consumption-insights).
- Learn how to [manage access to billing information for Azure by using Azure role-based access control (Azure RBAC)](/azure/cost-management-billing/manage/manage-billing-access).

## After migration

After a successful migration of your workloads and a few weeks of collecting consumption data, you'll have a clear idea of resources costs. As you analyze data, you can start to generate a budget baseline for Azure resource groups and resources. Then, as you understand where your cloud budget is being spent, you can analyze how to further reduce your costs.

## Best practice: Use Azure Cost Management + Billing

Microsoft provides Azure Cost Management + Billing to help you track spending. This service:

- Helps you to monitor and control Azure spending, and optimize use of resources.
- Reviews your entire subscription and all of its resources, and makes recommendations.
- Provides you with a full API to integrate external tools and financial systems for reporting.
- Tracks resource usage and helps you manage cloud costs with a single, unified view.
- Provides rich operational and financial insights to help you make informed decisions.

With Azure Cost Management + Billing, you can:

- Create a budget for financial accountability.
  - You can account for the services you consume or subscribe to for a specific period (monthly, quarterly, or annually), and a scope (subscriptions or resource groups). For example, you can create an Azure subscription budget for a monthly, quarterly, or annual period.
    - After you create a budget, it's shown in a cost analysis. Viewing your budget against current spending is important when you're analyzing your costs and spending.
  - You can choose to have email notifications sent when your budget thresholds are reached.
  - You can export costs management data to Azure Storage to analyze it.

  ![Screenshot of an Azure Cost Management budget.](./media/migrate-best-practices-costs/budget.png)
  *Figure 4: An Azure Cost Management + Billing budget.*

- Perform a cost analysis to explore and analyze your organizational costs, to understand how costs are accrued, and identify spending trends.
  - Cost analysis is available to Enterprise Agreement users.
  - You can view cost analysis data for various scopes, including by department, account, subscription, or resource group.
  - You can get a cost analysis that shows total costs for the current month, and accumulated daily costs.

  ![Screenshot of Azure Cost Management analysis](./media/migrate-best-practices-costs/analysis.png)
  *Figure 5: Azure Cost Management + Billing analysis.*

- Get Azure Advisor recommendations that show you how you can optimize and improve efficiency.

**Learn more:**

- Read the [Azure Cost Management + Billing overview](/azure/cost-management-billing/cost-management-billing-overview).
- Learn to [optimize your cloud investment with Azure Cost Management + Billing](/azure/cost-management-billing/costs/cost-mgt-best-practices).
- Learn about [Azure Cost Management + Billing reports](/azure/cost-management-billing/cloudyn/use-reports).
- Get a [tutorial on optimizing costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations).
- Review the [Azure Consumption APIs](/rest/api/consumption/budgets).

## Best practice: Monitor resource utilization

In Azure you pay for what you use, when resources are consumed, and you don't pay when they aren't. For VMs, billing occurs when a VM is allocated, and you aren't charged after a VM is deallocated. With this in mind, you should monitor VMs in use, and verify VM sizing.

Continually evaluate your VM workloads to determine baselines. For example, if your workload is used heavily Monday through Friday, 8 AM to 6 PM, but hardly used outside those hours, you can downgrade VMs outside peak times. This might mean changing VM sizes, or using virtual machine scale sets to autoscale VMs up or down. Some companies "snooze" VMs via a calendar that specifies when they should be available and when they're not needed.

You can monitor VM usage by using Microsoft tools, such as Azure Cost Management + Billing, Azure Monitor, and Azure Advisor. Third-party tools are also available.

> [!NOTE]
> In addition to VM monitoring, you should monitor other networking resources, such as Azure ExpressRoute and virtual network gateways, for underuse and overuse.

**Learn more:**

- Read overviews of [Azure Monitor](/azure/azure-monitor/overview) and [Azure Advisor](/azure/advisor/advisor-overview).
- [Get Azure Advisor cost recommendations](/azure/advisor/advisor-cost-recommendations).
- Learn how to [optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations), and [prevent unexpected charges](/azure/cost-management-billing/cost-management-billing-overview).
- Learn about the [Azure Resource Optimization (ARO) toolkit](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/azure-resource-optimization-toolkit).

## Best practice: Implement resource group budgets

Often, you might find it useful to represent cost boundaries with resource groups. A resource group budget helps you track the costs associated with a resource group. You can trigger alerts and run a wide variety of playbooks when you reach or exceed your budget.

**Learn more:**

- Learn how to [manage costs with Azure budgets](/azure/cost-management-billing/manage/cost-management-budget-scenario).
- Review a tutorial on [creating and managing an Azure budget](/azure/cost-management-billing/costs/tutorial-acm-create-budgets).

## Best practice: Optimize Azure Monitor retention

As you move resources into Azure and enable diagnostic logging for them, you generate a lot of log data. Typically, this log data is sent to a storage account that's mapped to a Log Analytics workspace. Here are a few tips for optimizing Azure Monitor retention:

- The longer the log data retention period, the more data you'll have.
- Not all log data is equal, and some resources will generate more log data than others.
- Due to regulations and compliance, it's likely that you'll need to retain log data for some resources longer than for others.
- You should walk a careful line between optimizing your log storage costs, and keeping the log data you need.
- We recommend evaluating and setting up the logging immediately after completing a migration so that you don't spend money on retaining nonessential logs.

**Learn more:**

- Learn about [monitoring usage and estimated costs](/azure/azure-monitor/usage-estimated-costs).

## Best practice: Optimize storage

If you followed best practices for selecting storage before migration, you're probably reaping some benefits. But there can be additional storage costs that you can still optimize. Over time, blobs and files become stale. Data might not be used anymore, but regulatory requirements might mean that you need to keep it for a certain period. As such, you might not need to store it on the high-performance storage that you used for the original migration.

Identifying and moving stale data to cheaper storage areas can have a huge impact on your monthly storage budget and cost savings. Azure provides many ways to help you identify and then store this stale data.

- Take advantage of access tiers for general-purpose v2 storage, moving less important data from the hot tier to the cool or archived tiers.
- Use StorSimple to help move stale data that's based on customized policies.

**Learn more:**

- Learn more about [access tiers](/azure/storage/blobs/storage-blob-storage-tiers).
- Read the [StorSimple overview](/azure/azure-monitor/overview).
- Review [StorSimple pricing](https://azure.microsoft.com/pricing/details/storsimple/).

## Best practice: Automate VM optimization

The ultimate goal of running a VM in the cloud is to maximize the CPU, memory, and disk that it uses. If you discover VMs that aren't optimized or have frequent periods when VMs aren't used, it makes sense to either shut them down or downscale them by using virtual machine scale sets.

You can optimize a VM with Azure Automation, virtual machine scale sets, auto-shutdown, and scripted or third-party solutions.

**Learn more:**

- Learn about [vertical autoscaling](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-vertical-scale-reprovision).
- [Schedule a VM autostart](https://azure.microsoft.com/updates/azure-devtest-labs-schedule-vm-auto-start/).
- Learn how to [start or stop VMs off hours in Azure Automation](/azure/automation/automation-solution-vm-management).
- Get more information about [Azure Advisor](/azure/advisor/advisor-overview), and the [Azure Resource Optimization (ARO) toolkit](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/azure-resource-optimization-toolkit).

## Best practices: Use Azure Logic Apps and runbooks with Budgets API

Azure provides a REST API that has access to your tenant billing information. You can use the Budgets API to integrate external systems and workflows that are triggered by metrics that you build from the API data. You can pull usage and resource data into your preferred data analysis tools. You can integrate the Budgets API with Azure Logic Apps and runbooks.

The Azure Resource Usage and RateCard APIs can help you accurately predict and manage your costs. The APIs are implemented as a resource provider and are included in the APIs exposed by the Azure Resource Manager.

**Learn more:**

- Review the [Azure Budgets API](/rest/api/consumption/budgets).
- Get insights into usage with the [Azure Billing APIs](/azure/cost-management-billing/manage/consumption-api-overview#usage-details-api).

## Best practice: Implement serverless technologies

VM workloads are often migrated "as-is" to avoid downtime. Often, VMs can host tasks that are intermittent, run over a short period, or take up many hours. Examples include VMs that run scheduled tasks, such as Windows task scheduler or PowerShell scripts. When these tasks aren't running, you're absorbing VM and disk storage costs.

After migrating and thoroughly reviewing these types of tasks, you might consider migrating them to serverless technologies like Azure Functions or Azure Batch jobs. These solutions can cut costs, and you'd no longer need to manage and maintain the VMs.

**Learn more:**

- Learn about [Azure Functions](https://azure.microsoft.com/services/functions/).
- Learn about [Azure Batch](https://azure.microsoft.com/services/batch/).

## Next steps

Review other best practices:

- Explore [best practices for security and management](./migrate-best-practices-security-management.md) after migrating workloads to Azure.
- Explore [best practices for networking](./migrate-best-practices-networking.md) after migrating workloads to Azure.
