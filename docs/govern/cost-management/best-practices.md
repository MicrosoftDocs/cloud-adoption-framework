---
title: Costing and sizing Azure resources
description: Use the Cloud Adoption Framework for Azure to learn best practices for costing and sizing resources in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Best practices for costing and sizing resources hosted in Azure

While delivering the disciplines of governance, cost management is a recurring theme at the enterprise level. By optimizing and managing costs, you can ensure the long-term success of your Azure environment. It's critical that all teams (such as finance, management, and application development teams) understand associated costs and review them on a recurring basis.

## Best practices by team and accountability

Cost management across the enterprise is a cloud governance and cloud operation function. All cost management decisions result in a change to the assets which support a workload. When those changes impact the architecture of a workload, additional considerations are required to minimize the impact on end users and business functions. The cloud adoption team who configured or developed that workload are likely to hold accountability for completing those types of changes.

Collective the centralized and decentralized teams should collaborate to ensure the following high level behaviors are implemented across your portfolio:

- **Tagging is critical to all governance.** Ensure all workloads and resources follow [proper naming and tagging conventions](../../ready/azure-best-practices/naming-and-tagging.md) and [enforce tagging conventions using Azure Policy](/azure/governance/policy/tutorials/govern-tags). This will help your centralized governance teams make wise cost management decisions.
- **Licensing alignment:** Proper allocation of Azure Hybrid Benefit and Azure Reserved VM Instances will significantly reduce your per unit cost for assets across your portfolio. These types of licensing decisions are generally established and maintained by central procurement functions. However, decentralized workload teams may want to be consulted on purchase and allocation of the licenses to minimize the cost of their individual workloads.
- **Identify right size opportunities.** Review your current resource utilization and performance requirements across the environment. Modify each resource to use the smallest instance or SKU that can support the performance requirements of each resource.
- **Shut down and deprovision unused resources:** Unused assets add cost in a cloud environment. Identify and terminate any resources that are adding to costs, but are not adding to business value.
- **Horizontal over vertical scale.** Using multiple small instances can allow for an easier scaling path that a single larger instance. This allows for scale automation, which creates cost optimization.

## Operational cost management best practices

The following best practices are typically completed by a member of the cloud governance or cloud operations team, in accordance with patching and other scheduled maintenance processes. These best practices map to actionable guidance later in this article.

- **Tagging is critical to all governance:** Ensure all workloads and resources follow [proper naming and tagging conventions](../../ready/azure-best-practices/naming-and-tagging.md) and [enforce tagging conventions using Azure Policy](/azure/governance/policy/tutorials/govern-tags).
- **Licensing alignment:** The most immediate cost impact on a large portfolio of workloads will come from a well-planned license acquisition strategy. Purchase and allocation of Azure Hybrid Benefit, Azure Reserved VM Instances, Spot VMs and other buying strategies will rapidly reduce costs across your entire cloud portfolio.
- **Identify right size opportunities:** Review your current resource utilization and performance requirements across the environment to identify resources which have remained underutilized for a period of time (generally more than 90 days).
- **Right-size provisioned SKUs:** Modify underutilized resource to use the smallest instance or SKU that can support the performance requirements of each resource.
- **Auto-shutdown for VMs:** When a VM isn't in constant use, consider automated shutdown. The VM won't be deleted or decommissioned, but it will stop consuming compute and memory costs until it's turned back on.
- **Auto-shutdown all nonproduction assets:** If a VM is part of a nonproduction environment, specifically development environments, establish an auto-shutdown policy to reduce unused costs. Whenever possible, use Azure DevTest Labs as a self-service option to help developers hold themselves accountable for cost.
- **Shut down and decommission unused resources:** Yes, we said it twice. If a resource hasn't been used in more than 90 days and doesn't have a clear uptime requirement, turn it off. More importantly, if a machine has been stopped or shut down for more than 90 days, then deprovision and delete that resource. Validate that any data retention policies are met through backup or other mechanisms.
- **Clean up orphaned disks:** Delete unused storage, especially VM storage that is no longer attached to any VMs.
- **Right-size redundancy:** If the resource doesn't require a high degree of redundancy, remove geo-redundant storage.
- **Adjust autoscale parameters:** Operational monitoring is likely to uncover usage patterns for various assets. When those usage patterns map to the parameters used to drive autoscale behaviors, it's common for the operations team to adjust autoscale parameters to meet seasonal demand or changes to budget allocations. Review workload cost management best practices for important precautions.

