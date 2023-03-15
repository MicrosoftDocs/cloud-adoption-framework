---
title: Sustainability alignment in cloud management
description: Use the Cloud Adoption Framework for Azure to learn how to better manage your cloud operations and take sustainability and cloud efficiency into consideration.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/13/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: UpdateFrequency2
---

# Sustainability alignment in cloud management

Introducing sustainability in your cloud management and operations help drive carbon awareness in your teams, and ultimately work toward achieving your goals set up for your [sustainability outcomes](../../strategy/business-outcomes/sustainability.md).

## Monitoring carbon emissions

Utilize monitoring capabilities to better understand how your organization is using resources, and help identify areas of improvements.

In the Azure Well-Architected Framework, we describe measuring and tracking carbon impact by using the Emissions Impact Dashboard, defining emissions targets, identifying the metrics and set improvement goals, using cost optimization as a proxy for carbon, and defining policies. To learn more, see [operational procedure considerations for sustainable workloads on Azure](/azure/architecture/framework/sustainability/sustainability-operational-procedures#measure-and-track-carbon-impact).

### Cost as a proxy for sustainability

While sustainability isn't usually the main purpose of [reducing service costs](/azure/advisor/advisor-cost-recommendations) with tools like Azure Advisor, these tools can often be aligned with carbon savings. Think about [cost as a proxy for sustainability](/azure/architecture/framework/sustainability/sustainability-design-methodology#use-a-proxy-solution-to-measure-emissions), and see how an optimized workload becomes more lean and ultimately reduces the carbon footprint.

### Find opportunities to schedule workloads

Part of your continuous operations and management of the cloud estate should be to evaluate what workloads you can schedule. For example, [running batch workloads during low-carbon periods](/azure/architecture/framework/sustainability/sustainability-application-platform#run-batch-workloads-during-low-carbon-intensity-periods).

### Monitor for services to retire

Understanding what services you're actively using and monitoring for unused resources can help you iteratively increase your cloud efficiency, and therefore lowering your carbon footprint.

Continuous management of your cloud estate is important, including understanding what portions of your Azure resources that aren't being used. An easy way to operationalize this is by [using PowerShell to identify unassociated resources in Azure](https://devblogs.microsoft.com/scripting/use-powershell-to-identify-unassociated-azure-resources/).

### Remove unused data

Improve the sustainability of your IT operations by moving data to tape or long-term archive. This offers insights into the "invisible sinks" within an organization. We can then also shift to quality from quantity.

To dive deeper, see [Learn How Moving Data to Tape Can Lead to Significant Energy Savings and Reduction in CO2 Emissions
](https://datastorage-na.fujifilm.com/sustainability/idc-whitepaper-reduce-data-usage/).

## Reporting

> TBD.

### Report emissions footprint savings

Based on emission reporting or WAF activities, there are recommended actions to reduce emission, for example turning off under-utilized VM or migrating workloads from VM-based to PaaS. Ideally, customer can punch in different "milestones" to measure emission, for example milestone before migration of workload X and milestone after migration. In my opinion, this will be more relevant compared to periodic reporting (time-based instead of milestone-based) for customer to see the impact.

### Carbon emissions reporting by resource group or tagged resources

Using the Emissions Impact Dashboard (EID), customers can report on carbon emissions per resource groups or service using tags. Organizing subscriptions and resources in a way that aligns with their cloud governance needs can be a good way to report on emissions for different business units.

> TBD.

## Demand shaping

> TBD.

Integrate Demand Shaping into applications or development tools where possible.

Detail what types of actions show up on the EID and which actions are still good, but won't show up on the dashboard.

The emissions impact dashboard uses aggregates to approximate carbon footprint. This means that certain sustainable actions such as temporal shifting and demand shaping will not change the reported values.

When designing for the end user, consider giving users visibility and control over their energy usage.

[Demand Shaping](https://principles.green/principles/demand-shaping/#heading-eco-modes)

Supply of carbon - when the carbon cost of running your application is higher, shape the demand to match the supply of carbo. You can achieve this automatically on data, or you can schedule it based on known low-carbon periods, or give the user a choice.
