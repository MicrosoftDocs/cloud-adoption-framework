---
title: Release, promote and optimize workloads
description: Learn how to review the solution for possible areas of optimization, including the design of the solution, right-sizing the services, and analyzing costs.
author: Zimmergren
ms.author: tozimmergren
ms.date: 07/07/2023
ms.topic: conceptual
ms.subservice: migrate
ms.custom: think-tank, fasttrack-new, AQC, UpdateFrequency2
---

# Release, promote and optimize workloads (test, optimize, and handoff)

Now that you have migrated your services to Azure, the next phase includes reviewing the solution for possible areas of optimization. This effort could include reviewing the design of the solution, right-sizing the services, and analyzing costs.

This phase is also an opportunity to optimize your environment and perform possible transformations of the environment. For example, you may have performed a "rehost" migration, and now that your services are running on Azure you can revisit the solutions configuration or consumed services, and possibly perform some "refactoring" to modernize and increase the functionality of your solution.

The remainder of this article focuses on tools for optimizing the migrated workload. When the proper balance between performance and cost has been reached, a workload is ready to be promoted to production. For guidance on promotion options, see the process improvement articles on [optimize and promote](../migration-considerations/optimize/index.md).

## Right-size assets

All Azure services that provide a consumption-based cost model can be resized through the Azure portal, CLI, or PowerShell. The first step in correctly sizing a service is to review its usage metrics. The Azure Monitor service provides access to these metrics. You may need to configure the collection of the metrics for the service you're analyzing, and allow an appropriate time to collect meaningful data based on your workload patterns.

1. Go to **Monitor**.
1. Select **Metrics** and configure the chart to show the metrics for the service to analyze.

The following are some common services that you can resize.

### Resize a virtual machine

Azure Migrate performs a right-sizing analysis as part of its pre-migration assessment phase, and virtual machines migrated with this tool will likely already be sized based on your pre-migration requirements.

However, for virtual machines created or migrated using other methods, or in cases where your post-migration virtual machine requirements need adjustment, you might want to further refine your virtual machine sizing.

1. Go to **Virtual machines**.
1. Select the desired virtual machine from the list.
1. Select **Size** and the desired new size from the list. You might need to adjust the filters to find the size you need.
1. Select **Resize**.

Resizing production virtual machines can cause service disruptions. Try to apply the correct sizing for your VMs before you promote them to production.

::: zone target="docs"

See the below list of links for more information on resizing VMs:

- [Manage reservations for Azure resources](/azure/cost-management-billing/reservations/manage-reserved-vm-instance)
- [Resize a VM](/azure/virtual-machines/resize-vm)

Partners can use the Partner Center to review the Azure usage.

- [Azure VM sizing for maximum reservation usage](/partner-center/azure-usage)

::: zone-end

### Resize or reconfigure a storage account

1. Go to **Storage accounts**.
1. Select the desired storage account.
1. Select **Configure** and adjust the properties of the storage account to match your requirements.
1. Select **Save**.

::: zone target="docs"

You can also upgrade a General purpose v1 storage account to v2 or can change the access tier of storage account. See [Upgrade a Storage Account](/azure/storage/common/storage-account-upgrade) and [Move a Storage Account](/azure/storage/common/storage-account-move).

::: zone-end

### Resize a SQL database

1. Go to either **SQL databases**, or **SQL servers**, then select the server.
1. Select the desired database.
1. Select **Configure** and the desired new service tier size.
1. Select **Apply**.

### Resize an App Service

1. Go to **App Services**.
1. Select your App Service instance.
1. Choose **Scale up (App Service plan)** in the left navigation.
1. Select on of the pricing tiers and choose **Select**.

## Cost management

It's important to perform ongoing cost analysis and review. This effort provides you with an opportunity to resize resources as needed to balance cost and workload.

### Azure Advisor

Azure Cost Management + Billing works with Azure Advisor to provide cost optimization recommendations. Azure Advisor helps you optimize and improve efficiency by identifying idle and underutilized resources.

1. Select **Cost Management + Billing**.
1. Select **Advisor recommendations** and the **Costs** tab.
1. Use the **Impact** and **Potential yearly savings** to review the potential benefits.

You can also use **Advisor** and select the **Costs** tab to identify recommendations for potential cost reductions.

### Azure Migrate

Additionally, the [Build business case](/azure/migrate/how-to-build-a-business-case) feature of Azure Migrate can help you quickly shape and justify a use case for migration, including cost-specific angles like:

- A view of on-premises vs. Azure total cost of ownership (TCO)
- Understand long-term cost savings when moving from a capital expenditure model (CAPEX) to an Operating expenditure model (OPEX) by paying only for what you use.
- Strengthen your cost planning process and add data insights-driven calculations.

> [!TIP]
> For services that don't require continuous availability, implementing a solution to start, stop, or pause the service as needed can help manage the cost (for example, Azure Virtual Machines or Azure SQL Data Warehouse).
>

::: zone target="docs"

- [Tutorial: optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations)
- [Prevent unexpected charges with Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview)
- [Explore and analyze costs with cost analysis](/azure/cost-management-billing/costs/quick-acm-cost-analysis)
- [Build a business case - Azure Migrate](/azure/migrate/how-to-build-a-business-case)

::: zone-end