## Workload cost management best practices

Before making architectural changes, consult the technical lead for the workload. Facilitating a review of the workload using [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review) and the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) to guide decisions regarding the following types of architectural changes.

- **Azure App Service.** Verify production requirements for any Premium tier App Service plans. Without an understanding of the business requirements for a workload and the underlying assets configuration, it's difficult to determine whether a Premium tier plan is required.
- **Horizontal over vertical scale.** Using multiple small instances can allow for an easier scaling path that a single larger instance. This allows for scale automation, which creates cost optimization. Before a workload can scale horizontally, the technical team must verify that the application is idempotent. Achieving horizontal scale may first require changes to the code and configuration of various layers of the of the application.
- **Autoscale.** Enable autoscale on all app services to allow for a burstable number of smaller VMs. Enabling autoscale has the same idempotent requirement, which requires an understanding of the workload architecture. The workload and supporting assets must be approved for horizontal scaling and autoscaling by the adoption team, prior to any operational changes.
- **Implement serverless technologies:** VM workloads are often migrated "as is" to avoid downtime. Often VMs may host tasks that are intermittent, taking a short period to run, or alternatively many hours. For example, VMs that run scheduled tasks such as Windows task scheduler or PowerShell scripts. When these tasks aren't running, you're nevertheless absorbing VM and disk storage costs. After migration, consider rearchitecting layers of the workload to serverless technologies such as Azure Functions or Azure Batch jobs.

## Actionable best practices

The remainder of this article provides tactical examples of operational best practices that a cloud governance or cloud operations team can follow to optimize cost across the enterprise.

## Before adoption

Before you move your workloads to the cloud, estimate the monthly cost of running them in Azure. Proactively managing cloud costs helps you adhere to your operating expense budget. The best practices in this section help you to estimate costs, and perform right-sizing for VMs and storage before a workload is deployed to the cloud.

## Best practice: Estimate monthly workload costs

To forecast your monthly bill for Azure resources, there are several tools you can use.

<!-- TODO - Change "input costs" -->

- **Azure pricing calculator:** Select the products you want to estimate, for example VMs and storage, then input costs into the calculator to build an estimate.

    ![Azure pricing calculator](../../migrate/azure-best-practices/media/migrate-best-practices-costs/pricing.png)
    *Azure pricing calculator.*

- **Azure Migrate:** To estimate costs, you need to review and account for all the resources required to run your workloads in Azure. To acquire this data, you create inventory of your assets, including servers, VMs, databases, and storage. You can use Azure Migrate to collect this information.
  - Azure Migrate discovers and assesses your on-premises environment to provide an inventory.
  - Azure Migrate can map and show you dependencies between VMs so that you have a complete picture.
  - An Azure Migrate assessment contains estimated cost.
    - **Compute costs:** Using the Azure VM size recommended when you create an assessment, Azure Migrate uses the Azure Billing APIs to calculate estimated monthly VM costs. The estimate considers the operating system, Software Assurance, Azure Reserved VM Instances, VM uptime, location, and currency settings. It aggregates the cost across all VMs in the assessment, and calculates a total monthly compute cost.
    - **Storage cost:** Azure Migrate calculates total monthly storage costs by aggregating the storage costs of all VMs in an assessment. You can calculate the monthly storage cost for a specific machine by aggregating the monthly cost of all disks attached to it.

    ![Azure Migrate](../../migrate/azure-best-practices/media/migrate-best-practices-costs/assess.png)
    *Azure Migrate assessment.*

**Learn more:**

- Use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/).
- Read the [Azure Migrate overview](/azure/migrate/migrate-services-overview).
- Read about [Azure Migrate assessments](/azure/migrate/concepts-assessment-calculation).
- Learn more about the [Azure Database Migration Service](/azure/dms/dms-overview).

## Best practice: Right-size VMs

You can choose various options when you deploy Azure VMs to support workloads. Each VM type has specific features and different combinations of CPU, memory, and disks. VMs are grouped as shown below:

