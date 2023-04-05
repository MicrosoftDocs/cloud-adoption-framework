---
title: Sustainability alignment in cloud management
description: Use the Cloud Adoption Framework for Azure to learn how to better manage your cloud operations and take sustainability and cloud efficiency into consideration.
author: Zimmergren
ms.author: tozimmergren
ms.date: 04/05/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: UpdateFrequency2
---

# Sustainability alignment in cloud management

Introducing sustainability in your cloud management and operations help drive carbon awareness in your teams and ultimately work toward achieving your goals set up for your [sustainability outcomes](../../strategy/business-outcomes/sustainability.md).

## Monitoring carbon emissions

Utilize monitoring capabilities to understand better how your organization uses resources and help identify areas of improvement.

In the Azure Well-Architected Framework, we describe measuring and tracking carbon impact using the Emissions Impact Dashboard, defining emissions targets, identifying the metrics and setting improvement goals, using cost optimization as a proxy for carbon, and defining policies. To learn more, see [operational procedure considerations for sustainable workloads on Azure](/azure/architecture/framework/sustainability/sustainability-operational-procedures#measure-and-track-carbon-impact).

### Cost as a proxy for sustainability

While sustainability isn't usually the primary purpose of [reducing service costs](/azure/advisor/advisor-cost-recommendations) with tools like Azure Advisor, these tools can often be aligned with carbon savings. Consider [cost as a proxy for sustainability](/azure/architecture/framework/sustainability/sustainability-design-methodology#use-a-proxy-solution-to-measure-emissions), and see how an optimized workload becomes leaner and ultimately reduces the carbon footprint.

### Find opportunities to schedule workloads

Part of your continuous operations and management of the cloud estate should be to evaluate what workloads you can schedule. For example, [running batch workloads during low-carbon periods](/azure/architecture/framework/sustainability/sustainability-application-platform#run-batch-workloads-during-low-carbon-intensity-periods).

### Monitor for services to retire

Understanding what services you're actively using and monitoring for unused resources can help you iteratively increase your cloud efficiency, lowering your carbon footprint.

Continuously managing your cloud estate is essential, including understanding what portions of your Azure resources aren't being used. An easy way to operationalize this is by [using PowerShell to identify unassociated resources in Azure](https://devblogs.microsoft.com/scripting/use-powershell-to-identify-unassociated-azure-resources/).

### Remove unused data

Improve the sustainability of your IT operations by moving data to tape or a long-term archive. This offers insights into the "invisible sinks" within an organization. We can then also shift to quality from quantity.

To dive deeper, see [Learn How Moving Data to Tape Can Lead to Significant Energy Savings and Reduction in CO2 Emissions](https://datastorage-na.fujifilm.com/sustainability/idc-whitepaper-reduce-data-usage/).

## Reporting

When reporting on sustainability and cloud management, it's essential to consider internal and external stakeholders. Internally, you can share reports with relevant teams and management to raise awareness and promote accountability. Externally, customers, investors, or other stakeholders might request reports to evaluate the organization's sustainability and environmental impact.

By tracking and reporting on key metrics, organizations can promote transparency, accountability, and continuous sustainability and environmental impact improvement.

### Carbon emissions reporting by resource group or tagged resources

The [Emissions Impact Dashboard](https://www.microsoft.com/sustainability/emissions-impact-dashboard?activetab=pivot:mostpopulartab) in Azure is a powerful tool that enables customers to track and report on carbon emissions.

One key benefit of the Emissions Impact Dashboard is its ability to help customers create detailed reports on carbon emissions. By tagging resources with relevant metadata, such as business units or project names, customers can generate customized reports that provide a granular view of emissions across different areas of their organization. This level of detail can benefit large enterprises with complex cloud environments, where it might be challenging to track emissions without a centralized reporting tool.

## Demand shaping

Demand shaping is a technique to optimize resource utilization by aligning demand with available resources. From a sustainability perspective, demand shaping can effectively reduce carbon emissions by ensuring that resources are used efficiently and effectively.

In a cloud environment, demand shaping typically involves identifying periods of low demand and [scheduling resource-intensive workloads during those times](/azure/architecture/framework/sustainability/sustainability-application-platform#process-when-the-carbon-intensity-is-low). By doing so, organizations can take advantage of excess capacity and reduce the need to deploy more resources, which can help reduce energy consumption and carbon emissions.

From a management perspective, demand shaping requires careful planning and coordination. It's essential to have a clear understanding of resource utilization patterns and workload requirements and the ability to automate resource allocation and scheduling.

Learn more:

- See [Demand Shaping](https://learn.greensoftware.foundation/carbon-awareness#demand-shaping) in the Principles of Green Software Engineering.
