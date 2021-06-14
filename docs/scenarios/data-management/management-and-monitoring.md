---
title: "Azure Enterprise Scale Analytics management and monitoring for 'data management and analytics'"
description: Describe how this enterprise-scale scenario can improve management and monitoring of 'data management and analytics'
author: christophermschmidt
ms.author: chrschm
ms.date: 06/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring for 'data management and analytics' Enterprise-Scale scenario

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [enterprise-scale design area for management and monitoring](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring). Following the guidance in this article will explore how to build on those principles to operationally maintain an Azure data analytics estate. 

## Design Considerations: 
Here are some design considerations for data analytics on Azure monitoring and management:

* Consider a centralized Azure Log Analytics workspace with Azure Monitor and Application Insights for platform and application layer monitoring

* Consider if individual data landing zones can query the centralized Log Analytics workspace with appropriate permissions or if each landing zone will also need its own Log Analytics workspace

* Use the [documentation](/azure/architecture/databricks-monitoring/) to configure Azure Databricks to send telemetry to Log Analytics. 

* Azure Monitor Log Analytics provides some [sample queries](/azure/azure-monitor/logs/queries) that can be used without modification or can be built upon as a starting point for your own queries. 

## Design Recommendations:

When thinking about enterprise scale analytics, here are some design recommendations.

* Implement threat protection with [Azure Sentinel](/azure/sentinel/overview).

* Monitor all services deployed as part of the data landing zone to a log analytics workspace. 

* Use [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) to recover virtual machines that support mission-critical workloads.