| Type | Details | Usage |
|---|---|---|
| **General-purpose** | Balanced CPU-to-memory. | Good for testing and development, small to midsize databases, low- to medium-volume traffic web servers. |
| **Compute-optimized** | High CPU-to-memory. | Good for medium-volume traffic web server, network appliances, batch processes, application servers. |
| **Memory-optimized** | High memory-to-CPU. | Good for relational databases, medium- to large-size cache, in-memory analytics. |
| **Storage optimized** | High disk throughput and I/O. | Suitable for big data, SQL, and NoSQL databases. |
| **GPU optimized** | Specialized VMs. Single or multiple GPUs. | Heavy graphics and video editing. |
| **High performance** | Fastest and most powerful CPU. VMs with optional high-throughput network interfaces (RDMA). | Critical high-performance applications. |

- It's important to understand the pricing differences between these VMs, and the long-term budget effects.
- Each type has several series of VMs within it.
- Additionally, when you select a VM within a series, you can only scale the VM up and down within that series. For example, a `DS2_v2` instance can scale up to `DS4_v2`, but it can't be changed to an instance of a different series such as a `F2S_v2` instance.

**Learn more:**

- Learn more about [VM types and sizing](/azure/virtual-machines/sizes), and map sizes to types.
- Plan [VM sizing](/azure/cloud-services/cloud-services-sizes-specs).
- Review a [sample assessment for the fictional Contoso company](../../plan/contoso-migration-assessment.md).

## Best practice: Select the right storage

Tuning and maintaining on-premises storage (SAN or NAS), and the networks to support them, can be costly and time-consuming. File (storage) data is commonly migrated to the cloud to help alleviate operational and management headaches. Microsoft provides several options for moving data to Azure, and you need to make decisions about those options. Picking the right storage type for data can save your organization several thousands of dollars every month. A few considerations:

- Data that isn't accessed much and isn't business-critical shouldn't be placed on the most expensive storage.
- Conversely, important business-critical data should be located on higher tier storage options.
- During adoption planning, take an inventory of data and classify it by importance, in order to map it to the most suitable storage. Consider budget and costs, as well as performance. Cost shouldn't necessarily be the main decision-making factor. Picking the least expensive option could expose the workload to performance and availability risks.

### Storage data types

Azure provides different types of storage data.

| Data type | Details | Usage |
| ---|---|---|
| **Blobs** | Optimized to store massive amounts of unstructured objects, such as text or binary data. | Access data from everywhere over HTTP/HTTPS. <br><br> Use for streaming and random access scenarios. For example, to serve images and documents directly to a browser, stream video and audio, and store backup and disaster recovery data. |
| **Files** | Managed file shares accessed over SMB 3.0. | Use when migrating on-premises file shares, and to provide multiple access and connections to file data. |
| **Disks** | Based on page blobs. <br><br> Disk type (speed): Standard HDD, standard SSD, premium SSD, or ultra disks. <br><br> Disk management: unmanaged (you manage disk settings and storage) or managed (you select the disk type and Azure manages the disk for you). | Use premium disks for VMs. Use managed disks for simple management and scaling. |
| **Queues** | Store and retrieve large numbers of messages accessed via authenticated calls (HTTP or HTTPS). | Connect application components with asynchronous message queuing. |
| **Tables** | Store tables. | Now part of Azure Cosmos DB Table API. |

### Access tiers

Azure Storage provides different options for accessing block blob data. Selecting the right access tier helps ensure that you store block blob data in the most cost-effective manner.

| Access tier | Details | Usage |
| --- | --- | --- |
| **Hot** | Higher storage costs, lower access, and transaction costs <br><br> This is the default access tier. | Use for data in active use that's accessed frequently. |
| **Cool** | Lower storage costs, higher access and transaction costs. <br><br> Store for minimum of 30 days. | Store short-term, data is available but accessed infrequently. |
| **Archive** | Used for individual block blobs. <br><br> Most cost-effective option for storage. Lowest storage costs, highest access and transaction costs. | Use for data that can tolerate several hours of retrieval latency and will reside in the archive tier for at least 180 days. |

### Storage account types

Azure provides different types of storage accounts and performance tiers.

