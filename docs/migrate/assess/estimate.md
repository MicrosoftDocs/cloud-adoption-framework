---
title: Update and refine initial cloud estimates
description: Understand the factors that can affect decisions and execution activities, and various options for estimating cloud costs.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/04/2024
ms.topic: conceptual
---

# Update and refine initial cloud estimates

During migration, there are several factors that can affect decisions and execution activities. This article discusses the options for estimating cloud costs, and to understand what options are best for different situations.

## Digital estate size

Prior to selecting your workloads for migration, you completed digital estate planning to understand what you wanted to move and to put together some initial cost understanding. While there are various tools and best practices, cost estimation is an ongoing process. Migrations that involve fewer than 250 Virtual Machines (VM), VM Role specific, can be estimated much more easily than a migration involving 10,000+ VMs (virtual machines). 

As a result, it's highly recommended that you select a smaller workload as your first migration waves. The digital estate size gives your team a chance to learn how to estimate the costs of a simple migration effort before trying to estimate larger and more complicated workload migrations.

Workload migrations can still involve a widely varying number of supporting assets. If your migration involves under 1,000 VMs, a tool like [Azure Migrate](/azure/migrate/migrate-services-overview) is likely sufficient to gather data on the inventory and forecast costs. More cost-estimate tooling options are described in the article on [digital estate cost calculations](/azure/cloud-adoption-framework/digital-estate/calculate).

For 1,000+ unit digital estates, it's still possible to break down an estimate into four or five actionable iterations, making the estimation process manageable. For larger estates, or when a higher degree of forecast accuracy is required, a more comprehensive approach might be required. For more information, see [Digital estate](/azure/cloud-adoption-framework/digital-estate/).

## Updating your initial cloud estimate

As you complete your architecture, you should revisit your cloud estimate to make sure that you're still within the planned budget. As you add supporting services like load balancers or backups, the cost can change. While tools like [Azure Migrate business cases](/azure/migrate/concepts-business-case-calculation) can be used to perform detailed cost management exercises, you should periodically revisit these as you adjust your architecture.

## Accounting models

If you're familiar with traditional Information Technology (IT) procurement processes, estimation in the cloud might seem foreign. When adopting cloud technologies, acquisition shifts from a rigid, structured capital expense model to a fluid operating expense model.

In the traditional capital expense model, the IT team would attempt to combine buying power for multiple workloads across various programs, which centralizes a pool of shared IT assets that could support each of those solutions. In the operating expenses cloud model, costs can be directly attributed to the support needs of individual workloads, teams, or business units. This approach allows for a more direct attribution of costs to the supported internal customer.

When estimating costs, it's important to first understand how much of this new accounting capability will be used by the IT team.

If you want to replicate the legacy capital expense approach to accounting, use the outputs of either approach suggested in the [Digital estate size](#digital-estate-size) section to get an annual cost basis. Then, multiply that annual cost by the company's typical hardware refresh cycle. The hardware refresh cycle is the rate at which a company replaces aging hardware, typically measured in years. The annual run rate multiplied by hardware refresh cycle creates a cost structure similar to a capital expense investment pattern.

## Next steps

> [!div class="nextstepaction"]
> [Deploy workloads](../deploy/index.md)
