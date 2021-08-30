---
title: Management and monitoring for data management and analytics in Azure
description: Learn how this enterprise-scale scenario can improve management and monitoring of data management and analytics in Azure.
author: christophermschmidt
ms.author: chrschm
ms.date: 07/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring for data management and analytics

This article provides guidance about maintaining an Azure data analytics estate. It builds on considerations and recommendations of the Azure landing zones. For more information, see [Management and monitoring](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring).

## Design considerations

Here are some design considerations for data analytics on Azure monitoring and management:

- Consider a centralized Azure Log Analytics workspace with Azure Monitor and Application Insights for platform and application layer monitoring. For more information, see [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace).
- Consider whether individual data landing zones can query the centralized Log Analytics workspace with appropriate permissions. Each landing zone might also need its own Log Analytics workspace.
- Configure Azure Databricks to send monitoring information to Log Analytics. For more information, see [Monitoring Azure Databricks](/azure/architecture/databricks-monitoring/).
- Review sample queries. You can use some without modification or build on them for your own queries. For more information, see [Using queries in Azure Monitor Log Analytics](/azure/azure-monitor/logs/queries).

## Design recommendations

When thinking about enterprise-scale analytics, consider these design recommendations:

- Implement threat protection. For more information, see [Azure Sentinel](/azure/sentinel/overview).
- Monitor all services deployed in the data landing zone to a Log Analytics workspace.
- Use Azure Site Recovery to recover virtual machines that support mission-critical workloads. For more information, see [About Site Recovery](/azure/site-recovery/site-recovery-overview).
- In a data landing zone, all the monitoring should be sent to the enterprise-scale management subscription for analysis.

## Next steps

- [Management and monitoring](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring)
- [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace)
- [Management and monitoring for data management and analytics](./eslz-business-continuity-and-disaster-recovery.md)