| Account type | Details | Usage |
| --- | --- | --- |
| **General-purpose v2 Standard tier** | Supports blobs (block, page, append), files, disks, queues, and tables. <br><br> Supports hot, cool, and archive access tiers. Zone-redundant storage (ZRS) is supported. | Use for most scenarios and most types of data. Standard storage accounts can be HDD or SSD-based. |
| **General-purpose v2 Premium tier** | Supports Blob Storage data (page blobs). Supports hot, cool, and archive access tiers. ZRS is supported. <br><br> Stored on SSD. | Microsoft recommends using for all VMs. |
| **General-purpose v1** | Access tiering isn't supported. Doesn't support ZRS | Use if applications need the Azure classic deployment model. |
| **Blob** | Specialized storage account for storing unstructured objects. Provides block blobs and append blobs only (no file, queue, table, or disk storage services). Provides the same durability, availability, scalability, and performance as general-purpose v2. | You can't store page blobs in these accounts, and therefore can't store VHD files. You can set an access tier to hot or cool. |

### Storage redundancy options

Storage accounts can use different types of redundancy for resilience and high availability.

| Type | Details | Usage |
| --- | --- | --- |
| **Locally redundant storage (LRS)** | Protects against a local outage by replicating within a single storage unit to a separate fault domain and update domain. Keeps multiple copies of your data in one datacenter. Provides at least 99.999999999 percent (eleven 9's) durability of objects over a given year. | Consider whether your application stores data that can be easily reconstructed. |
| **Zone-redundant storage (ZRS)** | Protects again a datacenter outage by replicating across three storage clusters in a single region. Each storage cluster is physically separated and located in its own Availability Zone. Provides at least 99.9999999999 percent (twelve 9's) durability of objects over a given year by keeping multiple copies of your data across multiple datacenters or regions. | Consider whether you need consistency, durability, and high availability. Might not protect against a regional disaster when multiple zones are permanently affected. |
| **Geo-redundant storage (GRS)** | Protects against an entire region outage by replicating data to a secondary region that's hundreds of miles away from the primary. Provides at least 99.99999999999999 percent (sixteen 9's) durability of objects over a given year. | Replica data isn't available unless Microsoft initiates a failover to the secondary region. If failover occurs, read and write access is available. |
| **Read-access geo-redundant storage (RA-GRS)** | Similar to GRS. Provides at least 99.99999999999999 percent (sixteen 9's) durability of objects over a given year. | Provides and 99.99 percent read availability by allowing read access from the second region used for GRS. |

**Learn more:**

- Review [Azure Storage pricing](https://azure.microsoft.com/pricing/details/storage/).
- Learn to use the [Azure Import/Export service](/azure/import-export/storage-import-export-service) to securely import large amounts of data to Azure Blob Storage and Azure Files.
- Compare [blobs, files, and disk storage data types](/azure/storage/common/storage-introduction).
- Learn more about [access tiers](/azure/storage/blobs/storage-blob-storage-tiers).
- Review [different types of storage accounts](/azure/storage/common/storage-account-overview).
- Learn about [Azure Storage redundancy](/azure/storage/common/storage-redundancy), including LRS, ZRS, GRS, and read-access GRS.
- Learn more about [Azure Files](/azure/storage/files/storage-files-introduction).

## After adoption

Prior to adoption, cost forecasts are dependent upon decisions made by workload owners and the cloud adoption team. While the governance team can aid in influencing those decisions, there's likely to be little action for the governance team to take.

Once resources are in production, data can be aggregated and trends analyzed at an environment level. This data will help the governance team make sizing and usage decisions independently, based on actual usage patterns and current state architecture.

- Analyze data to generate a budget baseline for Azure resource groups and resources.
- Identify patterns of use that would allow you to reduce size and stop or pause resources to further reduce your costs.

Best practices in this section include using Azure Hybrid Benefit and Azure Reserved VM Instances, reduce cloud spending across subscriptions, using Azure Cost Management + Billing for cost budgeting and analysis, monitoring resources and implementing resource group budgets, and optimizing monitoring, storage, and VMs.

## Best practice: Take advantage of Azure Hybrid Benefit

Due to years of software investment in systems such as Windows Server and SQL Server, Microsoft is in a unique position to offer customers value in the cloud, with substantial discounts that other cloud providers can't necessarily provide.

An integrated Microsoft on-premises/Azure product portfolio generates competitive and cost advantages. If you currently have an operating system or other software licensing through Software Assurance (SA), you can take those licenses with you to the cloud for with Azure Hybrid Benefit.

**Learn more:**

- [Take a look at](https://azure.microsoft.com/pricing/hybrid-benefit/) the Azure Hybrid Benefit savings calculator.
- Learn more about [Azure Hybrid Benefit for Windows Server](https://azure.microsoft.com/pricing/hybrid-benefit/).
- Review [pricing guidance for SQL Server Azure VMs](/azure/azure-sql/virtual-machines/windows/pricing-guidance).

## Best practice: Use Azure Reserved VM Instances

Most cloud platforms are set up as pay-as-you-go. This model presents disadvantages, since you don't necessarily know how dynamic workloads will be. When you specify clear intentions for a workload, you contribute to infrastructure planning.

Using Azure Reserved VM Instances, you prepay for either a one-year or three-year term for reserved instances.

- Prepayment provides a discount on the resources you use.
- You can significantly reduce costs for VM compute, SQL Database compute, Azure Cosmos DB, or other resources by up to 72% on pay-as-you-go prices.
- Reserved instances provide a billing discount, and don't affect the runtime state of your resources.
- You can cancel reserved instances.

![Azure Reserved VM Instances](../../migrate/azure-best-practices/media/migrate-best-practices-costs/reserve.png)
*Figure 1: Azure Reserved VM instances.*

**Learn more:**

- Learn about [Azure Reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations).
- Read the [reserved instances FAQ](https://azure.microsoft.com/pricing/reserved-vm-instances/#faq).
- Review [pricing guidance for SQL Server Azure VMs](/azure/azure-sql/virtual-machines/windows/pricing-guidance).

## Best practice: Aggregate cloud spend across subscriptions

It's inevitable that eventually you'll have more than one Azure subscription. For example, you might need an additional subscription to separate development and production boundaries, or you might have a platform that requires a separate subscription for each client. Having the ability to aggregate data reporting across all the subscriptions into a single platform is a valuable feature.

To do this, you can use Azure Cost Management + Billing APIs. Then, after aggregating data into a single source such as Azure SQL Database, you can use tools like Power BI to surface the aggregated data. You can create aggregated subscription reports, and granular reports. For example, for users who need proactive insights into cost management, you can create specific views of costs, based on department, resource group, or other information. You don't need to provide them with full access to Azure billing data.

**Learn more:**

- Read the [Azure Consumption APIs overview](/azure/cost-management-billing/manage/consumption-api-overview).
- Learn about [connecting to Azure Consumption Insights in Power BI Desktop](/power-bi/connect-data/desktop-connect-azure-consumption-insights).
- Learn to [manage access to billing information for Azure using Azure role-based access control (Azure RBAC)](/azure/cost-management-billing/manage/manage-billing-access).

## Best practice: Monitor resource utilization

In Azure you pay for what you use, when resources are consumed, and you don't pay when they aren't. For VMs, billing occurs when a VM is allocated, and you aren't charged after a VM is deallocated. With this in mind you should monitor VMs in use, and verify VM sizing.

- Continually evaluate your VM workloads to determine baselines.
- For example, if your workload is used heavily Monday through Friday, 8am to 6pm, but hardly used outside those hours, you could downgrade VMs outside peak times. This might mean changing VM sizes, or using virtual machine scale sets to autoscale VMs up or down.
- Some companies "snooze", VMs by putting them on a calendar that specifies when they should be available, and when they're not needed.
- In addition to VM monitoring, you should monitor other networking resources such as ExpressRoute and virtual network gateways for under and over use.
- You can monitor VM usage using Microsoft tools such as Azure Cost Management + Billing, Azure Monitor, and Azure Advisor. Third-party tools are also available.

**Learn more:**

- Read overviews of [Azure Monitor](/azure/azure-monitor/overview) and [Azure Advisor](/azure/advisor/advisor-overview).
- Get [Azure Advisor cost recommendations](/azure/advisor/advisor-cost-recommendations).
- Learn how to [optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations), and [prevent unexpected charges](/azure/cost-management-billing/cost-management-billing-overview).
- Learn about the [Azure Resource Optimization (ARO) toolkit](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/azure-resource-optimization-toolkit).

## Best practice: Reduce nonproduction costs

Development, testing, and quality assurance (QA) environments are needed during development cycles. Unfortunately, it's common for those environments to stay provisioned long after they cease to be useful. A regular review of unused nonproduction environments can have an immediate impact on costs.

Additionally, consider general cost reductions for any nonproduction environments:

- Reduce nonproduction resources to use lower cost B-series VMs and standard storage.
- Reduce nonproduction compute costs by using Spot VMs.
- Apply Azure policies to require resource level cost-reductions for any nonproduction resources.

**Learn more:**

- [Use tags](/azure/azure-resource-manager/management/tag-resources) to identify dev, test, or QA targets for resizing or termination.
- [Auto-shutdown VMs](/azure/cost-management-billing/cost-management-billing-overview#consider-cost-cutting-features-like-auto-shutdown-for-vms) sets a nightly termination time for VMs. Using this feature will stop nonproduction VMs each night, requiring developers to restart those VMs when they're ready to resume development.
- [Spot VMs](/azure/virtual-machines/spot-vms) allows it to take advantage of unused Azure capacity at a significant cost savings. However, at any point in time when Azure needs the capacity back, the Azure infrastructure will evict Spot VMs.
- Encourage development teams to use [Azure DevTest Labs](/azure/devtest-labs/devtest-lab-overview) to establish their own cost-control approaches and avoid impact of the standard auto-shutdown timing in the prior step.

## Best practice: Use Azure Cost Management + Billing

Microsoft provides Azure Cost Management + Billing to help you track spending:

- Helps you to monitor and control Azure spending, and optimize use of resources.
- Reviews your entire subscription and all of its resources, and makes recommendations.
- Provides a full API to integrate external tools and financial systems for reporting.
- Tracks resource usage and manage cloud costs with a single, unified view.
- Provides rich operational and financial insights to help you make informed decisions.

In Azure Cost Management + Billing, you can:

- **Create a budget:** Create a budget for financial accountability.
  - You can account for the services you consume or subscribe to for a specific period (monthly, quarterly, annually) and a scope (subscriptions/resource groups). For example, you can create an Azure subscription budget for a monthly, quarterly, or annual period.
    - After you create a budget, it's shown in cost analysis. Viewing your budget against current spending is one of the first steps needed when analyzing your costs and spending.
  - Email notifications can be sent when budget thresholds are reached.
  - You can export costs management data to Azure Storage, for analysis.

    ![View budgets in Azure Cost Management + Billing](../../migrate/azure-best-practices/media/migrate-best-practices-costs/budget.png)
    *Budgets in Azure Cost Management + Billing.*

- **Do a cost analysis:** Get a cost analysis to explore and analyze your organizational costs, to help you understand how costs are accrued, and identify spending trends.
  - Cost analysis is available to EA users.
  - You can view cost analysis data for various scopes, including by department, account, subscription, or resource group.
  - You can get a cost analysis that shows total costs for the current month, and accumulated daily costs.

    ![Azure Cost Management + Billing analysis](../../migrate/azure-best-practices/media/migrate-best-practices-costs/analysis.png)
    *Figure: Azure Cost Management + Billing analysis.*

- **Get recommendations:** Get Advisor recommendations that show you how you can optimize and improve efficiency.

**Learn more:**

- Read the [Azure Cost Management + Billing overview](/azure/cost-management-billing/cloudyn/overview).
- Learn how to [optimize your cloud investment with Azure Cost Management + Billing](/azure/cost-management-billing/costs/cost-mgt-best-practices).
- Learn how to use [Azure Cost Management + Billing reports](/azure/cost-management-billing/cloudyn/use-reports).
- Review a tutorial on [optimizing costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations).
- Review the [Azure Consumption APIs](/rest/api/consumption/budgets).

## Best practice: Implement resource group budgets

Often, resource groups are used to represent cost boundaries. Together with this usage pattern, the Azure team continues to develop new and enhanced ways to track and analyze resource spending at different levels, including the ability to create budgets at the resource group and resources.

- A resource group budget helps you track the costs associated with a resource group.
- You can trigger alerts and run a wide variety of playbooks as the budget is reached or exceeded.

**Learn more:**

- Learn how to [manage costs with Azure budgets](/azure/cost-management-billing/manage/cost-management-budget-scenario).
- Review a tutorial on [creating and managing an Azure budget](/azure/cost-management-billing/costs/tutorial-acm-create-budgets).

## Best practice: Review Azure Advisor recommendations

Azure Advisor cost recommendations identify opportunities to reduce costs. When budgets appear high or utilization appears low, use this report to find immediate opportunities to quickly align costs.

**Learn more:**

- [Review Azure Advisor cost recommendations](/azure/advisor/advisor-cost-recommendations) to take immediate actions.

## Best practice: Optimize Azure Monitor retention

As you move resources into Azure and enable diagnostic logging for them, you generate a lot of log data. Typically this log data is sent to a storage account that's mapped to a Log Analytics workspace.

- The longer the log data retention period, the more data you'll have.
- Not all log data is equal, and some resources will generate more log data than others.
- Due to regulations and compliance, it's likely that you'll need to retain log data for some resources longer than others.
- Balance between optimizing your log storage costs and keeping the log data you need.
- We recommend evaluating and setting up the logging immediately after completing a migration, so that you aren't spending money retaining logs of no importance.

**Learn more:**

- Learn about [monitoring usage and estimated costs](/azure/azure-monitor/usage-estimated-costs).

## Best practice: Optimize storage

If you followed best practices for selecting storage before adoption, you're probably reaping some benefits. You can probably optimize some additional storage costs. Over time, blobs and files become stale. Data might not be used anymore, but regulatory requirements might mean that you need to keep it for a certain period. As such, you might not need to store it on the high-performance storage that you used for the original adoption.

Identifying and moving stale data to cheaper storage areas can have a huge impact on your monthly storage budget and cost savings. Azure provides many ways to help you identify and then store this stale data.

- Take advantage of access tiers for general-purpose v2 storage by moving less important data from hot to cool and archived tiers.
- Use StorSimple to help move stale data based on customized policies.

**Learn more:**

- Learn more about [access tiers](/azure/storage/blobs/storage-blob-storage-tiers).
- Read the [StorSimple overview](/azure/azure-monitor/overview).
- Review [StorSimple pricing](https://azure.microsoft.com/pricing/details/storsimple/).

## Best practice: Automate VM optimization

The ultimate goal of running a VM in the cloud is to maximize the CPU, memory, and disk that it uses. If you discover VMs that aren't optimized, or have frequent periods when VMs aren't used, it makes sense to either shut them down, or downscale them using virtual machine scale sets.

You can optimize a VM with Azure Automation, virtual machine scale sets, auto-shutdown, and scripted or third-party solutions.

**Learn more:**

- Learn about [vertical autoscaling](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-vertical-scale-reprovision).
- Review [Azure DevTest Labs: Schedule VM auto-start](https://azure.microsoft.com/updates/azure-devtest-labs-schedule-vm-auto-start/).
- Learn how to [start or stop VMs off hours in Azure Automation](/azure/automation/automation-solution-vm-management).
- Get more information about [Azure Advisor](/azure/advisor/advisor-overview), and the [Azure Resource Optimization (ARO) toolkit](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/azure-resource-optimization-toolkit).

## Best practice: Use Logic Apps and runbooks with Budgets API

Azure provides a REST API that can access your tenant billing information.

- You can use the Budgets API to integrate external systems and workflows that are triggered by metrics that you build from the API data.
- You can pull usage and resource data into your preferred data analysis tools.
- The Azure Resource Usage API and the Azure Resource RateCard API can help you accurately predict and manage your costs.
- The APIs are implemented as a resource provider and are included in the APIs exposed by Azure Resource Manager.
- The Budgets API can be integrated with Azure Logic Apps and Azure Automation runbooks.

**Learn more:**

- Learn more about the [Budgets API](/rest/api/consumption/budgets).
- [Get insights](/azure/cost-management-billing/manage/consumption-api-overview#usage-details-api) into Azure usage with the Azure Billing APIs.

## Next steps

With an understanding of best practices, examine the [Cost Management toolchain](./toolchain.md) to identify Azure tools and features to help you execute these best practices.

> [!div class="nextstepaction"]
> [Cost Management toolchain for Azure](./toolchain.md)
